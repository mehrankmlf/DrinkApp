//
//  MainTableViewCell.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    private enum Constants {
        
        static let padding : CGFloat = 3.0
        
        static let fontSize : CGFloat = 15
        
        // MARK: contentView layout constants
        static let contentViewCornerRadius: CGFloat = 10.0
        static let generalPadding : CGFloat = 5.0
    }
    
    private lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkBackground
        view.clipsToBounds = true
        return view
    }()
    
    lazy var imageDrink : DownloadableImageView = {
        let imageDrink = DownloadableImageView()
        imageDrink.contentMode = .scaleAspectFill
        imageDrink.clipsToBounds = true
        return imageDrink
    }()

    private lazy var lblName : PaddingLabel = {
        let label = PaddingLabel(withInsets: 5, 5, 5, 5)
        label.textColor = .fontWhiteColor
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .lightDarkBackfround
        self.containerView.layer.cornerRadius = Constants.contentViewCornerRadius
        self.imageDrink.layer.cornerRadius = Constants.contentViewCornerRadius
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(imageDrink)
        self.containerView.addSubview(lblName)
        [containerView,
         imageDrink,
         lblName]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        self.setupAutoLayout()
        // To optimize the view render performance
        self.containerView.layer.shouldRasterize = true
        self.containerView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupParametrs(items : DrinkList_Response) {
        self.lblName.text = items.strDrink
        self.imageDrink.downloadWithUrlSession(at: self, urlStr: items.safeImageURL())
    }
}

extension MainTableViewCell {
    private func setupAutoLayout() {
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.generalPadding).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.generalPadding).isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.generalPadding).isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.generalPadding).isActive = true
        
        imageDrink.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.generalPadding).isActive = true
        imageDrink.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.generalPadding).isActive = true
        imageDrink.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.generalPadding).isActive = true
        imageDrink.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        lblName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.generalPadding).isActive = true
        lblName.leftAnchor.constraint(equalTo: imageDrink.rightAnchor, constant: Constants.generalPadding).isActive = true
        lblName.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.generalPadding).isActive = true
    }
}

extension MainTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
