import Foundation
import FirebaseFirestore

struct TaskItem: Identifiable {
    var id: String
    var title: String
    var description: String
}

class TaskVM: ObservableObject {
    @Published var tasks: [TaskItem] = []
    private var listener: ListenerRegistration?
    private let db = Firestore.firestore()
    
    private func ref(_ uid: String) -> CollectionReference {
        db.collection("users").document(uid).collection("tasks")
    }
    func start(uid: String) {
        listener?.remove()
        listener = ref(uid).order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snap, _ in
                guard let docs = snap?.documents else { return }
                self?.tasks = docs.map {
                    TaskItem(id: $0.documentID,
                             title: $0["title"] as? String ?? "",
                             description: $0["description"] as? String ?? "")
                }
            }
    }
    func stop() {
        listener?.remove()
        tasks = []
    }
    
    func add(uid: String, title: String, desc: String) {
        ref(uid).addDocument(data: [
            "title": title,
            "description": desc,
            "createdAt": FieldValue.serverTimestamp()
        ])
    }

    func update(uid: String, id: String, title: String, desc: String) {
        ref(uid).document(id).updateData(["title": title, "description": desc])
    }

    func delete(uid: String, id: String) {
        ref(uid).document(id).delete()
    }
}

