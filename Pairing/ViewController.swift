//
//  ViewController.swift
//  Pairing
//
//  Created by Sagaya Abdulhafeez on 07/03/2017.
//  Copyright © 2017 Sagaya Abdulhafeez. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

@objc protocol Disc{
    func count()
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,Disc,UITextFieldDelegate {
    internal func count() {
        print("dsdsds")
    }
    
    var groups = [[String]]()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        return collection
    }()
    let footerView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
//        v.frame.size.height = 50.0
        return v
    }()

    var testArr = [String]()
    var shuffledArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        navigationItem.rightBarButtonItem = btn
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.emptyDataSetSource = self
        collectionView.emptyDataSetDelegate = self
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 1
        if collectionView.isEmptyDataSetVisible{
            layout.footerReferenceSize = CGSize.zero
        }else{
            layout.footerReferenceSize = CGSize(width: collectionView.frame.width, height: 100)
        }

        view.addSubview(collectionView)
           view.addConstraintsWithFormat("H:|-15-[v0]-15-|", views: collectionView)
        view.addConstraintsWithFormat("V:|-8-[v0]|", views: collectionView)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")

        collectionView.register(ColCell.self, forCellWithReuseIdentifier: "cell")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func addNew(){
        let alertController = UIAlertController(title: "", message: "INPUT:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                self.testArr.append(field.text!)
                self.collectionView.reloadData()
            } else {
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColCell
        cell.buttomV.addTarget(self, action: #selector(deleteButton(sender:)), for: .touchUpInside)
        cell.buttomText.text = testArr[indexPath.row].uppercased()
        var nameText = testArr[indexPath.row].uppercased()
        let index = nameText.index(nameText.startIndex, offsetBy: 0)
        cell.viewText.text = "\(nameText[index])"
        cell.superv.backgroundColor = .randomColor()
        shuffledArr = testArr.shuffled()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)  as! HeaderView
        footer.contoller = self
        footer.d = self
        footer.button.addTarget(self, action: "gen", for: .touchUpInside)
        return footer
        
    }
    
    func gen(){
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        var sectionToHide: Bool = collectionView.isEmptyDataSetVisible
        if sectionToHide {
            return CGSize.zero
        }
        else {
            return CGSize(width: collectionView.frame.width, height: CGFloat(100))
        }
    }
    func deleteButton(sender: UIButton){
        var indexPath: IndexPath? = nil
        indexPath = self.collectionView.indexPathForItem(at: self.collectionView.convert(sender.center, from: sender.superview))
        print(indexPath?.row)
        testArr.remove(at: (indexPath?.row)!)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
    func showAlert(){
        let alert = UIAlertController(title: "", message: "Odd Number not supported", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    func nav(){
        let vc = secondVC()
        vc.allGroups = groups
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class ColCell:UICollectionViewCell,UITextFieldDelegate{
    let superv: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        return v
    }()
    let buttomV: UIButton = {
        let v = UIButton()
        v.backgroundColor = .red
        var attr = NSAttributedString(string: "Delete", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13),NSForegroundColorAttributeName: UIColor.white])
        v.setAttributedTitle(attr, for: .normal)
        v.isHidden = true
        return v
    }()
    let viewText: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = "D"
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    let buttomText: UILabel = {
        let label = UILabel()
        label.text = "Random Stuff"
        label.textAlignment = .center

        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var swipeGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleSwipeGesture))
        addGestureRecognizer(swipeGesture)
        
        var swipeGestureDown = UITapGestureRecognizer(target: self, action: #selector(self.handleDown))
//        swipeGestureDown.direction = .down
        superv.addGestureRecognizer(swipeGestureDown)
        
        backgroundColor = .white
        addSubview(superv)
        addSubview(buttomV)
        addSubview(buttomText)
        addConstraintsWithFormat("H:|[v0]|", views: superv)
        addConstraintsWithFormat("V:|[v0]-2-[v1]-2-[v2]|", views: superv,buttomText,buttomV)
        addConstraintsWithFormat("H:|[v0]|", views: buttomV)
        addConstraintsWithFormat("H:|[v0]|", views: buttomText)

        superv.addSubview(viewText)
        superv.addConstraintsWithFormat("H:|[v0]|", views: viewText)
        superv.addConstraintsWithFormat("V:|[v0]|", views: viewText)

    }
    
    func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        buttomV.isHidden = false
    }
    func handleDown(){
        buttomV.isHidden = true
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HeaderView: UICollectionViewCell,UITextFieldDelegate {
    var contoller : ViewController?
    weak var d:Disc?
    
    let groupTextField: SkyFloatingLabelTextField = {
        let l = SkyFloatingLabelTextField()
        l.placeholder = "Number of people per group"
        l.title = ""
        l.tintColor = .gray
        l.textColor = .darkGray
        l.lineColor = .gray
        l.selectedTitleColor = .gray
        l.selectedLineColor = .gray
        return l
    }()
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Pair!!!!", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red:0.21, green:0.79, blue:0.69, alpha:1.0)
        return btn
    }()
   override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(groupTextField)
        groupTextField.delegate = self
        addSubview(button)
        addConstraintsWithFormat("H:|[v0]|", views: groupTextField)
        addConstraintsWithFormat("H:|[v0]|", views: button)
        button.addTarget(self, action: "groupEm", for: .touchUpInside)
        addConstraintsWithFormat("V:|[v0]-4-[v1(50)]|", views: groupTextField,button)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    func groupEm(){
        print("Number of items we currently have is \(contoller?.testArr.count) number of groups is \(groupTextField.text)")
        if groupTextField.text != "" {

            var g = Int(groupTextField.text!)
            if (contoller?.shuffledArr.count)! != 0 && (contoller?.shuffledArr.count)! > 1{
                if (contoller?.shuffledArr.count)! % 2 != 0 && g! % 2 != 0{
                    contoller?.showAlert()
                }else{
                    
                    var group : [[String]] = Array(repeating: [], count: (contoller?.shuffledArr.count)! / 2)
                    var next = 0
                    for ix in stride(from: 0, to: (contoller?.shuffledArr.count)! - 1, by: g!){
                        print(ix)
                        for ixx in 0..<g!{
                            group[next].append((contoller?.shuffledArr[ix+ixx])!)
                        }
                        next += 1
                    }
                    contoller?.groups = group
                    contoller?.collectionView.reloadData()
                    if contoller?.groups.count != 0{
                        contoller?.nav()
                    }
                    
                }
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
