Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1511A680B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070728; cv=none; b=IlM8i8Achgl4A2kDLGgI1IXPZm4FbV59wdiSUKdIYm3TAUZ+k2Ispca/XY6LvDgEYE1GNuM+OBHI8EwSvE8Em+s8ale9kzfhmswhS4OHOvCuRE9cFDWifNCDqcsW0HI4E2YCFQ7YjHYhuIzhv9JSqs+m0Ij3IKKZXBKWBnyiQE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070728; c=relaxed/simple;
	bh=OKl8FxF8IEbfAFyPdAhMBb2ftzDCnYFKMb5F9NMa5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnpVvok+Z23xUW+FeMSpj0mrI/4L/C+ESLoeUggaQ3+TxTLsACR3oxjYRngg0+7+AG8tYGz5KbdEnYGlBVmsZNbHdvJjEi09qo4sSu5qbuPzLgPyNN/pzWMEm7f6oJx4ol2gkKAtAu9eZCSp9uuQbQ2ldWv0HnKh/iOAjiR4vSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddDE0uF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbK9FDGe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddDE0uF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbK9FDGe"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAQLeq1596905
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=; b=ddDE0uF9JmMiZi89
	0pSWhIStLk91p2Oa3mAq/K1DHJ/UGyhTK7OBu9A1DP5NMKgCP1x+0lmeuCgCm2Bu
	Hsp6velGQMQyWu00dsapalMCS0WjjRbF8S2f5a2Scz2e1i/k1pTD5vQmEHhdzAc4
	WVdM0z0TYH09b3weQM+SRt7JJh2Ad1VaxmNtzQnRGkjN/gZv5x9ZLYPJQDy04Nt6
	RupmY9mF3nzlHgRIy0X9bnYJ4P0KH3AAMW+bSDEvcE9kwcR9ircbLGBCyCZ70Ff6
	f+uUBrmaeMyxIuWe+yLHg4gZltdylfDn3As63uqQgvGlgAubXYV5h0e1mQG6eP7e
	J8SkgQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2v8ng1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:25:25 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c29a61f144so668576137.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792070725; x=1792675525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=;
        b=LbK9FDGeeul3ZXiFJAkavP8OF2Qi8QtX4pI6552Yf3nYGpUXCo9iRTEX7/jYQdsMte
         7LkZqExCS+PfhL4zSwaE/ryRkwTkdvXwNDGAR+TKIikJ+7zBqbFKviPySIrN0eaHfhAa
         42XAfDl7NK6VaTeXiFQKcd+/WbInSJkEyvcqc+RfBPTms7JuZ8c5aI0EHn/+dM6nERsD
         iE5G2FsLU5p9wxXM7M4VlqGsgKEXmvFGIJ6kvWZLgjMy5eOJRCBySpIC3x7HvHupWB1g
         Lurq65BMHtm4rHIiR4fG5snehKFR0Qxwrnfj5gCjoaP0I8pWuU8s1xeN0k1YfJNoG29i
         xOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070725; x=1792675525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=;
        b=GvPtscz3KlXuM+tGmZ5d6pI4UWsej3lCyk/Ty4hrY8Tm133XDx/F5c6GDuSLDj6c0c
         dnIVUFRUDvgBASHOuaoXKGxVB8mRQhtDRqiyaqMaQApvi/HJKvoaV5Swgfs0A8PAEYfZ
         MYu4yhe5aXNqYuRDrU/XIuY9XcG3Tua3cv/vIyCrzhmgaDaNUJX8zuw1KGNp0k17NRhI
         eply1lvfF9JlzSRIEB8dftNRacO6R/zXX2WkXSUAAdl3eGXtAL2G3Z+9uil8fivI75Z3
         6tGRDDw0SLkt8j9v7hjinIOI6vsRE3KrNFxoV5KmmW8GxSDGmCsK8P/Cj10UA+R7lMqf
         V8SA==
X-Forwarded-Encrypted: i=1; AKwUvBzoxHOlvZd6OvjzoG/SLXjm0ZwInXxuHmbR5t8AkZDZdnp0tAaOtPik8S5GVKM5AyBzE4B843GZ7J62ZWPHYIJsNg0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNLx0ZfERb3n9ZU/Ny86gKJpRsN2urA7VyQ285WIAGF+rW4ssf
	+4eEX0oHLzkR7KAsTNIRoFGiwoSxqO3buCJZ6uz0cIdwXnFr78eqllkeGNh4iopJOjb04TiLQPs
	FSYvQD6FLKpb2DlxAfG1bJmUFRtUSIBZRw44I12f7meeZHdtabS+bU5ZCnhhv3jnrxaOmFtRdYQ
	8=
X-Gm-Gg: AYBFou2j+VB81Se+Xu4yCo1ibvoLRsjS4H7kSwSZ+tdjBxaLrFL8S2QE61td4FaagLg
	5DRDP6cVfbzyxStVaAkLCFXpTAG+jFdQ/dUS8sVTulrFHqFcH3kk19dqjVy7v/bu8fpHxWJ/UKO
	FUicA0kwf2HVL2uvgBpZU5rxnXVA73FSeI6HZVbnOKP422YvPz9GhazbmfjUJYGiTU1pLkoKVGS
	fnyLFNzpGbghzlk9jcfc8WSDt5Hd8ZEQK8XCkukSGiX1vVS1LimQdUg9MWj8G0yhbzN+zno/qnd
	KS84ERmOVLTaCoNOqFpnBdAxiQO5mXktXjutFy6MMZz8Kd62H4nOgUXnEkHJB6byRmTy+7vzC1V
	o6OeuvTSBzRJWnROx4X1Q8+UGJ+I3dg==
