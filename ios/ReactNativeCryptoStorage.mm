#import "ReactNativeCryptoStorage.h"

@interface ReactNativeCryptoStorage()
@end

@implementation ReactNativeCryptoStorage

RCT_EXPORT_MODULE(NativeReactNativeCryptoStorageSpecJSI)

// initialize
- (id) init {
  if (self = [super init]) {
    
  }
  return self;
}

- (NSString *)getVersion {

  return @"Value from Native world";
}

- (void)setItem:(NSString *)key value:(NSString *)value resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject{
  
  NSData* data = [value dataUsingEncoding:NSUTF8StringEncoding];
  
  if(data == nil){
    resolve(@1);
    return;
  }
  
  NSDictionary* query = @{
    (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
    (__bridge id)kSecAttrAccount : key,
    (__bridge id)kSecValueData : data
  };
  
  SecItemDelete((__bridge CFDictionaryRef)query);
  
  OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, nil);
  
  if(status == noErr){
    resolve(@1);
    return ;
  }
  else{
    NSError* error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:status userInfo:nil];
    throwError(@"Error on saving data", error, reject);
    return;
  }
}

-(void)getItem:(NSString *)key resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  
  NSDictionary* query = @{
    (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
    (__bridge id)kSecAttrAccount : key,
    (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue,
    (__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitOne
  };
  
  
  CFTypeRef dataRef = NULL;
  OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataRef);
  
  if(status == errSecSuccess){
    NSString* storedValue = [[NSString alloc] initWithData:(__bridge NSData*)dataRef encoding:NSUTF8StringEncoding];
    resolve(storedValue);
  } else if (status == errSecItemNotFound){
    resolve(nil);
  }
  else{
    NSError* error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:status userInfo:nil];
    throwError(@"Error on retriving data", error, reject);
    
  }
}

-(void)removeItem:(NSString *)key resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  NSDictionary* query = @{
    (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
    (__bridge id)kSecAttrAccount : key,
    (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue
  };
  
  OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
  
  if (status == noErr) {
    resolve(key);
  }
  else {
    NSError* error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:status userInfo:nil];
    throwError(@"Error while removing data", error, reject);
  }
}

-(void)clearAll:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject {
  NSArray *secItems = @[
          (__bridge id)kSecClassGenericPassword,
          (__bridge id)kSecClassInternetPassword,
          (__bridge id)kSecClassCertificate,
          (__bridge id)kSecClassKey,
          (__bridge id)kSecClassIdentity
      ];
      
      for (id secItem in secItems) {
          NSDictionary *spec = @{(__bridge id)kSecClass: secItem};
          SecItemDelete((__bridge CFDictionaryRef)spec);
      }
      
      resolve(nil);
}


void throwError(NSString *message, NSError *error, RCTPromiseRejectBlock rejecter)
{
  NSString* errorCode = [NSString stringWithFormat:@"%ld", error.code];
  NSString* errorMessage = [NSString stringWithFormat:@"EncryptedStorageError: %@", message];
  
  rejecter(errorCode, errorMessage, error);
}


// Method to get a TurboModule instance
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeReactNativeCryptoStorageSpecJSI>(params);
}



@end
