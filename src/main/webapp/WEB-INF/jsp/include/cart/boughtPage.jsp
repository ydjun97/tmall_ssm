<%--
  Created by IntelliJ IDEA.
  User: ydjun97
  Date: 2018/8/30
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8" isELIgnored="false" %>

<title>我的订单</title>

<script>
    var deleteOrder = false;
    var deleteOrderId = 0;
    $(function(){
        $("a.deleteOrderLink").click(function(){
            deleteOrder = false;
            deleteOrderId = $(this).attr("oid");
            $("#deleteConfirmModal").modal('show');
        });
        $("button.deleteConfirmButton").click(function(){
            deleteOrder = true;
            $("#deleteConfirmModal").modal('hide');
        });
        $("#deleteConfirmModal").on("hidden.bs.modal",function(){
            if(deleteOrder){
                var page = "foredeleteOrder";
                var oid = deleteOrderId;
                $.post(
                    page,
                    {"oid":oid},
                    function(result){
                        if("success" == result){
                            $("table.orderListItemTable[oid=" + oid + "]").hide();
                        }
                        else
                            location.href = "login";
                    }
                );
            }
        });

        $("a[orderStatus]").click(function(){
            var orderStatus = $(this).attr("orderStatus");
            if("all" == orderStatus){
                $("table[orderStatus]").show();
            }
            else{
                $("table[orderStatus]").hide();
                $("table[orderStatus="+orderStatus+"]").show();
            }
            $("a[orderStatus]").parent("div").removeClass("selectedOrderType");
            $(this).parent("div").addClass("selectedOrderType");
        });

        $("button.ask2delivery").click(function(){
            var link = $(this).attr("link");
            $(this).hide();
            $.ajax({
                url: link,
                success: function (result) {
                    alert("卖家已秒发，刷新当前页面，即可进行确认收货")
                }
            });
        });
    });
</script>

<div class="boughtDiv">
    <div class="orderType">
        <div class="selectedOrderType"><a orderStatus="all" href="#">所有订单</a></div>
        <div><a orderStatus="waitPay" href="#">待付款</a></div>
        <div><a orderStatus="waitDelivery" href="#">待发货</a></div>
        <div><a orderStatus="waitConfirm" href="#">待收货</a></div>
        <div><a orderStatus="waitReview" class="noRightborder" href="#">待评价</a></div>
        <div class="orderTypeLastOne"><a style="padding-top: 22.5px" class="noRightborder"> </a></div>
    </div>
    <div style="clear: both"></div>

    <div class="orderListTitle">
        <table class="orderListTitleTable">
            <tr>
                <td>宝贝</td>
                <td width="100px">单价</td>
                <td width="100px">数量</td>
                <td width="120px">实付款</td>
                <td width="100px">交易操作</td>
            </tr>
        </table>
    </div>

    <div class="orderListItem">
        <c:forEach items="${os}" var="o">
            <table class="orderListItemTable" orderStatus="${o.status}" oid="${o.id}">
                <tr class="orderListItemFirstTR">
                    <td colspan="2">
                        <b><fmt:formatDate value="${o.createDate}" pattern="yyyy-MM-dd hh:mm:ss" /></b>
                        <span>订单号：${o.orderCode}</span>
                    </td>
                    <td colspan="2">
                        <img width="13px" src="img/site/orderItemTmall.png" />天猫商场
                    </td>
                    <td><a href="#" class="wangwanglink">
                        <div class="orderItemWangWangGif"></div>
                    </a></td>
                    <td class="orderItemDeleteTD"><a oid="${o.id}" href="#" class="deleteOrderLink">
                        <span class="orderListItemDelete glyphicon glyphicon-trash"></span>
                    </a></td>
                </tr>
                <c:forEach items="${o.orderItems}" var="oi" varStatus="st">
                    <tr class="orderItemProductInfoPartTR">
                        <td class="orderItemProductInfoPartTD">
                            <img width="80" height="80" src="img/productSingle_middle/${oi.product.firstProductImage.id}.jpg" />
                        </td>
                        <td class="orderItemProductInfoPartTD">
                            <div class="orderListItemProductLinkOutDiv">
                                <a href="foreproduct?pid=${oi.product.id}">
                                        ${oi.product.name}
                                </a>
                                <div class="orderListItemProductLinkInnerDiv">
                                    <img src="img/site/creditcard.png" title="支持信用卡支付">
                                    <img src="img/site/7day.png" title="消费者保障服务,承诺7天退货">
                                    <img src="img/site/promise.png" title="消费者保障服务,承诺如实描述">
                                </div>
                            </div>
                        </td>
                        <td class="orderItemProductInfoPartTD" width="100px">
                            <div class="orderListItemProductOriginalPrice">
                                ￥<fmt:formatNumber value="${oi.product.originalPrice}" minFractionDigits="2" />
                            </div>
                            <div class="orderListItemProductPrice">
                                ￥<fmt:formatNumber value="${oi.product.promotePrice}" minFractionDigits="2" />
                            </div>
                        </td>
                        <c:if test="${st.count == 1}">
                            <td class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px"
                                rowspan="${fn:length(o.orderItems)}" valign="top" >
                                <span class="orderListItemNumber">${o.totalNumber}</span>
                            </td>
                            <td class="orderListItemProductRealPriceTD orderItemOrderInfoPartTD" width="120px"
                                rowspan="${fn:length(o.orderItems)}" valign="top" >
                                <div class="orderListItemProductRealPrice">
                                    ￥<fmt:formatNumber value="${o.total}" minFractionDigits="2"
                                                       maxFractionDigits="2" type="number" />
                                </div>
                                <div class="orderListItemPriceWithTransport">(含运费：￥0.00)</div>
                            </td>
                            <td class="orderListItemButtonTD orderItemOrderInfoPartTD" width="100px"
                                rowspan="${fn:length(o.orderItems)}" valign="top" >
                                <c:if test="${o.status == 'waitPay'}">
                                    <a href="forealipay?oid=${o.id}&total=${o.total}">
                                        <button class="orderListItemConfirm">付款</button>
                                    </a>
                                </c:if>
                                <c:if test="${o.status == 'waitDelivery'}">
                                    <span>待发货</span>
                                    <button class="btn btn-info btn-sm ask2delivery" link="admin_order_delivery?id=${o.id}">
                                        催卖家发货
                                    </button>
                                </c:if>
                                <c:if test="${o.status == 'waitConfirm'}">
                                    <a href="foreconfirmPay?oid=${o.id}">
                                        <button class="orderListItemConfirm">确认收货</button>
                                    </a>
                                </c:if>
                                <c:if test="${o.status == 'waitReview'}">
                                    <a href="forereview?oid=${o.id}">
                                        <button class="orderListItemReview">评价</button>
                                    </a>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>
        </c:forEach>
    </div>
</div>