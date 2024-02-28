## 这个例子主要的目的不是analysis，而是架构方法。

```swift

// Define protocol

public protocol EventType {
  func name(for provider: ProviderType) -> String?
  func parameters(for provider: ProviderType) -> [String: Any]?
}

public protocol ProviderType {
  func log(_ eventName: String, parameters: [String: Any]?)
}

open class Analytics<Event: EventType>: AnalyticsType {
  private(set) open var providers: [ProviderType] = []

  public init() {
    // I'm Analytics 👋
  }

  open func register(provider: ProviderType) {
    self.providers.append(provider)
  }

  open func log(_ event: Event) {
    for provider in self.providers {
      guard let eventName = event.name(for: provider) else { continue }
      let parameters = event.parameters(for: provider)
      provider.log(eventName, parameters: parameters)
    }
  }
}

// MARK: - example

enum MyAppEvent {
  case signup(username: String)
  case viewContent(productID: Int)
  case purchase(productID: Int, price: Float)
}

extension MyAppEvent: EventType {
  /// An event name to be logged
  func name(for provider: ProviderType) -> String? {
    switch self {
    case .signup: return "signup"
    case .viewContent: return "view_content"
    case .purchase: return "purchase"
    }
  }

  /// Parameters to be logged
  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case let .signup(username):
      return ["username": username]
    case let .viewContent(productID):
      return ["product_id": productID]
    case let .purchase(productID, price):
      return ["product_id": productID, "price": price]
    }
  }
}

struct Analysis {
    static let analytics = Analytics<MyAppEvent>()
    
    static func initTracking() {
        analytics.register(provider: MixpanelProvider())
    }
    
    static func logDemo() {
        analytics.log(.signup(username: "devxoul"))
    }
}

```
