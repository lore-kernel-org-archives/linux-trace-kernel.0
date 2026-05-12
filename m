Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227B12D7D2E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557444; cv=none; b=FoFJLf0egyXbdkos+lMKaY8Rio4PEU79lVh5h0rf2ijeQO2oAlgB9bc0HnC0PwWfe9ubyZI+BBA0yL1hmuBHCI83Bl+2IiFjhu4Iuxll4UD8bh9PCxyzFS4bZJbj4eCBUnPJ9iDTJUEELwgRqa8UHcH3p16avkP74thBL6MbPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557444; c=relaxed/simple;
	bh=MZELVoEOl5tOHByAEwm/jpAsnRa0DkCTxp6FA71Z8IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPcuqFfkONKEVGnmGl41LpP0Kg42kH79zg860MuhWySz9MC9plXhmuWx7kxfcCUF0UDVitLxwYDWtJ9+DPC0kYpxcnCqcikev0Kg2XoN260nbrphFVRX1TFgDl8Tjzrtxe0b1bVYEm0zCntelvPA9i8cdN3HVJp8TnB2uUSJFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTQXsWZR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GT03sZ8P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTQXsWZR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GT03sZ8P"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6eCl2519014
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 03:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MzAPHv45P56jS617vj7sEIThlNMPest0Xa3Ik6/Stg=; b=PTQXsWZRN7ZthNlH
	RmowvZOdSRBaNPPdCii1AfYT6pWZ4qTBBSiVziIZaCeXcIn2oS1nmz8KhX9OLyp/
	w1GLefI/dBVtCYOt3+UGePQYqQqo8nWSibDKbeZrwWNGBNfO3BTNYMsF7ZzxxQP2
	nBIwtCxny6t+ylNX1heNluqGXtKlelEGL9+8888hGhfxvnNYZyRlvDLhwZ8kgdyo
	/YX972Ad132+pJ1bwMGR9Ts7IDp8NUJhhzElDpTR0LTO+yd8tNGqhFb5ViGC9c0Z
	Mg5kIh79PrXn0TaP3YEFuv+FunxFAwi5/LGrhTPyuff+Kny70TfUfCQAlTL5KfPO
	ERihWA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv1ha64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 03:44:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2eebb099efbso4860720eec.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 20:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778557441; x=1779162241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MzAPHv45P56jS617vj7sEIThlNMPest0Xa3Ik6/Stg=;
        b=GT03sZ8Pp7W6iFRjLa9YzV5Lu/NdQ8MKluVpTb8Cazzm3J1sRaogGxshj1GurzcYf+
         ydSvzn37eTsW0POzKk/tQqvDjPkqB91Sgz6lX/dcUw1JRDH4KII50ilvIhEvczLrCrow
         W6V0SQTsY7Yxh/PNkqRtTH38dtd+JJIiaFFpr+2shbDWG9bmazqEf5H+v49UdPSkdB5L
         k8UvWbR1s2+6QFYKO3qhr/f4H3jKfpFl2vc09KpGPdvoeHuGvmU+8845jPAwXAQx3eVn
         ZpPZyYg3TW7VbELTCho4+5navYrVoAy1WXv3GgK9mNYJDckzIabVHyOuVXeqlCNqHhmz
         GdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557441; x=1779162241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MzAPHv45P56jS617vj7sEIThlNMPest0Xa3Ik6/Stg=;
        b=fAe1w2drQR7aamXx/zugHGN7irVuiZYS3rBCMlEqhVAS4m8dBHtvRDlHNxCxRmSDdz
         ASYR64YbWNAlSP4q+yV+tPbjbTzN6mS3AWX80P8kd9Du59X15owh54VA9N1C0hBjMY1H
         2WNlHbGbrmDq7gzsQYtbab4xQ9ECACi2KnanXkBAV48I1eVZKQBIubSM718tt057wbnZ
         D/NOHsKcpRhTPyDrCwSeUjuyQvdlgnt9WYZ7+VLoU47qCe4oy4WPB1GBUlJjZ+weOYWD
         galtXqljf3Kw2KnmOg2bxRF5QDGMmOlZEhbgQPD/e+awd6tR1BT4PJ51UlzEK/kuA1bJ
         8Bhw==
X-Forwarded-Encrypted: i=1; AFNElJ+tunJa9d3Oe0NvcAPlBLSaftoK67EBvNrTQVOQN6L8oKHUMXpIjHufpLteHsiAcBd8TV9EoGFdbArhGkV+N6I/R0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7nU2CNCnSuiLoJ+4Asc6Bv+iARDRnoSa2yj622VDCDAL+n/t
	TZ1PFXXgCluVLI+pKi2o5A0yaZ0QxmMoEi7vhBd9/5m5OGgTLGTuTqTvNjQcHvT3iD9F0kVPIFq
	JmGTbLQdjpcHwmb4nPzbaPtKqUOhsS+k8iKGOBDd5VXV/hQpyx8hiAbbZrIBpXJMPy847kCQb3z
	92rHgz0zIGFQ==
