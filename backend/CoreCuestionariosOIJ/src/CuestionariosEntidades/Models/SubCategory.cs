﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CuestionariosEntidades.Models
{
    public class SubCategory
    {
        public int? Id { get; set; }
        public String? Name { get; set; } = String.Empty;
        public int? IdCategory { get; set; }

    }
}
