Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045A3F4DC9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188188; cv=none; b=HLhA8xUQ7eNFSnMNO/URyBLuz+S3/1U3hrUn1lh73OV3hwIbI8zTYyH4WXQecA4lh4TbcifbAJ6qdAQgWt9Tcdi0VtSvdML4DkaKyP9Tq0GEJGfULwM/NQ1yXU20+YTpKOqPciTsNjCED4d/0vpIU9oiZfzE1kWbBuSI+ksTikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188188; c=relaxed/simple;
	bh=jS0E4ds8/7NpK9Bp+8ECil2/7vTa8+eivZTcr4pPqBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqWKxW5uwW1QDHY2XgI54dASCSF1T3zq8pOe2uIBSH+l4Qm5mwfpXyMTMSMtRHvYHxgyh3n1rYTdny421SIy8S79FOtwoRlUE840AAFkiN9o211Hp/YhYcvfuQCbVVS3QGDktU0RPPXzVWfo57A25puKqGP5uaSQX2Pn6AtWIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVpymYBU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hejNOd1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVpymYBU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hejNOd1J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J81mdf1146383
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=; b=iVpymYBUSKPrxHBZ
	+zA3Sd1/rRCX4x5dXHvTVXNR9hZnOyWCc9+e1WKGYWe4CvnjPyYlME6v6z92WOEV
	mqXgTjMxwNsVZ3nXXk0cDxRX+ElBrnEjtgfWJkEH00xnGCe1tURqLu0ksneC42Xh
	OaVP7l65yeEoC56KW916tXhdExoh0N2xmotmaPV0IqVF230gWbxsU26frJQ4jR7D
	U2n10qJN9oO2kOBd/Gib//2ojCVosaD9pqACEEHwtMk8PhA4I74D3W8Tqi0nxYK6
	xDD+ldcUEIo+PT/3CxOXEyIdeptL0VPYDt+gRiAZh3T8h9H/AU88nR3sITmDiequ
	HgNDTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ej42g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:56:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36865d109dcso3098286a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779188183; x=1779792983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=;
        b=hejNOd1JSmsIkfRPXFPc2ND4ZZCQE7GzrcZ3LsIc2hOTgDTrmA0/WkaVAy27KHr0OQ
         k73WFW7PIXPn/3MiznanX1zlouCxDWTAAKyACWGWMhvMckTh9h3nm+izPyqJ82P5k++m
         z8OYY2mVoc0Qu3jnZh3HqgHJTHuvAg4Z66FFvjM2v0Yiuo0+BBGwv0C9Wuu0pb539SVU
         MqrOOG/5nqK0KBkTw9mqD/zDyPJCgr8o3mTA4JIt4t90tZedr18eZe0ydhOpqPK8/kXU
         iYITvjq4zcp+ojInRMdcBIJLdkAQJ9z4+tKC5LOTsxNNhKQIA8h77ZGh/Sz+PB2/CRxs
         LiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188183; x=1779792983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=;
        b=locFCzrxKp4OfgWBp0c8ZOxu1zeAA6HluRWIjXjJcDIM8didlR8iM4SWNAdJAoxCZc
         xUIOI6C+giBuIaEQ8uDeHHLKpgcoObCW/NKgqp3CIY9UTOh2AQl06s3MbUEznYzJwZEJ
         qwEuDGzLffKF2Kk2tGBOYQxGGXj3RhLaa9hLs5h6rk4CJwjhzzu/rvUfWvGOjZClREsm
         uwiVA+Xid47ajqHaRpxARr6aPC2jt2UR10QXgF3CQ4Lvsp59eBiBA8mFU30V+YED3mcX
         GH8nDV3j4CNgPzYphM81fF35ICl5OACUsV8QUyWLc+92SB9ar8qnPhTT+aYKEksfgNa8
         XPYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0qLMlLCfM9itEWilWYU1T7/iYcDq5pXX66xkyJs34DqXi3yKdZLoiVzXY52//hP9utcHaebc7ke0+VLuEXW2c3t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGx6MHVeoFCf1/evGsqOQIoLZ4I3vcH/EmCiu/nS+tQTTK0v3
	rzPbOyXg7x2LKs9ycyMNmNbfioCAmI69SWcpP8uOK4prbTaPTLVX9QsicLzJSPW+CNK4q3z97mE
	+YQGIWsci7mWBpg5zQcQWbtQfzDDC4u3QSLUB//PrgCR560LEoIFP73pOSO6IH1BuxI3eb+WS4z
	8=
