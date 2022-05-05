//
//  ViewController.swift
//  StoryPrompt
//
//  Created by Uriel Hernandez Gonzalez on 04/05/22.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var nounTextField: UITextField!
    @IBOutlet weak var adjectiveTextField: UITextField!
    @IBOutlet weak var verbTextFIeld: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var storyPromptImageView: UIImageView!
    
    let storyPrompt = StoryPromptEntry()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberSlider.value = 7.5
        setupActions()
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        storyPromptImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func changeImage() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imageController = PHPickerViewController(configuration: configuration)
        imageController.delegate = self
        present(imageController, animated: true)
    }

    
    @IBAction func onNumberChanged(_ sender: UISlider) {
        numberLabel.text = "Number: \(Int(sender.value))"
        storyPrompt.number = Int(sender.value)
    }
    
    @IBAction func onStoryTypeChanged(_ sender: UISegmentedControl) {
        if let genre = StoryPrompts.Genre(rawValue: sender.selectedSegmentIndex) {
            storyPrompt.genre = genre
        } else {
            storyPrompt.genre = .scifi
        }
    }
    
    @IBAction func onGenerateStoryClicked(_ sender: UIButton) {
        updateStoryPrompt()
        
        if storyPrompt.isValid() {
            print(storyPrompt)
        } else {
            let alert = UIAlertController(title: "Invalid Story Prompt", message: "Please fill out all of the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateStoryPrompt()
        return true
    }
    
    func updateStoryPrompt() {
        storyPrompt.noun = nounTextField.text ?? ""
        storyPrompt.adjective = adjectiveTextField.text ?? ""
        storyPrompt.verb = verbTextFIeld.text ?? ""
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if !results.isEmpty {
            let result = results.first!
            let itemProvider = result.itemProvider
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        picker.dismiss(animated: true)
                        self?.storyPromptImageView.image = image
                    }
                }
            }
        }
    }
    
    
    
    
}
