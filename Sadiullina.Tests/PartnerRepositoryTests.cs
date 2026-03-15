using Microsoft.EntityFrameworkCore;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SadiullinaLibrary.Data;
using SadiullinaLibrary.Models;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Sadiullina.Tests
{
    [TestClass]
    public class PartnerRepositoryTests
    {
        private AppDbContext _context;
        private PartnerRepository _repository;

        [TestInitialize]
        public void Setup()
        {
            // Создаем уникальную базу данных в памяти для каждого теста
            var options = new DbContextOptionsBuilder<AppDbContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;

            _context = new AppDbContext(options);
            _repository = new PartnerRepository(_context);

            // Добавляем тестовые данные
            SeedData();
        }

        private void SeedData()
        {
            // Добавляем тип партнера (нужен для внешнего ключа)
            if (!_context.PartnerTypes.Any())
            {
                _context.PartnerTypes.Add(new PartnerType
                {
                    Id = 1,
                    Name = "ООО"
                });
                _context.SaveChanges();
            }
        }

        [TestCleanup]
        public void Cleanup()
        {
            _context.Database.EnsureDeleted();
            _context.Dispose();
        }

        [TestMethod]
        public async Task AddAsync_ValidPartner_ReturnsPartnerWithId()
        {
            // Arrange
            var partner = new Partner
            {
                TypeId = 1,
                CompanyName = "ООО Тест",
                DirectorFullname = "Иванов Иван Иванович",
                Phone = "+7(123)456-78-90",
                Email = "test@test.ru",
                Rating = 50
            };

            // Act
            var result = await _repository.AddAsync(partner);

            // Assert
            Assert.IsNotNull(result);
            Assert.IsTrue(result.Id > 0);
            Assert.AreEqual("ООО Тест", result.CompanyName);
        }

        [TestMethod]
        public async Task GetByIdAsync_ExistingId_ReturnsPartner()
        {
            // Arrange
            var partner = new Partner
            {
                TypeId = 1,
                CompanyName = "ООО Тест",
                Rating = 50
            };
            var added = await _repository.AddAsync(partner);

            // Act
            var result = await _repository.GetByIdAsync(added.Id);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(added.Id, result.Id);
            Assert.AreEqual("ООО Тест", result.CompanyName);
        }

        [TestMethod]
        public async Task GetByIdAsync_NonExistingId_ReturnsNull()
        {
            // Act
            var result = await _repository.GetByIdAsync(999);

            // Assert
            Assert.IsNull(result);
        }

        [TestMethod]
        public async Task GetAllAsync_ReturnsAllPartners()
        {
            // Arrange
            await _repository.AddAsync(new Partner { TypeId = 1, CompanyName = "Партнер 1", Rating = 50 });
            await _repository.AddAsync(new Partner { TypeId = 1, CompanyName = "Партнер 2", Rating = 60 });

            // Act
            var result = await _repository.GetAllAsync();

            // Assert
            Assert.AreEqual(2, result.Count);
        }

        [TestMethod]
        public async Task UpdateAsync_ExistingPartner_UpdatesProperties()
        {
            // Arrange
            var partner = new Partner
            {
                TypeId = 1,
                CompanyName = "Старое название",
                Rating = 50
            };
            var added = await _repository.AddAsync(partner);

            // Act
            added.CompanyName = "Новое название";
            added.Rating = 75;
            await _repository.UpdateAsync(added);

            // Assert
            var updated = await _repository.GetByIdAsync(added.Id);
            Assert.AreEqual("Новое название", updated.CompanyName);
            Assert.AreEqual(75, updated.Rating);
        }

        [TestMethod]
        public async Task DeleteAsync_ExistingId_RemovesPartner()
        {
            // Arrange
            var partner = new Partner
            {
                TypeId = 1,
                CompanyName = "Для удаления",
                Rating = 50
            };
            var added = await _repository.AddAsync(partner);

            // Act
            await _repository.DeleteAsync(added.Id);

            // Assert
            var result = await _repository.GetByIdAsync(added.Id);
            Assert.IsNull(result);
        }
    }
}