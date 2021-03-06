USE [OrBitXI_Test]
GO
/****** Object:  StoredProcedure [dbo].[GetAQLDataBySQCReportId]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
-- =============================================
-- Author:		C C
-- Create date: 2018-07-06
-- Description:	根据送检单获取AQL样本数据
-- =============================================
CREATE PROCEDURE [dbo].[GetAQLDataBySQCReportId] 
@SQCId CHAR(12) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--
	--根据送检单判断产品类型
	--
	DECLARE	@SQC_Qty DECIMAL(18,4),		-- 送检数量
			@ProductType nvarchar(10)='',
			@ProductId char(12)=''
    SELECT  @SQC_Qty=SendQCQty,@ProductId=SendQCReport.ProductId, @ProductType = (Select ProductType from ProductTypeName where LEFT(ProductRoot.ProductName,1) = ProductTypeName.ProductTypeShortName)
	FROM	dbo.SendQCReport Left Join Product 
			On SendQCReport.ProductId =  Product.ProductId Left Join ProductRoot
			On Product.ProductRootId = ProductRoot.ProductRootId
	WHERE SendQCReportId=@SQCId

	--
	--判断产品类型是否在类型表中
	--
	IF (@ProductType=null)
	begin
		SELECT '-1' AS RetValue, '产品类型不在类型表中...' AS RetMsg
		return -1
	end

	DECLARE	@JCSP NVARCHAR(20)='',		-- 检查水平
			@JYBZ NVARCHAR(20)='',		-- 检验标准
			@JYBZ2 NVARCHAR(20)=''		-- 严格检验标准
	DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	DECLARE @SampleQty INT,		-- 样本大小
			@ACQty INT,			-- 允收数量
			@ReQty INT,			-- 拒收数量
			@ACQty2 INT,		-- 允收数量
			@ReQty2 INT			-- 拒收数量
	--
	--分支判断，如果是辅料，进入两个检查标准的分支，如果不是，进入一个检查标准的分支
	--

	--
	--分支1
	--
	If (@ProductType='3')
	Begin
		--
		--获取下面三项数据
		--
		--DECLARE	@JCSP NVARCHAR(20)='',		-- 检查水平
		--		@JYBZ NVARCHAR(20)='',		-- 检验标准
		--		@JYBZ2 NVARCHAR(20)=''		-- 严格检验标准
     
		IF (EXISTS(SELECT 1 From IQCCheckDefaultAQL Where IQCCheckDefaultAQL.ProductId = @ProductId))
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1, @JYBZ2=AQL2
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductId = @ProductId
		End
		Else
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1, @JYBZ2=AQL2
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductType = @ProductType AND IQCCheckDefaultAQL.ProductId=''
		End
	
		--
		--判断数据是否获取成功
		--
		IF (@JCSP = '' or @JYBZ='' or @JYBZ2='')
		BEGIN
			SELECT @JCSP asJCSP, @JYBZ asJYBZ, @JYBZ2 as JYBZ2
			SELECT '-1' AS RetValue, '辅料数据获取失败...' AS RetMsg
			return -1
		END

		--
		--获取下面五项数据
		--
		--DECLARE @SampleQty INT,		-- 样本大小
		--		@ACQty INT,			-- 允收数量
		--		@ReQty INT,			-- 拒收数量
		--		@ACQty2 INT,		-- 允收数量
		--		@ReQty2 INT			-- 拒收数量

		SELECT @SampleSizeCode=AQLSampleSizeCode  -- 样本大小代码 
		FROM dbo.AQLSampleSize 
		WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
		-- 获取AQL样本数量
		SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		FROM dbo.AQLDetail 
		WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ

		SELECT @ACQty2=ACQty,@ReQty2=ReQty 
		FROM dbo.AQLDetail 
		WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ2

		SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg,@JCSP AS CheckLevel, @JYBZ AS AQL1, @JYBZ2 AS AQL2, @SampleQty AS AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty, @ACQty2 AS ACQty2,@ReQty2 AS ReQty2 
		RETURN 0
	End
	--
	--分支2
	--
	Else
	Begin
		--
		--获取下面两项数据
		--
		--DECLARE	@JCSP NVARCHAR(20)='',		-- 检查水平
		--		@JYBZ NVARCHAR(20)=''		-- 检验标准
     
		IF (EXISTS(SELECT 1 From IQCCheckDefaultAQL Where IQCCheckDefaultAQL.ProductId = @ProductId))
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductId = @ProductId
		End
		Else
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductType = @ProductType AND IQCCheckDefaultAQL.ProductId=''
		End
	
		--
		--判断数据是否获取成功
		--
		IF (@JCSP = '' or @JYBZ='' )
		BEGIN
			SELECT '-1' AS RetValue, '数据获取失败...' AS RetMsg
			return -1
		END

		--
		--获取下面三项数据
		--
		--DECLARE @SampleQty INT,	-- 样本大小
		--		@ACQty INT,			-- 允收数量
		--		@ReQty INT			-- 拒收数量

		SELECT @SampleSizeCode=AQLSampleSizeCode  -- 样本大小代码 
		FROM dbo.AQLSampleSize 
		WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
		-- 获取AQL样本数量
		SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		FROM dbo.AQLDetail 
		WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ

		SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg,@JCSP AS CheckLevel, @JYBZ AS AQL1, '--' AS AQL2, @SampleQty AS AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty, '--' AS ACQty2,'--' AS ReQty2 
		RETURN 0
	End

	   
END

GO
/****** Object:  StoredProcedure [dbo].[GlassExtSubmit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlassExtSubmit]
	 @SendQCReportId char(12),
	 @xmlData  nvarchar(max), 
	 @Describe  nvarchar(max), 
	 @ExtCheckNo  nvarchar(10), 
	 
	 @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
     @Return INT	OUTPUT					-- 返回值
AS
BEGIN
	--验证是否存在检验报告
	IF NOT EXISTS(SELECT 1 FROM DBO.SQCheckResult WHERE SendQCReportId=@SendQCReportId)
	 BEGIN
	      SELECT @Result_Msg='不存在检验报告',@Return=-1
		   RETURN -1 
	 END
	--验证是否还没有加抽完成Speciment_ExtRecord
	 DECLARE @CheckNo INT
	 IF @ExtCheckNo=''
	   BEGIN
	        SELECT @Result_Msg='检验次数异常',@Return=-1
		   RETURN -1 
	   END
	ELSE
	  BEGIN
	  SET @CheckNo= CONVERT(DECIMAL, @ExtCheckNo) 
	  IF NOT  EXISTS(SELECT 1 FROM DBO.Speciment_ExtRecord WHERE SendQCReportId=@SendQCReportId AND CheckNo=@CheckNo AND IsDone=0)
	    BEGIN
	      SELECT @Result_Msg='不存在检验报告',@Return=-1
		   RETURN -1 
	    END
	   ELSE
	     BEGIN
		    UPDATE DBO.Speciment_ExtRecord SET xmlData=@xmlData,Describe=@Describe, IsDone=1 WHERE SendQCReportId=@SendQCReportId AND CheckNo=@CheckNo

		 END
	 END

	   SELECT @Result_Msg='提交成功',@Return=0
		   RETURN 0

END

GO
/****** Object:  StoredProcedure [dbo].[P_FirstSpeciment]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	抽样并打印标签
-- =============================================
CREATE PROCEDURE [dbo].[P_FirstSpeciment]
	@SQCId CHAR(12), 					-- 送检单Id 
@CYFS NVARCHAR(20),					-- 抽样方式
@JCSP NVARCHAR(20),					-- 检查水平
@JYBZ NVARCHAR(20),					-- 检验标准 
@JYBZ2 NVARCHAR(20)='--',					-- 检验标准
@UserId CHAR(12)='',				-- 用户内码
@ScanSN NVARCHAR(50)='',				-- 扫描SN
@CQ_Qty DECIMAL(18,4),				-- 抽取数量
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值
AS
BEGIN
  
  DECLARE @SQC_Qty  DECIMAL(18,4)
  SELECT @SQC_Qty=SendQCReport.SendQCQty FROM dbo.SendQCReport WHERE SendQCReportId= @SQCId 
	IF ISNULL(@SQC_Qty,-1)<=0
	BEGIN
		SELECT @Result_Msg='送检单不存在,不能打印样本标签...',@Return=-1
		RETURN -1 
	END

	DECLARE @T_LotId CHAR(12),@T_LotQty INT 

	SELECT @T_LotId=LotId,@T_LotQty=Qty FROM dbo.Lot WHERE LotSN=@ScanSN

	DECLARE @T_SQCId CHAR(12)

	SELECT @T_SQCId=VendorDeliveryItem.SendQCReportId FROM dbo.VendorDeliveryItemLot LEFT JOIN dbo.VendorDeliveryItem ON VendorDeliveryItem.VendorDeliveryItemId = VendorDeliveryItemLot.VendorDeliveryItemId 
	WHERE LotSN=@ScanSN
	IF ISNULL(@T_SQCId,'') <> ISNULL(@SQCId,' ')
	BEGIN
		SELECT @Result_Msg='送检单不一致,...'+ISNULL(@T_SQCId,'')+':'+ISNULL(@SQCId,' '),@Return=-1
		RETURN -1   
	END 
	 

IF EXISTS(SELECT 1 FROM Speciment WHERE SendQCReportId=@SQCId   )
	BEGIN
		SELECT @Result_Msg='当前检验批已生成样本标签,不能再次生成...',@Return=-1
		RETURN -1
	END 
END

	-- 根据检验参数获取检验标准,然后计算抽样数量是否达到检验标准  
	DECLARE @SampleQty INT,		-- 样本大小
		@ACQty INT,			-- 允收数量
		@ReQty INT			-- 拒收数量
     
	DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	SELECT @SampleSizeCode=AQLSampleSizeCode FROM dbo.AQLSampleSize WHERE CheckLevelCode=@JCSP  AND 
		( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
	  
	-- 获取AQL样本数量
	SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		FROM dbo.AQLDetail WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ

	

	IF ISNULL(@SampleQty,-1)<=0
	BEGIN
		SELECT @Result_Msg='样本需求数量异常...',@Return=-1
		RETURN -1  
	END 

-- 生成样本标签
	--DECLARE @T_NewYBSN NVARCHAR(30)='',@T_Str NVARCHAR(20)
	--SELECT TOP(1) @T_NewYBSN=YBSN FROM  Speciment WHERE DATEDIFF(DAY,GETDATE(),CreateDate )=0
	--IF ISNULL(@T_NewYBSN,'')=''
	--BEGIN
	--	SET @T_NewYBSN='YP'+CONVERT(CHAR(6),GETDATE(),12)+'0001'  
	--END 
	--ELSE
 --   BEGIN
	--	SET @T_NewYBSN='YP'+CONVERT(CHAR(6),GETDATE(),12)+ RIGHT(  '000'+ RTRIM(CAST( CAST(  RIGHT(@T_NewYBSN,4) AS INT)+1  AS CHAR(4)) ),4)
	--END 

	--写入样本数据
    INSERT INTO  Speciment(  SendQCReportId,   CYFS, CYSP, CYBZ, CQty, IsCYDone, CreateDate,SHQty,ScanSN,  CYBZ2 ,FCQty)
    SELECT @SQCId, @CYFS,@JCSP,  @JYBZ, @CQ_Qty,0,GETDATE(),@CQ_Qty,@ScanSN, @JYBZ2,@CQ_Qty

		--DECLARE @T_PKID INT
		--SELECT @T_PKID=SpecimentId FROM Speciment WHERE SendQCReportId=@SQCId
		
	SELECT @Result_Msg='数据抽取成功...',@Return=0
	RETURN 0

 
GO
/****** Object:  StoredProcedure [dbo].[P_GetAQLData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
 
-- =============================================
-- Author:		John Luo
-- Create date: 2018-06-08
-- Description:	获取AQL样本数据
-- =============================================
CREATE PROCEDURE [dbo].[P_GetAQLData] 
@SQCId CHAR(12),			-- 送检单Id
@CKlevel varchar(20)='',	-- 检查水平  ('S-1','S-2','S-3','S-4','I','II','III')
@AJDPgm VARCHAR(10)=1,				-- 抽样方案：0放宽，1正常，2加严，3免检
@aql VARCHAR(10)=1				-- 合格质量水平  

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQC_Qty DECIMAL(18,4),		-- 送检数量
			@NewSQCId CHAR(12),
			@ProductId CHAR(12)
    SELECT @NewSQCId=SendQCReportId, @SQC_Qty=SendQCQty,@ProductId=ProductId FROM dbo.SendQCReport WHERE SendQCReportId=@SQCId


	DECLARE @CYFS NVARCHAR(20),		--抽方式
			@JCSP NVARCHAR(20),		-- 检查水平
			@JYBZ NVARCHAR(20)		-- 检验标准

	-- 判断是否已抽样过 ,如果存在送检单抽样记录标准，那么根据抽样标准进行抽样
	-- 不存在则根据产品进行
	IF EXISTS(SELECT 1 FROM Speciment WHERE SendQCReportId=@NewSQCId )
	BEGIN
		SELECT @JCSP=CYSP,@CYFS=CYFS,@JYBZ=CYBZ FROM Speciment WHERE SendQCReportId=@NewSQCId
		 
	END 
	ELSE
    BEGIN
		SELECT  @JCSP=Product.CheckLevelCode -- AQL 检查水平
			, @JYBZ=AQLQualityStandard	-- AQL 检验标准
		 FROM dbo.Product   WHERE ProductId=@ProductId  
		 
	END 

	-- 如果检验标准与检查水平都未空,采用默认的参数
	IF ISNULL(@JCSP,'')='' OR ISNULL(@JYBZ,'')=''
	BEGIN
		SELECT @CYFS=@AJDPgm, @JCSP=@CKlevel ,@JYBZ=@aql
		PRINT('789')
	END 


	IF ISNULL(@JCSP,'')='' OR ISNULL(@JYBZ,'')=''-- OR ISNULL(@CYFS,'')=''
	BEGIN
		SELECT '-1' AS RetValue, '请设置产品的检验标准相关参数...' AS RetMsg
		RETURN -1
	END 

	DECLARE @SampleQty INT,		-- 样本大小
			@ACQty INT,			-- 允收数量
			@ReQty INT			-- 拒收数量
     
	DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	SELECT @SampleSizeCode=AQLSampleSizeCode FROM dbo.AQLSampleSize WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
		--AND LotRangeFromQty>=@SQC_Qty AND ISNULL(LotRangeToQty,1000000)<=@SQC_Qty
	
	-- 获取AQL样本数量
	SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		FROM dbo.AQLDetail WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ
	
	   
	 SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg,@SampleQty AS AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty 
	 RETURN -1
	   
END

GO
/****** Object:  StoredProcedure [dbo].[P_GetPrintData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_GetPrintData]
	 @YBBQ nvarchar(50),
	 @SendQCReportId CHAR(12), 					-- 送检单Id  
     @UserId CHAR(12)=''
AS
BEGIN
  DECLARE @CYFS NVARCHAR(10)='',
          @CYSP NVARCHAR(10),
          @CYBZ NVARCHAR(10),
          @CYBZ2 NVARCHAR(10),
          @CQty DECIMAL(18,4),
		  @YBSN  NVARCHAR(10),
		  @Describe  NVARCHAR(30)

  SELECT @CYFS=CYFS,@CYSP=CYSP,@CYBZ=CYBZ,@CYBZ2=CYBZ2,@CQty=CQty,@YBSN=YBSN,@Describe=Describe FROM Speciment WHERE  SendQCReportId=@SendQCReportId

  IF @CYFS=''
  BEGIN
        SELECT '-1' AS RetValue, '请先抽样,Unknown Errors...' AS RetMsg
		RETURN -1
  END	
  ELSE
  BEGIN
    IF @YBSN<>@YBBQ
	BEGIN
	    SELECT @CQty =ExtQty,@Describe=Describe2 FROM Speciment_ExtRecord WHERE  YBSN=@YBBQ
    END
  END
   

   DECLARE @SendDate NVARCHAR(50) ,
          @ProductShortName NVARCHAR(50),
		  @POName NVARCHAR(50),
		  @VendorName NVARCHAR(50), 
          @ProductDescription NVARCHAR(10)  
 
  SELECT @ProductShortName=ProductShortName,@ProductDescription=ProductDescription,@SendDate=SendDate,@POName=POName,@VendorName=VendorName
  FROM (
  SELECT   dbo.SendQCReport.SendQCReportId, dbo.PO.POName, dbo.SendQCReport.SendQCReportNumber, 
                dbo.Vendor.VendorName, dbo.Product.ProductId, ISNULL(dbo.ProductRoot.ProductShortName, 
                dbo.ProductRoot.ProductName) AS ProductShortName, dbo.Product.ProductDescription, dbo.SendQCReport.SendQCQty, 
                dbo.SendQCReport.SendDate, dbo.SendQCReport.QCResult, dbo.Speciment.IsCYDone
   FROM      dbo.SendQCReport LEFT OUTER JOIN
                dbo.VendorDeliveryItem ON 
                dbo.VendorDeliveryItem.VendorDeliveryItemId = dbo.SendQCReport.VendorDeliveryItemId LEFT OUTER JOIN
                dbo.VendorDelivery ON 
                dbo.VendorDelivery.VendorDeliveryId = dbo.VendorDeliveryItem.VendorDeliveryId LEFT OUTER JOIN
                dbo.PO ON dbo.PO.POId = dbo.VendorDeliveryItem.POId LEFT OUTER JOIN
                dbo.Vendor ON dbo.Vendor.VendorId = dbo.VendorDelivery.VendorId LEFT OUTER JOIN
                dbo.Product ON dbo.Product.ProductId = dbo.SendQCReport.ProductId LEFT OUTER JOIN
                dbo.ProductRoot ON dbo.ProductRoot.ProductRootId = dbo.Product.ProductRootId LEFT OUTER JOIN
                dbo.Speciment ON dbo.Speciment.SendQCReportId = dbo.SendQCReport.SendQCReportId
   )A

    
  SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg ,  @ProductShortName AS ProductShortName,@ProductDescription AS ProductDescribe,@SendDate AS SendDate
         ,@CYFS AS CYFS,@CYSP AS CYSP,@CYBZ AS AQL1,@CYBZ2 AS  AQL2,@CQty AS SampleSize,@YBBQ AS YBSN,@Describe AS Describe,@POName AS POName
	 	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_GetRawMaterialIQCCheckInfo]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_GetRawMaterialIQCCheckInfo]
	 @SendQCReportId char(12)
AS
BEGIN
	 SELECT '验证提交成功...' AS Result_Msg  ,0 AS RetValue ,RawMaterialIQCCheckId ,CreateDate ,FactoryId ,XMLData   ,CheckResult  ,SQCheckResultId  ,SendQCReportId ,CheckNO,
	         ScanSN,Qty,IsCheck

      FROM dbo.RawMaterialIQCCheck
	 WHERE SendQCReportId=@SendQCReportId

END

GO
/****** Object:  StoredProcedure [dbo].[P_GetSQCCheckData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_GetSQCCheckData]
	 @SendQCReportId CHAR(12) 			-- 送检单Id
AS
BEGIN
	 	SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg , A.SendQCReportId,	A.POName,A.SendQCReportNumber,A.VendorName,A.ProductId,A.ProductShortName
	           ,A.ProductDescription,A.SendQCQty,A.SendDate,A.QCResult,B.SpecimentId ,B.CYFS,B.CYSP,B.CYBZ,B.CQty,B.YBSN   
		       ,C.DefaultPath,C.UV,C.UV_Images,C.VL,C.VL_Images,C.IR
               ,C.IR_Images,C.HD_ZH,C.HD_ZH_Images,C.HD_BLH,C.HD_BLH_Images	
               ,C.HD_ABJH,C.HD_ABJH_Images,C.YD_YD,C.YD_YD_Images,C.SDJ_CS,C.SDJ_CS_Images
               ,C.SDJ_NM,C.SDJ_NM_Images,C.SDJ_MCH,C.SDJ_MCH_Images,C.ZWY_ZM,C.ZWY_ZM_Images,C.ZWY_BM,C.ZWY_BM_Images
			   ,C.GHXG_GQLX,C.GHXG_GQLX_Images,C.GHXG_WB,C.GHXG_WB_Images,C.ST_ST,C.ST_ST_Images
			   ,P_Left,P_Right,P_UP,P_Down
               ,C.Size_Long,C.Size_Width,C.Size_Height,C.CheckResult,C.CheckType

			   ,C.HD_BHC,C.HD_BHC_Images   ,C.HD_SYC,C.HD_SYC_Images ,C.HD_SYC,C.HD_SYC_Images
			   ,C.HD_BHC_Images,C.HD_BHC,C.HD_SYC_Images,C.HD_SYC,C.HD_LCM_Images,C.HD_LCM
			   ,C.NM_NM_Images,C.NM_NM,C.CB_CB_Images,C.CB_CB,C.CNL_CNL_Images,C.CNL_CNL
			   ,C.BGCS_BGCS_Images,C.BGCS_BGCS,C.GDWBC_SKBH_Images,C.GDWBC_SKBH,C.GDWBC_SKLX_Images,C.GDWBC_SKLX
			   ,C.GDWBC_SKSY_Images,C.GDWBC_SKSY,C.ST_D65CH_Images,C.ST_D65CH
			   ,C.ST_TL84CH_Images,C.ST_TL84CH,C.ST_FACH_Images,C.ST_FACH,C.ST_CWFCH_Images,C.ST_CWFCH
			   ,C.ST_QB_Images,C.ST_QB,C.ST_PQSJ_Images,C.ST_PQSJ
	  FROM dbo.V_SendQCReport A 
	  LEFT JOIN Speciment B ON A.SendQCReportId=B.SendQCReportId
	  LEFT JOIN SQCheckResult C ON A.SendQCReportId=C.SendQCReportId
 	  WHERE A.SendQCReportId=@SendQCReportId
END

GO
/****** Object:  StoredProcedure [dbo].[P_GetSQCData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
-- =============================================
-- Author:		John Luo
-- Create date: 2018-06-11
-- Description:	获取送检单信息
-- =============================================
CREATE   PROCEDURE [dbo].[P_GetSQCData] 
@SQCId CHAR(12) 			-- 送检单Id
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  
	IF NOT EXISTS(SELECT 1 FROM dbo.V_SendQCReport WHERE SendQCReportId=@SQCId) 
	BEGIN 
		SELECT '-1' AS RetValue, '获取检验批次信息失败,Unknown Errors...' AS RetMsg
		RETURN -1
	END 
	 
	DECLARE @SendQCReportId CHAR(12),
		@POName NVARCHAR(30) ,
		@VendorName NVARCHAR(30),
		@ProductId CHAR(12),
		@ProductShortName NVARCHAR(50),
		@ProductDescription NVARCHAR(300),
		@SendQCQty INT 


	SELECT @SendQCReportId=SendQCReportId,@POName=POName,@VendorName=VendorName,@ProductId=ProductId,@ProductShortName=ProductShortName,
		@ProductDescription=ProductDescription, @SendQCQty=CAST(SendQCQty AS INT) 
	  FROM dbo.V_SendQCReport
	  WHERE SendQCReportId=@SQCId
	 
	DECLARE  @IsCYDone BIT ,			-- 是否已经检验
			@CY_Qty INT
	
	--根据送检单判断产品类型
	--
	DECLARE	@SQC_Qty DECIMAL(18,4),		-- 送检数量
			@ProductType nvarchar(10)=''  

    SELECT  @SQC_Qty=SendQCQty,@ProductId=SendQCReport.ProductId, @ProductType = (Select ProductType from ProductTypeName where LEFT(ProductRoot.ProductName,1) = ProductTypeName.ProductTypeShortName)
	FROM	dbo.SendQCReport Left Join Product 
			On SendQCReport.ProductId =  Product.ProductId Left Join ProductRoot
			On Product.ProductRootId = ProductRoot.ProductRootId
	WHERE SendQCReportId=@SQCId

	
	--
	--判断产品类型是否在类型表中
	--
	IF (@ProductType=null)
	begin
		SELECT '-1' AS RetValue, '请设置产品默认检验标准...' AS RetMsg
		return -1
	end

	DECLARE	@JCSP NVARCHAR(20)='',		-- 检查水平
			@JYBZ NVARCHAR(20)='',		-- 检验标准
			@JYBZ2 NVARCHAR(20)='',		-- 严格检验标准
			@CYFS NVARCHAR(20)=''		-- 抽样方式
	DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	DECLARE @SampleQty INT,		-- 样本大小
			@ACQty INT,			-- 允收数量
			@ReQty INT,			-- 拒收数量
			@ACQty2 INT,		-- 允收数量
			@ReQty2 INT			-- 拒收数量

			
 
   -- 判断是否存在抽样数据,否则使用产品默认参数
	IF EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SQCId )
	BEGIN
		SELECT  @CYFS=  CYFS,@JCSP= CYSP,@JYBZ= CYBZ, @CY_Qty=CQty, @IsCYDone=IsCYDone,@JYBZ2=ISNULL(CYBZ2,''),@SampleQty=FCQty  FROM Speciment WHERE SendQCReportId=@SQCId   
		 
	END 	
	ELSE
	BEGIN
	--
	--分支判断，如果是辅料，进入两个检查标准的分支，如果不是，进入一个检查标准的分支
	--

	--
	--分支1
	--
	If (@ProductType='3')
	Begin
		--
		--获取下面三项数据
		--
		--DECLARE	@JCSP NVARCHAR(20)='',		-- 检查水平
		--		@JYBZ NVARCHAR(20)='',		-- 检验标准
		--		@JYBZ2 NVARCHAR(20)=''		-- 严格检验标准
     
		IF (EXISTS(SELECT 1 From IQCCheckDefaultAQL Where IQCCheckDefaultAQL.ProductId = @ProductId))
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1, @JYBZ2=AQL2
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductId = @ProductId
		End
		Else
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1, @JYBZ2=AQL2
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductType = @ProductType AND IQCCheckDefaultAQL.ProductId=''
		End
	
		--
		--判断数据是否获取成功
		--
		IF (@JCSP = '' or @JYBZ='' or @JYBZ2='')
		BEGIN
			SELECT @JCSP asJCSP, @JYBZ asJYBZ, @JYBZ2 as JYBZ2
			SELECT '-1' AS RetValue, '辅料数据获取失败...' AS RetMsg
			return -1
		END
		 
	End
	--
	--分支2
	--
	Else
	Begin 
     
		IF (EXISTS(SELECT 1 From IQCCheckDefaultAQL Where IQCCheckDefaultAQL.ProductId = @ProductId))
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductId = @ProductId
		End
		Else
		Begin
			Select @JCSP = CheckLevel, @JYBZ=AQL1
			From IQCCheckDefaultAQL
			Where IQCCheckDefaultAQL.ProductType = @ProductType AND IQCCheckDefaultAQL.ProductId=''
		End
	
		--
		--判断数据是否获取成功
		--
		IF (@JCSP = '' or @JYBZ='' )
		BEGIN
			SELECT '-1' AS RetValue, '数据获取失败...' AS RetMsg
			return -1
		END
 
		-- 获取AQL样本数量
		--SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		--FROM dbo.AQLDetail 
		--WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ

		--SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg,@JCSP AS CheckLevel, @JYBZ AS AQL1, '--' AS AQL2, @SampleQty AS AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty, '--' AS ACQty2,'--' AS ReQty2 
		--RETURN 0
	End
	 -- SELECT @SampleSizeCode=AQLSampleSizeCode  -- 样本大小代码 
		--FROM dbo.AQLSampleSize 
		--WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
   
  --     SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
	 --  FROM dbo.AQLDetail 
	 --  WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ
    
  END
    	SELECT @SampleSizeCode=AQLSampleSizeCode  -- 样本大小代码 
		FROM dbo.AQLSampleSize 
		WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
		 
       SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
	   FROM dbo.AQLDetail 
	   WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ
	      
	   IF  isnull(@JYBZ2,'')<>''
	   BEGIN 
		SELECT @ACQty2=ACQty,@ReQty2=ReQty 
		FROM dbo.AQLDetail 
		WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ2
	   END
	   ELSE
	  -- BEGIN 
	  --   SET  @ACQty2='--'
		 --SET  @ReQty2='--' 
	  -- END
	   
	-- 获取样本累计抽取数量
	DECLARE @T_TQty INT 

	SELECT @T_TQty=CQty FROM dbo.Speciment WHERE SendQCReportId=@SQCId

	SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg , @SQCId AS SendQCReportId,
		@POName AS POName,@VendorName AS VendorName,@ProductId AS ProductId,
		@ProductDescription AS ProductDescription, @SendQCQty AS SendQCQty,@ProductShortName AS ProductShortName,
		@CYFS AS CYFS ,@JCSP AS JYSP ,@JYBZ AS JYBZ ,  @SampleQty AS  JY_QTY, @IsCYDone AS IsCYDone,@T_TQty AS  TCQ_Qty,@JYBZ2 AS JYBZ2,@ACQty AS ACQty,@ReQty AS ReQty, @ACQty2 AS ACQty2,@ReQty2 AS ReQty2 

	RETURN -1
	   
END
GO
/****** Object:  StoredProcedure [dbo].[P_GetSQIQCCheckData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_GetSQIQCCheckData]
	 @SendQCReportId CHAR(12) 			-- 送检单Id
AS
BEGIN
	  SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg , A.SendQCReportId,	A.POName,A.SendQCReportNumber,A.VendorName,A.ProductId,A.ProductShortName
	           ,A.ProductDescription,A.SendQCQty,A.SendDate,A.QCResult,B.SpecimentId ,B.CYFS,B.CYSP,B.CYBZ,B.CQty,B.YBSN ,B.CYBZ2,B.FCQty  
		       ,C.DefaultPath,C.CheckResult,C.CheckType ,C.XMLData,C.AcceptQty,c.NGQty
	  FROM dbo.V_SendQCReport A 
	  LEFT JOIN Speciment B ON A.SendQCReportId=B.SendQCReportId
	  LEFT JOIN SQCheckResult C ON A.SendQCReportId=C.SendQCReportId
 	  WHERE A.SendQCReportId=@SendQCReportId
END

GO
/****** Object:  StoredProcedure [dbo].[P_GetSQRMCheckResultDetailData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_GetSQRMCheckResultDetailData]
 @SendQCReportId nvarchar(50),
 @RawMaterialIQCCheckId char(12)
AS
BEGIN
	 
 
	 SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg , A.SendQCReportId,	A.POName,A.SendQCReportNumber,A.VendorName,A.ProductId,A.ProductShortName
	           ,A.ProductDescription,A.SendQCQty,A.SendDate,A.QCResult,B.SpecimentId ,B.CYFS,B.CYSP,B.CYBZ,B.CQty,B.YBSN   
		       ,C.RawMaterialIQCCheckId ,C.CreateDate ,C.FactoryId,C.XMLData
               ,C.CheckResult ,C.SQCheckResultId,C.SendQCReportId ,C.CheckNO,C.ScanSN,C.Qty,C.IsCheck
	  FROM dbo.V_SendQCReport A 
	  LEFT JOIN Speciment B ON A.SendQCReportId=B.SendQCReportId
	  LEFT JOIN RawMaterialIQCCheck C ON A.SendQCReportId=C.SendQCReportId
 	  WHERE A.SendQCReportId=@SendQCReportId and C.RawMaterialIQCCheckId =@RawMaterialIQCCheckId
END

GO
/****** Object:  StoredProcedure [dbo].[P_PrintSQCLabels]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
-- =============================================
-- Author:		John Luo
-- Create date: 2018-06-12
-- Description:	扫描打印物料标签
-- =============================================
CREATE   PROCEDURE  [dbo].[P_PrintSQCLabels]  
@SQCId CHAR(12), 					-- 送检单Id 
@Describe NVARCHAR(20)='',					-- 备注
--@JCSP NVARCHAR(20),					-- 检查水平
--@JYBZ NVARCHAR(20),					-- 检验标准
@UserId CHAR(12)='',				-- 用户内码
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @SPecMId INT ,				-- 样本记录主表Id
			@T_YBSN NVARCHAR(30) ,		-- 样本标签
			@SQC_Qty DECIMAL(18,4),		-- 送检数量
			@SCI_Qty  DECIMAL(18,4)
	SELECT @SPecMId=SpecimentId,@T_YBSN=YBSN,@SCI_Qty=CQty FROM dbo.Speciment WHERE SendQCReportId=@SQCId
	IF ISNULL(@SPecMId,0)<=0
	BEGIN
		SELECT @Result_Msg='抽样数据不存在,不能打印样本标签...',@Return=-1
		RETURN -1 
	END
	

	DECLARE @VendorShortNum NVARCHAR(20)=''
	SELECT      @VendorShortNum=dbo.Vendor.VendorShortNum  
      FROM      dbo.SendQCReport LEFT OUTER JOIN
                dbo.VendorDeliveryItem ON 
                dbo.VendorDeliveryItem.VendorDeliveryItemId = dbo.SendQCReport.VendorDeliveryItemId LEFT OUTER JOIN
                dbo.VendorDelivery ON 
                dbo.VendorDelivery.VendorDeliveryId = dbo.VendorDeliveryItem.VendorDeliveryId LEFT OUTER JOIN
                dbo.PO ON dbo.PO.POId = dbo.VendorDeliveryItem.POId LEFT OUTER JOIN
                dbo.Vendor ON dbo.Vendor.VendorId = dbo.VendorDelivery.VendorId  
     WHERE  dbo.SendQCReport.SendQCReportId=@SQCId   
	    

	-- 生成样本标签
	DECLARE @T_NewYBSN NVARCHAR(30)='',@T_Str NVARCHAR(20)

	--获取与该送检单号同一个同一天的送检单
	SELECT TOP(1) @T_NewYBSN=YBSN 
	  FROM  Speciment 
	 WHERE DATEDIFF(DAY,GETDATE(),CreateDate )=0  AND  SendQCReportId IN
	      ( SELECT  dbo.SendQCReport.SendQCReportId  
              FROM    dbo.SendQCReport LEFT OUTER JOIN
                      dbo.VendorDeliveryItem ON 
                      dbo.VendorDeliveryItem.VendorDeliveryItemId = dbo.SendQCReport.VendorDeliveryItemId LEFT OUTER JOIN
                      dbo.VendorDelivery ON 
                      dbo.VendorDelivery.VendorDeliveryId = dbo.VendorDeliveryItem.VendorDeliveryId LEFT OUTER JOIN
                      dbo.PO ON dbo.PO.POId = dbo.VendorDeliveryItem.POId LEFT OUTER JOIN
                      dbo.Vendor ON dbo.Vendor.VendorId = dbo.VendorDelivery.VendorId  
              WHERE   DATEDIFF(DAY,GETDATE(),dbo.SendQCReport.SendDate )=0
                      AND   dbo.Vendor.VendorShortNum=@VendorShortNum)

	IF ISNULL(@T_NewYBSN,'')=''
	BEGIN
		SET @T_NewYBSN=@VendorShortNum+CONVERT(CHAR(6),GETDATE(),12)+'0001N' 
	END 
	ELSE
    BEGIN
		SET @T_NewYBSN=@VendorShortNum+CONVERT(CHAR(6),GETDATE(),12)+ RIGHT(  '000'+ RTRIM(CAST( CAST(  RIGHT(@T_NewYBSN,4) AS INT)+1  AS CHAR(4)) ),4)+'N'
	END 

	     
	IF EXISTS(SELECT 1 FROM Speciment WHERE SendQCReportId=@SQCId AND ISNULL(YBSN,'')<>'' )
	BEGIN

	    --检验是否存在加抽 未打印标签
		IF EXISTS(SELECT 1 FROM Speciment_ExtRecord WHERE SendQCReportId=@SQCId AND ISNULL(YBSN,'')='' )
		BEGIN
		  SELECT TOP(1) @T_NewYBSN=YBSN 
		  FROM  Speciment_ExtRecord 
		  WHERE DATEDIFF(DAY,GETDATE(),CreateDate )=0  ( 
		      SELECT  dbo.SendQCReport.SendQCReportId  
              FROM    dbo.SendQCReport LEFT OUTER JOIN
                      dbo.VendorDeliveryItem ON 
                      dbo.VendorDeliveryItem.VendorDeliveryItemId = dbo.SendQCReport.VendorDeliveryItemId LEFT OUTER JOIN
                      dbo.VendorDelivery ON 
                      dbo.VendorDelivery.VendorDeliveryId = dbo.VendorDeliveryItem.VendorDeliveryId LEFT OUTER JOIN
                      dbo.PO ON dbo.PO.POId = dbo.VendorDeliveryItem.POId LEFT OUTER JOIN
                      dbo.Vendor ON dbo.Vendor.VendorId = dbo.VendorDelivery.VendorId  
              WHERE   DATEDIFF(DAY,GETDATE(),dbo.SendQCReport.SendDate )=0
                      AND   dbo.Vendor.VendorShortNum=@VendorShortNum)

		  IF ISNULL(@T_NewYBSN,'')=''
       	  BEGIN
		    SET @T_NewYBSN=@VendorShortNum+CONVERT(CHAR(6),GETDATE(),12)+'0001' +'E'
	      END 
	      ELSE
          BEGIN
		     SET @T_NewYBSN=@VendorShortNum+CONVERT(CHAR(6),GETDATE(),12)+ RIGHT(  '000'+ RTRIM(CAST( CAST(  RIGHT(@T_NewYBSN,4) AS INT)+1  AS CHAR(4)) ),4)+'E'
	      END 
		   
		UPDATE Speciment_ExtRecord SET YBSN=@T_NewYBSN,Describe2=@Describe WHERE SpecimentId=@SPecMId 
	     SELECT @Result_Msg='数据抽取成功...',@Return=0
	     RETURN 0
		END
		SELECT @Result_Msg='当前检验批已生成样本标签,不能再次生成...',@Return=-1
		RETURN -1
	END 
	 
	-- 根据检验参数获取检验标准,然后计算抽样数量是否达到检验标准  
	--DECLARE @SampleQty INT,		-- 样本大小
	--	@ACQty INT,			-- 允收数量
	--	@ReQty INT			-- 拒收数量
     
	--DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	--SELECT @SampleSizeCode=AQLSampleSizeCode FROM dbo.AQLSampleSize WHERE CheckLevelCode=@JCSP  AND 
	--	( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
	  
	---- 获取AQL样本数量
	--SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
	--	FROM dbo.AQLDetail WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ
	
	--IF ISNULL(@SCI_Qty,-1)<ISNULL(@SampleQty,0)
	--BEGIN
	--	SELECT @Result_Msg='抽样数量不能小于样本需求数量...',@Return=-1
	--	RETURN -1  
	--END 
	
	

	UPDATE Speciment SET YBSN=@T_NewYBSN,Describe=@Describe WHERE SpecimentId=@SPecMId

	SELECT @Result_Msg=@T_NewYBSN,@Return=0
	RETURN 0
	   
END

GO
/****** Object:  StoredProcedure [dbo].[P_RawMaterialIQCCheckAddSubmit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_RawMaterialIQCCheckAddSubmit]
	  
      @SendQCReportId char(12),   
	  @ScanSN NVARCHAR(50),   
	  @QTY decimal(18,4),   
	  @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
      @Return INT	OUTPUT					-- 返回值
AS
BEGIN
     --验证送检单是否存在
	  declare @SQ_CheckResult int  
	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 

   --验证送检单是否已经打印样本并提交抽样
  IF NOT EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='还没有生成样本标签,不能检验...',@Return=-1
		RETURN -1
	END  

	
   IF EXISTS( SELECT  1 FROM dbo.RawMaterialIQCCheck WHERE SendQCReportId=@SendQCReportId AND ScanSN=@ScanSN )
		    BEGIN
				SELECT @Result_Msg='已存在扫描项，请不要重复扫描',@Return=-1
		        RETURN -1
	END

	 --头部数据是否已经创建,如果没有则自动创建 
	 declare  @SQCheckResultId char(12)
	 SELECT  @SQCheckResultId=SendQCReportResultId FROM dbo.SQCheckResult WHERE SendQCReportId=@SendQCReportId

   IF ISNULL(@SQCheckResultId,'')=''
	  BEGIN 
	   SELECT @SQCheckResultId=(substring(CONVERT([char](36),newid(),(0)),(1),(12)))

         INSERT INTO dbo.SQCheckResult
           (SendQCReportResultId,SendQCReportId ,UserId,FactoryId,CreateDate,DefaultPath ,CheckType,CheckResult )
          VALUES
           (@SQCheckResultId, @SendQCReportId    ,'' ,''   ,GETDATE() ,'upload'   ,2,0)
	  END
	ELSE
	   BEGIN
	        --如果已经提交则不可以再操作，CheckResult>0
			  IF EXISTS( SELECT  1 FROM dbo.SQCheckResult WHERE SendQCReportResultId=@SQCheckResultId AND CheckResult>0 )
			     BEGIN
				     SELECT @Result_Msg='数据已经提交不能检验',@Return=-1
		             RETURN -1
				 END
	   END 
	   

    IF (@Qty<=0)
    BEGIN
		  SELECT @Result_Msg='扫描数量必须大于0',@Return=-1
		  RETURN -1
	 END

	 declare @CheckNO int
	 SELECT @CheckNO=COUNT(1)+1 from DBO.RawMaterialIQCCheck where SQCheckResultId=@SQCheckResultId

	    INSERT INTO [dbo].[RawMaterialIQCCheck]
           (  FactoryId ,CheckResult,SQCheckResultId,SendQCReportId,CheckNO,ScanSN,Qty,IsCheck)
          VALUES
           (   '',0,@SQCheckResultId,@SendQCReportId,@CheckNO,@ScanSN,@Qty,0)
		 SELECT @Result_Msg='提交成功...',@Return=0
	    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_RawMaterialIQCCheckDelete]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_RawMaterialIQCCheckDelete]
	@RawMaterialIQCCheckId char(12),
    @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
    @Return INT	OUTPUT					-- 返回值
AS
BEGIN
	 --是否已经提交
	   declare @SendQCReportResultId char(12)
	   SELECT  @SendQCReportResultId=SendQCReportId FROM DBO.RawMaterialIQCCheck WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId
	    IF @SendQCReportResultId<>''
		  BEGIN
		      IF EXISTS( SELECT  1 FROM dbo.SQCheckResult WHERE SendQCReportResultId=@SendQCReportResultId AND CheckResult>0 )
			     BEGIN
				     SELECT @Result_Msg='数据已经提交不能修改',@Return=-1
		             RETURN -1
				 END 
		  END
		ELSE 
		   BEGIN
		       SELECT @Result_Msg='数据不存在',@Return=-1
		             RETURN -1
		   END
	   IF EXISTS(	   SELECT 1 FROM [dbo].[RawMaterialIQCCheck] WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId AND  IsCheck=1)
	      BEGIN
				     SELECT @Result_Msg='数据已经检验，不能删除',@Return=-1
		             RETURN -1
				 END 

	   DELETE FROM [dbo].[RawMaterialIQCCheck] WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId
	   SELECT @Result_Msg='删除成功',@Return=0
       RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_RawMaterialIQCCheckSubmit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_RawMaterialIQCCheckSubmit]
      @RawMaterialIQCCheckId char(12),
      @SendQCReportId char(12),
	  @CheckResult int,
	  @XMLData nvarchar(max), 
	  @FactoryId char(12),
	  @DefaultPath nvarchar(100),
	  @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
      @Return INT	OUTPUT					-- 返回值
AS
BEGIN
     --验证送检单是否存在
	  declare @SQ_CheckResult int  
	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 

   --验证送检单是否已经打印样本并提交抽样
  IF NOT EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='还没有生成样本标签,不能检验...',@Return=-1
		RETURN -1
	END  

	 --头部数据是否已经创建,如果没有则自动创建 
	 declare  @SQCheckResultId char(12)
	 SELECT  @SQCheckResultId=SendQCReportResultId FROM dbo.SQCheckResult WHERE SendQCReportId=@SendQCReportId

   IF ISNULL(@SQCheckResultId,'')=''
	  BEGIN 
	   SELECT @Result_Msg='检验单不存在...',@Return=-1
		RETURN -1
	  END
	ELSE
	   BEGIN
	        --如果已经提交则不可以再操作，CheckResult>0
			  IF EXISTS( SELECT  1 FROM dbo.SQCheckResult WHERE SendQCReportResultId=@SQCheckResultId AND CheckResult>0 )
			     BEGIN
				     SELECT @Result_Msg='数据已经提交不能修改',@Return=-1
		             RETURN -1
				 END
	   END
	   IF EXISTS( SELECT  1 FROM dbo.RawMaterialIQCCheck WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId AND IsCheck=1 )
			     BEGIN
				     SELECT @Result_Msg='已经检验过，不能重复检验',@Return=-1
		             RETURN -1
				 END
 
 
	 declare @CheckNO int
	 SELECT @CheckNO=COUNT(1)+1 from DBO.RawMaterialIQCCheck where SQCheckResultId=@SQCheckResultId

	 IF NOT EXISTS(SELECT  1 FROM DBO.RawMaterialIQCCheck WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId)
	  BEGIN
	     --INSERT INTO [dbo].[RawMaterialIQCCheck]
      --     (  FactoryId ,XMLData,CheckResult,SQCheckResultId,SendQCReportId,CheckNO)
      --    VALUES
      --     (   '',@XMLData,@CheckResult,@SQCheckResultId,@SendQCReportId,@CheckNO)
	  	 SELECT @Result_Msg='提交失败,找不到行数据',@Return=-1
	     RETURN -1
	   END
	   ELSE
	     BEGIN
		    UPDATE RawMaterialIQCCheck SET XMLData=@XMLData,CheckResult=@CheckResult,IsCheck=1 WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId
		 END

		 SELECT @Result_Msg='提交成功...',@Return=0
	    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_RMResultDataUpload]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[P_RMResultDataUpload]
    @SendQCReportId nvarchar(50),
    @XMLData nvarchar(max), 
	@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
    @Return INT	OUTPUT					-- 返回值
AS
BEGIN 
	--判断是否存在送检单
		  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 

	--判断是否重复提交
	DECLARE @CheckResult INT
	SELECT @CheckResult=CheckResult FROM dbo.SQCheckResult  WHERE SendQCReportId=@SendQCReportId AND CheckResult=1 
		  IF ISNULL(@CheckResult,-1)=-1
	 BEGIN
		SELECT @Result_Msg='检验单不存在',@Return=-1
		RETURN -1
	END 
	  IF ISNULL(@CheckResult,-1)<>0
	 BEGIN
		SELECT @Result_Msg='检验单已经提交过,请不要重复提交',@Return=-1
		RETURN -1
	END 

	  IF NOT EXISTS(SELECT 1 FROM dbo.RawMaterialIQCCheck  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='最少添加一条检验记录',@Return=-1
		RETURN -1
	END 
	
	--变更状态
	UPDATE dbo.SQCheckResult SET CheckResult=1  WHERE  SendQCReportId=@SendQCReportId 
	 SELECT @Result_Msg='提交成功...',@Return=0
	    RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_RMSQCheckResult_Submit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_RMSQCheckResult_Submit]
	-- Add the parameters for the stored procedure here
   
	@SendQCReportId char(12)  ,
	--@ResourceId char(12)  ,
	
	@FactoryId char(12)  , 
	@DefaultPath nvarchar(100)  ,
	@UV nvarchar(100)  ,
	@UV_Images nvarchar(200)  ,
	@VL nvarchar(100)  ,
	@VL_Images nvarchar(200)  ,
	@IR nvarchar(100)  ,
	@IR_Images nvarchar(200)  ,
	@HD_ZH nvarchar(100)  ,
	@HD_ZH_Images nvarchar(200)  ,
	 
	@YD_YD  decimal(18, 4),
	@YD_YD_Images nvarchar(200)  , 
	@HD_BHC  decimal(18, 4)  ,
	@HD_BHC_Images  nvarchar(200)  ,
	@HD_SYC  decimal(18, 4) ,
	@HD_SYC_Images   nvarchar(200)  ,
	@HD_LCM  decimal(18, 4) ,
	@HD_LCM_Images  nvarchar(1200)  ,
	@NM_NM  nvarchar(100)   ,
	@NM_NM_Images nvarchar(200)  ,
	@CB_CB  nvarchar(100)  ,
	@CB_CB_Images  nvarchar(200)  ,
	@CNL_CNL  nvarchar(100)  ,
	@CNL_CNL_Images  nvarchar(200)  ,
	@BGCS_BGCS  nvarchar(100)  ,
	@BGCS_BGCS_Images  nvarchar(200)  ,

	@GDWBC_SKBH  nvarchar(100)  ,
	@GDWBC_SKBH_Images  nvarchar(200)  ,

	@GDWBC_SKLX  nvarchar(100)  ,
	@GDWBC_SKLX_Images  nvarchar(200)  ,
	@GDWBC_SKSY  nvarchar(100)  ,
	@GDWBC_SKSY_Images  nvarchar(200)  ,
	@ST_D65CH  nvarchar(100)  ,
	@ST_D65CH_Images  nvarchar(200)  ,
	@ST_TL84CH  nvarchar(100)  ,
	@ST_TL84CH_Images  nvarchar(200)  ,
	@ST_FACH  nvarchar(100)  ,
	@ST_FACH_Images  nvarchar(200)  ,
	@ST_CWFCH  nvarchar(100)  ,
	@ST_CWFCH_Images  nvarchar(200)  ,
	@ST_QB  nvarchar(100)  ,
	@ST_QB_Images  nvarchar(200)  ,
	@ST_PQSJ  nvarchar(100)  ,
	@ST_PQSJ_Images  nvarchar(200)  ,
	@CheckResult int  ,
 

@UserId CHAR(12)='',				-- 用户内码
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 declare @SQ_CheckResult int 

	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 
  IF NOT EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='还没有生成样本标签,不能检验...',@Return=-1
		RETURN -1
	END 

	 SELECT @SQ_CheckResult=QCResult FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId
   IF @SQ_CheckResult<>0
	 BEGIN
	    SELECT @Result_Msg='已经检验过,不能重复检验',@Return=-1
		RETURN -1
	 END

INSERT INTO dbo.SQCheckResult
           (  SendQCReportId 
           ,UserId
           ,FactoryId 
           ,DefaultPath
           ,UV
           ,UV_Images
           ,VL
           ,VL_Images
           ,IR
           ,IR_Images
           ,HD_ZH
           ,HD_ZH_Images 
           ,YD_YD
           ,YD_YD_Images
          
           ,CheckResult
           ,HD_BHC
           ,HD_BHC_Images
           ,CheckType
           ,HD_SYC
           ,HD_SYC_Images
           ,HD_LCM
           ,HD_LCM_Images
       
           ,NM_NM_Images
           ,NM_NM
           ,CB_CB_Images
           ,CB_CB
           ,CNL_CNL_Images
           ,CNL_CNL
           ,BGCS_BGCS_Images
           ,BGCS_BGCS
           ,GDWBC_SKBH_Images
           ,GDWBC_SKBH
           ,GDWBC_SKLX_Images
           ,GDWBC_SKLX
           ,GDWBC_SKSY_Images
           ,GDWBC_SKSY
           ,ST_D65CH_Images
           ,ST_D65CH
           ,ST_TL84CH_Images
           ,ST_TL84CH
           ,ST_FACH_Images
           ,ST_FACH
           ,ST_CWFCH_Images
           ,ST_CWFCH
           ,ST_QB_Images
           ,ST_QB
           ,ST_PQSJ_Images
           ,ST_PQSJ)
     VALUES
           ( 
            @SendQCReportId
           ,@UserId 
           ,@FactoryId 
           ,@DefaultPath
           ,@UV
           ,@UV_Images 
           ,@VL 
           ,@VL_Images 
           ,@IR 
           ,@IR_Images 
           ,@HD_ZH 
           ,@HD_ZH_Images 
           
           ,@YD_YD 
           ,@YD_YD_Images 
           
           ,@CheckResult 
           ,@HD_BHC 
           ,@HD_BHC_Images 
           ,2
           ,@HD_SYC 
           ,@HD_SYC_Images 
           ,@HD_LCM 
           ,@HD_LCM_Images 
           
           ,@NM_NM_Images 
           ,@NM_NM 
           ,@CB_CB_Images 
           ,@CB_CB 
           ,@CNL_CNL_Images 
           ,@CNL_CNL 
           ,@BGCS_BGCS_Images 
           ,@BGCS_BGCS 
           ,@GDWBC_SKBH_Images 
           ,@GDWBC_SKBH 
           ,@GDWBC_SKLX_Images 
           ,@GDWBC_SKLX 
           ,@GDWBC_SKSY_Images 
           ,@GDWBC_SKSY 
           ,@ST_D65CH_Images 
           ,@ST_D65CH 
           ,@ST_TL84CH_Images 
           ,@ST_TL84CH 
           ,@ST_FACH_Images 
           ,@ST_FACH 
           ,@ST_CWFCH_Images 
           ,@ST_CWFCH 
           ,@ST_QB_Images 
           ,@ST_QB 
           ,@ST_PQSJ_Images 
           ,@ST_PQSJ )
 
    --更新送检单检验状态 
	--UPDATE dbo.SendQCReport SET QCResult=@CheckResult WHERE SendQCReportId=@SendQCReportId
	 
 	SELECT @Result_Msg='验证提交成功...',@Return=0
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_SelAQLData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
-- =============================================
-- Author:		John Luo
-- Create date: 2018-06-08
-- Description:	获取AQL样本数据
-- =============================================
CREATE  PROCEDURE [dbo].[P_SelAQLData] 
@SQCId CHAR(12),			-- 送检单Id
@CKlevel varchar(20)='',	-- 检查水平  ('S-1','S-2','S-3','S-4','I','II','III')
@AJDPgm VARCHAR(10)=1,				-- 抽样方案：0放宽，1正常，2加严，3免检
@aql VARCHAR(10)=1				-- 合格质量水平  

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQC_Qty DECIMAL(18,4),		-- 送检数量
			@NewSQCId CHAR(12),
			@ProductId CHAR(12)
    SELECT @NewSQCId=SendQCReportId, @SQC_Qty=SendQCQty,@ProductId=ProductId FROM dbo.SendQCReport WHERE SendQCReportId=@SQCId


	DECLARE @CYFS NVARCHAR(20),		--抽方式
			@JCSP NVARCHAR(20),		-- 检查水平
			@JYBZ NVARCHAR(20)		-- 检验标准


	SELECT @CYFS=@AJDPgm, @JCSP=@CKlevel ,@JYBZ=@aql


	IF ISNULL(@JCSP,'')='' OR ISNULL(@JYBZ,'')=''-- OR ISNULL(@CYFS,'')=''
	BEGIN
		SELECT '-1' AS RetValue, '请设置产品的检验标准相关参数...' AS RetMsg
		RETURN -1
	END 
	IF NOT EXISTS(SELECT 1 FROM AQLSampleSize WHERE CheckLevelCode=@JCSP)
	BEGIN
		SELECT '-1' AS RetValue, '检查谁设置错误...' AS RetMsg
		RETURN -1
	END 

	DECLARE @SampleQty INT,		-- 样本大小
			@ACQty INT,			-- 允收数量
			@ReQty INT			-- 拒收数量
     
	DECLARE @SampleSizeCode CHAR(10) -- 样本大小代码 
	SELECT @SampleSizeCode=AQLSampleSizeCode FROM dbo.AQLSampleSize WHERE CheckLevelCode=@JCSP  AND ( @SQC_Qty BETWEEN LotRangeFromQty AND LotRangeToQty )
		--AND LotRangeFromQty>=@SQC_Qty AND ISNULL(LotRangeToQty,1000000)<=@SQC_Qty
	
	-- 获取AQL样本数量
	SELECT @SampleQty=AQLSampleSizeQty,@ACQty=ACQty,@ReQty=ReQty 
		FROM dbo.AQLDetail WHERE AQLSampleSizeCode=@SampleSizeCode AND AQLQualityStandard= @JYBZ
	
	--SELECT @SampleSizeCode,@JYBZ   
	 SELECT '0' AS RetValue, '获取参数成功...' AS RetMsg,@SampleQty AS AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty 
	 RETURN -1
	   
END

GO
/****** Object:  StoredProcedure [dbo].[P_Speciment_Submit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
-- =============================================
-- Author:		John Luo
-- Create date: 2018-06-11
-- Description:	抽检信息提交
-- =============================================
CREATE  PROCEDURE  [dbo].[P_Speciment_Submit]  
@SQCId CHAR(12), 					-- 送检单Id
@CYFS NVARCHAR(20),					-- 抽样方式
@JCSP NVARCHAR(20),					-- 检查水平
@JYBZ NVARCHAR(20),					-- 检验标准
@ScanSN NVARCHAR(30),				-- 扫描SN
@CQ_Qty DECIMAL(18,4),				-- 抽取数量
@UserId CHAR(12)='',				-- 用户内码
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @T_CYFS CHAR(20),@T_CYSP CHAR(20) ,@T_CYBZ CHAR(20),@T_CQty DECIMAL(18,4),@T_PKID INT,
			@T_IsCYDone BIT 
             
	SELECT @T_PKID=SpecimentId ,@T_CYFS=CYFS,@T_CYSP=CYSP,@T_CYBZ=CYBZ, @T_CQty=CQty, @T_IsCYDone=IsCYDone FROM Speciment WHERE SendQCReportId=@SQCId
	IF ISNULL(@T_PKID,0)<>0
	BEGIN
		IF ISNULL(@T_CYFS,'')<>@CYFS  
		BEGIN
			SELECT @Result_Msg='抽样方式与现有的抽样数据不一致,请确认相关参数...',@Return=-1
			RETURN -1
		END 

		IF ISNULL(@T_CYSP,'')<>@JCSP  
		BEGIN
			SELECT @Result_Msg='检验水平与现有的抽样数据不一致,请确认相关参数...',@Return=-1
			RETURN -1
		END 

		IF ISNULL(@T_CYBZ,'')<>@JYBZ  
		BEGIN
			SELECT @Result_Msg='检验标准与现有的抽样数据不一致,请确认相关参数...',@Return=-1
			RETURN -1
		END 
		 
	END  
	
	IF EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SQCId AND ISNULL(YBSN,'')<>'')
	BEGIN
		SELECT @Result_Msg='已生成样本标签，不能再次抽检...',@Return=-1
		RETURN -1
	END 


	DECLARE @T_LotId CHAR(12),@T_LotQty INT 

	SELECT @T_LotId=LotId,@T_LotQty=Qty FROM dbo.Lot WHERE LotSN=@ScanSN

	DECLARE @T_SQCId CHAR(12)

	SELECT @T_SQCId=VendorDeliveryItem.SendQCReportId FROM dbo.VendorDeliveryItemLot LEFT JOIN dbo.VendorDeliveryItem ON VendorDeliveryItem.VendorDeliveryItemId = VendorDeliveryItemLot.VendorDeliveryItemId 
	WHERE LotSN=@ScanSN
	IF ISNULL(@T_SQCId,'') <> ISNULL(@SQCId,' ')
	BEGIN
		SELECT @Result_Msg='送检单不一致,...'+ISNULL(@T_SQCId,'')+':'+ISNULL(@SQCId,' '),@Return=-1
		RETURN -1   
	END 

	IF ISNULL(@T_LotQty,-1)< ISNULL(@CQ_Qty,0)
	BEGIN
		SELECT @Result_Msg='抽取数量不能大于条码批次数量...',@Return=-1
		RETURN -1  
	END 

	IF EXISTS(SELECT 1 FROM SpecimentItem WHERE LotId=@T_LotId )
	BEGIN
		SELECT @Result_Msg='当前批次已在样本群中，不能再次抽取...',@Return=-1
		RETURN -1 
	END 

	IF ISNULL(@T_PKID,0)>0
	BEGIN
		UPDATE Speciment SET CQty=ISNULL(CQty,0)+@CQ_Qty WHERE SpecimentId=@T_PKID
	END
	ELSE
	BEGIN 
		INSERT INTO  Speciment(  SendQCReportId,   CYFS, CYSP, CYBZ, CQty, IsCYDone, CreateDate )
		SELECT @SQCId, @CYFS,@JCSP,  @JYBZ, @CQ_Qty,0,GETDATE() 
		SELECT @T_PKID=SpecimentId FROM Speciment WHERE SendQCReportId=@SQCId
	END
	
	IF EXISTS(SELECT 1 FROM SpecimentItem WHERE  LotId=@T_LotId)
	BEGIN
		UPDATE SpecimentItem SET SpecQty=ISNULL(SpecQty,0)+@CQ_Qty WHERE LotId=@T_LotId 
	END 
	ELSE
	BEGIN
		INSERT INTO SpecimentItem(  SpecimentId, LotId, LotSN, SpecQty, UserId, CreateDate )
		SELECT @T_PKID,@T_LotId,@ScanSN,@CQ_Qty,@UserId,GETDATE()
	END
	 
	SELECT @Result_Msg='数据抽取成功...',@Return=0
	RETURN 0
	   
END

GO
/****** Object:  StoredProcedure [dbo].[P_SQCheckResult_Submit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_SQCheckResult_Submit]
	-- Add the parameters for the stored procedure here
   
	@SendQCReportId char(12)  ,
	--@ResourceId char(12)  ,
	
	@FactoryId char(12)  , 
	@DefaultPath nvarchar(100)  ,
	@UV nvarchar(100)  ,
	@UV_Images nvarchar(200)  ,
	@VL nvarchar(100)  ,
	@VL_Images nvarchar(200)  ,
	@IR nvarchar(100)  ,
	@IR_Images nvarchar(200)  ,
	@HD_ZH nvarchar(100)  ,
	@HD_ZH_Images nvarchar(200)  ,
	@HD_BLH nvarchar(100)  ,
	@HD_BLH_Images nvarchar(200)  ,
	@HD_ABJH nvarchar(100)  ,
	@HD_ABJH_Images nvarchar(200)  ,
	@YD_YD nvarchar(100)  ,
	@YD_YD_Images nvarchar(200)  ,
	@SDJ_CS nvarchar(100)  ,
	@SDJ_CS_Images nvarchar(200)  ,
	@SDJ_NM nvarchar(100)  ,
	@SDJ_NM_Images nvarchar(200)  ,
	@SDJ_MCH nvarchar(100)  ,
	@SDJ_MCH_Images nvarchar(200)  ,
	@ZWY_ZM nvarchar(100)  ,
	@ZWY_ZM_Images nvarchar(200)  ,
	@ZWY_BM nvarchar(100)  ,
	@ZWY_BM_Images nvarchar(200)  ,
	@GHXG_GQLX nvarchar(100)  ,
	@GHXG_GQLX_Images nvarchar(200)  ,
	@GHXG_WB nvarchar(100)  ,
	@GHXG_WB_Images nvarchar(200)  ,
	@ST_ST nvarchar(100)  ,
	@ST_ST_Images nvarchar(200)  ,
	@Size_Long decimal(18, 4)  ,
	@Size_Width decimal(18, 4)  ,
	@Size_Height decimal(18, 4)  ,
	@CheckResult int  ,


	@P_Left decimal(18, 4)  ,
	@P_Right decimal(18, 4)  ,
	@P_UP decimal(18, 4)  ,
	@P_Down decimal(18, 4)  ,

@UserId CHAR(12)='',				-- 用户内码
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 declare @SQ_CheckResult int 

	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 
  IF NOT EXISTS(SELECT 1 FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='还没有生成样本标签,不能检验...',@Return=-1
		RETURN -1
	END 

  

	 SELECT @SQ_CheckResult=QCResult FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId
   IF @SQ_CheckResult<>0
	 BEGIN
	    SELECT @Result_Msg='已经检验过,不能重复检验',@Return=-1
		RETURN -1
	 END

	 
INSERT INTO dbo.SQCheckResult
           ( SendQCReportId ,UserId,FactoryId,CreateDate,DefaultPath
           ,UV ,UV_Images ,VL ,VL_Images,IR,IR_Images
		   ,HD_ZH ,HD_ZH_Images  ,HD_BLH
           ,HD_BLH_Images
           ,HD_ABJH
           ,HD_ABJH_Images
           ,YD_YD
           ,YD_YD_Images
           ,SDJ_CS
           ,SDJ_CS_Images
           ,SDJ_NM
           ,SDJ_NM_Images
           ,SDJ_MCH
           ,SDJ_MCH_Images
           ,ZWY_ZM
           ,ZWY_ZM_Images
           ,ZWY_BM
           ,ZWY_BM_Images
           ,GHXG_GQLX
           ,GHXG_GQLX_Images
           ,GHXG_WB
           ,GHXG_WB_Images
           ,ST_ST
           ,ST_ST_Images
           ,Size_Long
           ,Size_Width
           ,Size_Height
           ,CheckResult
		   ,CheckType
		   ,P_Left
		   ,P_Right
		   ,P_UP
		   ,P_Down)
     VALUES
           ( @SendQCReportId  
           ,@UserId
           ,@FactoryId  
           ,GETDATE()
           ,@DefaultPath 
           ,@UV
           ,@UV_Images 
           ,@VL 
           ,@VL_Images 
           ,@IR
           ,@IR_Images
           ,@HD_ZH
           ,@HD_ZH_Images
           ,@HD_BLH
           ,@HD_BLH_Images
           ,@HD_ABJH
           ,@HD_ABJH_Images
           ,@YD_YD
           ,@YD_YD_Images
           ,@SDJ_CS
           ,@SDJ_CS_Images
           ,@SDJ_NM
           ,@SDJ_NM_Images
           ,@SDJ_MCH
           ,@SDJ_MCH_Images
           ,@ZWY_ZM
           ,@ZWY_ZM_Images
           ,@ZWY_BM
           ,@ZWY_BM_Images
           ,@GHXG_GQLX
           ,@GHXG_GQLX_Images
           ,@GHXG_WB
           ,@GHXG_WB_Images
           ,@ST_ST
           ,@ST_ST_Images
           ,@Size_Long
           ,@Size_Width
           ,@Size_Height
           ,@CheckResult
		   ,1
		   ,@P_Left
		   ,@P_Right
		   ,@P_UP
		   ,@P_Down
		   )
 
    --更新送检单检验状态 
	UPDATE dbo.SendQCReport SET QCResult=@CheckResult WHERE SendQCReportId=@SendQCReportId


 	SELECT @Result_Msg='验证提交成功...',@Return=0
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[P_SQIQCCheckResult_Submit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[P_SQIQCCheckResult_Submit]
	-- Add the parameters for the stored procedure here 
	@SendQCReportId char(12)  ,
	--@ResourceId char(12)  , 
	@ResourceId char(12)  , 
	@DefaultPath nvarchar(100) ='' ,
	@CheckResult int  ,
	@CheckType int  ,
    @XMLData nvarchar(max)='',
	@AcceptQty decimal(18,4)=0,
	@NGQty decimal(18,4)=0,
	@Describe  nvarchar(max) ='' ,

@UserId CHAR(12)='',				-- 用户内码
@Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
@Return INT	OUTPUT					-- 返回值

AS
BEGIN
 	

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 declare @SQ_CheckResult int 
	 declare @SendQCQty decimal
	 declare @CYFS nvarchar(100) 
	 declare @CYSP nvarchar (100) 
	 declare @CYBZ nvarchar (100) 
	 declare @CQty decimal(18,4)
	 declare @SpecimentId nvarchar (12) 
	    DECLARE @InputSN nvarchar(100)=''
	 
	 SELECT @SendQCQty=SendQCQty FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId 
	  IF ISNULL(@SendQCQty,-1)<=0
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 

	SELECT @SpecimentId=SpecimentId,@CYFS=CYFS,@CYSP=CYSP,@CYBZ=CYBZ,@CQty=CQty,@InputSN=ScanSN FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId 
		 
      IF  ISNULL(@CQty,-1)<=0
	BEGIN
		SELECT @Result_Msg='还没有生成样本标签,不能检验...',@Return=-1
		RETURN -1
	END 
	  
	  IF ISNULL(@InputSN,'')=''
	   BEGIN
	    SELECT @Result_Msg='没有生成标签,不能检验...',@Return=-1
		RETURN -1
	   END

	 SELECT @SQ_CheckResult=QCResult FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId
       IF @SQ_CheckResult<>0
	 BEGIN
	    SELECT @Result_Msg= '已经检验过,不能重复检验',@Return=-1
		RETURN -1
	 END

	  
	 --如果是原材料类型，则验证是否有检验行数据
	 --是否全部行已经经验完毕并且行数量等于送货数量 
	 IF	@CheckType=2
	   BEGIN
	    --   declare @RawSendQty decimal(18,4)
		   
		   --SELECT @RawSendQty=SUM(Qty) FROM dbo.RawMaterialIQCCheck  WHERE SendQCReportId=@SendQCReportId
	    --   IF @RawSendQty!=@SendQCQty
		   --BEGIN
		   --   SELECT @Result_Msg='发货数量与检验数量不一致',@Return=-1
		   --   RETURN -1
     --       END

		  IF  EXISTS(SELECT 1 FROM dbo.RawMaterialIQCCheck WHERE SendQCReportId=@SendQCReportId AND  IsCheck=0)
		   BEGIN
		      SELECT @Result_Msg='请全部检验完毕再提交',@Return=-1
		      RETURN -1
            END

		    SELECT @AcceptQty=SUM(Qty) FROM dbo.RawMaterialIQCCheck WHERE SendQCReportId=@SendQCReportId AND  CheckResult=1
		    SELECT @NGQty=ISNULL(SUM(Qty),0) FROM dbo.RawMaterialIQCCheck WHERE SendQCReportId=@SendQCReportId AND  CheckResult=2
	   END
	   
	  IF @SendQCQty!=(@AcceptQty+@NGQty)
	    BEGIN
		SELECT @Result_Msg='送检数量跟接收数量与不良数量之和不一致',@Return=-1
		RETURN -1
	   END 
	 -- 数据传入MES
	 DECLARE	@return_value int 
	 DECLARE	@I_ReturnMessage nvarchar(max)=''   		 --返回的信息,支持多语言
	 DECLARE    @I_ExceptionFieldName nvarchar(100)=''   	 --向客户端报告引起冲突的字段
	

	 DECLARE @CheckResultStr nvarchar(30)='' 
	 set @CheckResultStr=case 
     when @CheckResult=1 then '全部接受'
     when @CheckResult=2 then '特采'
     when @CheckResult=3 then '挑选接收'
     when @CheckResult=4 then '免检'
     when @CheckResult=5 then '拒收' 
     else '未知错误' 
   end
   
	EXEC	@return_value = [dbo].[PDA_IQCScanSubmit_DoMethod]
			@I_ReturnMessage = @I_ReturnMessage OUTPUT,
			@I_ExceptionFieldName = @I_ExceptionFieldName OUTPUT,
			@I_ResourceId=@ResourceId,
			@SendQCReportId=@SendQCReportId,
			@InputSN=@InputSN, --	输入SN
			@CheckLevel=@CYSP,--	检查水平
			@CheckStd=@CYBZ,--	检验标准 
			@DeliveryQty=@SendQCQty,--  送货数量 
			@NGQty =@NGQty,			--  不良数量
			@AcceptQty=@AcceptQty,						--  接收数量
			@CheckResult=@CheckResultStr				--  检验结果
 
 
	IF ISNULL(@return_value,-1)<0
	BEGIN    
		SELECT  @Result_Msg=@I_ReturnMessage,@Return=-1--,@I_ExceptionFieldName='InputSN'
		RETURN -1
	END 
	ELSE
	  BEGIN 
	   IF @CheckType=2
	      BEGIN
		    UPDATE SQCheckResult SET CheckResult=@CheckResult,AcceptQty=@AcceptQty,NGQty=@NGQty,DeliveryQty=@SendQCQty,CheckLevel=@CYSP,CheckStd=@CYBZ WHERE  SendQCReportId=@SendQCReportId
	      END
       ELSE
	    BEGIN
		IF EXISTS(SELECT 1 FROM SQCheckResult WHERE SendQCReportResultId=@SendQCReportId AND  CheckResult=-1)
		   BEGIN
	         UPDATE dbo.SQCheckResult
			 SET UserId=@UserId ,ResourceId =@ResourceId ,DefaultPath=@DefaultPath ,CheckResult=@CheckResult
			      ,CheckType=@CheckType,XMLData=@XMLData,AcceptQty=@AcceptQty,NGQty=@NGQty,DeliveryQty=@SendQCQty,CheckLevel=@CYSP,CheckStd=@CYBZ,Describe=@Describe
             WHERE SendQCReportResultId=@SendQCReportId
			END
	    ELSE
		   BEGIN
		     INSERT INTO dbo.SQCheckResult
           (  
		   SendQCReportId  ,UserId ,ResourceId  ,DefaultPath ,CheckResult,CheckType,XMLData,AcceptQty,NGQty,DeliveryQty,CheckLevel,CheckStd,Describe
           )
           VALUES
           ( 
            @SendQCReportId ,@UserId  ,@ResourceId ,@DefaultPath  ,@CheckResult ,@CheckType,@XMLData,@AcceptQty,@NGQty,@SendQCQty,@CYSP,@CYBZ,@Describe
           )
		   END
	  
         
		   END
	  END
 
 	SELECT @Result_Msg='检验提交成功...',@Return=0
	RETURN 0
END

GO
/****** Object:  StoredProcedure [dbo].[SaveIQCCheckResultTempXmlData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	保存临时数据
-- =============================================
CREATE PROCEDURE [dbo].[SaveIQCCheckResultTempXmlData]
      @XMLData nvarchar(max),
      @SendQCReportId char(12),    
	  @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
      @Return INT	OUTPUT					-- 返回值
AS
BEGIN 
    declare @SQ_CheckResult int  
	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 
	 --如果已经提交则不可以再操作，CheckResult>0
		 IF EXISTS( SELECT  1 FROM dbo.SQCheckResult WHERE SendQCReportResultId=@SendQCReportId AND CheckResult>0 )
			 BEGIN
				 SELECT @Result_Msg='数据已经提交不能保存',@Return=-1
		         RETURN -1
		     END
		 ELSE
		     BEGIN
			 
		declare @SendQCQty decimal
		declare @CYFS nvarchar(100) 
		declare @CYSP nvarchar (100) 
		declare @CYBZ nvarchar (100) 
		declare @CQty decimal(18,4)
		declare @SpecimentId nvarchar (12) 
		DECLARE @InputSN nvarchar(100)=''
	    SELECT @SpecimentId=SpecimentId,@CYFS=CYFS,@CYSP=CYSP,@CYBZ=CYBZ,@CQty=CQty,@InputSN=ScanSN FROM dbo.Speciment WHERE SendQCReportId=@SendQCReportId 
		 
         IF  ISNULL(@CQty,-1)<=0
	        BEGIN
		        SELECT @Result_Msg='还没有生成样本标签,不能保存...',@Return=-1
		        RETURN -1
	        END 
	  
	     IF ISNULL(@InputSN,'')=''
	       BEGIN
	           SELECT @Result_Msg='没有生成标签,不能保存...',@Return=-1
		       RETURN -1
	       END
		         IF EXISTS (SELECT 1 FROM SQCheckResult WHERE SendQCReportId=@SendQCReportId)
				   BEGIN
			        UPDATE  dbo.SQCheckResult  SET  XMLData=@XMLData WHERE SendQCReportId=@SendQCReportId 
			       END
                 ELSE 
				    BEGIN
					     INSERT INTO dbo.SQCheckResult
                         (    SendQCReportId  ,CheckType,XMLData,CheckResult )
                         VALUES
                         (  @SendQCReportId ,2,@XMLData,-1 )
		              END
					 
                     SELECT @Result_Msg='提交成功',@Return=0
		             RETURN 0
          END
END

GO
/****** Object:  StoredProcedure [dbo].[SaveIQCRMCheckResultTempXmlData]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	保存临时数据
-- =============================================
CREATE PROCEDURE [dbo].[SaveIQCRMCheckResultTempXmlData]
      @XMLData nvarchar(max),
	  @RawMaterialIQCCheckId char(12),    
      @SendQCReportId char(12),    
	  @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
      @Return INT	OUTPUT					-- 返回值
AS
BEGIN 
    declare @SQ_CheckResult int  
	  IF NOT EXISTS(SELECT 1 FROM dbo.SendQCReport  WHERE SendQCReportId=@SendQCReportId  )
	BEGIN
		SELECT @Result_Msg='送检单不存在',@Return=-1
		RETURN -1
	END 
	 --如果已经提交则不可以再操作，CheckResult>0
		 IF EXISTS( SELECT  1 FROM dbo.SQCheckResult WHERE SendQCReportResultId=@SendQCReportId AND CheckResult>0 )
			 BEGIN
				 SELECT @Result_Msg='数据已经提交不能保存',@Return=-1
		         RETURN -1
		     END
		 ELSE
		     BEGIN
			   IF EXISTS( SELECT  1 FROM dbo.RawMaterialIQCCheck WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId AND CheckResult>0 )
			    BEGIN
				    SELECT @Result_Msg='行数据已经提交不能保存',@Return=-1
		            RETURN -1
		        END
			   ELSE
			     BEGIN
			      UPDATE  dbo.RawMaterialIQCCheck  SET  XMLData=@XMLData WHERE RawMaterialIQCCheckId=@RawMaterialIQCCheckId
				    SELECT @Result_Msg='提交成功',@Return=0
		            RETURN 0
			    END
			 END


END

GO
/****** Object:  StoredProcedure [dbo].[Speciment_ExtRecordSubmit]    Script Date: 2018-07-17 13:42:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Speciment_ExtRecordSubmit]
	-- Add the parameters for the stored procedure here
	 @SendQCReportId char(12),
	 @ExtQty decimal(18,4), 
	 @Result_Msg NVARCHAR(300) OUTPUT,	-- 返回消息
     @Return INT	OUTPUT					-- 返回值
AS
BEGIN
	 --1、是否已经检验过
	   DECLARE @SQCheckResultId INT 
	   IF NOT EXISTS(SELECT 1 FROM SQCheckResult WHERE SendQCReportId=@SendQCReportId)
	      BEGIN 
		   SELECT @Result_Msg='还没生成检验报告',@Return=-1
		   RETURN -1 
		  END 
	 --2、检验结果不为1
	   IF  EXISTS(SELECT 1 FROM SQCheckResult WHERE CheckResult=1 and SendQCReportId=@SendQCReportId)
	      BEGIN 
		   SELECT @Result_Msg='检验结果为全部接收不能加抽',@Return=-1
		   RETURN -1 
		  END 
	 --3、必须为产品玻璃类型
	  DECLARE @ProductName NVARCHAR(50)
	  DECLARE @SendQCQty DECIMAL(18,2)
	   SELECT  @SendQCQty=dbo.SendQCReport.SendQCQty, @ProductName=ProductRoot.ProductName
	   FROM    dbo.SendQCReport Left Join Product 
			   On SendQCReport.ProductId =  Product.ProductId Left Join ProductRoot
			   On Product.ProductRootId = ProductRoot.ProductRootId
	   WHERE SendQCReportId=@SendQCReportId
	   
	   IF SUBSTRING(@ProductName,1,1)<>'B'
	      BEGIN
		     SELECT @Result_Msg='非半成品不能加抽',@Return=-1
		     RETURN -1 
		  END
	  --4、累计数量不能大于送货数量
	  DECLARE @CQty DECIMAL(18,2)
	    DECLARE @SpecimentId int
	  SELECT @CQty=CQty,@SpecimentId=SpecimentId FROM Speciment WHERE SendQCReportId=@SendQCReportId
	     
		
	  IF @CQty+@ExtQty>@SendQCQty
	    BEGIN
		   SELECT @Result_Msg='累计抽样数量不能大于送货数量',@Return=-1
		   RETURN -1 
		END 

		  
	   --5、是否存在没有完成的加抽 
	    IF EXISTS(   SELECT  1 FROM Speciment_ExtRecord WHERE IsDone=0 AND  SendQCReportId=@SendQCReportId)
		   BEGIN
		       SELECT @Result_Msg='存在还没有完成的加抽',@Return=-1
		       RETURN -1 
		   END
		 ELSE
		    BEGIN
			 
			--添加累计样本数据
			UPDATE Speciment SET CQty=ISNULL(CQty,0)+@ExtQty WHERE  SendQCReportId=@SendQCReportId

			 declare @CheckNO int
	         SELECT @CheckNO=COUNT(1)+1 from DBO.Speciment_ExtRecord where SendQCReportId=@SendQCReportId
			  
			-- --生成样本标签
	  --       DECLARE @T_NewYBSN NVARCHAR(30)='',@T_Str NVARCHAR(20)
	  --       SELECT TOP(1) @T_NewYBSN=YBSN FROM  Speciment WHERE DATEDIFF(DAY,GETDATE(),CreateDate )=0
	  --       IF ISNULL(@T_NewYBSN,'')=''
	  --        BEGIN
	  --          SET @T_NewYBSN='YP'+CONVERT(CHAR(6),GETDATE(),12)+'0001'  
	  --        END 
	  --        ELSE
   --             BEGIN
		 --          SET @T_NewYBSN='YP'+CONVERT(CHAR(6),GETDATE(),12)+ RIGHT(  '000'+ RTRIM(CAST( CAST(  RIGHT(@T_NewYBSN,4) AS INT)+1  AS CHAR(4)) ),4)
	  --          END 

          
	         INSERT INTO dbo.Speciment_ExtRecord
                  (CheckNo,SendQCReportId,ExtQty,IsDone,SpecimentId)
             VALUES
                   (@CheckNO,@SendQCReportId,@ExtQty,0,@SpecimentId)
			
		 
			  
		   SELECT @Result_Msg='执行成功',@Return=0
		   RETURN 0 
			END
END

GO
