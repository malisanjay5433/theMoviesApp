//
//  ViewController.swift
//  theMoviesApp
//
//  Created by Sanjay Mali on 09/01/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import UIKit
import FoldingCell
import Kingfisher
class MainTableViewController: UITableViewController {
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    var kRowsCount = 20
    var cellHeights: [CGFloat] = []
    var imagesUrl = "https://image.tmdb.org/t/p/w500"
    var table_Data = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON()
        self.setup()
    }
    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }
    func downloadJSON(){
        //let jsonUrl = "https://api.citybik.es/v2/networks"
        DataManager.getMoviesJSON() { (data, error) in
            guard let data = data else { return
            }
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(Movies.self, from: data)
                self.table_Data = json.results
                
            } catch{
                print("failed to convert data")
            }
            self.kRowsCount = self.table_Data.count
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
// MARK: - TableView
extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table_Data.count
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        cell.backgroundColor = .clear
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        let data = table_Data[indexPath.row]
        cell.number = indexPath.row
        cell.name.text = data.title!
        cell.descriptionLbl.text = data.overview!
        let imageString = imagesUrl + data.poster_path!
        let url = URL(string:imageString)
        cell.imageViewPoster.kf.setImage(with:url, placeholder:UIImage(named:"placeholder"), options:nil, progressBlock: nil, completionHandler: nil)
        cell.imageAvtar.kf.setImage(with:url, placeholder:UIImage(named:"placeholder"), options:nil, progressBlock: nil, completionHandler: nil)
        cell.release_date.text = data.release_date
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}

