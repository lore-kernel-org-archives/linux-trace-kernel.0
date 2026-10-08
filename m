Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC2547075
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418135; cv=none; b=VTH/u8svfc3N0zrx0Iv7DBQQ/KG+MPRoQqjSb/LcUIIwCvW4KutPOqEClcAF16fRPLZi+xLiabkOM97xdHaGwrb9jK6T4pPxzWqSt1mayOvLhTvHu4Tv2pMbvUbii3zLG8XzO8F2phCTGpw1cbl+Et0c/6hGF0suNbtyFqLLT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418135; c=relaxed/simple;
	bh=x2KkVoMQI1NXabI2h0N7BvI/fSRL3yWbK0MtUn7sBiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQiK5oXIxel5ydkvhZlfgJWI25DxH16JTSIh3vPuMLzCgG6nMlO+gPSXDPCpj4w6v+h5lWsRkkHD8Q2BV+lTumyl9SqPNMorijaZviY/mD9UDDXyZ1nLN5Lu4YvR1kXJRiHqTK1PFmQwh/hCKv3iM7c5myNKM1LeukClZkx7pJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BiKb4yPm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZlgjjt8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BiKb4yPm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZlgjjt8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697Ltvaj1346091
	for <linux-trace-kernel@vger.kernel.org>; Thu, 8 Oct 2026 00:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=; b=BiKb4yPmNEbSAUIb
	14/I5FvUmndSoBTWkx57rSDWqaiDeLehQ5sxGe1Sn98VlfxJT91h0QuQaO4On1fb
	MH6TJZXimpc3VSgdRISOrgU+mBS9Jb7TRbAEDnV4xgWCUgpHzDwsT05EcGedJ+SG
	hkUyqBPEltDltkRKzjhU54UMgC6Gc9jVkho8TxSqVVaTegarMci1ett/Xsi5ssba
	R17vmJ76UwRl6ryUN0DdPfaG12Cxs4bShJpTkqGsoofitle/EKMn5iJFB0XS7ZbD
	FhhmJbb8H8V2AlCMDyBx06SkNwRImIAdiZig1f2kskhpe+EIpbIDQP7AdvgC1SI4
	zF71uQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe80ax2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Oct 2026 00:08:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-147be78cd56so16750811c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791418132; x=1792022932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=;
        b=aZlgjjt8dRdLa14ang7d5wSHVO3Nv5zHX63nzRCgun8VoZoDwn+foFyT+bsg2yuq3y
         77BzWB+Sb4DCsoI/Renajlte6Z8i6iKSNKeQYSxcTVJEycb9WrFmhJk4NMwwLpr4fbkT
         xyCynggGnIgOgmsCUjV+aLTbpRMweCQ/uxQRvnkGXFo5BLq+t3WOK4Tzd0HTZGfd1DCI
         dfMc/Q/D9HAFJsqphrGHi3TSiF8ax6T1hHYqJTsf8oVwNggQRY66IBvRi+hpkQBhLAaX
         2MwqunqIM1NxWIp7SNu1BGfwe2tQKr5qD0baOZkFdNf3CsNgJR5sXAPTYioZ4NPYUTAr
         sBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791418132; x=1792022932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=;
        b=pYA5xdv5ToVrrVpQYkI2P60tHmJhHJ4YAno2NK2wcjWcH+/TrXD+AGtZZ/D5Zex/3V
         RMUJoXqn2isfZ6Hpb89mT33W5fFA85TfwOxqvz3MI2HC9sSTHCxyK2doKnCydzl1krLZ
         a+BXkJXZ8XKEfDrk8bcQMq/cu/kO7qQlr193vmn9/P0LclS1AZGmCmr1pNFiYjilSXLZ
         bNkWWW8qRUpfAI8DBAsn9/0b8IV2ofiibNXR9X0RhD6mr6YYyJevwIIKPOIFpowcMw3C
         cbuH3ocNsvPbETUDF82A/4cm3gvGdtqDt9iCrXJP4/NUivrwjlJGod+8QIp5LQ3qcK6k
         4asw==
X-Forwarded-Encrypted: i=1; AKwUvBw3yWpZAMT+WC0lix+Qcf3D/QX/8jS//nbw2Ae2sYDoEL/a8Xn28Kt1vd1jS7GjX0XCpe/v3OPD8r5+QReHWEz2Kic=@vger.kernel.org
X-Gm-Message-State: AFuF++lpw+YDuyI82dH9EUS2oJJxAsQqm2knt5CXVh8y6wBIN3VO6hkJ
	TBA7IufcsbvHSRo8XYA80bUBOv1/qxg4KzSD8Z8HIdkM00zLIULVs/xTlfbSAVDjiOZ3EQY6IoK
	TYdpJt6gGs9tIQWujl37mC5uyvOTixhIktVZiicbGUC+tvrmNWpx5JgLG8xSzk1ZdIRTPIgxrky
	c=
