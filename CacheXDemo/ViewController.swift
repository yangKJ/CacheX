//
//  ViewController.swift
//  CacheXDemo
//
//  Created by Condy on 2023/4/3.
//

import UIKit
import CacheX

class ViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let width = self.view.bounds.size.width-40
        let rect = CGRect(x: 20, y: 200, width: width, height: width)
        let imageView = UIImageView(frame: rect)
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: imageView.frame.maxY + 20, width: 200, height: 20)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(imageView)
        self.view.addSubview(label)
        self.setupCacheX()
    }
    
    func setupCacheX() {
        var storage = Storage<CacheModel>()
        
        var model = CacheModel()
        model.named = "Condy_258"
        model.image = UIImage.init(named: "IMG_0020")
        
        storage.storeCached(model, forKey: "key", options: .diskAndMemory)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let model_ = storage.fetchCached(forKey: "key", options: .diskAndMemory)
            self.imageView.image = model_?.image
            self.label.text = model_?.named            
        }
    }
}
