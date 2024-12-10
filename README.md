# react-native-crypto-storage

Android's EncryptedSharedPreferences and iOS' Keychain

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