X-Gm-Gg: Acq92OGdLdmfME5A1UP7S0v6+vBfWJgVikA2+5aJCSUNfergluiHQIBZ66RYNl9uAcu
	HiuPE/x8xFbgvGNmHVtidi2ZRUidYS/3+sJ+OSeKz/mjyY02+rXCsku0eMG9A61wFaZBRIEPdeQ
	sJJxJvYpjHL4Ox3DdtdgLlCliqZKkmvvQiuIqFfVauv0oSEXRIK4JxXmkgDJKQkfUgPJDh8ffPO
	okm2jA4cCNnfqDPflkI70embmi/EHVNdkjTWrIrEfD/75RSjPZ5KAulDaFUVB/pjfPGbh2XCyJN
	wD5YWjeE1hJrXHBk6AlgY8yWK/lFMyIoXnjHXnNzGzQ+nCYPyKSccJZgKWspLPK48J+Az87mSlN
	Omvmb3k96aIHJvj9ShxrQSpvdD7W/N70RkoKSoBlIShgagvpj7Reb8C1x
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr16978035a91.3.1779188183244;
        Tue, 19 May 2026 03:56:23 -0700 (PDT)
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr16978019a91.3.1779188182751;
        Tue, 19 May 2026 03:56:22 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm13853485a91.2.2026.05.19.03.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:56:22 -0700 (PDT)
Message-ID: <5e8591b1-d1b2-4b58-b667-cc2d4c0a4b8b@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:26:16 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c41d7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kAtbQewIYUbMTxBMGYQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: TLWtsPkkRFefhtufQT9Rl6Mrsl3i2Xr5
X-Proofpoint-GUID: TLWtsPkkRFefhtufQT9Rl6Mrsl3i2Xr5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOCBTYWx0ZWRfX28EuIOKXPPmj
 JZPAYon+Xd6WpGmB1/NREspUxpMx8rZH7OqOMePIdmkIOJtux121llWbuq1aXBBYSyVxFN5Igm/
 Kmnp+pb8Gy2fVaFD+9teLX1giKRiEGUN1PJ9Y8T890eVFZqPJWlTDv/fwKJ3H/t28oiPTbMMUJK
 1KaFFfc03gW6y7izkT1nQ6ayYSLl7ZzzPtkceI/CffOeI8urV23gBIi0SCkled8hd3mffc4SVJT
 r+D2vmDv/XrSHxAyJVtmLPJN7p5hbc/n8OhyaOtlhF1JRWvoZ8CNRoDwnUgNHVERid0vItsAy28
 BkU9JAm5jDQWUX9bHFrGrvHXtG4fPZS8dR/YUmCvtnwxnxRRogZZ5j9SX7puigWVq/HeAudrJI7
 zN2HaNG8RIQYwencHb0WNEFHv2HEg7tXbiXjplL3e2YrrHLXWlEuYPkjioAGk1LcVywy9tZS2dr
 oTuqIAJP7KZ7MGQ8pog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190108



On 5/18/2026 10:30 PM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI SPI driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover clock and setup parameter configuration,
> transfer metadata, interrupt status to be making it easier to diagnose
> communication issues in the field..
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v2->v3:
> - Renamed geni_spi_fifo_params to geni_spi_setup_params trace event.
> - Updated commit text.
> 
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
