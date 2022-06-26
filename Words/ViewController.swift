//
//  ViewController.swift
//  Words
//
//  Created by ys on 2022/6/23.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    
    private lazy var collectionView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
        
    private lazy var rootWords: [String] = {
        let items = sourceRootWords.map { $0.components(separatedBy: "\"")[1] }
        return items
    }()
    
    private let localRealm = try! Realm()

    private lazy var lastWord = localRealm.objects(LastWord.self)
    
    private lazy var redList = localRealm.objects(WordIndex.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        print(rootWords.count)

        view.addSubview(collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let w = UIScreen.main.bounds.width
        
        let beginY: CGFloat = 100
        var x: CGFloat = 0
        var y: CGFloat = beginY
        let countInLines: CGFloat = 3
        
        
        let itemW = w/countInLines
        let itemH: CGFloat = 83
        
        var items: [UIScrollView] = []
        
        for _ in 0...11 {
            let s = UIScrollView()
            s.backgroundColor = .white
            s.frame = CGRect(x: 0, y: 0, width: w, height: itemH*16+beginY)
            view.addSubview(s)
            items.append(s)
        }
        
        for i in 1...rootWords.count {
            let cell = WordCell(frame: CGRect(x: x, y: y, width: itemW, height: itemH))
            cell.titleLabel.text = rootWords[i-1]
            cell.indexLabel.text = "\(i)"
                        
            items[(i-1)/48].addSubview(cell)

            x += itemW
            if i % 48 == 0 {
                // new page
                y = beginY
                x = 0
            } else {
                if i % Int(countInLines) == 0 {
                    y += itemH
                    x = 0
                }
            }
        }
//        collectionView.backgroundColor = .white
//        collectionView.isScrollEnabled = true
//        collectionView.contentSize = CGSize(width: w, height: y+200)

        print(y+200)
//        collectionView.frame = view.bounds
//        collectionView.frame = CGRect(x: 0, y: 0, width: w, height: y+200)
        items.forEach({ ImageSaver().writeToPhotoAlbum(image: $0.asImage()) })
        
    }
    
}


class WordCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(titleLabel)
        addSubview(indexLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        indexLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indexLabel.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
}


extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

