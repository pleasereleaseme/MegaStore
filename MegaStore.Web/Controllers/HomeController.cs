using System;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using MegaStore.Web.Models;
using MegaStore.Helper;

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
                Description = "Test"
            };

            var eventMessage = new SaleCreatedEvent
            {
                Sale = sale,
                CreatedAt = DateTime.UtcNow
            };

            MessageQueue.Publish(eventMessage);
        }
    }
}
