Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65A3A7D74
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352107; cv=none; b=LWoE/t0O+B4Z5aX1fiRSmPd/9Wbt+5gRM8eie8TVZ22L6bkLWXNbULMQkebgkhbWNWFmMwxvVGxZh6BcaLRftTq2N6mMZYM+JBkuTz29lmksMGmxCF2+OXX/pNHDy0q6rKWHJDs1e5JJIHBM0DayEMgHuaKqyYdAbeGRbPMHcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352107; c=relaxed/simple;
	bh=24x+vWFLjhUk5l3YpK3HhMGF1FGUmyEy33Vjj+/mG7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr2vXvWQstgvwsllzeIkZvJ221Bw5V4Z0jN5hHU02syHhixdtCVauZCzs4MiPjf+vv+0gfLBha5kwlB0vdTC6KWg6gzfvgWwgGQbagWeMSSK5t1PmK/6JhWNJFxpjbg0ewnYIOi2HNYfQb3gfhUU/UZ1QV20rzziSb0uClCcogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPdAahHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZyWk+42h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPdAahHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZyWk+42h"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF65F825900
	for <linux-trace-kernel@vger.kernel.org>; Mon, 6 Jul 2026 15:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=; b=nPdAahHJZa+SmQ7X
	Om7qQXhhKSV6hKNfnZMEJofwS+PyJwzNdiSnFkYEd0WC2+Qnmv82TRM1NanVF4Ei
	kPZIzNyrHhiFC2HVnrUEYWP9+cmjliCJZAfCIERVQ9jENehf83WUqQPvaqq9hE2U
	2AIvqqa6zEzH7Zb+7xwZ7EkyB+QCB9JKZpzybhzZfiuqyJIZUiH4evYwGcq2ubBH
	mShl3zLv2Mxsmp99YT9L6v2uQFIgt7gRvH4sEMJu19vctvEEfbw/LyXlgM4mTDZx
	wT8YV8gvcXE7JjMRycdk0mzgU4BWQ+Bqfrh4hVKG2PbpqpqmD6mnMoZBHwWSPThW
	cw3hyw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t89vft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 15:35:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c2d2dd52eso2034981cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352104; x=1783956904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=;
        b=ZyWk+42hnl6FkCzOPMsLh98YteMOUNwMwbaua5kF8AAx380qFDz8eCxO4BEA40kyBW
         Fts1RbOc4dkiPsa/NBtl4DR88VGrkgW5W4JHTipIdZ5pzoWiHcXd3L24g5vkJVXeDMWd
         s7033Z4byi9NFoTxS/ncBgaJrKUt2D5q+EeO8gglCOA7G3kq/K+EAbYiltCX69gMypn9
         Mm4ei6wVLDjHdtdvzHE62jkv3V8IwpylQqiXCJuwSNpFhh0xNA7PUTTGnsZ3cXtwOEfH
         ZVndiaVbQNlIY98KOoQH/0DfIVHOglynwrRGYaosePOfHhQyv+Q2pgCk0dU3AD/AbkDd
         NkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352104; x=1783956904;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3zW101cLHzgWVTr7yKGtfLqHWots71GsLr4TTp2JZA=;
        b=Gck/ZBYYcPCvwfphD/gFbzH4k4Fk+7iYexlsPtpm5v4/87msbnl7ShbZLLjgqugscC
         E+YMw/I7uY4QTULmwfQ6IfNq9a7TCktpNsodc0UlIT7OW1F5fqLaxkPhgNrcE+wA5w6B
         ckOCASU5hmNkQFkMtNTgzlks/OGYfmaE2djO4r+2b8OOqqs82oRcWwIjgdiATxaXr5c4
         HAA/20/j0Tk2hwz4xwWB8I5L4aRZH5xxbVSV4PGlfDvyz7xh46k1a9PxWKe7/VjwJ7nG
         5ODLjp//Ql29v6FQv703tcWd14x0DeIK5utheY5qFAAoFkHhWOmHdT153tG4jWwvZUDV
         wMrA==
X-Forwarded-Encrypted: i=1; AHgh+Ro0M7oxTA7Xi9njmNQH5reIl7cW3Mzfj850gw/4s+D3bwdhm0S2o+juk5C1+p8UCk0LAbSq2284h2mmzhLidpfDrnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeZ3XVOjNOLycu67bgS/HJyX2voOUAc61glUBn9ZBA/OWH+uI
	Rnu4RT14hbFIltVevF4ZhdChoRNBAKAm+s74vguplkHHYy4w9EhCG4ShSBGxJcFMN/lueUVeHXB
	XkGdXsAOZ7n3RPDMjBDOUvy3GC78bySEkh5CytriIPVj5D+uOTS0IqBH33A+IVp0K2iKIpjZtZp
	I=
