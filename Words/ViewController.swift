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
        
        title = "3000"
        
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
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section][indexPath.item]
        cell.textLabel?.font = .systemFont(ofSize: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let _ = sections[section].first {
            return alphas[section] + " (\(sections[section].count)) "
        }
        return nil
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return alphas
    }
    
    
}










