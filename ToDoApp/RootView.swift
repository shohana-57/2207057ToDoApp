
import SwiftUI

struct RootView: View {
    @StateObject var auth = AuthVM()

    var body: some View {
        if auth.user != nil {
            TodoListView().environmentObject(auth)
        } else {
            LoginView().environmentObject(auth)
        }
    }
}
