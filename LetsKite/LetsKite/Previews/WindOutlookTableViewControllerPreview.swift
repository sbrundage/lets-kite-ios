//
//  WindOutlookTableViewControllerPreview.swift
//  LetsKite
//
//  Created by Stephen Brundage on 3/28/21.
//  Copyright © 2021 Stephen Brundage. All rights reserved.
//

import Foundation
import SwiftUI

struct WindOutlookTableViewControllerPreview: PreviewProvider, UIViewControllerRepresentable {
	
	typealias UIViewControllerType = WindOutlookViewController
	
	static var previews: some View {
		if #available(iOS 14.0, *) {
			Group {
				WindOutlookTableViewControllerPreview()
					.ignoresSafeArea(.all)
					.colorScheme(.dark)
			}
		} else {}
	}
	
	func makeUIViewController(context: Context) -> WindOutlookViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(identifier: WindOutlookViewController.storyboardID)
	}
	
	func updateUIViewController(_ uiViewController: WindOutlookViewController, context: Context) {}
}
