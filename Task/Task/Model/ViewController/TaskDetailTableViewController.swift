//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    //MARK:- Properties
    var task: Task?
    var dueDateValue: Date?

    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameLabel.text, !taskName.isEmpty else {return}
        let notes = notesTextField?.text
        
        if let task = task {
            TaskController.sharedInstance.update(task: task, name: taskName, notes: notes, due: dueDateValue)
        }
        else {
            TaskController.sharedInstance.add(name: taskName, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var taskNameLabel: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet var datePicker: UIDatePicker!
    @IBAction func userTappedView(_ sender: Any) {
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = datePicker.date
        dateTextField.text = dueDateValue?.stringValue()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.inputView = datePicker
        updateViews()
    }

    func updateViews() {
        guard let task = task else {return}
        notesTextField.text = task.notes
        taskNameLabel.text = task.name
        dateTextField.text = task.due?.stringValue()
    }
}
