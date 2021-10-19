//
//  ViewController.swift
//  MindTeckAssignment
//
//  Created by raushan on 13/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var carouselScrollView: UIScrollView!
    
    @IBOutlet weak var carouselPageControl: UIPageControl!
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    var carouselImagesNames = ["0","1","2"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    
   var arrayOfFlagNames = ["india","usa","australia","canada","china","france","pakistan","spain","uk"]
    
    var filteredData: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        carouselPageControl.currentPageIndicatorTintColor = .darkGray // custom color
        carouselPageControl.pageIndicatorTintColor = .darkGray.withAlphaComponent(0.3)
       
        self.tableViewHeight.constant = (self.tableView.frame.height * (self.view.frame.height/896)) + self.carouselScrollView.frame.height + self.carouselPageControl.frame.height - 16
        
       
        filteredData = arrayOfFlagNames
           
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell",bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
        self.carouselPageControl.numberOfPages = self.carouselImagesNames.count
        
        for index in 0..<self.carouselImagesNames.count{
            // getting starting point for each image view
            frame.origin.x = self.carouselScrollView.frame.size.width * CGFloat(index)
            frame.size = carouselScrollView.frame.size
            // adding image view to scroll view
            let carouselImageView = UIImageView(frame: frame)
            carouselImageView.contentMode = .scaleAspectFit
            carouselImageView.image = UIImage(named: self.carouselImagesNames[index])
            self.carouselScrollView.addSubview(carouselImageView)
        }
        
        self.carouselScrollView.contentSize = CGSize(width: carouselScrollView.frame.width * CGFloat(carouselImagesNames.count), height: self.carouselScrollView.frame.height)
        self.carouselScrollView.delegate = self
        
        self.hideKeyboardWhenTappedAround()
       
        
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
extension ViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        self.carouselPageControl.currentPage = Int(pageNumber)
    }
    


}

extension ViewController:UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "CustomTableViewCell") as! CustomTableViewCell
        cell.cellImageView.image = UIImage(named: self.filteredData[indexPath.row])
        cell.cellLabelView.text = self.filteredData[indexPath.row]
        cell.selectionStyle = .none
       
        return cell
    }
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filteredData = searchText.isEmpty ? arrayOfFlagNames : arrayOfFlagNames.filter({(dataString: String) -> Bool in
           
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        self.tableView.reloadData()
    }
    
    
}

