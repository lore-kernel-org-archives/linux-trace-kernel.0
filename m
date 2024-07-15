Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6518E774;
	Mon, 15 Jul 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053513; cv=none; b=nC8CD677CZejRany/HePkA7h0Q8A98q9hjGMElOZwu9i5l1DDdnfmw6dItSAb9MiZIR3DOD83aaO4dOXRtjlPSeDY4wmCzmRBS8XKwnRPBEzTEJXY+kpEjhsxC5+OaE4ryqfviBOYCmdUUr5cv6PtUA/tnOBVVFgs8pbYnc86aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053513; c=relaxed/simple;
	bh=R67XFnzLZ9QjB2uq+uY/ljL1d84gWX+aFz8a2q3uJG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M/OAKNqqIfT0WDGEeUS/xuUvub+nBL2/FJN3C5hKagNDTCUm0dYYk7jBRJDZPJ+4VhUczt59uNBKvOAwDuojiQdToUjZRzlezZOtv8z1GfuU+9PP+glr+EzqDj6KU3JWh3nSk6ZIMMweNPCisESg2j/Iw0ks3ft1Aumh9NATDXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SCKVab60; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SCKVab60"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FBQAk7012006;
	Mon, 15 Jul 2024 14:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lj3QQfvcZuDIukTmBT+g9CVo+hAALIMQsiEa519RY48=; b=SCKVab60QFt1pdbj
	nm3Gh6bzlnR1QrKymJDAeFUixK2tkyXBfPr+MW643H6SOf0eZi2CVETfnI4KMLdt
	KiI+OjNbvAj2vzVvzwwpWV4sIbPItJyfQ29+jpo5zVRjCwKTkSXZRBypELhm4Foq
	GZiAsf+a7Md/0yTqf1g9EeZnQG+A4YdFe3ODk6XjiP9bRPC6UeiUgqDp6pPsaJfr
	O0fg/gqYmrRI8z4jiwinrgquf4uEAgIkchuqAO/pNPXqzd2UGVCQE5ro/CChGIto
	ASGP70Q5wEs57sxJpmeGlEdf0FzlJDd20sfn+yRTPap4sJhVE3nYzw+RGrWyctuS
	ogNMbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bexncn0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 14:25:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FEP26r009233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 14:25:02 GMT
Received: from [10.48.246.224] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 07:25:02 -0700
Message-ID: <f60c8a62-86f3-4083-87a5-bf6343d58f46@quicinc.com>
Date: Mon, 15 Jul 2024 07:25:00 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: wuqiang.matt <wuqiang.matt@bytedance.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
 <7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
 <20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
 <3edb1529-744c-4b7a-acc9-12e166ada738@quicinc.com>
 <20240715181206.f0b6c9e6bfc548c2b729b76b@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715181206.f0b6c9e6bfc548c2b729b76b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eH4OmE_C52hyItjbv_-6-Fnt6sopEy0s
X-Proofpoint-GUID: eH4OmE_C52hyItjbv_-6-Fnt6sopEy0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150113

On 7/15/2024 2:12 AM, Masami Hiramatsu (Google) wrote:
> On Thu, 11 Jul 2024 11:14:20 -0700
> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
>> On 6/2/24 23:45, Masami Hiramatsu (Google) wrote:
>>> On Mon, 3 Jun 2024 11:25:59 +0800
>>> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
>>>
>>>> On 2024/6/1 08:31, Jeff Johnson wrote:
>>>>> make allmodconfig && make W=1 C=1 reports:
>>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
>>>>>
>>>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>>>
>>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>>> ---
>>>>>    lib/test_objpool.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
>>>>> index bfdb81599832..5a3f6961a70f 100644
>>>>> --- a/lib/test_objpool.c
>>>>> +++ b/lib/test_objpool.c
>>>>> @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
>>>>>    module_init(ot_mod_init);
>>>>>    module_exit(ot_mod_exit);
>>>>>    
>>>>> -MODULE_LICENSE("GPL");
>>>>> \ No newline at end of file
>>>>> +MODULE_DESCRIPTION("Test module for lockless object pool");
>>>>> +MODULE_LICENSE("GPL");
>>>>>
>>>>> ---
>>>>> base-commit: b050496579632f86ee1ef7e7501906db579f3457
>>>>> change-id: 20240531-md-lib-test_objpool-338d937f8666
>>>>>
>>>>
>>>> Looks good to me. Thanks for the update.
>>>>
>>>> I added Masami Hiramatsu and linux-trace in the loop.
>>>>
>>>> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
>>>
>>> Thanks, let me pick this to probes/for-next branch.
>> Following up since I don't see this in linux-next.
>> I'm hoping to have these warnings fixed tree-wide in 6.11.
>>
>> /jeff
>>
> 
> Can you resend it to me and linux-trace-kernel with Matt's
> Reviewed-by? Also, can you add the warning message?

v2 sent. note the warning message was already there.

/jeff

