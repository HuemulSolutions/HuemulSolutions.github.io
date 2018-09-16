

CREATE TABLE IF NOT EXISTS control_Executors (
                                              application_Id         VARCHAR(100)
                                             ,IdSparkPort            VARCHAR(50)
                                             ,IdPortMonitoring       VARCHAR(500)
                                             ,Executor_dtStart       TimeStamp
                                             ,Executor_Name          VARCHAR(100)
                                             ,PRIMARY KEY (application_Id)
                                            );

CREATE TABLE IF NOT EXISTS control_Singleton (
                                              Singleton_Id         VARCHAR(100)
                                             ,application_Id       VARCHAR(100)
                                             ,Singleton_Name       VARCHAR(100)
                                             ,MDM_fhCreate         TimeStamp
                                             ,PRIMARY KEY (Singleton_Id)
                                            );
        
CREATE TABLE IF NOT EXISTS control_Area (
                                              Area_Id              VARCHAR(50)
											 ,Area_IdPadre		   VARCHAR(50)
                                             ,Area_name            VARCHAR(100)
                                             ,MDM_fhCreate         TimeStamp
                                             ,MDM_ProcessName      VARCHAR(200)
                                             ,PRIMARY KEY (Area_Id)
                                            );
                             
CREATE TABLE IF NOT EXISTS control_Process ( 
                                              process_id           VARCHAR(200)
                                             ,Area_Id              VARCHAR(50)
                                             ,process_name         VARCHAR(200)
                                             ,process_FileName     VARCHAR(200)
                                             ,process_Description  VARCHAR(1000)
                                             ,process_Owner        VARCHAR(200)
											 ,process_frequency    VARCHAR(50) default 'NONE'
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate         TimeStamp
                                             ,MDM_ProcessName      VARCHAR(200)
                                             ,PRIMARY KEY (process_id)
                                            );
                             
CREATE TABLE IF NOT EXISTS control_ProcessExec ( 
                                              processExec_id          VARCHAR(50)
                                             ,processExec_idParent    VARCHAR(50)
                                             ,process_id              VARCHAR(200)
                                             ,Malla_id                VARCHAR(50)
                                             ,application_Id          VARCHAR(100)
                                             ,processExec_IsStart     boolean
                                             ,processExec_IsCancelled boolean
                                             ,processExec_IsEndError  boolean
                                             ,processExec_IsEndOK     boolean
                                             ,processExec_dtStart     timeStamp
                                             ,processExec_dtEnd       TimeStamp
                                             ,processExec_Durhour     int
                                             ,processExec_DurMin      int
                                             ,processExec_DurSec      int
                                             ,processExec_WhosRun     VARCHAR(200)
                                             ,processExec_DebugMode   boolean
                                             ,processExec_Environment VARCHAR(200)
											 ,processExec_param_year	INT default 0
											 ,processExec_param_month	INT default 0
											 ,processExec_param_day		INT default 0
											 ,processExec_param_hour	INT default 0
											 ,processExec_param_min		INT default 0
											 ,processExec_param_sec		INT default 0
											 ,processExec_param_others	VARCHAR(1000) default ''
                                             ,Error_Id                VARCHAR(50)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (processExec_id) 
                                            );
                             
CREATE TABLE IF NOT EXISTS control_ProcessExecParams ( 
                                              processExec_id          VARCHAR(50)
                                             ,processExecParams_Name  VARCHAR(1000)
                                             ,processExecParams_Value VARCHAR(8000)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (processExec_id, processExecParams_Name) 
                                            );
                   
CREATE TABLE IF NOT EXISTS control_ProcessExecStep ( 
                                              processExecStep_id      VARCHAR(50)
                                             ,processExec_id          VARCHAR(50)
                                             ,processExecStep_Name        VARCHAR(200)
                                             ,processExecStep_Status      VARCHAR(20)  --running, error, ok
                                             ,processExecStep_dtStart     timeStamp
                                             ,processExecStep_dtEnd       TimeStamp
                                             ,processExecStep_Durhour     int
                                             ,processExecStep_DurMin      int
                                             ,processExecStep_DurSec      int
                                             ,Error_Id                VARCHAR(50)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (processExecStep_id) 
                                            );
                    
CREATE TABLE IF NOT EXISTS control_RAWFiles ( 
                                              RAWFiles_id             VARCHAR(50)
                                             ,Area_Id                 VARCHAR(50)
                                             ,RAWFiles_LogicalName    VARCHAR(1000)
                                             ,RAWFiles_GroupName      VARCHAR(1000)
                                             ,RAWFiles_Description    VARCHAR(1000)
                                             ,RAWFiles_Owner          VARCHAR(200)
                                             ,RAWFiles_frequency      VARCHAR(200)
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (RAWFiles_id) 
                                            );

create index idx_control_rawFiles_i01 on control_rawFiles (rawfiles_logicalname, rawfiles_groupname);
create unique index idx_control_RAWFiles_i02 on control_RAWFiles (RAWFiles_LogicalName);
                                    
CREATE TABLE IF NOT EXISTS control_RAWFilesDet ( 
                                              RAWFilesDet_id                            VARCHAR(50)
                                             ,RAWFiles_id                               VARCHAR(50)
                                             ,RAWFilesDet_StartDate                     TimeStamp
                                             ,RAWFilesDet_EndDate                       TimeStamp
                                             ,RAWFilesDet_FileName                      VARCHAR(1000)
                                             ,RAWFilesDet_LocalPath                     VARCHAR(1000)
                                             ,RAWFilesDet_GlobalPath                    VARCHAR(1000)
                                             ,RAWFilesDet_Data_ColSeparatorType         VARCHAR(50)
                                             ,RAWFilesDet_Data_ColSeparator             VARCHAR(50)
                                             ,RAWFilesDet_Data_HeaderColumnsString      VARCHAR(8000)
                                             ,RAWFilesDet_Log_ColSeparatorType          VARCHAR(50)
                                             ,RAWFilesDet_Log_ColSeparator              VARCHAR(50)
                                             ,RAWFilesDet_Log_HeaderColumnsString       VARCHAR(8000)
                                             ,RAWFilesDet_Log_NumRowsFieldName          VARCHAR(200)
                                             ,RAWFilesDet_ContactName                   VARCHAR(200)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (RAWFilesDet_id) 
                                            );

create index idx_control_RAWFilesDet_i01 on control_RAWFilesDet (RAWFiles_id, RAWFilesDet_StartDate);
                                                       
CREATE TABLE IF NOT EXISTS control_RAWFilesDetFields ( 
                                              RAWFilesDet_id                  VARCHAR(50)
											 ,RAWFilesDetFields_LogicalName          VARCHAR(200)
                                             ,RAWFilesDetFields_ITName          VARCHAR(200)
                                             ,RAWFilesDetFields_description          VARCHAR(1000)
                                             ,RAWFilesDetFields_DataType            VARCHAR(50)
                                             ,RAWFilesDetFields_Position      INT
                                             ,RAWFilesDetFields_PosIni        INTEGER
                                             ,RAWFilesDetFields_PosFin        INTEGER
                                             ,RAWFilesDetFields_ApplyTrim     BOOLEAN
                                             ,RAWFilesDetFields_ConvertNull   BOOLEAN
											 ,MDM_Active			  BOOLEAN default true
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (RAWFilesDet_id, RAWFilesDetFields_LogicalName) 
                                            );
											
                  
CREATE TABLE IF NOT EXISTS control_RAWFilesUse ( 
                                              RAWFilesUse_id          VARCHAR(50)
                                             ,RAWFiles_id             VARCHAR(50)
                                             ,Process_Id              VARCHAR(200)
                                             ,ProcessExec_Id          VARCHAR(50)
                                             ,RAWFilesUse_Year        INT
                                             ,RAWFilesUse_Month       INT
                                             ,RAWFilesUse_Day         INT
                                             ,RAWFilesUse_Hour        INT
                                             ,RAWFilesUse_Minute       INT
                                             ,RAWFilesUse_Second      INT
                                             ,RAWFilesUse_params      VARCHAR(1000)
                                             ,RAWFiles_fullName       VARCHAR(1000)
                                             ,RAWFiles_fullPath       VARCHAR(1000)
                                             ,RAWFiles_numRows        VARCHAR(50)
                                             ,RAWFiles_HeaderLine     VARCHAR(8000)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (RAWFilesUse_id) 
                                            );
                   
