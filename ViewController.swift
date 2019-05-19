//
//  ViewController.swift
//  MyCamera
//
//  Created by STARBOARD on 2019/05/18.
//  Copyright © 2019年 omokaji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var pictureImgae: UIImageView!

    
    @IBAction func cameraButtonAction(_ sender: Any) {
        // カメラかフォトライブラリーのどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
                // カメラを定義
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        // フォトライブラリーを起動するための選択肢を定義
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (action:UIAlertAction) in
                // フォトライブラリーを定義
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
            
        // キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        // iPadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        
        // 選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
    }
    
    // 撮影が終わっと時に呼ばれるdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        // 撮影した写真を、配置したcaptureImageに渡す
        captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        // モーダルビューを閉じる
        dismiss(animated: true, completion: {
            // エフェクト画面に遷移
            self.performSegue(withIdentifier: "showEffectView", sender: nil)
        })
    }
    
    // 次の画面遷移をするときに渡す画像を格納する場所
    var captureImage : UIImage?
    
    // segueを使って画面遷移時に実行されるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面のインスタンスを格納
        if let nextViewController = segue.destination as? EffectViewController {
            // 次の画面のインスタンスに取得した画像を渡す
            nextViewController.originalImage = captureImage
        }
    }
    
}
