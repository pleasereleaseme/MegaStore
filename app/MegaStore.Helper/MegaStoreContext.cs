using Microsoft.EntityFrameworkCore;

namespace MegaStore.Helper
{
    // This code is modified from https://github.com/sixeyed/docker-on-windows
    public class MegaStoreContext : DbContext
    {
        private const string conn = "Server=tcp:mega-store.database.windows.net,1433;Initial Catalog=MegaStoreDat;Persist Security Info=False;User ID=sales_user;Password=qcDJLuvjh73n@r;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

        public DbSet<Sale> Sale { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //optionsBuilder.UseSqlServer(conn);
            optionsBuilder.UseSqlServer(Env.DbConnectionString);

        }

    }
}
