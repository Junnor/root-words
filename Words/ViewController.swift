//
//  ViewController.swift
//  Words
//
//  Created by ys on 2022/6/23.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var rootWords: [String] = {
        let items = wordsRoot.map { $0.components(separatedBy: "\"")[1] }
        return items
    }()
    
    private let localRealm = try! Realm()

    private lazy var lastWord = localRealm.objects(LastWord.self)
    
    private lazy var redList = localRealm.objects(WordIndex.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Root (\(rootWords.count))"
        tableView.rowHeight = 50
        
        updateNaviItem()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rootWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? WordCell {
            let word = rootWords[indexPath.item]
            cell.titleLabel.text = word
            
            var contain = false
            if let _ = redList.first(where: { $0.index == indexPath.item }) {
                contain = true
            }
            
            if contain {
                cell.titleLabel.textColor = .red
            } else {
                if lastWord.last?.name == word {
                    cell.titleLabel.textColor = .systemBlue
                } else {
                    cell.titleLabel.textColor = .white
                }
            }
            
            cell.indexLabel.text = "\(indexPath.item+1)"
            cell.indexLabel.textColor = .gray
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        func showAlertWith(_ ok: UIAlertAction) {
            let alert = UIAlertController(title: "加油狗头", message: nil, preferredStyle: .actionSheet)
            
            let readDot = UIAlertAction(title: "阅读点", style: .default) { [weak self] action in
                guard let self = self else { return }
                
                try! self.localRealm.write({
                    if self.lastWord.isEmpty {
                        self.localRealm.add(LastWord(name: self.rootWords[indexPath.item]))
                    } else {
                        self.lastWord.last?.name = self.rootWords[indexPath.item]
                    }
                })
                self.updateNaviItem()
            }
            
            let cancel = UIAlertAction(title: "取消", style: .destructive)
            alert.addAction(ok)
            alert.addAction(readDot)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        
        if let toDelete = redList.first(where: { $0.index == indexPath.item }) {
            let ok = UIAlertAction(title: "遗忘表 -", style: .default) { [weak self] action in
                guard let self = self else { return }
                
                try! self.localRealm.write({
                    self.localRealm.delete(toDelete)
                })
                tableView.reloadData()
            }
            showAlertWith(ok)
        } else {
            let ok = UIAlertAction(title: "遗忘表 +", style: .default) { [weak self] action in
                guard let self = self else { return }
                
                try! self.localRealm.write({
                    self.localRealm.add(WordIndex(index: indexPath.item))
                })
                
                tableView.reloadData()
            }
            showAlertWith(ok)
        }
    }
    
}


extension ViewController {
    
    private func updateNaviItem() {
        if let last = lastWord.last {
            let jump = UIBarButtonItem(title: last.name, style: .done, target: self, action: #selector(jump))
            navigationItem.rightBarButtonItems = [jump]
        }
    }
    
    @objc private func jump() {
        if let last = lastWord.last,
           let index = rootWords.firstIndex(where: { $0 == last.name }) {
            tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
        }
    }
    
}


class WordCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}
