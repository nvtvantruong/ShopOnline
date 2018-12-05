using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Cart
{
    public int ClientID
    {
        get;
        set;
    }

    public string Email
    {
        get;
        set;
    }

    public string FullName
    {
        get;
        set;
    }

    public string Mobi1
    {
        get;
        set;
    }

    public string Mobi2
    {
        get;
        set;
    }

    public bool Gender
    {
        get;
        set;
    }

    public string Address
    {
        get;
        set;
    }

    public int PaymentMethod
    {
        get;
        set;
    }

    private Dictionary<int, CartItem> cartItems;
    public Dictionary<int, CartItem> CartItems
    {
        get
        {
            if (cartItems == null)
                cartItems = new Dictionary<int, CartItem>();

            return cartItems;
        }
    }

    public double Total
    {
        get
        {
            double total = 0;
            foreach (var item in CartItems)
            {
                total += item.Value.Quantity * item.Value.OldPrice;
            }

            return total;
        }
    }

    public double Bonus
    {
        get
        {
            double bonus = this.Total - this.Amount;
            return bonus;
        }
    }

    public double Amount
    {
        get
        {
            double amount = 0;
            foreach (var item in CartItems)
            {
                amount += item.Value.Quantity * item.Value.Price;
            }

            return amount;
        }
    }

    public int CountItems
    {
        get
        {
            int quantity = 0;
            foreach(var item in CartItems)
            {
                quantity += item.Value.Quantity;
            }

            return quantity;
        }
    }
}