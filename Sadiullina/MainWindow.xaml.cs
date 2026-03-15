using Sadiullina.ViewModels;
using SadiullinaLibrary.DTO;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Sadiullina
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private MainViewModel? ViewModel => DataContext as MainViewModel;

        public MainWindow()
        {
            InitializeComponent();

            if (App.ServiceProvider != null)
            {
                DataContext = App.ServiceProvider.GetService(typeof(MainViewModel));
            }
        }

        private void PartnerCard_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (sender is FrameworkElement element && element.Tag is PartnerDto partner)
            {
                ViewModel!.SelectedPartner = partner;
            }
        }

        private void AddPartnerMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ViewModel?.AddPartnerCommand?.Execute(null);
        }

        private void EditPartnerMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ViewModel?.EditPartnerCommand?.Execute(null);
        }

        private void DeletePartnerMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ViewModel?.DeletePartnerCommand?.Execute(null);
        }

        private void HistoryMenuItem_Click(object sender, RoutedEventArgs e)
        {
            ViewModel?.ViewSalesHistoryCommand?.Execute(null);
        }

        private void ExitMenuItem_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void AboutMenuItem_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(
                "Мастер пол - Учет партнеров\n" +
                "Версия 1.0\n" +
                "Разработчик: Садиуллина\n" +
                "Группа: ИПО-41\n\n" +
                "© 2026 Все права защищены",
                "О программе",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}