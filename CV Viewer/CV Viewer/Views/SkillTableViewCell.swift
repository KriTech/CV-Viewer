//
//  SkillTableViewCell.swift
//  CV Viewer
//
//  Created by Jose Enrique Montañez Villanueva on 06/09/19.
//  Copyright © 2019 Jose Enrique Montañez Villanueva. All rights reserved.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    var skill: Skill! {
        didSet {
            self.backgroundColor = .clear
            
            if let skill = self.skill {
                let titleLabel = UILabel()
                titleLabel.text = skill.title
                titleLabel.tag = 2
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let levelBackgroundView = UIView()
                levelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
                levelBackgroundView.backgroundColor = #colorLiteral(red: 0.6903132796, green: 0.6904311776, blue: 0.6902977824, alpha: 1)
                levelBackgroundView.tag = 3
                
                let levelView = UIView()
                levelView.translatesAutoresizingMaskIntoConstraints = false
                levelView.tag = 1
                
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.3420023322, blue: 1, alpha: 1).cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                
                
                levelView.layer.addSublayer(gradientLayer)
                
                self.addSubview(titleLabel)
                self.addSubview(levelBackgroundView)
                self.addSubview(levelView)
                
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
                
                levelBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
                levelBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                levelBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
                levelBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
                levelBackgroundView.heightAnchor.constraint(equalToConstant: 5).isActive = true
                
                levelView.centerYAnchor.constraint(equalTo: levelBackgroundView.centerYAnchor).isActive = true
                levelView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
                levelView.widthAnchor.constraint(equalTo: levelBackgroundView.widthAnchor, multiplier: CGFloat(skill.percentage)/100.0).isActive = true
                levelView.heightAnchor.constraint(equalToConstant: 5).isActive = true
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let levelView = self.viewWithTag(1), let layers = levelView.layer.sublayers {
            for layer in layers {
                layer.frame = levelView.bounds
            }
        }
    }
    
    override func prepareForReuse() {
        for view in self.subviews {
            if view.tag != 0 {
                view.removeFromSuperview()
            }
        }
    }
}
