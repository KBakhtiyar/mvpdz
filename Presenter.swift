import Foundation
import RealmSwift

protocol RealmPresenterProtocol {
    func viewDidLoad()
    func addButtonTapped(name: String, surname: String, password: String)
    func setNameButtonTapped()
    func editButtonTapped(at indexPath: IndexPath)
    func updateUserName(to newName: String, at indexPath: IndexPath)
}

class RealmPresenter: RealmPresenterProtocol {
    var view: RealViewProtocol?
    var model: RealmModelProtocol!
    
    init(view: RealViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.reloadData()
    }
    
    func addButtonTapped(name: String, surname: String, password: String) {
        model.addUser(name: name, surname: surname, password: password)
        view?.reloadData()
    }
    
    func setNameButtonTapped() {
        view?.reloadData()
    }
    
    func editButtonTapped(at indexPath: IndexPath) {
            let users = model.getUsers()
            guard indexPath.row < users.count else { return }
            let user = users[indexPath.row]
            model.updateUser(user: user, newName: "New Name")
            view?.reloadData()
    }
    
    func updateUserName(to newName: String, at indexPath: IndexPath) {
        let users = model.getUsers()
        guard indexPath.row < users.count else { return }
        let user = users[indexPath.row]
        model.updateUser(user: user, newName: newName)
        view?.reloadData()
    }
}

