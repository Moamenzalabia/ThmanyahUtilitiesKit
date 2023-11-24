//
//  StorageKeychainManager.swift
//  
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

public class StorageKeychainManager: NSObject, StorageKeychainProtocol {
    
    // MARK: - Variables
    public static let shared = StorageKeychainManager()
    
    // MARK: - Init
    override init() {}
    
    // MARK: - Save Functions
    public func save(value: StorageKeychainType, forKey key: String, completion: StorageKeychainCompletionHandler) {
        let query = [kSecClass as String: kSecClassGenericPassword as String, kSecAttrAccount as String: key, kSecValueData as String: value] as [String: Any]
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            completion?(true, nil)
        } else {
            completion?(false, status)
        }
    }
    
    // MARK: - Get Functions
    public func get(valueForKey key: String) -> StorageKeychainType? {
        let query = [kSecClass as String: kSecClassGenericPassword, kSecAttrAccount as String: key, kSecReturnData as String: kCFBooleanTrue as Any, kSecMatchLimit as String: kSecMatchLimitOne] as [String: Any]
        
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
    
    // MARK: - Delete Functions
    public func delete(valueForKey key: String, completion: StorageKeychainCompletionHandler) {
        guard let value = get(valueForKey: key) else {
            completion?(true, nil)
            return
        }
        
        let query = [kSecClass as String: kSecClassGenericPassword as String, kSecAttrAccount as String: key, kSecValueData as String: value] as [String: Any]
        let status = SecItemDelete(query as CFDictionary)
        if status == noErr {
            completion?(true, nil)
        } else {
            completion?(false, status)
        }
    }
    
    public func wipeStorage(completion _: StorageKeychainCompletionHandler) {
        let secItemClasses = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}
