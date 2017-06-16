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
    SET @cOldStructure = '06'; 
    SET @cOldContent = '060';

    -- New Values
    SET @cNewVersion = '21';
    SET @cNewStructure = '06';
    SET @cNewContent = '061';
                            -- DESCRIPTION IS 30 Characters MAX    
    SET @cNewDescription = 'Arcane_Guardian';

                        -- COMMENT is 150 Characters MAX
    SET @cNewComment = 'Arcane_Guardian';

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

    -- Silvermoon City
	-- Arcane Guardian
	UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid IN (64056,64059,64060);
	DELETE FROM creature_movement WHERE id IN (64056,64059,64060);
	INSERT INTO creature_movement (id, point, position_x, position_y, position_z, waittime, script_id, orientation, model1, model2) VALUES
	-- #1
	(64056,1,9672.76,-7494.03,15.7596,0,0,4.72967,0,0),(64056,2,9670.61,-7519.96,15.7355,0,0,5.33992,0,0),(64056,3,9683.12,-7517.05,15.7355,0,0,6.00453,0,0),
	(64056,4,9695.07,-7521.45,15.7355,0,0,0.293895,0,0),(64056,5,9694.27,-7491.86,15.8131,0,0,0.879802,0,0),(64056,6,9719.45,-7481.92,13.561,0,0,0.0512015,0,0),
	(64056,7,9764.07,-7494.9,13.5244,0,0,0.0370635,0,0),(64056,8,9774.78,-7495.4,13.5485,0,0,5.02749,0,0),(64056,9,9777.26,-7508.34,13.5485,0,0,0.136807,0,0),
	(64056,10,9800.95,-7507.69,13.5485,0,0,1.42093,0,0),(64056,11,9802.55,-7487.94,13.5485,0,0,1.55445,0,0),(64056,12,9800.7,-7468.54,13.5485,0,0,3.08912,0,0),
	(64056,13,9778.3,-7468.61,13.5485,0,0,4.4133,0,0),(64056,14,9774.68,-7480.5,13.5485,0,0,3.25876,0,0),(64056,15,9747.55,-7479.94,13.5705,0,0,2.33356,0,0),
	(64056,16,9727.59,-7446.16,13.5727,0,0,3.04043,0,0),(64056,17,9718.75,-7445.93,13.5856,0,0,3.69231,0,0),(64056,18,9690.75,-7459.64,13.5864,0,0,4.19183,0,0),
	-- #2
	(64059,1,9850.77,-7451.69,13.6249,0,0,4.72528,0,0),(64059,2,9850.73,-7421.69,13.3197,0,0,2.61099,0,0),(64059,3,9805.08,-7419.36,13.3061,0,0,3.16626,0,0),
	(64059,4,9850.1,-7420.27,13.3164,0,0,4.89807,0,0),(64059,5,9850.76,-7452.14,13.6299,0,0,4.71351,0,0),(64059,6,9850.92,-7421.78,13.3187,0,0,0.43544,0,0),
	(64059,7,9879.56,-7418.61,13.2654,0,0,0.604301,0,0),(64059,8,9885.8,-7412.97,13.2654,0,0,1.13523,0,0),(64059,9,9888.1,-7388.53,13.5648,0,0,1.4596,0,0),
	(64059,10,9890.7,-7369.25,20.7165,0,0,1.43491,0,0),(64059,11,9892.62,-7350.45,20.6464,0,0,1.45847,0,0),(64059,12,9893.37,-7338.24,22.3974,0,0,1.76792,0,0),
	(64059,13,9888.71,-7326.05,23.7671,0,0,2.34205,0,0),(64059,14,9872.74,-7319.35,26.2829,0,0,3.10781,0,0),(64059,15,9854.49,-7320.4,26.2821,0,0,2.00354,0,0),
	(64059,16,9840.42,-7284.02,26.2259,0,0,1.37836,0,0),(64059,17,9842.54,-7274.31,26.133,0,0,1.1506,0,0),(64059,18,9860.73,-7245.4,26.7839,0,0,0.823874,0,0),
	(64059,19,9870.92,-7232.72,28.0373,0,0,0.505002,0,0),(64059,20,9875.86,-7232.71,28.0373,0,0,5.75225,0,0),(64059,21,9881.25,-7236.75,31.0445,0,0,5.87713,0,0),
	(64059,22,9886.03,-7237.04,31.0209,0,0,0.25446,0,0),(64059,23,9909.42,-7214.81,30.8594,0,0,0.559195,0,0),(64059,24,9927.99,-7207.16,30.8627,0,0,0.256816,0,0),
	(64059,25,9965.58,-7196.18,30.8758,0,0,0.284305,0,0),(64059,26,10000.7,-7184.92,30.8758,0,0,0.288232,0,0),(64059,27,9965.65,-7196.19,30.8758,0,0,3.46124,0,0),
	(64059,28,9928.25,-7207.11,30.8656,0,0,3.43768,0,0),(64059,29,9910.4,-7214.29,30.8547,0,0,3.87201,0,0),(64059,30,9886.04,-7238.09,31.0198,0,0,3.7385,0,0),
	(64059,31,9881.2,-7237.23,31.0481,0,0,2.474,0,0),(64059,32,9875.44,-7232.2,28.0375,0,0,2.77481,0,0),(64059,33,9871.49,-7231.91,28.0375,0,0,3.7275,0,0),
	(64059,34,9858.03,-7249.06,26.7771,0,0,4.26393,0,0),(64059,35,9842.69,-7274.95,26.1301,0,0,4.39509,0,0),(64059,36,9840.72,-7285.18,26.2211,0,0,4.87575,0,0),
	(64059,37,9854.58,-7320.47,26.2816,0,0,5.59517,0,0),(64059,38,9877.46,-7320.4,25.71,0,0,5.90069,0,0),(64059,39,9891.5,-7329.49,22.8815,0,0,5.35955,0,0),
	(64059,40,9894.34,-7343.66,22.3979,0,0,4.72888,0,0),(64059,41,9893.21,-7351.31,20.6479,0,0,4.62285,0,0),(64059,42,9890.91,-7369.46,20.7144,0,0,4.5718,0,0),
	(64059,43,9888.19,-7388.55,13.5651,0,0,4.60715,0,0),(64059,44,9885.37,-7412.69,13.2651,0,0,3.98034,0,0),(64059,45,9879.32,-7418.23,13.2651,0,0,3.60727,0,0),
	(64059,46,9850.15,-7420.8,13.3167,0,0,4.13742,0,0),
	-- #3
	(64060,1,9660.13,-7158.27,14.3233,0,0,0.270114,0,0),(64060,2,9667.71,-7153.79,14.3233,0,0,0.867017,0,0),(64060,3,9672.93,-7146.66,14.3237,0,0,1.28956,0,0),
	(64060,4,9672.93,-7136.62,14.3238,0,0,0.100468,0,0),(64060,5,9702.89,-7129.69,13.9218,0,0,0.960062,0,0),(64060,6,9702.85,-7123.77,13.9204,0,0,1.84599,0,0),
	(64060,7,9694.97,-7101.03,13.9209,0,0,1.7863,0,0),(64060,8,9685.25,-7089.14,14.3246,0,0,2.81807,0,0),(64060,9,9649.26,-7084.89,14.3159,0,0,3.20999,0,0),
	(64060,10,9611.6,-7104.24,14.4294,0,0,3.62625,0,0),(64060,11,9597.42,-7108.99,14.4461,0,0,3.25397,0,0),(64060,12,9543.35,-7110.42,14.3429,0,0,3.31287,0,0),
	(64060,13,9531.5,-7116.31,14.2175,0,0,3.72914,0,0),(64060,14,9523.96,-7128.79,14.1171,0,0,4.46976,0,0),(64060,15,9526.91,-7165.06,14.139,0,0,5.16091,0,0),
	(64060,16,9537.07,-7171.87,14.1139,0,0,6.05312,0,0),(64060,17,9576.68,-7173.84,14.2325,0,0,6.22983,0,0),(64060,18,9621.82,-7177.9,14.3065,0,0,6.14736,0,0),
	(64060,19,9672.7,-7185.15,14.322,0,0,0.533337,0,0),(64060,20,9696.98,-7166.98,13.9231,0,0,0.710052,0,0),(64060,21,9704.29,-7137.89,13.9225,0,0,3.09611,0,0),
	(64060,22,9674.72,-7136.34,14.3243,0,0,2.16462,0,0),(64060,23,9672.34,-7124.26,14.3244,0,0,1.8756,0,0),(64060,24,9666.38,-7115.44,14.3244,0,0,2.42459,0,0),
	(64060,25,9654.07,-7111.3,14.323,0,0,3.03485,0,0),(64060,26,9637.09,-7111.58,14.323,0,0,3.36707,0,0),(64060,27,9628.53,-7117.47,14.3232,0,0,4.0967,0,0),
	(64060,28,9623.45,-7129.11,14.3235,0,0,4.47324,0,0),(64060,29,9623.23,-7142.6,14.3236,0,0,4.95861,0,0),(64060,30,9627.91,-7154.79,14.3237,0,0,5.52162,0,0),
	(64060,31,9636.41,-7159.43,14.3237,0,0,6.0282,0,0),(64060,32,9648.92,-7160.64,14.3237,0,0,6.27952,0,0);

	-- Arcane Guardian
	Delete from `creature_ai_scripts` where `id`= 1810302;
	Insert into `creature_ai_scripts` values 
	('1810302','18103','1','0','75','33','5000','10000','90000','100000','1','-12003','-12004','-12005','1','-12006','-12007','-12008','0','0','0','0','Arcane Guardian - Random say on OOC');
	-- texts
	DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-12003','-12004','-12005','-12006','-12007','-12008');
	INSERT into `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
	('-12003','Obey the laws of Silvermoon. Failure to do so will result in termination.','0','0','0','18103','0'),
	('-12004','Do not disturb the serenity of the city. Peace must be upheld.','0','0','0','18103','0'),
	('-12005','Remain strong. Kael\'thas will - error - Lor\'themar will lead you to power and glory!','0','0','0','18103','0'),
	('-12006','Maintain order within these walls.','0','0','0','18103','0'),
	('-12007','Happiness is mandatory, citizen.','0','0','0','18103','0'),
	('-12008','Do not be disheartened. Silvermoon will remain strong through this course of events.','0','0','0','18103','0');
    

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

