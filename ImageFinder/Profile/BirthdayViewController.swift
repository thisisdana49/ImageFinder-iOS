//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class BirthdayViewController: UIViewController {

    var contents: ((String) -> Void)?
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        configureView()
    }
    
    @objc
    func datePickerValueChanged(_ sender: UIDatePicker) {
        print(#function, sender.date)
    }
    
    @objc
    func okButtonTapped() {
        contents?(datePicker.date.toFormattedString("yyyy년 MM월 dd일"))
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
}
