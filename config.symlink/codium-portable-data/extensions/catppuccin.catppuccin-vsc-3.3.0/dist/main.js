"use strict";
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __export = (target, all) => {
  for (var name in all)
    __defProp(target, name, { get: all[name], enumerable: true });
};
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toCommonJS = (mod) => __copyProps(__defProp({}, "__esModule", { value: true }), mod);

// src/main.ts
var main_exports = {};
__export(main_exports, {
  activate: () => activate
});
module.exports = __toCommonJS(main_exports);
var import_vscode2 = require("vscode");

// node_modules/@catppuccin/palette/dist/index.mjs
var latte = {
  rosewater: {
    hex: "#dc8a78",
    rgb: "rgb(220, 138, 120)",
    hsl: "hsl(11, 59%, 67%)",
    raw: "220, 138, 120"
  },
  flamingo: {
    hex: "#dd7878",
    rgb: "rgb(221, 120, 120)",
    hsl: "hsl(0, 60%, 67%)",
    raw: "221, 120, 120"
  },
  pink: {
    hex: "#ea76cb",
    rgb: "rgb(234, 118, 203)",
    hsl: "hsl(316, 73%, 69%)",
    raw: "234, 118, 203"
  },
  mauve: {
    hex: "#8839ef",
    rgb: "rgb(136, 57, 239)",
    hsl: "hsl(266, 85%, 58%)",
    raw: "136, 57, 239"
  },
  red: {
    hex: "#d20f39",
    rgb: "rgb(210, 15, 57)",
    hsl: "hsl(347, 87%, 44%)",
    raw: "210, 15, 57"
  },
  maroon: {
    hex: "#e64553",
    rgb: "rgb(230, 69, 83)",
    hsl: "hsl(355, 76%, 59%)",
    raw: "230, 69, 83"
  },
  peach: {
    hex: "#fe640b",
    rgb: "rgb(254, 100, 11)",
    hsl: "hsl(22, 99%, 52%)",
    raw: "254, 100, 11"
  },
  yellow: {
    hex: "#df8e1d",
    rgb: "rgb(223, 142, 29)",
    hsl: "hsl(35, 77%, 49%)",
    raw: "223, 142, 29"
  },
  green: {
    hex: "#40a02b",
    rgb: "rgb(64, 160, 43)",
    hsl: "hsl(109, 58%, 40%)",
    raw: "64, 160, 43"
  },
  teal: {
    hex: "#179299",
    rgb: "rgb(23, 146, 153)",
    hsl: "hsl(183, 74%, 35%)",
    raw: "23, 146, 153"
  },
  sky: {
    hex: "#04a5e5",
    rgb: "rgb(4, 165, 229)",
    hsl: "hsl(197, 97%, 46%)",
    raw: "4, 165, 229"
  },
  sapphire: {
    hex: "#209fb5",
    rgb: "rgb(32, 159, 181)",
    hsl: "hsl(189, 70%, 42%)",
    raw: "32, 159, 181"
  },
  blue: {
    hex: "#1e66f5",
    rgb: "rgb(30, 102, 245)",
    hsl: "hsl(220, 91%, 54%)",
    raw: "30, 102, 245"
  },
  lavender: {
    hex: "#7287fd",
    rgb: "rgb(114, 135, 253)",
    hsl: "hsl(231, 97%, 72%)",
    raw: "114, 135, 253"
  },
  text: {
    hex: "#4c4f69",
    rgb: "rgb(76, 79, 105)",
    hsl: "hsl(234, 16%, 35%)",
    raw: "76, 79, 105"
  },
  subtext1: {
    hex: "#5c5f77",
    rgb: "rgb(92, 95, 119)",
    hsl: "hsl(233, 13%, 41%)",
    raw: "92, 95, 119"
  },
  subtext0: {
    hex: "#6c6f85",
    rgb: "rgb(108, 111, 133)",
    hsl: "hsl(233, 10%, 47%)",
    raw: "108, 111, 133"
  },
  overlay2: {
    hex: "#7c7f93",
    rgb: "rgb(124, 127, 147)",
    hsl: "hsl(232, 10%, 53%)",
    raw: "124, 127, 147"
  },
  overlay1: {
    hex: "#8c8fa1",
    rgb: "rgb(140, 143, 161)",
    hsl: "hsl(231, 10%, 59%)",
    raw: "140, 143, 161"
  },
  overlay0: {
    hex: "#9ca0b0",
    rgb: "rgb(156, 160, 176)",
    hsl: "hsl(228, 11%, 65%)",
    raw: "156, 160, 176"
  },
  surface2: {
    hex: "#acb0be",
    rgb: "rgb(172, 176, 190)",
    hsl: "hsl(227, 12%, 71%)",
    raw: "172, 176, 190"
  },
  surface1: {
    hex: "#bcc0cc",
    rgb: "rgb(188, 192, 204)",
    hsl: "hsl(225, 14%, 77%)",
    raw: "188, 192, 204"
  },
  surface0: {
    hex: "#ccd0da",
    rgb: "rgb(204, 208, 218)",
    hsl: "hsl(223, 16%, 83%)",
    raw: "204, 208, 218"
  },
  base: {
    hex: "#eff1f5",
    rgb: "rgb(239, 241, 245)",
    hsl: "hsl(220, 23%, 95%)",
    raw: "239, 241, 245"
  },
  mantle: {
    hex: "#e6e9ef",
    rgb: "rgb(230, 233, 239)",
    hsl: "hsl(220, 22%, 92%)",
    raw: "230, 233, 239"
  },
  crust: {
    hex: "#dce0e8",
    rgb: "rgb(220, 224, 232)",
    hsl: "hsl(220, 21%, 89%)",
    raw: "220, 224, 232"
  }
};
var frappe = {
  rosewater: {
    hex: "#f2d5cf",
    rgb: "rgb(242, 213, 207)",
    hsl: "hsl(10, 57%, 88%)",
    raw: "242, 213, 207"
  },
  flamingo: {
    hex: "#eebebe",
    rgb: "rgb(238, 190, 190)",
    hsl: "hsl(0, 59%, 84%)",
    raw: "238, 190, 190"
  },
  pink: {
    hex: "#f4b8e4",
    rgb: "rgb(244, 184, 228)",
    hsl: "hsl(316, 73%, 84%)",
    raw: "244, 184, 228"
  },
  mauve: {
    hex: "#ca9ee6",
    rgb: "rgb(202, 158, 230)",
    hsl: "hsl(277, 59%, 76%)",
    raw: "202, 158, 230"
  },
  red: {
    hex: "#e78284",
    rgb: "rgb(231, 130, 132)",
    hsl: "hsl(359, 68%, 71%)",
    raw: "231, 130, 132"
  },
  maroon: {
    hex: "#ea999c",
    rgb: "rgb(234, 153, 156)",
    hsl: "hsl(358, 66%, 76%)",
    raw: "234, 153, 156"
  },
  peach: {
    hex: "#ef9f76",
    rgb: "rgb(239, 159, 118)",
    hsl: "hsl(20, 79%, 70%)",
    raw: "239, 159, 118"
  },
  yellow: {
    hex: "#e5c890",
    rgb: "rgb(229, 200, 144)",
    hsl: "hsl(40, 62%, 73%)",
    raw: "229, 200, 144"
  },
  green: {
    hex: "#a6d189",
    rgb: "rgb(166, 209, 137)",
    hsl: "hsl(96, 44%, 68%)",
    raw: "166, 209, 137"
  },
  teal: {
    hex: "#81c8be",
    rgb: "rgb(129, 200, 190)",
    hsl: "hsl(172, 39%, 65%)",
    raw: "129, 200, 190"
  },
  sky: {
    hex: "#99d1db",
    rgb: "rgb(153, 209, 219)",
    hsl: "hsl(189, 48%, 73%)",
    raw: "153, 209, 219"
  },
  sapphire: {
    hex: "#85c1dc",
    rgb: "rgb(133, 193, 220)",
    hsl: "hsl(199, 55%, 69%)",
    raw: "133, 193, 220"
  },
  blue: {
    hex: "#8caaee",
    rgb: "rgb(140, 170, 238)",
    hsl: "hsl(222, 74%, 74%)",
    raw: "140, 170, 238"
  },
  lavender: {
    hex: "#babbf1",
    rgb: "rgb(186, 187, 241)",
    hsl: "hsl(239, 66%, 84%)",
    raw: "186, 187, 241"
  },
  text: {
    hex: "#c6d0f5",
    rgb: "rgb(198, 208, 245)",
    hsl: "hsl(227, 70%, 87%)",
    raw: "198, 208, 245"
  },
  subtext1: {
    hex: "#b5bfe2",
    rgb: "rgb(181, 191, 226)",
    hsl: "hsl(227, 44%, 80%)",
    raw: "181, 191, 226"
  },
  subtext0: {
    hex: "#a5adce",
    rgb: "rgb(165, 173, 206)",
    hsl: "hsl(228, 29%, 73%)",
    raw: "165, 173, 206"
  },
  overlay2: {
    hex: "#949cbb",
    rgb: "rgb(148, 156, 187)",
    hsl: "hsl(228, 22%, 66%)",
    raw: "148, 156, 187"
  },
  overlay1: {
    hex: "#838ba7",
    rgb: "rgb(131, 139, 167)",
    hsl: "hsl(227, 17%, 58%)",
    raw: "131, 139, 167"
  },
  overlay0: {
    hex: "#737994",
    rgb: "rgb(115, 121, 148)",
    hsl: "hsl(229, 13%, 52%)",
    raw: "115, 121, 148"
  },
  surface2: {
    hex: "#626880",
    rgb: "rgb(98, 104, 128)",
    hsl: "hsl(228, 13%, 44%)",
    raw: "98, 104, 128"
  },
  surface1: {
    hex: "#51576d",
    rgb: "rgb(81, 87, 109)",
    hsl: "hsl(227, 15%, 37%)",
    raw: "81, 87, 109"
  },
  surface0: {
    hex: "#414559",
    rgb: "rgb(65, 69, 89)",
    hsl: "hsl(230, 16%, 30%)",
    raw: "65, 69, 89"
  },
  base: {
    hex: "#303446",
    rgb: "rgb(48, 52, 70)",
    hsl: "hsl(229, 19%, 23%)",
    raw: "48, 52, 70"
  },
  mantle: {
    hex: "#292c3c",
    rgb: "rgb(41, 44, 60)",
    hsl: "hsl(231, 19%, 20%)",
    raw: "41, 44, 60"
  },
  crust: {
    hex: "#232634",
    rgb: "rgb(35, 38, 52)",
    hsl: "hsl(229, 20%, 17%)",
    raw: "35, 38, 52"
  }
};
var macchiato = {
  rosewater: {
    hex: "#f4dbd6",
    rgb: "rgb(244, 219, 214)",
    hsl: "hsl(10, 58%, 90%)",
    raw: "244, 219, 214"
  },
  flamingo: {
    hex: "#f0c6c6",
    rgb: "rgb(240, 198, 198)",
    hsl: "hsl(0, 58%, 86%)",
    raw: "240, 198, 198"
  },
  pink: {
    hex: "#f5bde6",
    rgb: "rgb(245, 189, 230)",
    hsl: "hsl(316, 74%, 85%)",
    raw: "245, 189, 230"
  },
  mauve: {
    hex: "#c6a0f6",
    rgb: "rgb(198, 160, 246)",
    hsl: "hsl(267, 83%, 80%)",
    raw: "198, 160, 246"
  },
  red: {
    hex: "#ed8796",
    rgb: "rgb(237, 135, 150)",
    hsl: "hsl(351, 74%, 73%)",
    raw: "237, 135, 150"
  },
  maroon: {
    hex: "#ee99a0",
    rgb: "rgb(238, 153, 160)",
    hsl: "hsl(355, 71%, 77%)",
    raw: "238, 153, 160"
  },
  peach: {
    hex: "#f5a97f",
    rgb: "rgb(245, 169, 127)",
    hsl: "hsl(21, 86%, 73%)",
    raw: "245, 169, 127"
  },
  yellow: {
    hex: "#eed49f",
    rgb: "rgb(238, 212, 159)",
    hsl: "hsl(40, 70%, 78%)",
    raw: "238, 212, 159"
  },
  green: {
    hex: "#a6da95",
    rgb: "rgb(166, 218, 149)",
    hsl: "hsl(105, 48%, 72%)",
    raw: "166, 218, 149"
  },
  teal: {
    hex: "#8bd5ca",
    rgb: "rgb(139, 213, 202)",
    hsl: "hsl(171, 47%, 69%)",
    raw: "139, 213, 202"
  },
  sky: {
    hex: "#91d7e3",
    rgb: "rgb(145, 215, 227)",
    hsl: "hsl(189, 59%, 73%)",
    raw: "145, 215, 227"
  },
  sapphire: {
    hex: "#7dc4e4",
    rgb: "rgb(125, 196, 228)",
    hsl: "hsl(199, 66%, 69%)",
    raw: "125, 196, 228"
  },
  blue: {
    hex: "#8aadf4",
    rgb: "rgb(138, 173, 244)",
    hsl: "hsl(220, 83%, 75%)",
    raw: "138, 173, 244"
  },
  lavender: {
    hex: "#b7bdf8",
    rgb: "rgb(183, 189, 248)",
    hsl: "hsl(234, 82%, 85%)",
    raw: "183, 189, 248"
  },
  text: {
    hex: "#cad3f5",
    rgb: "rgb(202, 211, 245)",
    hsl: "hsl(227, 68%, 88%)",
    raw: "202, 211, 245"
  },
  subtext1: {
    hex: "#b8c0e0",
    rgb: "rgb(184, 192, 224)",
    hsl: "hsl(228, 39%, 80%)",
    raw: "184, 192, 224"
  },
  subtext0: {
    hex: "#a5adcb",
    rgb: "rgb(165, 173, 203)",
    hsl: "hsl(227, 27%, 72%)",
    raw: "165, 173, 203"
  },
  overlay2: {
    hex: "#939ab7",
    rgb: "rgb(147, 154, 183)",
    hsl: "hsl(228, 20%, 65%)",
    raw: "147, 154, 183"
  },
  overlay1: {
    hex: "#8087a2",
    rgb: "rgb(128, 135, 162)",
    hsl: "hsl(228, 15%, 57%)",
    raw: "128, 135, 162"
  },
  overlay0: {
    hex: "#6e738d",
    rgb: "rgb(110, 115, 141)",
    hsl: "hsl(230, 12%, 49%)",
    raw: "110, 115, 141"
  },
  surface2: {
    hex: "#5b6078",
    rgb: "rgb(91, 96, 120)",
    hsl: "hsl(230, 14%, 41%)",
    raw: "91, 96, 120"
  },
  surface1: {
    hex: "#494d64",
    rgb: "rgb(73, 77, 100)",
    hsl: "hsl(231, 16%, 34%)",
    raw: "73, 77, 100"
  },
  surface0: {
    hex: "#363a4f",
    rgb: "rgb(54, 58, 79)",
    hsl: "hsl(230, 19%, 26%)",
    raw: "54, 58, 79"
  },
  base: {
    hex: "#24273a",
    rgb: "rgb(36, 39, 58)",
    hsl: "hsl(232, 23%, 18%)",
    raw: "36, 39, 58"
  },
  mantle: {
    hex: "#1e2030",
    rgb: "rgb(30, 32, 48)",
    hsl: "hsl(233, 23%, 15%)",
    raw: "30, 32, 48"
  },
  crust: {
    hex: "#181926",
    rgb: "rgb(24, 25, 38)",
    hsl: "hsl(236, 23%, 12%)",
    raw: "24, 25, 38"
  }
};
var mocha = {
  rosewater: {
    hex: "#f5e0dc",
    rgb: "rgb(245, 224, 220)",
    hsl: "hsl(10, 56%, 91%)",
    raw: "245, 224, 220"
  },
  flamingo: {
    hex: "#f2cdcd",
    rgb: "rgb(242, 205, 205)",
    hsl: "hsl(0, 59%, 88%)",
    raw: "242, 205, 205"
  },
  pink: {
    hex: "#f5c2e7",
    rgb: "rgb(245, 194, 231)",
    hsl: "hsl(316, 72%, 86%)",
    raw: "245, 194, 231"
  },
  mauve: {
    hex: "#cba6f7",
    rgb: "rgb(203, 166, 247)",
    hsl: "hsl(267, 84%, 81%)",
    raw: "203, 166, 247"
  },
  red: {
    hex: "#f38ba8",
    rgb: "rgb(243, 139, 168)",
    hsl: "hsl(343, 81%, 75%)",
    raw: "243, 139, 168"
  },
  maroon: {
    hex: "#eba0ac",
    rgb: "rgb(235, 160, 172)",
    hsl: "hsl(350, 65%, 77%)",
    raw: "235, 160, 172"
  },
  peach: {
    hex: "#fab387",
    rgb: "rgb(250, 179, 135)",
    hsl: "hsl(23, 92%, 75%)",
    raw: "250, 179, 135"
  },
  yellow: {
    hex: "#f9e2af",
    rgb: "rgb(249, 226, 175)",
    hsl: "hsl(41, 86%, 83%)",
    raw: "249, 226, 175"
  },
  green: {
    hex: "#a6e3a1",
    rgb: "rgb(166, 227, 161)",
    hsl: "hsl(115, 54%, 76%)",
    raw: "166, 227, 161"
  },
  teal: {
    hex: "#94e2d5",
    rgb: "rgb(148, 226, 213)",
    hsl: "hsl(170, 57%, 73%)",
    raw: "148, 226, 213"
  },
  sky: {
    hex: "#89dceb",
    rgb: "rgb(137, 220, 235)",
    hsl: "hsl(189, 71%, 73%)",
    raw: "137, 220, 235"
  },
  sapphire: {
    hex: "#74c7ec",
    rgb: "rgb(116, 199, 236)",
    hsl: "hsl(199, 76%, 69%)",
    raw: "116, 199, 236"
  },
  blue: {
    hex: "#89b4fa",
    rgb: "rgb(137, 180, 250)",
    hsl: "hsl(217, 92%, 76%)",
    raw: "137, 180, 250"
  },
  lavender: {
    hex: "#b4befe",
    rgb: "rgb(180, 190, 254)",
    hsl: "hsl(232, 97%, 85%)",
    raw: "180, 190, 254"
  },
  text: {
    hex: "#cdd6f4",
    rgb: "rgb(205, 214, 244)",
    hsl: "hsl(226, 64%, 88%)",
    raw: "205, 214, 244"
  },
  subtext1: {
    hex: "#bac2de",
    rgb: "rgb(186, 194, 222)",
    hsl: "hsl(227, 35%, 80%)",
    raw: "186, 194, 222"
  },
  subtext0: {
    hex: "#a6adc8",
    rgb: "rgb(166, 173, 200)",
    hsl: "hsl(228, 24%, 72%)",
    raw: "166, 173, 200"
  },
  overlay2: {
    hex: "#9399b2",
    rgb: "rgb(147, 153, 178)",
    hsl: "hsl(228, 17%, 64%)",
    raw: "147, 153, 178"
  },
  overlay1: {
    hex: "#7f849c",
    rgb: "rgb(127, 132, 156)",
    hsl: "hsl(230, 13%, 55%)",
    raw: "127, 132, 156"
  },
  overlay0: {
    hex: "#6c7086",
    rgb: "rgb(108, 112, 134)",
    hsl: "hsl(231, 11%, 47%)",
    raw: "108, 112, 134"
  },
  surface2: {
    hex: "#585b70",
    rgb: "rgb(88, 91, 112)",
    hsl: "hsl(233, 12%, 39%)",
    raw: "88, 91, 112"
  },
  surface1: {
    hex: "#45475a",
    rgb: "rgb(69, 71, 90)",
    hsl: "hsl(234, 13%, 31%)",
    raw: "69, 71, 90"
  },
  surface0: {
    hex: "#313244",
    rgb: "rgb(49, 50, 68)",
    hsl: "hsl(237, 16%, 23%)",
    raw: "49, 50, 68"
  },
  base: {
    hex: "#1e1e2e",
    rgb: "rgb(30, 30, 46)",
    hsl: "hsl(240, 21%, 15%)",
    raw: "30, 30, 46"
  },
  mantle: {
    hex: "#181825",
    rgb: "rgb(24, 24, 37)",
    hsl: "hsl(240, 21%, 12%)",
    raw: "24, 24, 37"
  },
  crust: {
    hex: "#11111b",
    rgb: "rgb(17, 17, 27)",
    hsl: "hsl(240, 23%, 9%)",
    raw: "17, 17, 27"
  }
};
var palettes = {
  variants: {
    latte,
    frappe,
    macchiato,
    mocha
  },
  labels: {
    rosewater: {
      latte: latte.rosewater,
      frappe: frappe.rosewater,
      macchiato: macchiato.rosewater,
      mocha: mocha.rosewater
    },
    flamingo: {
      latte: latte.flamingo,
      frappe: frappe.flamingo,
      macchiato: macchiato.flamingo,
      mocha: mocha.flamingo
    },
    pink: {
      latte: latte.pink,
      frappe: frappe.pink,
      macchiato: macchiato.pink,
      mocha: mocha.pink
    },
    mauve: {
      latte: latte.mauve,
      frappe: frappe.mauve,
      macchiato: macchiato.mauve,
      mocha: mocha.mauve
    },
    red: {
      latte: latte.red,
      frappe: frappe.red,
      macchiato: macchiato.red,
      mocha: mocha.red
    },
    maroon: {
      latte: latte.maroon,
      frappe: frappe.maroon,
      macchiato: macchiato.maroon,
      mocha: mocha.maroon
    },
    peach: {
      latte: latte.peach,
      frappe: frappe.peach,
      macchiato: macchiato.peach,
      mocha: mocha.peach
    },
    yellow: {
      latte: latte.yellow,
      frappe: frappe.yellow,
      macchiato: macchiato.yellow,
      mocha: mocha.yellow
    },
    green: {
      latte: latte.green,
      frappe: frappe.green,
      macchiato: macchiato.green,
      mocha: mocha.green
    },
    teal: {
      latte: latte.teal,
      frappe: frappe.teal,
      macchiato: macchiato.teal,
      mocha: mocha.teal
    },
    sky: {
      latte: latte.sky,
      frappe: frappe.sky,
      macchiato: macchiato.sky,
      mocha: mocha.sky
    },
    sapphire: {
      latte: latte.sapphire,
      frappe: frappe.sapphire,
      macchiato: macchiato.sapphire,
      mocha: mocha.sapphire
    },
    blue: {
      latte: latte.blue,
      frappe: frappe.blue,
      macchiato: macchiato.blue,
      mocha: mocha.blue
    },
    lavender: {
      latte: latte.lavender,
      frappe: frappe.lavender,
      macchiato: macchiato.lavender,
      mocha: mocha.lavender
    },
    text: {
      latte: latte.text,
      frappe: frappe.text,
      macchiato: macchiato.text,
      mocha: mocha.text
    },
    subtext1: {
      latte: latte.subtext1,
      frappe: frappe.subtext1,
      macchiato: macchiato.subtext1,
      mocha: mocha.subtext1
    },
    subtext0: {
      latte: latte.subtext0,
      frappe: frappe.subtext0,
      macchiato: macchiato.subtext0,
      mocha: mocha.subtext0
    },
    overlay2: {
      latte: latte.overlay2,
      frappe: frappe.overlay2,
      macchiato: macchiato.overlay2,
      mocha: mocha.overlay2
    },
    overlay1: {
      latte: latte.overlay1,
      frappe: frappe.overlay1,
      macchiato: macchiato.overlay1,
      mocha: mocha.overlay1
    },
    overlay0: {
      latte: latte.overlay0,
      frappe: frappe.overlay0,
      macchiato: macchiato.overlay0,
      mocha: mocha.overlay0
    },
    surface2: {
      latte: latte.surface2,
      frappe: frappe.surface2,
      macchiato: macchiato.surface2,
      mocha: mocha.surface2
    },
    surface1: {
      latte: latte.surface1,
      frappe: frappe.surface1,
      macchiato: macchiato.surface1,
      mocha: mocha.surface1
    },
    surface0: {
      latte: latte.surface0,
      frappe: frappe.surface0,
      macchiato: macchiato.surface0,
      mocha: mocha.surface0
    },
    base: {
      latte: latte.base,
      frappe: frappe.base,
      macchiato: macchiato.base,
      mocha: mocha.base
    },
    mantle: {
      latte: latte.mantle,
      frappe: frappe.mantle,
      macchiato: macchiato.mantle,
      mocha: mocha.mantle
    },
    crust: {
      latte: latte.crust,
      frappe: frappe.crust,
      macchiato: macchiato.crust,
      mocha: mocha.crust
    }
  }
};
var { variants, labels } = palettes;

