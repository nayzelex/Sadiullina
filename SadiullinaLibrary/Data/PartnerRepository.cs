using Microsoft.EntityFrameworkCore;
using SadiullinaLibrary.Models;

namespace SadiullinaLibrary.Data
{
    public interface IPartnerRepository
    {
        Task<List<Partner>> GetAllAsync();
        Task<Partner?> GetByIdAsync(int id);
        Task<Partner> AddAsync(Partner partner);
        Task UpdateAsync(Partner partner);
        Task DeleteAsync(int id);
        Task<List<SalesHistory>> GetPartnerSalesHistoryAsync(int partnerId);
        Task<decimal> GetTotalSalesAmountByPartnerAsync(int partnerId);
    }

    public class PartnerRepository : IPartnerRepository
    {
        private readonly AppDbContext _context;

        public PartnerRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<List<Partner>> GetAllAsync()
        {
            return await _context.Partners
                .Include(p => p.PartnerType)
                .OrderBy(p => p.CompanyName)
                .ToListAsync();
        }

        public async Task<Partner?> GetByIdAsync(int id)
        {
            return await _context.Partners
                .Include(p => p.PartnerType)
                .Include(p => p.SalesPoints)
                .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Partner> AddAsync(Partner partner)
        {
            partner.CreatedAt = DateTime.UtcNow;
            partner.UpdatedAt = DateTime.UtcNow;

            await _context.Partners.AddAsync(partner);
            await _context.SaveChangesAsync();
            return partner;
        }

        public async Task UpdateAsync(Partner partner)
        {
            partner.UpdatedAt = DateTime.UtcNow;
            _context.Partners.Update(partner);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var partner = await _context.Partners.FindAsync(id);
            if (partner != null)
            {
                _context.Partners.Remove(partner);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<List<SalesHistory>> GetPartnerSalesHistoryAsync(int partnerId)
        {
            return await _context.SalesHistories
                .Include(sh => sh.Product)
                .Where(sh => sh.PartnerId == partnerId)
                .OrderByDescending(sh => sh.SaleDate)
                .ToListAsync();
        }

        public async Task<decimal> GetTotalSalesAmountByPartnerAsync(int partnerId)
        {
            return await _context.SalesHistories
                .Where(sh => sh.PartnerId == partnerId)
                .SumAsync(sh => sh.TotalAmount);
        }
    }
}