//
//  ChecklistViewControllerTableViewController.swift
//  MyCheckList
//
//  Created by Student on 2018-01-17.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailsVCDelegate {
    
    var checkList = [CheckLitsItem(text:"List 1", Checked: true),
                     CheckLitsItem(text:"Work", Checked: false),
                     CheckLitsItem(text:"Study", Checked: true),
                     CheckLitsItem(text:"Play", Checked: false),
                    CheckLitsItem(text:"rest", Checked: false)]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let item = CheckLitsItem(text:"Shopping", Checked: false)
        let newRow = checkList.count
        checkList.append(item)
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checkList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
         let label = cell.viewWithTag(1000) as! UILabel
         label.text = checkList[indexPath.row].text
        
        if(checkList[indexPath.row].checked){
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
//        if(indexPath.row == 1){
//        label.text = "Walk on the Beach"
//        } else{
//             label.text = "Walk Second"
//        }
        
          return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            checkList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
  
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //who is my down stream Vc
        //i will be its delegate
        if(segue.identifier == "AddItem"){
            let controller = segue.destination as!
            ItemDetailsViewController
            controller.delegate = self
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // Mark: ItemDetailsVc Protocol
    func itemDetailsVCDidCancel(){
        navigationController?.popViewController(animated: true)
    }
    func itemDetailsVc( _ control: ItemDetailsViewController,
                        didFinishAdd item: CheckLitsItem) {
        //append item to array
        
        //update the tableview
        let newRow = checkList.count
        checkList.append(item)
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func itemDetailsVC( _ control: ItemDetailsViewController,
                        didFinishEdit item: CheckLitsItem){}

}
