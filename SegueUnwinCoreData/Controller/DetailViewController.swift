//
//  DetailViewController.swift
//  SegueUnwinCoreData
//
//  Created by dohien on 7/16/18.
//  Copyright © 2018 hiền hihi. All rights reserved.
//

import UIKit
import os.log
class DetailViewController: UIViewController , UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var object: Entity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        if let dataObject = object {
            nameTextField.text = dataObject.name
            ageTextField.text = String(dataObject.age)
            photoImage.image = dataObject.image as? UIImage
        }
        // Do any additional setup after loading the view.
        updateSaveButtonSate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        if (nameTextField.text != nil) , (ageTextField.text != nil) , photoImage.image != nil{
            let enity = Entity(context: AppDelegate.context)
            enity.name = nameTextField.text
            enity.age = Int32(ageTextField.text ?? "") ?? 0
            enity.image = photoImage.image
            DataSerVice.shared.saveData()
//            navigationController?.dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        // UIImagePickerController là một bộ điều khiển xem cho phép người dùng chọn phương tiện từ thư viện ảnh của họ
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Loại bỏ bộ chọn nếu người dùng hủy
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage  = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Đặt photoImageView để hiển thị hình ảnh đã chọn.
        photoImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

    // hiện nút save khi có dữ liệu
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonSate()
        // đặt tiêu đề
        navigationItem.title = textField.text
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    // tắt nút lưu nè
    private func  updateSaveButtonSate() {
        let text = nameTextField.text ?? ""
            saveButton.isEnabled = !text.isEmpty
    }
}
