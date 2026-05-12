Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61185472789
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566235; cv=none; b=tmJQWyRXtfORIgeK0LGHv14fW6Wf7K5Ft7BmqjwHSzDOgSPphNm3krVaJQL+48mvjEeSWFbWWVIIvf6LntQXyrpLE4HRtO6awgvkjtsKTNhPxeenqRWPrut7K2S0/F6LlQGTsislyPf2U652E9bOaYWcjN5DiS6wLVEO5GHMcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566235; c=relaxed/simple;
	bh=4Oc/ygXfRBTK6jMvUCm36puGCr6UelEV3QWDsP5yNxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VauhiaxuIVRFTw3e8lyIYOq2shu5v/bsdfKYBApL6dJtAQFc18oDaKtMRv+/j6n2qN4E8V/VAzInVPIrOpYmeK1wZKbyeSde+MzyT7tN6nbF64fui7fsTR1mYl3HrvmLK8rXzs/V5x98N2Mrn5kExsSpVPaRNlI0SJPgW654FHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KEa6taoM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfC4ye7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KEa6taoM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfC4ye7x"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C53OPx1183967
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ll5yBfNIxQl+PyBvANVDDxs0W/OxwTKJ8orvqO+icGc=; b=KEa6taoMZjMuc1Zi
	OuW8Ls+oVft5SMB9E1gm2OEMOyYL7kQa/XWTeKyF7fUSD0pBrNeQFHuQ/4zxqsPl
	w2AQ4ZLiqvxPtDewFskim8pljXzcRfQISfiCQafg3GFfCM3RfVzyUMcEp/tqO8Zh
	+xzlcoVgbyTIW2/SVezbpecfs9b+dZY1e0Z7ygfoQagchK5e7UAAP6DmDwAJqdPL
	StQN5pOUJd4o8C+p2BN/5iEwVQ3ciw2q45lKcs5GcPn2OxQW/8SqURoIIP3BqjJh
	MqDB1CwYzHS1rw86VzibUDVOKOmVyWy2/JutyvqLvjFLZpgw/a5KyLK5SVr5TqOv
	fO0PFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nuy9r5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:10:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so8292386eec.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778566219; x=1779171019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll5yBfNIxQl+PyBvANVDDxs0W/OxwTKJ8orvqO+icGc=;
        b=XfC4ye7x2rheJ1Tu2CrM2RGVgkngxSXLYCHkRj3o81s83T4SKudKcxGLwpZV3+4DYw
         JK08Lf5qbgIQYbtVpwXvoKvF6+Ab8/tCllcHWhAmVhoMS/OKPeS4CcMyqfvyMNh++j2K
         LR4P8GkkZ4AhapjVyNjgfGFBF4YSFhbULWGS70AzUnLfdF3WzQ+cCHM8Jz1p0HVh2DVH
         OReNs/DqL6QjIkQXz0yrXjA86hxCf73X46qo9ktGlvZfTKxJLqdZrPYpRadL8y6QscKi
         ewBcvaCk2NLEOi0gO+eVDVMX8jmJM0AUKrZ3LYKuq73HmdC8vEc1Xuss9n5X5aENJT5z
         ke7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566219; x=1779171019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ll5yBfNIxQl+PyBvANVDDxs0W/OxwTKJ8orvqO+icGc=;
        b=Zwg15eoxCPWtqUJRhCUUVnVSDG7zc8zyC5uzCA1AnnetE77OD8PR/RxamTnChyNr07
         7JRgMtzB39cTXQ71FPAwBeG4kQ7tqn+lV1yOq28lip0+JkLqpkX1NokpvqRp0p+LTKVr
         iuyeISl8whkKm5SlqMYw9bVTi3E35rRafLoGj4CkPENspIRZNDKR4uM59gXhlTnGpR5V
         LpyzLB7W2IiY12K18ltf8S8TIaSIcPsUFAf5MQi89iY1Sl7jS7/yRb6DI2z2wqDchksB
         BTPSZLSSNP47nUZY7M/BbZ3egh3acSIWpfMcnaQ84DZyQTjUw9SaPgdyJa/qf5KOaJYf
         a7sA==
X-Forwarded-Encrypted: i=1; AFNElJ9oxvB58Uwo1hbEJkyWcu7Z3iS1QpK3ABzBzEd0a1XTPproFhMhHtIijLEdZwmWnAzOZI2o6XOBhYIjAerE4z350m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBoJshoQzyUlOCBkcHqeOBu2fj5F/AzOY70hEFRI8wzF4OOGP
	8g6DDerQUemAsf9LOISwh3+8mbqRmOyFO/WGvuFshzy3enK/Du6w2h+oDWMfhyH2EiVKIAwZZsW
	WVea3fGpebl9+5u5aSn5J49o3pmLuDUtw3lwrou9ub6fOk204O2x710qbQGIvYLwUGY5yJTUqpF
	o=
