Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB86E30C177
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 05:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779686237; cv=none; b=SYwz63he0Wv8bbQnl06gXNZ+0c4kn8+Rzi2DyZasZzxZkerWA8HkyHF4VrgNpdqusOqh4x2r7wbJXEdwiJqW6YeUh4L6I+s934KLiyuleGkzjucKvPnAOOmVctxh3PaatZblU6lB32Dah7t2xSR05ifKo/22LIZXFLwj+nQD+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779686237; c=relaxed/simple;
	bh=TT6fb9wRcDaVAgi9x7/XP+aN+zqiMMogNcrum5LKYb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkhT6YKnmovYq4BeFV/2w1GLvWq885D4GUNjUMx/6xjyLg+LFbZUM+6wX+vZjnL/4RMEmkIROeQqOdAfvwRv2dm7X8ENuaNdb7tHufsKcCuJ5t3BCuFOAsw8pyAbZQD8E5n3Z06aZ6JGpxwBF2Wl45qhB4jif9DNOozRYmwKuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hsB0i+7n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKhdZiZJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hsB0i+7n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKhdZiZJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OIuLma4115476
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 05:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=; b=hsB0i+7ncjNC8A9z
	LEh2SHbdGGWAJAdPz3eLH0iKrQVFvqfnwU4EG0phGfFvZQnjLV1CeylJ1k1L0wyk
	HlR2ZWonSkI9ROc5fweo/RcX7qNMG5lKZY5hszBcstTklbFQMWE5dQCS4uQ2Up+k
	lZkKt98Qy20iUQyLVFL6gzFYdmSWy4ornVUd91Bz/hWyDpFYUBfnO3eYyTUO/6Ys
	6cvw7rKTPK2t66D+6QdL5CoxTkKC/blrvLY1p0JY6ru4HRgVL5Ur4bbpYZ2stmhB
	Yc8DGG3Z2MHqMIqC8RBxVSCZ+H36F8KBR14eEShzOGhcfnsz733FOiefuryd9b09
	kf7pBA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386n6uv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 05:17:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso18243393a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 24 May 2026 22:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779686234; x=1780291034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=;
        b=dKhdZiZJB7v6y1Mv+jXSa0RCILUx6iNylOWB1JBC50c55WSBt1kHI/sxBPA4n7+h+V
         az0n1xQX33g7f3PoA1mUq3RJuGTgJDX3mqdEsk6D3K+fbRPBx69/cLfbAT52d7oMxtW4
         5iIp4GpX03IQvRxH0oxBZsHyVw1NJZCLHXFXq4aMGXEbq0U/ulQcMEy0qZESi+mdHjQD
         +1ny9sW5d9VUS2q4PsPieztUCD9wdNbDhwVO5CrY0dTP9KJk0irnu+ybdF7efIDWneUx
         WFk+Pi5Q7EzYV8c9CHD0XOZcWQ5zpMDcjqSXsKUq3V956niCwcmvlWlqo12BqN80N9WB
         XTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779686234; x=1780291034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTcW/jqS+R1fyGppCmwLUjOiRqL28+oajKP5jUq4DXs=;
        b=MXTTCp8v5m63FyAFbLivHxg+PNoUvdyi1ULiQKyK0f22S0pBE5MJ0LfgzJ293pdaLH
         lNhnSWSwky6xXs6Jp1EX6rwm+Bwc+UjQ8c5o/YdNilM7PIdRKarLzaAm1XB032cPg/AD
         xittuAFcbd2W0FiaMKifKRZiKYjI5Nr0ffTQ2dFU6xS/nENWzS406Xqdsbn7Ct1lDarg
         JD1vQsW/u9d19NPftai2e7U/ZbY0NJhDyShfzAvF0yMv6spb2voMWTBFD9FJ/3IfkSyH
         Ohyqo4UhsWS2RZSuOu0jY4WIxo8HJTIDKnDCiZlV+6LrF5iGGj5ACHTc7nQOFTjPjPnZ
         JNRg==
X-Forwarded-Encrypted: i=1; AFNElJ+GV65pUl6HRJqgpfHhQf9BGxS46ZzeF9SSeGIvrq3UyAWcnJ26FDzjzT1RkOCSU4AUhznLWeRxOz/I+A0BJh7au5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY5st5JcDWA02u/7XFx2pZD9yd/2TujSI1edrnJNWhPGkEXh65
	vj09FVFhcOfQNOzN0mOAychIXyfMX6cugiI3oU0vARX9s4J0BOD8Ei/SDmlUhX0jguQ6Qyo21HJ
	Y0DPWAgmR6MJot1phe1dU3igAeJE7QLXRx7x4nawfs46ewPunyKhI4JFl0XIrgEjltKx3rBvIEc
	8=
