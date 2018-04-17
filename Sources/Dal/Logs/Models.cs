﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Project.Kernel.Dal.Logs;

namespace Logs
{
    public class BaseLogModel:BaseModel
    {
        [Column(TypeName = "datetime2")]
        public DateTime Date { get; set; }

        [Required]
        [StringLength(255)]
        public string Thread { get; set; }

        [Required]
        [StringLength(50)]
        public string Level { get; set; }

        [Required]
        [StringLength(255)]
        public string Logger { get; set; }

        [Required]
        [StringLength(4000)]
        public string Message { get; set; }

        [Required]
        [StringLength(2000)]
        public string Exception { get; set; }
    }

    [Table("FrontendWebLogs")]
    public class FrontendWebLogsModel : BaseLogModel { }
}
