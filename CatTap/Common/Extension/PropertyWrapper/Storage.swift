import Foundation

@propertyWrapper
public struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    private let userDefaults = UserDefaults.standard
    
    public init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get { get() }
        set { set(newValue) }
    }
    
    private func get() -> T {
        if let data = userDefaults.data(forKey: key) {
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        } else {
            return defaultValue
        }
    }
    
    private func set(_ value: T) {
        do {
            let value = try JSONEncoder().encode(value)
            userDefaults.setValue(value, forKey: key)
        } catch {
            userDefaults.removeObject(forKey: key)
        }
    }
}
