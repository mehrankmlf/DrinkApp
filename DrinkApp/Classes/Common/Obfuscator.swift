//
//  Obfuscator.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

enum ObfuscatedConstants {
    static let obfuscatedDomain: [UInt8] = [41, 4, 4, 52, 22, 86, 74, 72, 22, 3, 18, 96, 39, 39, 7, 9, 10, 0, 31, 53, 17, 25, 40, 1, 14, 75, 4, 14, 25, 74, 47, 35, 38, 77, 0, 22, 12, 26]
}

/// Protocol approach replacement for Singelton
protocol ObfuscatorInjector {
    var obfuscator : Obfuscator { get }
}

extension ObfuscatorInjector {
    var obfuscator : Obfuscator {
        return sharedObfuscator
    }
}

fileprivate let sharedObfuscator : Obfuscator = Obfuscator()

protocol ObfuscatorProtocol {
    var salt : String { get }
    func bytesByObfuscatingString(string: String) -> [UInt8]
    func reveal(key: [UInt8]) -> String
    init(with salt: String)
}

struct Obfuscator : ObfuscatorProtocol {
    
    // MARK: - Variables
    
    /// The salt used to obfuscate and reveal the string.
    private(set) var salt: String
    
    // MARK: - Initialization
    
    init() {
        self.salt = "\(String(describing: AppDelegate.self))\(String(describing: NSObject.self))"
    }
    
    init(with salt: String) {
        self.salt = salt
    }
    
    // MARK: - Instance Methods
    
    /**
     This method obfuscates the string passed in using the salt
     that was used when the Obfuscator was initialized.
     
     - parameter string: the string to obfuscate
     
     - returns: the obfuscated string in a byte array
     */
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        #if DEVELOPMENT
        print("Salt used: \(self.salt)\n")
        print("Swift Code:\n************")
        print("// Original \"\(string)\"")
        print("let key: [UInt8] = \(encrypted)\n")
        #endif
        
        return encrypted
    }
    
    /**
     This method reveals the original string from the obfuscated
     byte array passed in. The salt must be the same as the one
     used to encrypt it in the first place.
     
     - parameter key: the byte array to reveal
     
     - returns: the original string
     */
    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
