//
//  Analysis.swift
//  AnalysisDemo
//
//  Created by liang wang on 28/2/2024.
//

import Foundation
import Umbrella

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
