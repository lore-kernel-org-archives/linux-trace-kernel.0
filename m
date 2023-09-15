Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31900EE0205
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 15 Sep 2023 02:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjIOCZn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 22:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjIOCZn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:25:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0D2134;
        Thu, 14 Sep 2023 19:25:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F2CMLv029724;
        Fri, 15 Sep 2023 02:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WGLmolsn3n10wJUD3dpZEjP6Y0CKmW7YRZcvPnRXP9M=;
 b=GARvPkfesNfpBEsQycDaldGriQTBdMIuwL4ZpAeTdcqDlpbh+oyiHaw3YIKzjOiDapK3
 ILEZodXikqlNFUl+xtonGCOrXRqphTc8jswHlHyjFuR8siEBfigNe//e3aoPy3QJEIdi
 Q8NapAP7JsIffN07zmmeFTjL5m3+HpqejA4BFvc6sYaRMI/t7g3HE0r+AN/TK//9dq0k
 yn/owuNTNgL1oOndoUYMoV2YVRm3cZrpOKMiAKgejq08TS9Jy0yY+sXtHeyvyb3nDKLt
 a4YDlTyxXh9Hu8ngPy4a+C3YtBNFkExp/skbYri7VI1SezUr400kgEnxpBmj8TdPoHey cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4e9br10s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:25:25 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F2POLm001095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 02:25:24 GMT
Received: from [10.253.37.179] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 19:25:21 -0700
Message-ID: <24a6305d-2d47-7502-e26e-75a4e08e47b1@quicinc.com>
Date:   Fri, 15 Sep 2023 10:25:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/8] usb: udc: trace: reduce buffer usage of trace event
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
 <20230914100302.30274-4-quic_linyyuan@quicinc.com>
 <20230914125410.432ca343@gandalf.local.home>
 <dc54b48f-f2ad-9948-f50f-a6f2c004c77c@quicinc.com>
 <20230914221644.6f4517b3@rorschach.local.home>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230914221644.6f4517b3@rorschach.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Cd6NmDH9eWHc1kNP8KNJ5C6y0LD1Vqne
X-Proofpoint-GUID: Cd6NmDH9eWHc1kNP8KNJ5C6y0LD1Vqne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_02,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=633 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150019
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


On 9/15/2023 10:16 AM, Steven Rostedt wrote:
> On Fri, 15 Sep 2023 09:11:06 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>>>> +		snprintf(__s, 9, "ep%d%s", te.address, \
>>>> +			(te.caps.dir_in && te.caps.dir_out) ? "" : \
>>>> +			te.caps.dir_in ? "in" : "out");
>>> Note, there's a temp buffer trace_seq 'p' available for use as well. See
>>> both include/trace/events/libata.h and include/trace/events/scsi.h:
>>>
>>>     const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
>>>     #define __parse_status(s) libata_trace_parse_status(p, s)
>>>
>>> I think that can be used instead of adding this TP_printk_init().
>>
>> the reason add TP_printk_init() because when i first design some macro
>> which not
>>
>> related to tracepoint,  it use too much stack.
>>
> Not sure what you mean about 'uses too much stack'. This is called by
> the reading code and not some arbitrary location, and the above macros
> are done in the same location as your "init" call, so I'm not sure how
> that makes a difference on the stack.
>
>> but i think  TP_printk_init()  is good as it following most common way
>> to print.
>>
> I really do not want to add more versions of TRACE_EVENT() that I need
> to maintain unless there is a really good reason to do so.
>
> And I really don't want to encourage the use of a "TP_printk_init()"
> because that just encourages more use cases that will make it hard for
> user space to parse the TP_printk().


that's true, it is difficult to understand, when i add this new, it 
report build issue.


will consider other way for this case without new tracepoint macro.



>
> -- Steve
