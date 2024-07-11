Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6C288A4;
	Thu, 11 Jul 2024 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721672; cv=none; b=Biz4uQr5nHksYJ+Yz9zZlEaR7yRbAiNACV8qu6+szOgs/yzA23D0+qUfkn/M76IwM/gRKxcp8wymFBNJ+3n46bqHBtpRrrN7pZvgxGMSPCONZJYPWcRtb807VR7azSwc4lAU1nAPQVmSzwHHh/SivsRpCa8qdXUnkQ/KGwju3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721672; c=relaxed/simple;
	bh=1PBJAd8JXbGMV647ts8nBIXJaoPwXPcfsrv42PPsOII=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BCQ4woj2x2UDJTofL+Zy8j951R+2Uu5SU0uIhvdr1jL9SPQDUjLvSzoLTGUOqSQl6wzLcJRqYkcKeoRnRU1oDvrxrgOWVLZOyiOXfWv8K5LJUmEdFF5264BBQiubVnWG9wWOKSNc/Yz4eLdFOhcvTNZ8fE877cE5G5TYlV9ALG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CE30bgye; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CE30bgye"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BDNtlB008742;
	Thu, 11 Jul 2024 18:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cn+Wvm+64AseXQQ6NMV+pY0w86NbZKERJ7AeFRggcyE=; b=CE30bgyeklJLR1tj
	RInkFSupG4zYJzMm/yNzYKmJXnyWodLuh/ZEKIrhRmCGUC9fhPU51f9ekAz+wgRT
	BTFRyobZn/yC48bb6MeJ7+zjP7mcX4wWGwKfGRL9yjooQ1VZjvnF9pZBcd7wIb5K
	3TIzNNNr+WpXrvZaB/CzcwI75TLRukEWF8l9L2gScCH7wi/V+dQGbEtAuNOBSPcy
	85Iw3o5TaWJsZRwE0hnO9zLqpn3+sGG+Vs0XdmNkVY+E59416jTpLICTkKjzC+dZ
	jqlEqaPwz4BkQ5ToqA/poONX/Y9PtKHvhbw/gG7JOjdI0RO6bWE4gg9g1u4wIRiQ
	Rzl9WQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x51de0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:14:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BIELuB004955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:14:21 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 11:14:21 -0700
Message-ID: <3edb1529-744c-4b7a-acc9-12e166ada738@quicinc.com>
Date: Thu, 11 Jul 2024 11:14:20 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION() macro
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        wuqiang.matt
	<wuqiang.matt@bytedance.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
 <7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
 <20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cl6ZkK40q_KP1TLTMHcOVob2iY8w3MeY
X-Proofpoint-ORIG-GUID: cl6ZkK40q_KP1TLTMHcOVob2iY8w3MeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110127

On 6/2/24 23:45, Masami Hiramatsu (Google) wrote:
> On Mon, 3 Jun 2024 11:25:59 +0800
> "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> 
>> On 2024/6/1 08:31, Jeff Johnson wrote:
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
>>>
>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> ---
>>>    lib/test_objpool.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
>>> index bfdb81599832..5a3f6961a70f 100644
>>> --- a/lib/test_objpool.c
>>> +++ b/lib/test_objpool.c
>>> @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
>>>    module_init(ot_mod_init);
>>>    module_exit(ot_mod_exit);
>>>    
>>> -MODULE_LICENSE("GPL");
>>> \ No newline at end of file
>>> +MODULE_DESCRIPTION("Test module for lockless object pool");
>>> +MODULE_LICENSE("GPL");
>>>
>>> ---
>>> base-commit: b050496579632f86ee1ef7e7501906db579f3457
>>> change-id: 20240531-md-lib-test_objpool-338d937f8666
>>>
>>
>> Looks good to me. Thanks for the update.
>>
>> I added Masami Hiramatsu and linux-trace in the loop.
>>
>> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
> 
> Thanks, let me pick this to probes/for-next branch.
Following up since I don't see this in linux-next.
I'm hoping to have these warnings fixed tree-wide in 6.11.

/jeff

