//
//  CustomUINavBar.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/2/17.
//
//

import UIKit

class CustomUINavBar: UINavigationBar {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //override func draw(_ rect: CGRect) {
    // Drawing code
    //    self.barTintColor = MWColors.MWBlue
    //}
    ///The height you want your navigation bar to be of
    static let navigationBarHeight: CGFloat = 44.0
    
    ///The difference between new height and default height
    static let heightIncrease:CGFloat = navigationBarHeight - 44
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        let shift = CustomUINavBar.heightIncrease/2
        
        ///Transform all view to shift upward for [shift] point
        self.transform =
            CGAffineTransform(translationX: 0, y: -shift)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shift = CustomUINavBar.heightIncrease/2
        
        ///Move the background down for [shift] point
        let classNamesToReposition: [String] = ["_UINavigationBarBackground"]
        for view: UIView in self.subviews {
            if classNamesToReposition.contains(NSStringFromClass(type(of: view))) {
                let bounds: CGRect = self.bounds
                var frame: CGRect = view.frame
                frame.origin.y = bounds.origin.y + shift - 20.0
                frame.size.height = bounds.size.height + 20.0
                view.frame = frame
            }
        }
    }


}
