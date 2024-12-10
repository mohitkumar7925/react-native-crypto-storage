import { useState } from 'react';
import { Text, View, StyleSheet, Button } from 'react-native';
import CryptoStorage from 'react-native-crypto-storage';

export default function App() {
  const [userData, setUserData] = useState({ name: '', age: 0, username: '' });

  async function storeData() {
    try {
      await CryptoStorage.setItem(
        'user_data',
        JSON.stringify({
          name: 'Mohit',
          age: 26,
          username: 'mohitkumar7925',
        })
      );
    } catch (error) {
      // if there is an error
    }
  }

  async function retrieveData() {
    try {
      const user = await CryptoStorage.getItem('user_data');
      if (user) {
        console.log('user data: ' + user);
        setUserData(JSON.parse(user));
      } else {
        console.log('No user data found');
      }
    } catch (error) {
      // if there is an error
    }
  }

  return (
    <View style={styles.container}>
      <Button title="setData" onPress={() => storeData()} />
      <Text>user name: {userData?.name || ''}</Text>
      <Button title="getData" onPress={() => retrieveData()} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
