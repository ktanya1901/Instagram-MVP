//
//  MainViewController.swift
//  HW-instagram-tables
//
//  Created by Tatyana Korotkova on 31.01.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    var storiesData: [Story] = [Story(storyImage: "avatar1", storyLabel: "login1", storyLink: ""), Story(storyImage: "avatar2", storyLabel: "login2", storyLink: ""), Story(storyImage: "avatar3", storyLabel: "login3", storyLink: ""), Story(storyImage: "avatar4", storyLabel: "login4", storyLink: ""), Story(storyImage: "avatar5", storyLabel: "login5", storyLink: "")]
    var postsData: [Post] = [
        Post(login: "login1", userLogo: "male", userPost: "wood", liked: false, likenum: 0),
        Post(login: "login2", userLogo: "female", userPost: "sunflower", liked: true, likenum: 4),
        Post(login: "login3", userLogo: "male", userPost: "lake", liked: true, likenum: 3),
        Post(login: "login4", userLogo: "female", userPost: "water", liked: false, likenum: 0)]
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        if (postsData[sender.tag].liked == false) {
            postsData[sender.tag].liked = true
            postsData[sender.tag].likenum += 1
        }
        else if (postsData[sender.tag].liked == true) {
            postsData[sender.tag].liked = false
            postsData[sender.tag].likenum -= 1
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Instagram"
        self.presenter = MainViewPresenter.init(view: self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as! InstagramStoriesCell
        cell.storiesCellView.image = UIImage(named: storiesData[indexPath.row].storyImage)
        cell.storiesLabel.text = storiesData[indexPath.row].storyLabel
        cell.storiesLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 134, height: 133)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "StoryImage") as! StoryViewController
        self.present(secondVC, animated: true, completion: nil)
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! InstagramPostCell
        let row = indexPath.row
        
        cell.avatarLabel.text = postsData[row].login
        cell.avatarLabel.font = UIFont.boldSystemFont(ofSize: 12)
        cell.avatarImageView.image = UIImage(named: postsData[row].userLogo)
        cell.postImageView.image = UIImage(named: postsData[row].userPost)
        
        cell.commentButton.setImage(UIImage(named: "comment"), for: .normal)
        cell.sendButton.setImage(UIImage(named: "send"), for: .normal)
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.setTitle("", for: .normal)
        if postsData[row].likenum == 1{
            cell.likedLabel.text = "1 like"
        }
        else{
            cell.likedLabel.text = "\(postsData[row].likenum) likes"
        }
        
        
        if(postsData[row].liked == true){
            cell.likeButton.setImage(UIImage(named: "liked"), for: .normal)
        }
        else{
            cell.likeButton.setImage(UIImage(named: "notliked"), for: .normal)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height*0.55
    }
    
    
}

extension MainViewController: MainViewProtocol{

}

