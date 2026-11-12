import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var auth: AuthVM
    @StateObject var vm = TaskVM()
    @State private var showForm = false
    @State private var editing: TaskItem?

    private var uid: String { auth.user?.uid ?? "" }

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.tasks) { task in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(task.title).font(.headline)
                        if !task.description.isEmpty {
                            Text(task.description).font(.subheadline).foregroundColor(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture { editing = task; showForm = true }
                }
                .onDelete { offsets in
                                  for i in offsets { vm.delete(uid: uid, id: vm.tasks[i].id) }
                              }
                          }
                          .navigationTitle("My Tasks")
                          .toolbar {
                              ToolbarItem(placement: .navigationBarLeading) {
                                  Button("Logout") { vm.stop(); auth.logout() }
                              }
                              ToolbarItem(placement: .navigationBarTrailing) {
                                  Button { editing = nil; showForm = true } label: { Image(systemName: "plus") }
                              }
                          }
                          .sheet(isPresented: $showForm) {
                              TaskFormView(task: editing) { title, desc in
                                  if let t = editing {
                                      vm.update(uid: uid, id: t.id, title: title, desc: desc)
                                  } else {
                                      vm.add(uid: uid, title: title, desc: desc)
                                                       }
                                                   }
                                               }
                                               .onAppear { vm.start(uid: uid) }
                                           }
                                       }
                                   }
