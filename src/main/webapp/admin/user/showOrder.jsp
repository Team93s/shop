<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="modal fade" id="myOrderModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
           		<h4 class="modal-title" id="orderOwner"></h4>
            </div>
            <div class="modal-body">
                <table class="table table-bordered" >
                    <tr>
                        <th>订单号</th>
                        <th>订单地址</th>
                        <th>订单日期</th>
                        <th>订单状态</th>
                    </tr>
                    <tbody id="customOrders">

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
