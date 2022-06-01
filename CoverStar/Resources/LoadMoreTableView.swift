//
//  LoadMoreTableView.swift
//  CoverStar
//
//  Created by taehan park on 2022/06/02.
//

import UIKit
import MJRefresh

class LoadMoreTableView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var loadMoreFooter = MJRefreshBackGifFooter()

    
    var dataSource : [[AnyObject]] = []
    
    var currentPage : Int = 0
    var totalPage   : Int = 1
    
    
    var onSelect : (_ indexPath : IndexPath) -> Void = {indexPath in}
    var onLoadData : (_ page : Int, _  completed : @escaping ()->Void) -> Void = {page, completed in}
    
    var numberOfRowsInSection : ((_ section : Int) -> Int)?
    var cellForIndex : ((_ tableView : UITableView,_ indexPath : IndexPath) -> UITableViewCell)?

    var headerView : UIView?
    
    var onScroll : (_ scrollView : UIScrollView) -> Void = {scrollView in}
    var onBeginDrag : (_ scrollView : UIScrollView) -> Void = {scrollView in}
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
    }
    
    
    private func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LoadMoreTableView", bundle: bundle)
        contentView = (nib.instantiate(withOwner: self, options: nil)[0] as! UIView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleBottomMargin,.flexibleHeight,.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleWidth]
        
        self.addSubview(contentView)
        
        
        setupTableView()
    }
    
    private func setupTableView() {
    
        //Delegate & Datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.reload), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        //Load More
        loadMoreFooter = MJRefreshBackGifFooter {
            print("load more")
            self.loadData(page: self.currentPage+1)
        }
        loadMoreFooter.setTitle("Drag up to load more", for: .idle)
        loadMoreFooter.setTitle("Loading more...", for: .refreshing)
        loadMoreFooter.setTitle("No more data", for: .noMoreData)
        
        self.tableView.mj_footer = loadMoreFooter
        
        
        //Cell Display
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 0
        self.tableView.estimatedRowHeight = 44
        
    }
    
    func setContentInset(with contentInset : UIEdgeInsets) {
        self.tableView.contentInset = contentInset
        
        updateRefreshPosition()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateRefreshPosition()
    }
    
    func updateRefreshPosition() {
//        self.refreshControl.resetYPositionOfFrame(self.tableView.contentInset.top)
    }
    
    //MARK: - Public interfaces
    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        self.tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    @objc open func reload(){
        currentPage = 0
        dataSource = []
        
        self.tableView.reloadData()
        
        loadData(page: 1)
    }
    
    private func loadData(page : Int) {
        let completed = {
            dispatchMain.async {
                
                self.currentPage = page
                
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
                if self.totalPage <= self.currentPage {
                    self.loadMoreFooter.endRefreshingWithNoMoreData()
                }else {
                    self.loadMoreFooter.endRefreshing()
                }
            }
        }
        onLoadData(page,completed)
    }

}

extension LoadMoreTableView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if numberOfRowsInSection != nil {
            return numberOfRowsInSection!(section)
        }
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if cellForIndex != nil {
            return cellForIndex!(tableView,indexPath)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.onSelect(indexPath)
    }
}


extension LoadMoreTableView : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.onBeginDrag(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.onScroll(scrollView)
        
    }
}


