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
    SET @cOldContent = '50';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '02';
    SET @cNewContent = '51';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Conjurer_Tyren';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Conjurer_Tyren';

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

-- UDB UPDATE
-- Silvermoon City
 -- Conjurer Tyren
 UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE guid = 66689;
 DELETE FROM creature_movement WHERE id = 66689;
 UPDATE creature_template SET MovementType = 2 WHERE entry = 18527;
 DELETE FROM creature_movement_template WHERE entry = 18527;
 INSERT INTO creature_movement_template (entry, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
 (18527,1,9580.41,-7134.3,14.2584,60000,1852702,0.257804,0,0),(18527,2,9583.42,-7125.76,14.3333,0,0,0.987649,0,0),(18527,3,9593.48,-7117.48,14.4257,0,0,0.598876,0,0),
 (18527,4,9621.15,-7108.19,14.3515,0,0,0.520337,0,0),(18527,5,9633.38,-7101.19,14.3394,0,0,0.38996,0,0),(18527,6,9649.11,-7098.48,14.3236,0,0,6.17521,0,0),
 (18527,7,9662.67,-7104.99,14.3236,0,0,5.17776,0,0),(18527,8,9664.43,-7114.67,14.3236,0,0,5.01283,0,0),(18527,9,9666.04,-7119.05,14.3238,0,0,5.54454,0,0),
 (18527,10,9668.66,-7120.97,14.3238,0,0,0.0318226,0,0),(18527,11,9673.02,-7120.11,14.3238,120000,1852701,0.322415,0,0),(18527,12,9682.49,-7114.24,14.3238,0,0,0.307494,0,0),
 (18527,13,9698.77,-7136.72,14.3238,0,0,5.22095,0,0),(18527,14,9703.34,-7159.53,13.9189,0,0,4.75364,0,0),(18527,15,9701.66,-7171.66,13.914,0,0,4.05072,0,0),
 (18527,16,9690.17,-7182.02,13.9148,0,0,3.96825,0,0),(18527,17,9679.18,-7196.85,13.9249,0,0,4.50624,0,0),(18527,18,9677.73,-7212.29,14.2828,0,0,4.48503,0,0),
 (18527,19,9674.62,-7215.65,14.3048,0,0,3.29437,0,0),(18527,20,9661.6,-7216.8,14.3048,0,0,3.31714,0,0),(18527,21,9657.64,-7218.86,14.955,0,0,3.82294,0,0),
 (18527,22,9655.39,-7221.8,15.626,0,0,4.43398,0,0),(18527,23,9655.54,-7228.13,15.2962,0,0,5.20838,0,0),(18527,24,9659.96,-7230.66,14.6318,0,0,6.19562,0,0),
 (18527,25,9689.36,-7244.11,14.2467,0,0,5.6241,0,0),(18527,26,9689.94,-7245.97,14.24,0,0,4.17583,0,0),(18527,27,9687.48,-7247.91,14.2777,120000,1852701,3.55458,0,0),
 (18527,28,9689.88,-7256.7,14.2531,0,0,4.77274,0,0),(18527,29,9689.91,-7266.39,14.2663,0,0,4.47664,0,0),(18527,30,9683.25,-7276.06,14.0879,0,0,3.73837,0,0),
 (18527,31,9672.17,-7282.72,14.0434,0,0,3.46898,0,0),(18527,32,9644.85,-7282.99,14.0105,0,0,3.13833,0,0),(18527,33,9611.25,-7282.73,14.0113,0,0,3.1344,0,0),
 (18527,34,9579.56,-7282.32,14.0097,0,0,3.13048,0,0),(18527,35,9533.29,-7282.07,14.0093,0,0,2.84616,0,0),(18527,36,9519.62,-7274.34,14.0156,0,0,2.5375,0,0),
 (18527,37,9508.5,-7267.72,14.3477,0,0,2.88072,0,0),(18527,38,9502.93,-7267.23,14.3481,120000,1852701,3.31504,0,0),(18527,39,9524.46,-7264.37,14.3174,0,0,6.20688,0,0),
 (18527,40,9547.9,-7264.48,14.24,0,0,0.0163672,0,0),(18527,41,9558.87,-7264.02,14.2302,0,0,0.193867,0,0),(18527,42,9570.43,-7261.72,14.2984,0,0,0.0509247,0,0),
 (18527,43,9584.28,-7262.27,14.2869,0,0,6.20923,0,0),(18527,44,9604.75,-7267.28,13.8682,0,0,0.0383605,0,0),(18527,45,9635.37,-7267.64,13.8697,0,0,6.27599,0,0),
 (18527,46,9646.78,-7267.28,13.8659,0,0,0.392572,0,0),(18527,47,9659.8,-7260.28,14.3018,0,0,0.352516,0,0),(18527,48,9661.345,-7260.638,14.28749,120000,1852701,0.04176108,0,0),    
 (18527,49,9667.56,-7247.18,14.2715,0,0,1.03986,0,0),(18527,50,9674.35,-7237.16,14.0004,0,0,1.38308,0,0),(18527,51,9674.09,-7232.91,14.2099,0,0,2.23445,0,0),
 (18527,52,9671.98,-7231.09,14.2965,0,0,2.7748,0,0),(18527,53,9659.94,-7230.77,14.6336,0,0,2.81015,0,0),(18527,54,9655.9,-7228.54,15.3152,0,0,2.31142,0,0),
 (18527,55,9654.83,-7224.71,15.6262,0,0,1.63205,0,0),(18527,56,9655.7,-7221.33,15.6262,0,0,1.17887,0,0),(18527,57,9658.26,-7218.67,14.9371,0,0,0.548985,0,0),
 (18527,58,9666.17,-7216.67,14.3064,0,0,0.226972,0,0),(18527,59,9674.23,-7215.28,14.305,0,0,0.894561,0,0),(18527,60,9675.75,-7209.25,13.9885,0,0,1.57765,0,0),
 (18527,61,9674,-7203.79,13.9597,0,0,2.3065,0,0),(18527,62,9669.14,-7201.18,14.3206,0,0,2.90333,0,0),(18527,63,9663.58,-7200.2,14.3219,0,0,2.12028,0,0),
 (18527,64,9664.278,-7198.672,14.31875,120000,1852701,1.8441,0,0),(18527,65,9637.54,-7186.25,14.3225,0,0,2.79494,0,0),(18527,66,9629.4,-7183.8,14.3145,0,0,2.89154,0,0),
 (18527,67,9611.11,-7181.33,14.2864,0,0,2.69441,0,0),(18527,68,9589.64,-7155.37,14.2629,0,0,2.09829,0,0),(18527,69,9577.91,-7136.72,14.2473,0,0,1.74408,0,0),
 (18527,70,9578.67,-7134.63,14.2487,0,0,0.57776,0,0),(18527,71,9580.41,-7134.3,14.2584,60000,1852702,0.257804,0,0);
 DELETE FROM dbscripts_on_creature_movement WHERE id IN (1852701,1852702); 
 INSERT INTO dbscripts_on_creature_movement (id, delay, command, datalong, datalong2, buddy_entry, search_radius, data_flags, dataint, dataint2, dataint3, dataint4, x, y, z, o, comments) VALUES
 (1852701,10,15,11542,0,0,0,0,11544,11540,0,0,0,0,0,0,''),
 (1852701,55,15,11544,0,0,0,0,11540,11542,0,0,0,0,0,0,''),
 (1852701,88,15,11540,0,0,0,0,11542,11544,0,0,0,0,0,0,''),
 (1852702,6,15,11542,0,0,0,0,11544,11540,0,0,0,0,0,0,''),
 (1852702,35,15,11544,0,0,0,0,11540,11542,0,0,0,0,0,0,'');
 
-- for 161 http://paste2.org/fBXEDfX0
-- Conjurer Tyren
-- In addition to the Fireworks and Evocation, he will occasionally fire out a single pulse of Hellfire. (Fireworks are done by scripts)
Delete from `creature_ai_scripts` where `creature_id`= 18527;
Insert into `creature_ai_scripts` values
('1852701','18527','1','0','25','1','30000','60000','180000','240000','11','1949','0','0','0','0','0','0','0','0','0','0','Conjurer Tyren - Cast Hellfire while OOC'),
('1852702','18527','1','0','100','1','90000','120000','420000','480000','11','12051','0','1','0','0','0','0','0','0','0','0','Conjurer Tyren - Cast Evocation while OOC');
UPDATE creature_template SET AIName='EventAI' WHERE `entry` = '18527';
    

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

