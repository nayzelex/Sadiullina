using Microsoft.VisualStudio.TestTools.UnitTesting;
using SadiullinaLibrary.Services;

namespace Sadiullina.Tests
{
    [TestClass]
    public class DiscountCalculatorTests
    {
        private DiscountCalculator _calculator;

        [TestInitialize]
        public void Setup()
        {
            _calculator = new DiscountCalculator();
        }

        [TestMethod]
        public void CalculateDiscount_AmountLessThan10000_Returns0()
        {
            // Arrange
            decimal amount = 5000;

            // Act
            int result = _calculator.CalculateDiscount(amount);

            // Assert
            Assert.AreEqual(0, result);
        }

        [TestMethod]
        public void CalculateDiscount_AmountBetween10000And50000_Returns5()
        {
            // Arrange
            decimal amount = 25000;

            // Act
            int result = _calculator.CalculateDiscount(amount);

            // Assert
            Assert.AreEqual(5, result);
        }

        [TestMethod]
        public void CalculateDiscount_AmountBetween50000And300000_Returns10()
        {
            // Arrange
            decimal amount = 150000;

            // Act
            int result = _calculator.CalculateDiscount(amount);

            // Assert
            Assert.AreEqual(10, result);
        }

        [TestMethod]
        public void CalculateDiscount_AmountMoreThan300000_Returns15()
        {
            // Arrange
            decimal amount = 500000;

            // Act
            int result = _calculator.CalculateDiscount(amount);

            // Assert
            Assert.AreEqual(15, result);
        }

        [DataTestMethod]
        [DataRow(5000, 0)]
        [DataRow(10000, 5)]
        [DataRow(25000, 5)]
        [DataRow(50000, 10)]
        [DataRow(150000, 10)]
        [DataRow(300000, 15)]
        [DataRow(1000000, 15)]
        public void CalculateDiscount_MultipleAmounts_ReturnsCorrectDiscount(double amountDouble, int expected)
        {
            // Arrange - конвертируем double в decimal
            decimal amount = Convert.ToDecimal(amountDouble);

            // Act
            int result = _calculator.CalculateDiscount(amount);

            // Assert
            Assert.AreEqual(expected, result);
        }
    }
}