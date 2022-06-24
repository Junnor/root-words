//
//  ViewController.swift
//  Words
//
//  Created by ys on 2022/6/23.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Root (\(rootWords.count))"
        tableView.rowHeight = 50
        
        updateNaviItem()
        
        fetchAttentionList()
    }
    
    private func updateNaviItem() {
        let record = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addRecord))

        if let last = UserDefaults.standard.value(forKey: recordKey) as? String, !last.isEmpty {
            let jump = UIBarButtonItem(title: last, style: .done, target: self, action: #selector(jump))
            navigationItem.rightBarButtonItems = [record, jump]
        } else {
            navigationItem.rightBarButtonItem = record
        }
    }
    
    @objc private func addRecord() {
        let alert = UIAlertController(title: "添加最新纪录", message: nil, preferredStyle: .alert)
        alert.addTextField { _ in }
        let ok = UIAlertAction(title: "保存", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                UserDefaults.standard.set(text, forKey: recordKey)
                self.updateNaviItem()
            } else {

            }
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc private func jump() {
        if let last = UserDefaults.standard.string(forKey: recordKey),
            let index = rootWords.firstIndex(where: { $0 == last }) {
            tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
        }
    }
    

    private lazy var rootWords: [String] = {
        let items = wordsRoot.map { $0.components(separatedBy: "\"")[1] }
        return items
    }()
    
    private var attentionList: [String] = [] {
        didSet {
            print("list = \(attentionList)")
            if attentionList.isEmpty {
                UserDefaults.standard.set(nil, forKey: listIndex)
                print("save clean")
            } else {
                let save = attentionList.joined(separator: joinMark)
                print("save = \(save)")
                UserDefaults.standard.set(save, forKey: listIndex)
            }
        }
    }
    
    private func fetchAttentionList() {
        let cache = UserDefaults.standard.string(forKey: listIndex)
        print("cache indexs: \(String(describing: cache))")
        if let all = cache, !all.isEmpty {
            var data = all.components(separatedBy: joinMark)
            data.sort()
            attentionList = data
        }
    }
        
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rootWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? WordCell {
            cell.titleLabel.text = rootWords[indexPath.item]
            cell.titleLabel.textColor = attentionList.contains(String(indexPath.item)) ? .red : .white

            cell.indexLabel.text = "\(indexPath.item+1)"
            cell.indexLabel.textColor = .gray
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        func addToList() {
            let alert = UIAlertController(title: "添加到加深列表里", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "添加", style: .default) { [weak self] action in
                guard let self = self else { return }
                
                var data = self.attentionList
                data.append(String(indexPath.item))
                data.sort()
                
                self.attentionList = data
                
                tableView.reloadData()
            }
            let cancel = UIAlertAction(title: "取消", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true)
        }
        if !attentionList.isEmpty {
            if let inRecord = attentionList.firstIndex(where: { $0 == String(indexPath.item) }) {
                let alert = UIAlertController(title: "从加深列表里移除", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "移除", style: .default) { [weak self] action in
                    guard let self = self else { return }
                    
                    self.attentionList.remove(at: inRecord)
                    tableView.reloadData()
                }
                let cancel = UIAlertAction(title: "取消", style: .cancel)
                alert.addAction(ok)
                alert.addAction(cancel)
                present(alert, animated: true)
            } else {
                addToList()
            }
        } else {
            addToList()
        }

    }
    
}


private let recordKey = "lastWords"
private let listIndex = "forgetIndexs"
private let joinMark = ","


class WordCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

}
