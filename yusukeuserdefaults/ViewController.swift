//
//  ViewController.swift
//  yusukeuserdefaults
//
//  Created by yusuke shinmura on 2020/09/19.
//

import UIKit
 
class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {


 
 
    @IBOutlet weak var tableView: UITableView!
 
    
    @IBOutlet weak var textField: UITextField!
    
    var todos: Array<String> = []
   // var done: Bool = false
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        textField.delegate = self
        
        if let aaa = userDefaults.object(forKey: "todos") {
            todos = aaa as! Array<String>
            
        }
        

 
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // セルの数
        return todos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {// セクションの数
        return 1
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {// セルの内容を決める。
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.isUserInteractionEnabled = false
        let todo = todos[indexPath.row]

    
            
        cell.textLabel?.text = todo
                           
        return cell
    }
    
     // セルが選択された時に呼び出される
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let cell = tableView.cellForRow(at:indexPath)

           // チェックマークを入れる
           cell?.accessoryType = .checkmark
       }

       // セルの選択が外れた時に呼び出される
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           let cell = tableView.cellForRow(at:indexPath)

           // チェックマークを外す
           cell?.accessoryType = .none
       }
    
    

    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {// returnキーを押した時の処理

        if let text = self.textField.text {
           
                
            todos.append(text)
            userDefaults.set(todos, forKey: "todos")
            userDefaults.synchronize()
            
            todos = userDefaults.object(forKey: "todos") as! Array<String>
            }
        
        self.textField.text = ""
        
        self.tableView.reloadData() //データをリロードする
        
        return true
}
    
 


    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        // アイテム削除処理
        todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        userDefaults.set(todos, forKey: "todos")
        userDefaults.synchronize()
        
        todos = userDefaults.object(forKey: "todos") as! Array<String>
        self.tableView.reloadData()

    }
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at:indexPath)
//
//         print(#function + "\(indexPath.row)")
//
//
//    }
    
    
    
}



