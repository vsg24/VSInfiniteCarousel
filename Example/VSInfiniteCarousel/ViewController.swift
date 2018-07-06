//
//  ViewController.swift
//  VSInfiniteCarousel
//
//  Created by vsg24 on 07/06/2018.
//  Copyright (c) 2018 vsg24. All rights reserved.
//

import UIKit
import VSInfiniteCarousel

class ViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let cardSize: CGFloat = 150;
		
		// A containerView holds an instance of VSInfiniteCarousel
		let containerView = UIView(frame: CGRect(x: 0, y: self.view.frame.height / 3, width: self.view.frame.width, height: cardSize))
		self.view.addSubview(containerView);
		
		// create an array of UIViews to show in the carousel
		var items = [UIView]();
		for n in 1...7 {
			let view = UIImageView();
			view.image = UIImage(named: String(n));
			view.contentMode = .scaleAspectFill;
			view.clipsToBounds = true;
			view.layer.cornerRadius = 4;
			
			items.append(view);
		}
		
		// initialize the carousel, specify the container view and items size, the space between them and the update interval (rate)
		let infiniteCarousel = VSInfiniteCarousel(containerView: containerView, itemFrame: CGRect(x: 0, y: 0, width: cardSize, height: cardSize), inset: 20, updateInterval: 1.5)
		// feed the carousel
		infiniteCarousel.initializeViewsList(viewsList: items);
    }
	
}

