using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using SadiullinaLibrary.Data;
using SadiullinaLibrary.DTO;
using SadiullinaLibrary.Models;
using SadiullinaLibrary.Services;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Sadiullina.Tests
{
    [TestClass]
    public class PartnerServiceTests
    {
        private Mock<IPartnerRepository> _mockPartnerRepo;
        private Mock<IProductRepository> _mockProductRepo;
        private Mock<IPartnerTypeRepository> _mockTypeRepo;
        private Mock<IDiscountCalculator> _mockDiscountCalc;
        private PartnerService _service;

        [TestInitialize]
        public void Setup()
        {
            _mockPartnerRepo = new Mock<IPartnerRepository>();
            _mockProductRepo = new Mock<IProductRepository>();
            _mockTypeRepo = new Mock<IPartnerTypeRepository>();
            _mockDiscountCalc = new Mock<IDiscountCalculator>();

            _service = new PartnerService(
                _mockPartnerRepo.Object,
                _mockProductRepo.Object,
                _mockTypeRepo.Object,
                _mockDiscountCalc.Object
            );
        }

        [TestMethod]
        public async Task GetAllPartnersAsync_ReturnsAllPartnersWithDiscounts()
        {
            // Arrange
            var partners = new List<Partner>
            {
                new Partner
                {
                    Id = 1,
                    TypeId = 1,
                    CompanyName = "Партнер 1",
                    PartnerType = new PartnerType { Id = 1, Name = "ООО" }
                },
                new Partner
                {
                    Id = 2,
                    TypeId = 2,
                    CompanyName = "Партнер 2",
                    PartnerType = new PartnerType { Id = 2, Name = "ИП" }
                }
            };

            _mockPartnerRepo.Setup(r => r.GetAllAsync()).ReturnsAsync(partners);
            _mockPartnerRepo.Setup(r => r.GetTotalSalesAmountByPartnerAsync(1)).ReturnsAsync(25000m);
            _mockPartnerRepo.Setup(r => r.GetTotalSalesAmountByPartnerAsync(2)).ReturnsAsync(150000m);
            _mockDiscountCalc.Setup(d => d.CalculateDiscount(25000m)).Returns(5);
            _mockDiscountCalc.Setup(d => d.CalculateDiscount(150000m)).Returns(10);

            // Act
            var result = await _service.GetAllPartnersAsync();

            // Assert
            Assert.AreEqual(2, result.Count);
            Assert.AreEqual(5, result.First(r => r.Id == 1).DiscountPercentage);
            Assert.AreEqual(10, result.First(r => r.Id == 2).DiscountPercentage);
        }

        [TestMethod]
        public async Task GetPartnerForEditAsync_ExistingId_ReturnsDto()
        {
            // Arrange
            int partnerId = 1;
            var partner = new Partner
            {
                Id = partnerId,
                TypeId = 1,
                CompanyName = "ООО Тест",
                DirectorFullname = "Иванов И.И.",
                Phone = "+7(123)456-78-90",
                Email = "test@test.ru",
                Rating = 50
            };

            _mockPartnerRepo.Setup(r => r.GetByIdAsync(partnerId)).ReturnsAsync(partner);

            // Act
            var result = await _service.GetPartnerForEditAsync(partnerId);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(partnerId, result.Id);
            Assert.AreEqual("ООО Тест", result.CompanyName);
            Assert.AreEqual(50, result.Rating);
        }

        [TestMethod]
        public async Task GetPartnerForEditAsync_NonExistingId_ReturnsNull()
        {
            // Arrange
            int partnerId = 999;
            _mockPartnerRepo.Setup(r => r.GetByIdAsync(partnerId)).ReturnsAsync((Partner?)null);

            // Act
            var result = await _service.GetPartnerForEditAsync(partnerId);

            // Assert
            Assert.IsNull(result);
        }

        [TestMethod]
        public async Task CreatePartnerAsync_ValidDto_CallsAddAsync()
        {
            // Arrange
            var dto = new PartnerCreateUpdateDto
            {
                TypeId = 1,
                CompanyName = "Новый партнер",
                DirectorFullname = "Петров П.П.",
                Rating = 75
            };

            var expectedPartner = new Partner
            {
                Id = 1,
                CompanyName = "Новый партнер"
            };

            _mockPartnerRepo.Setup(r => r.AddAsync(It.IsAny<Partner>()))
                .ReturnsAsync(expectedPartner);

            // Act
            var result = await _service.CreatePartnerAsync(dto);

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(1, result.Id);
            _mockPartnerRepo.Verify(r => r.AddAsync(It.IsAny<Partner>()), Times.Once);
        }
    }
}