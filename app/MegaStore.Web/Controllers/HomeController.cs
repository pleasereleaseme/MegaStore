using System;
using System.Collections.Generic;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using MegaStore.Web.Models;
using MegaStore.Helper;

namespace MegaStore.Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            CreateSale();
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        // This code is modified from https://github.com/sixeyed/docker-on-windows
        public void CreateSale()
        {
            var sale = new Sale()
            {
                CreatedOn = DateTime.Now,
                Description = GetProduct()
                //Description = $" {Environment.MachineName}"
            };

            var eventMessage = new SaleCreatedEvent
            {
                Sale = sale,
                CreatedAt = DateTime.Now
            };

            MessageQueue.Publish(eventMessage);
        }

        public string GetProduct()
        {
            Random rnd = new Random();
            var products = new List<string> { "Otter Bitter", "Otter Amber", "Otter Bright", "Otter Ale", "Otter Head", "Tarka Pure", "Tarka Four", "Yellow Hammer", "Port Stout", "Firefly Bitter", "Stormstay Ale" };
            int index = rnd.Next(products.Count);

            return products[index];
        }
    }
}
