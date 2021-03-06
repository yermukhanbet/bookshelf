//
//  AddBook.swift
//  books
//
//  Created by Yessen Yermukhanbet on 4/24/20.
//  Copyright © 2020 Yessen Yermukhanbet. All rights reserved.
//

import Foundation
import UIKit

class Book {
    var nameOfBook: String?
    var nameOfAuthor: String?
    var datePublished: String?
    var information: String?
    var hasFavoured: Bool?
  }
var books = [Book]()
class AddBook: UIViewController, UITextFieldDelegate{
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.darkText, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveButtonAction), for: UIControl.Event.touchUpInside)
        button.isEnabled = false
        return button
    }()
    //Text field for Book name
    let txtBookName: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10.0, y: 100.0, width: UIScreen.main.bounds.size.width - 20.0, height: 50.0))
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter the name of the Book"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: UIControl.Event.editingChanged)
        textField.resignFirstResponder()
        return textField
    }()
    //Text field for Book Author
    let txtBookAuthor: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10.0, y: 180.0, width: UIScreen.main.bounds.size.width - 20.0, height: 50.0))
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))   //padding view from the left side of text field
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        textField.keyboardAppearance = .dark
        textField.placeholder = "Enter the author of the Book"
        textField.font = UIFont.systemFont(ofSize: 15.0)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: UIControl.Event.editingChanged)
        textField.resignFirstResponder()
        return textField
    }()
    override func viewDidLoad() {
        view.backgroundColor = UIColor.darkGray
        configureTextFields()
        configureTapGesture()
        view.addSubview(txtBookName)
        view.addSubview(txtBookAuthor)
        view.addSubview(saveButton)
        setLayoutOfButton(for: saveButton, fromY: txtBookAuthor.bottomAnchor, Y: 50, Width: 150, Height: 50)
        //saveButton.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text!)
        saveButton.isEnabled = true
    }
    func saveArrayFromListViewController(booksFromListView: [Book]){
       books = booksFromListView
    }
    //MARK: save button action
    @objc func saveButtonAction() {
        let newBook = Book()
        newBook.nameOfBook = txtBookName.text!
        newBook.nameOfAuthor = txtBookAuthor.text!
        newBook.hasFavoured = false
        view.endEditing(true)//hide keyboard
        books.append(newBook)
        let list = tableView()
        let navCOntroller = UINavigationController(rootViewController: list)
        present(navCOntroller, animated: true, completion: nil)
    }
    func configureTextFields(){
        txtBookName.delegate = self
        txtBookAuthor.delegate = self
    }
    func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddBook.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtBookAuthor.resignFirstResponder()
        txtBookName.resignFirstResponder()
        saveButton.isEnabled = true
        return true
    }
    private func setLayoutOfButton(for button: UIButton, fromY: NSLayoutAnchor<NSLayoutYAxisAnchor>,  Y:CGFloat,Width:CGFloat, Height:CGFloat) {
        button.topAnchor.constraint(equalTo: fromY, constant: Y).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: Width).isActive = true
        button.heightAnchor.constraint(equalToConstant: Height).isActive = true
    }
}
