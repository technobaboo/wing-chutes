function stringifyNBT(obj_from_json) {
	if (typeof obj_from_json !== "object" || Array.isArray(obj_from_json)){
		// not an object, stringify using native function
		return JSON.stringify(obj_from_json);
	}
	// Implements recursive object serialization according to JSON spec
	// but without quotes around the keys.
	let props = Object
		.keys(obj_from_json)
		.map(key => `${key}:${stringifyNBT(obj_from_json[key])}`)
		.join(",");
	return `{${props}}`;
}

function generateTagFromConfig(configTag) {
	let tag = JSON.parse(JSON.stringify(configTag));

	tag.display.Name = JSON.stringify(tag.display.Name);
	if(tag.display.Lore) {
		tag.display.Lore.forEach(function(item, index, array) {
			array[index] = JSON.stringify(item);
		});
	}

	return tag;
};

function overrideTagData(baseTag, overrideData) {
	return {
		...baseTag,
		...overrideData
	}
}

function forEachColor(colorModelData, baseTag, dataOverride, runFunction) {
	let tag = overrideTagData(baseTag, dataOverride);

	let colorCombinations = colorModelData.length;

	for(let i = 0; i < colorCombinations; ++i) {
		let baseColor = colorModelData[i].baseColor;
		let circuitColor = colorModelData[i].circuitColor;
		let customModelData = colorModelData[i].customModelData;
customModelData
		tag.CustomModelData = customModelData;

		let tagString = stringifyNBT(tag);
		let executePart = `execute if entity @s[scores={basecolor=${baseColor},circuitcolor=${circuitColor}}]`;
		runFunction(executePart, tagString);
	}
}

module.exports = {
	stringifyNBT,
	generateTagFromConfig,
	overrideTagData,
	forEachColor
}
