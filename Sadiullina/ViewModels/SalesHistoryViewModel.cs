using System;
using System.Collections.Generic;
using System.Text;
using SadiullinaLibrary.DTO;
using SadiullinaLibrary.Services;
using System;
using System.Collections.ObjectModel;
using System.Threading.Tasks;
using System.Windows;

namespace Sadiullina.ViewModels
{
    public class SalesHistoryViewModel : ViewModelBase
    {
        private readonly IPartnerService _partnerService;
        private readonly int _partnerId;

        private ObservableCollection<SalesHistoryDto> _salesHistory;
        private bool _isLoading;
        private decimal _totalSalesAmount;
        private int _discountPercentage;

        public SalesHistoryViewModel(IPartnerService partnerService, int partnerId)
        {
            _partnerService = partnerService;
            _partnerId = partnerId;
            _salesHistory = new ObservableCollection<SalesHistoryDto>();

            LoadSalesHistoryAsync();
        }

        public ObservableCollection<SalesHistoryDto> SalesHistory
        {
            get => _salesHistory;
            set => SetProperty(ref _salesHistory, value);
        }

        public bool IsLoading
        {
            get => _isLoading;
            set => SetProperty(ref _isLoading, value);
        }

        public decimal TotalSalesAmount
        {
            get => _totalSalesAmount;
            set => SetProperty(ref _totalSalesAmount, value);
        }

        public int DiscountPercentage
        {
            get => _discountPercentage;
            set
            {
                if (SetProperty(ref _discountPercentage, value))
                {
                    OnPropertyChanged(nameof(DiscountInfo));
                }
            }
        }

        public string DiscountInfo => $"Текущая скидка: {DiscountPercentage}%";

        private async Task LoadSalesHistoryAsync()
        {
            try
            {
                IsLoading = true;

                var history = await _partnerService.GetPartnerSalesHistoryAsync(_partnerId);

                SalesHistory.Clear();
                decimal total = 0;

                foreach (var item in history)
                {
                    SalesHistory.Add(item);
                    total += item.TotalAmount;
                }

                TotalSalesAmount = total;

                var discountCalculator = new DiscountCalculator();
                DiscountPercentage = discountCalculator.CalculateDiscount(TotalSalesAmount);

                OnPropertyChanged(nameof(DiscountPercentage));
                OnPropertyChanged(nameof(DiscountInfo));
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки истории продаж: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                IsLoading = false;
            }
        }
    }
}