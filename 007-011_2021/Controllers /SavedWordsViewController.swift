//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 24.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchingButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SearchingViewController") as? SearchingViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
