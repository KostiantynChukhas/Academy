//
//  BarcodeExt.swift
//  Academy
//
//  Created by   on 18.04.2021.
//

import UIKit

class BarcodeGenerate {
    
    static let shared = BarcodeGenerate()
    func createBarcodeFromString(barcode:String) -> UIImage?{

        let data = barcode.data(using: .isoLatin1)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue(7.0, forKey:"inputQuietSpace")
        guard var ciImage = filter.outputImage else {
            return nil
        }

        let imageSize = ciImage.extent.integral
        let outputSize = CGSize(width:3020, height: 600)
        ciImage = ciImage.transformed(by:CGAffineTransform(scaleX: outputSize.width/imageSize.width, y: outputSize.height/imageSize.height))

        let image = convertCIImageToUIImage(ciimage: ciImage)
        return image
    }

   private func convertCIImageToUIImage(ciimage:CIImage)->UIImage{
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(ciimage, from: ciimage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}
