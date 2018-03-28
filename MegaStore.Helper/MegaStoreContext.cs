using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace MegaStore.Helper
{
    public class MegaStoreContext : DbContext
    {
        private const string conn = "Server=tcp:mega-store.database.windows.net,1433;Initial Catalog=MegaStoreDat;Persist Security Info=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

        public DbSet<Sale> Sale { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(conn);
        
        }

    }
}
