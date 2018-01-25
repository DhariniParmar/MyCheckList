//
//  ItemDetailsViewController.swift
//  MyCheckList
//
//  Created by Student on 2018-01-17.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

protocol ItemDetailsVCDelegate: class {
    func itemDetailsVCDidCancel()
    func itemDetailsVc( _ control: ItemDetailsViewController,
                        didFinishAdd item: CheckLitsItem)
    func itemDetailsVC( _ control: ItemDetailsViewController,
                        didFinishEdit item: CheckLitsItem)
    
}

class ItemDetailsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemtoEdit {
        textField.text = item.text
            self.title = "Edit Item"
    } else
    
        {
            title = "Add Item"
        }
    }
    
    weak var delegate:ItemDetailsVCDelegate?
    var itemtoEdit:CheckLitsItem?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        delegate?.itemDetailsVCDidCancel()
    }
    
    
    @IBAction func Done(_ sender: UIBarButtonItem) {
        //if edit, extrct the text, call delegate method finished editing otherwise do one else part
        if let item = itemtoEdit{
            item.text = textField.text!
            delegate?.itemDetailsVC(self, didFinishEdit: item)
            
        } else {
        //extract the textfield contect
        let text = textField.text!
        
        //make a new checklistlitem object
        let item = CheckLitsItem(text: text, Checked: false)
        
        //send it back to the upper strem VC
        delegate?.itemDetailsVc(self, didFinishAdd: item)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var textField: UITextField!
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
