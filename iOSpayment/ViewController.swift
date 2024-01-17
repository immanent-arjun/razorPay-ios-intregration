//
//  ViewController.swift
//  iOSpayment
//
//  Created by Sonoma on 11/12/23.
//

import UIKit
import Razorpay

class ViewController: UIViewController {
    
    let razorPayKey = "rzp_test_KboS8KMecYRxzP"
    var razorPay: RazorpayCheckout? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btn(_ sender: Any) {
        openRazorPayCheckout()
    }
    
    func openRazorPayCheckout(){
        razorPay = RazorpayCheckout.initWithKey(razorPayKey, andDelegate: self)
        let options: [String:Any] = [
            "amount": "100", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": "purchase description",
           // "order_id": "order_DBJOWzybf0sJbb",
            "image": "https://url-to-image.jpg",
            "name": "business or product name",
            "prefill": [
                "contact": "9797979797",
                "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#F37254"
            ]
        ]
        razorPay?.open(options)
    }
}

extension ViewController : RazorpayPaymentCompletionProtocol {

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
        
    }
    
    func presentAlert(withTitle:String?, message: String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay!", style: .default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}
