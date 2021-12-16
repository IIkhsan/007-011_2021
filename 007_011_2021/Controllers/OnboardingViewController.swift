import UIKit

class OnboardingViewController: UIViewController {
    
    // Private properties
    
    private let pages: [Page] = [Page(animationName: "animation1", title: "Dictionary", description: "An ordered list of words in the English alphabet, as well as their phonetics"),
                                 Page(animationName: "animation2", title: "Find the word you are interested in", description: "In this dictionary you can find the word you are interested in. The list will continue to grow."),
                                 Page(animationName: "animation3", title: "Feature List", description: "In the future, the list of application functionality will grow.")]
    
    // IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private funcs
    
    private func configure() {
        getStartedButton.layer.cornerRadius = 20
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: NibsNames.onboardingNibName, bundle: Bundle.main), forCellWithReuseIdentifier: CellsIdentifiers.onboardingCellId)
        pageControl.numberOfPages = self.pages.count
    }
    
    // MARK: - IBActions
    
    @IBAction func getStartedButtonAction(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifiers.savedWordsViewControllerIdentifier) as? SavedWordsViewController else {
                return
            }
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true, completion: nil)
            OnboardingDisplayService.shared.setIsNotNewUser()
    }
    @IBAction func pageControlAction(_ sender: Any) {
        let pageControl = sender as! UIPageControl
            collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                        at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsIdentifiers.onboardingCellId, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(page: pages[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

