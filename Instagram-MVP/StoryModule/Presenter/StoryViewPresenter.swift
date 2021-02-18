//
//  StoryViewPresenter.swift
//  Instagram-MVP
//
//  Created by Tatyana Korotkova on 18.02.2021.
//

import Foundation

protocol StoryViewProtocol {
    func setImage(image: Data)
}

protocol StoryViewPresenterProtocol {
    init(view: StoryViewProtocol)
    
    func getRandomImage()
}

class StoryViewPresenter: StoryViewPresenterProtocol{
    let view: StoryViewProtocol
    var img: Data = Data()
    
    required init(view: StoryViewProtocol) {
        self.view = view
    }
    
    func getRandomImage(){
        getRequest()
    }
    
    // used dog pictures just to practice the work of presenter
    func getRequest() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let rowData = data {
                do {
                    //using codable
                    let json = try JSONDecoder().decode(RandomImage.self, from: rowData)
                    self.getImage(url: json.message)
                } catch {
                    print("Error parsing to dictionary")
                }
            }
        }
        task.resume()
    }
    
    func getImage(url: String) {
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let rowData = data {
                self.img = rowData
                self.view.setImage(image: self.img)
            }
        }
        task.resume()
    }
    
    
}
