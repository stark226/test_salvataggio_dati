//
//  Prove_json.swift
//  test_salvataggio_dati
//
//  Created by Resia Servizi Operativi on 09/03/23.
//

import Foundation


//import SSZipArchive


//✅ creeiamo, scriviamo e leggiamo un file
///writing data to a json file
//func convertStructIntoJson(user: MyChatData, to fileName: String) {
//
//
//    let encoder = JSONEncoder()
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//    let fileURL = commonAppFolderForTheFileURL.appendingPathComponent(fileName)
//
//    do {
//        let jsonData = try encoder.encode(user)
//
//        let jsonString = String(data: jsonData, encoding: .utf8)!
//
//        try jsonString.write(toFile: fileURL.path, atomically: true, encoding: .utf8)
//        print("✅ File JSON salvato in \(fileURL.path)")
//
//    } catch {
//        print("❌ \(error.localizedDescription)")
//        fatalError()
//    }
//}


//func readUserJsonInsideAFolder(fileName: String, folderName: String) {
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//
//    do {
//        let folderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
//        let fileURL = folderURL.appendingPathComponent(fileName)
//
//        guard let jsonData = FileManager.default.contents(atPath: fileURL.path) else {
//            print("❌ File non trovato")
//            return
//        }
//
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(User.self, from: jsonData)
//
//        print("✅ Utente letto: \(user)")
//    } catch {
//        print("❌ \(error.localizedDescription)")
//        fatalError()
//    }
//}


//
//func readUserJsonInsideAFolder(fileName: String, folderName: String) {
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//
//    do {
//        let folderURL = commonAppFolderForTheFileURL.appendingPathComponent(folderName, isDirectory: true)
//        let fileURL = folderURL.appendingPathComponent(fileName)
//
//        guard let jsonData = FileManager.default.contents(atPath: fileURL.path) else {
//            print("❌ File non trovato")
//            return
//        }
//
//        let decoder = JSONDecoder()
//        let user = try decoder.decode(User.self, from: jsonData)
//
//        print("✅ Utente letto: \(user)")
//    } catch {
//        print("❌ \(error.localizedDescription)")
//        fatalError()
//    }
//}






//reading user from file
//func readUserFromJson(from fileName: String) -> User? {
//    
//    
//    let commonAppFolderForTheFileURL = FileManager.documentDirectoryURL
//    let fileURL = commonAppFolderForTheFileURL.appendingPathComponent(fileName)
//    
//    do {
//        let jsonString = try String(contentsOfFile: fileURL.path, encoding: .utf8)
//        
//        let decoder = JSONDecoder()
//        
//        let user = try decoder.decode(User.self, from: Data(jsonString.utf8))
//        print(user)
//        return user
//        
//    } catch {
//        print("❌ \(error.localizedDescription)")
//        return nil
//    }
//    
//}
