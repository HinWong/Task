//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Hin Wong on 3/4/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    var delegate: ButtonTableViewCellDelegate?
    
    func updateButton(_ isComplete:Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension ButtonTableViewCell {
    func update(withTask task:Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
        
    }
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender:ButtonTableViewCell)

}
