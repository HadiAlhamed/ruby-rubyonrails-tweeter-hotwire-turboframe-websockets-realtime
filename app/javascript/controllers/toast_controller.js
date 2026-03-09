import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // 1. Entrance Animation (Slide in from right)
    this.element.animate([
      { transform: 'translateX(100%)', opacity: 0 },
      { transform: 'translateX(0)', opacity: 1 }
    ], {
      duration: 400,
      easing: 'ease-out'
    })

    // 2. Schedule the Auto-close
    setTimeout(() => {
      this.close()
    }, 4000)
  }

  close() {
    // 3. Exit Animation (Slide out to right)
    const animation = this.element.animate([
      { transform: 'translateX(0)', opacity: 1 },
      { transform: 'translateX(100%)', opacity: 0 }
    ], {
      duration: 400,
      easing: 'ease-in'
    })

    // 4. When the animation FINISHES, remove the element
    animation.onfinish = () => {
      this.element.remove()
    }
  }
}