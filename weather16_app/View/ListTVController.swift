//
//  ListTVController.swift
//  weather16_app
//
//  Created by user on 09.11.2021.
//

import UIKit

class ListTVController: UITableViewController {

    private let networkWeatherManeger = NetworkWeatherManeger()
    
    private let emptyCity = Weather()
    
    private var filterCityArray = [Weather]()
    private var citiesArray = [Weather]()
    
    var nameCitiesArray = ["Lviv", "Berlin", "Paris", "Warszawa", "Madrid", "San Francisco", "Reykjavík", "Anchorage"]
    
    private var weather: Weather? = nil
    private var instruction: Instruction? = nil
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
       
    }
    
    @IBAction func pressPlusButton(_ sender: Any) {
        alertPlusCity(name: "City", placeholder: "enter the city name") { (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    func addCities() {
        getCityWeather(citiesArray: self.nameCitiesArray) { index, weather in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            //print(self.citiesArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func fillCities(_ array: [String]) {
        for city in array {
            networkWeatherManeger.updateWeatherInfo(urlString: "http://api.weatherapi.com/v1/forecast.json?key=5d660d04041a48beb80213202210911&q=\(city)&days=1") { (result) in
                switch result {
                    
                case .success( let weather):
                   // print("\(city) \(self.citiesArray[0])")
                    self.instruction = weather
          //         print(self.instruction?.location.name)
                    self.tableView.reloadData()
                case .failure(let error ):
                    print("error", error)
                }
            }
            
        }
    }
    
    @IBAction func Forecast(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowForecast", sender: nil)
    }
    
    
    //MARK: Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showD" {

             guard let indexPath = tableView.indexPathForSelectedRow else { return }

             if isFiltering {
                 let filter = filterCityArray[indexPath.row]
                 let dstVC = segue.destination as! DetailVC
                 dstVC.weatherModel = filter
                 
             } else {
                 let cityWeather = citiesArray[indexPath.row]
                 let dstVC = segue.destination as! DetailVC
                 dstVC.weatherModel = cityWeather
             }
   
         }
     }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isFiltering {
            return filterCityArray.count
        }
        
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell

        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]

        } else {
            weather = citiesArray[indexPath.row]
        }
        
        cell.configure(instruction: weather)
        
        return cell
    }
    


   
//Delete
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler)  in
            let editingRow = self.nameCitiesArray[indexPath.row]
            
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)

                } else {
                    self.citiesArray.remove(at: index)

                }
                
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}

extension ListTVController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}
