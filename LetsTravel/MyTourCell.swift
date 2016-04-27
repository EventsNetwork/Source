//
//  MyTourCell.swift
//  LetsTravel
//
//  Created by TriNgo on 4/26/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class MyTourCell: UITableViewCell {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    
    @IBOutlet weak var tourDay: UILabel!
    
    @IBOutlet weak var tourStart: UILabel!
    
    var tour:Tour? {
        didSet{
            if let t = tour{
                tourName.text = t.provinceName!
                tourDay.text = "\(t.totalDay!) days"
                
                if t.startTime > 0 {
                    tourStart.text = Utils.dateTotring(NSDate(timeIntervalSince1970: Double(t.startTime!)), format: "dd/MM/yyyy")
                } else{
                    tourStart.text = "---"
                }
                
                posterView.setImageWithURL(NSURL(string: t.imageUrls![0] as String)!, placeholderImage: UIImage(named: "placeholder"))
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
