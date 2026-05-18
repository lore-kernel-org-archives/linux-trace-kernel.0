Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427E30C35E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111899; cv=none; b=JNJqe8ThpgmSwMKB10WsBGjQ9Havn9omJAaFCbko7HT6LUuWzTUqtWeTAd59sgpvjqdSDRhQFhWwBKETiELP5krDeMfhtGdRw4Jim6IS/7iA5kwJ5ORV1P4jnj+kTZ1ykxaAJ0BnuKrvBdEjZA6uJogtP/AZhxQsrS+9oQywnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111899; c=relaxed/simple;
	bh=lHvda2NbFgW89aGtBUROhxE/JDE+sRSb8r8BbzUoSLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUKH4TigCAR+r1eQypILnRuagTiXhto5t/Y2fJs5r73ZTa0/XzsBFTD1U3T1Bxrs5GoSwl6i0aJiGtHIPnIoPVGwsT3KTVeFTwTjb9/mXKgeF2f/dUhC9QtN3ZxMJpt+Oc1YxzxR55K2jl3XDI0uMPSzjPKEdk7dsla63rbwdL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oz6SJ0q2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D1nlDL6N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oz6SJ0q2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1nlDL6N"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ICp2Fl2438007
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=; b=oz6SJ0q2ihCIsKhS
	izEDZsnIZ/68zpI+HyMpKXsv33iN1nCp0OST0FF+9FZGCNB5FfUC5kNt+Ni6xPdg
	ChhH0eMonqSRRpRIidoEZYkb/axB7ewS0aQMzipvLrQuPh0Uq0PzcTL4STZdtMCA
	+l/J5qdEKHydRjm6pxR5n3/qXUmBQyuKogQKMtZH/itAA30B74l2M/b3m2OX21t/
	J9J9t5XFaenSu/E67MCXQjzObmC1IKea7TpmbyxD1cP21mFYjfrl1mtFCcGL8X5B
	nCVJ5PcCMLykSLrx/4Uu/QmE/HLV//OZJ9kUnBtMUHo/zFlItzUHYRgE1v7wQYFv
	6eUxqg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e834v06g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e62562b6aso8281161cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111893; x=1779716693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=;
        b=D1nlDL6NM3Dj2yLgQJhqAGTwi4+zKVYe+DgFnofdA05NYWLzvmRNbu8wU5zXlS0PrF
         LA+LqBDF3wsJ6l6KQLdk3Vn3FJuXpNidB/CR3ezifYBWMXZfeOOq+tTIXctzApUpR62E
         /Qip10N3maiPwrUTKY89Kw0cdx1PeetZ+x15mvAwLVe+6ABf/46n8TrP+WizeoeBb3vP
         HcLwx/KCvu+J/gCp/QiXKjVD7enqwGYarInZZlhBOSTh1Hf1TILP0MT/dsfdoOV1+cyS
         J0071sZcf13k3xRhacCz9NQMxqyHk2Ty/HT1QAIZCMbT0mV5I9KMnfcgAma+npYpa4JG
         i2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111893; x=1779716693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyevxfIizzgDB7/P56OEYcISboPpJOah7P6lWmyc20Y=;
        b=VQ7W9S5D+EcpXADlH8+Imyc98ThJIYvRqrra/tUqdtcJv2IPRykDjm1q3yn1AiPdQt
         y83jS9zxXWfQxdPRmYN+2O7z+4Ei67Ki+fa14o1JXen/qo44zk/3NvL2d4lZ8rMLIdt/
         Smi5B5UE2kMY639A/347TcgzLSmETiuj1My+rrEhmdf1f4iDW8lcnKpT6NMpAn9ww59O
         MU9DttrE1VAraU0p1Muo43IRaUcOqZCgLfzeRKv+O1dlJnLjlAxD2mPcv7BnQWoms4xn
         or5AUfDIOjwUh1bH+2MpisQSYssQtYnhdg2jeknsoIzO6KMqeXAWAXjiUykI12BU41T3
         RlmA==
X-Forwarded-Encrypted: i=1; AFNElJ+mw7MJ8O+DapyoMyHBMPTw76CaMnBkz7qSM6w545eTg41bik59E/yJdK92ZBnnx3SSRbErAOXrGnX61b8X0VoNnv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfj1r7wp62Ochr39Y/LGxhiZwwK3DmLzRzDHiscwSsfNTEQir
	a5RKn0rQ6J37kJpv6fQe8mdt3VUYP4EYqfX4dhRdtOPaGSdnWllMHA9ZKYCzfp3QXRnQokLQew5
	YgQg8QvlMvVe8bZ+VvT/wQhm8grt7hBAd9qZNwEcdOfWZd3kASu3YW5FgT6abljQ14ihvko52ZI
	E=