// src/theme/tokens/cpp.ts
var tokens = (context) => {
  const { palette } = context;
  return [
    {
      name: "C++ functions",
      scope: "entity.name.function.call.cpp",
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "C++ extern keyword",
      scope: "storage.modifier.specifier.extern.cpp",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "C++ keywords",
      scope: ["keyword.operator.new.cpp"],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    }
  ];
};
var cpp_default = tokens;

// src/theme/tokens/css.ts
var tokens2 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Classes, reflecting the className color in JSX",
      scope: "source.css entity.other.attribute-name.class",
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Pseudo classes",
      scope: "source.css entity.other.attribute-name.pseudo-class",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      scope: "source.css constant.other.unicode-range",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      scope: "source.css variable.parameter.url",
      settings: {
        foreground: palette.green,
        fontStyle: ""
      }
    },
    {
      name: "CSS vendored property names",
      scope: ["support.type.vendored.property-name"],
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "Less/SCSS right-hand variables (@/$-prefixed)",
      scope: [
        "source.css meta.property-value variable",
        "source.css meta.property-value variable.other.less",
        "source.css meta.property-value variable.other.less punctuation.definition.variable.less",
        // the left hand equivalent, initial assignment
        "meta.definition.variable.scss"
        // "meta.property-list variable.scss",
      ],
      settings: {
        foreground: palette.maroon,
        fontStyle: ""
      }
    },
    {
      name: "CSS variables (--prefixed)",
      scope: [
        "source.css meta.property-list variable",
        // ditto for less
        "meta.property-list variable.other.less",
        "meta.property-list variable.other.less punctuation.definition.variable.less"
      ],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "CSS Percentage values, styled the same as numbers",
      scope: "keyword.other.unit.percentage.css",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "CSS Attribute selectors, styled the same as strings",
      scope: "source.css meta.attribute-selector",
      settings: {
        foreground: palette.green,
        fontStyle: ""
      }
    }
  ];
};
var css_default = tokens2;

