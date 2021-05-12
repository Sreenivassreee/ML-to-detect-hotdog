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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        if var image =  info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            ImageView.image = image
            
            guard let ciImage = CIImage(image: image) else {
                      fatalError("couldn't convert uiimage to CIImage")
                  }
            detect(image: ciImage)
        }
        
        
        
    }
    

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var statusLable: UILabel!
    
         
    func detect(image: CIImage) {
         
         // Load the ML model through its generated class
         guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
             fatalError("can't load ML model")
         }
         
         let request = VNCoreMLRequest(model: model) { request, error in
             guard let results = request.results as? [VNClassificationObservation],
                 let topResult = results.first
                 else {
                     fatalError("unexpected result type from VNCoreMLRequest")
             }
             
             if topResult.identifier.contains("hotdog") {
                 DispatchQueue.main.async {
                    self.statusLable.text="HotDog"
                    self.statusLable.textColor = .green
                   
                 }
             }
             else {
                 DispatchQueue.main.async {
                    self.statusLable.text="Not HotDog"
                    self.statusLable.textColor = .red
                     
                 }
             }
         }
         
         let handler = VNImageRequestHandler(ciImage: image)
         
         do {
             try handler.perform([request])
         }
         catch {
             print(error)
         }
     }
     
}

