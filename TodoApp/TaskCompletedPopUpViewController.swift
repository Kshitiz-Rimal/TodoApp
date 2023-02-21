//
//  TaskCompletedPopUpViewController.swift
//  TodoApp
//
//  Created by gurzu on 12/12/2022.
//

import UIKit

protocol TaskCompletedPopUpViewControllerDelegate: AnyObject {
    func onCancelButtonPressed(cellIndex: Int)
    func onDoneButtonPressed(cellTitle: String)
}

class TaskCompletedPopUpViewController: UIViewController {

    @IBOutlet weak var taskCompletedTitle: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    var delegate: TaskCompletedPopUpViewControllerDelegate?
    
    var cellIndex: Int?
    var cellTitle: String?
    
    init() {
        super.init(nibName: "TaskCompletedPopUpViewController", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor  = .clear
        self.backView.backgroundColor = .black.withAlphaComponent(0.6)
        self.backView.alpha = 0
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 10
        taskCompletedTitle.text = "Congratulations on Completing a task"
        taskCompletedTitle.textAlignment = .center
        taskCompletedTitle.numberOfLines = 0
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(calcelButtonPressed), for: .touchUpInside)
    }
    
    func setup(cellIndex: Int, cellTitle: String) {
        self.cellIndex = cellIndex
        self.cellTitle = cellTitle
    }
    
    func completedPopUpAppear(sender: UIViewController) {
        sender.present(self, animated: true) {
            self.completedPopUpShow()
        }
    }
    
    private func completedPopUpShow() {
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func completedPopUpHide() {
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut) {
            self.backView.alpha = 0
            self.contentView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }
    
    @objc func doneButtonPressed() {
        guard let cellTitle = cellTitle else {
            return
        }
        self.delegate?.onDoneButtonPressed(cellTitle: cellTitle)
        completedPopUpHide()
    }
    
    @objc func calcelButtonPressed() {
        guard let cellIndex = cellIndex else {
            return
        }
        completedPopUpHide()
        self.delegate?.onCancelButtonPressed(cellIndex: cellIndex)
    }
}
