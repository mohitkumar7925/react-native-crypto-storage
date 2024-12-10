import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  setItem(key: string, value: string): Promise<void>;
  getItem(key: string): Promise<string | null>;
  clearAll(): Promise<void>;
  removeItem(key: string): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'ReactNativeCryptoStorage'
);
