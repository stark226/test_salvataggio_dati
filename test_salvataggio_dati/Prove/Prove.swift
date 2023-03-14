//POD
//import BIP39 //https://github.com/bitmark-inc/bip39-swift //vecchia, rimossa❌

//pacakge manager:
//https://github.com/yenom/BitcoinKit

//Elenco
//https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki
//dove trovi:
//https://github.com/CikeQiu/CKMnemonic // ❌ si porta cryptoswift vecchio
//https://github.com/keefertaylor/MnemonicKit // ❌ si porta cryptoswift vecchio
//https://github.com/yuzushioh/WalletKit
//https://github.com/pengpengliu/BIP39
//https://github.com/matter-labs/web3swift/blob/develop/Sources/web3swift/KeystoreManager/BIP39.swift
//https://github.com/zcash-hackworks/MnemonicSwift
//https://github.com/ShenghaiWang/BIP39

//https://github.com/jedisct1/swift-sodium

import UIKit
//import CKMnemonic
//import MnemonicKit
import MnemonicSwift
import CryptoKit
//import CryptoSwift //not needed









//let chat = ["come stai", "bene"]


//struct ChatMessage: Identifiable {
//    let id = UUID().uuidString
//    let date = Date()
//    let text: String
//}
//
//struct Chat: Identifiable {
//    let id = UUID().uuidString
//    let messages = [
//        ChatMessage(text: "Come stai"),
//        ChatMessage(text: "Bene"),
//    ].sorted(by: {$0.date < $1.date})
//}



//----------------------------------------------------------------------------


// Mnemonic phrase
//        let phrase = "rally speed budget undo purpose orchard hero news crunch flush wine finger"
//
//        // Creating mnemonic. English wordlist by default
//        let mnemonic = try! Mnemonic(mnemonic: phrase.components(separatedBy: " "))
//
//        // 128 bit entropy
//        print("Entropy: ", mnemonic.entropy)
//


//----------------------------------------------------------------------------

//MARK: - CKMnemonic
//        do {
//            let language: CKMnemonicLanguageType = .english
//            let mnemonic = try CKMnemonic.generateMnemonic(strength: 128, language: language)
//            print(mnemonic)
//            let seed = try CKMnemonic.deterministicSeedString(from: mnemonic, passphrase: "Test", language: language)
//            print(seed)
//        } catch {
//            print(error)
//        }


//MARK: - CKMnemonic
//        let englishMnemonic = Mnemonic.generateMnemonic(strength: 64, language: .english)
//        let hexRepresentation: String = ""
//        let mnemonic = Mnemonic.mnemonicString(from: hexRepresentation)
//        print("Mnemonic: \(mnemonic)\nFrom hex string: \(hexRepresentation)")
//








//----------------------------------------------------------------------------





//sempre errore ❌ The operation couldn’t be completed. (CryptoKit.CryptoKitError error 1.)

//
//do {
//    // Data to encrypt
//    let data = Data("ciao".utf8)
//
//    // Generate mnemonic and seed
//    let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//    try Mnemonic.validate(mnemonic: mnemonicString)
//    let passphrase = "test"
//    let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
//
//    // Derive key from seed
//    guard let keyData = Data(base64Encoded: deterministicSeedString) else {
//        print("❌ problem")
//        return
//    }
//    let encryptionKey = SymmetricKey(data: keyData)
//
//    // Encrypt data using AES-GCM
//    let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
//    let encryptedData = sealedBox.combined
//
//    // Decrypt data using AES-GCM
//    let sealedBoxToOpen = try AES.GCM.SealedBox(combined: encryptedData)
//    let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: encryptionKey)
//
//    // Print results
//    print("Mnemonic: \(mnemonicString)")
//    print("Seed: \(deterministicSeedString)")
//    print("Encrypted data: \(encryptedData.base64EncodedString())")
//    print("Decrypted data: \(String(data: decryptedData, encoding: .utf8) ?? "nil")")
//} catch {
//    print("❌ \(error.localizedDescription)")
//}






