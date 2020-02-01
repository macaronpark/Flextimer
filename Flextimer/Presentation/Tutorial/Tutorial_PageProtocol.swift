//
//  Tutorial_Page.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/01.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension TutorialPageViewController: UIPageViewControllerDelegate {
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
    ) { // set the pageControl.currentPage to the index of the current viewController in pages
    if let viewControllers = pageViewController.viewControllers {
      if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
        self.pageControl.currentPage = viewControllerIndex
        
        let vc = viewControllers[0] as! TutorialContentViewController

        self.skipButton.isHidden = vc.viewModel.isLast
        self.startButton.isUserInteractionEnabled = vc.viewModel.isLast

          UIView.animate(withDuration: 0.3) {
            self.startButton.alpha = vc.viewModel.isLast ? 1: 0
          }
      }
    }
  }
}

extension TutorialPageViewController: UIPageViewControllerDataSource {

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
      if viewControllerIndex != 0 {
        return self.pages[viewControllerIndex - 1]
      }
//      else { // 페이지 루프
//        return self.pages[self.pages.count - 1]
//      }
    }
    return nil
  }
  
  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
      if viewControllerIndex < self.pages.count - 1 {
        return self.pages[viewControllerIndex + 1]
      }
//      else { // 페이지 루프
//        return self.pages.first
//      }
    }
    return nil
  }
}
