
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthVM
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Todo App").font(.largeTitle).bold()
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
            SecureField("Password (min 6)", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if !auth.errorMessage.isEmpty {
                Text(auth.errorMessage).foregroundColor(.red).font(.footnote)
            }
            

            Button("Login") { auth.login(email: email, password: password) }
                .buttonStyle(.borderedProminent)
            Button("Register") { auth.register(email: email, password: password) }
        }
        .padding(24)
    }
}
