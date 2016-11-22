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
    SET @cOldStructure = '02'; 
    SET @cOldContent = '76';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '02';
    SET @cNewContent = '77';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Zixil_Merchant_Supreme';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Added waypoints for Zixil_Merchant_Supreme and linked minion';

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
-- Credit Trinitycore / UDB [205] Zixil <Merchant Supreme>
-- Zixil <Merchant Supreme>
UPDATE creature SET position_x = -36.31, position_y = -916.366, position_z = 55.075, orientation = 1.062, Spawndist = 0, MovementType = 2 WHERE guid = 15424;
UPDATE creature SET position_x = -37.248, position_y = -914.605, position_z = 55.343, orientation = 0.826, Spawndist = 0, MovementType = 0 WHERE guid = 15423;
DELETE FROM creature_movement WHERE id = 15424;
UPDATE creature_template SET MovementType = 2 WHERE entry = 3537;
DELETE FROM creature_movement_template WHERE entry = 3537;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(3537, 1, -36.31, -916.366, 55.075, 180000, 0, 1.062, 0, 0), 
(3537, 2, -28.532600, -902.440735, 55.908634, 0, 0, 0, 0, 0),
(3537, 3, -26.338741, -896.902466, 56.039452, 0, 0, 0, 0, 0),
(3537, 4, -51.500923, -836.734619, 56.524872, 0, 0, 0, 0, 0),
(3537, 5, -17.165236, -802.633240, 58.751846, 0, 0, 0, 0, 0),
(3537, 6, -20.983173, -719.063965, 69.290993, 0, 0, 0, 0, 0),
(3537, 7, -149.228104, -712.801025, 64.445107, 0, 0, 0, 0, 0),
(3537, 8, -226.017303, -722.711487, 60.861263, 0, 0, 0, 0, 0),
(3537, 9, -325.539337, -754.267334, 54.089657, 0, 0, 0, 0, 0),
(3537, 10, -377.870178, -776.472351, 54.472977, 0, 0, 0, 0, 0),
(3537, 11, -403.164459, -680.892700, 54.499004, 0, 0, 0, 0, 0),
(3537, 12, -331.617737, -671.147278, 54.918808, 0, 0, 0, 0, 0),
(3537, 13, -341.247772, -713.172363, 57.733025, 0, 0, 0, 0, 0),
(3537, 14, -340.614716, -711.776184, 57.733025, 120000, 0, 0, 0, 0),
(3537, 15, -325.247681, -677.673950, 54.596302, 0, 0, 0, 0, 0), 
(3537, 16, -339.869904, -673.187561, 55.012871, 0, 0, 0, 0, 0),
(3537, 17, -385.749298, -685.196350, 54.387272, 0, 0, 0, 0, 0),
(3537, 18, -413.708405, -656.887817, 54.488979, 0, 0, 0, 0, 0),
(3537, 19, -440.757660, -585.658386, 53.424225, 0, 0, 0, 0, 0),
(3537, 20, -520.923462, -558.851501, 39.920975, 0, 0, 0, 0, 0),
(3537, 21, -569.159912, -567.547302, 32.809437, 0, 0, 0, 0, 0),
(3537, 22, -594.511536, -575.940979, 31.982075, 0, 0, 0, 0, 0),
(3537, 23, -650.699402, -560.431763, 26.120964, 0, 0, 0, 0, 0),
(3537, 24, -691.624939, -568.642334, 24.540937, 0, 0, 0, 0, 0),
(3537, 25, -707.109802, -562.611023, 22.809536, 0, 0, 0, 0, 0),
(3537, 26, -724.787048, -549.384033, 20.291832, 0, 0, 0, 0, 0),
(3537, 27, -811.109985, -542.174927, 15.771987, 0, 0, 0, 0, 0),
(3537, 28, -817.549683, -533.020020, 15.160646, 180000, 0, 0, 0, 0),
(3537, 29, -811.109985, -542.174927, 15.771987, 0, 0, 0, 0, 0),
(3537, 30, -724.787048, -549.384033, 20.291832, 0, 0, 0, 0, 0),
(3537, 31, -707.109802, -562.611023, 22.809536, 0, 0, 0, 0, 0),
(3537, 32, -691.624939, -568.642334, 24.540937, 0, 0, 0, 0, 0),
(3537, 33, -650.699402, -560.431763, 26.120964, 0, 0, 0, 0, 0),
(3537, 34, -594.511536, -575.940979, 31.982075, 0, 0, 0, 0, 0),
(3537, 35, -569.159912, -567.547302, 32.809437, 0, 0, 0, 0, 0),
(3537, 36, -520.923462, -558.851501, 39.920975, 0, 0, 0, 0, 0),
(3537, 37, -440.757660, -585.658386, 53.424225, 0, 0, 0, 0, 0),
(3537, 38, -413.708405, -656.887817, 54.488979, 0, 0, 0, 0, 0),
(3537, 39, -385.749298, -685.196350, 54.387272, 0, 0, 0, 0, 0),
(3537, 40, -339.869904, -673.187561, 55.012871, 0, 0, 0, 0, 0),
(3537, 41, -325.247681, -677.673950, 54.596302, 0, 0, 0, 0, 0), 
(3537, 42, -340.614716, -711.776184, 57.733025, 120000, 0, 0, 0, 0),
(3537, 43, -341.247772, -713.172363, 57.733025, 0, 0, 0, 0, 0),
(3537, 44, -331.617737, -671.147278, 54.918808, 0, 0, 0, 0, 0),
(3537, 45, -403.164459, -680.892700, 54.499004, 0, 0, 0, 0, 0),
(3537, 46, -377.870178, -776.472351, 54.472977, 0, 0, 0, 0, 0),
(3537, 47, -325.539337, -754.267334, 54.089657, 0, 0, 0, 0, 0),
(3537, 48, -226.017303, -722.711487, 60.861263, 0, 0, 0, 0, 0),
(3537, 49, -149.228104, -712.801025, 64.445107, 0, 0, 0, 0, 0),
(3537, 50, -20.983173, -719.063965, 69.290993, 0, 0, 0, 0, 0),
(3537, 51, -17.165236, -802.633240, 58.751846, 0, 0, 0, 0, 0),
(3537, 52, -51.500923, -836.734619, 56.524872, 0, 0, 0, 0, 0),
(3537, 53, -26.338741, -896.902466, 56.039452, 0, 0, 0, 0, 0),
(3537, 54, -28.532600, -902.440735, 55.908634, 0, 0, 0, 0, 0),
(3537, 55, -38.973717, -917.010193, 55.065174, 0, 0, 1.062, 0, 0);
-- link
DELETE FROM creature_linking WHERE guid = 15423;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(15423, 15424, 128+512);
    

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

