import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    siteKey: String,
  }

  connect() {
    if (typeof turnstile === "undefined") {
      this.script = document.querySelector("script[data-turnstiled]")
      this.script?.addEventListener("load", this.render, { once: true })
    } else {
      this.render()
    }
  }

  disconnect() {
    this.script?.removeEventListener("load", this.render)
  }

  // A page restored from Turbo's cache still holds the old widget and its used token.
  render = () => {
    this.element.replaceChildren()

    turnstile.render(this.element, {
      sitekey: this.siteKeyValue,
      callback: this.callback.bind(this),
    })
  }

  callback(token) {
    this.dispatch("success", {
      detail: { token },
    })
  }
}
