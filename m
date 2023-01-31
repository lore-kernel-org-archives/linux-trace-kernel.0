Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C67C636D3
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 02:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAaCGd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 30 Jan 2023 21:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAaCGc (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:06:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3D227BD;
        Mon, 30 Jan 2023 18:06:31 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V103x5013269;
        Tue, 31 Jan 2023 02:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fla+bs46GocOCgOn3lWBYaq7sBN2zogkWbNcQ/SHbu4=;
 b=V0xDw5iT1fZzIRa4DdNekR+D2WfLV2+3PRSmZsZkStq87CEteeOTIv/FKuhlidZB6B9h
 hR9xCQ4xCCnkwX2Lk5z0t9iYA8YohJpS5zKFY3qo7LlqarguckFCIf4/crED6S4eW5c0
 fUDkVHAUzQZNsb0MLxkIT9RJh8wa0TxMLCe1SWkkIJIkD3uEQcTQcAWn8NvRBrItlvmu
 7hQxhR2Z1rjngHTqhQM5cSTRM+EIQPkkaxpHh8JCuwdPEQjWPqxz5nB1zaRCRDuRSarY
 CJqiq8CwM+xyQkb1TwTqxgkeGismcJm2bx0+fEJlaDG7BeRESZ8tLLY/hDtDZpBus7ex 9w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdpw9th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:06:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30V26RGE016887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:06:27 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 18:06:25 -0800
Message-ID: <e2735a3a-4a9b-8b3a-0671-b3f56187cbe2@quicinc.com>
Date:   Tue, 31 Jan 2023 10:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5] trace: acquire buffer from temparary trace sequence
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
 <28cd9aca-1945-ceed-2756-162132d576ef@quicinc.com>
 <20230130143041.713c4c7b@gandalf.local.home>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <20230130143041.713c4c7b@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 85BAjxRosDVTYvw3mRwuvx9suAOPStl0
X-Proofpoint-ORIG-GUID: 85BAjxRosDVTYvw3mRwuvx9suAOPStl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_19,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=554
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310016
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


On 1/31/2023 3:30 AM, Steven Rostedt wrote:
> On Mon, 30 Jan 2023 21:14:01 +0800
> Linyu Yuan <quic_linyyuan@quicinc.com> wrote:
>
>> @Steven current design is not safe, as user still can write to buffer
>> which have no enough space.
> I'm assuming that it would never use more that DWC3_MSG_MAX, and that's set
> to 500. The size of the trace_seq() is 4096 (or PAGE_SIZE), I doubt it will
> ever be an issue.
>
> How do you think the user can still write more than enough?


yes, agree it will be safe for dwc3, but i don't know if any possible 
hacker,

as the function always return a valid pointer even when hacker input a 
large size.


>
> -- Steve
>
>> do you think it is better to improve dwc3 trace in fast assign path ?
>>
>
