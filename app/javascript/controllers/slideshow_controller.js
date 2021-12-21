// src/controllers/slideshow_controller.js
import { Controller } from "@hotwired/stimulus"
const slides = 3;

export default class extends Controller {
  static targets = [ "slide" ]
  static values = { index: Number }

  next() {
    if (this.indexValue == slides) {
      this.indexValue = 0 
    }
    else if (this.indexValue < slides && this.indexValue >= 0) {
      this.indexValue++
    }
  }

  previous() {
    if (this.indexValue == 0) {
      this.indexValue = slides 
    }
    else if (this.indexValue > 0 && this.indexValue <= slides) {
      this.indexValue--
    }
  }

  indexValueChanged() {
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    })
  }
}