//
//  ViewController.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 13.02.2023.
//

import UIKit
import RealmSwift
import RevenueCat

class CoffeeListViewController: UIViewController {
    
    
    // MARK: - Variables
    let realm = try! Realm()
    var coffees : Results<Coffee>?
    var selectedCoffee : Coffee?
    var showFavorites : Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFavorites: UIButton!
    
    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check isVipStatus
        checkInAppPurchaseStatus()
        // Do any additional setup after loading the view.
        searchBar.searchTextField.leftView?.tintColor = UIColor(named: "appBackgroundColor")
        searchBar.searchTextField.textColor = UIColor(named: "appBackgroundColor")
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor(named: "appBackgroundColor")]
        )
        self.loadData()
    }
    
    
    // MARK: - Actions
    
    func checkInAppPurchaseStatus() {
        
        Purchases.shared.getCustomerInfo { (customerInfo, error) in
            if customerInfo?.entitlements.all["coffeemPremium"]?.isActive == true {
                print("FirstCheckUserPremium")
                isVipMember = true

            }
        }
        
    }
    
    @IBAction func filterPressed(_ sender: UIButton) {
        openCoffeeDetailVC(viewController: self)
    }
    
    @IBAction func showFavoritesPressed(_ sender: UIButton) {
        showFavorites.toggle()
        if coffees != nil {
            if showFavorites {
                btnFavorites.setTitle("Show All", for: .normal)
                coffees = coffees!.filter("isFavorite ==[cd] %@", 1)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                btnFavorites.setTitle("Show Favorites", for: .normal)
                loadData()
            }
        }
    }
    
    
    
    // MARK: - Functions
    
    /// Loads all coffee data from realm db and reloads table view for show current coffees.
    func loadData () {
        // Not be able to cast directly to the array even if it's like an array. It's different data type and not very easily converted.
        // That's why up global we made categories as type of result.
        coffees = realm.objects(Coffee.self)
        tableView.reloadData()
    }
}

    // MARK: - TableView Extension
extension CoffeeListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeListTableViewCellID") as! CoffeeListTableViewCell
        cell.coffeeListTableViewCellDelegate = self
        
        if let coffee = coffees?[indexPath.row] {
            cell.updateCell(coffee: coffee)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coffees = coffees {
            if let cell = self.tableView.cellForRow(at: indexPath) as? CoffeeListTableViewCell {
                let coffee = coffees.filter("name CONTAINS[cd] %@", cell.lblName.text)
                openCoffeeDetailVC(coffee: coffee[0])
            }
        }
    }
}

    // MARK: - SearchBar Extension
extension CoffeeListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Not even need to loadItems. Because we've already loaded them. Now we just filter them.
        // Update collection of results with filtered predicate version and sort them.
        coffees = coffees?.filter("(name CONTAINS[cd] %@) OR (roaster CONTAINS[cd] %@)", searchBar.text, searchBar.text).sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            // Leave being first responder. No cursor, keyboard leaves. Needs to be done in main thread.
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}

    // MARK: - CoffeeListCell Delegate
extension CoffeeListViewController: CoffeeListTableViewCellDelegate {
    func cell(_ cell: CoffeeListTableViewCell, didTap button: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        if let coffee = coffees?.filter("name CONTAINS[cd] %@", cell.lblName.text) {
            do {
                try realm.write {
                    if coffee[0].isFavorite == 0 {
                        coffee[0].isFavorite = 1
                    } else {
                        coffee[0].isFavorite = 0
                    }
                }
                print(coffee)
            } catch {
                print(error)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CoffeeListViewController : FilterViewControllerDelegate {
    
    
    func coffeeFiltered(filteredCoffee: String) {
        loadData()
        if coffees != nil {
            coffees = coffees!.filter("roast ==[cd] %@", filteredCoffee)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
                
    }
    
    
    
    
}
