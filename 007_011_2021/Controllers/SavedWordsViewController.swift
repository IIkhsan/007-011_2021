import UIKit

class SavedWordsViewController: UIViewController, UISearchBarDelegate {
    
    // Private properties
    
    private var words = [Word]()
    
    // IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewWordButton: UIButton!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewWordButton.layer.cornerRadius = 20
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: NibsNames.savedWordsNibName, bundle: Bundle.main), forCellReuseIdentifier: CellsIdentifiers.savedWordsCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        words = PersistableService.shared.getWords()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        if OnboardingDisplayService.shared.isNewUser() {
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.onboardingViewControllerIdentifier) as? OnboardingViewController else {
                return
            }
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: false, completion: nil)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func addNewWordButtonTaped(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.searchWordsViewControllerIdentifier) as? SearchWordsViewController else {
            return
        }
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SavedWordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.savedWordsCellId, for: indexPath) as? SavedWordsTableViewCell else {
            return UITableViewCell()
        }
        let model = words[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavedWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistableService.shared.deleteWord(word: words[indexPath.row])
            words = PersistableService.shared.getWords()
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
