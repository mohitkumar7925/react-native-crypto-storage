# react-native-crypto-storage

React Native Turbo Module built for encrypted storage using Android's EncryptedSharedPreferences and iOS' Keychain

## Feature 

- Android: EncryptedSharedPreferences
- iOS: KeyChain
- Turbo Native Module
- Encrypted secure storage


## Installation

```sh
npm install react-native-crypto-storage
```

## Linking

For iOS, run:

```bash
$ npx pod-install
```
## Usage

```js
import CryptoStorage from 'react-native-crypto-storage';
```

### Storing a value

```js
async function storeData() {
    try {
        await CryptoStorage.setItem(
            "user_data",
            JSON.stringify({
                name : "Mohit",
                age : 26,
                username : "mohitkumar7925",
            })
        );

    } catch (error) {
        // if there is an error 
    }
}
```
### Retrieving a value

```js
async function retrieveData() {
    try {   
        const user = await CryptoStorage.getItem("user_data");
        if (user) {
            
        }
    } catch (error) {
        // if there is an error 
    }
}
```

### Removing a value

```js
async function removeData() {
    try {
        await CryptoStorage.removeItem("user_data");
       
    } catch (error) {
        // if there is an error 
    }
}
```

### Clearing all previously saved values

```js
async function clearStorage() {
    try {
        await CryptoStorage.clear();
        
    } catch (error) {
        // if there is an error 
    }
}
```

## Important Note: `Keychain` persistence

iOS `Keychain` is not cleared when your app is uninstalled, this is the expected behaviour of `Keychain`. However, if you do want to achieve a different behaviour, you can use the below snippet to clear the `Keychain` on the first launch of your app.

```objc
// AppDelegate.m

/**
 Deletes all Keychain items accessible by this app if this is the first time the user launches the app
 */
static void ClearKeychainIfNecessary() {
    // Checks wether or not this is the first time the app is run
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HAS_RUN_BEFORE"] == NO) {
        // Set the appropriate value so we don't clear next time the app is launched
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HAS_RUN_BEFORE"];

        NSArray *secItemClasses = @[
            (__bridge id)kSecClassGenericPassword,
            (__bridge id)kSecClassInternetPassword,
            (__bridge id)kSecClassCertificate,
            (__bridge id)kSecClassKey,
            (__bridge id)kSecClassIdentity
        ];

        // Maps through all Keychain classes and deletes all items that match
        for (id secItemClass in secItemClasses) {
            NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
            SecItemDelete((__bridge CFDictionaryRef)spec);
        }
    }
}

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Add this line to call the above function
    ClearKeychainIfNecessary();

    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"APP_NAME" initialProperties:nil];

    rootView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;

    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

    return YES;
}

// ...

@end
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

### Connect with me

<p align="left">
<a href="https://linkedin.com/in/mohit-kumar-49337b1a0" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="mohit-kumar-49337b1a0" height="30" width="40" /></a>
<a href="https://twitter.com/MohitBisyan" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="MohitBisyan" height="30" width="40" /></a>
</p>

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)


