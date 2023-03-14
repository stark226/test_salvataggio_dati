////
////  ViewController.swift
////  test_salvataggio_dati
////
////  Created by stefano cardia on 07/03/23.
////
//
////POD
////import BIP39 //https://github.com/bitmark-inc/bip39-swift //vecchia, rimossa❌
//
////pacakge manager:
////https://github.com/yenom/BitcoinKit
//
//import UIKit
//
//import Bip39 // https://swiftpack.co/package/tesseract-one/Bip39.swift
//import CryptoSwift //https://github.com/krzyzanowskim/CryptoSwift#installation
//
//
//class ViewController: UIViewController {
//    
//    
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //✅ ok creeiamo, scriviamo e leggiamo un file
//                let message = "dato da salvare"
//                let nomeFile = "nuovo.txt"
//        
//                let URLFileDiDestinazione = URL(
//                    fileURLWithPath: nomeFile,
//                    relativeTo: commonAppFolderForTheFileURL)
//                do {
//                    //scriviamo
//                    try message.write(to: URLFileDiDestinazione, atomically: true, encoding: .utf8)
//                    //leggiamo
//                    var read = try String(contentsOf: URLFileDiDestinazione)
//                    print(read)
//                    print()
//                } catch {
//                    print("❌ \(error.localizedDescription)")
//                }
//        
//        
//        // Genera una frase mnemonica casuale
//        let mnemonic = try! Bip39.Mnemonic() //restituisce array che utente deve ricordare, wordlist da fare in italianno
//        print(mnemonic)
//
//        //creare entropia entropyTomnnemonic ?
//        
//        // Genera un seed bip39 utilizzando la frase mnemonica
//        let seed = mnemonic.seed()
//        
//        //calcolare salt e va salvato per decriptaggio
//        
//        // Converte il seed in una chiave AES-256
//        let aesKey = try! PKCS5.PBKDF2(password: seed, salt: [2], iterations: 2048, keyLength: 32, variant: .sha256).calculate()
//
//        // Converte il seed in un vettore di inizializzazione AES-256
//        let aesIV = try! PKCS5.PBKDF2(password: seed, salt: [2], iterations: 2048, keyLength: 16, variant: .sha256).calculate()
//
//        // Crea un oggetto AES-256 in modalità CBC con la chiave e il vettore di inizializzazione generati
//        let aes = try! AES(key: aesKey, blockMode: CBC(iv: aesIV))
//
//        // Stringa di esempio da crittografare
//        let plaintext = "Questa è una stringa di esempio da crittografare"
//
//        // Crittografa la stringa di esempio utilizzando l'oggetto AES-256
//        let ciphertext = try! aes.encrypt(Array(plaintext.utf8))
//
//        // Stampa il risultato in forma di stringa esadecimale
//        print(ciphertext.toHexString())
//
//        let dec = try! aes.decrypt(ciphertext)
//        print("dec: \(dec)")
//        
//
//    }
//    
//    
//}
//
//
//
//
//
//
////MARK: - extensions
//extension FileManager {
//    ///la cartella comune propria dell'app tramite sandboxing
//    static var documentDirectoryURL: URL {
//        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    }
//}
//
//
//
//
//
//
