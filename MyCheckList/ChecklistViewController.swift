//
//  ChecklistViewControllerTableViewController.swift
//  MyCheckList
//
//  Created by Student on 2018-01-17.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailsVCDelegate {


    var checkList: [CheckLitsItem]!
      /*  = [CheckLitsItem(text: "List 1", Checked: true),
        CheckLitsItem(text: "Work", Checked: false),
        CheckLitsItem(text: "Study", Checked: true),
        CheckLitsItem(text: "Play", Checked: false),
        CheckLitsItem(text: "rest", Checked: false)]
*/
    override func viewDidLoad() {
        super.viewDidLoad()

        loadChecklist()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let item = CheckLitsItem(text: "Shopping", Checked: false)
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
        let checkmarklabel = cell.viewWithTag(1001) as!
        UILabel
        checkmarklabel.text = "√"
        /* if(checkList[indexPath.row].checked){
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        */
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
            saveChecklist()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let checkmarklabel = cell.viewWithTag(1001) as!
            UILabel
            if (checkmarklabel.text == "√") {
                checkmarklabel.text = ""
            } else {
                checkmarklabel.text = "√"
            }
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
        if(segue.identifier == "Additem") {
            let controller = segue.destination as!
            ItemDetailsViewController
            controller.delegate = self
        } else if(segue.identifier == "EditItem") {
            let controller = segue.destination as!
            ItemDetailsViewController
            controller.delegate = self

            //indetify which cell was touched on
            let indexPath = tableView.indexPath(for: sender as!
            UITableViewCell)
            //extract the data / text
            let item = checkList[indexPath!.row]
            //send the data to ItemDetailsVC
            controller.itemtoEdit = item
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // Mark: ItemDetailsVc Protocol
    func itemDetailsVCDidCancel() {
        navigationController?.popViewController(animated: true)
    }
    func itemDetailsVc(_ control: ItemDetailsViewController,
                       didFinishAdd item: CheckLitsItem) {
        //append item to array

        //update the tableview
        let newRow = checkList.count
        checkList.append(item)
        //save checklist
        saveChecklist()
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    func itemDetailsVC(_ control: ItemDetailsViewController,
                       didFinishEdit item: CheckLitsItem) {
        //update the data source
        if let index = checkList.index(of: item)
            {

            checkList[index].text = item.text
             saveChecklist()
            let indexpath = IndexPath(row: index, section: 0)
            //update the table view
            if let cell = tableView.cellForRow(at: indexpath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = item.text
            }
        }

        //dismiss the itemDetailsVC
        navigationController?.popViewController(animated: true)

    }
    func documnetDirectory() -> URL{
        
       
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilepath() -> URL {
         print(documnetDirectory())
        
        return documnetDirectory().appendingPathComponent("Checklist.plist")
    }
    func saveChecklist(){
        
        //get an encoder
        let encoder = PropertyListEncoder()
        //encode
        do {
        let data = try encoder.encode(checkList)
        //write the encoded data to the dataFilePath
        try data.write(to: dataFilepath())
        } catch{
            print("Encoding Eroor")
        }
        
    }
    func loadChecklist(){
        // get a decoder tool
        let decoder = PropertyListDecoder()
        let path = dataFilepath()
        if let data = try? Data(contentsOf: path){
            
            do {
             checkList =   try decoder.decode([CheckLitsItem].self, from: data)
            } catch {
                print("decoding error")
            }
        }
        //read from the device into objects
        //decode the data
        
    }
    
}