// src/theme/tokens/data.ts
var tokens3 = (context) => {
  const { palette } = context;
  return [
    {
      name: "JSON/YAML keys, other left-hand assignments",
      scope: [
        "keyword.other.definition.ini",
        "punctuation.support.type.property-name.json",
        "support.type.property-name.json",
        "punctuation.support.type.property-name.toml",
        "support.type.property-name.toml",
        "entity.name.tag.yaml",
        "punctuation.support.type.property-name.yaml",
        "support.type.property-name.yaml"
      ],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "JSON/YAML constants",
      scope: ["constant.language.json", "constant.language.yaml"],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "YAML anchors",
      scope: ["entity.name.type.anchor.yaml", "variable.other.alias.yaml"],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "TOML tables / ini groups",
      scope: [
        "support.type.property-name.table",
        "entity.name.section.group-title.ini"
      ],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "TOML dates",
      scope: "constant.other.time.datetime.offset.toml",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      name: "YAML anchor puctuation",
      scope: [
        "punctuation.definition.anchor.yaml",
        "punctuation.definition.alias.yaml"
      ],
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      name: "YAML triple dashes",
      scope: "entity.other.document.begin.yaml",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    }
  ];
};
var data_default = tokens3;

// src/theme/tokens/dotenv.ts
var tokens4 = (context) => {
  const { palette } = context;
  return [
    {
      name: "dotenv left-hand side assignments",
      scope: ["variable.other.env"],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "dotenv reference to existing env variable",
      scope: ["string.quoted variable.other.env"],
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    }
  ];
};
var dotenv_default = tokens4;

// src/theme/tokens/golang.ts
var tokens5 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Comment keywords",
      scope: "comment meta.annotation.go",
      settings: {
        foreground: palette.maroon,
        fontStyle: ""
      }
    },
    {
      name: "go:embed, go:build, etc.",
      scope: "comment meta.annotation.parameters.go",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Go constants (nil, true, false)",
      // nil should be peach, but TextMate doesn't offer a fine-grained enough scope
      scope: "constant.language.go",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Go functions",
      // nil should be peach, but TextMate doesn't offer a fine-grained enough scope
      scope: "support.function.go",
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    }
  ];
};
var golang_default = tokens5;

// src/theme/tokens/graphql.ts
var tokens6 = (context) => {
  const { palette } = context;
  return [
    {
      name: "GraphQL variables",
      scope: "variable.graphql",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "GraphQL aliases",
      scope: "string.unquoted.alias.graphql",
      settings: {
        foreground: palette.flamingo,
        fontStyle: ""
      }
    },
    {
      name: "GraphQL enum members",
      scope: "constant.character.enum.graphql",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "GraphQL field in types",
      scope: "meta.objectvalues.graphql constant.object.key.graphql string.unquoted.graphql",
      settings: {
        foreground: palette.flamingo,
        fontStyle: ""
      }
    }
  ];
};
var graphql_default = tokens6;

// src/theme/tokens/html.ts
var tokens7 = (context) => {
  const { palette } = context;
  return [
    {
      name: "HTML/XML DOCTYPE as keyword",
      scope: [
        "keyword.other.doctype",
        "meta.tag.sgml.doctype punctuation.definition.tag",
        "meta.tag.metadata.doctype entity.name.tag",
        "meta.tag.metadata.doctype punctuation.definition.tag"
      ],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "HTML/XML-like <tags/>",
      scope: ["entity.name.tag"],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "Special characters like &amp;",
      scope: [
        "text.html constant.character.entity",
        "text.html constant.character.entity punctuation",
        "constant.character.entity.xml",
        "constant.character.entity.xml punctuation",
        // ditto for JSX / TSX
        "constant.character.entity.js.jsx",
        "constant.charactger.entity.js.jsx punctuation",
        "constant.character.entity.tsx",
        "constant.character.entity.tsx punctuation"
      ],
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      name: "HTML/XML tag attribute values",
      scope: ["entity.other.attribute-name"],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Components",
      scope: ["meta.tag support.class.component"],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    }
  ];
};
var html_default = tokens7;

// src/theme/tokens/java.ts
var tokens8 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Annotations",
      scope: ["punctuation.definition.annotation", "storage.type.annotation"],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Java enums",
      scope: "constant.other.enum.java",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Java imports",
      scope: "storage.modifier.import.java",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    }
  ];
};
var java_default = tokens8;

// src/theme/tokens/javascript.ts
var tokens9 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Exported Variable",
      scope: "meta.export variable.other.readwrite.js",
      settings: {
        foreground: palette.maroon,
        fontStyle: ""
      }
    },
    {
      name: "JS/TS constants & properties",
      scope: [
        "variable.other.constant.js",
        "variable.other.constant.ts",
        "variable.other.property.js",
        "variable.other.property.ts"
      ],
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      scope: "support.type.object.console.js",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "Node constants as keywords (module, etc.)",
      scope: ["support.constant.node", "support.type.object.module.js"],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "implements as keyword",
      scope: "storage.modifier.implements",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Builtin types",
      scope: [
        "constant.language.null.js",
        "constant.language.null.ts",
        "constant.language.undefined.js",
        "constant.language.undefined.ts",
        "support.type.builtin.ts"
      ],
      settings: {
        foreground: palette.mauve
      }
    },
    {
      scope: "variable.parameter.generic",
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Arrow functions",
      scope: [
        "keyword.declaration.function.arrow.js",
        "storage.type.function.arrow.ts"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Decorator punctuations (decorators inherit from blue functions, instead of styleguide peach)",
      scope: "punctuation.decorator.ts",
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    },
    {
      name: "of/ keyof / typeof as keywords",
      scope: [
        "keyword.operator.expression.keyof.ts",
        "keyword.operator.expression.typeof.js",
        "keyword.operator.expression.typeof.ts",
        "keyword.operator.expression.of.ts",
        "keyword.operator.expression.of.js"
      ],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Vue components",
      scope: ["support.class.component.vue"],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    }
  ];
};
var javascript_default = tokens9;

// src/theme/tokens/julia.ts
var tokens10 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Julia functions",
      scope: "support.function.julia",
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    },
    {
      name: "Julia macros",
      scope: "support.function.macro.julia",
      settings: {
        foreground: palette.teal,
        fontStyle: "italic"
      }
    },
    {
      name: "Julia language constants (true, false)",
      scope: "constant.language.julia",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Julia other constants (these seem to be arguments inside arrays)",
      scope: "constant.other.symbol.julia",
      settings: {
        foreground: palette.maroon,
        fontStyle: ""
      }
    }
  ];
};
var julia_default = tokens10;

// src/theme/tokens/latex.ts
var tokens11 = (context) => {
  const { palette } = context;
  return [
    {
      name: "LaTeX preamble",
      scope: "text.tex keyword.control.preamble",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "LaTeX functions",
      scope: "text.tex support.function",
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "LaTeX be functions",
      scope: "text.tex support.function.be",
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "LaTeX math",
      scope: "constant.other.general.math.tex",
      settings: {
        foreground: palette.flamingo,
        fontStyle: ""
      }
    }
  ];
};
var latex_default = tokens11;

