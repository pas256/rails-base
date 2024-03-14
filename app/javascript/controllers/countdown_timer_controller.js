import { Controller } from "@hotwired/stimulus"
import { formatSecondsToTime } from "../utils/time"

const COUNTDOWN_PLACEHOLDER = '[XX:XX:XX]'
const ONE_SECOND = 1000

/**
 * Reusable countdown timer controller.
 *
 * targets:
 *  - displayElement: The element that will display the countdown time. If the element is an input, the value will be updated. Otherwise, the innerHTML will be updated. Does not handle nested elements so put this target on the inner most element.
 *
 * values:
 *  - from: The starting time for the countdown, in seconds. Default: `30` seconds
 *  - placeholder: The placeholder value to replace with the countdown time. Default: `[XX:XX:XX]`
 *  - zeroCallback: The (optional) name of a function to call when the countdown reaches zero.
 *
 * Example usage:
 * ```html
 * <script>
 *   function doThing() {
 *     console.log('Doing the thing when the countdown gets to zero')
 *   }
 * </script>
 *
 * <div data-controller="countdown-timer"
 *   data-countdown-timer-from-value="60"
 *   data-countdown-timer-zero-callback-value="doThing"
 *   data-countdown-timer-placeholder-value="[CUSTOM-PLACEHOLDER]"
 * >Blast off in [CUSTOM-PLACEHOLDER]...</div>
 * ```
 */
export default class extends Controller {
  static targets = ['displayElement']
  static values = {
    from: { type: Number, default: 30 },
    placeholder: { type: String, default: COUNTDOWN_PLACEHOLDER },
    zeroCallback: String,
  }

  connect() {
    // Determine which property to use for the countdown display
    if (this.displayElementTarget?.value?.includes(this.placeholderValue)) {
      this.property = 'value'
    } else {
      this.property = 'innerHTML'
    }

    // Save the original value so we can access it again during the countdown
    this.originalValue = this.displayElementTarget[this.property]

    // Always show the initial time
    this.showRemainingTime()

    // Start the countdown timer
    this.timer = setInterval(this.updateTimer.bind(this), ONE_SECOND)
  }

  disconnect() {
    if (this.timer) {
      clearInterval(this.timer)
    }
  }

  updateTimer() {
    this.fromValue--
    this.showRemainingTime()

    if (this.fromValue <= 0) {
      clearInterval(this.timer)
      if (this.zeroCallbackValue) {
        window[this.zeroCallbackValue]()
      }
    }
  }

  showRemainingTime() {
    this.remainingTime = formatSecondsToTime(this.fromValue)
    this.displayElementTarget[this.property] = this.originalValue.replace(this.placeholderValue, this.remainingTime)
  }
}
