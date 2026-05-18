Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BEC481643
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111662; cv=none; b=jBWHeZtGfKMKc0c60DieZmfXXG1l4nLqQ4DFoOZNqKvki4JJfLq7wDuO6bBXNnuz6hdg3gnTnentvaXMOJFdEuzNrZxEFB7rro5pUm/Z3rApE535GyM12BCLe3vI6ONm+irAJS/qQ6m/6ColzFgHxTugmII/sbsebf8UO1+NXVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111662; c=relaxed/simple;
	bh=57KBMhPoXOLrxYaodFJyU1hyz8hueBgCg9SK1L5VcN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gd33QiDijflqGI2TCBheLctrQmESGCVEE0hB/bObz8kGHnpE/xO+cDQnPz3JFJv+1YSCvHIexHIiI3fTbHwQZgpG56/fgKWwN3EKz4I5iwj7ZBMiDPiJ5sjdnFMD2ickY5G5copZtzAVd4nfUeS05zU3icyfhtudqtE/k1ipo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipCDmSMZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FSrDgC1M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipCDmSMZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FSrDgC1M"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IAopWm2083071
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=; b=ipCDmSMZ0QTQsv7p
	MysuYeWl//kp2UqxZi6cY+Mbe0riuRiadjv66PX3gcmpBG6+L4sSbpCGD58V1gLD
	37I/2ZyOh8HNdY8RI+NJI1gVrypvq8NVmpjnMNAlMCL9ntMw8ssKlMRijTfzlaYP
	kOyrmccQgOKtyX8+XRXLGCWuGmPjsGxrs3ixPB/l+EXt5VmFwlM7wg6qwVq4WL2W
	n12miacMVR7PtGfh7I6JZC9Tcf3G3RP2hJswpP2hZjeNbW0B4qSN3GUvytXohtvX
	lncKiEen+oY8ta7DzyF77V8GHS/kZMHlJwXPL/ooVKW24tXF7vTJLU5ZGiqlwhBO
	qxzNYw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch8ngq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:40:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e5c781193so6187931cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111659; x=1779716459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=;
        b=FSrDgC1MErVtx5YBlg6wQmdZtNxAMh1ypnUq51AkkKnpXO1heiQOC0NeFcAaACETs7
         jSl6HWTbggw4wgGPiJaIFtYIqA0uuA6FKwefHorude738Urwp53KQ1shjlIliW9upKMB
         xkVC7usK/NVrmS2jp6RgatBw/5f+qSciy8AsZ2tctKsLjnIE81o0wsY2m8jk5sC30dLx
         YYJpTtbNwtnL5knqoKym3Cf6sZzCwPKQmep8l4Ql6CWfkUOq0rWkKrjTFAaAXpyVXP5C
         n3un0BQV3+pbC56lYD8or17R/T1bkoT1139ENndgKTTAJsPbXdrpl4XuXhytDVxMEoGY
         gcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111659; x=1779716459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/iVpdwss/V65EErDxjTuIpj7D/ub0rITgGHADjbz2s=;
        b=Z4wSP0fai/Sr76txHyASdxI9grwtev8kArcC3JucHXDrMtr6QivUKYvXONjrI3gpNL
         vqzIaXEULEbId68/9e0zK6cTyzk/LkMHxninqkRk1a3p6lCx0nMeCQYKg7X+q2GNLgrP
         y/tFYIwiG1xQMM4/ZDCVY7bYSawSqpdKSScNs1kH6/5BBeyl7KSHQFnFXnvR0qEJXKVz
         CMQ3vS/NDGhlPZTN9NSvkwbrpqp+bd5sOfw+q4YGl/3iuIe5IP704j16396z59D54p2P
         yhABgZ8dhI7wRTztwkxpkcxP2h/FDrUxp3oZwacoZ69e50q9gUx7FqH5TzNAA/5C6Rw1
         RDCw==