X-Gm-Gg: Acq92OFrvUr0Jg6J4/44Dd4AV8+z0q5FkD+Qt5J1ejlhrXruxzVpRSoRda12YkVpd4c
	DNZDD8OJMKYRj9yz/vdwN9MycCTfbRgKucLFBUIhBPReeKzDNRxr30isXbgpKDmnY0CnnmyEj0Z
	1e/HKc2qbb0/RDkv13+YBFlQxcEJjBqfgheIUKq7R4gb8e/eUjmeZMQL0Tv6HZh0/JFaMk2jt5a
	ujaiK7X+X+Q8Sluyb8sSdXp/CWFqPxUsvnj+Hgz3BoJo/wyxzPS5hHw9mq65jaIOWSq3fksQlD2
	d4C33kNlFzcnRz6LLeyuqQAJCxbOkL+43lT+iFmXOL2iFH227zKIGLVdQk6WLVRgDvt1lqyqQP3
	42I9RR/0Uv36PUpTiLGQ7GRBpm2dMOaNKBaehp8SGvWGSaIcncIfM
X-Received: by 2002:a05:7300:ec11:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-2f54e194293mr13165503eec.28.1778566219048;
        Mon, 11 May 2026 23:10:19 -0700 (PDT)
X-Received: by 2002:a05:7300:ec11:b0:2dd:5641:f01 with SMTP id 5a478bee46e88-2f54e194293mr13165479eec.28.1778566218453;
        Mon, 11 May 2026 23:10:18 -0700 (PDT)
Received: from [10.92.208.73] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm19727422eec.10.2026.05.11.23.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 23:10:18 -0700 (PDT)
Message-ID: <b3caf403-f882-4a39-b309-ce6a9ca3aff2@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:40:12 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
 <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
 <afxJmZ9MkP5eJkQC@sirena.co.uk>
 <59e36f20-891d-4a58-8cc4-6822d03daa23@oss.qualcomm.com>
 <af3spostNgoRU0Vv@sirena.co.uk>
 <e37f2d5d-daa9-4302-8d34-9ce198e60a4a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <e37f2d5d-daa9-4302-8d34-9ce198e60a4a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: RaMyDPW-V0KnV2bGK2neKPPqCvpU9Ejz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1NyBTYWx0ZWRfX8JppLPVEen8y
 TANVwf7GTeAKjnD0q0SFk/4QoSaGLnuTrVxb4JAdIFxvQzgb20NpyqBuILejmiPYnuIxtaRQQnK
 6XpJgL60UH/pthtf71r6mJjoulnMTCKoN37cKMrTfPhXyRhh52bDI1XrzOt63cCvECIP3B+yMg7
 JclclpSAsA9UCUrajgzTLjBmMyUZZKkv8qGpeM/9Zj64NbZ5Uioa9aLs+5urWtXvRD8t+tt8BbR
 GFfbbhlIOKzIV8LJ3C+pZW//pPGhysWO4h3bNTHGxaZ08OoCWC+mT1JIXf6lEIsd9GdqvfLUJqS
 /4BQU1xaw2XxFmvtzlMpt3vhEycQLQ+X1Qz4BNvOyp5G9nySBgJCbUOhxnfdtL6zG3udiAdOL77
 xIbaPx3qEwmy2OtEuPFsZd29We9VkMIWpip3c3SgTlu6IrLpuXYQ92yrDIGTBCNTeArseRhum5V
 4H+IjSbtJa6nw8EGB7Q==
X-Authority-Analysis: v=2.4 cv=UZ5hjqSN c=1 sm=1 tr=0 ts=6a02c44b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=UcMF6MLYIlUYwx0yHsUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: RaMyDPW-V0KnV2bGK2neKPPqCvpU9Ejz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120057

Hi Trilok,

On 09-05-2026 04:44, Trilok Soni wrote:
> On 5/8/2026 7:01 AM, Mark Brown wrote:
>> On Thu, May 07, 2026 at 11:03:39PM +0530, Praveen Talari wrote:
>>> On 07-05-2026 13:43, Mark Brown wrote:
>>>> By generic I mean this should not be driver specific at all.
>>> I hope these changes are fine. Please let me know if you have any concerns
>>> or feedback.
>> The data tracepoints look plausible but I would expect them to be
>> generated by the core, they'll be there for everything so I'd expect
>> them to work for everything.
> I agree here. Praveen - this is similar to suggestion I had for the i2c
> internally.

Sure i will review for I2C as well.


Thanks,

Praveen Talari

>   
>
> ---Trilok Soni
>
