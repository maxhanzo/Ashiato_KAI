//
//  View+BottomSheetStyle.swift
//
//
//  Created by Uedasoft IT Solutions on 09/04/25.
//

import SwiftUI

public extension View {
    func bottomSheet<T, B>(
        item: Binding<RouteIdentifiable?>,
        content: @escaping BottomSheetStyle<T, B>.ContentBuilder
    ) -> some View where T: BottomSheetRoutable, B: View {
        modifier(
            BottomSheetStyle(
                item: item,
                buider: content
            )
        )
    }
}
