

import UIKit

class ViewController: UIViewController {
  
    var isGraphViewShowing = false
    
    
  //Counter outlets
  @IBOutlet weak var counterView: CounterView!
  @IBOutlet weak var counterLabel: UILabel!
  @IBOutlet weak var contrainerView: UIView!
  @IBOutlet weak var graphView: GraphView!
  
  @IBAction func pushButtonPressed(_ button: PushButton) {
    if button.isAddButton {
      counterView.counter += 1
    } else {
      if counterView.counter > 0 {
        counterView.counter -= 1
      }
    }
    counterLabel.text = String(counterView.counter)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    counterLabel.text = String(counterView.counter) 
  }
  
    
    @IBAction func counterViewTap(_ gesture: UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            //hide Graph
            UIView.transition(from: graphView,
                              to: counterView,
                              duration: 1.0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion:nil)
        } else {
            //show Graph
            UIView.transition(from: counterView,
                              to: graphView,
                              duration: 1.0,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }
}

