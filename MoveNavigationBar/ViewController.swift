//
//  ViewController.swift
//  MoveNavigationBar
//
//  Created by Vera on 22/12/1939 Saka.
//  Copyright © 1939 Vera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressVC: UIProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    var pickedImageArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.delegate = self
      self.collectionView.dataSource = self
        self.progressVC.progress = 100
        self.progressVC.isHidden = true
    }

    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.pickedImageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cameraCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cameraCVC", for: indexPath) as! cameraCVC
        cameraCell.cellImage.image = self.pickedImageArray[indexPath.row]
        
        return cameraCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfColoms:CGFloat = 2
//        let width:CGFloat = self.collectionView.frame.size.width
//        let xInsets:CGFloat = 10
//        let cellSpacing:CGFloat = 5
//
//        return CGSize(width: (width / numberOfColoms) - (xInsets + cellSpacing), height: (width / numberOfColoms) - (xInsets + cellSpacing))
        return CGSize(width: self.collectionView.frame.size.width/2 - 1, height: self.collectionView.frame.size.width/2 - 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
       return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
       return 1.0
    }

    
}
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.contentMode = .ScaleAspectFit
//            imageView.image = pickedImage
            self.progressVC.progress = 0.0
            let data:NSData = UIImagePNGRepresentation(pickedImage)! as NSData
            
            
            self.progressVC.progress = Float(CGFloat(data.length))
            print((data.length/1024)/1024)
            let length = (data.length/1024/1024)
            print(length)
            print(self.progressVC.progress)
            
        
            
            self.pickedImageArray.append(pickedImage)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)

    }
}

