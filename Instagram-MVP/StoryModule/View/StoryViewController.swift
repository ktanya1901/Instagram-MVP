//
//  StoryViewController.swift
//  Instagram-MVP
//
//  Created by Tatyana Korotkova on 18.02.2021.
//

import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyImageView: UIImageView!
    var presenter: StoryViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.presenter = StoryViewPresenter.init(view: self)
        self.presenter.getRandomImage()
    }


}

extension StoryViewController: StoryViewProtocol{
    func setImage(image: Data){
        DispatchQueue.main.async{
            self.storyImageView.image = UIImage(data: image)
        }
    }
}
