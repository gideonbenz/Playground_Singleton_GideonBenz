//
// Copyright © Gideon Benz. All rights reserved.
//

import UIKit

// Singleton <- S
final class ApiClient {
    static let instance = ApiClient()
    private init () {}
}

// let api = ApiClient() <- cannot be init
let apiInstance = ApiClient.instance

// singleton <- s
class PersonalClient {
    static let instance = PersonalClient()
}

let personal = PersonalClient() // <- can be init
let personalInstance = PersonalClient.instance

//---------------- How to test them ? ----------------//

// Singleton <- it's impossible to test it
extension ApiClient {
    func login(completion: (_ isSuccess: Bool) -> Void) {}
}

// this is un-achievable because the super init is private
// final class MockApiClient: ApiClient {
//    override init() {
//        super.init()
//    }
// }

// singleton <- "can be inherit for testing"
extension PersonalClient {
    func takeNote(complete: (_ savedNote: String) -> Void) {}
}

final class MockPersonalClient: PersonalClient {
    override init() {
        super.init()
    }
}

final class LoginViewController: UIViewController {
    var personal = PersonalClient.instance
    
    func note() {
        personal.takeNote { savedNote in
            // update UI
        }
    }
}

// setup test implementation using singleton
let loginViewController = LoginViewController()
loginViewController.personal = MockPersonalClient() // <- set mock using property injection

//---------------------------------------//
//---------------- BONUS ----------------//
//---------------------------------------//

// Mutable Global State
class GlobalState {
    static var instance = GlobalState()
}

final class MockGlobalState: GlobalState {}

// setup test implementation using Global State
GlobalState.instance = MockGlobalState()
// note: on tearDown, don't forget to reset the global properties back to original GlobalState
