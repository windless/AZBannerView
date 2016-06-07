
import UIKit
import Kingfisher

public protocol AZBannerViewDelegate {
    func bannerView(bannerView: AZBannerView, didClick page:Int)
}

public class AZBannerView: UIView, UIScrollViewDelegate {
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    var currentPage: Int {
        get {
            return pageControl.currentPage
        }
        set {
            pageControl.currentPage = newValue
        }
    }
    var timer: NSTimer?
    public var delegate: AZBannerViewDelegate?
    public var timeInterval: NSTimeInterval = 10
    public var pageIndicatorTintColor: UIColor? {
        get {
            return pageControl.pageIndicatorTintColor
        }
        set {
            pageControl.pageIndicatorTintColor = newValue
        }
    }
    public var currentPageIndicatorTintColor: UIColor? {
        get {
            return pageControl.currentPageIndicatorTintColor
        }
        set {
            pageControl.currentPageIndicatorTintColor = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        addSubview(scrollView)
        
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        addSubview(pageControl)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var imageUrls: [String] = [] {
        willSet {
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            
            var views: [UIImageView] = []
            for i in 0..<newValue.count {
                let imageView = UIImageView()
                imageView.tag = i
                imageView.userInteractionEnabled = true
                imageView.contentMode = .ScaleAspectFit
                if let url = NSURL(string: newValue[i]) {
                    imageView.kf_setImageWithURL(url)
                }
                scrollView.addSubview(imageView)
                views.append(imageView)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(AZBannerView.tapImage(_:)))
                imageView.addGestureRecognizer(tap)
            }
            imageViews = views
            
            pageControl.numberOfPages = newValue.count
            
            setNeedsLayout()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: CGFloat(self.imageUrls.count) * self.frame.size.width,
                                  height: self.frame.size.height)
        
        pageControl.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        pageControl.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 10)
        
        for i in 0..<imageViews.count {
            let frame = CGRect(
                x: 0 + (CGFloat(i) * scrollView.frame.size.width),
                y: 0,
                width: scrollView.frame.size.width,
                height: scrollView.frame.size.height
            )
            imageViews[i].frame = frame
        }
    }
    
    private var imageViews: [UIImageView] = []
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = CGRectGetWidth(scrollView.frame)
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        currentPage = Int(page)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        stopAnimating()
    }
    
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAnimating()
    }
    
    public func startAnimating() {
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(
            timeInterval,
            target: self,
            selector: #selector(AZBannerView.scrollToNextPage),
            userInfo: nil,
            repeats: true
        )
    }
    
    public func stopAnimating() {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollToNextPage() {
        let page = (self.currentPage + 1) % self.imageUrls.count
        let pageWidth = self.scrollView.frame.size.width
        let pageHeight = self.scrollView.frame.size.height
        let rect = CGRect(x: CGFloat(page) * pageWidth, y: 0, width: pageWidth, height: pageHeight)
        self.scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    func tapImage(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            delegate?.bannerView(self, didClick: view.tag)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}























