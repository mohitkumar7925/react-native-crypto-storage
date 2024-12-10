package com.cryptostorage

import com.facebook.react.module.annotations.ReactModule
import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKey
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.WritableNativeArray

@ReactModule(name = ReactNativeCryptoStorageModule.NAME)
class ReactNativeCryptoStorageModule(reactContext: ReactApplicationContext) :
  NativeReactNativeCryptoStorageSpec(reactContext) {


  private var storage: SharedPreferences? = null

  init {
    try {
      val key = MasterKey.Builder(reactContext)
        .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
        .build()
      this.storage = EncryptedSharedPreferences.create(
        reactContext,
        STORAGE_FILENAME,
        key,
        EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
        EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
      )
    } catch (error: Exception) {
      Log.e(NAME, "Failed to create encrypted storage! Falling back to standard SharedPreferences", error)
      this.storage = reactContext.getSharedPreferences(STORAGE_FILENAME, Context.MODE_PRIVATE)
    }
  }
  override fun getName(): String = NAME
  override fun setItem(key: String?, value: String?, promise: Promise) {
    val prefs = storage ?: run {
      promise.reject("STORAGE_INITIALIZATION_ERROR", "Failed to initialize storage.")
      return
    }

    val editor = prefs.edit()
    editor.putString(key, value)

    val status = editor.commit()
    if (status) {
      promise.resolve(value)
    } else {
      promise.reject("STORAGE_WRITE_ERROR", "An error occurred while saving the item.")
    }
  }

  override fun getItem(key: String?, promise: Promise) {
    val prefs = storage ?: run {
      promise.reject("STORAGE_INITIALIZATION_ERROR", "Failed to initialize storage.")
      return
    }

    val value = prefs.getString(key, null)
    promise.resolve(value)
    
  }

  override fun clearAll(promise: Promise) {
    val prefs = storage ?: run {
      promise.reject("STORAGE_INITIALIZATION_ERROR", "Failed to initialize storage.")
      return
    }

    val editor = prefs.edit()
    editor.clear()
    val status = editor.commit()
    if (status) {
      promise.resolve(null)
    } else {
      promise.reject("STORAGE_CLEAR_ERROR", "An error occurred while clearing the storage.")
    }
  }

  override fun removeItem(key: String?, promise: Promise) {
    val prefs = storage ?: run {
      promise.reject("STORAGE_INITIALIZATION_ERROR", "Failed to initialize storage.")
      return
    }

    val editor = prefs.edit()
    editor.remove(key)
    val status = editor.commit()
    if (status) {
      promise.resolve(key)
    } else {
      promise.reject("STORAGE_REMOVE_ERROR", "An error occurred while removing the item.")
    }
  }

  companion object {
    const val NAME = "ReactNativeCryptoStorage"
    private const val STORAGE_FILENAME = "RN_SECURE_STORAGE_SHARED_PREF"
  }


}
