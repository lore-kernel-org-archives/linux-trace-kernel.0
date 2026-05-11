Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492F93043D5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467819; cv=none; b=mpwtX1O4dmC0wAGkmILPPa1VARfl4rvhkgaAU+6vapY5bYyh00ASy4EXRa5Gl4EPDlH8NrfbQsZ+MVBIf8AlzhI9/+dTybFYeJh6y/AqCu8AbtvQTxmfphGmPLZiv0RrxYjWH0jBn2YGbFIe81QLClUlJZl74UdG9uf2FT2g3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467819; c=relaxed/simple;
	bh=7CEpYxzjG9fIv0yHhRZqWpmwWgSC8zbSJ88P6IVPJYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FThIo7qV0pfESqRglabI7Zbi8XNcmqx6uNElOvA4ioQm7z4wBfl1npUqiqZsa45Gyn7rJLA1lVWHWy7uvG2PrAfh370jC0lE7Wfd1eeOC3G3SYBg+i5MoSOh0HuL+lwafBAlA/3Gm2e8tyou1YATazGFHY1DYCyoWAlYVbNzvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XcveZUs9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LmVTUZai; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcveZUs9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmVTUZai"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADbxPE1128933
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 02:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=; b=XcveZUs9ReAEQ3dT
	eJXcseiAL+gXINniTwpzmLVBPOOjvgeXlPJzsG0lIF+dOJN5FlOABJ91JAJqr6kg
	jJxvYPVtMY/jKsu9O4OlOUj78f1zvj1EkO5gtvSpdyDY9U7y8xc0wi+Ly++OvsDQ
	qD0fdKAVA2qi4sde3qSugqEdYteBnf3VF237JfUU55HAkgq5rKDvLFY74K8nlflK
	iFKMQinTFUodfLV/N2nxfQSaVPo22iEK2l0K4RMggKg1lY9k/Wma+/V62zXHnnLK
	R3Kh0+d1SSM2r/u+ee+yWeEPvQoVbDk1D/K2mJmb0OwUOxQyxBbRIdh3MvHtmCkI
	H42pnQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1ux6v885-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 02:50:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36521936155so3912876a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 10 May 2026 19:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778467816; x=1779072616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=;
        b=LmVTUZaiGZnTaoonK72mBMVXJ9MyysK47FZogfx6dQtmYFULiKMly2N6dlwd6uUYQX
         51O11/DbgOdLUsMrTPF2v80oIWBbR7MoIo0Ha5o1Ct0gwmzgPj6uc3LeRBc+lk7bo0yn
         ARbS3yZLEllhSw/mUSZsdYQagFssrg5Rt5TUunTgrT5M0YO3GMlv+uMtZS7yQtEj9gRb
         brYMMR1hRv++cYo/WFNgToyH7137DFuG0upQsFO0YSq2wiPrAELKVH/ALGPXmIcIsKWM
         vlhABHaALEaLsSPluNVfHeWxSbg90XYzNgpK/CUp7kGEIX9W+uo0isennzd8MMRL1IC3
         TccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778467816; x=1779072616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFrXtXBDcGtYWCCGYy7o+Z4QHvQ0PhoJyB9RJytsiYM=;
        b=lQlEaArUPMalapAA1pZa1al3QRh3odgDqLOwjw7loRgGxG3v9pAqXpOlXsxeLl9HEf
         RpZT4hkMLP1iYQaxwbQXNnknxfEhlmLLmVoUqMVDiWr+LGtYnx1/nZzvQIByjWV2TDyU
         cnzWTKEzgnjh3ZGZ+4tDgGEFrxogD/bMytn+HvBX5aN88DZxInghd+hpit3L8IAu3MW1
         dbnB9HiXpmGjhp1XgWRxwDzH23/Ca8IEMC/ErU86KXO0zAUc1ZjxZqDaKrUUdjKWTtwM
         6jmBHmN1CdtHrAymddpXZP8XR65TY4JpwC/WbuHFUSQXXXIjtu/Op6jQdhLF0LpGsffH
         UZ4g==
X-Forwarded-Encrypted: i=1; AFNElJ9Rmnt9L9gydOZIAuN/9hUtBzjF+J+6EXy9llOvNO+3HU3NpwiY+9DiHJr7zJIiM0SLn6Q46F69CkH/63pV4uJn/as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCmRQ6a4eTiNMY+MEKrbV1k0CupAgRdjacWLN/gIWykqxa83RR
	EYPk6dhkk4S4XxqYpIC16LseesCkfjHVYKjzZeqtt6u0mm/APjY7RX8M0/wZosC+NVUdp+0sc9h
	KtK8SzFe5wBbTKACviKGR0ZAUuBdwjEmoxvBLQVw8kPLBLpExtQ6QAq3RHmDTXtYqRw70Lnvb+T
	8=