X-Received: by 2002:a05:6102:41ac:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7cc10451036mr217341137.27.1792070724708;
        Thu, 15 Oct 2026 06:25:24 -0700 (PDT)
X-Received: by 2002:a05:6102:41ac:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7cc10451036mr217320137.27.1792070724111;
        Thu, 15 Oct 2026 06:25:24 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66ab3dsm65873415e9.2.2026.10.15.06.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:25:23 -0700 (PDT)
Message-ID: <f44df63d-155e-41ad-8652-36d770efcdb6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:25:21 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
To: Krzysztof Kozlowski <krzk@kernel.org>, senozhatsky@chromium.org
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
 <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX2nqiKjSNSYXt
 9TpsWJtDrk7p3sZ1AJ03jrcCQrSdc60nEs4EcIVrFcLm50HbuL4UyRoseUdW+TwrcKVO6LB84C0
 VKNQpdknSmQHHpUpQe4v63yh/Zm/oMc6lLjwbw8PLMiwvwFpIaBKyf6bAv57U5Jb5Ix9RonYHlt
 LqOfgrma3lSWti7Je5GIxkIODIuIqPjFAD5GEqFRsmW00mutI+i4pjXM104NtMlLTgr66/crrq6
 1ByPqZtFWkW36e4hv/6v9bIbtvn6eJTWuFa6Xxx1rQ0DYd2XLG3YaUG4ww0VIlQj90xyGYaNgWn
 PRO+BVhi6VFebl8WS04wIaorWP6TqJ8JX+QFpThSQhWR2fPW6ZR11MELlN/EpiUwoNfGZl+syHW
 3iLj8ZtqzVummnGmHqoI6IoqFAF1RZ77oUUEdQ37XC1ztl1M0pEXrgQzwNslJOqzKp6m8sTEQNP
 lIVasrb2k0BaQxOD6Gg==
X-Proofpoint-ORIG-GUID: hX9YwaOScyJB6Lqr9-vbidmhKdAQiUqd
X-Proofpoint-GUID: hX9YwaOScyJB6Lqr9-vbidmhKdAQiUqd
X-Authority-Analysis: v=2.4 cv=G/CJgNk5 c=1 sm=1 tr=0 ts=6ad0d445 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=vTTj8iH6AlmXu0jsvGYA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX0hlsUrperhJ3
 0hUh3+ozAReZaoXhkkALXO0bC0jQvZwdvZbYt+dfS3APRXRDrjYg53rVnBG7MgtBL14GVSwoAYj
 rMMgfcCUl2Xv0W90Dt3xloegU4H+CFM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053

On 10/1/2026 11:50 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
>> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
>> hardware block that accelerates compression and decompression of memory
>> pages.
>>
>> Provide the urgent command path for synchronous single-page compression and
>> decompression. This exposes the low-latency operations needed by
>> compressed-memory users such as zram, especially for page decompression on
>> the read path.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/Kconfig          |  14 +
>>  drivers/soc/qcom/Makefile         |   1 +
>>  drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>>  drivers/soc/qcom/qpace_internal.h |  84 ++++
>>  include/linux/soc/qcom/qpace.h    | 154 ++++++
>>  5 files changed, 1017 insertions(+)
>>  create mode 100644 drivers/soc/qcom/qpace.c
>>  create mode 100644 drivers/soc/qcom/qpace_internal.h
>>  create mode 100644 include/linux/soc/qcom/qpace.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 535c8619197b..6bcb86dcd726 100644
>> --- a/drivers/soc/qcom/Kconfig
> 
> Sorry, but no. Soc is not a dumping ground. This has clear function of
> compression offload, so it should have some dedicated maintainers like
> other offload engines.

Thanks Krzysztof, and thanks Sergey for the input on the zram side. Before
I respin, let me elaborate on a possible structure, so we can choose the
direction we want to go.

The QPaCE driver splits into one engine and (up to) two consumers, following
the IAA/idxd driver model split where the engine exports an in-kernel API and
the crypto side is a separate, thin layer:

Engine: drivers/soc/qcom/qpace.c + include/linux/soc/qcom/qpace.h - decompress
primitives. It stays under soc/qcom, interacts with LLCC slices etc.

zram: drivers/block/zram/backend_qpace.c - A zcomp backend calling the
engine's in-kernel API directly. The zram intentionally does not use the
crypto API today (917a59e81c34).

zswap (?): drivers/crypto/qcom/qpace_crypto.c - Registers qpace-lz4 as a
crypto acomp algorithm for crypto consumers (zswap maybe?). It will share
the engine's primitives, so this would be a thin wrapper.

If zram switches to the acomp API in the future, zram can use QPaCE through
the acomp algorithm and backend_qpace.c simply goes away - so this will be
compatible with that direction without depending on it.

Krzysztof, does engine-in-soc/qcom + the crypto acomp address your concern?
Or would you still prefer the engine live somewhere other than soc/qcom?
An alternative would be to put it in drivers/crypto/qcom/ as a crypto
driver - register with acomp, but there will be no user, and zram would
still use the exported in-kernel API.

Sergey, is a native backend_qpace.c the right thing for zram now, with
acomp left as the future path rather than something I add to zram core
today?

Thanks,
Georgi
