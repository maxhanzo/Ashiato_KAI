//
//  BottomSheetConfiguration.swift
//  
//
//  Created by Uedasoft IT Solutions on 09/04/25.
//

import SwiftUI

public class BottomSheetConfiguration {
    public var detents: Set<PresentationDetent>
    public var dragIndicator: Visibility
    public var interactiveDismissDisabled: Bool
    
    public init(detents: Set<PresentationDetent>, dragIndicator: Visibility, interactiveDismissDisabled: Bool) {
        self.detents = detents
        self.dragIndicator = dragIndicator
        self.interactiveDismissDisabled = interactiveDismissDisabled
    }
    
    public static var `default`: BottomSheetConfiguration = .init(
        detents: [.medium, .large],
        dragIndicator: .visible,
        interactiveDismissDisabled: false
    )
    
    public static var mediumDismissEnabled: BottomSheetConfiguration = .init(
        detents: [.medium],
        dragIndicator: .visible,
        interactiveDismissDisabled: false
    )
    
    public static var mediumDismissDisabled: BottomSheetConfiguration = .init(
        detents: [.medium],
        dragIndicator: .visible,
        interactiveDismissDisabled: true
    )
    
    public static var largeDismissDisabled: BottomSheetConfiguration = .init(
        detents: [.large],
        dragIndicator: .visible,
        interactiveDismissDisabled: true
    )
    
    public func detents(_ detents: Set<PresentationDetent>) -> Self {
        self.detents = detents
        return self
    }
    
    public func visibility(_ visibility: Visibility) -> Self {
        self.dragIndicator = visibility
        return self
    }
    
    public func dismissDisabled(_ disabled: Bool) -> Self {
        interactiveDismissDisabled = disabled
        return self
    }
}
