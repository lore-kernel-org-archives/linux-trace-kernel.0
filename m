Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79F8EDE9B8
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 15 Sep 2023 01:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjIOB5C (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 21:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjIOB5A (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:57:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650D726A4;
        Thu, 14 Sep 2023 18:56:56 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1jH2R028756;
        Fri, 15 Sep 2023 01:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BdeUHQ3r/cEj+7oxeY7bSUJgPg81T4oGvKKm9M2SpXY=;
 b=KkDtW2s6cPyMuaq0a6mAKYJV6jJOtSqWGQpO2n9zEKXAQsG3W3T7o+quf5UgoD7j3Jnd
 cB8UnQ4bdL38Ri2hyTta4ViU1DWQDOceHwFF+9guS0CHlecsRbE2oQJXKeTLcQ4Bx0k8
 A4Jz18bB8Y+00l5VEO0Iq6FAw7KaRgmFopHjJLjuXTPJpF/Q7byoKZHQW2MYRMAvll86
 NeQ4uFe4fes6mDGLv83ESIOOitgBwvu5GCiZGDbB6P+4wqnBL/XzG+iC7AWarbcme4Dp
 VHow8kI2+e6XjfIhhuI8qCRiFAvofziSpg4Nt+p+rDzM4OVxako0FiNdEmeFJqj1pw0v Yg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4dvrg0f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 01:56:15 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F1uF3W025192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 01:56:15 GMT
Received: from [10.253.37.179] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 18:56:12 -0700
Message-ID: <e7120ef7-683d-7a92-1f8f-e125b7ccdf6a@quicinc.com>
Date:   Fri, 15 Sep 2023 09:56:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/8] usb: gadget: add anonymous definition in some struct
 for trace purpose
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
 <20230914100302.30274-3-quic_linyyuan@quicinc.com>
 <073cbfb2-2f18-4bf7-a313-b16bbcefa8e0@rowland.harvard.edu>
 <0c2ba115-826e-40d6-73ac-7ed67302c8eb@quicinc.com>
 <eae2be47-f489-4f1b-91c7-f2f81304bfdb@rowland.harvard.edu>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <eae2be47-f489-4f1b-91c7-f2f81304bfdb@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n5BsXm4pWo34lpMZM5NUQhRxjijFl0-5
X-Proofpoint-GUID: n5BsXm4pWo34lpMZM5NUQhRxjijFl0-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=300 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150015
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


On 9/15/2023 9:51 AM, Alan Stern wrote:
> On Fri, Sep 15, 2023 at 09:02:48AM +0800, Linyu Yuan wrote:
>> On 9/14/2023 10:54 PM, Alan Stern wrote:
>>> You didn't include the version number in the Subject: line.  Undoubtedly
>>> Greg's automatic error checker will warn you about this.  Unless the
>>> version number is clearly marked for each patch, it's difficult for his
>>> programs to tell which email message contains the most recent version.
>>>
>>> On Thu, Sep 14, 2023 at 06:02:56PM +0800, Linyu Yuan wrote:
>>>> Some UDC trace event will save usb udc information, but it use one int
>>>> size buffer to save one bit information of usb udc, it is wast trace
>>>> buffer.
>>>>
>>>> Add anonymous union which have one u32 member can be used by trace event
>>>> during fast assign stage to save more entries with same trace ring buffer
>>>> size.
>>>>
>>>> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
>>>> ---
>>> And you didn't include the version change information here, below the
>>> "---" line.
>>>
>>> Apart from that, this is a _lot_ better than before!  I don't know if
>>> Greg will think this change is worth merging, but at least now it's
>>> possible to read the code and understand what's going on.
>>
>> according Steven's comment, maybe will always save data in little endian at
>> trace event
>>
>> fast assign stage.
>>
>> it will add definition of bit field back.
> Yes, that would be even better because you wouldn't have to change the
> definition of struct usb_gadget or struct usb_endpoint at all.  The fast
> assign stage can simply do:
>
> 	__entry->dw1 = (g->sg_supported << 0) |
> 			(g->is_otg << 1) |
> 			...
>
> and then you can easily access the individual bits in __entry.  It
> wouldn't be as fast but it would still save a lot of space.


how about __entry->dw1 = cpu_to_le32(g->dw1) ?




>
> Alan Stern
