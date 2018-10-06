using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;

namespace OpenAuth.App.OldAJD
{
    public class SchemeApp : OldBaseApp<Repository.Domain.Kindee.Scheme>
    {
        public Repository.Domain.Kindee.Scheme GetSchemeByScheme(string schemeid)
        {
            try
            {
                var paras = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "Schemeid",
                    Value = schemeid
                };
                var data = Repository.FindBySQL(@"select id as RecordId, 制作要求 as 'MakeRequest',总览图 as 'images',备注 as 'SchemeRemark' ,方案名 as SchemeName,编制者 as SchemeMaker,编制时间 as SchemeTime,imagesNew
                                          from   wx客户个性方案_记录 a 
                                                 left join t_ICItem b on a.fitemid = b.FItemID
                                          where a.ID =@Schemeid order by 编制时间 desc", paras).FirstOrDefault();

                if (string.IsNullOrEmpty(data.imagesNew))
                {
                    System.IO.Stream stream = new System.IO.MemoryStream(data.images);
                    using (Image image = Image.FromStream(stream))
                    {
                        string AtterFileName = DateTime.Now.ToString("yyyMMddHHmmss") + DateTime.Now.Millisecond + ".jpg";
                        string dirpath = System.AppDomain.CurrentDomain.BaseDirectory + "uploadfiles\\oldajdimgs\\";
                        if (!System.IO.Directory.Exists(dirpath))
                            System.IO.Directory.CreateDirectory(dirpath);

                        System.Drawing.Image bmp = new System.Drawing.Bitmap(image);
                        bmp.Save(dirpath + AtterFileName, System.Drawing.Imaging.ImageFormat.Jpeg);
                        bmp.Dispose();
                        Repository.ExecuteSql("UPDATE wx客户个性方案_记录 SET imagesNew='" + AtterFileName + "' WHERE id=" + data.RecordId);
                        data.imagesNew = AtterFileName;
                    } 
                    stream.Close(); 
                } 
                return data; 
            }
            catch (Exception ex)
            {
               throw new Exception(ex.Message);
            }

        }
    }
}
