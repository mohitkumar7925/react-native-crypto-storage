import ReactNativeCryptoStorage from './NativeReactNativeCryptoStorage';

// export function multiply(a: number, b: number): number {
//   return ReactNativeCryptoStorage.multiply(a, b);
// }

export const { clearAll, getItem, removeItem, setItem } =
  ReactNativeCryptoStorage;
export default ReactNativeCryptoStorage;