// src/theme/tokens/markdown.ts
var tokens12 = (context) => {
  const { palette } = context;
  return [
    {
      scope: [
        "heading.1.markdown punctuation.definition.heading.markdown",
        "heading.1.markdown",
        "markup.heading.atx.1.mdx",
        "markup.heading.atx.1.mdx punctuation.definition.heading.mdx",
        "markup.heading.setext.1.markdown",
        "markup.heading.heading-0.asciidoc"
      ],
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      scope: [
        "heading.2.markdown punctuation.definition.heading.markdown",
        "heading.2.markdown",
        "markup.heading.atx.2.mdx",
        "markup.heading.atx.2.mdx punctuation.definition.heading.mdx",
        "markup.heading.setext.2.markdown",
        "markup.heading.heading-1.asciidoc"
      ],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      scope: [
        "heading.3.markdown punctuation.definition.heading.markdown",
        "heading.3.markdown",
        "markup.heading.atx.3.mdx",
        "markup.heading.atx.3.mdx punctuation.definition.heading.mdx",
        "markup.heading.heading-2.asciidoc"
      ],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      scope: [
        "heading.4.markdown punctuation.definition.heading.markdown",
        "heading.4.markdown",
        "markup.heading.atx.4.mdx",
        "markup.heading.atx.4.mdx punctuation.definition.heading.mdx",
        "markup.heading.heading-3.asciidoc"
      ],
      settings: {
        foreground: palette.green,
        fontStyle: ""
      }
    },
    {
      scope: [
        "heading.5.markdown punctuation.definition.heading.markdown",
        "heading.5.markdown",
        "markup.heading.atx.5.mdx",
        "markup.heading.atx.5.mdx punctuation.definition.heading.mdx",
        "markup.heading.heading-4.asciidoc"
      ],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      scope: [
        "heading.6.markdown punctuation.definition.heading.markdown",
        "heading.6.markdown",
        "markup.heading.atx.6.mdx",
        "markup.heading.atx.6.mdx punctuation.definition.heading.mdx",
        "markup.heading.heading-5.asciidoc"
      ],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      scope: "markup.bold",
      settings: {
        foreground: palette.red,
        fontStyle: "bold"
      }
    },
    {
      scope: "markup.italic",
      settings: {
        foreground: palette.red,
        fontStyle: "italic"
      }
    },
    {
      scope: "markup.strikethrough",
      settings: {
        foreground: palette.subtext0,
        fontStyle: "strikethrough"
      }
    },
    {
      name: "Markdown auto links",
      scope: ["punctuation.definition.link", "markup.underline.link"],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "Markdown links",
      scope: [
        "text.html.markdown punctuation.definition.link.title",
        "string.other.link.title.markdown",
        "markup.link",
        // references like
        // > [1]: http://example.com "Example"
        "punctuation.definition.constant.markdown",
        "constant.other.reference.link.markdown",
        "markup.substitution.attribute-reference"
      ],
      settings: {
        foreground: palette.lavender,
        fontStyle: ""
      }
    },
    {
      name: "Markdown code spans",
      scope: [
        "punctuation.definition.raw.markdown",
        "markup.inline.raw.string.markdown",
        "markup.raw.block.markdown"
      ],
      settings: {
        foreground: palette.green,
        fontStyle: ""
      }
    },
    {
      name: "Markdown triple backtick language identifier",
      scope: "fenced_code.block.language",
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "Markdown triple backticks",
      scope: [
        "markup.fenced_code.block punctuation.definition",
        "markup.raw support.asciidoc"
      ],
      settings: {
        foreground: palette.overlay2,
        fontStyle: ""
      }
    },
    {
      name: "Markdown quotes",
      scope: ["markup.quote", "punctuation.definition.quote.begin"],
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      name: "Markdown separators",
      scope: "meta.separator.markdown",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Markdown list bullets",
      scope: [
        "punctuation.definition.list.begin.markdown",
        "markup.list.bullet"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    }
  ];
};
var markdown_default = tokens12;

// src/theme/tokens/nix.ts
var tokens13 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Nix attribute names",
      scope: [
        "entity.other.attribute-name.multipart.nix",
        "entity.other.attribute-name.single.nix"
      ],
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "Nix parameter names",
      scope: "variable.parameter.name.nix",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "Nix interpolated parameter names",
      scope: "meta.embedded variable.parameter.name.nix",
      settings: {
        foreground: palette.lavender,
        fontStyle: ""
      }
    }
  ];
};
var nix_default = tokens13;

// src/theme/tokens/php.ts
var tokens14 = (context) => {
  const { palette } = context;
  return [
    {
      name: "PHP Attributes",
      scope: ["support.attribute.builtin", "meta.attribute.php"],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "PHP Parameters (needed for the leading dollar sign)",
      scope: "meta.function.parameters.php punctuation.definition.variable.php",
      settings: {
        foreground: palette.maroon,
        fontStyle: ""
      }
    },
    {
      name: "PHP Constants (null, __FILE__, etc.)",
      scope: "constant.language.php",
      settings: {
        foreground: palette.mauve
      }
    },
    {
      name: "PHP functions",
      scope: "text.html.php support.function",
      settings: {
        foreground: palette.blue
      }
    }
  ];
};
var php_default = tokens14;

// src/theme/tokens/python.ts
var tokens15 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Python argument functions reset to text, otherwise they inherit blue from function-call",
      scope: [
        "support.variable.magic.python",
        "meta.function-call.arguments.python"
      ],
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "Python double underscore functions",
      scope: ["support.function.magic.python"],
      settings: {
        foreground: palette.sky,
        fontStyle: "italic"
      }
    },
    {
      name: "Python `self` keyword",
      scope: [
        "variable.parameter.function.language.special.self.python",
        "variable.language.special.self.python"
      ],
      settings: {
        foreground: palette.red,
        fontStyle: "italic"
      }
    },
    {
      name: "python keyword flow/logical (for ... in)",
      scope: ["keyword.control.flow.python", "keyword.operator.logical.python"],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "python storage type",
      scope: "storage.type.function.python",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "python function support",
      scope: [
        "support.token.decorator.python",
        "meta.function.decorator.identifier.python"
      ],
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "python function calls",
      scope: ["meta.function-call.python"],
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    },
    {
      name: "python function decorators",
      scope: [
        "entity.name.function.decorator.python",
        "punctuation.definition.decorator.python"
      ],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "python placeholder reset to normal string",
      scope: "constant.character.format.placeholder.other.python",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      name: "Python exception & builtins such as exit()",
      scope: [
        "support.type.exception.python",
        "support.function.builtin.python"
      ],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "entity.name.type",
      scope: ["support.type.python"],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "python constants (True/False)",
      scope: "constant.language.python",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Arguments accessed later in the function body",
      scope: ["meta.indexed-name.python", "meta.item-access.python"],
      settings: {
        foreground: palette.maroon,
        fontStyle: "italic"
      }
    },
    {
      name: "Python f-strings/binary/unicode storage types",
      scope: "storage.type.string.python",
      settings: {
        foreground: palette.green,
        fontStyle: "italic"
      }
    }
  ];
};
var python_default = tokens15;

// src/theme/tokens/ruby.ts
var tokens16 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Ruby built-in functions",
      scope: ["support.function.kernel.ruby"],
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    }
  ];
};
var ruby_default = tokens16;

// src/theme/tokens/rust.ts
var tokens17 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Rust attribute",
      scope: [
        "meta.annotation.rust",
        "meta.annotation.rust punctuation",
        "meta.attribute.rust",
        "punctuation.definition.attribute.rust"
      ],
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Rust keyword",
      scope: [
        "storage.type.module.rust",
        "storage.modifier.rust",
        "storage.type.struct.rust",
        "storage.type.enum.rust",
        "storage.type.trait.rust",
        "storage.type.union.rust",
        "storage.type.impl.rust",
        "storage.type.rust",
        "storage.type.function.rust",
        "storage.type.type.rust"
      ],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Rust u/i32, u/i64, etc.",
      scope: "entity.name.type.numeric.rust",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Rust generic",
      scope: "meta.generic.rust",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Rust impl",
      scope: "entity.name.impl.rust",
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Rust module",
      scope: "entity.name.module.rust",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      name: "Rust trait",
      scope: "entity.name.trait.rust",
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Rust struct",
      scope: "storage.type.source.rust",
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Rust union",
      scope: "entity.name.union.rust",
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Rust enum member",
      scope: "meta.enum.rust storage.type.source.rust",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Rust macro",
      scope: [
        "support.macro.rust",
        "meta.macro.rust support.function.rust",
        "entity.name.function.macro"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Rust lifetime",
      scope: ["storage.modifier.lifetime.rust", "entity.name.type.lifetime"],
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    },
    {
      name: "Rust string formatting",
      scope: "string.quoted.double.rust constant.other.placeholder.rust",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      name: "Rust return type generic",
      scope: "meta.function.return-type.rust meta.generic.rust storage.type.rust",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "Rust functions",
      scope: "meta.function.call.rust",
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "Rust angle brackets",
      scope: "punctuation.brackets.angle.rust",
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "Rust constants",
      scope: "constant.other.caps.rust",
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    }
  ];
};
var rust_default = tokens17;

