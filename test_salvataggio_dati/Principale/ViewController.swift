//
//  ViewController.swift
//  test_salvataggio_dati
//
//  Created by stefano cardia on 07/03/23.
//

import UIKit
import MnemonicSwift
import CryptoKit
import SSZipArchive
import MobileCoreServices
//import CryptoSwift //not needed

// A sample structure to encode
struct User: Codable {
    let name: String
    let password: String
}

class ViewController: UIViewController {
    
    //    private var encrypted = ""
    private let mnemonicString = "cattle swallow auction pistol orchard dilemma brain dynamic popular ready critic grief"
    let encodingModel = EncodingModel.shared
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //apre file e mostra cartella
        //                askForPermission()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummyUser = User(name: "john", password: "woo")
        let fileName = "myJedi.json"
        let folderName = "myNewFolder"
        
        //ZIP
        //                        saveZipEncryptUserJson(user: dummyUser, fileName: fileName, folderName: folderName)
        //UNZIP
        //                let userUnzipped = unzipAndReadUserJson(fileName: fileName, folderName: folderName)!
        
        //        generateSeedAndEncode64(mnemonicString: mnemonicString, user: dummyUser) { [weak self] result in
        //            guard let self = self else {return}
        //
        //            switch result {
        //            case .success(let (base64EncodedString, symmetricKey)):
        //
        //                self.saveZipUserJson(
        //                    user: base64EncodedString,
        //                    fileName: fileName,
        //                    folderName: folderName,
        //                    symmetricKey: symmetricKey) { [weak self] zipFileURL in
        //                    guard let self = self else {return}
        //                    do {
        //                        //Criptare file zip con AES
        //                        try self.encryptZipFileWithAES(atPath: zipFileURL.path, key: symmetricKey)
        //                    } catch {
        //                        print("❌ caught error: \(error.localizedDescription)")
        //                    }
        //                }
        //
        //            case .failure(let error):
        //                print("Error: \(error.localizedDescription)")
        //            }
        //        }
        
        
        self.retriveUser(originalString: self.mnemonicString, fileName: fileName, folderName: folderName)
        
        
        
        
    }
    
    
    //MARK: ENCRYPT
    
    ///Creates seed via Bip39, encodes in 64 bits
    func generateSeedAndEncode64(mnemonicString: String, user: User, completion: @escaping (Result<(String, SymmetricKey), Error>) -> Void) {
        do {
            //BIP39 section
            //Generate mnemonic and seed
            //let mnemonicString = try Mnemonic.generateMnemonic(strength: 128, language: .english)
            //print("Mnemonic: \(mnemonicString)")
            try Mnemonic.validate(mnemonic: mnemonicString)
            let deterministicSeedString = try Mnemonic.deterministicSeedString(from: mnemonicString, passphrase: "test", language: .english)
            //econding in base 64
            let simmetricKey = encodingModel.keyFromPassword(deterministicSeedString)
            let base64EncodedString = try encodingModel.encryptCodableObject(user, usingKey: simmetricKey)
            
            completion(.success((base64EncodedString, simmetricKey)))
            print("generateSeedAndEncode64 - ✅ user encoded")
        } catch {
            completion(.failure(error))
            print("❌ \(error.localizedDescription)")
        }
    }
    
    
    ///L'obiettivo della funzione è di salvare il file JSON dell'utente nella cartella specificata, creare un file zip contenente la cartella, e infine criptare il file zip.
    /// - creates folder
    /// - encodes in json
    /// - creates a zip file
    /// - calls encryptZipFileWithAES for encoding via AES
    func saveZipUserJson(user: String, fileName: String, folderName: String, symmetricKey: SymmetricKey, completion: @escaping (URL) -> () ) {
        
        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
        
        do {
            // Creare la cartella con il nome specifico
            let folderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
            try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
            
            // Salvare il file JSON nella cartella
            let fileURL = folderURL.appendingPathComponent(fileName)
            print("saveZipEncryptUserJson\n fileURL save:\n\(fileURL)\n")
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
            
            // Creare il file zip
            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip") //myNewFolder.zip.encrypted
            SSZipArchive.createZipFile(atPath: zipFileURL.path, withContentsOfDirectory: folderURL.path)
            print("saveZipEncryptUserJson\n ✅ File Zip saved at:\n\(zipFileURL)\n")
            completion(zipFileURL)
            
            
        } catch {
            print("❌ \(error.localizedDescription)")
            fatalError()
        }
    }
    
    //------------------------------------------------------------------------------
    
    ///crypting via AES
    func encryptZipFileWithAES(atPath path: String, key: SymmetricKey) throws {
        let zipData = try Data(contentsOf: URL(fileURLWithPath: path))
        let encryptedData = try AES.GCM.seal(zipData, using: key)
        
        let zipFilePath = "\(path).encrypted"
        let fileManager = FileManager.default
        
        guard fileManager.createFile(atPath: zipFilePath, contents: encryptedData.combined, attributes: nil) else {
            print("❌ not encrypted zip file")
            throw NSError(domain: "EncryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create encrypted zip file"])
        }
        print("encryptZipFileWithAES - ✅ crypted zip file found at path:\n\(URL(fileURLWithPath: zipFilePath))")
        
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - DECRYPT
    
    //MARK: bip39 part
    
    func retriveUser(originalString: String, fileName: String, folderName: String) {
        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
        let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip.encrypted")
        
        if FileManager.default.fileExists(atPath: zipFileURL.path) {
            print("retriveUser - ✅ file exists")
            do {
                //decrypt zip file
                let deterministicSeedString = try Mnemonic.deterministicSeedString(from: originalString, passphrase: "test", language: .english)
                let symmetricKey = encodingModel.keyFromPassword(deterministicSeedString)
                try self.decryptZipFileWithAES(atPath: zipFileURL.path, key: symmetricKey)
                
                //extract zip file
                let unzipFolderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
                try SSZipArchive.unzipFile(atPath: zipFileURL.path, toDestination: unzipFolderURL.path)
                let user = self.unzipAndReadUserJson(fileName: fileName, folderName: folderName)
            } catch {
                print("retriveUser ❌ \(error.localizedDescription)")
            }
        } else {
            // Il file non esiste, gestisci l'errore
            print("❌ Il file non esiste all'URL specificato.")
        }
        
    }
    
    
    //MARK: DECRYPT VIA AES
    //------------------------------------------------------------------------------
    
    ///decrypting via AES
    func decryptZipFileWithAES(atPath path: String, key: SymmetricKey) throws {
        
        do {
            
            let encryptedData = try Data(contentsOf: URL(fileURLWithPath: path))
            let sealedBox = try AES.GCM.SealedBox(combined: encryptedData)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            
            let zipFilePath = path.replacingOccurrences(of: ".encrypted", with: "")
            print("decryptZipFileWithAES - using path:\n\(zipFilePath)")
            let fileManager = FileManager.default
            
            guard fileManager.createFile(atPath: zipFilePath, contents: decryptedData, attributes: nil) else {
                print("decryptZipFileWithAES- ❌ not decrypted zip file")
                throw NSError(domain: "DecryptionError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create decrypted zip file"])
            }
            print("decryptZipFileWithAES - ✅ decrypted zip file")
        } catch {
            print("decryptZipFileWithAES ❌ \(error.localizedDescription)")
        }
        
    }
    
    
    
    
    func unzipAndReadUserJson(fileName: String, folderName: String) -> User? {
        
        let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
        
        do {
            // Creare la cartella temporanea per l'estrazione del file zip
            let tempFolderURL = commonAppFolderForTheFileURL
                .appendingPathComponent("temp", isDirectory: true)
                .deletingLastPathComponent()
            try FileManager.default.createDirectory(at: tempFolderURL, withIntermediateDirectories: true, attributes: nil)
            
            // Estrarre il file zip nella cartella temporanea
            let zipFileURL = commonAppFolderForTheFileURL.appendingPathComponent("\(folderName).zip")
            let unzipResult = SSZipArchive.unzipFile(atPath: zipFileURL.path, toDestination: tempFolderURL.path)
            guard unzipResult else {
                print("unzipAndReadUserJson - ❌ Errore durante l'unzip del file zip")
                return nil
            }
            print("unzipAndReadUserJson - ✅ file unzipped")
            
            // Leggere il file JSON estratto
            let folderURL = tempFolderURL.appendingPathComponent(folderName, isDirectory: true)
            let fileURL = folderURL.appendingPathComponent(fileName)
            //print("fileURL unzip:\n\(fileURL)")
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: jsonData)
            print("unzipAndReadUserJson - ✅ \(user)")
            
            return user
            
        } catch {
            print("unzipAndReadUserJson - ❌ \(error.localizedDescription)")
            return nil
        }
    }
    
    
}

extension ViewController {
    
    /// Richiedere l'autorizzazione per accedere alla cartella dei documenti dell'app
    func askForPermission() {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.shouldShowFileExtensions = true
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
}
