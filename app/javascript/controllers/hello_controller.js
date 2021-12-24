// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "valor", "aparece", "aparece2", "hide", "imageap", "image"]  
  static classes = ["display"]

  precios() {
    var valores = this.valorTarget.value.split(",")
    this.apareceTarget.textContent = valores[1].replace(']', '')
    this.aparece2Target.value = valores[0].replace('[', '')
  } 

  menumovil(){
     this.hideTarget.classList.toggle(this.displayClass)
  }

  change_image(event) {
    this.imageapTarget.src  = event.currentTarget.src
  }
}
