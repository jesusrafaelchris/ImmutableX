import Foundation

enum LoginState {
    case connected(ConnectedState)
    case disconnected
    case disconnecting
    case connecting
}
