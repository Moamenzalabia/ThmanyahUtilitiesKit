//
//  StorageKeychainInterface.swift
//
//  Created by Moamen on 24/11/2023.
//

import Foundation

public typealias StorageKeychainCompletionHandler = ((Bool, OSStatus?) -> Void)?
public typealias StorageKeychainType = Data

public protocol StorageKeychainProtocol {
    func save(value: StorageKeychainType, forKey key: String, completion: StorageKeychainCompletionHandler)
    func get(valueForKey key: String) -> StorageKeychainType?
    func delete(valueForKey key: String, completion: StorageKeychainCompletionHandler)
    func wipeStorage(completion _: StorageKeychainCompletionHandler)
}