X-Forwarded-Encrypted: i=1; AFNElJ+oIcSovWhDSUnwirZjom9N0W9lxhbL1cleJ6BwQGp2LHLaI2aVH+8hRgSQyQxDf0jXaLUlKUnLI69SMuDKw8Qwcfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXokJuD8/aGXWenU2kpSx6oeNQMNSibsD/0BG5hibr1L8tOuTc
	0fPH3veCc516vlOvrAWKdDXKI3PFEUj58vcm4iz/Z+oboAQTdkYDVm8LlL9zHw1iJ5omdahd77Y
	HZg0r7uCHQil8U2isJ2lgAoZTIWypW1yNHE21+k8nyNx6zQ5GkTFPQOUd0NtklQ+g9BHzMkMCcN
	4=
X-Gm-Gg: Acq92OF8mJab9ujye2uRaIwv1YA8+0WB3uxZ/Lx8hY8ehTNct57bFJxENZ3WRfJtGP1
	FcLmHJNhYKuwTzhuoW4lZWVtZYRYyj2DQgc4poNm9WwalX5xUZKzKX7/RldwjgXEqwpIR6IAb6o
	lE8ITsr3upscp/OYsvqJKwXhhCtpMAB8DEgP3DpA1r8uYhDY1J59O2tq/2YHyBCFAG6rj9U2NLi
	cU1uqTQusk8t+DIyPKQAlf4CsEHztupfHYufm73X/T5fdW2ot1IkmA/kND+VmD5T7Zx9/6h9Fka
	pymMSduuwbrEuL4l99OHkSkh65Rr8SpuJqG0VcNJRuCvzAGRssgX+orSMAWf3fDWqsMhtiCY35s
	P1MtRmnPwCZ0WLhp2YpRFeH8V5mhjgRH3JgRsy+T4Wfr7rdd2JgUGIbmVWwWRQod/6KkkzCesNC
	5jARI=
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr134986271cf.3.1779111658637;
        Mon, 18 May 2026 06:40:58 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr134985831cf.3.1779111658077;
        Mon, 18 May 2026 06:40:58 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68311660f49sm5146434a12.15.2026.05.18.06.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:40:57 -0700 (PDT)
Message-ID: <21a1b097-be34-445c-b113-e9c9c70d7b87@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:40:54 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
 <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b16eb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=FDeQY5eERw5HgavBjtEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzMyBTYWx0ZWRfX/v3v6O1ZzgXQ
 W4744hNtnXZSNqbhdYTsQabT/19JnGnNCgIfBAl8u+7PkBo+V1STQMWKpNFUfl26tN3U53dOVMU
 VglxfQvamgRVs/Q6lzQfmn+M+pj4PfskrwaQzox129QOpg22NNWWx6neCcG8EbjR1xcJ7tC6edO
 OALNiMV+DEy2MqMjM9kE8rN4ZSJUYQUdZmQYlUcJtE/GSnj3dz7xnQtWhENfX+sEi1z2iqkMn94
 lbq2TcL+SWHv+zhWGWzAuDGGHrRFQb+/QnRsFpQfLcJplOWMJCL2nFVAfUPH0RzToC1Dou4MtsM
 gRyAMqie+Z7RYwJttg5EJ82/I6HO9q/1/HedtBllSHVhbXDeSE2eEoLZCGK82QFkAfe0cbeIStP
 9VXffkY3JXi7U8kk3v8kPSw23RX1onofPIcS+sOxDeGpmPPCiZkFedK0QRaTWszzRM4ybTmGSJW
 8u92gbSkkG3nkaZwBgw==
X-Proofpoint-ORIG-GUID: 7GsYSTQ9KdcP71YyX4mWTzhXFsEGL6hd
X-Proofpoint-GUID: 7GsYSTQ9KdcP71YyX4mWTzhXFsEGL6hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180133

On 5/12/26 7:14 PM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI serial driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover UART termios configuration, clock setup, modem
> control state, interrupt status, and TX/RX data, making it easier to
> diagnose communication issues in the field.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +DEFINE_EVENT(geni_serial_data, geni_serial_tx_data,
> +
> +	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
> +
> +	TP_ARGS(dev, buf, len)
> +
> +);
> +
> +DEFINE_EVENT(geni_serial_data, geni_serial_rx_data,
> +
> +	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
> +
> +	TP_ARGS(dev, buf, len)
> +
> +);

stray \ns above

otherwise lgtm

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
