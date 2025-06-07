//
//  EnvironmentObject+Extension.swift
//
//
//  Created by Uedasoft IT Solutions on 23/01/25.
//

import SwiftUI

public extension EnvironmentObject {
    var hasValue: Bool {
        !String(describing: self).contains("_store: nil")
    }
}
