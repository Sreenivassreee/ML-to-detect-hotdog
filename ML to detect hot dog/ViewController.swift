//
//  ViewController.swift
//  ML to detect hot dog
//
//  Created by Sreenivas k on 12/05/21.
//

import UIKit
import Vision
import CoreML


class ViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var imagePicker =  UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        
        
    }
}

