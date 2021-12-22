// src/controllers/slideshow_controller.js
import { Controller } from "@hotwired/stimulus"
const slides = 3;

export default class extends Controller {
  static targets = [ "slide" ]
  static classes = [ "currentSlide" ]
  static values = { index: Number }

  next() {
    if (this.indexValue == this.lastIndex) {
      this.indexValue = 0 
    }
    else if (this.indexValue < this.lastIndex && this.indexValue >= 0) {
      this.indexValue++
    }
  }

  previous() {
    if (this.indexValue == 0) {
      this.indexValue = this.lastIndex 
    }
    else if (this.indexValue > 0 && this.indexValue <= this.lastIndex) {
      this.indexValue--
    }
  }

  indexValueChanged() {
    this.render()
  }

  render() {
    this.slideTargets.forEach((element, index) => {
      element.classList.toggle(this.currentSlideClass, index == this.indexValue)
    })
  }

  get lastIndex() {
    return this.slideTargets.length - 1
  }
}