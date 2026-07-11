Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922A2BE7DD
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Jul 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783738482; cv=none; b=fkwrGG4LGfhDJ/KaFiP1ZOQpjPdDU+MA90WcSyFg6vF8asawj6L5+/geLb/d012mytlKpC5fOYVzA3fAjqXi9ultKaHyJgP7PY1InoencMJl64pm98AWFCC+PxOPfBtce5rfuSGT2OAG1tqHd2/XZgLrMY3CR8GRF7TVTDMlFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783738482; c=relaxed/simple;
	bh=e+5oTDlJE3JeVGw8kwraD9BnLZNaTeaClLqHopfsvpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anNBuxzdV8f/9w8PYPqcsC34zhse/c4I8v1LyZJzXeIh67bembdJy2UFugKlOdKyST+GkUiGS39UkuFYZsAq3Jo+lzqnyhtkhv7vb6lJhzhzIolUwo5tDjPG76/m5Mp9p44sqq+4JqT98DENnKtAIK8wBbTNpLYB9wCSdIgr+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaYX6Av8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TGxcB5cv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaYX6Av8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TGxcB5cv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66B0JaG12289473
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Jul 2026 02:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=; b=AaYX6Av8yvYvaJ0j
	PjF9y9PlI6MKxkfvv3zTMKgG/+V8mJJpEBzjezQq02SAM7+g7rL95R3YSjAtcwXW
	Y9LyPpZnfKwqZS0YxQnRhJTLU9658HJtSZEFOJpIVDqv52c2ikA9lrOM+TtxhGA9
	vzzte+HVfSHMgC/wPuT1m+UjKuxLM0vE9EdURBbXE7/Vgo1RoXk7UT2ZVD2I4UdS
	c8nnOqv9bYFWA1FZIKgoGSM+O+KN603LBw8IMKW4743bphihfb1RC8iWIkjXtP5h
	mSiGu9h1p4Xncwq2YIWKlVr1clYG48HWEczuy1mYidpNmoPvs4yrAMVQHqBcNum9
	EEUDXw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbb6kr8en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Jul 2026 02:54:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1379177a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 19:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783738479; x=1784343279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=;
        b=TGxcB5cv8addLJROzvfzgAp5IYoOvsmXj7vq9KvTyxWDPfEQRrVpDuXygWIQMtGVbR
         eZ1oKLgadAUjVsbq7jlqN33OvBGUwjP4uV/f0JBKHxE5L5wJexH8O43OpV9zktTR9L21
         JbibRlsTDzLaZoCHYXfm2cD2ILBdHWdDfh1mKV5XXOi/U9iKEMlqvifc/rNeRzh434nL
         8kS8D+8pJaCkwuYGdmfJSkDPmOa+N81WCLjhythXBVVI6WRmx047Xd6WADyqsd3MCWMs
         ty5dpNAcQORfIYhhF4soOlLjgnzIItnhBHQgV0vhLdpSgff34ctiiAAeK/A54fAI+iiD
         rsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783738479; x=1784343279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J2+OHtFXDardG1nxZZRPnKNBAxjQeEXhfcwumgbzb4g=;
        b=OPG3e2pAonn5rRUNgD8Ck5fC8cpiZu+Paci7wxQOxwZibXOnpSTkHOb4RtuVbSDru0
         +V+wvHv0RA04XBcq7sbF0hMUVRl+x5cJr3DWncgGO3OGoVOUn0krCZ3ko36iARPCTq7I
         aHMaEKv2Kw64XTqeTn0qTQl/Oh2LtKmScQeVqUYIvdWchEpgQxwxwl9I2hW33Z5VEGXc
         3P3hVhWX3gII4Y01FxvOhjV1IFUnRgMe67Zm+nExpSzBV7AgUPLjS7E4UC8OvnF80B4j
         Kt0IjnXOrDUA0DAk2P9vCpzk0f1Vk/SOwy1eDq8I6zcWXIimPt04/NSpKxsqlS3Xt3fv
         E5+A==
X-Forwarded-Encrypted: i=1; AHgh+Rpamts33MlhtpAtv3vgomrWy1IgD4ERhgIMHbX0cV9/Sz/3rlXIMKtZCaRQ7lN+G38ypiqeNNJ6QFdLvt1OsDCsLyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUhsC0uet03L4CImYbE5yhE9ralISGgRUZksdTD67xqulkPJ3T
	FR0mCnzM99tKMKSEriAI9zdOJ56h1BHH6+mGJXMI0eF8L/Z7AvjpyQ+Mra+Bu1JmUjyH8LCTzcc
	o3o644Q/VMgEllH8uDyKzzNs3tt8/uvOgL18FWUMjzdvF1TwVwhjflPPgkhHJSsvcG4+5YWiJLi
	E=
