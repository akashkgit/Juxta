//
//  ViewController.swift
//  Juxta
//
//  Created by akash kumar on 2/17/24.
//

import UIKit
import VisionKit
class ViewController: UIViewController{
    
    var scannerAvail:Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    var chemicalDataApi = ChemicalApi()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        chemicalDataApi.callURL(ingredient: "phosphoric")
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard scannerAvail == true  else {
            print(" haiyaa scannner not supported ");
            return
        }
        let dataScanner = DataScannerViewController(recognizedDataTypes: [.text()],qualityLevel: .accurate, recognizesMultipleItems:true, isHighFrameRateTrackingEnabled: true, isHighlightingEnabled: false)
        dataScanner.delegate = self
        present(dataScanner,animated: true)
        try? dataScanner.startScanning()
        
        
    }
    
    
    
}


extension ViewController:DataScannerViewControllerDelegate{
//    let setting = "sodium lauryl sulfate, butane, isopropyl"
//    
//    let res = matches(for:pattern,in:setting)
    
    
//    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
//        switch item{
//        case .text(let text):
//            //print(" text : \(text.transcript)")
//        default:
//            print(" defaulted ")
//        }
//    }
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        //        print(" added \(addedItems)")
        for items in addedItems{
            switch items{
            case .text(let texts):
                print("input \(texts.transcript)")
                let extracted = matches(in:texts.transcript)
                print("extracted \(extracted) ")
                
            default:
                print(" NA ")
            }
        }
    }

    
    func matches(in text:String) -> [String] {
        let regExp = "([\\w\\s]+,)*([\\w\\s]+)"
        do {
            let regex = try NSRegularExpression(pattern: regExp)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
     

}

