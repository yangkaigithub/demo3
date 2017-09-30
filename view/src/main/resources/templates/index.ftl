<!DOCTYPE html>

<html lang="en">

<body>

<table border="1" style="border-collapse: collapse">

<#list commodityMap?keys as itemkey1>
    <tr>
        <td>${itemkey1}</td>
        <#assign map1 = commodityMap[itemkey1]>
        <#list map1?keys as item2Key>
            <td>${item2Key} : ${map1[item2Key]}</td>
        </#list>
    </tr>

</#list>
</table>

<#--<#list commodityMap?keys as itemkey1>-->
    <#--${itemkey1}:-->
    <#--<#assign map1 = commodityMap[itemkey1]>-->
    <#--<#list map1?keys as item2Key>-->
        <#--${map1[item2Key]},-->
    <#--</#list>-->
<#--<br>-->
<#--</#list>-->
<#if (pageNum>1)>
<a href="/demo3/nextpage?pageNum=${pageNum-1}">
    <button type="button">beforepage</button>
</a>
<br>
</#if>
<a href="/demo3/nextpage?pageNum=${pageNum+1}">
        <button type="button">nextpage</button>
</a>

<form action="/demo3/topage" method="get">
    跳转至: <input type="text" name="pageNum" />
    <input type="submit" value="跳转" />
</form>

</body>

</html>  