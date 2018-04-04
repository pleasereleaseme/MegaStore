using System;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using MegaStore.Web.Models;
using MegaStore.Helper;
using System.Collections.Generic;

namespace MegaStore.Web.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            CreateSale();

            return View();
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public void CreateSale()
        {
            var sale = new Sale()
            {
                CreatedOn = DateTime.Now,
                Description = GetProduct()
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
