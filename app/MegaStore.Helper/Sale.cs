using System;

namespace MegaStore.Helper
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    public class Sale
    {
        public long SaleID { get; set; }

        public DateTime CreatedOn { get; set; }

        public string Description { get; set; }
    }
}
