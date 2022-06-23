//
//  ViewController.swift
//  Words
//
//  Created by ys on 2022/6/23.
//

import UIKit

enum WordsType {
    case words3000
    case wordsRoot
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var contentType: WordsType = .wordsRoot {
        didSet {
            title = contentType == .wordsRoot ? "Root(\(rootWords.count))" : "3000"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentType = .wordsRoot
        
        tableView.rowHeight = 50
    }
    
    private lazy var sections: [[String]] = {
        var results: [[String]] = []
        for i in alphas {
            results.append(words3000.filter({ $0.hasPrefix(i) }))
        }
        return results
    }()
    private let alphas = "a b c d e f g h i j k l m n o p q r s t u v w x y z".components(separatedBy: " ")

    
    private lazy var rootWords: [String] = {
        let items = wordsRoot.map { $0.components(separatedBy: "\"")[1] }
        return items
    }()
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch contentType {
        case .wordsRoot:
            return 1
        case .words3000:
            return sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contentType {
        case .wordsRoot:
            return rootWords.count
        case .words3000:
            return sections[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch contentType {
        case .wordsRoot:
            cell.textLabel?.text = rootWords[indexPath.item]
        case .words3000:
            cell.textLabel?.text = sections[indexPath.section][indexPath.item]
        }
        cell.textLabel?.font = .systemFont(ofSize: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch contentType {
        case .wordsRoot:
            return nil
        case .words3000:
            if let _ = sections[section].first {
                return alphas[section] + " (\(sections[section].count)) "
            }
            return nil
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        switch contentType {
        case .wordsRoot:
            return nil
        case .words3000:
            return alphas
        }
    }
    
    
}










