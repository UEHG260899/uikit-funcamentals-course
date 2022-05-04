//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Uriel Hernandez Gonzalez on 04/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyPrompt = StoryPromptEntry()
        storyPrompt.noun = "toaster"
        storyPrompt.adjective = "smelly"
        storyPrompt.verb = "burps"
        storyPrompt.number = 10
        print(storyPrompt)
    }


}

