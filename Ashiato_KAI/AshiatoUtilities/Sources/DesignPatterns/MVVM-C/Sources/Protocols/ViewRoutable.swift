//
//  ViewRoutable.swift
//  
//
//  Created by Uedasoft IT Solutions on 19/06/25.
//

import Foundation

public protocol ViewRoutable: Routable { }

public extension ViewRoutable {
    var configuration: BottomSheetConfiguration { .default }
}
