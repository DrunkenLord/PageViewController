//
//  PageVC.swift
//  PageViewController
//
//  Created by Mehul  Singhal  on 16/04/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import UIKit
import Foundation

class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "FirstVC"), self.VCInstance(name: "SecondVC"), self.VCInstance(name: "ThirdVC")]
    }()
    
    private func VCInstance(name: String) -> UIViewController{
       
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let FirstVC = VCArr.first{
            setViewControllers([FirstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }else if view is UIPageViewController{
                view.backgroundColor = UIColor.clear
            }
        }
    }
    

    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = VCArr.index(of: viewController) else{
            
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else{
            return VCArr.last
        }
        guard VCArr.count > previousIndex else{
            return nil
        }
        
        return VCArr[previousIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = VCArr.index(of: viewController) else{
            
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else{
            return VCArr.first
        }
        guard VCArr.count > nextIndex else{
            return nil
        }
        
        return VCArr[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int // The number of items reflected {
    {
            return VCArr.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int // The selected item reflected in
    {
        guard let firstViewController = viewControllers?.first ,
            let firstViewControllerIndex = VCArr.index(of: firstViewController) else {
            return 0
        }
        
        return firstViewControllerIndex
        
    }
    
    
}
