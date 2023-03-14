//
//  Extensions.swift
//  test_salvataggio_dati
//
//  Created by Resia Servizi Operativi on 09/03/23.
//

import UIKit
import MnemonicSwift
import CryptoKit
import SSZipArchive
import MobileCoreServices


//MARK: - extensions

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

extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Gestire la scelta dei documenti
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // L'utente ha annullato la scelta dei documenti
    }
}

extension FileManager {
    ///la cartella comune propria dell'app tramite sandboxing
    static var documentDirectoryURL: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

