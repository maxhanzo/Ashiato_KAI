//
//  BottomSheetStyle.swift
//  
//
//  Created by Uedasoft IT Solutions on 09/04/25.
//

import SwiftUI

public struct BottomSheetStyle<T, B>: ViewModifier where T: BottomSheetRoutable, B: View {
    public typealias ContentBuilder = (_ item: T) -> B
    
    @Binding
    var item: RouteIdentifiable?
    var buider: ContentBuilder
    
    public func body(content: Content) -> some View {
        content
            .sheet(item: $item) { route in
                if let route = route.wrappedValue.asType(of: T.self) {
                    buider(route)
                        .presentationDetents(route.configuration.detents)
                        .presentationDragIndicator(route.configuration.dragIndicator)
                        .interactiveDismissDisabled(route.configuration.interactiveDismissDisabled)
                }
        }
    }
}
