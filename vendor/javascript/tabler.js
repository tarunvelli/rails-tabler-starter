/*!
 * Tabler v1.0.0-beta14 (https://tabler.io)
 * @version 1.0.0-beta14
 * @link https://tabler.io
 * Copyright 2018-2022 The Tabler Authors
 * Copyright 2018-2022 codecalm.net Paweł Kuna
 * Licensed under MIT (https://github.com/tabler/tabler/blob/master/LICENSE)
 */
(function (factory) {
  typeof define === "function" && define.amd ? define(factory) : factory();
})(function () {
  "use strict";

  var prefix = "tblr-";
  var hexToRgba = function hexToRgba(hex, opacity) {
    var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    return result
      ? "rgba("
          .concat(parseInt(result[1], 16), ", ")
          .concat(parseInt(result[2], 16), ", ")
          .concat(parseInt(result[3], 16), ", ")
          .concat(opacity, ")")
      : null;
  };
  var getColor = function getColor(color) {
    var opacity =
      arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 1;
    var c = getComputedStyle(document.body)
      .getPropertyValue("--".concat(prefix).concat(color))
      .trim();
    if (opacity !== 1) {
      return hexToRgba(c, opacity);
    }
    return c;
  };

  var tabler = /*#__PURE__*/ Object.freeze({
    __proto__: null,
    prefix: prefix,
    hexToRgba: hexToRgba,
    getColor: getColor,
  });

  globalThis.tabler = tabler;
});
