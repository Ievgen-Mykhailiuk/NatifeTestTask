//
//  PostsCell.swift
//  NatifeTest
//
//  Created by Евгений  on 15/07/2022.
//

import UIKit

//MARK: - Protocols
protocol CellStateDelegate {
    func cellIsExpanded(_ postId: Int)
    func cellIsCollapsed(_ postId: Int)
}

final class PostsCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    
    //MARK: - Properties
    var delegate: CellStateDelegate?
    var postId = 0
    private let collapsedLines = 2
    private let expandedLines = 0
    
    //MARK: - Override methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpButton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        readMoreButton.isHidden = false
    }
    
    //MARK: - Actions
    @IBAction func ReadMoreButtonPressed(_ sender: UIButton) {
        let lines = postTextLabel.numberOfLines
        if lines == collapsedLines {
            setReadLess()
            delegate?.cellIsExpanded(postId)
        } else if lines == expandedLines {
            setReadmore()
            delegate?.cellIsCollapsed(postId)
        }
    }
    
    //MARK: - View configuration
    func configure (title: String,
                    text: String,
                    likes: Int,
                    date: Double) {
        postTitleLabel.text = title
        postTextLabel.text = text
        likesLabel.text = String(likes)
        
        let maxSymbolsCount = 100
        if  postTextLabel.text!.count < maxSymbolsCount {
            readMoreButton.isHidden = true
        }
        configureDate(date)
    }
    
    //MARK: - Date configuration method
    private func configureDate(_ date: Double) {
        let startDate = Date()
        let daysInMonth = 30
        let endDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let endDateString = dateFormatter.string(from: endDate)
        if let endDate = dateFormatter.date(from: endDateString) {
            let components = Calendar.current.dateComponents([.day], from: endDate, to: startDate)
            guard let days = components.day else { return }
            if days > daysInMonth {
                dateLabel.text = "\(days/daysInMonth) monthes ago"
            } else {
                dateLabel.text = "\(days) days ago"
            }
        }
    }
    
    //MARK: - Expand/Collaps button setup
    func setReadLess() {
        self.postTextLabel.numberOfLines = expandedLines
        readMoreButton.setTitle("Read less", for: .normal)
    }
    
    func setReadmore() {
        self.postTextLabel.numberOfLines = collapsedLines
        readMoreButton.setTitle("Read more", for: .normal)
    }
    
    private func setUpButton() {
        readMoreButton.layer.cornerRadius = 10
        readMoreButton.layer.borderWidth = 1
        readMoreButton.layer.borderColor = UIColor.black.cgColor
        readMoreButton.setTitleColor(.black, for: .normal)
    }
}




