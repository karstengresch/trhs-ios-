//
//  PageController.swift
//  InteractiveStory
//
//  Created by Karsten Gresch on 15.03.17.
//  Copyright © 2017 Closure One. All rights reserved.
//

import UIKit

extension Story {

}


class PageController: UIViewController {
  
  var page: Page?
  
  // MARK: User Interface Properties
  let artworkView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  let storyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    return label
  }()
  
  let firstChoiceButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  
  }()

  
  let secondChoiceButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
    
  }()
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  init(xPage: Page) {
    page = xPage
    super.init(nibName: nil, bundle: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    if let page = page {
      artworkView.image = page.story.artwork
      
      let attributedString = NSMutableAttributedString(string: page.story.text)
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.lineSpacing = 10
      
      attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
      
      storyLabel.attributedText = attributedString
      
      if let firstChoice = page.firstChoice {
        firstChoiceButton.setTitle(firstChoice.title, for: .normal)
        firstChoiceButton.addTarget(self, action: #selector(PageController.loadFirstChoice), for: .touchUpInside)
        
      } else {
        firstChoiceButton.setTitle("Play again!", for: .normal)
        firstChoiceButton.addTarget(self, action: #selector(PageController.playAgain), for: .touchUpInside)
        
      }
    }
    
    if let secondChoice = page?.secondChoice {
      secondChoiceButton.setTitle(secondChoice.title, for: .normal)
      secondChoiceButton.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
      
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    view.addSubview(artworkView)
    
    NSLayoutConstraint.activate([
      artworkView.topAnchor.constraint(equalTo: view.topAnchor),
      artworkView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      artworkView.rightAnchor.constraint(equalTo: view.rightAnchor),
      artworkView.leftAnchor.constraint(equalTo: view.leftAnchor)
      
      ])
    
    view.addSubview(storyLabel)

    NSLayoutConstraint.activate([
      storyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
      storyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
      storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.0)
      ])
    
    view.addSubview(firstChoiceButton)
    firstChoiceButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      firstChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      firstChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0)
      ])
    
    view.addSubview(secondChoiceButton)
    secondChoiceButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      secondChoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      secondChoiceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32.0)
      
      ])
  }
  
  func loadFirstChoice() {
    if let page = page, let firstChoice = page.firstChoice {
      let nextPage = firstChoice.page
      let pageController = PageController(xPage: nextPage)
      
      navigationController?.pushViewController(pageController, animated: true)
      
    }
  }
  
  func loadSecondChoice() {
    if let page = page, let secondChoice = page.secondChoice {
      let nextPage = secondChoice.page
      let pageController = PageController(xPage: nextPage)
      
      navigationController?.pushViewController(pageController, animated: true)
      
    }
  }
  
  func playAgain() {
    navigationController?.popToRootViewController(animated: true)
    
  }
  
}