X-Gm-Gg: Acq92OH44N1HhFMOKnL3EInF65wZNN21pmaPlxzeF/2xggMOuqWUmZ0qbNBEHs+K290
	mClUl+MmTSG7aDoO9PSoOrLPMQH+jTEugC/ED/XzKYoMlyqVs2PoeVYhsDyad56Ytvdm9jhQKJS
	IPkh3xM+g7gpR9H3PemHWTW/R2oCjrkHzxIon2gV/SRvN8ib0KqUWH+z+FPUVzES72XKaFLoF44
	S922WDQmQKrRg3Xn2GcAk1/lgccexVnSuk8pvMGtSOXs648krsih0qhHlH9OjBXT/PFQN7XsyID
	H5xixN1C21IrSN37EPBH3B9j6WEuX4PftykuQIfKJsOWb9JTEGcd17jkZvk5NVA4b2YBjbQ9S57
	y+ADfFFdw0JqQyaJKXOVobVv/UHRMqteQ+hebbMIwuR3YVlgE/uqW5twdig0drckCiFxJVCbquy
	jvyt4=
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id d75a77b69052e-5165a202f87mr153359511cf.6.1779111893417;
        Mon, 18 May 2026 06:44:53 -0700 (PDT)
X-Received: by 2002:a05:622a:11ce:b0:513:43ce:eaa3 with SMTP id d75a77b69052e-5165a202f87mr153359221cf.6.1779111892776;
        Mon, 18 May 2026 06:44:52 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b52675sm5248215a12.8.2026.05.18.06.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:44:52 -0700 (PDT)
Message-ID: <4056582b-a6d5-4fdf-8cce-5e2d20b00a08@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:44:48 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-2-3b184068ecf9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-2-3b184068ecf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a0b17d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-Sl1Rx_dgo55JVPCJUEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: tNj63HXkiJijt57K-ATVfDVnFxKuZt75
X-Proofpoint-GUID: tNj63HXkiJijt57K-ATVfDVnFxKuZt75
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX5KjLdX9Ew71S
 HDsS0bKhSZXMlncPANFzqI1wT1K9TAAV5wbkLklPbX3yfnQlVcZD7xiJbJ37QbQEM8Tg1JRtCQD
 XGTZ+TqxQlNQOT6hrnS947UOOTvAhflGBNg/2hvdIiyo03laBWLrHUAQ1VRqox1oPtpY3p+BsZ/
 bCZAZBsqLYF+2AmJWdybx2c4/v1bjEO2aHpOXBdyv09p6T9V/vUkzgp+YLaLBLIA528fANeA12Y
 YMcs2GB4srC86GpACH4ULXabtwxk8gcWK8v3/MMZrlksoS3zLti2Mu1dW+pmTFmEI/yqD160Gpi
 fWNYxBhf/99vTGpT7AtwI0k8xBZLg5jtqy+U9gSaT/S4SYa2in54ZR7JqzSVMeOdjA/HMvK/bHM
 SgJy7kVMUfGT7L/ng4J1s4nfGT0GTFH4l6xm5dAfYf5bYUYzPEtkRJM49Bvi4ONLA0zZmlFoWJA
 TLWEeuU19y5CdWUE5hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180134

On 5/12/26 8:12 AM, Praveen Talari wrote:
> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
> These trace events enable runtime debugging and performance analysis
> of SPI operations.
> 
> The trace events capture SPI clock configuration, FIFO parameters,
> transfer details, interrupt status.
> 
> Usage examples:
> 
> Enable all SPI traces:
>   echo 1 > /sys/kernel/tracing/events/spi/enable
>   echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
>   cat /sys/kernel/debug/tracing/trace_pipe
> 
> Example trace output:
> 
> 1003.956560: spi_message_submit: spi16.0 000000001b20b93c
> 1003.956642: spi_controller_busy: spi16
> 1003.956643: spi_message_start: spi16.0 000000001b20b93c
> 1003.956646: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
>      mode_changed=0x00000007 cs_changed=0
> 1003.956647: spi_set_cs: spi16.0 activate
> 1003.956648: spi_transfer_start: spi16.0 00000000ea1cf8b6 len=16
>      tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> rx=[00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
> 1003.956653: geni_spi_clk_cfg: 888000.spi: req_hz=20000000
>      sclk_hz=100000000 clk_idx=5 clk_div=5 bpw=8
> 1003.956691: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
> 1003.956708: geni_spi_irq: 888000.spi: m_irq=0x08000081
>      dma_tx=0x00000000 dma_rx=0x00000000
> 1003.956717: spi_transfer_stop: spi16.0 00000000ea1cf8b6 len=16
>      tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> rx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
> 1003.956717: spi_set_cs: spi16.0 deactivate
> 1003.956718: spi_message_done: spi16.0 000000001b20b93c len=16/16

Same feedback regarding this part of the commit message as on the
UART patch

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
