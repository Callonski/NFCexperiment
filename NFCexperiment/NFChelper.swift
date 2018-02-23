//
//  NFChelper.swift
//  NFCexperiment
//
//  Created by Calle Engene on 2018-02-23.
//  Copyright © 2018 Calle Engene. All rights reserved.
//

import Foundation
import CoreNFC

class NFCHelper: NSObject, NFCNDEFReaderSessionDelegate {
    
    var onNFCResult: ((Bool, String) -> ())?

    func restartSession() {
        let session =
            NFCNDEFReaderSession(delegate: self,
                                 queue: nil,
                                 invalidateAfterFirstRead: true)
        session.begin()
    }
    
   
    // Callback when reading NFC with a validation error
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        guard let onNFCResult = onNFCResult else {
            return
        }
        onNFCResult(false, error.localizedDescription)
    
    }
    // Callback when reading NFC
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        print("Did detect NDEFs.")
        // Loop through all messages
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
            }
        }
    }
    
  
}