CREATE TABLE IF NOT EXISTS control_Tables ( 
                                              Table_id                VARCHAR(50)
                                             ,Area_Id                 VARCHAR(50)
                                             ,Table_BBDDName          VARCHAR(200)
                                             ,Table_Name              VARCHAR(200)
                                             ,Table_Description       VARCHAR(1000)
                                             ,Table_BusinessOwner     VARCHAR(200)
                                             ,Table_ITOwner           VARCHAR(200)
                                             ,Table_PartitionField    VARCHAR(200)
                                             ,Table_TableType         VARCHAR(50)  --reference, master, transactional
                                             ,Table_StorageType       VARCHAR(50)
                                             ,Table_LocalPath         VARCHAR(1000)
                                             ,Table_GlobalPath        VARCHAR(1000)
                                             ,Table_SQLCreate         VARCHAR(8000)
											 ,Table_Frequency		  VARCHAR(200)
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)                                             
                                             ,PRIMARY KEY (Table_id) 
                                            );

create unique index idx_control_Tables_i01 on control_Tables (Table_BBDDName, Table_Name );
                   
CREATE TABLE IF NOT EXISTS control_TablesRel (                   
                                              TableRel_id               VARCHAR(50)
                                             ,Table_idPK                VARCHAR(50)
                                             ,Table_idFK                VARCHAR(50)
                                             ,TableFK_NameRelationship  VARCHAR(100)
                                             ,TableRel_ValidNull      boolean
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)                                             
                                             ,PRIMARY KEY (TableRel_id) 
                                            );
											
                    
CREATE TABLE IF NOT EXISTS control_TablesRelCol ( 
                                              TableRel_id                VARCHAR(50)
                                             ,Column_idFK                VARCHAR(50)
                                             ,Column_idPK                VARCHAR(50)
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate               TimeStamp
                                             ,MDM_ProcessName            VARCHAR(200)
                                             ,PRIMARY KEY (TableRel_id, Column_idFK) 
                                            );
                                                                       
                    
CREATE TABLE IF NOT EXISTS control_Columns ( 
                                              Column_id                  VARCHAR(50)
                                             ,Table_id                   VARCHAR(50)
                                             ,Column_Position            int
                                             ,Column_Name                VARCHAR(200)
                                             ,Column_Description         VARCHAR(1000)
                                             ,Column_Formula             VARCHAR(1000)
                                             ,Column_DataType            VARCHAR(50)
                                             ,Column_SensibleData        boolean
                                             ,Column_EnableDTLog         boolean
                                             ,Column_EnableOldValue      boolean
                                             ,Column_EnableProcessLog    boolean
                                             ,Column_DefaultValue        VARCHAR(1000)
                                             ,Column_SecurityLevel       VARCHAR(200)
                                             ,Column_Encrypted           VARCHAR(200)
                                             ,Column_ARCO                VARCHAR(200)
                                             ,Column_Nullable            boolean
                                             ,Column_IsPK                boolean
                                             ,Column_IsUnique            boolean
                                             ,Column_DQ_MinLen           int
                                             ,Column_DQ_MaxLen           int 
                                             ,Column_DQ_MinDecimalValue  Decimal(30,10) 
                                             ,Column_DQ_MaxDecimalValue  Decimal(30,10) 
                                             ,Column_DQ_MinDateTimeValue VARCHAR(50) 
                                             ,Column_DQ_MaxDateTimeValue VARCHAR(50)
											 ,Column_DQ_RegExp           varchar(1000)
                                             ,Column_Responsible         VARCHAR(100)
                                             ,MDM_Active                 Boolean default false
                                             ,MDM_ManualChange           Boolean default false
                                             ,MDM_fhCreate               TimeStamp
                                             ,MDM_ProcessName            VARCHAR(200)
                                             ,PRIMARY KEY (Column_id) 
                                            );

create index idx_control_Columns_i01 on control_Columns (Table_Id, Column_Name);
                                                                       
                   
CREATE TABLE IF NOT EXISTS control_TablesUse ( 
                                              Table_id                VARCHAR(50)
                                             ,Process_Id              VARCHAR(200)
                                             ,ProcessExec_Id          VARCHAR(50)
                                             ,ProcessExecStep_Id      VARCHAR(50)
                                             ,TableUse_Year        INT
                                             ,TableUse_Month       INT
                                             ,TableUse_Day         INT
                                             ,TableUse_Hour        INT
                                             ,TableUse_Minute       INT
                                             ,TableUse_Second      INT
                                             ,TableUse_params      VARCHAR(1000)
                                             ,TableUse_Read           boolean
                                             ,TableUse_Write          boolean
                                             ,TableUse_numRowsNew     BIGINT
                                             ,TableUse_numRowsUpdate  BIGINT
											 ,TableUse_numRowsUpdatable  BIGINT
											 ,TableUse_numRowsNoChange  BIGINT
                                             ,TableUse_numRowsMarkDelete  BIGINT
                                             ,TableUse_numRowsTotal   BIGINT
											 ,TableUse_PartitionValue VARCHAR(200)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (Process_Id, Table_id, ProcessExec_Id, ProcessExecStep_Id) 
                                            );
                    
CREATE TABLE IF NOT EXISTS control_DQ (
                                              DQ_Id                   VARCHAR(50) 
                                             ,Table_id                VARCHAR(50) 
                                             ,Process_Id              VARCHAR(200)
                                             ,ProcessExec_Id          VARCHAR(50)
                                             ,Column_Id               VARCHAR(50)
                                             ,Column_Name             VARCHAR(200)
                                             ,Dq_AliasDF              VARCHAR(200)
                                             ,DQ_Name                 VARCHAR(200)
                                             ,DQ_Description          VARCHAR(1000)
                                             ,DQ_QueryLevel           VARCHAR(50)
                                             ,DQ_Notification         VARCHAR(50)
                                             ,DQ_SQLFormula           VARCHAR(8000)
                                             ,DQ_DQ_toleranceError_Rows     BigInt
                                             ,DQ_DQ_toleranceError_Percent     Decimal(30,10)
                                             ,DQ_ResultDQ             VARCHAR(8000)
                                             ,DQ_ErrorCode            Integer
                                             ,DQ_NumRowsOK            BigInt
                                             ,DQ_NumRowsError         BigInt
                                             ,DQ_NumRowsTotal         BigInt
                                             ,DQ_IsError              Boolean
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (DQ_Id) 
                                            );
                    
                   
CREATE TABLE IF NOT EXISTS control_Error ( 
                                              Error_Id          VARCHAR(50)
                                             ,Error_Message                text
                                             ,Error_Code           Integer
                                             ,Error_Trace                text
                                             ,Error_ClassName                text
                                             ,Error_FileName                text
                                             ,Error_LIneNumber                text
                                             ,Error_MethodName                text
                                             ,Error_Detail                text
                                             ,MDM_fhCrea            TimeStamp
                                             ,MDM_ProcessName         varchar(1000)
                                             ,PRIMARY KEY (Error_Id)
                                            );
                                                                       
                  
CREATE TABLE IF NOT EXISTS control_Date ( 
                                      Date_Id		DATE
                                      ,Date_year	INT
                                      ,Date_Month	INT
                                      ,Date_Day	INT
                                      ,Date_DayOfWeek	INT
                                      ,Date_DayName	VARCHAR(20)
                                      ,Date_MonthName	VARCHAR(20)
                                      ,Date_Quarter	INT
                                      ,Date_Week	INT
                                      ,Date_isWeekEnd	BOOLEAN
                                      ,Date_IsWorkDay	BOOLEAN
                                      ,Date_IsBankWorkDay	BOOLEAN
                                      ,Date_NumWorkDay		INT
                                      ,Date_NumWorkDayRev	INT
                                      ,MDM_fhCreate            TimeStamp default current_timestamp
                                      ,MDM_ProcessName         VARCHAR(200) default ''
                                      ,PRIMARY KEY (Date_Id) 
                                      );
                                                                       
                 
