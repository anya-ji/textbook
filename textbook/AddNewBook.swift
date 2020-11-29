//
//  AddNewBook.swift
//  textbook
//
//  Created by Zuhao Hua on 11/29/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import UIKit

class AddNewBook: UIViewController {

    var bookImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        bookImage = UIImageView()
        bookImage.image = UIImage(named: "add_image_icon")
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookImage.contentMode = .scaleAspectFill
        bookImage.layer.cornerRadius = 30
        bookImage.clipsToBounds = true
        bookImage.backgroundColor = .lightGray
        bookImage.isUserInteractionEnabled = true
        view.addSubview(bookImage)
        
        let singleTapImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappingImage(recognizer:)))
        singleTapImage.numberOfTapsRequired = 1
        bookImage.addGestureRecognizer(singleTapImage)
        
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            bookImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bookImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bookImage.heightAnchor.constraint(equalToConstant: view.frame.height*0.3)
        ])
        
    }
    
    @objc func tappingImage(recognizer: UIGestureRecognizer){
        //image tapped
        showChooseSourceTypeAlertController()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddNewBook:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    // we need UINavigationControllerDelegate because we need to present a new view
    
    func showChooseSourceTypeAlertController() {
        
        let photoLibraryAction = UIAlertAction(title: "Choose A Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Take A New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showImagePickerController(sourceType:UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        
        present(imagePickerController,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            bookImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
