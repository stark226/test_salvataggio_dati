////
////  ViewModel.swift
////  test_salvataggio_dati
////
////  Created by Resia Servizi Operativi on 09/03/23.
////
//
//import UIKit
//import MnemonicSwift
//import CryptoKit
//import SSZipArchive
//import MobileCoreServices
//
//class ViewModel {
//    
//    
//    static let shared = ViewModel()
//    private let encodingModel = EncodingModel.shared
//    
//    private init() {}
//    
//    ///creates seed via Bip39, encodes in 64 bits
//        func encrypt(mnemonicString: String, completion: @escaping (String) -> ()) {
//    
//            do {
//    
//                //BIP39 section
//    
//                //Generate mnemonic and seed
//                //let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//                //print("Mnemonic: \(mnemonicString)")
//                try Mnemonic.validate(mnemonic: mnemonicString)
//                let passphrase = "test"
//                let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
//                //print("Seed: \(deterministicSeedString)")
//    
//                //ENCODING
//                let key = encodingModel.keyFromPassword(deterministicSeedString)
//    
//                // Create a user that will be encrypted
//                let user = User(name: "J.Doe", password: "Another Secret")
//                let base64EncodedString = try encodingModel.encryptCodableObject(user, usingKey: key)
//                completion(base64EncodedString)
//                //            encrypted = base64EncodedString
//                print("✅")
//    
//            } catch {
//                print("❌ \(error.localizedDescription)")
//            }
//    
//    
//        }
//    
//    //versione nuova che cripta il file zip
////    func encrypt(mnemonicString: String, folderName: String, completion: @escaping (String) -> ()) {
////
////        do {
////            //Generazione seed via Bip39
////            try Mnemonic.validate(mnemonic: mnemonicString)
////            let passphrase = "test"
////            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
////
////            // Encoding
////            let key = encodingModel.keyFromPassword(deterministicSeedString)
////
////            //Recupero della cartella zippata
////            let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
////            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip")
////            let zippedData = try Data(contentsOf: zipFileURL)
////
////            // Crittografia della cartella zippata
////            let base64EncodedString = try encodingModel.encryptCodableObject(zippedData, usingKey: key)
////            completion(base64EncodedString)
////            print("✅")
////
////        } catch {
////            print("❌ \(error.localizedDescription)")
////        }
////    }
//    
//    //questa non sta ancora decriptando il file zip
//    func decrypt(encrypted: String, originalString: String) {
//        
//        do {
//            
//            //BIP39 section
//            
//            print("Mnemonic: \(originalString)")
//            try Mnemonic.validate(mnemonic: originalString)
//            let passphrase = "test"
//            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: originalString, passphrase: passphrase, language: .english)
//            print("Seed: \(deterministicSeedString)")
//            
//            //ENCODING
//            let key = encodingModel.keyFromPassword(deterministicSeedString)
//            
//            // Create a user that will be encrypted
//            //                    let user = User(name: "J.Doe", password: "Another Secret")
//            //                    let base64EncodedString = try encryptCodableObject(user, usingKey: key)
//            
//            let newObject = try encodingModel.decryptStringToCodableOject(User.self, from: encrypted, usingKey: key)
//            print(newObject.name)      // J.Doe
//            print(newObject.password)  // Another Secret
//            print("✅")
//            
//            
//        } catch {
//            print("❌❌ decrypting: \(error.localizedDescription)")
//        }
//    }
//    
//
//}
