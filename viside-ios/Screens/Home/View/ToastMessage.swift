//
//  ToastMessage.swift
//  viside-ios
//
//  Created by JEONGEUN KIM on 2022/11/11.
//


import UIKit
// MARK: - Toast Message
extension HomeViewController {
    func toastMessage( withDuration: Double, delay: Double){
        lazy var toastMessage = PaddingLabel(padding: UIEdgeInsets(top: 17, left: 31, bottom: 15, right: 31)).then {
            $0.frame = CGRect(x: 0, y: 0, width: 260, height: 56)
            $0.alpha = 0.8
            $0.layer.backgroundColor = Color.main500?.cgColor
            $0.layer.cornerRadius = 16
            $0.textColor = .white
            $0.font = Font.xl.extraBold
            let shadow = NSShadow()
            shadow.shadowBlurRadius = 4
            shadow.shadowColor = Color.g500
            $0.attributedText = NSMutableAttributedString(string: "Welcome to V side!", attributes: [NSAttributedString.Key.kern: -0.8, .shadow : shadow])
        }
        self.view.addSubview(toastMessage)
            toastMessage.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(65)
                $0.top.equalToSuperview().offset(394)
                $0.height.equalTo(56)
                $0.width.equalTo(260)
            }
            UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
                toastMessage.alpha = 0.0
               }, completion: {(isCompleted) in
                   toastMessage.removeFromSuperview()
               })
        }
}
