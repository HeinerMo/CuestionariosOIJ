﻿using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using CuestionariosEntidades.Models;
using CuestionariosEntidades.EFModels;

namespace CuestionariosAD.Mappings
{
    public class CategoryMapping : IEntityTypeConfiguration<EFCategory>
    {
        public void Configure(EntityTypeBuilder<EFCategory> builder)
        {
            // Indicarle las columnas de la base de datos
            builder.HasKey(c => c.Id);

            builder.Property(c => c.Name)
                .IsRequired()
                .HasColumnType("nvarchar(150)")
            .HasColumnName("nombre");

            builder.ToTable("tb_categoria_pregunta");
        }
    }
}
