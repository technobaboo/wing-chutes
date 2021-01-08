//generated config
module.exports = {
  "global": {
    "onBuildSuccess": null
  },
  "mc": {
    "dev": true,

	"colorModelData": [
		{"baseColor": 0, "circuitColor": 1, "customModelData": 1},
		{"baseColor": 0, "circuitColor": 2, "customModelData": 2},
		{"baseColor": 0, "circuitColor": 3, "customModelData": 3},

		{"baseColor": 1, "circuitColor": 1, "customModelData": 11},
		{"baseColor": 1, "circuitColor": 2, "customModelData": 12},
		{"baseColor": 1, "circuitColor": 3, "customModelData": 13}
	],

	"elytraTag": {
		"display": {
			"Name": {
				"text":"Wing Chute"
			},
			"Lore": [
				{"text":"Try to jump in midair!"},
				{"text":"The wing chute will deploy"},
				{"text":"if strapped to your back!"}
			]
		},
		"CustomModelData":0,
		"HideFlags":63,
		"Damage":0,
		"Unbreakable":1,
		"WingChute":1
	},
	"wingChuteTag": {
		"display": {
			"Name": {
				"text":"Wing Chute (Wings)"
			}
		},
		"CustomModelData":0
	},

	"functions": require("./util.js"),
	"tmp": {},

    "header": "# Built by Nova King using MCBuild",
    "internalScoreboard": "LANG_MC_INTERNAL",
    "rootNamespace": null
  }
}
