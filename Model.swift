import Foundation
import RealmSwift

protocol RealmModelProtocol {
    func getUsers() -> Results<User>
    func addUser(name: String, surname: String, password: String)
    func updateUser(user: User, newName: String)
}

class RealmModel: RealmModelProtocol {
    private let realm = try! Realm()
    
    func getUsers() -> Results<User> {
        return realm.objects(User.self)
    }
    func addUser(name: String, surname: String, password: String) {
            let newUser = User()
            newUser.name = name
            newUser.surname = surname
            newUser.password = password
            
            try! realm.write {
                realm.add(newUser)
            }
        }
        
        func updateUser(user: User, newName: String) {
            try! realm.write {
                user.name = newName
            }
        }
    }
class User: Object {
    @Persisted var name: String = ""
    @Persisted var surname: String = ""
    @Persisted var password: String
}
