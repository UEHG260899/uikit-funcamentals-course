//
//  StoryPromptViewController.swift
//  StoryPrompt
//
//  Created by Uriel Hernandez Gonzalez on 04/05/22.
//

import UIKit

class StoryPromptViewController: UIViewController {

    @IBOutlet weak var storyPromtpTextView: UITextView!
    
    var storyPrompt: StoryPromptEntry?
    var isNewStoryPrompt = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        storyPromtpTextView.text = storyPrompt?.description
        
        if isNewStoryPrompt {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onClickedSave))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onClickedCancel))
            
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.leftBarButtonItem = cancelButton
        }
    }
    
    @objc
    func onClickedCancel() {
        performSegue(withIdentifier: "CancelStoryPrompt", sender: nil)
    }
    
    @objc
    func onClickedSave() {
        NotificationCenter.default.post(name: .StoryPromptSaved, object: storyPrompt)
        performSegue(withIdentifier: "SaveStoryPrompt", sender: nil)
    }
}

extension Notification.Name {
    static let StoryPromptSaved = Notification.Name("StoryPromptSave")
}
