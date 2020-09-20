//
//  BattleCollectionViewCell.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 30/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class BattleCollectionViewCell : UICollectionViewCell {
    
    
    @IBOutlet weak var battleLabel: UILabel!
    
     private static let sizingCell = UINib(nibName: BATTLE_COLLECTION_VIEW_CELL, bundle: nil).instantiate(withOwner: nil, options: nil).first! as! BattleCollectionViewCell
    
    var winnerIsHero: Bool? = nil
    
    var isWidthCalculated: Bool = false
    
    var battle : Battle? = nil
    
    var loadedFromHeroes : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false 
    }
    
    //MARK: Configure methods
    
    func configure(viewModel: BattleCollectionViewCellModel, isSizing: Bool = false){
        self.loadedFromHeroes = viewModel.loadedFromHeroes
        self.winnerIsHero = viewModel.winnerIsHero
        self.battleLabel.text = viewModel.battleName
        self.configureUI()
    }
        
    //MARK: Private methods
    
    private func configureUI(){
        self.setViewShape()
        self.setViewColorAndTitle()
    }
    
    private func setViewShape(){
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.shadowColor = UIColor.gray.cgColor
        self.contentView.layer.shadowOffset = CGSize.zero
        self.contentView.layer.shadowRadius = 4.0
        self.contentView.layer.shadowOpacity = 0.2
    }
    
    private func setViewColorAndTitle(){
        guard let winnerIsHero = self.winnerIsHero else { return }
        if(self.loadedFromHeroes){
            self.contentView.backgroundColor = winnerIsHero ? UIColor(red: 0.0, green: 0.0, blue: 0.70, alpha: 1.0) :  UIColor(red: 0.70, green: 0.0, blue: 0.0, alpha: 1.0)
        } else {
            self.contentView.backgroundColor =  !winnerIsHero ? UIColor(red: 0.0, green: 0.0, blue: 0.70, alpha: 1.0) :  UIColor(red: 0.70, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    

//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //Exhibit A - We need to cache our calculation to prevent a crash.
//        if !isWidthCalculated {
//            setNeedsLayout()
//            layoutIfNeeded()
//            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//            var newFrame = layoutAttributes.frame
//            newFrame.size.width =  CGFloat(ceilf(Float(size.width)))
//            layoutAttributes.frame = newFrame
//            isWidthCalculated = true
//        }
//        return layoutAttributes
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        var newFrame = layoutAttributes.frame
        // Make any additional adjustments to the cell's frame
        newFrame.size = size
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
}
