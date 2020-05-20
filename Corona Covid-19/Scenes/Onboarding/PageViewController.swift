//
//  PageViewController.swift
//  Corona Covid-19
//
//  Created by Majdi EL Felah on 20/05/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController:"screenOne"),
        self.newVC(viewController:"screenTwo")
        ]
        
    }()
    
    var pageControl = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let onBoarding = UserDefaults.standard.object(forKey: "onBoarding") as? Bool, onBoarding {
            // MARK: - Go to TabBar
        
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
            else {
              return
            }
            sceneDelegate.applicationLaunching(withVC: 0)

        } else {
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
                configurePageControl()
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let pageContentViewController = pageViewController.viewControllers?.first else {return}
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard orderedViewControllers.count > previousIndex else { return nil}
        
        return orderedViewControllers[previousIndex]
       }
       
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {return nil}
           let nextIndex = viewControllerIndex + 1
           guard nextIndex >= 0 else {return nil}
           guard orderedViewControllers.count > nextIndex else { return nil}
           
           return orderedViewControllers[nextIndex]
       }
}

extension PageViewController {
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY -  50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
    }
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}
