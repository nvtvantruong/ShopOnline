<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ProductCompare.aspx.cs" Inherits="ProductCompare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
    <div class="container">
                <div class="titleHeader clearfix">
                    <h3>So Sánh Sản Phẩm</h3>
                </div>
                <div class="row">
                    <div class="span12">
                        <table class="table table-compare">
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Product</h3>
                                </td>
                                <td>
                                    <h4>
                                        <a href="#" class="invarseColor">Foliomania the designer</a>
                                    </h4>
                                </td>
                                <td>
                                    <h4>
                                        <a href="#" class="invarseColor">Foliomania the designer</a>
                                    </h4>
                                </td>
                                <td>
                                    <h4>
                                        <a href="#" class="invarseColor">Foliomania the designer</a>
                                    </h4>
                                </td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Image</h3>
                                </td>
                                <td>
                                    <a href="#">
                                        <img src="/css/images/92x92.jpg" />
                                    </a>
                                </td>
                                <td>
                                    <a href="#">
                                        <img src="/css/images/92x92.jpg" />
                                    </a>
                                </td>
                                <td>
                                    <a href="#">
                                        <img src="/css/images/92x92.jpg" />
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Price</h3>
                                </td>
                                <td class="price">
                                    <span class="strike-through">$200.00</span> $150.00
                                </td>
                                <td class="price">$99.99</td>
                                <td class="price">$100.00</td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Brand</h3>
                                </td>
                                <td>APEL Corparation1</td>
                                <td>APEL Corparation2</td>
                                <td>APEL Corparation3</td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Rating</h3>
                                </td>
                                <td>
                                    <ul class="rating">
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
                                    <small>Based On (2) Reviews</small>
                                </td>
                                <td>
                                    <ul class="rating">
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
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                    </ul>
                                    <small>Based On (16) Reviews</small>
                                </td>
                                <td>
                                    <ul class="rating">
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                        <li>
                                            <i class="star-off"></i>
                                        </li>
                                    </ul>
                                    <small>Based On (0) Reviews</small>
                                </td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Sammary</h3>
                                </td>
                                <td>
                                    Quisque tincidunt lacus et quam tempor elementum. Nulla vulputate tellus ac erat cursus tristique. Nulla non orci nec
                                    <a href="#" data-toggle="tooltip" data-title="More" data-placement="top">[...]</a>
                                </td>
                                <td>
                                    Quisque tincidunt lacus et quam tempor elementum. Nulla vulputate tellus ac erat cursus tristique. Nulla non
                                    <a href="#" data-toggle="tooltip" data-title="More" data-placement="top">[...]</a>
                                </td>
                                <td>
                                    Quisque tincidunt lacus et quam tempor elementum. Nulla vulputate tellus ac erat cursus tristique. Nulla non orci
                                    <a href="#" data-toggle="tooltip" data-title="More" data-placement="top">[...]</a>
                                </td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Weight</h3>
                                </td>
                                <td>5.00kg</td>
                                <td>11.00kg</td>
                                <td>4.00kg</td>
                            </tr>
                            <tr>
                                <td class="aligned-color">
                                    <h3 class="compare-title">Dimensions</h3>
                                </td>
                                <td>0.90cm x 0.09cm x 2.00cm</td>
                                <td>2.0cm x 0.00cm x 8.00cm</td>
                                <td>1.0cm x 0.00cm x 7.99cm</td>
                            </tr>
                            <tr>
                                <td class="aligned-color"></td>
                                <td>
                                    <button class="btn btn-small btn-primary" data-toggle="tooltip" data-title="+To Cart" data-placement="top"><i class="icon-shopping-cart"></i></button>
                                    <button class="btn btn-small" data-toggle="tooltip" data-title="+To Wishlist" data-placement="top"><i class="icon-heart"></i></button>
                                    <button class="btn btn-small btn-danger" data-toggle="tooltip" data-title="Remove" data-placement="top"><i class="icon-trash"></i></button>
                                </td>
                                <td>
                                    <button class="btn btn-small btn-primary" data-toggle="tooltip" data-title="+To Cart" data-placement="top"><i class="icon-shopping-cart"></i></button>
                                    <button class="btn btn-small" data-toggle="tooltip" data-title="+To Wishlist" data-placement="top"><i class="icon-heart"></i></button>
                                    <button class="btn btn-small btn-danger" data-toggle="tooltip" data-title="Remove" data-placement="top"><i class="icon-trash"></i></button>
                                </td>
                                <td>
                                    <button class="btn btn-small btn-primary" data-toggle="tooltip" data-title="+To Cart" data-placement="top"><i class="icon-shopping-cart"></i></button>
                                    <button class="btn btn-small" data-toggle="tooltip" data-title="+To Wishlist" data-placement="top"><i class="icon-heart"></i></button>
                                    <button class="btn btn-small btn-danger" data-toggle="tooltip" data-title="Remove" data-placement="top"><i class="icon-trash"></i></button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
</asp:Content>

