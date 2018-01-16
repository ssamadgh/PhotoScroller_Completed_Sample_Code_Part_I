//
//  ViewController.swift
//  PhotoScroller
//
//  Created by Seyed Samad Gholamzadeh on 1/14/18.
//  Copyright © 2018 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var imageScrollView: ImageScrollView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		//1. Initialize imageScrollView and adding it to viewControllers view
		self.imageScrollView = ImageScrollView(frame: self.view.bounds)
		self.view.addSubview(self.imageScrollView)
		self.layoutImageScrollView()
		
		//2. Making an image from our photo path
		let imagePath = Bundle.main.path(forResource: "225H", ofType: "jpg")!
		let image = UIImage(contentsOfFile: imagePath)!
		
		//3. Ask imageScrollView to show image
		self.imageScrollView.display(image)

	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		self.restoreStatesForRotation(in: size)
	}
	
	
	func restoreStatesForRotation(in bounds: CGRect) {
		// recalculate contentSize based on current orientation
		let restorePoint = imageScrollView.pointToCenterAfterRotation()
		let restoreScale = imageScrollView.scaleToRestoreAfterRotation()
		imageScrollView.frame = bounds
		imageScrollView.setMaxMinZoomScaleForCurrentBounds()
		imageScrollView.restoreCenterPoint(to: restorePoint, oldScale: restoreScale)
	}
	
	func restoreStatesForRotation(in size: CGSize) {
		var bounds = self.view.bounds
		if bounds.size != size {
			bounds.size = size
			self.restoreStatesForRotation(in: bounds)
		}
	}

	
	func layoutImageScrollView() {
		self.imageScrollView.translatesAutoresizingMaskIntoConstraints = false
		
		let top = NSLayoutConstraint(item: self.imageScrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
		let left = NSLayoutConstraint(item: self.imageScrollView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)
		
		let bottom = NSLayoutConstraint(item: self.imageScrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
		let right = NSLayoutConstraint(item: self.imageScrollView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)
		
		self.view.addConstraints([top, left, bottom, right])
	}


}

