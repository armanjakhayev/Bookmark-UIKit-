import Foundation
import UIKit

class Storage {
    @AppDataStorage (key: "bookmark_models", defaultValue: [])
    static var bookmarkModels: [Bookmark]
    
    @AppDataStorage(key: "show_onboarding", defaultValue: true)
    static var showOnboarding: Bool
}

@propertyWrapper
struct AppDataStorage <T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
