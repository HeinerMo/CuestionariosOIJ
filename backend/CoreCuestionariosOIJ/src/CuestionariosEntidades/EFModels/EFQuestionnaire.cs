﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CuestionariosEntidades.EFModels
{
    public class EFQuestionnaire
    {
        public int Id { get; set; }
        public IEnumerable<EFQuestion>? Questions { get; set; }
        public String? Type { get; set; } = String.Empty;
        public String? Name { get; set; } = String.Empty;
        public DateTime? ExpirationDate { get; set; }
        public String? Description { get; set; } = String.Empty;
    }
}
