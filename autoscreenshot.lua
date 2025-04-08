--| Module creator: Discord: @pogofcz | GitHub: @pogof 
--|
--| https://github.com/pogof/SimplyLove-Assorted-Modules
--|
--| To use this drop this file into Simply Love/Modules folder. It can also be Z-Mod or
--| any other theme that is Simply Love based (And for ITGmania!).
--| 
--| This module will take a screenshot of the results screen if you get a personal record (ITG).
--| It can be either player one or player two. It does not support course mode.
--| 
--| Due to animation delays the screenshot will be taken 3 seconds after you arrive at the evaluation screen.
--| This is to ensure that you are not taking a screenshot of black screen or text over the eval screen.

--| You can find the screenshots in your profile folder/Screenshots
--| You can specify the subfolder path in the prefix below.
--|
--| Most of the code was adapted from already existing Simply Love codebase. Mainly from
--| ScreenEvaluationStage folder.
--|
--| IMPORTANT: IF YOU ARE PLAYIN ITL/SRPG that draw the score box over the evaluation screen make sure this takes
--| screenshot of the evaluation screen and not the score box. The 3 seconds should be short enough to be safe, but
--| check few times to make sure!!
--================================================================================================================================================================





local u = {}


u["ScreenEvaluationStage"] = Def.Actor {
    ModuleCommand = function(self)



-----------------------------------------------------------------------------------------
-- You can edit the sleep time if your screenshots are black/have the CLEAR/FAILED text over them.
-- 3 = seconds, 0.001 = 1 milisecond
-----------------------------------------------------------------------------------------
        
    self:sleep(3):queuecommand("GetScore")

------------------------------------------------------------------------------------------

    end,

    GetScoreCommand = function(self)
    
        for player in ivalues(GAMESTATE:GetHumanPlayers()) do
            local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
            local personal = pss:GetPersonalHighScoreIndex()

            local EarnedPersonalRecord = ( personal ~= -1 ) and pss:GetPercentDancePoints() >= 0.01
            if EarnedPersonalRecord and personal == 0 then
               -- self:queuecommand("TakeScreen")




-- You can change the screenshot path here.


                -- You can change the subfolder path here.
                local subfolder = "PB"

                -- If you are feeling adventurous you can change the naming scheme below.
                -- It is however recommended to keep it as it is.
                -- It is also what Simply Love already uses for screenshots.

                -- format a localized month string like "06-June" or "12-Diciembre"
                local month = ("%02d-%s"):format(MonthOfYear()+1, THEME:GetString("Months", "Month"..MonthOfYear()+1))

                -- get the FullTitle of the song or course that was just played
                local title = GAMESTATE:IsCourseMode() and GAMESTATE:GetCurrentCourse():GetDisplayFullTitle() or GAMESTATE:GetCurrentSong():GetDisplayFullTitle()

                -- song titles can be very long, and the engine's SaveScreenshot() function
                -- is already hardcoded to make the filename long via DateTime::GetNowDateTime()
                -- so, let's use only the first 10 characters of the title in the screenshot filename
                title = title:utf8sub(1,10)

                -- substitute all symbols with underscores to avoid file name conflicts
                title = title:gsub("%W", "_")

                local prefix = subfolder .. "/" .. Year() .. "/" .. month .. "/" .. title


                
-- And this is the end of what you should be changing.                 
                
                
                
                
                
                
                local success, path = SaveScreenshot(player, false, false , prefix)





            end

        end
    
    end

}

return u
