Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC582ECE93
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119589; cv=none; b=jr7f1kuVXnCZs9K0sJzbQNZCyREjAeFbhLUreP9Z3MEwb3j/HQtnPTLVDevfEc0attWNfSBfsOqmJlp86N0VDp7d4z6mjVh7la3IPbN7Wtj3Gu2+Sb5wEnyGAq2w4JkH743bdu86wbcbyAkPBf63UiOwlzcHXIbvPP/aYSIekEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119589; c=relaxed/simple;
	bh=kV7wA03t3xolDsZur1Y4hsiu+lY9W9WaJm5yxNmK5Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIIdiwE1F7wYQPdn+AxJlnGA4IkpQ8YrF1IfW/29NKjVm85Jg3Ao/poNttjMrA8qKD6GsMZlfdz6DquMIlGPqFU0munYAURGStmVLezf5o5/NZik2YnNoIYZw/gyrKDcaVc0ZWNgLGwJrnUoqabjIHjuSmB0r6KOkWLTHw+ggos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDO9gHtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmRwxocr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDO9gHtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmRwxocr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHQv52482374
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=; b=KDO9gHtXEixHeMmG
	bumNm3ZDsHLjuZnYBvOTQTXPPSuc/28CGNelObvbJBJr+Nr7lU9YrXE2aeorvxjF
	oFQOu6D2NMTW5YPQ4AI62/WPQt9Cnhd8vgV7haghtzE7WLop9aGqNOwYucNBQ692
	R/f1zHpdLLedMNYgPZbdTtyuv+IVH+KMXwNNs3EMLvuyeyZbrEs2Kt5tagpOhZnt
	6WQtikJjsnrqeV6mRnt0epm6Ti49DpvVdTmFCR9pqQrMzBI32uLnwz06kXdajOV8
	inem7w10KbtVHwzOyew6jMMqJ58/jOq9MRBlVbCXU6Ojt3XApm0tJR7adKIztl0F
	ve5AtQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvh1c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:52:55 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-135916eefa0so8588168c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779119574; x=1779724374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=;
        b=CmRwxocryRWW3ckPbibELGcXqga3V4D3FBg4rTTdjnbC15FS7G+gLzJPBCfiy/skrI
         rlciFvyqI8m7gnKFNkbcPJ0yVudleQRecmYKixDusXVLvj8Wczi54G6OW1PX03+LFxBC
         eDc4Z24zF3QmxejfXHCBswe99TnrPSCKNmLdRehkaYspt3SIkm8FrGmg3y88bSWuEH+r
         Mdoo98dm1Py6myRRQ6sYdYVLCjc9EHdCUT92yXyxgIMcSBcF4sI/LJtJ4rBILsXEp9XN
         +UJkOH9YyCwB+dAdyDdrpBgAu/LNGNiHohIhrnO814GhSsgwuilbT3QbHR5vCOPJIpb8
         bY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119574; x=1779724374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csR+wJpOLyPA3FCSrAWppws3sLkeJRysSK8h3qz+NAM=;
        b=blCayxE9KsAhsSu7ETYOSHD85Psw57Qcerdpe3X5zsZeljOQtrxtJmdeKEkfwvwoac
         LgGCFeUhmDIs5tZ7pj3cwVtlWHBhEvqIvAUM56oBlgMxN7MAxruv+RkI297QqnCzaDSi
         3XJ1TLSj5AqrD0+r3eSxD41n6J5Gq+FtrtcPdu5LoboJVxcJZ1NoHODrhUGkNA9KpWWe
         5Yc1Rq878wH8ROpXbT6rmkpvsg2zaMajRnH/WWvoAcpz/4vjcPIvTPwwi1AYZAQkEAyl
         7w8J6t7dEIYwB50lF+ekuh9zM+h9F69DpBW7FOPbxzIEKtcc3XRA/aIbiPP0GCjJVzJk
         PX8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9BZ3+FVF9ODhvKpecKlOgTB0ZbITPf8EIUr+ixeeMrSpTJIqlyh+PMJQuATG17RSoxUyem3CnqcGCWQFxRMW/W/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8y5ifeCwdYieZ2EOyaVohfD8Fpn9rZ28sM9PuY9YXFZOFIoeq
	Gbu3Tp2QX+tIZkJjRermIim2zm82GgwXWlUNyuJTtTJiYERYekbiX15vujZ/AYeovDjuG4YBdS/
	HImM0RmiSElR4K7BBlUYpDqr8qrbXHr49c/yzoHGkJkTct1lrCMephiPycz4aoupUeHXEJVudP1
	u0o55dicc=
