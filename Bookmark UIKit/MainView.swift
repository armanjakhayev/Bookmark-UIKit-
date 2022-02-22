import UIKit
import SnapKit

class MainView: UIViewController, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private var bookmarks: [Bookmark] = Storage.bookmarkModels{
        didSet {
            if bookmarks.count > 0 {
                checkLinks()
            }
            if bookmarks.count == 0 {
                checkLinks()
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 238/255, alpha: 1)
        tableView.isHidden = true
        return tableView
    }()
    
    private let labelText: UILabel = {
        let labelText = UILabel()
        labelText.text = "Save your first\n bookmark"
        labelText.numberOfLines = 0
        labelText.font = UIFont(name: "SFProText-Semibold", size: 36)
        labelText.font = .systemFont(ofSize: 36, weight: .bold)
        labelText.textColor = .black
        labelText.textAlignment = .center
        return labelText
    }()
    
    private let titleOfList: UILabel = {
        lazy var label = UILabel()
        label.isHidden = true
        label.text = "List"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let titleOfEmptyList: UILabel = {
        lazy var label = UILabel()
        label.text = "Bookmark App"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLinks()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 238/255, alpha: 1)
        
        tableView.register(ListOfBookmarks.self, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(labelText)
        labelText.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(titleOfList)
        titleOfList.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(titleOfEmptyList)
        titleOfList.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
        }
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 24)
        button.layer.cornerRadius = 16
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().inset(50)
        }
        button.addTarget(self, action: #selector(displayAlert), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsets(top: 41, left: 0, bottom: 0, right: 0)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? ListOfBookmarks else { return UITableViewCell() }
        cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 238/255, alpha: 1)
        cell.configure(model: bookmarks[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL (string: bookmarks[indexPath.row].link) {
            UIApplication.shared.open(url)
        }
    }
    
    // swipe to change or delete row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _,_,_ in
            self.bookmarks.remove(at: indexPath.row)
            Storage.bookmarkModels.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        let actionChange = UIContextualAction(style: .normal, title: "Change") { _,_,_ in
            self.bookmarks.remove(at: indexPath.row)
            Storage.bookmarkModels.remove(at: indexPath.row)
            tableView.reloadData()
            self.displayAlert()
        }
        checkLinks()

        let configuration = UISwipeActionsConfiguration(actions: [actionDelete, actionChange])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    private func checkLinks() {
           if bookmarks.isEmpty {
               tableView.isHidden = true
               titleOfList.isHidden = true
               labelText.isHidden = false
               titleOfEmptyList.isHidden = false
           } else {
               tableView.isHidden = false
               titleOfList.isHidden = false
               labelText.isHidden = true
               titleOfEmptyList.isHidden = true
           }
       }
    
    @objc func displayAlert(){
        let alertView = UIAlertController(title: "Change", message: .none , preferredStyle: .alert)
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark title"})
        alertView.addTextField(configurationHandler: { textField in textField.placeholder = "Bookmark link(URL)"})
        let save = UIAlertAction(title: "Save", style: .cancel , handler: { _ in
            guard let bookmarkName = alertView.textFields?[0].text,let bookmarkLink = alertView.textFields?[1].text else { return }
            let bookmark = Bookmark(title: bookmarkName, link: bookmarkLink)
            self.bookmarks.append(bookmark)
            Storage.bookmarkModels.append(Bookmark(title: bookmarkName, link: bookmarkLink))
            self.tableView.reloadData()
        })
        alertView.addAction(save)
        self.present(alertView, animated: true, completion: nil)
    }
}