X-Gm-Gg: AfdE7ck7VrzRrjBdB8u9uP9DvgsNBp2blZrYNBydPfhwRXYW3W4NJWCTChkbzoRvr/j
	6SzfngpICxgtnCaPHBU9KGzBe2nj4w8chYmH/5ppQHBZ4cI8RrlKlI1Iawp2pMkNtSnTA5RsIV2
	XWgprwGFOOAI2uX2WvLJ3h0ZgHnBHiFCzRDjHjd2Ag7MqKIjfAE0F9iP5Ld3/8gCp+NArjZaPSx
	KPU3G0TGBHWqfIbxoC6R0cQQsGKdZ+os/Nwj08jkZuU2Ot/5yayUgC51NI4Lqgkiv1v0MEhqw12
	OUaXX9EO2KN1XSbDjJpLXbjOutbqFeRqQFqvrYDy1XopLGOnDs+9qGyrRMxSMgS5pYqrswGtSt+
	A2hgtPxFcgCTZo63cImwSlFqpA+Xq5v6lufs=
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr98384951cf.6.1783352103921;
        Mon, 06 Jul 2026 08:35:03 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr98384441cf.6.1783352103372;
        Mon, 06 Jul 2026 08:35:03 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6054fe7sm772422566b.10.2026.07.06.08.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:35:02 -0700 (PDT)
Message-ID: <8b30a278-3a53-4f0b-93bc-ee1822430b51@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1NyBTYWx0ZWRfX0mRcC4NMBvOf
 Jsv2BoSO82flRsQLmFHwsCByi3BebcV0n4KrmhHW9OURmRJTM8pUVeGTD0Sh0jX3qWCcDUA+bBx
 h31s0FzrDR6rfDM7/qCUVsYOGIM3DM0=
X-Proofpoint-GUID: W8rhlW-M2F5evucRKHQ2Djfke6FVrQQ_
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4bcb28 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wRhyhPH_MPSplg4SnB4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: W8rhlW-M2F5evucRKHQ2Djfke6FVrQQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1NyBTYWx0ZWRfX5H94jTbiOD2T
 FiMAVEfRN1r3ZMfJDjtY9GMun8g4zEjrmp+uN5+X8thnI+SKMvc6tvRHhPZjUvv1gNhK2Wz/zP+
 IP6qtLvrADkl4qrlzquve6pxGP7cnnKTgrcm7KhcMA5j4P3hE/5BVS9n3WKydp5MtqKrbLAVuGR
 Z/1ietsRJMnQUg98bGQm2r0kFuDlOqyp0Yc+2QmzYWFOgBFJcF32FWzwVRCMRH3riPyEprUXIqu
 A3t1Rj/FmZFkeHuaaM3FGx9QBgNkLB7K2GH5t1St7araB31mg6k1reKRXEjya7iSYb8faXZBASt
 zum9JG7NSUKA/zfAhl/OQVMWL5PzaUZNqhyuMhrvq5L9fncwiG+/iRXvlJW8xTvIBDZH9VyAWI2
 LzK8itUdXmU4Bcy8F5+5CVugQF7AUf7SHzLjIFpDnmI9vQP1x1eMCP9WjL/orJkWhBA2gf4DByI
 +fHZUjxgs7vWfWFSIKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060157

On 7/6/26 1:08 PM, Praveen Talari wrote:
> The GENI SPI driver reports various transfer failures such as command
> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
> interrupt conditions. However, diagnosing the root cause of these
> failures is difficult as the hardware state is not captured when the
> error occurs.
> 
> Add trace_geni_se_regs() calls at critical SPI error handling paths to
> automatically capture GENI serial engine debug registers when failures
> are detected. This includes:
> 
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - DMA transaction failures and pending residue conditions
> - Unexpected interrupt error status
> - Premature transfer completion with pending TX/RX data
> 
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of SPI transfer issues without affecting normal operation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 26e723cfea61..7db0836308c2 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -3,6 +3,7 @@
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/qcom_geni_spi.h>
> +#include <trace/events/qcom_geni_se.h>

nit: this could be sorted alphabetically (Mark, could you fix
it up while applying?)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
