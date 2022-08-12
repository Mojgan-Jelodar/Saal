import Combine
protocol Presentation: ObservableObject {
    associatedtype ViewEvent
    
    var viewEventSubject: PassthroughSubject<ViewEvent, Never> { get }
}
