//
//  OrderViewController.swift
//  Newbie
//
//  Created by Raj.P, Varun (Cognizant) on 12/08/24.
//

import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var empty_Lbl: UILabel!
    @IBOutlet weak var list_TableView: UITableView!
    
    private var orderVM: OrderListViewModel!
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        orderVM = OrderListViewModel(getOrdersViewModel: GetOrdersViewModel(url: URL(string: Constants.Urls.orders)!))
        setInitialView()
        
        fetchOrder()
    }
    
    func addPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        list_TableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        fetchOrder()
    }
    
    func fetchOrder() {
        orderVM.getOrdersViewModel?.fetchOrders(completion: { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let list):
                    self?.orderVM.ordersList = list
                case .failure(let failure):
                    break
                }
                self?.updateTable()
            }
        })
    }

    func setInitialView() {
        list_TableView.delegate = self
        list_TableView.dataSource = self
        list_TableView.register(UINib(nibName: "OrdersListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrdersListTableViewCell")
        
        addPullToRefresh()
    }
    
    func updateTable() {
        refreshControl.endRefreshing()
        list_TableView.reloadData()
    }
    
    func toggleEmptyLabel() {
        if orderVM.noOfRows == 0 {
            empty_Lbl.isHidden = false
        } else {
            empty_Lbl.isHidden = true
        }
    }
}

extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toggleEmptyLabel()
        return orderVM.noOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersListTableViewCell", for: indexPath) as! OrdersListTableViewCell
        cell.setData(data: orderVM.orderAtIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orderVM.orderAtIndex(index: indexPath.row)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewOrderViewController") as! ViewOrderViewController
        vc.orderVM = order
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
