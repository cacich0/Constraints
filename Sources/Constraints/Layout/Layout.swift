import UIKit

//public protocol JustifyAnchor {
//    func left(_ constant: CGFloat) -> JustifyAnchor
//    func right(_ constant: CGFloat) -> JustifyAnchor
//
//    func leading(_ constant: CGFloat) -> JustifyAnchor
//    func trailing(_ constant: CGFloat) -> JustifyAnchor
//
//    func top(_ constant: CGFloat) -> JustifyAnchor
//    func bottom(_ constant: CGFloat) -> JustifyAnchor
//
//    func centerX(_ constant: CGFloat) -> JustifyAnchor
//    func centerY(_ constant: CGFloat) -> JustifyAnchor
//
//    func center(in view: UIView) -> Layout
//    func center() -> Layout
//    func horizontally() -> Layout.Anchor
//    func vertically() -> Layout.Anchor
//    func height(_ constant: CGFloat) -> Layout.Anchor
//    func width(_ constant: CGFloat) -> Layout.Anchor
//    func dispose(in disposable: inout Layout.Constraint?) -> Layout.Anchor
//    func active(_ value: Layout.Anchor.Active) -> Layout.Anchor
//    func activate()
//
//    var left: Layout.Anchor { get }
//    var right: Layout.Anchor { get }
//
//    var leading: Layout.Anchor { get }
//    var trailing: Layout.Anchor { get }
//
//    var top: Layout.Anchor { get }
//    var bottom: Layout.Anchor { get }
//
//    var centerX: Layout.Anchor { get }
//    var centerY: Layout.Anchor { get }
//
//    var firstBaseline: Layout.Anchor { get }
//    var lastBaseline: Layout.Anchor { get }
//
//    var width: Layout.Anchor { get }
//    var height: Layout.Anchor { get }
//}
//
//
//public protocol PerfectAnchor: JustifyAnchor {
//    func equal(
//        _ view: UIView,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func equal(
//        _ anchor: NSLayoutXAxisAnchor,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func equal(
//        _ anchor: NSLayoutYAxisAnchor,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func equal(
//        _ dimension: NSLayoutAnchor<NSLayoutDimension>,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//
//    func less(
//        _ view: UIView,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func less(
//        _ anchor: NSLayoutXAxisAnchor,
//        _ constant: CGFloat)
//    -> Layout.Anchor
//    func less(
//        _ anchor: NSLayoutYAxisAnchor,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func less(
//        _ dimension: NSLayoutAnchor<NSLayoutDimension>,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//
//    func greater(
//        _ view: UIView,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func greater(
//        _ anchor: NSLayoutXAxisAnchor,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func greater(
//        _ anchor: NSLayoutYAxisAnchor,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//    func greater(
//        _ dimension: NSLayoutAnchor<NSLayoutDimension>,
//        _ constant: CGFloat
//    ) -> Layout.Anchor
//}

extension Layout {
    public class Anchor {
        fileprivate var layout: Layout
        
        fileprivate var type: List
        fileprivate var constraint: Constraint?
        fileprivate var view: UIView?
        
        fileprivate init(layout: Layout, type: List) {
            self.layout = layout
            self.type = type
        }
        
        fileprivate func active() {
            constraint?.active = true
        }
        
