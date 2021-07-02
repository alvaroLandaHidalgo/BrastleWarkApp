//
//  DetailInhabitantViewController.swift
//  brastewarkmobiletest
//
//  Created by alvaro Landa Hidalgo on 1/7/21.
//

import Foundation
import UIKit
import Alamofire

class DetailInhabitantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var inHabitants = [Inhabitant]()
    var selectedInhabitant: Inhabitant! = nil
    var friendsSelectedInhabitants = [Inhabitant]()
    var inhabitantProfessionArray = [String]()
    
    @IBOutlet weak var InhabitantImageView: UIImageView!
        
    @IBOutlet weak var InhabitantName: UILabel!
    
    @IBOutlet weak var InhabitantAge: UILabel!
    
    @IBOutlet weak var InhabitantHeight: UILabel!
    
    @IBOutlet weak var InhabitantWeight: UILabel!

    @IBOutlet weak var InhabitantProfessions: UILabel!
    
    @IBOutlet weak var FriendsTableView: UITableView!
    override func viewDidLoad() {
        FriendsTableView.delegate = self
        FriendsTableView.dataSource = self
        super.viewDidLoad()
        CheckFriends()
        CheckProfessions()
        showData()
        FriendsTableView.reloadData()
        
    }
    func CheckFriends(){
        for friend in selectedInhabitant.friends{
            for inhabitant in inHabitants{
                if inhabitant.name == friend{
                    friendsSelectedInhabitants.append(inhabitant)
                }
            }
        }
        print("friends selected: \(friendsSelectedInhabitants)")
    }
    func CheckProfessions(){
        for Inhabitant in inHabitants{
            for number in Inhabitant.professions{
                inhabitantProfessionArray.append(number)
            }
        }
    }
    func showData(){
        InhabitantImageView.sd_setImage(with:URL(string: selectedInhabitant.thumbnail.replacingOccurrences(of: "http", with: "https")))
        InhabitantName.text = "Name: \(selectedInhabitant.name)"
        InhabitantAge.text = "Age: \(selectedInhabitant.age)"
        InhabitantHeight.text = "Height: \(selectedInhabitant.height)"
        InhabitantWeight.text = "weight: \(selectedInhabitant.weight)"
        let urlThumbnail = self.selectedInhabitant.thumbnail.replacingOccurrences(of: "http", with: "https")
        InhabitantImageView.sd_setImage(with: URL(string: urlThumbnail))
        
        var SelectedInhabitantProfessions = ""
        
        for profession in selectedInhabitant.professions{
            
            SelectedInhabitantProfessions = SelectedInhabitantProfessions + profession + " "
        }

        InhabitantProfessions.text = "profession: "+SelectedInhabitantProfessions

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsSelectedInhabitants.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "FriendViewControllerCell"
        let cell: FriendViewControllerCell = tableView.dequeueReusableCell(withIdentifier: identifier,  for:indexPath) as! FriendViewControllerCell
        let urlThumbnail = self.friendsSelectedInhabitants[indexPath.row].thumbnail.replacingOccurrences(of: "http", with: "https")
        
        cell.FriendUIImage.sd_setImage(with: URL(string: urlThumbnail))
        cell.FriendLabelName.text = self.friendsSelectedInhabitants[indexPath.row].name
        return cell
    }
}

