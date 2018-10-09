//
//  ViewController.swift
//  Efemeride
//
//  Created by STR on 09/10/18.
//  Copyright © 2018 STR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var client: MSClient!
    private var table: MSTable!
    private var listaDatas: [(dia: Int, mes: Int, efemeride: String)] = []

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        client = MSClient(applicationURLString: "https://efermerideapp.azurewebsites.net")
        table = client.table(withName: "dateEfermeride")
        
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    //================================================================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return listaDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! DatasTableViewCell
        let indice = indexPath.row
        
        let dia = String(format: "%02d", listaDatas[indice].dia)
        let mes = String(format: "%02d", listaDatas[indice].mes)
        
        cell.data.text = "\(dia)/\(mes)/"
        cell.evento.text = listaDatas[indice].efemeride
        
        return cell
    }
    
    //=================================================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mudarData(_ sender: UIDatePicker) {
        
        let components = NSCalendar.current.dateComponents([.month,.day], from: datePicker.date)
        listaDatas.removeAll()
        tableView.reloadData()
        
        let query = table.query(with: NSPredicate(format: "dia == \(String(describing: components.day)) && mes == \(String(describing: components.month))"))
        
        query.read(completion: {(result, error) in
            if let error = error{
                print("Error: ", error)
            }else if let items = result?.items{
                self.listaDatas.removeAll()
                if items.count  > 0 {
                    for item in items {
                        let data = (dia: item["dia"] as! Int, mes: item["mes"] as! Int,
                                    efemeride: item["efemeride"] as! String)
                        self.listaDatas.append(data)
                    }
                    
                    self.tableView.reloadData()
                }else {
                    print("Não existe data para esse dia!")
                }
            }
        })
    }
    
}

