//___FILEHEADER___

import DesignPatterns
import GGCommons
import SwiftUI

public struct ___VARIABLE_moduleName___Coordinator: ___VARIABLE_moduleName___CoordinatorInterface {
    @Environment(\.presentationMode)
    public var presentationMode
    
    @Environment(\.parentCoordinator)
    public var parent: (any Coordinator)?
    
    public var root: ViewRoute
    
    @Binding
    public var path: [AnyHashable]
    
    @State
    public var sheetItem: RouteIdentifiable?
    
    @State
    public var coverItem: RouteIdentifiable?
    
    public init(root: ViewRoute = .main, path: Binding<[AnyHashable]>) {
        self.root = root
        self._path = path
    }
    
    public var body: some View {
        if parent == nil {
            TNavigationStack(
                path: $path,
                root: buildContent
            )
        } else {
            buildContent()
        }
    }
    
    public func view(for route: ViewRoute) -> some View {
        ZStack { Color.gray }
    }
}

#Preview {
    @Previewable
    @State
    var path = [AnyHashable]()
    return ___VARIABLE_moduleName___Coordinator(path: $path)
}
