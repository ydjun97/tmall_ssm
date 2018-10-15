<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/30
  Time: 0:35
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>购物车</title>

<script>
    function syncCreateOrderButton() {
        var selectAny = false;
        $("img.cartProductItemIfSelected").each(function(){
            if("selectit" == $(this).attr("selectit")){
                selectAny = true;
            }
        });
        if(selectAny){
            $("button.createOrderButton").removeAttr("disabled");
            $("button.createOrderButton").css("background-color", "#c40000");
        }
        else{
            $("button.createOrderButton").attr("disabled", "disabled");
            $("button.createOrderButton").css("background-color", "#AAAAAA");
        }
    }

    function syncSelect() {
        var selectAll = true;
        $("img.cartProductItemIfSelected").each(function(){
            if("false" == $(this).attr("selectit")){
                selectAll = false;
            }
        });
        if(selectAll) {
            $("img.selectAllItem").attr("selectit", "selectit");
            $("img.selectAllItem").attr("src", "img/site/cartSelected.png");
        }
        else {
            $("img.selectAllItem").attr("selectit", "false");
            $("img.selectAllItem").attr("src", "img/site/cartNotSelected.png");
        }
    }

    function calcCartSumPriceAndNumber(){
        var sum = 0;
        var total = 0;
        $("img.cartProductItemIfSelected[selectit='selectit']").each(function(){
            var oiid = $(this).attr("oiid");
            var price = $("span.cartProductItemSmallSumPrice[oiid="+oiid+"]").text();
            price = price.replace(/,/g, "");
            price = price.replace(/￥/g, "");
            sum += new Number(price);

            var num = $("input.orderItemNumberSetting[oiid="+oiid+"]").val();
            total += new Number(num);
        });
        $("span.cartTitlePrice").html("￥" + formatMoney(sum));
        $("span.cartSumPrice").html("￥" + formatMoney(sum));
        $("span.cartSumNumber").html(total);
    }

    function syncPrice(pid, num, price){
        var page = "foreChangeOrderItem";
        $.post(
            page,
            {"pid":pid, "number":num},
            function(result){
                if("success" != result){
                    location.href = "login";
                }
            }
        );

        $("input.orderItemNumberSetting[pid="+pid+"]").val(num);
        $("span.cartProductItemSmallSumPrice[pid="+pid+"]").html("￥" + formatMoney(num * price));
        calcCartSumPriceAndNumber();
    }

    var deleteOrderItem = false;
    var deleteOrderItemId = 0;
    $(function(){
        $("a.deleteOrderItem").click(function(){
            deleteOrderItem = false;
            deleteOrderItemId = $(this).attr("oiid");
            $("#deleteConfirmModal").modal('show');
    });
    $("button.deleteConfirmButton").click(function(){
        deleteOrderItem = true;
        $("#deleteConfirmModal").modal('hide');
    });
    $("#deleteConfirmModal").on("hidden.bs.modal",function(){
        if(deleteOrderItem){
            var page = "foredeleteOrderItem";
            var oiid = deleteOrderItemId;
            $.post(
                page,
                {"oiid":oiid},
                function(result){
                    if("success" == result){
                        $("tr.cartProductItemTR[oiid=" + oiid + "]").remove();
                    }
                    else
                        location.href="login";
                }
            );
        }
    });

        $("img.cartProductItemIfSelected").click(function(){
            if("selectit" == $(this).attr("selectit")){
                $(this).attr("selectit", "false");
                $(this).attr("src", "img/site/cartNotSelected.png");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
            }
            else{
                $(this).attr("selectit", "selectit");
                $(this).attr("src", "img/site/cartSelected.png");
                $(this).parents("tr.cartProductItemTR").css("background-color", "#fff8e1");
            }

            syncCreateOrderButton();
            syncSelect();
            calcCartSumPriceAndNumber();
        });
        $("img.selectAllItem").click(function(){
            if("selectit" == $(this).attr("selectit")){
                $("img.cartProductItemIfSelected").each(function(){
                    $(this).attr("selectit", "false");
                    $(this).attr("src", "img/site/cartNotSelected.png");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#fff");
                });
                $("img.selectAllItem").attr("selectit", "false");;
                $("img.selectAllItem").attr("src", "img/site/cartNotSelected.png");
            }
            else{
                $("img.cartProductItemIfSelected").each(function(){
                    $(this).attr("selectit", "selectit");
                    $(this).attr("src", "img/site/cartSelected.png");
                    $(this).parents("tr.cartProductItemTR").css("background-color", "#fff8e1");
                });
                $("img.selectAllItem").attr("selectit", "selectit");
                $("img.selectAllItem").attr("src", "img/site/cartSelected.png");
            }

            syncCreateOrderButton();
            calcCartSumPriceAndNumber();
        });

        $("input.orderItemNumberSetting").keyup(function(){
            var pid = $(this).attr("pid");
            var stock = $("span.orderItemStock[pid="+pid+"]").text();
            var price = $("span.orderItemPromotePrice[pid="+pid+"]").text();

            var num = $(this).val();
            num = parseInt(num);
            if(isNaN(num))
                num = 1;
            if(num <= 0)
                num = 1;
            if(num > stock)
                num = stock;

            syncPrice(pid, num, price);
        });
        $("a.numberMinus").click(function(){
            var pid = $(this).attr("pid");
            var price = $("span.orderItemPromotePrice[pid="+pid+"]").text();
            var num = $("input.orderItemNumberSetting[pid="+pid+"]").val();

            num--;
            if(num <= 0)
                num = 1;

            syncPrice(pid, num, price);
        });
        $("a.numberPlus").click(function(){
            var pid = $(this).attr("pid");
            var stock = $("span.orderItemStock[pid="+pid+"]").text();
            var price = $("span.orderItemPromotePrice[pid="+pid+"]").text();
            var num = $("input.orderItemNumberSetting[pid="+pid+"]").val();

            num++;
            if(num > stock)
                num = stock;

            syncPrice(pid, num, price);
        });

        $("button.createOrderButton").click(function(){
            var params = "";
            $("img.cartProductItemIfSelected").each(function(){
                if("selectit" == $(this).attr("selectit")){
                    var oiid = $(this).attr("oiid");
                    params += "&oiid=" + oiid;
                }
            });
            params = params.substring(1);
            location.href = "forebuy?" + params;
        });
    });
