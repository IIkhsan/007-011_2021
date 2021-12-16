import Foundation

class OnboardingDisplayService {
    
    // Public properties
    
    static let shared = OnboardingDisplayService()
    
    // Private properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Init properties
    
    private init() {
    }
    
    // MARK: - Public funcs
    
    public func isNewUser() -> Bool {
        return !userDefaults.bool(forKey: UserDefaultsKeys.keyForIsNewUser)
    }
    
    public func setIsNotNewUser() {
        userDefaults.set(true, forKey: UserDefaultsKeys.keyForIsNewUser)
    }
}