//----------------------------------------------------------------------------


//
//
//do {
//    // Data to encrypt
//    let data = Data("ciao".utf8)
//
//    // Generate mnemonic and seed
//    let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//    print("Mnemonic: \(mnemonicString)")
//    try Mnemonic.validate(mnemonic: mnemonicString)
//    let passphrase = "test"
//    let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
//    print("Seed: \(deterministicSeedString)")
//
//
//
//    // Derive key from seed
//    guard let keyData = Data(base64Encoded: deterministicSeedString) else {
//        print("❌ problem")
//        return
//    }
//    let encryptionKey = SymmetricKey(data: keyData)
//
//    // Encrypt data using AES-GCM
//    let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
//    let encryptedData = sealedBox.combined
//    print("Encrypted data: \(encryptedData!.base64EncodedString())")
//
//    // Decrypt data using AES-GCM
//    let sealedBoxToOpen = try AES.GCM.SealedBox(combined: encryptedData!)
//    let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: encryptionKey)
//    print("Decrypted data: \(String(data: decryptedData, encoding: .utf8) ?? "nil")")
//
//    print("✅ all ok")
//} catch {
//    print("❌ \(error.localizedDescription)")
//}






//        do {
//
//            //data to encrypt
//            let data = Data("ciao".utf8)
//
//            let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//            print("mnemonic: \(mnemonicString)")
//
//            try Mnemonic.validate(mnemonic: mnemonicString)
//            //passphrase
//            let passphrase: String = "test"
//            //seed
//            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString,
//                                                                               passphrase: passphrase,
//                                                                               language: .english)
//            print("Deterministic Seed String: \(deterministicSeedString)")
//
//            //usare seed per symmetric encryption
//            //potrei usare un file zip
//
//
//            guard let keyData = Data(base64Encoded: deterministicSeedString) else {
//                print("❌ problema")
//                return
//            }
//            let symmetricKey = SymmetricKey(data: keyData)
//
//            //encrypt
////            let encryptedData = try ChaChaPoly.seal(data, using: symmetricKey).combined
//            let encryptedData = try AES.GCM.seal(data, using: symmetricKey).combined //errore
//
//            //decrypt
////            let sealedBox = try ChaChaPoly.SealedBox(combined: encryptedData)
////            let decryptedData = try ChaChaPoly.open(sealedBox, using: symmetricKey)
////            print(decryptedData)
//
//
//
//        } catch {
//            print("❌ \(error.localizedDescription)")
//        }


//----------------------------------------------------------------------------


//        do {
//            // Data to encrypt
//            let data = Data("ciao".utf8)
//
//            // Generate mnemonic and seed
//            let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//            print("Mnemonic: \(mnemonicString)")
//            try Mnemonic.validate(mnemonic: mnemonicString)
//            let passphrase = "test"
//            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
//            print("Seed: \(deterministicSeedString)")
//
//
//
//            // Derive key from seed
//            guard let keyData = Data(base64Encoded: deterministicSeedString) else {
//                print("❌ problem")
//                return
//            }
//            let encryptionKey = SymmetricKey(data: keyData)
//
//            // Encrypt data using AES-GCM
//            let sealedBox = try AES.GCM.seal(data, using: encryptionKey)
//            let encryptedData = sealedBox.combined
//            print("Encrypted data: \(encryptedData!.base64EncodedString())")
//
//            // Decrypt data using AES-GCM
//            let sealedBoxToOpen = try AES.GCM.SealedBox(combined: encryptedData!)
//            let decryptedData = try AES.GCM.open(sealedBoxToOpen, using: encryptionKey)
//            print("Decrypted data: \(String(data: decryptedData, encoding: .utf8) ?? "nil")")
//
//            print("✅ all ok")
//        } catch {
//            print("❌ \(error.localizedDescription)")
//        }



