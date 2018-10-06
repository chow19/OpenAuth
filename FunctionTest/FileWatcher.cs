using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionTest
{
    /// <summary>
    /// 文件监控类，用于监控指定目录下文件以及文件夹的变化
    /// </summary>
    public class FileWatcher
    {
        
        public static void WatcherStrat(string path, string filter)
        {

            FileSystemWatcher watcher = new FileSystemWatcher();
            watcher.Path = path;
            watcher.Filter = filter;
            watcher.Changed += new FileSystemEventHandler(OnProcess);
            watcher.Created += new FileSystemEventHandler(OnProcess);
            watcher.Deleted += new FileSystemEventHandler(OnProcess);
            watcher.Renamed += new RenamedEventHandler(OnRenamed);
            watcher.EnableRaisingEvents = true;
            watcher.NotifyFilter = NotifyFilters.Attributes | NotifyFilters.CreationTime | NotifyFilters.DirectoryName | NotifyFilters.FileName | NotifyFilters.LastAccess
                                   | NotifyFilters.LastWrite | NotifyFilters.Security | NotifyFilters.Size;
            watcher.IncludeSubdirectories = true;
        }

        /// <summary>
        /// 关闭监听器
        /// </summary>
        public void Close()
        {
            FileSystemWatcher _watcher = new FileSystemWatcher();
          
            _watcher.Created -= new FileSystemEventHandler(OnProcess);
            _watcher.Changed -= new FileSystemEventHandler(OnProcess);
            _watcher.Deleted -= new FileSystemEventHandler(OnProcess);
            _watcher.Renamed -= new RenamedEventHandler(OnRenamed);
            _watcher.EnableRaisingEvents = false;
            _watcher = null;
        }

        private static void OnProcess(object source, FileSystemEventArgs e)
        {
            if (e.ChangeType == WatcherChangeTypes.Created)
            {
                OnCreated(source, e);
            }
            else if (e.ChangeType == WatcherChangeTypes.Changed)
            {
                OnChanged(source, e);
            }
            else if (e.ChangeType == WatcherChangeTypes.Deleted)
            {
                OnDeleted(source, e);
            }

        }
        private static void OnCreated(object source, FileSystemEventArgs e)
        {
            Console.WriteLine("文件新建事件处理逻辑 {0}  {1}  {2}", e.ChangeType, e.FullPath, e.Name); 
            
        }
        private static void OnChanged(object source, FileSystemEventArgs e)
        {
            Console.WriteLine("文件改变事件处理逻辑{0}  {1}  {2}", e.ChangeType, e.FullPath, e.Name);
        }

        private static void OnDeleted(object source, FileSystemEventArgs e)
        {
            Console.WriteLine("文件删除事件处理逻辑{0}  {1}   {2}", e.ChangeType, e.FullPath, e.Name);
        }

        private static void OnRenamed(object source, RenamedEventArgs e)
        {
            Console.WriteLine("文件重命名事件处理逻辑{0}  {1}  {2}", e.ChangeType, e.FullPath, e.Name);
        }

    }
}