CREATE TABLE IF NOT EXISTS control_TestPlan ( 
                                              testPlan_Id             VARCHAR(200)
                                             ,testPlanGroup_Id        VARCHAR(200)
                                             ,processExec_id          VARCHAR(200)
                                             ,process_id              VARCHAR(200)
                                             ,testPlan_name           VARCHAR(200)
                                             ,testPlan_description    VARCHAR(1000)
                                             ,testPlan_resultExpected VARCHAR(1000)  
                                             ,testPlan_resultReal     VARCHAR(1000)
                                             ,testPlan_IsOK           boolean
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (testPlan_Id) 
                                            );
                             

CREATE TABLE IF NOT EXISTS control_TestPlanFeature ( 
                                              Feature_Id              VARCHAR(200)
                                             ,testPlan_Id             VARCHAR(200)
                                             ,MDM_fhCreate            TimeStamp
                                             ,MDM_ProcessName         VARCHAR(200)
                                             ,PRIMARY KEY (Feature_Id, testPlan_Id) 
                                            );
                             


CREATE OR REPLACE FUNCTION control_TestPlan_add (   p_testPlan_Id              VARCHAR(200)
                       , p_testPlanGroup_Id          VARCHAR(200)
                       , p_processExec_id          VARCHAR(200)
                       , p_process_id    VARCHAR(200)
                       , p_testPlan_name    VARCHAR(200)
                       , p_testPlan_description    VARCHAR(1000)
                       , p_testPlan_resultExpected  VARCHAR(1000)
                       , p_testPlan_resultReal    varchar(1000)
                       , p_testPlan_IsOK            boolean    
                       , p_Executor_Name     			VARCHAR(100))  
RETURNS VOID AS
$$
BEGIN
	INSERT INTO control_TestPlan ( testPlan_Id             
                                ,testPlanGroup_Id        
                                ,processExec_id          
                                ,process_id              
                                ,testPlan_name           
                                ,testPlan_description    
                                ,testPlan_resultExpected   
                                ,testPlan_resultReal     
                                ,testPlan_IsOK           
                                ,MDM_fhCreate            
                                ,MDM_ProcessName         
                              )
  SELECT p_testPlan_Id
       , p_testPlanGroup_Id
       , p_processExec_id
       , p_process_id
       , p_testPlan_name
       , p_testPlan_description
       , p_testPlan_resultExpected
       , p_testPlan_resultReal
       , p_testPlan_IsOK
       , current_timestamp
       , p_Executor_Name;
       
	RETURN;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION control_TestPlanFeature_add (   p_Feature_Id              VARCHAR(200)
                       , p_testPlan_Id              VARCHAR(200)
                       , p_Executor_Name     			VARCHAR(100))  
RETURNS VOID AS
$$
BEGIN
	INSERT INTO control_TestPlanFeature ( Feature_Id             
                                ,testPlan_Id                 
                                ,MDM_fhCreate            
                                ,MDM_ProcessName         
                              )
  SELECT p_Feature_Id
       , p_testPlan_Id
       , current_timestamp
       , p_Executor_Name;
       
	RETURN;
END;
$$
LANGUAGE plpgsql;

               
CREATE OR REPLACE FUNCTION control_process_addOrUpd (   p_process_id              VARCHAR(200)
										   , p_area_id                 VARCHAR(50)
										   , p_process_name            VARCHAR(200)
										   , p_process_FileName        VARCHAR(200)
										   , p_process_description     VARCHAR(1000)
										   , p_process_frequency		   VARCHAR(50)
										   , p_process_owner           VARCHAR(200)
										   , p_mdm_processname         VARCHAR(200))  
RETURNS VOID AS
$$
BEGIN
	-- first try to update the key
	UPDATE control_process 
  SET area_id = CASE WHEN MDM_ManualChange THEN area_id ELSE p_area_id END
	   , process_name			= CASE WHEN MDM_ManualChange THEN process_name ELSE p_process_name END
     , process_FileName = CASE WHEN MDM_ManualChange THEN process_FileName ELSE p_process_FileName END
	   , process_description	= CASE WHEN MDM_ManualChange THEN process_description ELSE p_process_description END
	   , process_owner			= CASE WHEN MDM_ManualChange THEN process_owner ELSE p_process_owner END
	   , process_frequency    = CASE WHEN MDM_ManualChange THEN process_frequency ELSE p_process_frequency END
	WHERE process_id = p_process_id;

	IF found THEN
		RETURN;
	END IF;

	-- not there, so try to insert the key
	-- if someone else inserts the same key concurrently,
	-- we could get a unique-key failure

	INSERT INTO control_process (process_id
							   , area_id
							   , process_name
                 , process_FileName
							   , process_description
							   , process_owner
							   , process_frequency
							   , mdm_fhcreate
							   , mdm_processname) 	
	SELECT   p_process_id
		   , p_area_id
		   , p_process_name
       , p_process_FileName
		   , p_process_description
		   , p_process_owner
		   , p_process_frequency
		   , current_timestamp
		   , p_mdm_processname;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_singleton_Add (p_singleton_id                 VARCHAR(100)
										   , p_application_Id              VARCHAR(100)
										   , p_singleton_name                 VARCHAR(100))  
RETURNS VARCHAR(100) AS
$$
DECLARE
	V_application_id VARCHAR(100);
BEGIN
	V_application_id := NULL;
	BEGIN
		INSERT INTO control_singleton (singleton_id
								   , application_id
								   , singleton_name
								   , mdm_fhcreate) 	
		SELECT   p_singleton_id
			   , p_application_Id
			   , p_singleton_name
			   , current_timestamp;
			   		
	EXCEPTION
		WHEN unique_violation THEN V_application_id := (SELECT application_id FROM control_singleton WHERE singleton_id = p_singleton_id);
		WHEN others THEN V_application_id := (SELECT application_id FROM control_singleton WHERE singleton_id = p_singleton_id);
	END;
	RETURN V_application_id;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_singleton_remove (p_singleton_id                 VARCHAR(100))  
RETURNS VOID AS
$$
BEGIN
	DELETE FROM control_singleton 
  WHERE singleton_id = p_singleton_id;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;


  
CREATE OR REPLACE FUNCTION control_executors_remove (   p_application_Id              VARCHAR(100))  
RETURNS VOID AS
$$
BEGIN
	DELETE FROM control_singleton where application_id = p_application_Id;
	DELETE FROM control_executors where application_id = p_application_Id;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



               
CREATE OR REPLACE FUNCTION control_executors_add (   p_application_Id              VARCHAR(100)
										   , p_IdSparkPort                 VARCHAR(50)
										   , p_IdPortMonitoring            VARCHAR(500)
										   , p_Executor_Name     			VARCHAR(100))  
RETURNS VOID AS
$$
BEGIN
	INSERT INTO control_executors (application_Id
							   , IdSparkPort
							   , IdPortMonitoring
							   , Executor_dtStart
							   , Executor_Name) 	
	SELECT   p_application_Id
		   , p_IdSparkPort
		   , p_IdPortMonitoring
		   , current_timestamp
		   , p_Executor_Name;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION control_processExec_UpdParam (     p_processExec_id          VARCHAR(50)
                                             ,p_paramName varchar(50)
											 ,p_value INTEGER)
RETURNS VOID AS
$$
BEGIN
	UPDATE control_processExec 
	SET processExec_param_year	= case when p_paramName = 'year' then p_value else processExec_param_year	 end
	   ,processExec_param_month	= case when p_paramName = 'month' then p_value else processExec_param_month	 end
	   ,processExec_param_day	= case when p_paramName = 'day' then p_value else processExec_param_day	 end
	   ,processExec_param_hour	= case when p_paramName = 'hour' then p_value else processExec_param_hour	 end
	   ,processExec_param_min	= case when p_paramName = 'min' then p_value else processExec_param_min	 end
	   ,processExec_param_sec	= case when p_paramName = 'sec' then p_value else processExec_param_sec	 end
	WHERE processexec_id = p_processExec_id;
                          
	RETURN;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION control_processExec_UpdParamInfo (     p_processExec_id          VARCHAR(50)
                                             ,p_paramName varchar(50)
											 ,p_value varchar(1000))
RETURNS VOID AS
$$
BEGIN
	UPDATE control_processExec 
    SET processExec_param_others = case when processExec_param_others is null or processExec_param_others = '' then '' else processExec_param_others || ', ' end
										|| '{' || p_paramName || '}=' || p_value
	WHERE processexec_id = p_processExec_id;
                          
	RETURN;
END;
$$
LANGUAGE plpgsql;




