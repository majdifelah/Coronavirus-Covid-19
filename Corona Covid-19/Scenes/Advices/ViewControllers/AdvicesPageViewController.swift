//
//  AdvicesPageViewController.swift
//  Corona Covid-19
//
//  Created by Majdi EL Felah on 20/05/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class AdvicesPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVC(viewController:"adviceOne"),
        self.newVC(viewController:"adviceTwo"),
        self.newVC(viewController:"adviceThree")
        ]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
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

extension AdvicesPageViewController {
    
    func newVC(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}
