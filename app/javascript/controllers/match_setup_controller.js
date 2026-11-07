import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["mode", "strategy"];

  connect() {
    this.update();
  }

  update() {
    const computer = this.modeTargets.some((input) => input.checked && input.value === "computer");
    this.strategyTarget.disabled = !computer;
  }
}
