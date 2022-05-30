//
//  TermsVC.swift
//  CellTest
//
//  Created by taehan park on 2022/04/01.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class LegalAgreeViewController: UIViewController {
    
    @IBOutlet weak var tblTerms: UITableView!
    @IBOutlet weak var btnAllAccept: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var BBBack: UIBarButtonItem!
    
    var viewModel = LegalAgreeViewModel()
    let bag = DisposeBag()
    var isCheckedBtnAllAccept: Bool = false {
        didSet {
            let checkImageName = isCheckedBtnAllAccept ? "circle.fill" : "circle"
            btnAllAccept.setImage(UIImage(systemName: checkImageName), for: .normal)
        }
    }
    
    @IBAction func btnConfirm_Click(_ sender: AnyObject) {
        if isCheckedBtnAllAccept {
            performSegue(withIdentifier: "country", sender: self)
        }else{
            let alert = UIAlertController(title: "필수 선택", message: "필수 선택은 모두 동의 하셔야 합니다.", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "확인", style: .default) { []
                (action:UIAlertAction!) in
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
                }
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupOutputBinding()
        setupInputBinding()
    }

    private func setupView() {
        
        BBBack.action = #selector(backButtonPressed(sender:))
        
        tblTerms.delegate = self
        tblTerms.dataSource = self
        let nibName = String(describing: TermsCell.self)
        tblTerms.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }

    private func setupInputBinding() {
        rx.viewWillAppear.take(1).asDriver(onErrorRecover: { _ in return .never()})
            .drive(onNext: { [weak self] _ in
                self?.viewModel.viewWillAppear()
            }).disposed(by: bag)

        btnAllAccept.rx.tap.asDriver(onErrorRecover: {_ in return .never()})
            .drive(onNext: { [weak self] in
                self?.isCheckedBtnAllAccept.toggle()
                self?.viewModel.acceptAllTerms(self?.isCheckedBtnAllAccept)
            }).disposed(by: bag)
    }

    private func setupOutputBinding() {
        viewModel.updateTermsContents.asDriver(onErrorRecover: {_ in return .never()})
            .drive(onNext: { [weak self] in
                self?.tblTerms.reloadData()
            }).disposed(by: bag)

        viewModel.satisfyTermsPermission.asDriver(onErrorRecover: {_ in return .never()})
            .drive(onNext: { [weak self] isSatisfy in
                self?.btnConfirm.isEnabled = isSatisfy
            }).disposed(by: bag)

        viewModel.acceptAllTerms.asDriver(onErrorRecover: {_ in return .never()})
            .drive(onNext: { [weak self] isAcceptAllTerms in
                self?.isCheckedBtnAllAccept = isAcceptAllTerms
            }).disposed(by: bag)
    }
    
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
}

extension LegalAgreeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataSource[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TermsCell.self)) as! TermsCell
        cell.selectionStyle = .none
        cell.bind(viewModel.dataSource[indexPath.section][indexPath.row])
        cell.btnCheck.rx.tap.asDriver(onErrorRecover: { _ in return .never()})
            .drive(onNext: { [weak self] in
                self?.viewModel.didSelectTermsCell(indexPath: indexPath)
            }).disposed(by: cell.bag)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectTermsCell(indexPath: indexPath)
    }
}