CREATE OR REPLACE FUNCTION control_processExec_add (     p_processExec_id          VARCHAR(50)
                                             ,p_processExec_idParent    VARCHAR(50)
                                             ,p_process_id              VARCHAR(200)
                                             ,p_Malla_id                VARCHAR(50)
											 ,p_application_Id			VARCHAR(100)
                                             ,p_processExec_WhosRun     VARCHAR(200)
                                             ,p_processExec_DebugMode   boolean
                                             ,p_processExec_Environment VARCHAR(200)
											 ,p_processExec_param_year	INT 
											 ,p_processExec_param_month	INT 
											 ,p_processExec_param_day	INT 
											 ,p_processExec_param_hour	INT 
											 ,p_processExec_param_min	INT 
											 ,p_processExec_param_sec	INT 
											 ,p_processExec_param_others	VARCHAR(1000) 
                                             ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
BEGIN
	INSERT INTO control_processExec (
                           processexec_id
                          ,processexec_idparent
                          ,process_id
                          ,malla_id
						              ,application_Id
                          ,processexec_isstart
                          ,processexec_iscancelled
                          ,processexec_isenderror
                          ,processexec_isendok
                          ,processexec_dtstart
                          ,processexec_dtend
                          ,processexec_durhour
                          ,processexec_durmin
                          ,processexec_dursec
                          ,processexec_whosrun
                          ,processexec_debugmode
                          ,processexec_environment
						  ,processExec_param_year	
						  ,processExec_param_month	
						  ,processExec_param_day	
						  ,processExec_param_hour	
						  ,processExec_param_min	
						  ,processExec_param_sec	
						  ,processExec_param_others
                          ,error_id
                          ,mdm_fhcreate
                          ,mdm_processname)
     SELECT    p_processexec_id
			  ,p_processexec_idparent
			  ,p_process_id
			  ,p_malla_id
			  ,p_application_Id
			  ,true
			  ,false
			  ,false
			  ,false
			  ,current_timestamp
			  ,null
			  ,0
			  ,0
			  ,0
			  ,p_processexec_whosrun
			  ,p_processexec_debugmode
			  ,p_processexec_environment
			  ,p_processExec_param_year	
			  ,p_processExec_param_month	
			  ,p_processExec_param_day	
			  ,p_processExec_param_hour	
			  ,p_processExec_param_min	
			  ,p_processExec_param_sec	
			  ,p_processExec_param_others
			  ,null
			  ,current_timestamp
			  ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_processExec_Finish (p_processExec_id          VARCHAR(50)
										 	 ,p_processExecStep_id		VARCHAR(50)
                                             ,p_error_id              VARCHAR(50))
RETURNS VOID AS
$$
BEGIN
	UPDATE control_processExecStep
        SET processexecstep_status = case when p_error_id is null or p_error_id = '' then 'OK' else 'ERROR' end
			,processexecstep_dtend = current_timestamp
			,processexecstep_durhour = extract(hour from (current_timestamp - processexecstep_dtstart)) + extract(day from (current_timestamp - processexecstep_dtstart)) * 24
			,processexecstep_durmin  = extract(minute from (current_timestamp - processexecstep_dtstart))
			,processexecstep_dursec  = extract(second from (current_timestamp - processexecstep_dtstart))
			,error_id				  = p_error_id
	WHERE processExecStep_id = p_processExecStep_id;
	
	UPDATE control_processExec
        SET processexec_iscancelled = false
	  ,processexec_isenderror = case when p_error_id is null or p_error_id = '' then false else true end
	  ,processexec_isendok	  = case when p_error_id is null or p_error_id = '' then true else false end
	  ,processexec_dtend	  = current_timestamp
	  ,processexec_durhour	  = extract(hour from (current_timestamp - processexec_dtstart)) + extract(day from (current_timestamp - processexec_dtstart)) * 24
	  ,processexec_durmin	  = extract(minute from (current_timestamp - processexec_dtstart))
	  ,processexec_dursec	  = extract(second from (current_timestamp - processexec_dtstart))
	  ,error_id				  = p_error_id
	WHERE processexec_id = P_processexec_id;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;
   



CREATE OR REPLACE FUNCTION control_processExecStep_add ( p_processExecStep_id      VARCHAR(50)
											 ,p_processExecStep_idAnt   VARCHAR(50)
                                             ,p_processExec_id          VARCHAR(50)
                                             ,p_processExecStep_Name        VARCHAR(200)
                                             ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
BEGIN
	IF (p_processExecStep_idAnt IS NOT NULL) THEN
		UPDATE control_processExecStep
		SET processexecstep_status = 'OK'
           ,processexecstep_dtend = current_timestamp
		   ,processexecstep_durhour = extract(hour from (current_timestamp - processexecstep_dtstart)) + extract(day from (current_timestamp - processexecstep_dtstart)) * 24
		   ,processexecstep_durmin  = extract(minute from (current_timestamp - processexecstep_dtstart))
		   ,processexecstep_dursec  = extract(second from (current_timestamp - processexecstep_dtstart))
		WHERE processExecStep_id = p_processExecStep_idAnt;
	END IF;
	
	INSERT INTO control_processExecStep (  processexecstep_id
										  ,processexec_id
										  ,processexecstep_name
										  ,processexecstep_status
										  ,processexecstep_dtstart
										  ,processexecstep_dtend
										  ,processexecstep_durhour
										  ,processexecstep_durmin
										  ,processexecstep_dursec
										  ,error_id
										  ,mdm_fhcreate
										  ,mdm_processname)
     SELECT    p_processexecstep_id
			  ,p_processexec_id
			  ,p_processexecstep_name
			  ,'RUNNING'
			  ,current_timestamp
			  ,null
			  ,0
			  ,0
			  ,0
			  ,null
			  ,current_timestamp
			  ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_DQ_add (  p_DQ_Id                   VARCHAR(50) 
								 ,p_Table_name              VARCHAR(200) 
								 ,p_BBDD_name               VARCHAR(200) 
								 ,p_Process_Id              VARCHAR(200)
								 ,p_ProcessExec_Id          VARCHAR(50)
								 ,p_Column_Name             VARCHAR(200)
								 ,p_Dq_AliasDF              VARCHAR(200)
								 ,p_DQ_Name                 VARCHAR(200)
								 ,p_DQ_Description          VARCHAR(1000)
                                                                 ,p_DQ_QueryLevel           VARCHAR(50)
                                                                 ,p_DQ_Notification         VARCHAR(50)
								 ,p_DQ_SQLFormula           VARCHAR(8000)
								 ,p_DQ_toleranceError_Rows     BigInt
								 ,p_DQ_toleranceError_Percent     Decimal(30,10)
								 ,p_DQ_ResultDQ             VARCHAR(8000)
                 ,p_DQ_ErrorCode            Integer
								 ,p_DQ_NumRowsOK            BigInt
								 ,p_DQ_NumRowsError         BigInt
								 ,p_DQ_NumRowsTotal         BigInt
                                                                 ,p_DQ_IsError                Boolean
								 ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
DECLARE
	LocalTable_id VARCHAR(50);
	LocalColumn_Id VARCHAR(50);
BEGIN
	LocalTable_id := (select Table_id from control_Tables where Table_BBDDName = p_BBDD_name and Table_Name = p_Table_name);
	LocalColumn_Id := (select Column_id from control_Columns where Table_Id = LocalTable_id and Column_Name = p_Column_Name);
	
	INSERT INTO control_DQ (
                      dq_id
                     ,table_id
                     ,process_id
                     ,processexec_id
                     ,column_id
                     ,column_name
                     ,dq_aliasdf
                     ,dq_name
                     ,dq_description
                     ,DQ_QueryLevel
                     ,DQ_Notification
                     ,dq_sqlformula
                     ,dq_DQ_toleranceError_Rows
                     ,dq_DQ_toleranceError_Percent
                     ,dq_resultdq
                     ,dq_ErrorCode
                     ,dq_numrowsok
                     ,dq_numrowserror
                     ,dq_numrowstotal
                     ,DQ_IsError
                     ,mdm_fhcreate
                     ,mdm_processname)
	SELECT    p_dq_id
			 ,LocalTable_id
			 ,p_process_id
			 ,p_processexec_id
			 ,LocalColumn_Id
			 ,p_column_name
			 ,p_dq_aliasdf
			 ,p_dq_name
			 ,p_dq_description
			 ,p_DQ_QueryLevel
			 ,p_DQ_Notification
			 ,p_dq_sqlformula
			 ,p_DQ_toleranceError_Rows
			 ,p_DQ_toleranceError_Percent
			 ,p_dq_resultdq
       ,p_dq_ErrorCode
			 ,p_dq_numrowsok
			 ,p_dq_numrowserror
			 ,p_dq_numrowstotal
                         ,p_DQ_IsError
			 ,current_timestamp
			 ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_rawFiles_add (    p_RAWFiles_id             VARCHAR(50)
										 ,p_RAWFiles_LogicalName    VARCHAR(1000)
										 ,p_RAWFiles_GroupName      VARCHAR(1000)
										 ,p_RAWFiles_Description    VARCHAR(1000)
										 ,p_RAWFiles_Owner          VARCHAR(200)
										 ,p_RAWFiles_frequency      VARCHAR(200)
										 ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
BEGIN
	UPDATE control_rawFiles
  SET rawfiles_description	= case when MDM_ManualChange then rawfiles_description	else p_rawfiles_description	end
		 ,rawfiles_owner		= case when MDM_ManualChange then rawfiles_owner		else p_rawfiles_owner		end
		 ,rawfiles_frequency	= case when MDM_ManualChange then rawfiles_frequency	else p_rawfiles_frequency	end
	WHERE rawfiles_logicalname = p_rawfiles_logicalname
  and   rawfiles_groupname   = p_rawfiles_groupname;
	IF FOUND THEN
	
		RETURN;
	END IF;
	
	INSERT INTO control_rawFiles (rawfiles_id
								 ,area_id
								 ,rawfiles_logicalname
								 ,rawfiles_groupname
								 ,rawfiles_description
								 ,rawfiles_owner
								 ,rawfiles_frequency
								 ,MDM_ManualChange
								 ,mdm_fhcreate
								 ,mdm_processname)
	SELECT    p_rawfiles_id
			 ,''
			 ,p_rawfiles_logicalname
			 ,p_rawfiles_groupname
			 ,p_rawfiles_description
			 ,p_rawfiles_owner
			 ,p_rawfiles_frequency
			 ,false as MDM_ManualChange
			 ,current_timestamp
			 ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE or replace FUNCTION control_RAWFilesDet_add (     p_RAWFilesDet_id                            VARCHAR(50)
                                             ,p_rawfiles_logicalname                      VARCHAR(1000)
                                             ,p_rawfiles_groupname                        VARCHAR(1000)
                                             ,p_RAWFilesDet_StartDate                     TimeStamp
                                             ,p_RAWFilesDet_EndDate                       TimeStamp
                                             ,p_RAWFilesDet_FileName                      VARCHAR(1000)
                                             ,p_RAWFilesDet_LocalPath                     VARCHAR(1000)
                                             ,p_RAWFilesDet_GlobalPath                    VARCHAR(1000)
                                             ,p_RAWFilesDet_Data_ColSeparatorType         VARCHAR(50)
                                             ,p_RAWFilesDet_Data_ColSeparator             VARCHAR(50)
                                             ,p_RAWFilesDet_Data_HeaderColumnsString      VARCHAR(8000)
                                             ,p_RAWFilesDet_Log_ColSeparatorType          VARCHAR(50)
                                             ,p_RAWFilesDet_Log_ColSeparator              VARCHAR(50)
                                             ,p_RAWFilesDet_Log_HeaderColumnsString       VARCHAR(8000)
                                             ,p_RAWFilesDet_Log_NumRowsFieldName          VARCHAR(200)
                                             ,p_RAWFilesDet_ContactName                   VARCHAR(200)
                                             ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
DECLARE
	Localrawfilesdet_id VARCHAR(50);
	LocalRAWFiles_id  VARCHAR(50);
BEGIN


	LocalRAWFiles_id := ( SELECT RAWFiles_Id
                        FROM control_rawFiles
                        WHERE rawfiles_logicalname = p_rawfiles_logicalname
                        and   rawfiles_groupname   = p_rawfiles_groupname
                      );
	Localrawfilesdet_id := (SELECT rawfilesdet_id 
							FROM control_RAWFilesDet 
							WHERE RAWFiles_id = LocalRAWFiles_id
							AND   RAWFilesDet_StartDate = p_RAWFilesDet_StartDate); 
								
	IF (Localrawfilesdet_id IS NULL) THEN
		INSERT INTO control_RAWFilesDet (   rawfilesdet_id
										   ,rawfiles_id
										   ,rawfilesdet_startdate
										   ,rawfilesdet_enddate
										   ,rawfilesdet_filename
										   ,rawfilesdet_localpath
										   ,rawfilesdet_globalpath
										   ,rawfilesdet_data_colseparatortype
										   ,rawfilesdet_data_colseparator
										   ,rawfilesdet_data_headercolumnsstring
										   ,rawfilesdet_log_colseparatortype
										   ,rawfilesdet_log_colseparator
										   ,rawfilesdet_log_headercolumnsstring
										   ,rawfilesdet_log_numrowsfieldname
										   ,rawfilesdet_contactname
										   ,mdm_fhcreate
										   ,mdm_processname)
		SELECT  p_rawfilesdet_id
			   ,LocalRAWFiles_id
			   ,p_rawfilesdet_startdate
			   ,p_rawfilesdet_enddate
			   ,p_rawfilesdet_filename
			   ,p_rawfilesdet_localpath
			   ,p_rawfilesdet_globalpath
			   ,p_rawfilesdet_data_colseparatortype
			   ,p_rawfilesdet_data_colseparator
			   ,p_rawfilesdet_data_headercolumnsstring
			   ,p_rawfilesdet_log_colseparatortype
			   ,p_rawfilesdet_log_colseparator
			   ,p_rawfilesdet_log_headercolumnsstring
			   ,p_rawfilesdet_log_numrowsfieldname
			   ,p_rawfilesdet_contactname
			   ,current_timestamp
			   ,p_mdm_processname
			   ;
	ELSE
		UPDATE control_RAWFilesDet
		SET rawfilesdet_enddate      = p_rawfilesdet_enddate						
		   ,rawfilesdet_filename					= p_rawfilesdet_filename					
		   ,rawfilesdet_localpath					= p_rawfilesdet_localpath					
		   ,rawfilesdet_globalpath					= p_rawfilesdet_globalpath					
		   ,rawfilesdet_data_colseparatortype		= p_rawfilesdet_data_colseparatortype		
		   ,rawfilesdet_data_colseparator			= p_rawfilesdet_data_colseparator			
		   ,rawfilesdet_data_headercolumnsstring	= p_rawfilesdet_data_headercolumnsstring	
		   ,rawfilesdet_log_colseparatortype		= p_rawfilesdet_log_colseparatortype		
		   ,rawfilesdet_log_colseparator			= p_rawfilesdet_log_colseparator			
		   ,rawfilesdet_log_headercolumnsstring		= p_rawfilesdet_log_headercolumnsstring		
		   ,rawfilesdet_log_numrowsfieldname		= p_rawfilesdet_log_numrowsfieldname		
		   ,rawfilesdet_contactname					= p_rawfilesdet_contactname					
		WHERE rawfilesdet_id = Localrawfilesdet_id;
	
		UPDATE control_RAWFilesDetFields SET MDM_Active = false where rawfilesdet_id = 	Localrawfilesdet_id;
	END IF;
		
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE or replace FUNCTION control_RAWFilesDetFields_add (
                              p_rawfiles_logicalname            VARCHAR(1000)
                             ,p_rawfiles_groupname              VARCHAR(1000)
                             ,p_RAWFilesDet_StartDate           TimeStamp
							 ,p_RAWFilesDetFields_ITName          VARCHAR(200)
							 ,p_RAWFilesDetFields_LogicalName          VARCHAR(200)
							 ,p_RAWFilesDetFields_description          VARCHAR(1000)
							 ,p_RAWFilesDetFields_DataType            VARCHAR(50)
							 ,P_RAWFilesDetFields_Position      INT
							 ,P_RAWFilesDetFields_PosIni        INTEGER
							 ,P_RAWFilesDetFields_PosFin        INTEGER
							 ,p_RAWFilesDetFields_ApplyTrim     BOOLEAN
							 ,p_RAWFilesDetFields_ConvertNull   BOOLEAN
							 ,P_MDM_ProcessName                 VARCHAR(200))
RETURNS VOID AS
$$
DECLARE
  Localrawfiles_id VARCHAR(50);
  Localrawfilesdet_id VARCHAR(50);
BEGIN
  Localrawfiles_id := (SELECT RawFiles_Id
                          FROM control_RAWFiles
                          WHERE rawfiles_logicalname = p_rawfiles_logicalname
                          AND   rawfiles_groupname = p_rawfiles_groupname);

  Localrawfilesdet_id := (SELECT rawfilesdet_id
                          FROM control_RAWFilesDet
                          WHERE RawFiles_Id = Localrawfiles_id
                          AND   RAWFilesDet_StartDate = p_RAWFilesDet_StartDate);
						  

	UPDATE control_RAWFilesDetFields
	SET  MDM_Active = TRUE
		,RAWFilesDetFields_ITName		=  p_RAWFilesDetFields_ITName
		,RAWFilesDetFields_LogicalName  =  p_RAWFilesDetFields_LogicalName
		,RAWFilesDetFields_description  =  p_RAWFilesDetFields_description
		,RAWFilesDetFields_DataType     =  p_RAWFilesDetFields_DataType
		,rawfilesdetfields_position     =  p_rawfilesdetfields_position
		,rawfilesdetfields_posini       =  p_rawfilesdetfields_posini
		,rawfilesdetfields_posfin       =  p_rawfilesdetfields_posfin
		,RAWFilesDetFields_ApplyTrim    =  p_RAWFilesDetFields_ApplyTrim
		,RAWFilesDetFields_ConvertNull  =  p_RAWFilesDetFields_ConvertNull 
	WHERE rawfilesdet_id = Localrawfilesdet_id
	AND   RAWFilesDetFields_LogicalName = p_RAWFilesDetFields_LogicalName;
	
	IF FOUND THEN
		RETURN;
	END IF;

	INSERT INTO control_RAWFilesDetFields (  rawfilesdet_id
											,RAWFilesDetFields_ITName
											,RAWFilesDetFields_LogicalName
											,RAWFilesDetFields_description
											,RAWFilesDetFields_DataType
											,rawfilesdetfields_position
											,rawfilesdetfields_posini
											,rawfilesdetfields_posfin
                                             ,RAWFilesDetFields_ApplyTrim
                                             ,RAWFilesDetFields_ConvertNull 
											 ,MDM_Active
											,mdm_fhcreate
											,mdm_processname)
	SELECT   Localrawfilesdet_id
			,p_RAWFilesDetFields_ITName
			,p_RAWFilesDetFields_LogicalName
			,p_RAWFilesDetFields_description
			,p_RAWFilesDetFields_DataType
			,p_rawfilesdetfields_position
			,p_rawfilesdetfields_posini
			,p_rawfilesdetfields_posfin
			,p_RAWFilesDetFields_ApplyTrim
			,p_RAWFilesDetFields_ConvertNull 
			,true
			,current_timestamp
			,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE or replace FUNCTION control_rawFilesUse_add (p_rawfiles_logicalname            VARCHAR(1000)
												 ,p_rawfiles_groupname              VARCHAR(1000)
												 ,p_RAWFilesUse_id          VARCHAR(50)
												 ,p_Process_Id              VARCHAR(200)
												 ,p_ProcessExec_Id          VARCHAR(50)
                                             ,p_RAWFilesUse_Year        INT
                                             ,p_RAWFilesUse_Month       INT
                                             ,p_RAWFilesUse_Day         INT
                                             ,p_RAWFilesUse_Hour        INT
                                             ,p_RAWFilesUse_Minute       INT
                                             ,p_RAWFilesUse_Second      INT
                                             ,p_RAWFilesUse_params      VARCHAR(1000)
												 ,p_RAWFiles_fullName       VARCHAR(1000)
												 ,p_RAWFiles_fullPath       VARCHAR(1000)
												 ,p_RAWFiles_numRows        VARCHAR(50)
												 ,p_RAWFiles_HeaderLine     VARCHAR(8000)
												 ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
DECLARE
  Localrawfiles_id VARCHAR(50);
BEGIN
  Localrawfiles_id := (SELECT RawFiles_Id
                          FROM control_RAWFiles
                          WHERE rawfiles_logicalname = p_rawfiles_logicalname
                          AND   rawfiles_groupname = p_rawfiles_groupname);

	INSERT INTO control_rawFilesUse (  rawfilesuse_id
									 ,rawfiles_id
									 ,process_id
									 ,processexec_id
                                             ,RAWFilesUse_Year
                                             ,RAWFilesUse_Month
                                             ,RAWFilesUse_Day
                                             ,RAWFilesUse_Hour
                                             ,RAWFilesUse_Minute
                                             ,RAWFilesUse_Second
                                             ,RAWFilesUse_params
									 ,rawfiles_fullname
									 ,rawfiles_fullpath
									 ,rawfiles_numrows
									 ,rawfiles_headerline
									 ,mdm_fhcreate
									 ,mdm_processname)
	SELECT    p_rawfilesuse_id
			 ,Localrawfiles_id
			 ,p_process_id
			 ,p_processexec_id
                         ,p_RAWFilesUse_Year
                                             ,p_RAWFilesUse_Month   
                                             ,p_RAWFilesUse_Day     
                                             ,p_RAWFilesUse_Hour    
                                             ,p_RAWFilesUse_Minute   
                                             ,p_RAWFilesUse_Second  
                                             ,p_RAWFilesUse_params  
			 ,p_rawfiles_fullname
			 ,p_rawfiles_fullpath
			 ,p_rawfiles_numrows
			 ,p_rawfiles_headerline
			 ,current_timestamp
			 ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_ProcessExecParams_add (    p_processExec_id          VARCHAR(50)
                                             ,p_processExecParams_Name  VARCHAR(1000)
                                             ,p_processExecParams_Value VARCHAR(8000)
                                             ,p_MDM_ProcessName         VARCHAR(200))
RETURNS VOID AS
$$
BEGIN
	INSERT INTO control_ProcessExecParams (processexec_id
								  ,processexecparams_name
								  ,processexecparams_value
								  ,mdm_fhcreate
								  ,mdm_processname)
	SELECT p_processexec_id
		  ,p_processexecparams_name
		  ,p_processexecparams_value
		  ,current_timestamp
		  ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_TablesUse_add (    p_Table_Name		VARCHAR(200)
												  	 ,p_Table_BBDDName		VARCHAR(200)
												  	 ,p_Process_Id              VARCHAR(200)
													 ,p_ProcessExec_Id          VARCHAR(50)
													 ,p_ProcessExecStep_Id          VARCHAR(50)
													 ,p_TableUse_Year        INT
													 ,p_TableUse_Month       INT
													 ,p_TableUse_Day         INT
													 ,p_TableUse_Hour        INT
													 ,p_TableUse_Minute       INT
													 ,p_TableUse_Second      INT
													 ,p_TableUse_params      VARCHAR(1000)
													 ,p_TableUse_Read           boolean
													 ,p_TableUse_Write          boolean
													 ,p_TableUse_numRowsNew     BIGINT
													 ,p_TableUse_numRowsUpdate  BIGINT
													 ,p_TableUse_numRowsUpdatable  BIGINT
													 ,p_TableUse_numRowsNoChange  BIGINT
													 ,p_TableUse_numRowsMarkDelete  BIGINT
													 ,p_TableUse_numRowsTotal   BIGINT
													 ,p_TableUse_PartitionValue VARCHAR(200)
													 ,p_MDM_ProcessName         VARCHAR(200)
												 )
RETURNS VOID AS
$$
DECLARE
	LocalTable_id VARCHAR(50);
BEGIN
	LocalTable_id := (SELECT Table_Id FROM Control_Tables WHERE Table_Name = p_Table_Name and Table_BBDDName = p_Table_BBDDName);

	INSERT INTO control_TablesUse ( table_id
								   ,process_id
								   ,processexec_id
                                   ,ProcessExecStep_Id
                                   ,TableUse_Year
                                   ,TableUse_Month
                                   ,TableUse_Day
                                   ,TableUse_Hour
                                   ,TableUse_Minute
                                   ,TableUse_Second
                                   ,TableUse_params
								   ,tableuse_read
								   ,tableuse_write
								   ,tableuse_numrowsnew
								   ,tableuse_numrowsupdate
								   ,TableUse_numRowsUpdatable
								   ,TableUse_numRowsNoChange 
								   ,tableuse_numrowsmarkdelete
								   ,tableuse_numrowstotal
								   ,TableUse_PartitionValue
								   ,mdm_fhcreate
								   ,mdm_processname)
	SELECT  LocalTable_id
		   ,p_process_id
		   ,p_processexec_id
           ,P_ProcessExecStep_Id
           ,p_TableUse_Year
           ,p_TableUse_Month
           ,p_TableUse_Day
           ,p_TableUse_Hour
           ,p_TableUse_Minute
           ,p_TableUse_Second
           ,p_TableUse_params
		   ,p_tableuse_read
		   ,p_tableuse_write
		   ,p_tableuse_numrowsnew
		   ,p_tableuse_numrowsupdate
		   ,p_TableUse_numRowsUpdatable
		   ,p_TableUse_numRowsNoChange 
		   ,p_tableuse_numrowsmarkdelete
		   ,p_tableuse_numrowstotal
		   ,p_TableUse_PartitionValue
		   ,current_timestamp
		   ,p_mdm_processname
		   ;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_TablesRel_add (   p_TableRel_id				VARCHAR(50)
										   , p_Table_NamePK               VARCHAR(50)
										   , p_Table_BBDDPK               VARCHAR(50)
										   , p_Table_NameFK               VARCHAR(50)
										   , p_Table_BBDDFK               VARCHAR(50)
										   , p_TableFK_NameRelationship         VARCHAR(200)
										   , p_mdm_processname         VARCHAR(200))  
RETURNS VARCHAR(50) AS
$$
DECLARE
	lTableRel_id VARCHAR(50);
	FK_Id VARCHAR(50);
	PK_ID VARCHAR(50);
BEGIN
	PK_ID := (SELECT Table_Id FROM control_Tables 
			  WHERE Table_Name = p_Table_NamePK
			  AND   Table_BBDDName = p_Table_BBDDPK
			 );
			 
	FK_Id := (SELECT Table_Id FROM control_Tables 
			  WHERE Table_Name = p_Table_NameFK
			  AND   Table_BBDDName = p_Table_BBDDFK
			 );
			 
	lTableRel_id := (SELECT TableRel_id 
					 FROM control_TablesRel 
					 WHERE Table_idPK = PK_ID
					 AND   Table_idFK = FK_Id
					 AND   TableFK_NameRelationship = p_TableFK_NameRelationship
					);
			
	IF (lTableRel_id IS NULL) THEN
		lTableRel_id := P_TableRel_id;
		INSERT INTO control_TablesRel (TableRel_id
							   , Table_idPK
							   , Table_idFK
							   , TableFK_NameRelationship
							   , MDM_fhCreate
							   , mdm_processname) 	
		SELECT   P_TableRel_id
			   , PK_ID
			   , FK_Id
			   , p_TableFK_NameRelationship
			   , current_timestamp
			   , p_mdm_processname;
	ELSE
		DELETE FROM control_TablesRelCol WHERE TableRel_id = lTableRel_id;
	END IF;
	
	

	
	
	RETURN lTableRel_id;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_TablesRelCol_add ( p_TableRel_id				VARCHAR(50)
										   , p_Table_NamePK               VARCHAR(50)
										   , p_Table_BBDDPK               VARCHAR(50)
										   , p_ColumnName_PK               VARCHAR(50)			 
										   , p_Table_NameFK               VARCHAR(50)
										   , p_Table_BBDDFK               VARCHAR(50)
										   , p_ColumnName_FK               VARCHAR(50)			 
										   , p_mdm_processname         VARCHAR(200))  
RETURNS VOID AS
$$
DECLARE
	FK_Id VARCHAR(50);
	PK_ID VARCHAR(50);
	ColumnPK VARCHAR(50);
	ColumnFK VARCHAR(50);
BEGIN
	PK_ID := (SELECT Table_Id FROM control_Tables 
			  WHERE Table_Name = p_Table_NamePK
			  AND   Table_BBDDName = p_Table_BBDDPK
			 );
			 
	FK_Id := (SELECT Table_Id FROM control_Tables 
			  WHERE Table_Name = p_Table_NameFK
			  AND   Table_BBDDName = p_Table_BBDDFK
			 );
			 
	ColumnPK := (SELECT Column_Id FROM control_columns
				 WHERE table_id = PK_ID
				 AND   column_name = p_ColumnName_PK
				);
				
	ColumnFK := (SELECT Column_Id FROM control_columns
				 WHERE table_id = FK_ID
				 AND   column_name = p_ColumnName_FK
				);
			 
	INSERT INTO control_TablesRelCol (TableRel_id
									 ,Column_idFK
									 ,Column_idPK
									 ,MDM_fhCreate
									 ,MDM_ProcessName
									 )
	SELECT p_TableRel_id
		  ,ColumnFK
		  ,ColumnPK
		  ,current_timestamp
		  ,p_mdm_processname;
	
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_Tables_addOrUpd (  p_Table_id                VARCHAR(50)
													 ,p_Area_Id                 VARCHAR(50)
													 ,p_Table_BBDDName          VARCHAR(200)
													 ,p_Table_Name              VARCHAR(200)
													 ,p_Table_Description       VARCHAR(1000)
													 ,p_Table_BusinessOwner     VARCHAR(200)
													 ,p_Table_ITOwner           VARCHAR(200)
													 ,p_Table_PartitionField    VARCHAR(200)
													 ,p_Table_TableType         VARCHAR(50)  --reference, master, transactional
													 ,p_Table_StorageType       VARCHAR(50)
													 ,p_Table_LocalPath         VARCHAR(1000)
													 ,p_Table_GlobalPath        VARCHAR(1000)
													 ,p_Table_SQLCreate         VARCHAR(8000)
													 ,p_Table_Frequency		  VARCHAR(200)
													 ,p_MDM_ProcessName         VARCHAR(200) )  
RETURNS VOID AS
$$
DECLARE 
	LocalTable_Id VARCHAR(50);
BEGIN
	-- first try to update the key
	UPDATE control_Tables 
  SET table_description = CASE WHEN MDM_ManualChange THEN table_description		ELSE P_table_description	END	 
		,table_businessowner	= CASE WHEN MDM_ManualChange THEN table_businessowner	ELSE P_table_businessowner	END
		,table_itowner			= CASE WHEN MDM_ManualChange THEN table_itowner			ELSE P_table_itowner		END
		,table_partitionfield	= P_table_partitionfield	
		,table_tabletype		= P_table_tabletype		
		,table_storagetype		= P_table_storagetype		
		,table_localpath		= P_table_localpath		
		,table_globalpath		= P_table_globalpath		
		,table_sqlcreate		= P_table_sqlcreate		
		,Table_Frequency		= p_Table_Frequency
	WHERE table_bbddname = p_table_bbddname
	and   table_name	 = p_table_name;

	IF found THEN
		LocalTable_Id := (SELECT Table_Id 
						  FROM control_Tables
						  WHERE table_bbddname = p_table_bbddname
						  and   table_name	 = p_table_name);
						  
		UPDATE Control_Columns SET MDM_Active = false WHERE Table_Id = LocalTable_Id;
		
		RETURN;
	END IF;

	-- not there, so try to insert the key
	-- if someone else inserts the same key concurrently,
	-- we could get a unique-key failure

	INSERT INTO control_Tables ( table_id
								,area_id
								,table_bbddname
								,table_name
								,table_description
								,table_businessowner
								,table_itowner
								,table_partitionfield
								,table_tabletype
								,table_storagetype
								,table_localpath
								,table_globalpath
								,table_sqlcreate
								,Table_Frequency
								,mdm_fhcreate
								,mdm_processname) 	
	SELECT   p_table_id
			,p_area_id
			,p_table_bbddname
			,p_table_name
			,p_table_description
			,p_table_businessowner
			,p_table_itowner
			,p_table_partitionfield
			,p_table_tabletype
			,p_table_storagetype
			,p_table_localpath
			,p_table_globalpath
			,p_table_sqlcreate
			,p_Table_Frequency
			,current_timestamp
			,p_mdm_processname;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_Columns_addOrUpd ( p_Column_id                  VARCHAR(50)
													 ,p_Table_Name               VARCHAR(200)
													 ,p_Table_BBDDName           VARCHAR(200)
													 ,p_Column_Position            int
													 ,p_Column_Name                VARCHAR(200)
													 ,p_Column_Description         VARCHAR(1000)
													 ,p_Column_Formula             VARCHAR(1000)
													 ,p_Column_DataType            VARCHAR(50)
													 ,p_Column_SensibleData        boolean
													 ,p_Column_EnableDTLog         boolean
													 ,p_Column_EnableOldValue      boolean
													 ,p_Column_EnableProcessLog    boolean
													 ,p_Column_DefaultValue        VARCHAR(1000)
													 ,p_Column_SecurityLevel       VARCHAR(200)
													 ,p_Column_Encrypted           VARCHAR(200)
													 ,p_Column_ARCO                VARCHAR(200)
													 ,p_Column_Nullable            boolean
													 ,p_Column_IsPK                boolean
													 ,p_Column_IsUnique            boolean
													 ,p_Column_DQ_MinLen           int
													 ,p_Column_DQ_MaxLen           int 
													 ,p_Column_DQ_MinDecimalValue  Decimal(30,10) 
													 ,p_Column_DQ_MaxDecimalValue  Decimal(30,10) 
													 ,p_Column_DQ_MinDateTimeValue VARCHAR(50) 
													 ,p_Column_DQ_MaxDateTimeValue VARCHAR(50)
													 ,p_Column_DQ_RegExp VARCHAR(1000)
													 ,p_MDM_ProcessName            VARCHAR(200) )  
RETURNS VOID AS
$$
DECLARE 
	LocalTable_Id VARCHAR(50);
BEGIN
	LocalTable_Id := (SELECT Table_Id 
					  FROM control_Tables
					  WHERE table_bbddname = p_table_bbddname
					  and   table_name	 = p_table_name);
						  
	-- first try to update the key
	UPDATE control_Columns 
  SET column_position	 = p_column_position				
		 ,column_description			= CASE WHEN MDM_ManualChange THEN column_description ELSE p_column_description	END
		 ,column_formula				= CASE WHEN MDM_ManualChange THEN column_formula ELSE p_column_formula	END			
		 ,column_datatype				= p_column_datatype				
		 ,column_sensibledata			= CASE WHEN MDM_ManualChange THEN column_sensibledata ELSE p_column_sensibledata	END		
		 ,column_enabledtlog			= p_column_enabledtlog			
		 ,column_enableoldvalue			= p_column_enableoldvalue			
		 ,column_enableprocesslog		= p_column_enableprocesslog		
		 ,column_defaultvalue			= p_column_defaultvalue			
		 ,column_securitylevel			= CASE WHEN MDM_ManualChange THEN column_securitylevel ELSE p_column_securitylevel	END		
		 ,column_encrypted				= p_column_encrypted				
		 ,column_arco					= CASE WHEN MDM_ManualChange THEN column_arco ELSE p_column_arco	END				
		 ,column_nullable				= p_column_nullable				
		 ,column_ispk					= p_column_ispk					
		 ,column_isunique				= p_column_isunique				
		 ,column_dq_minlen				= p_column_dq_minlen				
		 ,column_dq_maxlen				= p_column_dq_maxlen				
		 ,column_dq_mindecimalvalue		= p_column_dq_mindecimalvalue		
		 ,column_dq_maxdecimalvalue		= p_column_dq_maxdecimalvalue		
		 ,column_dq_mindatetimevalue	= p_column_dq_mindatetimevalue	
		 ,column_dq_maxdatetimevalue	= p_column_dq_maxdatetimevalue	
		 ,Column_DQ_RegExp              = p_Column_DQ_RegExp
		 ,MDM_Active					= true
	WHERE Table_Id = LocalTable_Id
	AND   Column_Name = p_column_name;

	IF found THEN
		RETURN;
	END IF;

	-- not there, so try to insert the key
	-- if someone else inserts the same key concurrently,
	-- we could get a unique-key failure

	INSERT INTO control_Columns ( column_id
								 ,table_id
								 ,column_position
								 ,column_name
								 ,column_description
								 ,column_formula
								 ,column_datatype
								 ,column_sensibledata
								 ,column_enabledtlog
								 ,column_enableoldvalue
								 ,column_enableprocesslog
								 ,column_defaultvalue
								 ,column_securitylevel
								 ,column_encrypted
								 ,column_arco
								 ,column_nullable
								 ,column_ispk
								 ,column_isunique
								 ,column_dq_minlen
								 ,column_dq_maxlen
								 ,column_dq_mindecimalvalue
								 ,column_dq_maxdecimalvalue
								 ,column_dq_mindatetimevalue
								 ,column_dq_maxdatetimevalue
								 ,Column_DQ_RegExp
								 ,mdm_fhcreate
								 ,mdm_processname) 	
	SELECT    p_column_id
			 ,LocalTable_Id
			 ,p_column_position
			 ,p_column_name
			 ,p_column_description
			 ,p_column_formula
			 ,p_column_datatype
			 ,p_column_sensibledata
			 ,p_column_enabledtlog
			 ,p_column_enableoldvalue
			 ,p_column_enableprocesslog
			 ,p_column_defaultvalue
			 ,p_column_securitylevel
			 ,p_column_encrypted
			 ,p_column_arco
			 ,p_column_nullable
			 ,p_column_ispk
			 ,p_column_isunique
			 ,p_column_dq_minlen
			 ,p_column_dq_maxlen
			 ,p_column_dq_mindecimalvalue
			 ,p_column_dq_maxdecimalvalue
			 ,p_column_dq_mindatetimevalue
			 ,p_column_dq_maxdatetimevalue
			 ,p_Column_DQ_RegExp
			 ,current_timestamp
			 ,p_mdm_processname;
	
	RETURN;
END;
$$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION control_Error_finish (p_processExec_id          VARCHAR(50)
										 	 	,p_processExecStep_id		VARCHAR(50)
                                             	,p_Error_Id          VARCHAR(50)
												 ,p_Error_Message                text
                         ,p_Error_Code                Integer
												 ,p_Error_Trace                text
												 ,p_Error_ClassName                text
												 ,p_Error_FileName                text
												 ,p_Error_LIneNumber                text
												 ,p_Error_MethodName                text
												 ,p_Error_Detail                text
												 ,p_MDM_ProcessName         varchar(1000))
RETURNS VOID AS
$$
BEGIN
	INSERT INTO Control_Error (error_id
                      ,error_message
                      ,error_code
                      ,error_trace
                      ,error_classname
                      ,error_filename
                      ,error_linenumber
                      ,error_methodname
                      ,error_detail
                      ,mdm_fhcrea
                      ,mdm_processname)
	SELECT p_error_id
		  ,p_error_message
      ,p_error_code
		  ,p_error_trace
		  ,p_error_classname
		  ,p_error_filename
		  ,p_error_linenumber
		  ,p_error_methodname
		  ,p_error_detail
		  ,current_timestamp
		  ,p_mdm_processname;
		  
	PERFORM control_processExec_Finish(p_processExec_id, p_processExecStep_id, p_error_id);
		  
	RETURN;
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION control_Error_register (p_Error_Id          VARCHAR(50)
												 ,p_Error_Message                text
												 ,p_Error_Code                Integer
												 ,p_Error_Trace                text
												 ,p_Error_ClassName                text
												 ,p_Error_FileName                text
												 ,p_Error_LIneNumber                text
												 ,p_Error_MethodName                text
												 ,p_Error_Detail                text
												 ,p_MDM_ProcessName         varchar(1000))
RETURNS VOID AS
$$
BEGIN
	INSERT INTO Control_Error (error_id
                      ,error_message
                      ,error_code
                      ,error_trace
                      ,error_classname
                      ,error_filename
                      ,error_linenumber
                      ,error_methodname
                      ,error_detail
                      ,mdm_fhcrea
                      ,mdm_processname)
	SELECT p_error_id
		  ,p_error_message
      ,p_error_code
		  ,p_error_trace
		  ,p_error_classname
		  ,p_error_filename
		  ,p_error_linenumber
		  ,p_error_methodname
		  ,p_error_detail
		  ,current_timestamp
		  ,p_mdm_processname;
		  
	RETURN;
END;
$$
LANGUAGE plpgsql;