X-Gm-Gg: Acq92OHmD0aggX+C2HdV8r5qIAQ37OOsUHICOkHQXqfDOSrE/dKVDOFHbrbghIOInPs
	AmFHsvxR6RhvvLT66ToX/xMgS1d8W8AqQ9IvIQRsrUzt+4Nn18mEBtmCNep9k4ZHqo5NkyNXpG1
	QRAeIdyMz+4TNsjmkdTYQ3X2cq59cxja7CzzhpwNLIrnpvj57fKOsimN5DfbgNCDNTPgfwV8EXl
	C0DeoDUja3YXJfH0imK8WFOazn/E3RMMhE2tNoh7p1vdGrATBns7ODuAYXSHArWah4yVs3LrcI3
	OzbvMkKc9oGjVnNX5/bd2o9RhV9/yJbDcowbqIo9sgomwPX+ifBpidb5umvBtZdJJghSkdYt4xV
	KX9IqQixaAaAhBVOeYp0ckPG07pbS8AQBzKA7tOvBqIKkw+GsPLqS
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id 5a478bee46e88-2f54d15fe7amr12704117eec.25.1778557440901;
        Mon, 11 May 2026 20:44:00 -0700 (PDT)
X-Received: by 2002:a05:7300:3b08:b0:2c7:3a7:c7a7 with SMTP id 5a478bee46e88-2f54d15fe7amr12704099eec.25.1778557440351;
        Mon, 11 May 2026 20:44:00 -0700 (PDT)
Received: from [10.92.208.73] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d43b4sm15873980eec.11.2026.05.11.20.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:43:59 -0700 (PDT)
Message-ID: <4c8318a2-2e2c-40f2-882d-8748f1bbb303@oss.qualcomm.com>
Date: Tue, 12 May 2026 09:13:53 +0530
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
X-Proofpoint-GUID: rMQh1kjtWasmynJgbUOrHSTwoZcoxr7J
X-Proofpoint-ORIG-GUID: rMQh1kjtWasmynJgbUOrHSTwoZcoxr7J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAzMSBTYWx0ZWRfXwbYDNazZJUiy
 PmFNHbVt1IjVUkAl9AscHAK4a5svgYn3IoEidwuXW4Za3BEmV8/bi2Cu4QszOY0+0PakAqvPnUG
 7Rndf/ZW+hIotuqTdSVXBpOwnB/ZprGPsC70dte9KxwnvZZZPjx/zB5RK2cXFz7f3N91+7meTpM
 Mu4Rwb9I6QbHC3uo5sPpsk00csM3k0phgZ9aFF92FSh2c3Ty96wGMRfN2XHdG0LLU6rJSYqhcIn
 OQs5t6DzFJ/oBpdI6CTJXkb9VcwShhGF1WGmsqq7xY1pcBt/JB/PdlGPEjVzmQbz3K1qWAgMovf
 I75xG1CI3e+qgFDCBT31CfVKCzarcxSJu0xXY8nPghsI6q7ZfCzCMQ/Ka3cUyDoUXYAMQppyYZD
 HJ/3bFq1cPh9YowV0YKFPbQhRDj3EeejRFHXlTlVto6k4atBKr4qLGM2Edd8JF7L8ubiA2ARSFw
 i5ds02kDzwSujgcdYYw==
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a02a202 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=BLhwAGxgQewik7T9gzMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120031

Hi Mark,

On 10-05-2026 18:07, Mark Brown wrote:
> On Sat, May 09, 2026 at 07:37:26AM +0530, Praveen Talari wrote:
>
>> Could you also please review the changes made in spi.c ?
>> I would appreciate any feedback or suggestions you may have.
> Please just sumbmit normal patches instead of sending partial patches in
> reply to another thread unless something is really unclear.
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
I can see that TX/RX data tracepoints are already present in the core 
layer, so I will drop the TX/RX data tracepoints from this series. I 
will update the patch set accordingly.

trace log from spi.c:

spi_transfer_start: spi16.0 00000000631b0da2 len=16 
tx=[d8-07-1f-c4-b3-b3-07-d6-a8-7b-33-6f-7b-bb-ae-9b] 
rx=[d8-07-1f-c4-b3-b3-07-d6-a8-7b-33-6f-7b-bb-ae-9b

Thanks,

Praveen Talari

