#  MVVM-C Implementation

> First of all, check out the concepts, patterns, and architecture behind all this in the [References](../README.md#references) section.


The implementation is divided into 3 steps, **Coordinator**, **View**, and **ViewModel**. 


**So let's get started!**


## <a id="coordinator"></a>Coordinator

The first thing that you need to have in your mind is that you must have a unique coordinator per flow, and the coordinator is the unique one that will have the knowledge and control all scenes on the flow.

Let's take a look at the following snip code with an example of the Coordinator struct.

```swift
import ArchitectureModule
import SwiftUI

// 1.
struct FooCoordinator: Coordinator {
    @Environment(\.parentCoordinator)
    var parent
    
    let root: Screen
    
    // 2.
    @Binding
    public var path: [AnyHashable]
    
    @State
    public var sheetItem: RouteIdentifiable?
    
    @State
    public var coverItem: RouteIdentifiable?
    
    // 3.
    var body: some View {
        // 4.
        if parent == nil {
            // 5.
            TNavigationStack(
                path: $path,
                root: buildContent
            )
        } else {
            buildContent()
        }
    }
    
    @MainActor @ViewBuilder
    func buildContent() -> some View {
        ZStack {
            buildScreen(root)
        }
        // 6.
        .tNavigationDestination(for: Screen.self, destination: buildScreen)
    }
    
    // 7.
    @MainActor @ViewBuilder
    func view(for route: ViewRoute) -> some View {
        switch route {
        case .firstView:
            FirstView(viewModel: .init().setCoordinator(self))
        case .secondView:
            SecondView(viewModel: .init().setCoordinator(self))
                // 8.
                .sheet(item: $sheetItem, content: buildPresentingScreen)
                .fullScreenCover(item: $coverItem, content: buildPresentingScreen)
        }
    }
	
	// 9.
    @MainActor @ViewBuilder
    func bottomSheet(for route: BottomSheetRoute) -> some View {
        switch route {
        case .fooBottomSheetView(let vm):
            FirstBottomSheetView(viewModel: vm, onDismiss: { [weak self] in
                guard let self = self else { return }
                self.dismissBottomSheet()
            })
        }
    }
}

extension FooCoordinator {
	// 10.
    enum Scene: ScreenRoutable {
        case secondView
    }
}

extension FooCoordinator {
	// 11.
    enum BottomSheet: BottomSheetRoutable {
        case fooBottomSheetView(ViewModel)
        
        var style: String? {
            return ""
        }
    }
}
```

1. Create a coordinator class for a specific flow and implement the `Coordinator` protocol, which requires two enum types responsible for defining the scenes and bottom sheet routes.
2. Declare your variable `path` as `@Binding`.
3. Implement the `var body: some View` and return the root view for the coordinator flow.
4. You can check the `parent` property and understand if need a structure with or without `TNavigationStack`.
5. In your root view, declare the `TNavigationStack` UI component and pass the `path` property from `router` as a binding parameter. Pay attention to the `TNavigationStack` component.
6. Implement the `.tNavigationDestination(for:)` on the `body` of a view inside of the `TNavigationStack`. If you are showing the coordinator in `push` style from another coordinator, you can't implement the `TNavigationStack`, because the flow can have only one `TNavigationStack` per flow. This method will be called when the coordinator changes the value of the `navPath` property to change the navigation.
7. Implement the `func view(for_ route: ViewRoute) -> some View` function and return each appropriate view according to the route value received as a parameter.
8. Implement the `.fullScreenCover(item:)` or `.sheet(item:)` on the view body. This modifier must be implemented only over the visible view before that precede this kind of presentation. 
   This method will be called when the coordinator changes the value of the `sheetItem` or `coverItem` property to change the navigation with modal style. 
   Warning: Calling the `.sheet()` and `.fullScreenCover()` modifiers at the root produce warning that will be a exception in the future release.
9. This is an optional implementation, and if your coordinator flow needs to show bottom sheet views, so you must implement the `func bottomSheet(for route: BottomSheetRoute) -> some View` function and return each appropriate view according to the route value received as a parameter.
10. Create the enum for `Screen` that should conform with the `ScreenRoutable` protocol.
11. Create the enum for `BottomSheet` that should conform with the `BottomSheetRoutable` protocol.


## <a id="view-model"></a>View Model

Having the [Coordinator](#coordinator) step concluded, now we are able to create our `ViewModel` and then the `View`.

Let's take a look at the following peace of code with an example of the ViewModel class.

```swift
import ArchitectureModule

// 1.
class FirstViewModel: ViewModel<FooCoordinator> {
    // 2.
    func onSecondViewAction() {
        coordinator?.push(.secondView)
    }
    
    // 3.
    func onSecondViewAction() {
        Task { [weak self] in
            guard let self = self else { return }
            await coordinator?
                .delay(for: 1.0)
                .push(.secondView)
        }
    }
}
```

1. Create a view model class for a specific view inheriting from the `ViewModel` base class that was previously defined as a type alias inside of the [Coordinator](#coordinator) class.
2. It's example of no-async coordinator function. It Should be triggered when the user interacts with the interface components. You can call a coordinator method to present the next scene or bottom sheet.
3. It's example of async coordinator function that are creating a stack of executions calling for the least the `delay(for: Int)` method. It Should be triggered when the user interacts with the interface components and inside of any async process.


## <a id="view"></a>View

After concluded the [Coordinator](#coordinator) and [View Model](#view-model) steps, now we can go to final step, the `View`.

Let's take a look at the following peace of code with an example of how to create a `View`.


```swift
import ArchitectureModule
import SwiftUI

struct FirstView: View {
    // 1.
    @StateObject
    var viewModel: MyAccountViewModel
    
    var body: some View {
        VStack {
           Button("Go to second view") {
              viewModel.onSecondViewAction()
           }
        }
    }
}
```

1. Declare the `viewModel` with `@StateObject` property wrapper.
