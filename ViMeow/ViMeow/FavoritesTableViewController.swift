//
//  FavoritesTableViewController.swift
//  ViMeow
//
//  Created by Jillian Somera on 2/10/17.
//  Copyright © 2017 Jillian Somera. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var favoriteVideos = [Animal]()
    
    func readPropertyList() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var plistData:[String:AnyObject] = [:]
        let plistPath:String?  = Bundle.main.path(forResource: "./Favorites", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {
            plistData = try PropertyListSerialization.propertyList(from: plistXML,                                                                             options: .mutableContainersAndLeaves, format: &format) as! [String:AnyObject]
           // favoriteVideos = plistData["Favorites"] as! [Animal]
            let tempArr = plistData["Favorites"] as! NSArray
         //   print(tempArr)
            for video in tempArr {
                let favorite = Animal()
                favorite.title = (video as! NSObject).value(forKeyPath: "title") as! String
                favorite._description = (video as! NSObject).value(forKeyPath: "description") as! String
                favorite.thumbnailUrl = (video as! NSObject).value(forKeyPath: "thumbnailUrl") as! String
                print(favorite.thumbnailUrl)
                favorite.id = (video as! NSObject).value(forKeyPath: "id") as! String
                favoriteVideos.append(favorite)
            }
            print(favoriteVideos[0].thumbnailUrl)
        } catch {
            print("Error reading plist: \(error), format: \(format)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //display logo
        let titleView = UIView(frame: CGRect(0, 0, 120, 30))
        let titleImageView = UIImageView(image: UIImage(named: "ViMeow Logo"))
        titleImageView.frame = CGRect(0, 0, titleView.frame.width, titleView.frame.height)
        titleView.addSubview(titleImageView)
        navigationItem.titleView = titleView
        
        readPropertyList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteVideos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        
        cell.favoriteVideoTitleLabel.text = favoriteVideos[indexPath.row].title
        
        var urlString = favoriteVideos[indexPath.row].thumbnailUrl.replacingOccurrences(of: "\r\n", with: " ")
        urlString = String(urlString.characters.filter { !" \n\t\r".characters.contains($0) })
        print(urlString)
        //remove \r\n from string, like why does this exist?
        //let url = URL(string: urlString)
        let url = URL(string: urlString)
        print(url)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if error == nil {
                    if let data = data {
                        cell.favoriteVideoImageView.image = UIImage(data: data)
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        })
        task.resume()
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
