function load {
	scoreboard objectives add basecolor trigger "Base Color"

	scoreboard objectives remove airbelow
	scoreboard objectives add airbelow dummy
	scoreboard players reset * airbelow

	tellraw @a ["",{"text":"No","color":"dark_aqua"},{"text":"va","color":"green"},{"text":"'s "},{"text":"Wing Chutes","color":"gold"},{"text":" loaded!"}]
}


function tick {
	# Tag everyone who has a wing chute on
	tag @a remove wearingWingChute
	tag @a[nbt={Inventory:[{Slot:102b,tag:{WingChute:1}}]}] add wearingWingChute

	# Enable or disable the wing chute based on the proximity to the ground
	execute as @a[tag=wearingWingChute] run function wing_chutes:disable
	execute as @a[tag=wearingWingChute] at @s if block ~ ~-1 ~ air if block ~ ~-2 ~ air run function wing_chutes:enable

	# If the player started gliding while wearing a wing chute, deploy the wings and update the tags!
	execute as @a[tag=wearingWingChute,tag=!usingWingChute,nbt={FallFlying:1b}] run function wing_chutes:deploy
	tag @a[tag=wearingWingChute,nbt={FallFlying:1b}] add usingWingChute

	# If the player stopped gliding while wearing a wing chute, retract the wings and update the tags!
	execute as @a[tag=usingWingChute,nbt={FallFlying:0b}] run function wing_chutes:retract
	tag @a[tag=usingWingChute,nbt={FallFlying:0b}] remove usingWingChute
}


function give {
	<%%
		let elytraTag = config.functions.generateTagFromConfig(config.elytraTag);
		config.functions.forEachColor(
			config.colorModelData,
			elytraTag,
			{},
			function(executePart, tagString) {
				let command = `${executePart} run give @s elytra${tagString} 1`;
				// console.log(command);
				emit(command);
			}
		);
	%%>
}

function enable {
	<%%
		let elytraTag = config.functions.generateTagFromConfig(config.elytraTag);
		config.functions.forEachColor(
			config.colorModelData,
			elytraTag,
			{Damage:0},
			function(executePart, tagString) {
				let command = `${executePart} run replaceitem entity @s armor.chest elytra${tagString}`;
				// console.log(command);
				emit(command);
			}
		);
	%%>
}

function disable {
	<%%
		let elytraTag = config.functions.generateTagFromConfig(config.elytraTag);
		config.functions.forEachColor(
			config.colorModelData,
			elytraTag,
			{Damage:431},
			function(executePart, tagString) {
				let command = `${executePart} run replaceitem entity @s armor.chest elytra${tagString}`;
				// console.log(command);
				emit(command);
			}
		);
	%%>
}



function deploy {
	effect give @s slow_falling 999999 0 true

	<%%
		let wingChuteTag = config.functions.generateTagFromConfig(config.wingChuteTag);
		config.functions.forEachColor(
			config.colorModelData,
			wingChuteTag,
			{},
			function(executePart, tagString) {
				let command = `${executePart} run replaceitem entity @s armor.head paper${tagString}`;
				// console.log(command);
				emit(command);
			}
		);
	%%>
}

function retract {
	effect clear @s slow_falling
	execute as @s run replaceitem entity @s armor.head air
}
