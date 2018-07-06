//
//  VSInfiniteCarousel.swift
//  Pods-VSInfiniteCarousel_Example
//
//  Created by Vahid Amiri Motlagh on 7/6/18.
//

import Foundation
import UIKit

public class VSInfiniteCarousel {
	// it has to be a weak reference to avoid memory leaks!
	weak var containerView: UIView?;
	let itemFrame: CGRect;
	let inset: CGFloat;
	let updateInterval: TimeInterval;
	private var _effectiveMovement: CGFloat = 0;
	var effectiveMovement: CGFloat {
		return _effectiveMovement;
	};
	
	var timer: Timer?;
	
	var items = [UIView]();
	
	public init(containerView: UIView, itemFrame: CGRect, inset: CGFloat, updateInterval: TimeInterval) {
		self.containerView = containerView;
		self.itemFrame = itemFrame;
		self.inset = inset;
		self.updateInterval = updateInterval;
	}
	
	public func initializeViewsList(viewsList: [UIView]) {
		var lastItemX = self.containerView?.frame.maxX;
		for view in viewsList {
			view.frame = self.itemFrame;
			view.frame.origin.x = lastItemX!;
			// TODO: Also apply inset to width and height
			view.frame.origin.y = self.inset / 2;
			
			items.append(view);
			self.containerView?.addSubview(view);
			
			lastItemX = lastItemX! - self.itemFrame.width - self.inset;
		}
		
		self.timer = Timer.scheduledTimer(timeInterval: self.updateInterval, target: self, selector: #selector(self.updateCarousel), userInfo: nil, repeats: true);
	}
	
	@objc
	func updateCarousel() {
		self._effectiveMovement = self.itemFrame.width * CGFloat(1/self.updateInterval);
		for (i, n) in self.items.enumerated() {
			
			if(self.containerView == nil) {
				self.timer?.invalidate();
				self.timer = nil;
				return;
			}
			
			if(n.frame.maxX + self.itemFrame.width >= (self.containerView?.frame.minX)! && n.isHidden) {
				// about to show
				n.isHidden = false;
			}
			
			UIView.animate(withDuration: self.updateInterval, delay: 0, options: [.curveLinear], animations: {
				n.frame.origin.x = n.frame.origin.x + self.effectiveMovement;
				return;
			});
			
			if(n.frame.minX > (self.containerView?.frame.maxX)! + self.itemFrame.width) {
				n.isHidden = true;
				n.frame.origin.x = (self.items.last?.frame.minX)! - self.itemFrame.width - (self.inset - self.effectiveMovement);
				self.items.remove(at: i);
				self.items.append(n);
			}
		}
	}
	
	deinit {
		self.timer?.invalidate();
	}
	
}
