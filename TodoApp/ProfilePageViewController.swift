import UIKit

class ProfilePageViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var todoListButton: UIButton!
    @IBOutlet weak var completedTasks: UIButton!
    @IBOutlet weak var deletedTasks: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewcontrollerComponents()
        navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    private func viewcontrollerComponents() {
        // profile picture
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.image = UIImage(named: "displayPicture")
        // profile Name
        profileName.text = "Kshitiz Rimal"
        profileName.textAlignment = .center
        // Todo List Button
        todoListButton.setTitle("Todo List", for: .normal)
        todoListButton.addTarget(self, action: #selector(todoListButtonTapped), for: .touchUpInside)
        // Completed Tasks
        completedTasks.setTitle("Tasks Completed", for: .normal)
        completedTasks.addTarget(self, action: #selector(completedTasksButtonTapped), for: .touchUpInside)
        // deleted Tasks
        deletedTasks.setTitle("Tasks Deleted", for: .normal)
        deletedTasks.addTarget(self, action: #selector(deletedTasksButtonTapped), for: .touchUpInside)
        // LogOut Button
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    @objc private func todoListButtonTapped() {
        if let toTodoView = storyboard?.instantiateViewController(
            withIdentifier: "TabViewController"
        ) as? TabViewController {
            toTodoView.selectedIndex = 0
            navigationController?.pushViewController(toTodoView, animated: true)
        }
        
    }
    
    @objc private func completedTasksButtonTapped() {
        if let toCompletedView = storyboard?.instantiateViewController(
            withIdentifier: "TabViewController"
        ) as? TabViewController {
            toCompletedView.selectedIndex = 1
            navigationController?.pushViewController(toCompletedView, animated: true)
        }
    }
    
    @objc private func deletedTasksButtonTapped() {
        if let toDeletedView = storyboard?.instantiateViewController(
            withIdentifier: "TabViewController"
        ) as? TabViewController {
            toDeletedView.selectedIndex = 2
            navigationController?.pushViewController(toDeletedView, animated: true)
        }
    }
    
    @objc private func logoutButtonTapped() {
        if let viewController = storyboard?.instantiateViewController(
            withIdentifier: "ViewController"
        ) as? ViewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
