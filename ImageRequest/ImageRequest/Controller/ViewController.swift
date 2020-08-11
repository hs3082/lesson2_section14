//
//  ViewController.swift
//  ImageRequest
//
//  Created by Owen LaRosa on 10/11/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    let imageLocation = KittenImageLocation.http.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //updated let statement per warning Initialization of immutable value 'imageURL' was never used; consider replacing with assignment to '_' or removing it
        //Replace 'let imageURL' with '_'
        _ = URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg")!
        
        //Per lesson plan
        // use "URLSession.shared" to access the shared URLSession
        let task = URLSession.sharedSession().dataTask(with: imageURL) { (data, response, error) in
        print("task finished")
        }
    }

    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        guard let imageUrl = URL(string: imageLocation) else {
            print("Cannot create URL")
            return
        }
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data else {
                print("no data, or there was an error")
                return
            }
            let downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.imageView.image = downloadedImage
            }
        }
        task.resume()
        
    }
}

