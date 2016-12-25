-- ----------------------------------------
-- Added to prevent timeout's while loading
-- ----------------------------------------
SET GLOBAL net_read_timeout=30;
SET GLOBAL net_write_timeout=60;
SET GLOBAL net_buffer_length=1000000; 
SET GLOBAL max_allowed_packet=1000000000;
SET GLOBAL connect_timeout=10000000;

-- --------------------------------------------------------------------------------
-- This is an attempt to create a full transactional MaNGOS update (v1.3)
-- --------------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `update_mangos`; 

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_mangos`()
BEGIN
    DECLARE bRollback BOOL  DEFAULT FALSE ;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `bRollback` = TRUE;

    -- Current Values (TODO - must be a better way to do this)
    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurStructure := (SELECT structure FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cCurContent := (SELECT content FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);

    -- Expected Values
    SET @cOldVersion = '21'; 
    SET @cOldStructure = '03'; 
    SET @cOldContent = '15';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '03';
    SET @cNewContent = '16';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Blood Elf Bandit';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Blood Elf Bandit';

    -- Evaluate all settings
    SET @cCurResult := (SELECT description FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
    SET @cOldResult := (SELECT description FROM db_version WHERE `version`=@cOldVersion AND `structure`=@cOldStructure AND `content`=@cOldContent);
    SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

    IF (@cCurResult = @cOldResult) THEN    -- Does the current version match the expected version
        -- APPLY UPDATE
        START TRANSACTION;

        -- UPDATE THE DB VERSION
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        INSERT INTO `db_version` VALUES (@cNewVersion, @cNewStructure, @cNewContent, @cNewDescription, @cNewComment);
        SET @cNewResult := (SELECT description FROM db_version WHERE `version`=@cNewVersion AND `structure`=@cNewStructure AND `content`=@cNewContent);

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL BELOW -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

-- UDB UPDATE [405] Blood Elf Bandit
-- Blood Elf Bandit
-- wrong spawns removed
DELETE FROM creature WHERE id = 17591; 
-- Correct spawn locations - should be 10 in total
-- missing added - UDB free guids reused
-- small note - molid had to be set (reason: seting female model = client crush)
DELETE FROM creature WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM creature_addon WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM creature_movement WHERE id IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM game_event_creature WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM game_event_creature_data WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM creature_battleground WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
DELETE FROM creature_linking WHERE guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113)
OR master_guid IN (84104,84105,84106,84107,84108,84109,84110,84111,84112,84113);
INSERT INTO creature (guid, id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(84104,17591,530,1,1,17115,0,-4210.5,-11623.5,7.85861,6.14483,60,0,0,103,0,0,0),  -- 27.6, 52.1 - Between a large tree and a lit pillar on side of the road.
(84105,17591,530,1,1,17115,0,-4494.68,-11815.3,14.658,4.0476,60,0,0,103,0,0,0),   -- 32.3, 62.7 - Next to a large broken pillar.
(84106,17591,530,1,1,17115,0,-4715.08,-11881,26.6153,1.01286,60,0,0,103,0,0,0),   -- 33.8, 70.7 - Next to a large tree on side of the road.
(84107,17591,530,1,1,17115,0,-4554.34,-11935.9,28.3687,5.84462,60,0,0,103,0,0,0), -- 35.3, 64.8 - Next to a lit pillar at fork in the road.
(84108,17591,530,1,1,17115,0,-4516.35,-12253.7,17.1639,5.9114,60,0,0,103,0,0,0),  -- 43.1, 63.5 - Next to a patch of bushes slightly off side of the road.
(84109,17591,530,1,1,17115,0,-3866.65,-12392.6,0.681576,4.271,60,0,0,103,0,0,0),  -- 46.6, 39.5 - Next to a purple street light on side of the road.
(84110,17591,530,1,1,17115,0,-3592.69,-12552.4,18.7525,1.29588,60,0,0,103,0,0,0), -- 50.4, 29.2 - Next to a small broken pillar on side of the road.
(84111,17591,530,1,1,17115,0,-3276.44,-12606.2,38.6142,4.28432,60,0,0,103,0,0,0), -- 51.9, 17.6 - Next to a lit pillar on southwest corner of a small bridge.
(84112,17591,530,1,1,17115,0,-3362.6,-11999.4,19.2218,4.15353,60,0,0,103,0,0,0),  -- 36.8, 21.0 - Next to a large tree just off side of the road.
(84113,17591,530,1,1,17115,0,-3675.1,-12001.7,6.26555,1.70936,60,0,0,103,0,0,0); -- 36.7, 32.7 - Next to a small broken pillar and large tree on side of the road.

-- Only one can be spawned at at the same time
DELETE FROM pool_template WHERE entry = 25520;
INSERT INTO pool_template (entry, max_limit, description) VALUES 
(25520,1,'Blood Elf Bandit');
DELETE FROM pool_creature_template WHERE pool_entry = 25520;
INSERT INTO pool_creature_template (id, pool_entry, chance, description) VALUES
(17591, 25520, 0, 'Blood Elf Bandit - 17591');
    

        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
        -- -- PLACE UPDATE SQL ABOVE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

        -- If we get here ok, commit the changes
        IF bRollback = TRUE THEN
            ROLLBACK;
            SHOW ERRORS;
            SELECT '* UPDATE FAILED *' AS `===== Status =====`,@cCurResult AS `===== DB is on Version: =====`;



        ELSE
            COMMIT;
            SELECT '* UPDATE COMPLETE *' AS `===== Status =====`,@cNewResult AS `===== DB is now on Version =====`;
        END IF;
    ELSE    -- Current version is not the expected version
        IF (@cCurResult = @cNewResult) THEN    -- Does the current version match the new version
            SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cCurResult AS `===== DB is already on Version =====`;
        ELSE    -- Current version is not one related to this update
            IF(@cCurResult IS NULL) THEN    -- Something has gone wrong
                SELECT '* UPDATE FAILED *' AS `===== Status =====`,'Unable to locate DB Version Information' AS `============= Error Message =============`;
            ELSE
		IF(@cOldResult IS NULL) THEN    -- Something has gone wrong
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SET @cOldResult = CONCAT('Rel',@cOldVersion, '_', @cOldStructure, '_', @cOldContent, ' - ','IS NOT APPLIED');
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
		ELSE
		    SET @cCurVersion := (SELECT `version` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurStructure := (SELECT `STRUCTURE` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
		    SET @cCurContent := (SELECT `Content` FROM db_version ORDER BY `version` DESC, STRUCTURE DESC, CONTENT DESC LIMIT 0,1);
                    SET @cCurOutput = CONCAT(@cCurVersion, '_', @cCurStructure, '_', @cCurContent, ' - ',@cCurResult);
                    SELECT '* UPDATE SKIPPED *' AS `===== Status =====`,@cOldResult AS `=== Expected ===`,@cCurOutput AS `===== Found Version =====`;
                END IF;
            END IF;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Execute the procedure
CALL update_mangos();

-- Drop the procedure
DROP PROCEDURE IF EXISTS `update_mangos`;

