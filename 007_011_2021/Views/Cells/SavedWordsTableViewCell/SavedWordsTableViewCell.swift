import UIKit

class SavedWordsTableViewCell: UITableViewCell {
    
    // Private properties
    
    private var word: Word?
    
    // IBOutlets
    
    @IBOutlet weak var savedWordTitleLabel: UILabel!
    @IBOutlet weak var savedWordPhoneticsLabel: UILabel!
    
    // MARK: - Public funcs
    
    public func configureCell(with model: Word) {
        word = model
        savedWordTitleLabel.text = model.title
        savedWordPhoneticsLabel.text = model.phonetics?.first?.text
    }
}
