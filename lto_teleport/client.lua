-- Add Teleport Location Here
-- Position #1 To Position #2 + Color of the Marker RGB
positions = {
    {{-756.55, -1322.80, 43.71, 0}, {-969.25, -1174.10, 48.74, 0}, "1"}, --  Blackwater silahçı
    {{1324.13, -1301.29, 76.31, 0}, {1344.62, -1317.15, 77.57, 0}, "2"}, -- Change Me / Add More
    --{{1324.13, -1301.29, 76.31, 0}, {1344.62, -1317.15, 77.57, 0},{0,191,255}, "3"}, -- Change Me / Add More
}

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
		local playerPed = PlayerPedId()
        local playerLoc = GetEntityCoords(playerPed)

        for _,location in ipairs(positions) do

            loc1 = {x=location[1][1], y=location[1][2], z=location[1][3], heading=location[1][4]}
            loc2 = {x=location[2][1], y=location[2][2], z=location[2][3], heading=location[2][4]}
            Red = location[3][1]
            Green = location[3][2]
            Blue = location[3][3]
			
       --     DrawMarker(0x94FDAE17, loc1.x, loc1.y, loc1.z, 0, 0, 0, 0, 0, 0, 1.20, 1.20, 0.30, Red, Green, Blue, 200, 0, 0, 0, 0)
       --     DrawMarker(0x94FDAE17, loc2.x, loc2.y, loc2.z, 0, 0, 0, 0, 0, 0, 1.20, 1.20, 0.30, Red, Green, Blue, 200, 0, 0, 0, 0)

            if CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc1.x, loc1.y, loc1.z, 2) then 
			    DrawTxt('İçeri girmek için [~e~Enter~q~] tuşuna basın', 0.45, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
 
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedOnMount(playerPed, true) then
                        SetEntityCoords(GetMount(playerPed), loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(GetMount(playerPed), loc2.heading)
                    else
                        SetEntityCoords(playerPed, loc2.x, loc2.y, loc2.z)
                        SetEntityHeading(playerPed, loc2.heading)
                    end
                end

            elseif CheckPos(playerLoc.x, playerLoc.y, playerLoc.z, loc2.x, loc2.y, loc2.z, 2) then
                DrawTxt('Çıkmak için [~e~Enter~q~] tuşuna basın', 0.45, 0.85, 0.5, 0.5, true, 255, 255, 255, 150, false)
				
                if IsControlJustPressed(0, 0xC7B5340A) then
                    if IsPedOnMount(playerPed, true) then
                        SetEntityCoords(GetMount(playerPed), loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(GetMount(playerPed), loc1.heading)
                    else
                        SetEntityCoords(playerPed, loc1.x, loc1.y, loc1.z)
                        SetEntityHeading(playerPed, loc1.heading)
                    end
                end
            end            
        end
    end
end)

function DrawMarker(type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)
	Citizen.InvokeNative(0x2A32FAA57B937173, type, posX, posY, posZ, dirX, dirY, dirZ, rotX, rotY, rotZ, scaleX, scaleY, scaleZ, red, green, blue, alpha, bobUpAndDown, faceCamera, p19, rotate, textureDict, textureName, drawOnEnts)
end

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2
    local t2 = y-cy
    local t21 = t2^2
    local t3 = z - cz
    local t31 = t3^2
    return (t12 + t21 + t31) <= radius^1
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end