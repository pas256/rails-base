/**
 * A collection of time related utility functions and helpers.
 */

/**
 * Formats a time value (given in seconds) to [HHH:MM:SS] format, automatically
 * omitting the HHH or MM if the number is small enough.
 *
 * @param {integer} timeInSeconds
 * @returns {string} The formatted time string.
 */
export function formatSecondsToTime(timeInSeconds) {
  // Hours, minutes and seconds
  const hrs = Math.floor(timeInSeconds / 3600);
  const mins = Math.floor((timeInSeconds % 3600) / 60);
  const secs = Math.floor(timeInSeconds % 60);

  // Output like "23", "1:01" or "4:03:59" or "123:03:59"
  let ret = "";

  if (hrs > 0) {
    ret += "" + hrs + ":" + (mins < 10 ? "0" : "");
  }
  if (mins > 0) {
    ret += "" + mins + ":" + (secs < 10 ? "0" : "");
  }

  ret += "" + secs;

  return ret;
}
