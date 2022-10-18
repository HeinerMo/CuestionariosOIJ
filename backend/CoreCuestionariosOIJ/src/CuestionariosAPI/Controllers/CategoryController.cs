﻿using CuestionariosEntidades.EFModels;
using CuestionariosEntidades.Models;
using CuestionariosRN.BusinessObjects;
using Microsoft.AspNetCore.Mvc;

namespace CuestionariosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CategoryController : ControllerBase
    {
        private readonly CategoryRN categoryRN;

        public CategoryController() {

            categoryRN = new CategoryRN();
        }

        // Peticion tipo GET: api/GetCategories
        [HttpGet]
        [Route("GetCategories")]
        public async Task<ActionResult<List<EFCategory>>> GetCategories()
        {
            return await categoryRN.GetCategories();
        }
        
        // Petición tipo POST: api/CreateCategory
        [HttpPost]
        [Route("CreateCategory")]
        public async Task<ActionResult<List<EFCategory>>> CreateCategory(EFCategory category)
        {
            return await categoryRN.CreateCategory(category);
        }

        //Petición tipo PUT: api/UpdateCategory
        [Route("UpdateCategory")]
        [HttpPut]
        public async Task<ActionResult<List<EFCategory>>> UpdateCategory(EFCategory category)
        {
            return await categoryRN.UpdateCategory(category);
        }

        //Petición tipo DELETE: api/DeleteCategory
        [HttpDelete("DeleteCategory/{id}")]
        public async Task<ActionResult<List<EFCategory>>> DeleteCategory(int id)
        {
            return await categoryRN.DeleteCategory(id);
        }

    }
}