X-Gm-Gg: Acq92OGuYhx/hpIXO9eT6u/I5vQI1lz7MxFF7xHUF6HcOjiVAeLVXgIPinbrNmP2vqv
	bj12edD7w/6yjIo4tWDhnjHhD0sPv5USgcXHqma4u6K4Bm1eayrDHvPlataBTxXyOKSYxDrOfSw
	D+44ZiIA9UBterHpoBCAF4WdckohpNmlwyYNZ3OP73P4cE3TGb0a4ZBp+bGo2SZ+x6rc4rJ/R6c
	OqBIL6RVc6MRkqW5XqwtvYQ+hxShajSru/Co9MTmueEdtew68cd9Jh+XgzyDKjas8RalsBXYWvp
	4BYrQPFHpkfxFTkQDYYmJ7F1y8c9VmiZRCATtseXM+Sf4eGJogwPRRBgNp+fJsVxJo2Pj+Eizq9
	fU98oflqWKm6GIDFndpZTg/9FV8zU5XWKcsqKr9oIWtCrfmhsgI9LdA==
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr20842077a91.14.1778467816123;
        Sun, 10 May 2026 19:50:16 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr20842054a91.14.1778467815512;
        Sun, 10 May 2026 19:50:15 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fa47sm5901498a91.3.2026.05.10.19.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 19:50:15 -0700 (PDT)
Message-ID: <5ffd5ac5-fa9d-4b4a-9c65-2595271a98eb@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:20:09 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
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
 <4d90b061-95ab-40d4-83d2-13425e992d4d@oss.qualcomm.com>
 <agB8AgF3qVqDw60Z@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <agB8AgF3qVqDw60Z@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyOSBTYWx0ZWRfXz43Uh92dm/PH
 bLs0ycFwXJRlPLAmk0izlEGp1Hm4WGwx9rYCpTtsTt2Lhwniut+MBeJnw0+V6iQSzkHrnsBzbTe
 B587ZIH5sC+nBPw7noMgTUwx47sQGviQYzDKiJ9hFr03PpKXiC4A4F36fRbhwO0KBMOgYRYnide
 3iILcedF03OZq3I229O3p3lq1zefRbAmXiMcN5gBjepQ+rhOD51rU0OVKPREDoSSxZZn4OKRfKj
 fmSlTOh15qzJ6BfhYhQtngKLl1tGifEsL+J+vXpXck6XhK8XQ4GfD/tEwKBh9snTEA0HhTdwhQU
 X578v0OctoCYOby9FklVy3TlYmnQvf2nRgg9opdL2R/HSXObloy9d71+AQWrkXP0ScXb9Mdyo11
 nu7GqvwwwzoFpM1Gew5upWMcr8wDQb3IzLTBwFB1QQV5bdsBP7B8pntuiACNuPlgp12HoB6TrK9
 Fns8K83t5fjUIleIPqA==
X-Authority-Analysis: v=2.4 cv=QJZYgALL c=1 sm=1 tr=0 ts=6a0143e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pozBpaLkQfaUl8DsMMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: gWJmJMl7WY8OX_3xt0ME4lyBzE5c5Ll_
X-Proofpoint-GUID: gWJmJMl7WY8OX_3xt0ME4lyBzE5c5Ll_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110029

HI Mark,

On 10-05-2026 18:07, Mark Brown wrote:
> On Sat, May 09, 2026 at 07:37:26AM +0530, Praveen Talari wrote:
>
>> Could you also please review the changes made in spi.c ?
>> I would appreciate any feedback or suggestions you may have.
> Please just sumbmit normal patches instead of sending partial patches in
> reply to another thread unless something is really unclear.


Sure, I will send the patches next. I just wanted to confirm a few points

>
>> @@ -1658,6 +1658,11 @@ static int spi_transfer_one_message(struct
>> spi_controller *ctlr,
>>
>>                  trace_spi_transfer_stop(msg, xfer);
>>
>> +               if (spi_valid_txbuf(msg, xfer))
>> +                       trace_spi_tx_data(msg->spi, xfer->tx_buf,
>> xfer->len);
>> +               if (spi_valid_rxbuf(msg, xfer))
>> +                       trace_spi_rx_data(msg->spi, xfer->rx_buf,
>> xfer->len);
> It feels like it'd be more helpful to log the transmit data before we do
> the send.

Sure. will take care in next patch-set.


Thanks,

Praveen Talari