// src/theme/tokens/shell.ts
var tokens18 = (context) => {
  const { palette } = context;
  return [
    {
      name: "Shell shebang",
      scope: [
        "comment.line.shebang",
        "comment.line.shebang punctuation.definition.comment",
        "comment.line.shebang",
        "punctuation.definition.comment.shebang.shell",
        "meta.shebang.shell"
      ],
      settings: {
        foreground: palette.pink,
        fontStyle: "italic"
      }
    },
    {
      name: "Shell shebang command",
      scope: "comment.line.shebang constant.language",
      settings: {
        foreground: palette.teal,
        fontStyle: "italic"
      }
    },
    {
      name: "Shell interpolated command",
      scope: [
        "meta.function-call.arguments.shell punctuation.definition.variable.shell",
        "meta.function-call.arguments.shell punctuation.section.interpolation",
        "meta.function-call.arguments.shell punctuation.definition.variable.shell",
        "meta.function-call.arguments.shell punctuation.section.interpolation"
      ],
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      name: "Shell interpolated command variable",
      scope: "meta.string meta.interpolation.parameter.shell variable.other.readwrite",
      settings: {
        foreground: palette.peach,
        fontStyle: "italic"
      }
    },
    {
      scope: [
        "source.shell punctuation.section.interpolation",
        "punctuation.definition.evaluation.backticks.shell"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Shell EOF",
      scope: "entity.name.tag.heredoc.shell",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Shell quoted variable",
      scope: "string.quoted.double.shell variable.other.normal.shell",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    }
  ];
};
var shell_default = tokens18;

// src/theme/tokens/index.ts
var tokens_default = (context) => {
  const { options, palette } = context;
  return [
    {
      name: "Basic text & variable names (incl. leading punctuation)",
      scope: [
        "text",
        "source",
        "variable.other.readwrite",
        "punctuation.definition.variable"
      ],
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "Parentheses, Brackets, Braces",
      scope: "punctuation",
      settings: {
        foreground: palette.overlay2,
        fontStyle: ""
      }
    },
    {
      name: "Comments",
      scope: ["comment", "punctuation.definition.comment"],
      settings: {
        foreground: palette.overlay0,
        fontStyle: options.italicComments ? "italic" : ""
      }
    },
    {
      scope: ["string", "punctuation.definition.string"],
      settings: {
        foreground: palette.green,
        fontStyle: ""
      }
    },
    {
      scope: "string.regexp",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      scope: "constant.character.escape",
      settings: {
        foreground: palette.pink,
        fontStyle: ""
      }
    },
    {
      scope: [
        "constant.numeric",
        "variable.other.constant",
        "entity.name.constant",
        "constant.language.boolean"
      ],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      scope: [
        "keyword",
        "keyword.operator.word",
        "keyword.operator.new",
        "variable.language.super",
        "support.type.primitive",
        "storage.type",
        "storage.modifier",
        // include punctuation like $ and @ if they're part of the keyword
        "punctuation.definition.keyword"
      ],
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      scope: "entity.name.tag.documentation",
      settings: {
        foreground: palette.mauve,
        fontStyle: ""
      }
    },
    {
      name: "Punctuation",
      scope: [
        "keyword.operator",
        "punctuation.accessor",
        "punctuation.definition.generic",
        "meta.function.closure punctuation.section.parameters",
        "punctuation.definition.tag",
        "punctuation.separator.key-value"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      scope: [
        "variable.function",
        "meta.function-call.method",
        "entity.name.function",
        "support.function.misc"
      ],
      settings: {
        foreground: palette.blue,
        fontStyle: "italic"
      }
    },
    {
      name: "Classes",
      scope: [
        "entity.name.class",
        "entity.other.inherited-class",
        "support.class",
        "meta.function-call.constructor",
        "entity.name.struct"
      ],
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Enum",
      scope: "entity.name.enum",
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Enum member",
      scope: [
        "meta.enum variable.other.readwrite",
        "variable.other.enummember"
      ],
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Object properties",
      scope: "meta.property.object",
      settings: {
        foreground: palette.teal,
        fontStyle: ""
      }
    },
    {
      name: "Types",
      scope: [
        "meta.type",
        "meta.type-alias",
        "support.type",
        "entity.name.type"
      ],
      settings: {
        foreground: palette.yellow,
        fontStyle: "italic"
      }
    },
    {
      name: "Decorators",
      scope: [
        "meta.annotation variable.function",
        "meta.annotation variable.annotation.function",
        "meta.annotation punctuation.definition.annotation",
        "meta.decorator",
        "punctuation.decorator"
      ],
      settings: {
        foreground: palette.peach,
        fontStyle: ""
      }
    },
    {
      scope: ["variable.parameter", "meta.function.parameters"],
      settings: {
        foreground: palette.maroon,
        fontStyle: "italic"
      }
    },
    {
      name: "Built-ins",
      scope: ["constant.language", "support.function.builtin"],
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      scope: "entity.other.attribute-name.documentation",
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      name: "Preprocessor directives",
      scope: ["keyword.control.directive", "punctuation.definition.directive"],
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Type parameters",
      scope: "punctuation.definition.typeparameters",
      settings: {
        foreground: palette.sky,
        fontStyle: ""
      }
    },
    {
      name: "Namespaces",
      scope: "entity.name.namespace",
      settings: {
        foreground: palette.yellow,
        fontStyle: ""
      }
    },
    {
      name: "Property names (left hand assignments in json/yaml/css)",
      scope: "support.type.property-name.css",
      settings: {
        foreground: palette.blue,
        fontStyle: ""
      }
    },
    {
      name: "This/Self keyword",
      scope: [
        "variable.language.this",
        // leading punctuation like $this in PHP
        "variable.language.this punctuation.definition.variable"
      ],
      settings: {
        foreground: palette.red,
        fontStyle: ""
      }
    },
    {
      name: "Object properties",
      scope: "variable.object.property",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    {
      name: "String template interpolation",
      scope: "string.template variable",
      settings: {
        foreground: palette.text,
        fontStyle: ""
      }
    },
    // per-language tokens
    ...[
      cpp_default,
      css_default,
      data_default,
      dotenv_default,
      golang_default,
      graphql_default,
      html_default,
      java_default,
      javascript_default,
      julia_default,
      latex_default,
      markdown_default,
      nix_default,
      php_default,
      python_default,
      ruby_default,
      rust_default,
      shell_default
    ].flatMap((el) => el(context))
  ];
};

// src/theme/tokenColors.ts
var getTokenColors = (context) => {
  const { options } = context;
  return tokens_default(context).map((token) => {
    if (token.name === "Comments")
      return token;
    token = {
      ...token,
      settings: {
        ...token.settings,
        fontStyle: options.italicKeywords ? token.settings.fontStyle : (token.settings.fontStyle ?? "").replace("italic", "")
      }
    };
    return token;
  });
};

// src/theme/semanticTokens.ts
var getSemanticTokens = (context) => {
  const { palette } = context;
  return {
    enumMember: { foreground: palette.teal },
    selfKeyword: { foreground: palette.red },
    "variable.defaultLibrary": { foreground: palette.maroon },
    // Python types
    "class:python": { foreground: palette.yellow },
    "class.builtin:python": { foreground: palette.mauve },
    "variable.typeHint:python": { foreground: palette.yellow },
    // ignore `const`s being peach in JS & TS
    "variable.readonly:javascript": { foreground: palette.text },
    "variable.readonly:typescript": { foreground: palette.text },
    "property.readonly:javascript": { foreground: palette.text },
    "property.readonly:typescript": { foreground: palette.text },
    // ditto for React
    "variable.readonly:javascriptreact": { foreground: palette.text },
    "variable.readonly:typescriptreact": { foreground: palette.text },
    "property.readonly:javascriptreact": { foreground: palette.text },
    "property.readonly:typescriptreact": { foreground: palette.text },
    // Scala, also dealing with constants
    "variable.readonly:scala": { foreground: palette.text },
    // Golang builtin readonly defaultLibrary (nil)
    "type.defaultLibrary:go": { foreground: palette.mauve },
    "variable.readonly.defaultLibrary:go": { foreground: palette.mauve },
    // TOML syntax
    tomlArrayKey: { foreground: palette.blue, fontStyle: "" },
    tomlTableKey: { foreground: palette.blue, fontStyle: "" },
    // Rust attributes
    "builtinAttribute.attribute.library:rust": { foreground: palette.blue },
    "generic.attribute:rust": { foreground: palette.text },
    // Typst
    heading: { foreground: palette.red },
    "text.emph": { foreground: palette.red, fontStyle: "italic" },
    "text.strong": { foreground: palette.red, fontStyle: "bold" },
    "text.math": { foreground: palette.flamingo },
    pol: { foreground: palette.flamingo }
  };
};

// src/theme/utils.ts
var capitalize = (s) => {
  return s.charAt(0).toUpperCase() + s.substring(1);
};
var opacity = (color, opacity2) => {
  opacity2 = Math.floor(255 * opacity2);
  color = color.replace(`#`, ``);
  if (color.length === 6) {
    return `#${color}${opacity2.toString(16)}`;
  } else {
    return color;
  }
};
var shade = (color, magnitude) => {
  magnitude = Math.round(magnitude * 100);
  color = color.replace(`#`, ``);
  if (color.length === 6) {
    const decimalColor = parseInt(color, 16);
    let r = (decimalColor >> 16) + magnitude;
    r > 255 && (r = 255);
    r < 0 && (r = 0);
    let g = (decimalColor & 255) + magnitude;
    g > 255 && (g = 255);
    g < 0 && (g = 0);
    let b = (decimalColor >> 8 & 255) + magnitude;
    b > 255 && (b = 255);
    b < 0 && (b = 0);
    return `#${(g | b << 8 | r << 16).toString(16)}`;
  } else {
    return color;
  }
};
var transparent = "#00000000";

// src/theme/extensions/error-lens.ts
function colors(context) {
  const { palette } = context;
  return {
    "errorLens.errorBackground": opacity(palette.red, 0.15),
    "errorLens.errorMessageBackground": opacity(palette.red, 0.15),
    "errorLens.errorBackgroundLight": opacity(palette.red, 0.15),
    "errorLens.errorForeground": palette.red,
    "errorLens.errorForegroundLight": palette.red,
    "errorLens.warningBackground": opacity(palette.peach, 0.15),
    "errorLens.warningMessageBackground": opacity(palette.peach, 0.15),
    "errorLens.warningBackgroundLight": opacity(palette.peach, 0.15),
    "errorLens.warningForeground": palette.peach,
    "errorLens.warningForegroundLight": palette.peach,
    "errorLens.infoBackground": opacity(palette.blue, 0.15),
    "errorLens.infoMessageBackground": opacity(palette.blue, 0.15),
    "errorLens.infoBackgroundLight": opacity(palette.blue, 0.15),
    "errorLens.infoForeground": palette.blue,
    "errorLens.infoForegroundLight": palette.blue,
    "errorLens.hintBackground": opacity(palette.green, 0.15),
    "errorLens.hintMessageBackground": opacity(palette.green, 0.15),
    "errorLens.hintBackgroundLight": opacity(palette.green, 0.15),
    "errorLens.hintForeground": palette.green,
    "errorLens.hintForegroundLight": palette.green,
    "errorLens.statusBarIconErrorForeground": palette.red,
    "errorLens.statusBarIconWarningForeground": palette.peach,
    "errorLens.statusBarErrorForeground": palette.red,
    "errorLens.statusBarWarningForeground": palette.peach,
    "errorLens.statusBarInfoForeground": palette.blue,
    "errorLens.statusBarHintForeground": palette.green
  };
}

// src/theme/extensions/index.ts
function extensions_default(context) {
  return {
    ...colors(context)
  };
}

// src/theme/uiColors.ts
var getCustomizedColors = (context) => {
  const { palette, options, isLatte } = context;
  const L = isLatte ? -1 : 1;
  const bracketsMap = {
    rainbow: {
      "editorBracketHighlight.foreground1": palette.red,
      "editorBracketHighlight.foreground2": palette.peach,
      "editorBracketHighlight.foreground3": palette.yellow,
      "editorBracketHighlight.foreground4": palette.green,
      "editorBracketHighlight.foreground5": palette.sapphire,
      "editorBracketHighlight.foreground6": palette.mauve,
      "editorBracketHighlight.unexpectedBracket.foreground": palette.maroon
    },
    dimmed: {
      "editorBracketHighlight.foreground1": shade(palette.red, -0.6 * L),
      "editorBracketHighlight.foreground2": shade(palette.peach, -0.6 * L),
      "editorBracketHighlight.foreground3": shade(palette.yellow, -0.6 * L),
      "editorBracketHighlight.foreground4": shade(palette.green, -0.6 * L),
      "editorBracketHighlight.foreground5": shade(palette.sapphire, -0.6 * L),
      "editorBracketHighlight.foreground6": shade(palette.mauve, -0.6 * L),
      "editorBracketHighlight.unexpectedBracket.foreground": shade(
        palette.maroon,
        -0.6 * L
      )
    },
    monochromatic: {
      "editorBracketHighlight.foreground1": palette.subtext1,
      "editorBracketHighlight.foreground2": palette.subtext0,
      "editorBracketHighlight.foreground3": palette.overlay2,
      "editorBracketHighlight.foreground4": palette.overlay1,
      "editorBracketHighlight.foreground5": palette.overlay0,
      "editorBracketHighlight.foreground6": palette.surface2,
      "editorBracketHighlight.unexpectedBracket.foreground": palette.maroon
    },
    neovim: {
      "editorBracketHighlight.foreground1": palette.red,
      "editorBracketHighlight.foreground2": palette.teal,
      "editorBracketHighlight.foreground3": palette.yellow,
      "editorBracketHighlight.foreground4": palette.blue,
      "editorBracketHighlight.foreground5": palette.pink,
      "editorBracketHighlight.foreground6": palette.flamingo,
      "editorBracketHighlight.unexpectedBracket.foreground": palette.maroon
    }
  };
  const workbenchMap = {
    default: {},
    flat: {
      "activityBar.background": palette.mantle,
      "breadcrumb.background": palette.base,
      "commandCenter.background": palette.mantle,
      "debugToolBar.background": palette.mantle,
      "editorGroupHeader.tabsBackground": palette.mantle,
      "minimap.background": opacity(palette.base, 0.5),
      "statusBar.background": palette.mantle,
      "statusBar.noFolderBackground": palette.mantle,
      "tab.border": palette.base,
      "titleBar.activeBackground": palette.mantle,
      "titleBar.inactiveBackground": palette.mantle,
      "scrollbar.shadow": palette.mantle
    },
    minimal: {
      "activityBar.background": palette.base,
      "breadcrumb.background": palette.base,
      "commandCenter.background": palette.base,
      "debugToolBar.background": palette.base,
      "editor.background": palette.base,
      "editorWidget.background": palette.base,
      "editorGroupHeader.tabsBackground": palette.base,
      "minimap.background": opacity(palette.base, 0.5),
      "statusBar.background": palette.base,
      "statusBar.noFolderBackground": palette.base,
      "sideBar.background": palette.base,
      "sideBarSectionHeader.background": palette.base,
      "tab.border": palette.base,
      "tab.inactiveBackground": palette.base,
      "titleBar.activeBackground": palette.base,
      "titleBar.inactiveBackground": palette.base
    }
  };
  return {
    ...bracketsMap[options.bracketMode],
    ...workbenchMap[options.workbenchMode]
  };
};
var getUiColors = (context) => {
  const { palette, options, isLatte } = context;
  const accent = palette[options.accent];
  const dropBackground = opacity(palette.surface2, 0.6);
  const border = options.extraBordersEnabled ? opacity(palette.overlay1, 0.15) : transparent;
  const customNamedColors = {
    ...Object.entries({
      // collect the options, overwrite the "all" config with the current palette config
      ...options.customUIColors.all,
      ...options.customUIColors[palette.name]
    }).map(([k, v]) => {
      if (v.startsWith("accent")) {
        const entry2 = v.split(" ");
        if (entry2.length !== 1) {
          return {
            [k]: opacity(accent, Number(entry2[1]))
          };
        } else {
          return {
            [k]: accent
          };
        }
      }
      if (v.startsWith("#")) {
        return {
          [k]: v
        };
      }
      const entry = v.split(" ");
      if (entry.length !== 1) {
        v = opacity(
          palette[entry[0]],
          Number(entry[1])
        );
      } else {
        v = palette[v];
      }
      return {
        [k]: v
      };
    }).reduce((prev, cur) => ({ ...prev, ...cur }), {})
  };
  return {
    // Base colors
    focusBorder: transparent,
    foreground: palette.text,
    disabledForeground: palette.subtext0,
    "widget.shadow": opacity(palette.mantle, 0.5),
    "selection.background": palette.surface2,
    descriptionForeground: palette.text,
    errorForeground: palette.red,
    "icon.foreground": accent,
    "sash.hoverBorder": accent,
    // Window border
    "window.activeBorder": transparent,
    "window.inactiveBorder": transparent,
    // Text colors
    "textBlockQuote.background": palette.mantle,
    "textBlockQuote.border": palette.crust,
    "textCodeBlock.background": palette.base,
    "textLink.activeForeground": palette.sky,
    "textLink.foreground": palette.blue,
    "textPreformat.foreground": palette.text,
    "textSeparator.foreground": accent,
    // Activity Bar
    "activityBar.background": palette.crust,
    "activityBar.foreground": accent,
    "activityBar.dropBorder": dropBackground,
    "activityBar.inactiveForeground": palette.overlay0,
    "activityBar.border": border,
    "activityBarBadge.background": accent,
    "activityBarBadge.foreground": palette.crust,
    "activityBar.activeBorder": transparent,
    "activityBar.activeBackground": transparent,
    "activityBar.activeFocusBorder": transparent,
    "badge.background": palette.surface1,
    "badge.foreground": palette.text,
    "breadcrumb.activeSelectionForeground": accent,
    "breadcrumb.background": palette.mantle,
    "breadcrumb.focusForeground": accent,
    "breadcrumb.foreground": opacity(palette.text, 0.8),
    "breadcrumbPicker.background": palette.mantle,
    // buttons & checkboxes
    "button.background": accent,
    "button.foreground": palette.crust,
    "button.border": transparent,
    "button.separator": transparent,
    "button.hoverBackground": shade(accent, 0.2),
    "button.secondaryForeground": palette.text,
    "button.secondaryBackground": palette.surface2,
    "button.secondaryHoverBackground": shade(palette.surface2, 0.2),
    "checkbox.background": palette.surface1,
    "checkbox.border": border,
    "checkbox.foreground": accent,
    // dropdown controls
    "dropdown.background": palette.mantle,
    "dropdown.listBackground": palette.surface2,
    "dropdown.border": accent,
    "dropdown.foreground": palette.text,
    // debug
    "debugToolBar.background": palette.crust,
    "debugToolBar.border": transparent,
    "debugExceptionWidget.background": palette.crust,
    "debugExceptionWidget.border": accent,
    "debugTokenExpression.number": palette.peach,
    "debugTokenExpression.boolean": palette.mauve,
    "debugTokenExpression.string": palette.green,
    "debugTokenExpression.error": palette.red,
    // debug icons
    "debugIcon.breakpointForeground": palette.red,
    "debugIcon.breakpointDisabledForeground": opacity(palette.red, 0.6),
    "debugIcon.breakpointUnverifiedForeground": palette.base,
    "debugIcon.breakpointCurrentStackframeForeground": palette.surface2,
    "debugIcon.breakpointStackframeForeground": palette.surface2,
    "debugIcon.startForeground": palette.green,
    "debugIcon.pauseForeground": palette.blue,
    "debugIcon.stopForeground": palette.red,
    "debugIcon.disconnectForeground": palette.surface2,
    "debugIcon.restartForeground": palette.teal,
    "debugIcon.stepOverForeground": palette.mauve,
    "debugIcon.stepIntoForeground": palette.text,
    "debugIcon.stepOutForeground": palette.text,
    "debugIcon.continueForeground": palette.green,
    "debugIcon.stepBackForeground": palette.surface2,
    "debugConsole.infoForeground": palette.blue,
    "debugConsole.warningForeground": palette.peach,
    "debugConsole.errorForeground": palette.red,
    "debugConsole.sourceForeground": palette.rosewater,
    "debugConsoleInputIcon.foreground": palette.text,
    "diffEditor.border": palette.surface2,
    "diffEditor.insertedTextBackground": opacity(palette.green, 0.1),
    "diffEditor.removedTextBackground": opacity(palette.red, 0.1),
    "diffEditor.insertedLineBackground": opacity(palette.green, 0.15),
    "diffEditor.removedLineBackground": opacity(palette.red, 0.15),
    "diffEditor.diagonalFill": opacity(palette.surface2, 0.6),
    "diffEditorOverview.insertedForeground": opacity(palette.green, 0.8),
    "diffEditorOverview.removedForeground": opacity(palette.red, 0.8),
    "editor.background": palette.base,
    "editor.findMatchBackground": opacity(palette.red, 0.3),
    "editor.findMatchBorder": transparent,
    "editor.findMatchHighlightBackground": opacity(palette.sky, 0.3),
    "editor.findMatchHighlightBorder": transparent,
    "editor.findRangeHighlightBackground": opacity(palette.sky, 0.3),
    "editor.findRangeHighlightBorder": transparent,
    "editor.foldBackground": opacity(palette.sky, 0.25),
    "editor.foreground": palette.text,
    "editor.hoverHighlightBackground": opacity(palette.sky, 0.25),
    "editor.inactiveSelectionBackground": palette.surface2,
    "editor.lineHighlightBackground": opacity(palette.text, 0.07),
    "editor.lineHighlightBorder": transparent,
    "editor.rangeHighlightBackground": opacity(palette.sky, 0.25),
    "editor.rangeHighlightBorder": transparent,
    "editor.selectionBackground": palette.surface2,
    "editor.selectionHighlightBackground": opacity(palette.overlay2, 0.4),
    "editor.selectionHighlightBorder": opacity(palette.sky, 0.2),
    "editor.wordHighlightBackground": opacity(palette.surface2, 0.7),
    "editor.wordHighlightStrongBackground": opacity(palette.surface2, 0.5),
    "editorBracketMatch.background": opacity(palette.overlay2, 0.1),
    "editorBracketMatch.border": palette.overlay2,
    "editorCodeLens.foreground": palette.overlay1,
    "editorCursor.background": palette.base,
    "editorCursor.foreground": palette.rosewater,
    "editorGroup.border": palette.surface2,
    "editorGroup.dropBackground": dropBackground,
    "editorGroup.emptyBackground": palette.base,
    "editorGroupHeader.tabsBackground": palette.crust,
    "editorGutter.addedBackground": palette.green,
    "editorGutter.background": palette.base,
    "editorGutter.commentRangeForeground": palette.overlay2,
    "editorGutter.deletedBackground": palette.red,
    "editorGutter.foldingControlForeground": palette.overlay2,
    "editorGutter.modifiedBackground": palette.yellow,
    "editorHoverWidget.background": palette.mantle,
    "editorHoverWidget.border": palette.surface2,
    "editorHoverWidget.foreground": palette.text,
    "editorIndentGuide.activeBackground": palette.surface2,
    "editorIndentGuide.background": palette.surface1,
    "editorInlayHint.foreground": palette.surface2,
    "editorInlayHint.background": opacity(palette.mantle, 0.75),
    "editorInlayHint.typeForeground": palette.subtext1,
    "editorInlayHint.typeBackground": opacity(palette.mantle, 0.75),
    "editorInlayHint.parameterForeground": palette.subtext0,
    "editorInlayHint.parameterBackground": opacity(palette.mantle, 0.75),
    "editorLineNumber.activeForeground": accent,
    "editorLineNumber.foreground": palette.overlay1,
    "editorLink.activeForeground": accent,
    "editorMarkerNavigation.background": palette.mantle,
    "editorMarkerNavigationError.background": palette.red,
    "editorMarkerNavigationInfo.background": palette.blue,
    "editorMarkerNavigationWarning.background": palette.peach,
    "editorOverviewRuler.background": palette.mantle,
    "editorOverviewRuler.border": opacity(palette.text, 0.07),
    "editorOverviewRuler.modifiedForeground": palette.yellow,
    "editorRuler.foreground": palette.surface2,
    // breakpoints
    "editor.stackFrameHighlightBackground": opacity(palette.yellow, 0.15),
    "editor.focusedStackFrameHighlightBackground": opacity(palette.green, 0.15),
    "editorStickyScrollHover.background": palette.surface0,
    "editorSuggestWidget.background": palette.mantle,
    "editorSuggestWidget.border": palette.surface2,
    "editorSuggestWidget.foreground": palette.text,
    "editorSuggestWidget.highlightForeground": accent,
    "editorSuggestWidget.selectedBackground": palette.surface0,
    "editorWhitespace.foreground": opacity(palette.overlay2, 0.4),
    "editorWidget.background": palette.mantle,
    "editorWidget.foreground": palette.text,
    "editorWidget.resizeBorder": palette.surface2,
    "editorLightBulb.foreground": palette.yellow,
    // errors & warnings
    "editorError.foreground": palette.red,
    "editorError.border": transparent,
    "editorError.background": transparent,
    "editorWarning.foreground": palette.peach,
    "editorWarning.border": transparent,
    "editorWarning.background": transparent,
    "editorInfo.foreground": palette.blue,
    "editorInfo.border": transparent,
    "editorInfo.background": transparent,
    "problemsErrorIcon.foreground": palette.red,
    "problemsInfoIcon.foreground": palette.blue,
    "problemsWarningIcon.foreground": palette.peach,
    // extensions marketplace
    "extensionButton.prominentForeground": palette.crust,
    "extensionButton.prominentBackground": accent,
    "extensionButton.separator": palette.base,
    "extensionButton.prominentHoverBackground": shade(accent, 0.2),
    "extensionBadge.remoteBackground": palette.blue,
    "extensionBadge.remoteForeground": palette.crust,
    "extensionIcon.starForeground": palette.yellow,
    "extensionIcon.verifiedForeground": palette.green,
    "extensionIcon.preReleaseForeground": palette.surface2,
    "extensionIcon.sponsorForeground": palette.pink,
    // git colors
    "gitDecoration.addedResourceForeground": palette.green,
    "gitDecoration.conflictingResourceForeground": palette.mauve,
    "gitDecoration.deletedResourceForeground": palette.red,
    "gitDecoration.ignoredResourceForeground": palette.overlay0,
    "gitDecoration.modifiedResourceForeground": palette.yellow,
    "gitDecoration.stageDeletedResourceForeground": palette.red,
    "gitDecoration.stageModifiedResourceForeground": palette.yellow,
    "gitDecoration.submoduleResourceForeground": palette.blue,
    "gitDecoration.untrackedResourceForeground": palette.green,
    "input.background": palette.surface0,
    "input.border": transparent,
    "input.foreground": palette.text,
    "input.placeholderForeground": opacity(palette.text, 0.45),
    "inputOption.activeBackground": palette.surface2,
    "inputOption.activeBorder": accent,
    "inputOption.activeForeground": palette.text,
    "inputValidation.errorBackground": palette.red,
    "inputValidation.errorBorder": opacity(palette.crust, 0.2),
    "inputValidation.errorForeground": palette.crust,
    "inputValidation.infoBackground": palette.blue,
    "inputValidation.infoBorder": opacity(palette.crust, 0.2),
    "inputValidation.infoForeground": palette.crust,
    "inputValidation.warningBackground": palette.peach,
    "inputValidation.warningBorder": opacity(palette.crust, 0.2),
    "inputValidation.warningForeground": palette.crust,
    // Lists and trees
    "list.activeSelectionBackground": palette.surface1,
    // currently selected in file tree
    "list.activeSelectionForeground": palette.text,
    "list.dropBackground": dropBackground,
    "list.focusBackground": palette.surface0,
    // when using keyboard to move around files
    "list.focusForeground": palette.text,
    "list.focusOutline": transparent,
    "list.highlightForeground": accent,
    "list.hoverBackground": isLatte ? palette.surface2 : palette.base,
    // when hovering over the file tree
    "list.hoverForeground": palette.text,
    "list.inactiveSelectionBackground": palette.surface1,
    // currently selected focused in editor
    "list.inactiveSelectionForeground": palette.text,
    "list.warningForeground": palette.peach,
    "listFilterWidget.background": palette.surface1,
    "listFilterWidget.noMatchesOutline": palette.red,
    "listFilterWidget.outline": transparent,
    "tree.indentGuidesStroke": palette.overlay0,
    "menu.background": palette.base,
    "menu.border": options.extraBordersEnabled ? palette.surface2 : opacity(palette.base, 0.5),
    "menu.foreground": palette.text,
    "menu.selectionBackground": palette.surface2,
    "menu.selectionBorder": transparent,
    "menu.selectionForeground": palette.text,
    "menu.separatorBackground": palette.surface2,
    "menubar.selectionBackground": palette.surface1,
    "menubar.selectionForeground": palette.text,
    "merge.commonContentBackground": palette.surface1,
    "merge.commonHeaderBackground": palette.surface2,
    "merge.currentContentBackground": opacity(palette.green, 0.2),
    "merge.currentHeaderBackground": opacity(palette.green, 0.4),
    "merge.incomingContentBackground": opacity(palette.blue, 0.2),
    "merge.incomingHeaderBackground": opacity(palette.blue, 0.4),
    "minimap.background": opacity(palette.mantle, 0.5),
    "minimap.findMatchHighlight": opacity(palette.sky, 0.3),
    "minimap.selectionHighlight": opacity(palette.surface2, 0.75),
    "minimap.selectionOccurrenceHighlight": opacity(palette.surface2, 0.75),
    "minimap.warningHighlight": opacity(palette.peach, 0.75),
    "minimap.errorHighlight": opacity(palette.red, 0.75),
    "minimapSlider.background": opacity(accent, 0.2),
    "minimapSlider.hoverBackground": opacity(accent, 0.4),
    "minimapSlider.activeBackground": opacity(accent, 0.6),
    "minimapGutter.addedBackground": opacity(palette.green, 0.75),
    "minimapGutter.deletedBackground": opacity(palette.red, 0.75),
    "minimapGutter.modifiedBackground": opacity(palette.yellow, 0.75),
    "notificationCenter.border": accent,
    "notificationCenterHeader.foreground": palette.text,
    "notificationCenterHeader.background": palette.mantle,
    "notificationToast.border": accent,
    "notifications.foreground": palette.text,
    "notifications.background": palette.mantle,
    "notifications.border": accent,
    "notificationLink.foreground": palette.blue,
    "notificationsErrorIcon.foreground": palette.red,
    "notificationsWarningIcon.foreground": palette.peach,
    "notificationsInfoIcon.foreground": palette.blue,
    "panel.background": palette.base,
    "panel.border": palette.surface2,
    "panelSection.border": palette.surface2,
    "panelSection.dropBackground": dropBackground,
    "panelTitle.activeBorder": accent,
    "panelTitle.activeForeground": palette.text,
    "panelTitle.inactiveForeground": palette.subtext0,
    // peek view colors
    "peekView.border": accent,
    "peekViewEditor.background": palette.mantle,
    "peekViewEditorGutter.background": palette.mantle,
    "peekViewEditor.matchHighlightBackground": opacity(palette.sky, 0.3),
    "peekViewEditor.matchHighlightBorder": transparent,
    "peekViewResult.background": palette.mantle,
    "peekViewResult.fileForeground": palette.text,
    "peekViewResult.lineForeground": palette.text,
    "peekViewResult.matchHighlightBackground": opacity(palette.sky, 0.3),
    "peekViewResult.selectionBackground": palette.surface0,
    "peekViewResult.selectionForeground": palette.text,
    "peekViewTitle.background": palette.base,
    "peekViewTitleDescription.foreground": opacity(palette.subtext1, 0.7),
    "peekViewTitleLabel.foreground": palette.text,
    "pickerGroup.border": accent,
    "pickerGroup.foreground": accent,
    "progressBar.background": accent,
    "scrollbar.shadow": palette.crust,
    "scrollbarSlider.activeBackground": opacity(palette.surface0, 0.4),
    "scrollbarSlider.background": opacity(palette.surface2, 0.5),
    "scrollbarSlider.hoverBackground": palette.overlay0,
    "settings.focusedRowBackground": opacity(palette.surface2, 0.2),
    "settings.headerForeground": palette.text,
    "settings.modifiedItemIndicator": accent,
    "settings.dropdownBackground": palette.surface1,
    "settings.dropdownListBorder": transparent,
    "settings.textInputBackground": palette.surface1,
    "settings.textInputBorder": transparent,
    "settings.numberInputBackground": palette.surface1,
    "settings.numberInputBorder": transparent,
    "sideBar.background": palette.mantle,
    "sideBar.dropBackground": dropBackground,
    "sideBar.foreground": palette.text,
    "sideBar.border": border,
    "sideBarSectionHeader.background": palette.mantle,
    "sideBarSectionHeader.foreground": palette.text,
    "sideBarTitle.foreground": accent,
    // banners, such as Restricted Mode
    "banner.background": palette.surface1,
    "banner.foreground": palette.text,
    "banner.iconForeground": palette.text,
    // Status Bar
    "statusBar.background": palette.crust,
    "statusBar.foreground": palette.text,
    "statusBar.border": border,
    // having no folder open shouldn't change the bar
    "statusBar.noFolderBackground": palette.crust,
    "statusBar.noFolderForeground": palette.text,
    "statusBar.noFolderBorder": border,
    // debugging is peach
    "statusBar.debuggingBackground": palette.peach,
    "statusBar.debuggingForeground": palette.crust,
    "statusBar.debuggingBorder": border,
    // offline styled the same as banners
    "statusBar.offlineBackground": palette.surface1,
    "statusBar.offlineForeground": palette.text,
    // remote is blue
    "statusBarItem.remoteBackground": palette.blue,
    "statusBarItem.remoteForeground": palette.crust,
    // different states
    "statusBarItem.activeBackground": opacity(palette.surface2, 0.4),
    "statusBarItem.hoverBackground": opacity(palette.surface2, 0.2),
    "statusBarItem.prominentForeground": accent,
    "statusBarItem.prominentBackground": transparent,
    "statusBarItem.prominentHoverBackground": opacity(palette.surface2, 0.2),
    "statusBarItem.errorForeground": palette.red,
    "statusBarItem.errorBackground": transparent,
    "statusBarItem.warningForeground": palette.peach,
    "statusBarItem.warningBackground": transparent,
    // command center
    "commandCenter.foreground": palette.subtext1,
    "commandCenter.activeForeground": accent,
    "commandCenter.background": palette.crust,
    "commandCenter.activeBackground": opacity(palette.surface2, 0.2),
    "commandCenter.border": accent,
    // Tab Bar
    "tab.activeBackground": palette.base,
    "tab.activeBorder": accent,
    "tab.activeBorderTop": transparent,
    "tab.activeForeground": accent,
    "tab.border": palette.mantle,
    "tab.inactiveBackground": palette.mantle,
    "tab.inactiveForeground": palette.overlay0,
    "tab.activeModifiedBorder": palette.yellow,
    "tab.inactiveModifiedBorder": opacity(palette.yellow, 0.3),
    // Terminal
    "terminal.foreground": palette.text,
    "terminal.ansiBlack": isLatte ? palette.surface1 : palette.subtext0,
    // color0
    "terminal.ansiRed": palette.red,
    // color1
    "terminal.ansiGreen": palette.green,
    // color2
    "terminal.ansiYellow": palette.yellow,
    // color3
    "terminal.ansiBlue": palette.blue,
    // color4
    "terminal.ansiMagenta": palette.pink,
    // color5
    "terminal.ansiCyan": palette.sky,
    // color6
    "terminal.ansiWhite": isLatte ? palette.surface2 : palette.subtext1,
    // color7
    "terminal.ansiBrightBlack": isLatte ? palette.subtext0 : palette.surface2,
    // color8
    "terminal.ansiBrightRed": palette.red,
    // color9
    "terminal.ansiBrightGreen": palette.green,
    // color10
    "terminal.ansiBrightYellow": palette.yellow,
    // color11
    "terminal.ansiBrightBlue": palette.blue,
    // color12
    "terminal.ansiBrightMagenta": palette.pink,
    // color13
    "terminal.ansiBrightCyan": palette.sky,
    // color14
    "terminal.ansiBrightWhite": isLatte ? palette.subtext1 : palette.surface1,
    // color15
    "terminal.selectionBackground": palette.surface2,
    "terminal.inactiveSelectionBackground": opacity(palette.surface2, 0.5),
    "terminalCursor.background": palette.base,
    "terminalCursor.foreground": palette.rosewater,
    "terminal.border": palette.surface2,
    "terminal.dropBackground": dropBackground,
    "terminal.tab.activeBorder": accent,
    // title bar
    "titleBar.activeBackground": palette.crust,
    "titleBar.activeForeground": palette.text,
    "titleBar.inactiveBackground": palette.crust,
    "titleBar.inactiveForeground": opacity(palette.text, 0.5),
    "titleBar.border": border,
    // welcome page
    "welcomePage.tileBackground": palette.mantle,
    "welcomePage.progress.background": palette.crust,
    "welcomePage.progress.foreground": accent,
    "walkThrough.embeddedEditorBackground": opacity(palette.base, 0.3),
    // symbols in outline, autocomplete, etc.
    "symbolIcon.textForeground": palette.text,
    "symbolIcon.arrayForeground": palette.peach,
    "symbolIcon.booleanForeground": palette.mauve,
    "symbolIcon.classForeground": palette.yellow,
    "symbolIcon.colorForeground": palette.pink,
    "symbolIcon.constantForeground": palette.peach,
    "symbolIcon.constructorForeground": palette.lavender,
    "symbolIcon.enumeratorForeground": palette.yellow,
    "symbolIcon.enumeratorMemberForeground": palette.yellow,
    "symbolIcon.eventForeground": palette.pink,
    "symbolIcon.fieldForeground": palette.text,
    "symbolIcon.fileForeground": accent,
    "symbolIcon.folderForeground": accent,
    "symbolIcon.functionForeground": palette.blue,
    "symbolIcon.interfaceForeground": palette.yellow,
    "symbolIcon.keyForeground": palette.teal,
    "symbolIcon.keywordForeground": palette.mauve,
    "symbolIcon.methodForeground": palette.blue,
    "symbolIcon.moduleForeground": palette.text,
    "symbolIcon.namespaceForeground": palette.yellow,
    "symbolIcon.nullForeground": palette.maroon,
    "symbolIcon.numberForeground": palette.peach,
    "symbolIcon.objectForeground": palette.yellow,
    "symbolIcon.operatorForeground": palette.teal,
    "symbolIcon.packageForeground": palette.flamingo,
    "symbolIcon.propertyForeground": palette.maroon,
    "symbolIcon.referenceForeground": palette.yellow,
    "symbolIcon.snippetForeground": palette.flamingo,
    "symbolIcon.stringForeground": palette.green,
    "symbolIcon.structForeground": palette.teal,
    "symbolIcon.typeParameterForeground": palette.maroon,
    "symbolIcon.unitForeground": palette.text,
    "symbolIcon.variableForeground": palette.text,
    // chart colors
    "charts.foreground": palette.text,
    "charts.lines": palette.subtext1,
    "charts.red": palette.red,
    "charts.blue": palette.blue,
    "charts.yellow": palette.yellow,
    "charts.orange": palette.peach,
    "charts.green": palette.green,
    "charts.purple": palette.mauve,
    ...extensions_default(context),
    // workbench overrides
    ...getCustomizedColors(context),
    // custom named overrides
    ...customNamedColors
  };
};

// src/theme/index.ts
var defaultOptions = {
  accent: "mauve",
  boldKeywords: true,
  italicComments: true,
  italicKeywords: true,
  colorOverrides: {},
  workbenchMode: "default",
  bracketMode: "rainbow",
  extraBordersEnabled: false,
  customUIColors: {}
};
var compileTheme = (flavour = "mocha", options = defaultOptions) => {
  var _a, _b;
  const ctpPalette = Object.entries(variants[flavour]).map(([k, v]) => {
    return {
      [k]: v["hex"],
      name: flavour
    };
  }).reduce((acc, curr) => ({ ...acc, ...curr }), {});
  const palette = {
    ...ctpPalette,
    ...(_a = options.colorOverrides) == null ? void 0 : _a.all,
    ...(_b = options.colorOverrides) == null ? void 0 : _b[flavour]
  };
  const context = {
    palette,
    options,
    isLatte: flavour === "latte"
  };
  const flavourName = `Catppuccin ${capitalize(flavour)}`;
  const theme = {
    name: flavourName,
    type: context.isLatte ? "light" : "dark",
    colors: getUiColors(context),
    semanticHighlighting: true,
    semanticTokenColors: getSemanticTokens(context),
    tokenColors: getTokenColors(context)
  };
  return theme;
};

// src/utils.ts
var import_vscode = require("vscode");
var Utils = class {
  constructor() {
    this.promptToReload = (trigger) => {
      const msg = `Catppuccin: ${trigger} - Reload required.`;
      const action = "Reload window";
      import_vscode.window.showInformationMessage(msg, action).then((selectedAction) => {
        if (selectedAction === action) {
          import_vscode.commands.executeCommand("workbench.action.reloadWindow");
        }
      });
    };
    this.writeThemeFile = async (uri, data) => {
      return import_vscode.workspace.fs.writeFile(uri, Buffer.from(JSON.stringify(data, null, 2))).then(
        () => {
        },
        (err) => {
          import_vscode.window.showErrorMessage(err.message);
        }
      );
    };
    this.fileExists = async (uri) => {
      return import_vscode.workspace.fs.stat(uri).then(
        () => true,
        () => false
      );
    };
    this.isMutable = async (uri) => {
      return import_vscode.workspace.fs.stat(uri).then(
        (stat) => stat.permissions !== import_vscode.FilePermission.Readonly,
        (err) => err
      );
    };
    this.isFreshInstall = async (ctx) => {
      console.log("Checking if catppuccin is installed for the first time.");
      const flagUri = import_vscode.Uri.file(ctx.asAbsolutePath("themes/.flag"));
      if (await this.fileExists(flagUri)) {
        console.log("Catppuccin has been installed before.");
        return false;
      } else {
        console.log("Catppuccin is installed for the first time!");
        return import_vscode.workspace.fs.writeFile(flagUri, Buffer.from("")).then(
          () => true,
          () => "error"
        );
      }
    };
    this.isDefaultConfig = () => {
      console.log("Checking if catppuccin is using default config.");
      const state = JSON.stringify(this.getConfiguration()) === JSON.stringify(defaultOptions);
      console.log(`Catppuccin is using ${state ? "default" : "custom"} config.`);
      return state;
    };
    this.getConfiguration = () => {
      const conf = import_vscode.workspace.getConfiguration("catppuccin");
      return {
        accent: conf.get("accentColor") ?? defaultOptions.accent,
        boldKeywords: conf.get("boldKeywords") ?? defaultOptions.boldKeywords,
        italicKeywords: conf.get("italicKeywords") ?? defaultOptions.italicKeywords,
        italicComments: conf.get("italicComments") ?? defaultOptions.italicComments,
        colorOverrides: conf.get("colorOverrides") ?? defaultOptions.colorOverrides,
        workbenchMode: conf.get("workbenchMode") ?? defaultOptions.workbenchMode,
        bracketMode: conf.get("bracketMode") ?? defaultOptions.bracketMode,
        extraBordersEnabled: conf.get("extraBordersEnabled") ?? defaultOptions.extraBordersEnabled,
        customUIColors: conf.get("customUIColors") ?? defaultOptions.customUIColors
      };
    };
    this.updateThemes = async (options, paths, trigger) => {
      const flavours = Object.keys(variants);
      const promises = flavours.map(async (flavour) => {
        const theme = compileTheme(flavour, options);
        return this.writeThemeFile(paths[flavour], theme);
      });
      Promise.all(promises).then(() => {
        this.promptToReload(trigger);
      });
    };
    this.syncToIconPack = () => {
      const id = "catppuccin.catppuccin-vsc-icons";
      if (import_vscode.extensions.getExtension(id) === void 0)
        return;
      const uiThemesToIconThemes = {
        "Catppuccin Latte": "catppuccin-latte",
        "Catppuccin Frapp\xE9": "catppuccin-frappe",
        "Catppuccin Macchiato": "catppuccin-macchiato",
        "Catppuccin Mocha": "catppuccin-mocha"
      };
      const uiTheme = import_vscode.workspace.getConfiguration("workbench").get("colorTheme") ?? "";
      const ctpThemeActive = Object.keys(uiThemesToIconThemes).includes(uiTheme);
      const ctpIconsActive = Object.values(uiThemesToIconThemes).includes(
        import_vscode.workspace.getConfiguration("workbench").get("iconTheme") ?? ""
      );
      if (ctpThemeActive && ctpIconsActive) {
        const iconTheme = uiThemesToIconThemes[uiTheme];
        import_vscode.workspace.getConfiguration("workbench").update("iconTheme", iconTheme, import_vscode.ConfigurationTarget.Global);
      }
    };
  }
};
var utils_default = new Utils();

// src/main.ts
var activate = async (ctx) => {
  const base = ctx.extensionUri;
  const paths = {
    latte: import_vscode2.Uri.joinPath(base, "themes", "latte.json"),
    frappe: import_vscode2.Uri.joinPath(base, "themes", "frappe.json"),
    macchiato: import_vscode2.Uri.joinPath(base, "themes", "macchiato.json"),
    mocha: import_vscode2.Uri.joinPath(base, "themes", "mocha.json")
  };
  if (await utils_default.isFreshInstall(ctx) && !utils_default.isDefaultConfig()) {
    utils_default.updateThemes(
      utils_default.getConfiguration(),
      paths,
      "Update detected" /* FRESH_INSTALL */
    );
  }
  ctx.subscriptions.push(
    import_vscode2.workspace.onDidChangeConfiguration((event) => {
      if (event.affectsConfiguration("catppuccin")) {
        utils_default.updateThemes(
          utils_default.getConfiguration(),
          paths,
          "Configuration changed" /* CONFIG_CHANGE */
        );
      }
      if (event.affectsConfiguration("workbench.colorTheme")) {
        utils_default.syncToIconPack();
      }
    })
  );
  utils_default.syncToIconPack();
};
// Annotate the CommonJS export names for ESM import in node:
0 && (module.exports = {
  activate
});
//# sourceMappingURL=main.js.map