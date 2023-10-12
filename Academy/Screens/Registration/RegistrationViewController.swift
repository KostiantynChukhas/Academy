//
//  RegistrationViewController.swift
//  Academy
//
//  Created by   on 24.04.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var patronymicTextField: UITextField!
    @IBOutlet var numberTextField: PhoneNumberTextField!
    @IBOutlet var birthdayTextField: UITextField!
    @IBOutlet var howDidYouKnowTextField: UITextField!
    @IBOutlet var chekBoxButton: UIButton! {
        didSet{
            chekBoxButton.setImage(UIImage(named:""), for: .normal)
            chekBoxButton.setImage(#imageLiteral(resourceName: "checked"), for: .selected)
        }
    }
    
    var viewModel: RegistrationViewModelType!
    var imagePicker = UIImagePickerController()
    var isCheckboxSelected = false
    var textFieldArray: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldArray = [nameTextField,lastNameTextField,patronymicTextField,numberTextField,birthdayTextField,howDidYouKnowTextField]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImage(tapGestureRecognizer:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGestureRecognizer)
        imagePicker.delegate = self
        
        self.chekBoxButton.layer.borderWidth = 1
        self.chekBoxButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        
        numberTextField.keyboardType = .numberPad
        
        textFieldArray.forEach({ (textField) in
            textField.layer.cornerRadius = Style.Radius.textField
            textField.delegate = self
        })
        
        birthdayTextField.addTarget(self, action: #selector(birthdayTFSelection(_:)), for: .editingDidBegin)
    }
    
    @objc func birthdayTFSelection(_ sender: Any) {
        birthdayTextField.resignFirstResponder()
        //init date picker
        let datePicker = UIDatePicker(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.size.width, height: 200)))
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        //add to actionsheetview
        let alertController = UIAlertController(title: nil, message: nil , preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.view.addSubview(datePicker)//add subview
        
        let cancelAction = UIAlertAction(title: "Done", style: .cancel) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            self.birthdayTextField.text = dateFormatter.string(from: datePicker.date)
        }
        
        //add button to action sheet
        alertController.addAction(cancelAction)
        
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant:300)
        alertController.view.addConstraint(height);
        
        datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: -10).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: alertController.view.bottomAnchor, constant: -70).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: 0).isActive = true
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func tapImage(tapGestureRecognizer: UITapGestureRecognizer) {
        ImagePickerManager().pickImage(self){ image in
            self.avatarImage.image = image
            self.avatarImage.roundAll(radius: self.avatarImage.bounds.size.height / 2)
        }
    }
    
    @IBAction func chekBoxButtonAction(_ sender: UIButton) {
        sender.checkboxAnimation {
            print("I'm done")
            print(sender.isSelected)
            self.isCheckboxSelected = sender.isSelected
        }
    }
    
    @IBAction func detailsButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let firstname = nameTextField.text, firstname.isEmpty != true else {
            AlertHelper.showAlert(msg: "Введіть ім'я")
            return
        }
        
        guard let lastname = lastNameTextField.text, lastname.isEmpty != true else {
            AlertHelper.showAlert(msg: "Введіть прізвище")
            return
        }
        
        guard let middlename = patronymicTextField.text, middlename.isEmpty != true else {
            AlertHelper.showAlert(msg: "Введіть по батькові")
            return
        }
        
        guard let phone = numberTextField.text, phone != "+380" else {
            AlertHelper.showAlert(msg: "Введіть номер телефону")
            return
        }
        
        guard let birthday = birthdayTextField.text, birthday.isEmpty != true else {
            AlertHelper.showAlert(msg: "Введіть дату народження")
            return
        }
        
        guard isCheckboxSelected == true else {
            AlertHelper.showAlert(msg: "Підтвердіть умови політики конфіденційності")
            return
        }
        
        self.viewModel.createUser(firstname: firstname, lastname: lastname, middlename: middlename, phone: phone, birthday: birthday, description: howDidYouKnowTextField.text ?? "") { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let response):
                    self.viewModel.uploadImage(clientId: response.id) { result in
                        switch result {
                            
                        case .success(_):
                            self.viewModel.route(to: .home)
                        case .failure(_): break
                            
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    deinit {
        print("RegistrationViewController - deinit")
    }
}

extension RegistrationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        avatarImage.image = image
        
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
}
