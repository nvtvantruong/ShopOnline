<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccountWishlist.aspx.cs" Inherits="AccountWishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <div class="container">
        <div class="row">



            <div class="span9">
                <div class="titleHeader clearfix">
                    <h3>Sản Phẩm Ưa Thích</h3>
                </div>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th class="desc">Descraption</th>
                            <th>Model</th>
                            <th>Stock</th>
                            <th>Unit Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a href="#">
                                    <img src="/css/images/72x72.jpg" alt="" />
                                </a>
                            </td>
                            <td class="desc">
                                <h4>
                                    <a href="#" class="invarseColor">Foliomania the designer </a>
                                </h4>
                                <ul class="rating clearfix">
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-off"></i>
                                    </li>
                                    <li>
                                        <i class="star-off"></i>
                                    </li>
                                </ul>
                                <ul class="unstyled">
                                    <li>No. CtAw9458</li>
                                </ul>
                            </td>
                            <td>Designwe</td>
                            <td>
                                <i style="color: #468847;" class="icon-ok"></i>
                            </td>
                            <td>
                                <h2>$150.00</h2>
                            </td>
                            <td>
                                <button class="btn btn-small btn-primary" data-title="+To Cart" data-placement="top" data-toggle="tooltip"><i class="icon-shopping-cart"></i></button>
                                <button class="btn btn-small btn-danger" data-title="Remove" data-placement="top" data-toggle="tooltip"><i class="icon-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">
                                    <img src="/css/images/72x72.jpg" alt="" />
                                </a>
                            </td>
                            <td class="desc">
                                <h4>
                                    <a href="#" class="invarseColor">Foliomania the designer </a>
                                </h4>
                                <ul class="rating clearfix">
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-on"></i>
                                    </li>
                                    <li>
                                        <i class="star-off"></i>
                                    </li>
                                </ul>
                                <ul class="unstyled">
                                    <li>No. CtAw9458</li>
                                </ul>
                            </td>
                            <td class="quantity">Designwe</td>
                            <td class="sub-price">
                                <i style="color: #b94a48;" class="icon-remove-sign"></i>
                            </td>
                            <td class="total-price">
                                <h2>$150.00</h2>
                            </td>
                            <td>
                                <button class="btn btn-small btn-primary" data-title="+To Cart" data-placement="top" data-toggle="tooltip"><i class="icon-shopping-cart"></i></button>
                                <button class="btn btn-small btn-danger" data-title="Remove" data-placement="top" data-toggle="tooltip"><i class="icon-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">
                                    <img src="/css/images/72x72.jpg" alt="" />
                                </a>
                            </td>
                            <td class="desc">
                                <h4>
                                    <a href="#" class="invarseColor">Foliomania the designer </a>
                                </h4>
                                <ul class="unstyled">
                                    <li>No. CtAw9458</li>
                                    <li>Nicka Corparation</li>
                                    <li>25 Points</li>
                                </ul>
                            </td>
                            <td class="quantity">anything</td>
                            <td>
                                <i style="color: #468847;" class="icon-ok"></i>
                            </td>
                            <td>
                                <h2>$150.00</h2>
                            </td>
                            <td>
                                <button class="btn btn-small btn-primary" data-title="+To Cart" data-placement="top" data-toggle="tooltip"><i class="icon-shopping-cart"></i></button>
                                <button class="btn btn-small btn-danger" data-title="Remove" data-placement="top" data-toggle="tooltip"><i class="icon-trash"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>




            <div class="span3">
                <div class="titleHeader clearfix">
                    <h3>Trợ Giúp</h3>
                </div>
                <ul class="unstyled my-account">
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Login or Register</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Forget my Password</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>My Account</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>My wishlist</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Order History</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Downloads</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Returns</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>TRANSACTIONS</a>
                    </li>
                    <li>
                        <a class="invarseColor" href="#"><i class="icon-caret-right"></i>Newlatters</a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</asp:Content>

