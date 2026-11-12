import Foundation
import FirebaseAuth

class AuthVM: ObservableObject {
    @Published var user: User?
    @Published var errorMessage = ""
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        user = Auth.auth().currentUser
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, u in
            self?.user = u
        }
    }
    
    func login(email: String, password: String) {
          Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
              self?.errorMessage = error?.localizedDescription ?? ""
          }
      }

      func register(email: String, password: String) {
          Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
              self?.errorMessage = error?.localizedDescription ?? ""
          }
      }

      func logout() {
          try? Auth.auth().signOut()
      }
  }
