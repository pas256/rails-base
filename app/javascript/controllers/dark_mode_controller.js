import { Controller } from "@hotwired/stimulus"

/**
 * Light mode / dark mode controller
 */
export default class extends Controller {
  connect() {
    // When the page loads, enable the selected (or default) mode
    this.enableMode()
  }

  enableMode() {
    // Detect the mode (if any set)
    if (localStorage.theme === 'light' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: light)').matches)) {
      document.documentElement.classList.remove('dark')
    } else {
      // Dark is the default
      document.documentElement.classList.add('dark')
    }
  }

  toggleMode() {
    if (localStorage.theme === 'dark') {
      localStorage.theme = 'light'
    } else {
      localStorage.theme = 'dark'
    }
    this.enableMode()
  }

  setDarkMode() {
    localStorage.theme = 'dark'
    this.enableMode()
  }

  setLightMode() {
    localStorage.theme = 'light'
    this.enableMode()
  }

  setSystemMode() {
    localStorage.removeItem('theme')
    this.enableMode()
  }
}
