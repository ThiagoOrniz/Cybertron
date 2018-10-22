//
//  CreateTransformerController.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-21.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import UIKit

class CreateTransformerController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthTextField: UITextField!
    @IBOutlet weak var intelligenceTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    @IBOutlet weak var enduranceTextField: UITextField!
    @IBOutlet weak var rankTextField: UITextField!
    @IBOutlet weak var courageTextField: UITextField!
    @IBOutlet weak var firepowerTextField: UITextField!
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var teamTextField: UITextField!

    let numberPicker: UIPickerView = UIPickerView()
    let teamPicker: UIPickerView = UIPickerView()

    private let viewModel: CreateTransformerViewModel
    
    // MARK: - Initialization
    public init(viewModel: CreateTransformerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        setupTextFields()
        setupPickers()
        loadLayout()
        loadNavBar()
        
        registerForKeyboardNotifications()
        hideKeyboardWhenTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Layout
    private func setupTextFields() {
        nameTextField.delegate = self
        strengthTextField.delegate = self
        intelligenceTextField.delegate = self
        speedTextField.delegate = self
        enduranceTextField.delegate = self
        rankTextField.delegate = self
        courageTextField.delegate = self
        firepowerTextField.delegate = self
        skillTextField.delegate = self
        teamTextField.delegate = self
    }
    
    private func setupPickers() {
        numberPicker.delegate = self
        numberPicker.dataSource = self
        teamPicker.delegate = self
        teamPicker.dataSource = self
     
        strengthTextField.inputView = numberPicker
        intelligenceTextField.inputView = numberPicker
        speedTextField.inputView = numberPicker
        enduranceTextField.inputView = numberPicker
        rankTextField.inputView = numberPicker
        courageTextField.inputView = numberPicker
        firepowerTextField.inputView = numberPicker
        skillTextField.inputView = numberPicker
        teamTextField.inputView = teamPicker
        
    }
    
    private func loadNavBar() {
        navigationItem.title = viewModel.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSave))
    }
    
    private func loadLayout() {
        view.backgroundColor = UIColor.CBTColors.background
    }
    
    // MARK: - Data
    private func loadData() {
        nameTextField.text = String(viewModel.name)
        strengthTextField.text = String(viewModel.strength)
        intelligenceTextField.text = String(viewModel.intelligence)
        speedTextField.text = String(viewModel.speed)
        enduranceTextField.text = String(viewModel.endurance)
        rankTextField.text = String(viewModel.rank)
        courageTextField.text = String(viewModel.courage)
        firepowerTextField.text = String(viewModel.firepower)
        skillTextField.text = String(viewModel.skill)
        teamTextField.text = viewModel.team.teamName
    }
    

    // MARK: - Actions
    @objc private func actionSave() {
        view.isUserInteractionEnabled = false
        viewModel.save()
    }
}

// MARK: - TransformersListDelegate
extension CreateTransformerController: CreateTransformerDelegate {
    
    /// Update outlets with the model values
    func didUpdateModel() {
        loadData()
    }
    
    /// We check which attribute didn't udpate/add, so we set first responder to its textField
    func didMissToUpdate(item: CreateTransformerNumberItems) {
        view.isUserInteractionEnabled = true

        switch item {
        case .name: nameTextField.becomeFirstResponder()
        case .strength: strengthTextField.becomeFirstResponder()
        case .intelligence: intelligenceTextField.becomeFirstResponder()
        case .speed: speedTextField.becomeFirstResponder()
        case .endurance: enduranceTextField.becomeFirstResponder()
        case .rank: rankTextField.becomeFirstResponder()
        case .courage: courageTextField.becomeFirstResponder()
        case .firepower: firepowerTextField.becomeFirstResponder()
        case .skill: skillTextField.becomeFirstResponder()
        case .team: teamTextField.becomeFirstResponder()
        case .none: break
        }
    }
    
    func didFail(msg: String) {
        view.isUserInteractionEnabled = true
        showOKMessage(title: "Oops!", content: msg)
    }
    
    func didSuccess(msg: String) {
        view.isUserInteractionEnabled = true
        print(msg)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - TransformersListDelegate
extension CreateTransformerController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField: viewModel.itemBeingUpdated = .name
        case strengthTextField: viewModel.itemBeingUpdated = .strength
        case intelligenceTextField: viewModel.itemBeingUpdated = .intelligence
        case speedTextField: viewModel.itemBeingUpdated = .speed
        case enduranceTextField: viewModel.itemBeingUpdated = .endurance
        case rankTextField: viewModel.itemBeingUpdated = .rank
        case courageTextField: viewModel.itemBeingUpdated = .courage
        case firepowerTextField: viewModel.itemBeingUpdated = .firepower
        case skillTextField: viewModel.itemBeingUpdated = .skill
        case teamTextField: viewModel.itemBeingUpdated = .team
        default: viewModel.itemBeingUpdated = .none
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField {
            viewModel.name = textField.text ?? ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TransformersListDelegate
extension CreateTransformerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == numberPicker {
            return CreateTransformerViewModel.kMaxSpec
        } else if pickerView == teamPicker {
            return Team.kMaxTeam
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == numberPicker {
            viewModel.selected(newValue: row + 1)
        } else if pickerView == teamPicker {
            viewModel.selectedTeam(at: row)
        }
        view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.CBTColors.background
        label.textAlignment = .center

        if pickerView == numberPicker {
            label.text = String(row + 1)
        } else {
            label.text = (row == 0) ? Team.autobot.teamName : Team.decepticon.teamName
        }
        return label
    }
}

// MARK: - Associated keyboard actions
extension CreateTransformerController {
    
    /**
     Adds a gesture recognizer to view
    
     - returns: void
     */
    private func hideKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionHideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    /**
     Hides keyboard when user taps the view
     - returns: void
     */
    @objc private func actionHideKeyboard() {
        self.view.endEditing(true)
    }
    
    /**
     Create notification for KeyboardDidShow and KeyboardWillHide
    
     - returns: void
     */
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
   
    /**
     Deals with selector of keyboardDidShow
     ```
     We get the size of keyboard. It may vary according to the type of the keyboard.
     Then add in the scrollView content insets
     
     ```
     - parameter notification: NSNotification
     - returns: void
     */
    @objc private func keyboardDidShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                         left: scrollView.contentInset.left,
                                         bottom: keyboardSize.height,
                                         right: scrollView.contentInset.right)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    /**
     Deals with selector of keyboardWillHide
     ```
     Add 0 back to scrollView content insets
     
     ```
     - parameter notification: NSNotification
     - returns: void
     */
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,
                                         left: scrollView.contentInset.left,
                                         bottom: 0,
                                         right: scrollView.contentInset.right)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