X-Gm-Gg: Acq92OFAk/ZpBf0LQvyY1/W/gX7XPNAnSMs/lSdMviXXbm6gEHD8aAp4dGiXAafCtDF
	0YP19FbvzfwPvATB3CMll4LECRi1NNbGVv/j2yu2sJspuRR5HKpb/VgkDM47ol7G26M6LEYgHAq
	SJRANnICkzAQkNP+fs0+d6LU6d3FoEPMs06xpcdvaCx4s3YIUykwJeOBew/wcy+dSNJbdZgS/4V
	cZUyHmYigtYXpplRP/OT20adrZASVJE/R1wLsxXL7Pu57euAG3BTXNxNdkcLmb3sTqD1VwF6nJa
	npWyvV6JJLRmqUb/3vODvDGb79xSHatibVXl+YcFSPCRoKb5xK1U7nOMHqH8eTZue3imlsKcNqx
	z9lEzP6DXLIDepdnlms0lFzfPQL+H3Cb9h4vKjJ+WExLMukOsBfJHTg==
X-Received: by 2002:a17:90b:1d8c:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-36a67422decmr12178435a91.4.1779686233693;
        Sun, 24 May 2026 22:17:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8c:b0:366:33a6:9921 with SMTP id 98e67ed59e1d1-36a67422decmr12178413a91.4.1779686233253;
        Sun, 24 May 2026 22:17:13 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852057f9cdsm6963798a12.32.2026.05.24.22.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 22:17:12 -0700 (PDT)
Message-ID: <22a52e0b-849e-485b-ac6c-ae55c2b75be7@oss.qualcomm.com>
Date: Mon, 25 May 2026 10:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
 <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
 <5c59952f-72c5-4aee-a1a6-4b11b0a542c3@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <5c59952f-72c5-4aee-a1a6-4b11b0a542c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aK3JjjWpAE2octidQaEPz4D9jpCXBA0h
X-Proofpoint-GUID: aK3JjjWpAE2octidQaEPz4D9jpCXBA0h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1MCBTYWx0ZWRfX9yac5RUv3PzU
 tBZr6Kp6mPK6kN/9dG3LU9Cf8KjPwIGAvwJvAyNnssagC4AcJj1wv5LRluaecYEdRDMHPCfPqea
 sRP62U4Ixw7FF/zqfHOp8245AqgQtWsMwr8rrPhS+dt5HSROYK7D/HAHtbIfrEu8bm/mEk4GNFK
 t+lMAcbFI03iZy4dxqN6ziEMGcfUcxe7GAE1cKZxZeRHvyzO1fJMj/ZHlJLS+jrpWwGmOSeQi6G
 seXcWMJEqOMXR3hAbF9b4wcrg10+8ETkr83eP6PB+gE9DEyJzcjmp53TZLn3mxdJ8xWRDNXhRrO
 mDyMVGqsdKk4quCJqG9DV8TkInZ/WnUad5+aqWE+sKiCrONuwJjn8P9YXk4sKtTimnufbQw9HOP
 XKcfT8RcV8K0l3Lruk4cTZ8SdvoxVIuGBXRMh/8tvvNwhP0EUEq0URvu4V0in31Sx2Kl1W0UI/1
 DtLJUJYNrV4wvc1cLXw==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a13db5a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=v0BZMRiMjL-9nwr9ESwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250050



On 5/19/2026 5:04 PM, Konrad Dybcio wrote:
> On 5/19/26 12:59 PM, Mukesh Savaliya wrote:
>> Hi Praveen, one question below.
>>
>> On 5/18/2026 10:30 PM, Praveen Talari wrote:
>>> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
>>> These trace events enable runtime debugging and performance analysis
>>> of SPI operations.
>>>
>>> The trace events capture SPI clock configuration, setup parameters,
>>> transfer details, interrupt status.
>> Don't you need trace logs around PM operations ? ie. runtime and system PM ?
> 
> The PM core provides a couple, are those enough?
> 
Understood, should be enough. Thanks !
> Konrad

