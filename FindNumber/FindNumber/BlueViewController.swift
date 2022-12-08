//
//  BlueViewController.swift
//  FindNumber
//
//  Created by Dauren Sarsenov on 18.04.2022.
//

import UIKit

class BlueViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    var textForLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel

    }
    

    @IBAction func goToGreenController(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController{
            vc.textForLabel = "Text Nice"
            vc.title = "Green"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
