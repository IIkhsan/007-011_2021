import UIKit

class SearchWordsViewController: UIViewController {
    
    // Private properties
    
    private var words: [Word] = []
    
    // IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibsNames.searchWordsNibName, bundle: Bundle.main), forCellReuseIdentifier: CellsIdentifiers.searchWordsCellId)
        searchBar.delegate = self
    }
}

// MARK: - UITableViewDelegate

extension SearchWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SearchWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.searchWordsCellId, for: indexPath) as? SearchWordsTableViewCell else {
            return UITableViewCell()
        }
        let model = words[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchWordsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {
            return
        }
        NetworkService.shared.getItems(word: searchBarText) { [weak self] (result) in
            switch result {
            case .success(let words):
                self?.words = words
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        searchBar.resignFirstResponder()
    }
}