X-Gm-Gg: Acq92OE5kXLUonL9e9GslKRDvRjwClwUGG8QYcLd6nY+IPsaAzMcrIbRtpSJSMy8kYH
	rbtmP5Vj+o3an4ZLBbjaQtBw3e9EgtnWts8IMDYummK9HPuy/DY3cwUsIT7aFybV/QZbfwVzEwu
	av/PhO9Fd1HBMtzTK2VobQwo7HxNX3bd3Bp82LjjIQ/m67aGWvUWVnk4RxXNMj8/mii08LKw38L
	bodlKw8tZ+Y2PtnFC5Wm3ESBmN3RGwT9qgI/BA4Zgc2sp1H6TLHzP4p1POvQohXwtc8Xtz+BbwA
	N7emXXxDmZpCrtXN5p/bZz61liGrMazFN9qfaT4GflQk3LMRKGH6ibowtSsGtqSN0TKxhwJtvk6
	f3JqVZ34nLhvCDVca6Is5xDD8GuObaCswfUD1bvO/1maSCdfIueNvdg==
X-Received: by 2002:a05:7022:ff42:b0:134:cbed:2b35 with SMTP id a92af1059eb24-13504517534mr7018463c88.18.1779119574047;
        Mon, 18 May 2026 08:52:54 -0700 (PDT)
X-Received: by 2002:a05:7022:ff42:b0:134:cbed:2b35 with SMTP id a92af1059eb24-13504517534mr7018436c88.18.1779119573402;
        Mon, 18 May 2026 08:52:53 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.110.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2352f2sm20239854c88.10.2026.05.18.08.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:52:53 -0700 (PDT)
Message-ID: <3b415d4c-7d09-4ddf-847b-b5a3d94aa5e3@oss.qualcomm.com>
Date: Mon, 18 May 2026 21:22:46 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
 <a713082f-e84e-403a-af1d-c6fa0c5d8613@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <a713082f-e84e-403a-af1d-c6fa0c5d8613@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1NiBTYWx0ZWRfX2+KXvjGoEdXX
 A4m2lIRkiKErVoaxITYPfI0+mAehhhV92s9nHjWxs8w5Mdcblybp04s8h6VYbsMiyYaUJWVRCGL
 ijlNwGmQtXbgqf3Ncs5c09o5Vg9AobxPpc6X7cKGRTcXsAVOY3f3hefeQYhOhwbnXrd3ioixGAk
 TdDizgrp68dzqs0aZVxX2Mor6Y1gSzySEJOR5FNHCfu5x9/qw6Kvn+Suv0oHzw5qKAQHPdNWPqj
 7eVzn+aUhHxTDsAx5UI9IILNgWdeNU2dutGqo32yzoc0UxDS75BPc7AnaefQOtguEhlA+nWMlMd
 WbmYhlxG1dI1BC7Eqze9ifCiC31CKJpgAmW9oUpAfflnxqNQcoF1Iy/qsD2AWoaPY0godsFCTsJ
 ijUs9r4RYNGknaQ6yk+pE9U0Q3U85fumgs2jHYEPVDwXh0YB5aLaweKWB80kIdlC9cxkqBDFcM4
 pGDNrUfDCUtewGykLHg==
X-Proofpoint-GUID: 4Ey8v__hOv_hDI5fu6QSpFRl68eI2qji
X-Proofpoint-ORIG-GUID: 4Ey8v__hOv_hDI5fu6QSpFRl68eI2qji
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b35d7 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZQCjlrEJpO1bLG4YfcUt8w==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=rWy7ofVw4T7H4fDcE_kA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180156

Hi Mark,

On 18-05-2026 19:37, Mark Brown wrote:
> On Tue, May 12, 2026 at 11:42:52AM +0530, Praveen Talari wrote:
>
>> +TRACE_EVENT(geni_spi_fifo_params,
>> +	    TP_PROTO(struct device *dev, u8 cs, u32 mode,
>> +		     u32 mode_changed, bool cs_changed),
>> +	    TP_ARGS(dev, cs, mode, mode_changed, cs_changed),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u8, cs)
>> +			     __field(u32, mode)
>> +			     __field(u32, mode_changed)
>> +			     __field(bool, cs_changed)
> These don't really seem like FIFO parameters?  I see that's the name of
> the function where we log this but they're more just generic bus status
> things.
I agree with you.

Can i use below name or any suggestions?

+TRACE_EVENT(geni_spi_setup_params

Thanks,

Praveen Talari

