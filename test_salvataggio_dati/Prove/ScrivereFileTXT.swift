//
//  ScrivereFileTXT.swift
//  test_salvataggio_dati
//
//  Created by Resia Servizi Operativi on 09/03/23.
//

import Foundation

//ok

///- URL: https://fred.appelman.net/?p=119
///- simply writes a text file
//func writeAndReadTxtFile() {
//
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//
//    let message = "dato da salvare"
//    let nomeFile = "testoSalvato.txt"
//
//    let URLFileDiDestinazione = URL(
//        fileURLWithPath: nomeFile,
//        relativeTo: commonAppFolderForTheFileURL)
//    do {
//        //scriviamo
//        try message.write(to: URLFileDiDestinazione, atomically: true, encoding: .utf8)
//        //leggiamo
//        let read = try String(contentsOf: URLFileDiDestinazione)
//        print(read)
//        print()
//    } catch {
//        print("❌ \(error.localizedDescription)")
//        fatalError()
//    }
//}
