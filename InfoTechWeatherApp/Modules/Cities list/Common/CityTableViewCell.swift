//
//  CityTableViewCell.swift
//  InfoTechWeatherApp
//
//  Created by Stanly Shiyanovskiy on 20.06.2022.
//

import UIKit

public final class CityTableViewCell: UITableViewCell {

    public static let reuseId = "CityTableViewCell"
    public static let cellNib = UINib(nibName: "CityTableViewCell", bundle: nil)
    
    // MARK: - Outlets
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var avatarIcon: UIImageView!
    @IBOutlet private weak var cityTitle: UILabel!
    
    // MARK: - Data

    public override func awakeFromNib() {
        super.awakeFromNib()
        configureContainer()
        selectionStyle = .none
    }
    
    public func configure(model: CityViewModel) {
        cityTitle.text = model.name
        avatarIcon.loadRemoteImageFrom(urlString: model.avatar)
    }
    
    private func configureContainer() {
        container.layer.cornerRadius = 16
    }
}
