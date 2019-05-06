import UIKit


class ViewController: UIViewController {
    
    var sqareView: UIView = {
        let myView = UIView()
        
        myView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        myView.backgroundColor = .green
        
        return myView
    }()
    
    var redSqareView: UIView = {
        let myView = UIView()
        
        myView.frame = CGRect(x: 100, y: 20, width: 80, height: 80)
        myView.backgroundColor = .red
        
        return myView
    }()
    
    var animator = UIDynamicAnimator()
    var snap: UISnapBehavior?
    var snapRed: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createGestureRecognizer()
        self.sqareView.center = self.view.center
        self.view.addSubview(sqareView)
        self.view.addSubview(redSqareView)
        createAnimationAndBehaviors()

    }
    
    
    func createAnimationAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let collision = UICollisionBehavior(items: [sqareView, redSqareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        snap = UISnapBehavior(item: sqareView, snapTo: self.view.center)
        snap?.damping = 1
        animator.addBehavior(snap!)
        
        snapRed = UISnapBehavior(item: redSqareView, snapTo: self.view.center)
        snapRed?.damping = 0.1
        animator.addBehavior(snapRed!)
        
    }
    
    
    func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(paramTap: UITapGestureRecognizer) {
        let tapPoint = paramTap.location(in: self.view)
        
        if snap != nil {
            animator.removeBehavior(snap!)
        }
        
        if snapRed != nil {
            animator.removeBehavior(snapRed!)
        }
        snap = UISnapBehavior(item: sqareView, snapTo: tapPoint)
        snapRed = UISnapBehavior(item: redSqareView, snapTo: tapPoint)
        snap?.damping = 0.5
        snapRed!.damping = 1
        animator.addBehavior(snap!)
        animator.addBehavior(snapRed!)
    }
    
    
    


}

