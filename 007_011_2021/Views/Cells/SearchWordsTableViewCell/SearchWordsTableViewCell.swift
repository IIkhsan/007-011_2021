import UIKit

class SearchWordsTableViewCell: UITableViewCell {
    
    // Private properties
    
    private var word: Word?
    
    // IBOutlets
    
    @IBOutlet weak var searchWordTitleLabel: UILabel!
    @IBOutlet weak var searchWordPhoneticsLabel: UILabel!
    @IBOutlet weak var addWordFromSearchButton: UIButton!
    
    // MARK: - Public funcs
    
    public func configureCell(model: Word) {
        word = model
        searchWordTitleLabel.text = model.title
        searchWordPhoneticsLabel.text = model.phonetics?.first?.text ?? ""
        guard let word = word else { return }
        if PersistableService.shared.isContainsWord(word: word) {
            addWordFromSearchButton.isHidden = true
        }
    }
    
    // MARK: - IBAction funcs
    
    @IBAction func addWordFromSearchAction(_ sender: Any) {
        guard let word = word else { return }
        if !addWordFromSearchButton.isHidden {
            PersistableService.shared.saveWord(word: word)
            addWordFromSearchButton.isHidden = true
        }
    }
}
