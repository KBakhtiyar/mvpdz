import UIKit
import RealmSwift
import SnapKit

protocol RealViewProtocol {
    func reloadData()
}


class RealmViewController: UIViewController {
    
    var presenter: RealmPresenterProtocol?
    var users: Results<User>?
    
    lazy var textFieldName: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "NAME:"
        return textfield
    }()
    
    lazy var textFieldSurname: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "SURNAME:"
        return textfield
    }()
    
    lazy var textFieldPassword: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "PASSWORD:"
        return textfield
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("*TAP ME*", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(setName), for: .touchDragInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    func reloadData() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(textFieldName)
        view.addSubview(textFieldSurname)
        view.addSubview(textFieldPassword)
        view.addSubview(button)
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        textFieldName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        textFieldSurname.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textFieldName.snp.bottom).offset(8)
        }
        
        textFieldPassword.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(textFieldSurname.snp.bottom).offset(12)
        }
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(textFieldSurname.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(button.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func buttonTapped() {
        presenter?.addButtonTapped(name: textFieldName.text ?? "", surname: textFieldSurname.text ?? "", password: textFieldPassword.text ?? "")
        
        let user = User()
        user.name = textFieldName.text ?? ""
        textFieldName.text = ""
        user.surname = textFieldSurname.text ?? ""
        textFieldSurname.text = ""
        user.password = textFieldPassword.text ?? ""
        textFieldPassword.text = ""
    }
    
    @objc func setName(_ sender: UIButton) {
        presenter?.setNameButtonTapped()
    }
}



extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let user = users?[indexPath.row] {
            cell.textLabel?.text = "\(user.name) \(user.surname) \(user.password)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
            
            self?.editUser(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }

   private func editUser(at indexPath: IndexPath) {
        guard let newName = textFieldSurname.text else { return }
       presenter?.updateUserName(to: newName, at: indexPath)
        textFieldSurname.text = ""
    }
}

