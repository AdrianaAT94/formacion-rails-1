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
  static targets = [ "valor", "aparece", "hide"]  
  static classes = ["display"]

  precios(event) {
    this.apareceTarget.textContent = this.valorTarget.value
  } 

  menumovil(){
     this.hideTarget.classList.toggle(this.displayClass)
  }
}