        fileprivate func _width(_ constant: CGFloat) -> Anchor {
            var constraint: NSLayoutConstraint?
            constraint = layout.view?.width.constraint(equalToConstant: constant)
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        fileprivate func _height(_ constant: CGFloat) -> Anchor {
            var constraint: NSLayoutConstraint?
            constraint = layout.view?.height.constraint(equalToConstant: constant)
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        
        public func center(in view: UIView) -> Layout {
            let _ = layout.centerX.equal(view)
            let _ = layout.centerY.equal(view)
            return layout
        }
        public func center() -> Layout {
            guard let superview = view?.superview else {
                return layout
            }
            
            let _ = layout.centerX.equal(superview)
            let _ = layout.centerY.equal(superview)
            
            return layout
        }
        public func horizontally() -> Anchor {
            layout.horizontally()
        }
        public func vertically() -> Anchor {
            layout.vertically()
        }
        
        public func left(_ constant: CGFloat = 0) -> Anchor {
            return layout.left(constant)
        }
        public func right(_ constant: CGFloat = 0) -> Anchor {
            return layout.right(constant)
        }
        
        public func leading(_ constant: CGFloat = 0) -> Anchor {
            return layout.leading(constant)
        }
        public func trailing(_ constant: CGFloat = 0) -> Anchor {
            return layout.trailing(constant)
        }
        
        public func top(_ constant: CGFloat = 0) -> Anchor {
            return layout.top(constant)
        }
        public func bottom(_ constant: CGFloat = 0) -> Anchor {
            return layout.bottom(constant)
        }
        
        public func centerX(_ constant: CGFloat = 0) -> Anchor {
            return layout.centerX(constant)
        }
        public func centerY(_ constant: CGFloat = 0) -> Anchor {
            return layout.centerY(constant)
        }
        
        public func equal(
            _ view: UIView,
            _ constant: CGFloat = 0
        ) -> Anchor {
            self.view = view
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(equalTo: view.left, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(equalTo: view.right, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(equalTo: view.leading, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(equalTo: view.trailing, constant: abs)
            case .top          : constraint = layout.view?.top.constraint(equalTo: view.top, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(equalTo: view.bottom, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(equalTo: view.centerX, constant: constant)
            case .centerY      : constraint = layout.view?.centerY.constraint(equalTo: view.centerY, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(equalTo: view.firstBaseline, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(equalTo: view.firstBaseline, constant: constant)
            case .width        : constraint = layout.view?.width.constraint(equalTo: view.width, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(equalTo: view.height, constant: constant)
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func equal(
            _ anchor: NSLayoutXAxisAnchor,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(equalTo: anchor, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(equalTo: anchor, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(equalTo: anchor, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(equalTo: anchor, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(equalTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func equal(
            _ anchor: NSLayoutYAxisAnchor,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .top          : constraint = layout.view?.top.constraint(equalTo: anchor, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(equalTo: anchor, constant: abs)
            case .centerY      : constraint = layout.view?.centerY.constraint(equalTo: anchor, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(equalTo: anchor, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(equalTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func equal(
            _ dimension: NSLayoutAnchor<NSLayoutDimension>,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            switch type {
            case .width        : constraint = layout.view?.width.constraint(equalTo: dimension, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(equalTo: dimension, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func less(
            _ view: UIView,
            _ constant: CGFloat = 0
        ) -> Anchor {
            self.view = view
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(lessThanOrEqualTo: view.left, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(lessThanOrEqualTo: view.right, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(lessThanOrEqualTo: view.leading, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(lessThanOrEqualTo: view.trailing, constant: abs)
            case .top          : constraint = layout.view?.top.constraint(lessThanOrEqualTo: view.top, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(lessThanOrEqualTo: view.bottom, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(lessThanOrEqualTo: view.centerX, constant: constant)
            case .centerY      : constraint = layout.view?.centerY.constraint(lessThanOrEqualTo: view.centerY, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(lessThanOrEqualTo: view.firstBaseline, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(lessThanOrEqualTo: view.firstBaseline, constant: constant)
            case .width        : constraint = layout.view?.width.constraint(lessThanOrEqualTo: view.width, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(lessThanOrEqualTo: view.height, constant: constant)
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func less(
            _ anchor: NSLayoutXAxisAnchor,
            _ constant: CGFloat = 0)
        -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(lessThanOrEqualTo: anchor, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(lessThanOrEqualTo: anchor, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(lessThanOrEqualTo: anchor, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(lessThanOrEqualTo: anchor, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(lessThanOrEqualTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func less(
            _ anchor: NSLayoutYAxisAnchor,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .top          : constraint = layout.view?.top.constraint(lessThanOrEqualTo: anchor, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(lessThanOrEqualTo: anchor, constant: abs)
            case .centerY      : constraint = layout.view?.centerY.constraint(lessThanOrEqualTo: anchor, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(lessThanOrEqualTo: anchor, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(lessThanOrEqualTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func less(
            _ dimension: NSLayoutAnchor<NSLayoutDimension>,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            switch type {
            case .width        : constraint = layout.view?.width.constraint(lessThanOrEqualTo: dimension, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(lessThanOrEqualTo: dimension, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func greater(
            _ view: UIView,
            _ constant: CGFloat = 0
        ) -> Anchor {
            self.view = view
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(greaterThanOrEqualTo: view.left, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(greaterThanOrEqualTo: view.right, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(greaterThanOrEqualTo: view.left, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(greaterThanOrEqualTo: view.trailing, constant: abs)
            case .top          : constraint = layout.view?.top.constraint(greaterThanOrEqualTo: view.top, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(greaterThanOrEqualTo: view.bottom, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(greaterThanOrEqualTo: view.centerX, constant: constant)
            case .centerY      : constraint = layout.view?.centerY.constraint(greaterThanOrEqualTo: view.centerY, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(greaterThanOrEqualTo: view.firstBaseline, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(greaterThanOrEqualTo: view.firstBaseline, constant: constant)
            case .width        : constraint = layout.view?.width.constraint(greaterThanOrEqualTo: view.width, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(greaterThanOrEqualTo: view.height, constant: constant)
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func greater(
            _ anchor: NSLayoutXAxisAnchor,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .left         : constraint = layout.view?.left.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .right        : constraint = layout.view?.right.constraint(greaterThanOrEqualTo: anchor, constant: abs)
            case .leading      : constraint = layout.view?.leading.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .trailing     : constraint = layout.view?.trailing.constraint(greaterThanOrEqualTo: anchor, constant: abs)
            case .centerX      : constraint = layout.view?.centerX.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func greater(
            _ anchor: NSLayoutYAxisAnchor,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            let abs = constant < 0 ? abs(constant) : -constant
            switch type {
            case .top          : constraint = layout.view?.top.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .bottom       : constraint = layout.view?.bottom.constraint(greaterThanOrEqualTo: anchor, constant: abs)
            case .centerY      : constraint = layout.view?.centerY.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .firstBaseline: constraint = layout.view?.firstBaseline.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            case .lastBaseline : constraint = layout.view?.lastBaseline.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        public func greater(
            _ dimension: NSLayoutAnchor<NSLayoutDimension>,
            _ constant: CGFloat = 0
        ) -> Anchor {
            var constraint: NSLayoutConstraint?
            switch type {
            case .width        : constraint = layout.view?.width.constraint(greaterThanOrEqualTo: dimension, constant: constant)
            case .height       : constraint = layout.view?.height.constraint(greaterThanOrEqualTo: dimension, constant: constant)
            default            : break
            }
            guard let constraint else { return self }
            self.constraint = .init(value: constraint)
            return self
        }
        
        public func height(_ constant: CGFloat) -> Anchor {
            layout.height(constant)
        }
        public func width(_ constant: CGFloat) -> Anchor {
            layout.width(constant)
        }
        
        public func constant(_ value: CGFloat) -> Anchor {
            let _abs: CGFloat
            switch type {
            case .bottom, .right, .trailing:
                _abs = value < 0 ? abs(value) : -value
            default:
                _abs = value
            }
            constraint?.constant = _abs
            return self
        }
        public func multiplier(_ value: CGFloat) -> Anchor {
            constraint?.multiplier = value
            return self
        }
        
        public func dispose(in disposable: inout Constraint?) -> Anchor {
            guard let constraint else { return self }
            disposable = constraint
            return self
        }
        
        public func active(_ value: Active) -> Anchor {
            if value == .later {
                constraint?.needActive = false
            }
            return self
        }
        
        public func activate() {
            layout.activate()
        }
        
        public var left: Anchor {
            return layout.left
        }
        public var right: Anchor {
            return layout.right
        }
        
        public var leading: Anchor {
            return layout.leading
        }
        public var trailing: Anchor {
            return layout.trailing
        }
        
        public var top: Anchor {
            return layout.top
        }
        public var bottom: Anchor {
            return layout.bottom
        }
        
        public var centerX: Anchor {
            return layout.centerX
        }
        public var centerY: Anchor {
            return layout.centerY
        }
        
        public var firstBaseline: Anchor {
            return layout.firstBaseline
        }
        public var lastBaseline: Anchor {
            return layout.lastBaseline
        }
        
        public var width: Anchor {
            return layout.width
        }
        public var height: Anchor {
            return layout.height
        }
        
    }
}

extension Layout.Anchor {
    public enum Active {
        case now
        case later
    }
    
    fileprivate enum List: CaseIterable {
        case left
        case right
        
        case leading
        case trailing
        
        case top
        case bottom
        
        case centerX
        case centerY
        
        case firstBaseline
        case lastBaseline
        
        case width
        case height
    }
}

public class Layout {
    fileprivate var view: UIView?
    
    private lazy var anchors: [Anchor]? = Anchor.List.allCases.map { Anchor(layout: self, type: $0) }
    
    public init(view: UIView) {
        self.view = view
        self.view?.auto = false
    }
    
    public func height(_ constant: CGFloat) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .height }) else {
            let anchor = Anchor(layout: self, type: .height)
            anchors?.append(anchor)
            return anchor
        }
        return anchor._height(constant)
    }
    public func width(_ constant: CGFloat) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .width }) else {
            let anchor = Anchor(layout: self, type: .width)
            anchors?.append(anchor)
            return anchor
        }
        return anchor._width(constant)
    }
    public func size(_ constant: CGFloat) -> Layout {
        guard let anchors,
              let width = anchors.first(where: { $0.type == .width }),
              let height = anchors.first(where: { $0.type == .height })
        else {
            return self
        }
        let _ = width._width(constant)
        let _ = height._height(constant)
        return self
    }
    public func size(w: CGFloat, h: CGFloat) -> Layout {
        guard let anchors,
              let width = anchors.first(where: { $0.type == .width }),
              let height = anchors.first(where: { $0.type == .height })
        else {
            return self
        }
        let _ = width._width(w)
        let _ = height._height(h)
        return self
    }
    public func box(in view: UIView, insets: UIEdgeInsets = .zero, safeAreaIgnore: Bool = false) -> Layout {
        guard let anchors,
              let leading = anchors.first(where: { $0.type == .leading }),
              let trailing = anchors.first(where: { $0.type == .trailing }),
              let top = anchors.first(where: { $0.type == .top }),
              let bottom = anchors.first(where: { $0.type == .bottom })
        else {
            return self
        }
        let _ = leading.equal(view, insets.left)
        let _ = trailing.equal(view, insets.right)
        let _ = top.equal(safeAreaIgnore ? view.top : view.safeTop, insets.top)
        let _ = bottom.equal(safeAreaIgnore ? view.bottom: view.safeBottom, insets.bottom)
        return self
    }
    public func box(insets: UIEdgeInsets = .zero, safeAreaIgnore: Bool = false) -> Layout {
        guard let anchors,
              let leading = anchors.first(where: { $0.type == .leading }),
              let trailing = anchors.first(where: { $0.type == .trailing }),
              let top = anchors.first(where: { $0.type == .top }),
              let bottom = anchors.first(where: { $0.type == .bottom }),
              let superview = view?.superview
        else {
            return self
        }
        let _ = leading.equal(superview, insets.left)
        let _ = trailing.equal(superview, insets.right)
        let _ = top.equal(safeAreaIgnore ? superview.top : superview.safeTop, insets.top)
        let _ = bottom.equal(safeAreaIgnore ? superview.bottom: superview.safeBottom, insets.bottom)
        return self
    }
    public func center(in view: UIView) -> Layout {
        guard let anchors,
              let centerX = anchors.first(where: { $0.type == .centerX }),
              let centerY = anchors.first(where: { $0.type == .centerY })
        else {
            return self
        }
        let _ = centerX.equal(view)
        let _ = centerY.equal(view)
        return self
    }
    public func center() -> Anchor {
        guard let anchors,
              let centerX = anchors.first(where: { $0.type == .centerX }),
              let centerY = anchors.first(where: { $0.type == .centerY }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .centerY)
            anchors?.append(anchor)
            return anchor
        }
        
        let _ = centerX.equal(superview)
        return centerY.equal(superview)
    }
    public func horizontally() -> Anchor {
        guard let anchors,
              let centerX = anchors.first(where: { $0.type == .centerX }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .centerX)
            anchors?.append(anchor)
            return anchor
        }
        
        return centerX.equal(superview)
    }
    public func vertically() -> Anchor {
        guard let anchors,
              let centerY = anchors.first(where: { $0.type == .centerY }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .centerY)
            anchors?.append(anchor)
            return anchor
        }
        
        return centerY.equal(superview)
    }
    
    public func left(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .left }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .left)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    public func right(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .right }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .right)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    
    public func leading(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .leading }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .leading)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    public func trailing(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .trailing }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .trailing)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    
    public func top(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .top }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .top)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    public func bottom(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .bottom }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .bottom)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    
    public func centerX(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .centerX }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .centerX)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    public func centerY(_ constant: CGFloat = 0) -> Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .centerY }),
              let superview = view?.superview else {
            let anchor = Anchor(layout: self, type: .centerY)
            anchors?.append(anchor)
            return anchor
        }
        
        return anchor.equal(superview, constant)
    }
    
    public var left: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .left }) else {
            let anchor = Anchor(layout: self, type: .left)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var right: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .right }) else {
            let anchor = Anchor(layout: self, type: .right)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public var leading: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .leading }) else {
            let anchor = Anchor(layout: self, type: .leading)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var trailing: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .trailing }) else {
            let anchor = Anchor(layout: self, type: .trailing)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public var top: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .top }) else {
            let anchor = Anchor(layout: self, type: .top)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var bottom: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .bottom }) else {
            let anchor = Anchor(layout: self, type: .bottom)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public var firstBaseline: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .firstBaseline }) else {
            let anchor = Anchor(layout: self, type: .firstBaseline)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var lastBaseline: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .lastBaseline }) else {
            let anchor = Anchor(layout: self, type: .lastBaseline)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public var centerX: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .centerX }) else {
            let anchor = Anchor(layout: self, type: .centerX)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var centerY: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .centerY }) else {
            let anchor = Anchor(layout: self, type: .centerY)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public var width: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .width }) else {
            let anchor = Anchor(layout: self, type: .width)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    public var height: Anchor {
        guard let anchors,
              let anchor = anchors.first(where: { $0.type == .height }) else {
            let anchor = Anchor(layout: self, type: .height)
            anchors?.append(anchor)
            return anchor
        }
        return anchor
    }
    
    public func activate() {
        anchors?
            .filter { $0.constraint?.needActive ?? false }
            .forEach {
                $0.active()
            }
        anchors = nil
    }
}

extension Layout {
    public class Constraint {
        public var value: NSLayoutConstraint
        public var constant: CGFloat {
            get { value.constant }
            set { value.constant = newValue }
        }
        public var multiplier: CGFloat {
            get { value.multiplier }
            set {
                if let new = value.multiplier(newValue) {
                    (value.firstItem as? UIView)?.removeConstraint(value)
                    (value.firstItem as? UIView)?.addConstraint(new)
                    value = new
                    active = true
                }
            }
        }
        public var active: Bool {
            get { value.isActive }
            set { value.isActive = newValue }
        }
        
        public func activate() {
            active = true
        }
        
        public func activate(
            with animation: Animation,
            completion: ((Bool) -> Void)? = nil
        ) {
            switch animation {
            case .default(let duration, let delay, let options):
                UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                    self.activate()
                    self.value.firstItem?.setNeedsLayout()
                    self.value.firstItem?.layoutIfNeeded()
                }, completion: completion)
            case .spring(let duration, let delay, let damping, let velocity, let options):
                UIView.animate(withDuration: duration,
                               delay: delay,
                               usingSpringWithDamping: damping,
                               initialSpringVelocity: velocity,
                               options: options,
                               animations: {
                    self.activate()
                    self.value.firstItem?.setNeedsLayout()
                    self.value.firstItem?.layoutIfNeeded()
                }, completion: completion)
            }
        }
        
        public func animate(
            _ value: CGFloat,
            with animation: Animation,
            completion: ((Bool) -> Void)? = nil
        ) {
            constant = value
            activate(with: animation, completion: completion)
        }
        
        public func replace(
            to view: UIView,
            attribute: NSLayoutConstraint.Attribute,
            constant: CGFloat? = nil
        ) {
            guard let new = value.replaceItem(view, attribute, constant) else { return }
            value.isActive = false
            new.isActive = true
            value = new
        }
        
        public func replace(
            to view: UIView,
            attribute: NSLayoutConstraint.Attribute,
            constant: CGFloat? = nil,
            with animation: Animation,
            completion: ((Bool) -> Void)? = nil
        ) {
            replace(to: view, attribute: attribute, constant: constant)
            activate(with: animation, completion: completion)
        }
        
        fileprivate var needActive: Bool = true
        
        fileprivate init(value: NSLayoutConstraint) {
            self.value = value
        }
    }
}

extension Layout.Constraint {
    public enum Animation {
        case `default`(
            duration: TimeInterval,
            delay: TimeInterval = 0,
            options: UIView.AnimationOptions = []
        )
        case spring(
            duration: TimeInterval,
            delay: TimeInterval = 0,
            damping: CGFloat,
            initialVelocity: CGFloat,
            options: UIView.AnimationOptions = []
        )
    }
}

extension NSLayoutConstraint {
    fileprivate func multiplier(_ value: CGFloat) -> NSLayoutConstraint? {
        guard let item = firstItem else { return nil }
        return NSLayoutConstraint(item: item,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: value,
                                  constant: constant)
    }
    fileprivate func replaceItem(
        _ new: UIView,
        _ attribute: Attribute,
        _ constant: CGFloat?
    ) -> NSLayoutConstraint? {
        guard let item = firstItem else { return nil }
        return NSLayoutConstraint(item: item,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: new,
                                  attribute: attribute,
                                  multiplier: multiplier,
                                  constant: constant ?? self.constant)
    }
}

public extension UIView {
    var layout: Layout {
        return Layout(view: self)
    }
}

public extension UIView {
    var auto: Bool {
        get { translatesAutoresizingMaskIntoConstraints }
        set { translatesAutoresizingMaskIntoConstraints = false }
    }
    
    var left: NSLayoutXAxisAnchor { leftAnchor }
    var right: NSLayoutXAxisAnchor { rightAnchor }
    
    var leading: NSLayoutXAxisAnchor { leadingAnchor }
    var trailing: NSLayoutXAxisAnchor { trailingAnchor }
    
    var top: NSLayoutYAxisAnchor { topAnchor }
    var bottom: NSLayoutYAxisAnchor { bottomAnchor }
    
    var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    
    var safeTop: NSLayoutYAxisAnchor { safeAreaLayoutGuide.topAnchor }
    var safeBottom: NSLayoutYAxisAnchor { safeAreaLayoutGuide.bottomAnchor }
    
    var safeCenterX: NSLayoutXAxisAnchor { safeAreaLayoutGuide.centerXAnchor }
    var safeCenterY: NSLayoutYAxisAnchor { safeAreaLayoutGuide.centerYAnchor }
    
    var firstBaseline: NSLayoutYAxisAnchor { firstBaselineAnchor }
    var lastBaseline: NSLayoutYAxisAnchor { lastBaselineAnchor }
    
    var width: NSLayoutDimension { widthAnchor }
    var height: NSLayoutDimension  { heightAnchor }
}

extension UIView {
    public func removeAllConstraints() {
        var _superview = self.superview
        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }
        self.removeConstraints(self.constraints)
        self.auto = true
    }
}

public extension Array where Element == Layout.Constraint? {
    func activate() {
        forEach { $0?.activate() }
    }
    
    func activate(
        with animation: Layout.Constraint.Animation,
        completion: ((Bool) -> Void)? = nil
    ) {
        forEach { $0?.activate(with: animation, completion: completion) }
    }
}

