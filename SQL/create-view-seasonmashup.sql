CREATE VIEW `seasonmashup` AS 
select `rg`.`gameType` AS `gametype`
    , year(`w`.`gameDate`) AS `Year`
    , `w`.`year` AS `season`
    , `w`.`week` AS `week`
    , `w`.`gid` AS `gid`
    , `t`.`name` AS `WinningTeam`
    , `t`.`ownerID` AS `WinningOwnerID`
    , `w`.`teamScore` AS `WinningTeamScore`
    , `t2`.`name` AS `LosingTeam`
    , `t2`.`ownerID` AS `LosingOwnerID`
    , `l`.`teamScore` AS `LosingTeamScore`
    , case 
        when `w`.`division` = 0 then 'Yes' 
        else 'No' end AS `DivisionGame`
    , `w`.`location` AS `WinningTeamLocation` 
    , `w`.`teamScore`-`l`.`teamScore` AS 'ScoreDifferential'
from `gamedetail` `w` 
left join `teams` `t` on `w`.`teamID` = `t`.`teamID` 
left join `ref_gametype` `rg` on `w`.`gameTypeID` = `rg`.`gameTypeID` 
left join `gamedetail` `l` on(`w`.`gid` = `l`.`gid` and `l`.`status` = 'L' 
left join `teams` `t2` on `l`.`teamID` = `t2`.`teamID` 
where `w`.`status` = 'W'