X-Gm-Gg: AYBFou2FwMGiRuMxcmKYDLGUQqbVw7a9N5Z+xe7NiVWZZEs6kkeKIUnV21xdz2tRYvY
	3bi6zPcGmIkEG+wIgC+bOVHrNudER/qGctJuzTyhU94ZzrC7B/9EYXYaMdWxpGuGmtEw6eQtDsh
	PcWTQf9gohMDPWkZ+liWitUq3I4jSDQygnJlM8yemcmZ5JgGH7GwRPL7Rth3dgkNc1c0TuTbTYS
	A1IM1k3oTIsrc0DtvdLtZCMeFRn2M3P5lQd7KxhAKcySwr9+2DuFAl9XNgSpgcYqxwkPCsHZwDC
	rJx2Skx2tanyyJkdaekerX2W6wYYYfBYTnhP9MRpexsSJDwcu73o+H9p4ggozaJsNeRmhycv/EX
	21uOv22yzbVhjoMld7nLVqYeIhb55UjcGsVx0afVcQiRZga2LvAQ38w1qYeaHt9E=
X-Received: by 2002:a05:701b:241a:b0:151:ceb3:e105 with SMTP id a92af1059eb24-162047a17dcmr4490629c88.11.1791418132405;
        Wed, 07 Oct 2026 17:08:52 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:151:ceb3:e105 with SMTP id a92af1059eb24-162047a17dcmr4490583c88.11.1791418131519;
        Wed, 07 Oct 2026 17:08:51 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166216f39sm11910314c88.6.2026.10.07.17.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 17:08:51 -0700 (PDT)
Message-ID: <46903bb4-67ee-49a4-bf53-e7ba2c34256d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
 <20261001-hopping-belligerent-spider-876e7b@quoll>
 <fed665c5-3062-462b-928d-ab60976ce839@oss.qualcomm.com>
 <b12214fc-2e06-4e52-8bda-6c6f9a76bd7a@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <b12214fc-2e06-4e52-8bda-6c6f9a76bd7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX8pF35c6lUH9e
 obOpMp+HV6i4vOG+WkXI3dtwQGScO8seqJQkx5bH1wL4M0HHEJVJVnbb6wR8I/IO5nTqwLYLbjw
 rMudaVC1sUNurfnlSFclxmx54G6Rcvx7x289r8ERGe7gSmNYu+9g6sgoOUNxwJ4WLJvdAidgsID
 ei9/1kjBoTlr30FI6YLEIKUFtJyKu64Ifw3801VtxhNAcVKPWpTqchm0nDVwR1UqnQ9C7nLWkni
 ILg3h5gTb10W/ga/8fvHHCOKve/bWuMCDAoCpzl+scTrTkUl/Akoa7l7JQk2XCTs71fEAXZLoA/
 W7IRAkolvuYEM+M16cjBsbrpbDceKl+ombgGY9U4BD83/x+c0ZREY+nI1Zu+2m5vVWhJe43bk7b
 ULe4nPeMeHNXQUNUrCYr7DpVaGdeC488h2bbrOjpqlStfBa5D74P9eUFrykXQPUz5wPgUhB1RI3
 b7GJMSXR5xDb2uSyAXQ==
X-Proofpoint-GUID: P8r_ofNbAUCtGDXS5KKTRqe4n0fbFLZn
X-Proofpoint-ORIG-GUID: P8r_ofNbAUCtGDXS5KKTRqe4n0fbFLZn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfXzBIzK23WjAHg
 ASWSrC3uSoJiyXi5vLFt2SIzBJ8qsadF3NdijQ8afnyHyUcl1lp8ovpC57hmqPJ2WY3D2qetYXF
 rk2iQLjMV0vc5bqckhT/TNd7cdWsrW4=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6df15 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=8u56npouWohDfDDlGUsA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080000

On 10/7/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 07/10/2026 01:51, Oreoluwa Babatunde wrote:
>> On 10/1/2026 1:50 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
>>>> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
>>>> hardware block that accelerates compression and decompression of memory
>>>> pages.
>>>>
>>>> Provide the urgent command path for synchronous single-page compression and
>>>> decompression. This exposes the low-latency operations needed by
>>>> compressed-memory users such as zram, especially for page decompression on
>>>> the read path.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>>>> ---
>>>>    drivers/soc/qcom/Kconfig          |  14 +
>>>>    drivers/soc/qcom/Makefile         |   1 +
>>>>    drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>>>>    drivers/soc/qcom/qpace_internal.h |  84 ++++
>>>>    include/linux/soc/qcom/qpace.h    | 154 ++++++
>>>>    5 files changed, 1017 insertions(+)
>>>>    create mode 100644 drivers/soc/qcom/qpace.c
>>>>    create mode 100644 drivers/soc/qcom/qpace_internal.h
>>>>    create mode 100644 include/linux/soc/qcom/qpace.h
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index 535c8619197b..6bcb86dcd726 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>
>>> Sorry, but no. Soc is not a dumping ground. This has clear function of
>>> compression offload, so it should have some dedicated maintainers like
>>> other offload engines.
>>
>> The reason for putting this in soc/qcom is because this is a qcom HW
> 
> Every qcom HW driver is a qcom HW driver and they DO NOT go to drivers/soc.
> 
> Again: soc is not a dumping ground.
> 
ACK. We are looking at the crypto driver to see if it fits our use of 
the qpace HW block.

Do you have other suggestions for where this would better fit besides 
the crypto framework?

Thanks,
Oreoluwa

