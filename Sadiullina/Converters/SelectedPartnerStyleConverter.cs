using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;
using SadiullinaLibrary.DTO;

namespace Sadiullina.Converters
{
    public class SelectedPartnerStyleConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null || parameter == null)
                return Application.Current.FindResource("PartnerCardStyle");

            var currentPartner = value as PartnerDto;
            var selectedPartner = parameter as PartnerDto;

            if (selectedPartner != null && currentPartner != null && currentPartner.Id == selectedPartner.Id)
                return Application.Current.FindResource("SelectedPartnerCardStyle");

            return Application.Current.FindResource("PartnerCardStyle");
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}