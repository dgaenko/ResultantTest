import UIKit

@IBDesignable class UIPaddingLabel: UILabel {
    
    private var _padding:CGFloat = 0.0;
    
    public var padding:CGFloat {
        
        get { return _padding; }
        set {
            _padding = newValue;
            
            paddingTop = _padding;
            paddingLeft = _padding;
            paddingBottom = _padding;
            paddingRight = _padding;
        }
    }
    
    @IBInspectable var paddingTop:CGFloat = 0.0;
    @IBInspectable var paddingLeft:CGFloat = 0.0;
    @IBInspectable var paddingBottom:CGFloat = 0.0;
    @IBInspectable var paddingRight:CGFloat = 0.0;
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top:paddingTop, left:paddingLeft, bottom:paddingBottom, right:paddingRight);
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets));
    }
    
    override var intrinsicContentSize: CGSize {
        
        get {
            var intrinsicSuperViewContentSize = super.intrinsicContentSize;
            intrinsicSuperViewContentSize.height += paddingTop + paddingBottom;
            intrinsicSuperViewContentSize.width += paddingLeft + paddingRight;
            return intrinsicSuperViewContentSize;
        }
    }
}
