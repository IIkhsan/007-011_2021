import UIKit
import Lottie

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    // Private properties
    
    private var animation = AnimationView()
    
    // IBOutlets
    
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Public funcs
    
    public func configureCell(page: Page) {
        animation = AnimationView(name: page.animationName)
        animation.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height * 0.8)
        animation.animationSpeed = 1
        animation.loopMode = .loop
        animation.play()
        animationContainer.addSubview(animation)
        self.titleLabel.text = page.title
        self.descriptionTextView.text = page.description
    }
}
