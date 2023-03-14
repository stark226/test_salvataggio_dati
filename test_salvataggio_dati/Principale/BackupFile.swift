////
////  ViewController.swift
////  test_salvataggio_dati
////
////  Created by stefano cardia on 07/03/23.
////
//
//import UIKit
//import MnemonicSwift
//import CryptoKit
//import SSZipArchive
//import MobileCoreServices
////import CryptoSwift //not needed
//
//// A sample structure to encode
//struct User: Codable {
//    let name: String
//    let password: String
//}
//
//class ViewController: UIViewController {
//    
////    private var encrypted = ""
//    private let mnemonicString = "cattle swallow auction pistol orchard dilemma brain dynamic popular ready critic grief"
//    
//    //    private let viewModel = ViewModel.shared
//    let encodingModel = EncodingModel.shared
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //apre file e mostra cartella
//        //                askForPermission()
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //✅ creiamo un
//        let dummyUser = User(name: "stefano", password: "cardìa")
//        let fileName = "myJedi.json"
//        let folderName = "myNewFolder"
//        
//        //ZIP
//        //                saveZipEncryptUserJson(user: dummyUser, fileName: fileName, folderName: folderName)
//        //UNZIP
//        //                let userUnzipped = unzipAndReadUserJson(fileName: fileName, folderName: folderName)!
//        
//        
//        //        Cryttography
//        generateSeedAndEncode64(mnemonicString: mnemonicString, user: dummyUser) { [weak self] base64EncodedString, symmetricKey in
//            guard let self = self else {return}
//            self.saveZipEncryptUserJson(user: base64EncodedString, fileName: fileName, folderName: folderName, symmetricKey: symmetricKey)
//            
//            print()
////            self.retriveUser(encrypted: base64EncodedString, originalString: self.mnemonicString, fileName: fileName, folderName: folderName)
//            
//        }
//        
//        self.retriveUser(originalString: self.mnemonicString, fileName: fileName, folderName: folderName)
//
//        
//     
//        
//    }
//    
//    
//    //MARK: ENCRYPT
//    
//    //MARK: - Bip39 part
//    //------------------------------------------------------------------------------
//    
//    
//    ///Creates seed via Bip39, encodes in 64 bits
//    func generateSeedAndEncode64(mnemonicString: String, user: User, completion: @escaping (_ base64EncodedString: String, _ symmetricKey: SymmetricKey ) -> ()) {
//        
//        do {
//            
//            //BIP39 section
//            
//            //Generate mnemonic and seed
//            //let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
//            //print("Mnemonic: \(mnemonicString)")
//            try Mnemonic.validate(mnemonic: mnemonicString)
//            let passphrase = "test"
//            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: passphrase, language: .english)
//            //print("Seed encrypt:\n\(deterministicSeedString)")
//            
//            //ENCODING
//            let simmetricKey = encodingModel.keyFromPassword(deterministicSeedString)
//            
//            //encode the user
//            let base64EncodedString = try encodingModel.encryptCodableObject(user, usingKey: simmetricKey)
//            completion(base64EncodedString, simmetricKey)
//            print("generateSeedAndEncode64 - ✅ user encoded")
//            
//        } catch {
//            print("❌ \(error.localizedDescription)")
//        }
//        
//        
//    }
//    
//   
//    
//    ///L'obiettivo della funzione è di salvare il file JSON dell'utente nella cartella specificata, creare un file zip contenente la cartella, e infine criptare il file zip.
//    /// - creates folder
//    /// - encodes in json
//    /// - creates a zip file
//    /// - calls encryptZipFileWithAES for encoding via AES
//    func saveZipEncryptUserJson(user: String, fileName: String, folderName: String, symmetricKey: SymmetricKey) {
//        
//        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//        
//        do {
//            // Creare la cartella con il nome specifico
//            let folderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
//            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
//            
//            // Salvare il file JSON nella cartella
//            let fileURL = folderURL.appendingPathComponent(fileName)
//            print("saveZipEncryptUserJson\n fileURL save:\n\(fileURL)\n")
//            let encoder = JSONEncoder()
//            let jsonData = try encoder.encode(user)
//            let jsonString = String(data: jsonData, encoding: .utf8)!
//            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
//            
//            // Creare il file zip
//            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip") //myNewFolder.zip.encrypted
//            SSZipArchive.createZipFile(atPath: zipFileURL.path, withContentsOfDirectory: folderURL.path)
//            print("saveZipEncryptUserJson\n ✅ File Zip saved at:\n\(zipFileURL)\n")
//            
//            //Criptare file zip con AES
//            print("saveZipEncryptUserJson\n cripteremo zip al path:\n\(zipFileURL)\n")
//            try self.encryptZipFileWithAES(atPath: zipFileURL.path, key: symmetricKey)
//            
//            
//        } catch {
//            print("❌ \(error.localizedDescription)")
//            fatalError()
//        }
//    }
//    
//    
//    
//    //MARK: ENCRYPT UTIL VIA AES
//    //------------------------------------------------------------------------------
//    
//    ///crypting via AES
//    func encryptZipFileWithAES(atPath path: String, key: SymmetricKey) throws {
//        let zipData = try Data(contentsOf: URL(fileURLWithPath: path))
//        let encryptedData = try AES.GCM.seal(zipData, using: key)
//        
//        let zipFilePath = "\(path).encrypted"
//        let fileManager = FileManager.default
//        
//        guard fileManager.createFile(atPath: zipFilePath, contents: encryptedData.combined, attributes: nil) else {
//            print("❌ not encrypted zip file")
//            throw NSError(domain: "EncryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create encrypted zip file"])
//        }
//        print("encryptZipFileWithAES - ✅ crypted zip file found at path:\n\(URL(fileURLWithPath: zipFilePath))")
//        
//    }
//    
//    //MARK: - DECRYPT
//
//    //MARK: bip39 part
//    
//    //questa non sta ancora decriptando il file zip
////    func retriveUser(originalString: String, fileName: String, folderName: String) {
////
////        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
////
////        print("*********************** inverse operation *************************")
////        do {
////
////            //BIP39 section
////
////            //print("Mnemonic: \(originalString)")
////            try Mnemonic.validate(mnemonic: originalString)
////            let passphrase = "test"
////            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: originalString, passphrase: passphrase, language: .english)
////            print("retriveUser\nSeed decrypt:\n\(deterministicSeedString)\n")
////
////            let symmetricKey = encodingModel.keyFromPassword(deterministicSeedString)
////
////            //1) trovare file
////            //2) decryptare file da AES
////            //3) unzippare file
////            //4) decodificare da base 64
////
////            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip")
////            print("retriveUser\n ✅ searching Zip file saved at:\n\(zipFileURL)\n")
////
//////            let newObject = try encodingModel.decryptStringToCodableOject(User.self, from: encrypted, usingKey: simmetricKey)
//////            print("retriveUser - ✅\n\(newObject.name) \(newObject.password)\n")
////
////        } catch {
////            print("❌❌ decrypting: \(error.localizedDescription)")
////        }
////    }
//    
//    func retriveUser(originalString: String, fileName: String, folderName: String) {
//        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//        let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip.encrypted")
//        
//        do {
//            //Decriptare il file zip
//            let passphrase = "test"
//                        let deterministicSeedString = try Mnemonic.deterministicSeedString(from: originalString, passphrase: passphrase, language: .english)
//            let symmetricKey = encodingModel.keyFromPassword(deterministicSeedString)
//            try self.decryptZipFileWithAES(atPath: zipFileURL.path, key: symmetricKey)
//            
//            //Estrarre i file zip
//            let unzipFolderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
////            try SSZipArchive.unzipFile(atPath: zipFileURL.path, toDestination: unzipFolderURL.path)
//            let user = self.unzipAndReadUserJson(fileName: fileName, folderName: folderName)
//        } catch {
//            print("❌ \(error.localizedDescription)")
//        }
//    }
//    
//    
//    //MARK: DECRYPT VIA AES
//    //------------------------------------------------------------------------------
//    
//    ///decrypting via AES
//    func decryptZipFileWithAES(atPath path: String, key: SymmetricKey) throws {
//        let encryptedData = try Data(contentsOf: URL(fileURLWithPath: path))
//        let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
//        let decryptedData = try AES.GCM.open(sealedBox, using: key)
//        
//        let zipFilePath = path.replacingOccurrences(of: ".encrypted", with: "")
//        print("decryptZipFileWithAES - using path \(zipFilePath)")
//        let fileManager = FileManager.default
//        
//        guard fileManager.createFile(atPath: zipFilePath, contents: decryptedData, attributes: nil) else {
//            print("decryptZipFileWithAES- ❌ not decrypted zip file")
//            throw NSError(domain: "DecryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create decrypted zip file"])
//        }
//        print("decryptZipFileWithAES - ✅ decrypted zip file")
//        
//    }
//    
//    
//    
//    
//    func unzipAndReadUserJson(fileName: String, folderName: String) -> User? {
//        
//        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//        
//        do {
//            // Creare la cartella temporanea per l'estrazione del file zip
//            let tempFolderURL = commonAppFolderForTheFileURL
//                .appendingPathComponent("temp", isDirectory: true)
//                .deletingLastPathComponent()
//            try FileManager.default.createDirectory(at: tempFolderURL, withIntermediateDirectories: true, attributes: nil)
//            
//            // Estrarre il file zip nella cartella temporanea
//            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip")
//            let unzipResult = SSZipArchive.unzipFile(atPath: zipFileURL.path, toDestination: tempFolderURL.path)
//            guard unzipResult else {
//                print("unzipAndReadUserJson - ❌ Errore durante l'unzip del file zip")
//                return nil
//            }
//            print("unzipAndReadUserJson - ✅ file unzipped")
//            
//            // Leggere il file JSON estratto
//            let folderURL = tempFolderURL.appendingPathComponent(folderName, isDirectory: true)
//            let fileURL = folderURL.appendingPathComponent(fileName)
//            //print("fileURL unzip:\n\(fileURL)")
//            let jsonData = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let user = try decoder.decode(User.self, from: jsonData)
//            print("unzipAndReadUserJson - ✅ \(user)")
//            
//            return user
//            
//        } catch {
//            print("unzipAndReadUserJson - ❌ \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    
//}
//
//extension ViewController {
//    
//    /// Richiedere l'autorizzazione per accedere alla cartella dei documenti dell'app
//    func askForPermission() {
//        
//        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
//        documentPicker.delegate = self
//        documentPicker.allowsMultipleSelection = false
//        documentPicker.shouldShowFileExtensions = true
//        documentPicker.modalPresentationStyle = .formSheet
//        present(documentPicker, animated: true, completion: nil)
//    }
//}