X-Gm-Gg: AfdE7cla0c6bTrKiGhf9RxRs/CUgQysWJ8iXnd5BS85gvFfY3I3cgR5TRww4cNzD1kG
	VTemqBi09CaIEPRZ8hjMaKJZPVx0LgYdeaXXxumD8Y++IZfofJEHGAKk9AQh5zxyagcPH82+c/z
	K6Ny9e74hGYOVBnY4tjzolgIDg42st/pL3jVN8rgibL+j1PeqwFCcobyI3plDn3kTJ/BKNILgW9
	xbCTwX5x0yx1fOlZ9NRLaP64m//B6yF0Kk/YtOEO86z31FmaECN+vB+WaB2q1gpt0Z6YItR2Hqc
	H1n7TUjj0m6m5X+sv0Clx0HuGNWN6rhQp4GXTWDXiS9iSe+pgLyTJBUMc8WxJzlHFP0lR4eQNVW
	/kxL1+0SfOu6P1NnLW0dVjNdNOnW9jz8c9Wuz5pUL4A==
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3c110a65ba0mr1534084637.37.1783738478724;
        Fri, 10 Jul 2026 19:54:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3c110a65ba0mr1534062637.37.1783738478252;
        Fri, 10 Jul 2026 19:54:38 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.105.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm11787208eec.7.2026.07.10.19.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 19:54:37 -0700 (PDT)
Message-ID: <73df1c58-39a3-4f89-8674-43fb2dc36a06@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 08:24:33 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
 <20260711-add-tracepoints-for-se-reg-dump-v2-2-ca1e9ba62359@oss.qualcomm.com>
 <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDAyNSBTYWx0ZWRfXzTKxXN9EIZWo
 wQ90cyuxaOqz8xovylGJftAmNYNKwH4eggNL2weIK5uA5CWLvc+lwwasOO5PqMom6kgJndAU1Fh
 mdjO6c1MmS9FVzungrwPhsYAK2CIc3w65zs+E6xM7Sm9aVdkHNfTD7wGo5ecnFRCiMJdXiXvWY/
 nl5uvhY61E+0MwRWXBbrIAGVoHl2jaKPJ+A1kZOmBSt9GO7rguXawnUX3xFuUOcynUvfWAR00Iu
 qJWsbYvOBVpH4RoAfECCukxmy2pz2Hs60R2FG00YfvkSichGkRBQMz51sBa8I/Chj0hwLMFrFYs
 niA+nQkw51NZHK/w1bLEJzoqKY7v6fY0Ja3NU4jd1QyBGCcmEcZ0+mFK6PxAq+rvs8jJ+LkdisH
 ANBx4bQpVHxWlTC7u1Dc63MvQz2msdx7OembkerStcx2x6MQpCWGasqb3VDkAuu694Xwcz1Pl/2
 H4goY66A5pJj61o1l2w==
X-Proofpoint-GUID: 3ckOx9M7cnENzA1LPJKzdTM0_mGr8XUX
X-Authority-Analysis: v=2.4 cv=Bq2tB4X5 c=1 sm=1 tr=0 ts=6a51b06f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ua2K4HyBCek8nw/sr3ra2Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=o-iBtrM1MSidxli5CHcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 3ckOx9M7cnENzA1LPJKzdTM0_mGr8XUX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDAyNSBTYWx0ZWRfXzUgfOjxQrhCu
 Bwu8ePhwrjT0Ue4IkFKU1B1FAHXA3vsQxp5z7BQYtbxY+qfrHuB13WwOvQQkHxWLsH/K1EHPo+P
 Ws5Mf2zBl4PK17DHwvMM75oIQnQegKE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110025

Hi Mark,

On 11-07-2026 02:56, Mark Brown wrote:
> On Sat, Jul 11, 2026 at 12:18:42AM +0530, Praveen Talari wrote:
>
>> The GENI SPI driver reports various transfer failures such as command
>> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
>> interrupt conditions. However, diagnosing the root cause of these
>> failures is difficult as the hardware state is not captured when the
>> error occurs.
>> +#include <trace/events/qcom_geni_se.h>
> Should this be in rivers/soc/qcom/qcom-geni-se.c (and the first patch?)
> - that way if another driver starts using them we won't multiply define
> the tracepoints.
Yes, you are correct but

If this header in drivers/soc/qcom/qcom-geni-se.c, how it will be access 
trace API in other drivers like i2c, spi and uart?
>
>> @@ -986,10 +997,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>   					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>>   					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
>>   						mas->tx_rem_bytes, mas->cur_bits_per_word);
>> +					trace_geni_se_regs(se);
> SE_GENI_TX_WATERMARK_REG is one of the registers in the tracepoint,
> perhaps trace before we write to clear it?
it will be captured in m_irq register so it is not required to capture.

Thanks,

Praveen talari
