//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 24.11.2021.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
  // MARK: - UI
  private lazy var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.currentPageIndicatorTintColor = .black
    pageControl.pageIndicatorTintColor = .systemGray
    pageControl.numberOfPages = pages.count
    pageControl.currentPage = initialPageIndex
    return pageControl
  }()
  
  private lazy var skipButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitle("Пропустить", for: .normal)
    return button
  }()
  
  private lazy var nextPageButton: UIButton = {
    let button = UIButton()
    button.setTitle("Дальше", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    return button
  }()
  
  // MARK: - Properties
  private var pages: [UIViewController] = []
  private let initialPageIndex = 0
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addControllers()
    configure()
    addSubviews()
    setConstraints()
  }
  
  // MARK: - Private
  private func configure() {
    dataSource = self
    delegate = self
    
    pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
    nextPageButton.addTarget(self, action: #selector(nextPageButtonTapped), for: .touchUpInside)
  }
  
  private func addSubviews() {
    view.addSubview(skipButton)
    view.addSubview(nextPageButton)
    view.addSubview(pageControl)
  }
  
  private func setConstraints() {
    skipButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
      make.leading.equalToSuperview().inset(5)
    }
    nextPageButton.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(5)
      make.trailing.equalToSuperview().inset(5)
    }
    pageControl.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(5)
    }
  }
  
  private func addControllers() {
    pages.append(OnboardingViewController(image: UIImage(named: "wordSearch"), titleText: "Поиск", description: "Чтобы найти нужное слово, сначала нажмите на лупу в правом верхнем углу на главной странице, дальше введите слово и нажмите Search или Enter"))
    pages.append(OnboardingViewController(image: UIImage(named: "wordSave"), titleText: "Сохранить", description: "Чтобы сохранить слово - свайпните его влево"))
    pages.append(OnboardingViewController(image: UIImage(named: "wordDelete"), titleText: "Удалить", description: "Чтобы удалить слово из списка - свайпните его влево"))
    setViewControllers([pages[initialPageIndex]], direction: .forward, animated: true, completion: nil)
  }
  
  // Objc
  @objc private func pageControlTapped(_ sender: UIPageControl) {
    setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
  }
  
  @objc private func skipButtonTapped() {
    let homeViewController = UINavigationController(rootViewController: SavedWordsViewController())
    homeViewController.modalPresentationStyle = .fullScreen
    present(homeViewController, animated: true, completion: nil)
  }
  
  @objc private func nextPageButtonTapped() {
    guard let currentPage = viewControllers?[0],
          let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage),
          let currentIndex = pages.firstIndex(of: nextPage) else { return }
    pageControl.currentPage = pageControl.currentPage < currentIndex ? pageControl.currentPage + 1 : 0
    setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
  }
}

// MARK: - UIPageViewControllerDelegate & UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
    if currentIndex == 0 {
      return pages.last
    } else {
      return pages[currentIndex - 1]
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
    if currentIndex < pages.count - 1 {
      return pages[currentIndex + 1]
    } else {
      return pages.first
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    guard let viewControllers = pageViewController.viewControllers, let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
    pageControl.currentPage = currentIndex
  }
}
