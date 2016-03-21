//
//  MessagePublisher.swift
//  MHMessageKit
//
//  Created by Milen Halachev on 1/15/16.
//  Copyright © 2016 Milen Halachev. All rights reserved.
//

import Foundation

public protocol MessagePublisher {
    
    func publishMessage(message: Message)
}
