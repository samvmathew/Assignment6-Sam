import UIKit
struct toDoList{
    let text: String
    var complete: Bool
}
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDo = [toDoList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func AddButton(_ sender: Any) {
            let alertbox = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
            alertbox.addTextField { (textField)in
            textField.placeholder = "Write An Item"
        }
        alertbox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertbox.addAction(UIAlertAction(title: "OK", style: .default,handler: { (_) in
            guard let toDotext = alertbox.textFields?.first?.text   else{
                    return
            }
            self.toDo.append(toDoList(text: toDotext,complete: false))
            self.tableView.reloadData()
        }))
        present(alertbox,animated:  true)
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toDo = toDo[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = toDo.text
        if toDo.complete {
            cell.accessoryType = .checkmark
            cell.textLabel?.alpha = 0.5
        }
        else {
            cell.accessoryType = .none
            cell.textLabel?.alpha = 1.0
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                toDo.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        toDo[indexPath.row].complete.toggle()
        tableView.reloadData()
    }
}
