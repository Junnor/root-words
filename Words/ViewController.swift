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
        
        title = "词根(\(rootWords.count))"
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
        alert.addTextField { _ in
        }
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
            UserDefaults.standard.set(self.attentionList.joined(separator: indexJoin), forKey: attentionIndex)
            print(self.attentionList)
        }
    }
    
    private func fetchAttentionList() {
        if let all = UserDefaults.standard.string(forKey: attentionIndex), !all.isEmpty {
            var data = all.components(separatedBy: indexJoin)
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
        cell.textLabel?.text = rootWords[indexPath.item]
        if attentionList.contains(String(indexPath.item)) {
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .white
        }
        cell.textLabel?.font = .systemFont(ofSize: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        func addToList() {
            let alert = UIAlertController(title: "添加到加深列表里", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "添加", style: .default) { [weak self] action in
                guard let self = self else { return }

                self.attentionList.append(String(indexPath.item))
                self.attentionList.sort()
                
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
private let attentionIndex = "forgetIndexs"
private let indexJoin = ","


