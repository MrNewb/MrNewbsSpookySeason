function RegisterSpookyDecorations()
	local batch = {}
	for index, decoration in ipairs(Config.Decorations) do
		batch[#batch + 1] = {
			id = ('MrNewbsSpookySeason:decoration:%s'):format(index),
			payload = {
				model = decoration.model,
				coords = vector3(decoration.position.x, decoration.position.y, decoration.position.z),
				heading = decoration.position.w,
				radius = 100.0,
			},
		}
	end

	exports[bridge.name]:AddInteractionsBatch(batch)
end

function RemoveSpookyDecorations()
	for index in ipairs(Config.Decorations) do
		exports[bridge.name]:RemoveInteraction(('MrNewbsSpookySeason:decoration:%s'):format(index))
	end
end
