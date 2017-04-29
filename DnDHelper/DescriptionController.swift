//
//  DescriptionController.swift
//  DnDHelper
//
//  Created by u0771753 on 4/29/17.
//  Copyright © 2017 u0771753. All rights reserved.
//

import UIKit

class DescriptionController: UIViewController {
    var desc: Description = Description()
    
    var contentView : DescriptionView! {
        return view as! DescriptionView!
    }
    
    override func loadView() {
        super.loadView()
        view = DescriptionView()
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickedBack)), animated: true)
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let temp = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        temp.textAlignment = .center
        temp.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        temp.adjustsFontSizeToFitWidth = true
        temp.borderStyle = UITextBorderStyle.line
        self.navigationItem.titleView = temp
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (self.navigationItem.titleView as! UITextField).text = desc.title
        contentView.update(text: desc.text)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backstoryPressed(sender: UIButton!) {
        
    }
    
    func spellbookPressed(sender: UIButton!) {
        
    }
    
    func clickedBack(sender: UIBarButtonItem?) {
        desc.text = contentView.text
        desc.title = (self.navigationItem.titleView as! UITextField).text!
        _ = navigationController?.popViewController(animated: true)
    }
}
