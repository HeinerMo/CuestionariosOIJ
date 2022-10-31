﻿using CuestionariosEntidades.DataTranferObjects;
using CuestionariosEntidades.Models;
using CuestionariosRN.BusinessObjects;
using Microsoft.AspNetCore.Mvc;

namespace CuestionariosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class QuestionController : ControllerBase
    {
        private readonly QuestionRN questionRN;

        public QuestionController()
        {

            questionRN = new QuestionRN();
        }

        // Peticion tipo GET: api/GetQuestionTypes
        [HttpGet]
        [Route("GetQuestionTypes")]
        public async Task<ActionResult<ResponseDTO<List<QuestionType>>>> GetQuestionTypes()
        {
            return await questionRN.GetQuestionTypes();
        }

        // Peticion tipo GET: api/GetQuestionTypeById
        [HttpGet]
        [Route("GetQuestionTypeById")]
        public async Task<ActionResult<ResponseDTO<QuestionType>>> GetQuestionTypeById(int idType)
        {
            return await questionRN.GetQuestionTypeById(idType);
        }
        /*
        // Peticion tipo GET: api/GetQuestions
        [HttpGet]
        [Route("GetQuestions")]
        public async Task<ActionResult<List<Question>>> GetQuestions()
        {
            return await questionRN.GetQuestions();
        }

        // Petición tipo POST: api/CreateQuestion
        [HttpPost]
        [Route("CreateQuestion")]
        public async Task<ActionResult<List<Question>>> CreateQuestion(Question question)
        {
            return await questionRN.CreateQuestion(question);
        }

        //Petición tipo PUT: api/UpdateQuestion
        [Route("UpdateQuestion")]
        [HttpPut]
        public async Task<ActionResult<List<Question>>> UpdateQuestion(Question question)
        {
            return await questionRN.UpdateQuestion(question);
        }

        //Petición tipo DELETE: api/DeleteQuestion
        [HttpDelete("DeleteQuestion/{id}")]
        public async Task<ActionResult<List<Question>>> DeleteQuestion(int id)
        {
            return await questionRN.DeleteQuestion(id);
        }
        */
    }
}
