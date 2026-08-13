import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    siteKey: String,
    size: { type: String, default: "compact" },
    theme: { type: String, default: "auto" },
  }

  connect() {
    turnstile.render(this.element, {
      sitekey: this.siteKeyValue,
      size: this.sizeValue,
      theme: this.themeValue,
      callback: this.callback.bind(this),
    })
  }

  callback(token) {
    this.dispatch('success', {
      detail: { token },
    })
  }
}
