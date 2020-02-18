//
//  MaskTableViewController.swift
//  MasksApp
//
//  Created by Glen Lin on 2020/2/15.
//  Copyright © 2020 Glen Lin. All rights reserved.
//

import UIKit

class MaskTableViewController: UITableViewController ,UISearchResultsUpdating{

    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    var masks = [Mask]()
    var searchMasks = [Mask]()
    
    
    func updateSearchResults(for searchController: UISearchController){
        let searchString = searchController.searchBar.text!
        searchMasks = masks.filter({ (name) -> Bool in
            return name.name.contains(searchString)
        })
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true




        getData()
        getRefreshController()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func getRefreshController(){
        refreshControl = UIRefreshControl()
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        refreshControl?.attributedTitle = NSAttributedString(string: "更新...",attributes: attributes)
        refreshControl?.tintColor = .white
        refreshControl?.backgroundColor = .black
        refreshControl?.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    @objc func getData() -> () {
        let urlStr = "https://quality.data.gov.tw/dq_download_json.php?nid=116285&md5_url=2150b333756e64325bdbc4a5fd45fad1"
        print("GOT URL")
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(formatter)
                do{
                    try decoder.decode([Mask].self, from: data!)
                }catch{
                    print(error)
                }
                if let data = data, let masks = try? decoder.decode([Mask].self, from: data){
                    self.masks = masks
                    print("get Result")
                    DispatchQueue.main.async {
                        print("viewDidLoad")
                        self.activityIndicatorView.removeFromSuperview()
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
                    }
                }
            }.resume()
        }else{
            print("error")
        }
    }
    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if navigationItem.searchController?.isActive == true{
            return searchMasks.count
        }else{
            return masks.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

guard let cell = tableView.dequeueReusableCell(withIdentifier: "MaskTableViewCell", for: indexPath) as? MaskTableViewCell else { return UITableViewCell() }

        if navigationItem.searchController?.isActive == true {
                          let mask = searchMasks[indexPath.row]
                          cell.idLabel.text = "醫院代碼 :" + mask.id
                          cell.nameLabel.text = "醫院名稱 :" + mask.name
                          cell.addressLabel.text = "醫院地址 :" + mask.address
                          cell.telLabel.text = "電話 :" + mask.tel
                          cell.adultLabel.text = "成人口罩剩餘 :" + mask.adult
                          cell.childLabel.text = "兒童口罩剩餘 :" + mask.child
                          let formatter = DateFormatter()
                          formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                          let timeText = formatter.string(from: mask.time)
                          cell.timeLabel.text = "更新時間 :" + "\(timeText)"
                        } else {
                         let mask = masks[indexPath.row]
                         cell.idLabel.text = "醫院代碼 :" + mask.id
                         cell.nameLabel.text = "醫院名稱 :" + mask.name
                         cell.addressLabel.text = "醫院地址 :" + mask.address
                         cell.telLabel.text = "電話 :" + mask.tel
                         cell.adultLabel.text = "成人口罩剩餘 :" + mask.adult
                         cell.childLabel.text = "兒童口罩剩餘 :" + mask.child
                         let formatter = DateFormatter()
                         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                         let timeText = formatter.string(from: mask.time)
                         cell.timeLabel.text = "更新時間 :" + "\(timeText)"
                        }
              return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
