//
//  ViewController.swift
//  brastewarkmobiletest
//
//  Created by alvaro Landa Hidalgo on 29/6/21.
//

import UIKit
import SDWebImage
class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var inhabitantsTableView: UITableView!
    
    var filteredInhabitants = [Inhabitant]()
    var inhabitants = [Inhabitant]()
    var runningTimer: Bool = false
    var searchActive = false
    
    var mySearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnableGestureRecognizer()
        inhabitantsTableView.delegate = self
        inhabitantsTableView.dataSource = self
        searchBar.delegate = self
        
        DataProvider.getInhabitant(){(data:[Inhabitant]) -> Void in
            self.inhabitants = data
            self.filteredInhabitants = self.inhabitants
            self.inhabitantsTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        StartTimer()
    }
    
    func StartTimer(){
        _ = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(IdleWarning), userInfo: nil, repeats: false)
    }
    @objc func IdleWarning()
    {
        let alert = UIAlertController(title: "Hello? Are you there?", message: "You have been 5 minutes idle", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "oops!", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func EnableGestureRecognizer(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        gesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(gesture)
    }
    @objc func checkAction(sender : UITapGestureRecognizer) {
        StartTimer()
        dismissKeyboard()
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInhabitants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "InhabitantTableViewCell"
        let cell: InhabitantViewControllerCell = tableView.dequeueReusableCell(withIdentifier: identifier,  for:indexPath) as! InhabitantViewControllerCell
        let urlThumbnail = self.filteredInhabitants[indexPath.row].thumbnail.replacingOccurrences(of: "http", with: "https")
        cell.InhabitantImageView.sd_setImage(with: URL(string: urlThumbnail))
        cell.InhabitantNameLabel.text = self.filteredInhabitants[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell")
        let identifier = "DetailViewController"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailInhabitantViewController
        vc.inHabitants = self.inhabitants
        vc.selectedInhabitant = self.filteredInhabitants[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredInhabitants =  []
        if searchText == "" {
            filteredInhabitants = inhabitants
        }else{
            for inhabitant in inhabitants{
                if inhabitant.name.lowercased().contains(searchText.lowercased()){
                    filteredInhabitants.append(inhabitant)
                }
            }
        }
        self.inhabitantsTableView.reloadData()
    }
}
