
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL){
        
        if ImageCache.default.isCached(forKey: url.path) {
            loadImageFromDisk(url)
            return
        }
        
        loadImageFromInternet(url)
    }
    
    private func loadImageFromInternet(_ url: URL) {
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(systemName: "person"),
                         options: [ .processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(url.path)")
                self.image = value.image
                ImageCache.default.store(value.image, forKey: url.path)
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    private func loadImageFromDisk(_ url: URL) {
        ImageCache.default.retrieveImageInDiskCache(forKey: url.path, completionHandler: { [weak self] (result) in
            switch result {
                case .success(let image):
                    self?.setNewImage(image)
                    return
                case .failure(let error):
                    print("Kingfisher retrieveImageInDiskCache error \(error.localizedDescription)")
                    self?.loadImageFromInternet(url)
            }
        })
    }
    
    private func setNewImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}