</script>

<div class="cartDiv">
    <div class="cartTitle pull-right">
        <span>已选商品 (不含运费) </span>
        <span class="cartTitlePrice">￥0.00</span>
        <button class="createOrderButton" disabled="disabled">结 算</button>
    </div>

    <div class="cartProductList">
        <table class="cartProductTable">
            <thead>
            <tr>
                <th class="selectAndImage">
                    <img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png"> 全选
                </th>
                <th>商品信息</th>
                <th>单价</th>
                <th>数量</th>
                <th width="120px">金额</th>
                <th class="operation">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${ois}" var="oi" varStatus="st">
                <tr oiid="${oi.id}" class="cartProductItemTR">
                    <td>
                        <img selectit="false" oiid="${oi.id}" class="cartProductItemIfSelected"
                             src="img/site/cartNotSelected.png" />
                        <a style="display:none" href="#nowhere">
                            <img src="img/site/cartSelected.png">
                        </a>
                        <img class="cartProductImg" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" />
                    </td>
                    <td>
                        <div class="cartProductLinkOutDiv">
                            <a href="foreproduct?pid=${oi.product.id}" class="cartProductLink">
                                    ${oi.product.name}
                            </a>

                            <div class="cartProductLinkInnerDiv">
                                <img src="img/site/creditcard.png" title="支持信用卡支付">
                                <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                            </div>
                        </div>
                    </td>
                    <td>
                        <span class="cartProductItemOringalPrice">
                            ￥${oi.product.originalPrice}
                        </span>
                        <span class="cartProductItemPromotionPrice">
                            ￥${oi.product.promotePrice}
                        </span>
                    </td>
                    <td>
                        <div class="cartProductChangeNumberDiv">
                            <span class="hidden orderItemStock " pid="${oi.product.id}">${oi.product.stock}</span>
                            <span class="hidden orderItemPromotePrice " pid="${oi.product.id}">${oi.product.promotePrice}</span>

                            <a pid="${oi.product.id}"  class="numberMinus" href="#">-</a>
                            <input pid="${oi.product.id}" oiid="${oi.id}" class="orderItemNumberSetting"
                                   autocomplete="off" type="text" value="${oi.number}" />
                            <a pid="${oi.product.id}" stock="${oi.product.stock}" class="numberPlus" href="#">+</a>
                        </div>
                    </td>
                    <td><span class="cartProductItemSmallSumPrice" oiid="${oi.id}" pid="${oi.product.id}" >
                        ￥<fmt:formatNumber value="${oi.product.promotePrice * oi.number}" minFractionDigits="2"/>
                    </span></td>
                    <td>
                        <a class="deleteOrderItem" oiid="${oi.id}" href="#nowhere">删除</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="cartFoot">
        <img selectit="false" class="selectAllItem" src="img/site/cartNotSelected.png">
        <span>全选</span>

        <div class="pull-right">
            已选商品 <span class="cartSumNumber">0</span> 件 合计 (不含运费):
            <span class="cartSumPrice">￥0.00</span>
            <button class="createOrderButton" disabled="disabled">结  算</button>
        </div>
    </div>
</div>