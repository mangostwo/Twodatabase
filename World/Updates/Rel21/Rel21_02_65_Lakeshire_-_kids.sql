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
    SET @cOldContent = '64';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '02';
    SET @cNewContent = '65';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Lakeshire_-_kids';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Lakeshire_-_kids';

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
-- UDB Update [182] Lakeshire - kids
-- Lakeshire
-- Erin
UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE guid = 6156;
DELETE FROM creature_movement WHERE id = 6156;
UPDATE creature_template SET MovementType = 2 WHERE entry = 850;
DELETE FROM creature_movement_template WHERE entry = 850;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(850,1,-9174.33,-2109.71,88.95,20000,85001,5.89073,0,0),(850,2,-9192.52,-2098.69,87.7837,0,0,2.69796,0,0),(850,3,-9208.23,-2090.51,85.3921,0,0,2.93672,0,0),
(850,4,-9220.96,-2089.61,81.1544,0,0,2.99563,0,0),(850,5,-9234.93,-2085.46,76.4945,0,0,3.5242,0,0),(850,6,-9242.56,-2096.16,73.6174,0,0,4.4274,0,0),
(850,7,-9249.78,-2122.28,65.0417,0,0,4.23341,0,0),(850,8,-9256.07,-2139.82,64.0223,0,0,4.75962,0,0),(850,9,-9254.31,-2147.89,64.0695,0,0,5.67539,0,0),
(850,10,-9238.9,-2148.92,64.3411,0,0,5.73586,0,0),(850,11,-9237.57,-2152.63,64.3492,0,0,4.67165,0,0),(850,12,-9218.89,-2155.42,64.3544,0,0,0.401173,0,0),
(850,13,-9216.46,-2151.99,64.3544,1000,85002,1.36486,0,0),(850,14,-9216.22,-2147.52,64.3544,0,0,1.57299,0,0),(850,15,-9216.22,-2147.52,64.3544,60000,85001,4.75856,0,0),
(850,16,-9218.43,-2154.78,64.3544,0,0,3.38647,0,0),(850,17,-9231.99,-2155.23,64.3576,0,0,3.21212,0,0),(850,18,-9237.01,-2157.84,64.3576,0,0,2.06465,0,0),
(850,19,-9237.87,-2149.49,64.3426,0,0,2.80273,0,0),(850,20,-9248.67,-2148.45,63.9334,0,0,2.40164,0,0),(850,21,-9256.32,-2138.6,63.8953,0,0,1.32093,0,0),
(850,22,-9251.08,-2121.47,65.2993,0,0,1.57654,0,0),(850,23,-9253.26,-2112.42,66.5815,0,0,2.24648,0,0),(850,24,-9261.04,-2106.96,66.8522,15000,85002,2.66117,0,0),
(850,25,-9251.76,-2113.45,66.6836,0,0,5.22157,0,0),(850,26,-9246.46,-2127.76,64.1511,0,0,4.62939,0,0),(850,27,-9248.61,-2135.95,63.9343,0,0,4.37257,0,0),
(850,28,-9254.32,-2148.24,64.056,0,0,4.10161,0,0),(850,29,-9271.21,-2158.97,61.1872,0,0,3.23767,0,0),(850,30,-9277.96,-2157.76,59.2388,0,0,2.87639,0,0),
(850,31,-9310.03,-2148.39,63.4841,60000,85001,2.82141,0,0),(850,32,-9300.57,-2151.61,63.3088,0,0,5.96445,0,0),(850,33,-9278.2,-2158.05,59.202,0,0,0.11559,0,0),
(850,34,-9261.5,-2157.36,64.0706,0,0,0.584478,0,0),(850,35,-9252.47,-2139.73,64.0216,0,0,1.20494,0,0),(850,36,-9244.6,-2120.1,65.1008,0,0,1.41229,0,0),
(850,37,-9242.08,-2095.47,73.8924,0,0,0.926126,0,0),(850,38,-9233.67,-2085.3,76.8089,0,0,6.22599,0,0),(850,39,-9219.75,-2090.06,81.5803,0,0,6.26762,0,0),
(850,40,-9207.11,-2090.25,85.8603,0,0,6.01079,0,0),(850,41,-9198.75,-2092.32,87.6703,0,0,5.73827,0,0),(850,42,-9174.33,-2109.71,88.95,25000,0,5.89073,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id IN (85001,85002); 
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(85001,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON'),
(85002,1,25,0,0,0,0,0,0,0,0,0,0,0,0,0,'RUN OFF');

-- Madison
UPDATE creature_model_info SET modelid_other_gender = 0 WHERE modelid = 257;  -- should't use male model 
UPDATE creature SET position_x = -9327.604, position_y = -2202.139, position_z = 61.898, orientation = 2.485968, spawndist = 0, MovementType = 2 WHERE guid = 6150;
DELETE FROM creature_movement WHERE id = 6150;
UPDATE creature_template SET MovementType = 2 WHERE entry = 848;
DELETE FROM creature_movement_template WHERE entry = 848;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(848,1,-9327.604,-2202.139,61.898,30000,84801,2.485968,0,0),(848,2,-9315.13,-2208.34,61.8977,0,0,6.15947,0,0),(848,3,-9293.39,-2209.66,61.821,0,0,0.401712,0,0),
(848,4,-9287.74,-2206.22,62.7899,0,0,1.06066,0,0),(848,5,-9281.29,-2171.65,59.6998,0,0,1.24138,0,0),(848,6,-9267.21,-2137.46,62.1799,0,0,1.15106,0,0),
(848,7,-9262.62,-2131.42,65.3403,0,0,0.903661,0,0),(848,8,-9248.75,-2116.83,66.1153,0,0,1.05681,0,0),(848,9,-9245.36,-2104.48,70.2651,0,0,1.35526,0,0),
(848,10,-9243.86,-2085.17,75.3524,0,0,1.35526,0,0),(848,11,-9239.41,-2057.41,76.8398,0,0,1.72205,0,0),(848,12,-9248.06,-2044.15,77.0034,0,0,1.84378,0,0),
(848,13,-9248.36,-2023.24,77.0013,60000,84801,1.58853,0,0),(848,14,-9248.64,-2045.46,77.0022,0,0,4.91676,0,0),(848,15,-9239.96,-2068.09,75.8833,0,0,4.69999,0,0),
(848,16,-9240.93,-2088.38,75.2944,0,0,4.6725,0,0),(848,17,-9245.53,-2099.99,71.8304,0,0,4.55862,0,0),(848,18,-9247.71,-2120.82,65.1585,0,0,4.58611,0,0),
(848,19,-9254.52,-2145.7,64.0393,0,0,4.56255,0,0),(848,20,-9255.4,-2185.46,64.0101,0,0,3.76379,0,0),(848,21,-9270.92,-2193.77,64.0897,0,0,4.53035,0,0),
(848,22,-9276.26,-2211.56,64.0588,0,0,4.10466,0,0),(848,23,-9293.97,-2213.25,61.6685,0,0,3.07815,0,0),(848,24,-9316.85,-2209.62,61.8983,0,0,2.81976,0,0),
(848,25,-9327.604,-2202.139,61.898,120000,84801,2.485968,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 84801; 
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(84801,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');

-- Rachel & Nathan
UPDATE creature SET position_x = -9262.288086, position_y = -2204.600342, position_z = 63.933990, orientation = 3.567484, spawndist = 0, MovementType = 2 WHERE guid = 6154;
UPDATE creature SET position_x = -9262.288086, position_y = -2204.600342, position_z = 63.933990, orientation = 3.567484, spawndist = 0, MovementType = 0 WHERE guid = 6155;
DELETE FROM creature_movement WHERE id IN (6154,6155);
UPDATE creature_template SET MovementType = 2 WHERE entry = 849;
DELETE FROM creature_movement_template WHERE entry = 849;
INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
(849,1,-9262.288086,-2204.600342,63.933990,2000,84901,3.567484,0,0),(849,2,-9282.55,-2212.77,63.4702,0,0,3.37348,0,0),(849,3,-9316.21,-2213.16,61.8981,0,0,3.07503,0,0),
(849,4,-9342.98,-2208.78,61.8981,0,0,2.00139,0,0),(849,5,-9344.81,-2183.14,61.8981,0,0,0.826432,0,0),(849,6,-9333.46,-2184.53,61.8981,0,0,4.18637,0,0),
(849,7,-9342.04,-2206.52,61.8981,0,0,5.47914,0,0),(849,8,-9326.1,-2210.98,61.8981,0,0,6.27006,0,0),(849,9,-9293.37,-2209.15,61.8213,0,0,0.311687,0,0),
(849,10,-9286.83,-2203.5,62.899,0,0,1.07195,0,0),(849,11,-9280.69,-2175.14,60.2934,0,0,1.17013,0,0),(849,12,-9270.13,-2152.55,61.1369,0,0,1.28794,0,0),
(849,13,-9264.35,-2133.3,64.3245,0,0,0.769574,0,0),(849,14,-9249.2,-2126.65,64.3418,0,0,0.193481,0,0),(849,15,-9209.35,-2136.65,63.9347,0,0,6.19989,0,0),
(849,16,-9190.63,-2136.43,63.942,0,0,5.98547,0,0),(849,17,-9184.8,-2144.66,63.9756,0,0,5.00216,0,0),(849,18,-9178.52,-2182.85,64.0438,0,0,4.63302,0,0),
(849,19,-9192.09,-2199.42,63.9338,0,0,1.98231,0,0),(849,20,-9198.02,-2179.83,63.9338,0,0,2.40328,0,0),(849,21,-9207.62,-2174.96,63.9338,0,0,3.09365,0,0),
(849,22,-9239.17,-2175.39,63.9338,0,0,3.65965,0,0),(849,23,-9247.98,-2186.89,64.0099,0,0,3.71473,0,0),(849,24,-9262.78,-2190.39,64.0897,0,0,4.22838,0,0);
DELETE FROM dbscripts_on_creature_movement WHERE id = 84901; 
INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
(84901,1,25,1,0,0,0,0,0,0,0,0,0,0,0,0,'RUN ON');
-- link
DELETE FROM creature_linking WHERE guid = 6155;
INSERT INTO creature_linking (guid, master_guid, flag) VALUES
(6155, 6154, 512);    

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

