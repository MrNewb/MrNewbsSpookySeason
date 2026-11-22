lib.callback.register('MrNewbsSpookySeason:Callback:UseItemProgress', function(itemLabel)
	return bridge.progressbar.openprogressbar({
		duration = 5000,
		label = itemLabel or '',
		disable = { move = true, combat = true },
		anim = { dict = 'anim@heists@humane_labs@emp@hack_door', clip = 'hack_loop', flag = 1 },
		prop = {
			model = 'xm3_prop_xm3_present_01a',
			bone = 28422,
			pos = vector3(0.00, -0.19, -0.16),
			rot = vector3(0.0, 0.0, 0.0),
		},
		canCancel = true,
	}) or false
end)
