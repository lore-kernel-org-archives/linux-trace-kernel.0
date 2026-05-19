Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC223395C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188389; cv=none; b=srf/Q1lotpw5E7BIRgBTt8PuP5yDqzpBEd2EWuOyZMy/PHTF1YJLcqzyzzX7d2Gk3UG93V5p0abgg+mu1ELG8nP0Zgwu+oBfTTNgNFFPVIGyRDVvbp7Y97lu8ufCUgSLYvtPd2J/0U7c5T5TFHa5N2rX7+PHIDIYnl6f1JvY/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188389; c=relaxed/simple;
	bh=pYndXf2KAGQT4uraSK0I2EebaLVY2dqZbM0fqBUTB/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXqVAHyVmKQQGdz82tHxruuA0adwJ6/UKGjXbURJgxWRY11jxpVu7NvbpC/rT0kvIiEArFIht07QydDKiCAG/JT6eP6ObBBBsj3S409OpywmgF7AHxGvXYMsP1R9tv6LNHTIzY13w+SbixyZYXSbr9KHEYSdtYbo10fR3YQdfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MgN5964V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PAq7OFpX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MgN5964V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAq7OFpX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9LowD4062907
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=; b=MgN5964VrMlkwu3o
	mQtLMtF/QdtufHM6bYJkRQObsPCzDl7u3ojwpJjlvhUEXypr9U2hhuJq8KmZzJHR
	AcBxzUv4uSiMG0WDrMnnzsg39z5rIUrdwD4AiLReR7w0qIDwyFjM2yk+bcO26U5S
	c16gDYYKTIMZUsL/XcYGRgaGxO6T51QXQP2+sPrxEff30dy5lXhdPhI6/uZBkwI7
	72D1AnZyFBw//yg13cXLjivUUrhRN3u1V9IiuBhQXpeYk8AdfYgcNKOEzMKTDnmd
	x7CcY8YY+I3qLiSVBXUzouZXkD8zu5FDJPw2D7DAYj25LjePCf6miUffdayib3wW
	razlOQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8n5u0cbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 10:59:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3684cb22502so3169103a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779188384; x=1779793184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=;
        b=PAq7OFpXZ9X8D2eOnmixVo8tw6Gjm1vIA6lAcfRxYsk1UHrj2qNySplQooy2xWKXJY
         5HgjExk3AdU1J5DnVz9DUs/K6dsB93e4fqtemo3VYQ9DS6ZsroUNaQq+AtnzaCIDdkK4
         OLVdLmomVDUR1ytTdQOsYBRa7E9Jdt8dWC94XJ/WDgSFVetGwC54+56nbVV7DIV19XGm
         unwVXOKgie2xwYT/Aj8oSYc7TWOdTmgHmwYtByHZ8ciIFXj2LSFdgGO2Ry3pqpmRr/xq
         olf58xcX77U48niwXLaNM5ZszJdIzmacNaWdYWjxq2A/61jtWLHOtXGdy0NMzZOu4RrQ
         Yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188384; x=1779793184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3GJB/k2ynxWxGVEV1RFSKNfi7UMFKJzz6+gNpmDXEA=;
        b=pXPLVEMumsPOofxsjY847nOpGvqY/rf1Y4pouLiBTUMBV8KIYDZ5yCgmYZGsj/1VX7
         tclw9kqI/zodesGTvnBcA5mMxZEhcCyEW9Be7YbNJ8Zoa6T/Ig+N1wlZmTx7N5pD5rvi
         1rhTiNvMsDAc1qrn+SsPjS7OwRRRVEN4//6sglmddT8lKPDJF6fwjAdzEMtOX8CHjQhj
         /I5cp/U0tKzP/50ueaLty1xa8hV662Od3Q2rc/16IywgB75roT+k6zvJp6uP7Bb8v025
         ktuXOaz1k0GAECfOD7GCC3Y77jSgZmkwjruPv1Bg+NhZ5zwP3vv7bwoN2vfaEH0ZdPmW
         zU3A==
X-Forwarded-Encrypted: i=1; AFNElJ9G37sv/zL7RxIr00z5fhu3Feq7vJ1cThr3VJukbcvjoAJrwfpceF5s+tMvjww9FcAskXQs6EqSDn8vx5HfWhoNisM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+bcqWrJq5kSMWuvNBqJv7JWko8s01Nc1Ca7lW48nvFCzuxyZ
	i0mSMT88J2E8zqketm3Eyjw1KlrB/y0w/NIrDMUCoZklOlxp7MEPvBMs5m7RJUal7dItZSQLgdY
	ZApwSD/+CcOL+L6WoeUrKtv/62AOC/W0hZa8i5UQkWZQi7eAOlUxshH4b2xKfsBenHggstisdHi
	Y=
X-Gm-Gg: Acq92OF8BCMN32cvwd84m1TahU7GPqpO0SWyvz+7/y5MkLrMFs1SrAJLsXeA4LIMWJp
	QzYMOxIT/wYI33QpBQ/HdHUV5rViOdi+r6KgaJcIrKicN3XE8AUjsfjI/3SL2ZQyYn6BNtWM1yf
	dftUdqmSQ/y2GNtwKSI+t94QvR7eIoJdV1EQcYrMRnVztie32pq/nAUdHugivHawyUmQ/PMPj5F
	D/vAa4hhCWniza+RmP5Y0rDWtGmovYqbpnklS4lL9r1VRnDi/t44Bef9TnCVTBXySvfIQtGyd8a
	GozYUUFIbv/9L7G0fNdHMxAD7dZmniWU/zPgH9HM+KMEo7HwQf+7H7m6/6jgqgBT102YfEcEx2I
	RMnG4CfH33OR25gxmbXSwTWa+mM0aehGk/oEvkPlZ1d3DOP/awj2b8/mlYZMKShuV3wc=
X-Received: by 2002:a17:90b:1d84:b0:368:433:b697 with SMTP id 98e67ed59e1d1-36951ca51ecmr18877737a91.19.1779188384473;
        Tue, 19 May 2026 03:59:44 -0700 (PDT)
X-Received: by 2002:a17:90b:1d84:b0:368:433:b697 with SMTP id 98e67ed59e1d1-36951ca51ecmr18877703a91.19.1779188383967;
        Tue, 19 May 2026 03:59:43 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369514361b6sm13809344a91.12.2026.05.19.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:59:43 -0700 (PDT)
Message-ID: <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:29:38 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
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
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MfBcfZ/f c=1 sm=1 tr=0 ts=6a0c42a1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-fVOaADM36-ZU2ItTmYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 6vrAHQSkm31XSc5tKBORzmiTsf5kr5l4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOCBTYWx0ZWRfX9ftGMG47GAA1
 DCHp5ZWlCWfN7lORfmhGuy01pwuojs9N48kpQJYDmwB/a9qNLy7wYrB43Wdm5y4IX94Wd9F2etz
 s+9wT57qefaUZGCn16DoROz+QP2n+bcDpWNJX0rxliBywR071GJ/kEupbqmb6PeHRxPY+NILcn2
 7G3sOZAL+p0I6riQZHrcv+M7Vq+H8vupXCGQPM0N/FY5DzhVTsiX/7WsZnOTzZ38g4HY6ruQpBO
 ShpQq8BLzOWOK9cZIGsbXo+YoWxu88/vLqDI1c6u6hrqFB3r57oZzTR/Go5WmxgvZAg8O7/oLad
 9QeuFRjjXwECqIQhkH5CyftBv2sqd8Lt+z1szpwTrV8I7SG0AchG2lcXVe6Bo7DlXJ+dRUAfHC8
 EIoKZLumVwEDMZ8yBMpiwutnj5FZfRPSbmn1OR2NDwdmGdXypTrM/QtZPXagHApnp2LpJ7rIhmg
 CY4cLbAObyiwEqjd1Sg==
X-Proofpoint-ORIG-GUID: 6vrAHQSkm31XSc5tKBORzmiTsf5kr5l4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190108

Hi Praveen, one question below.

On 5/18/2026 10:30 PM, Praveen Talari wrote:
> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
> These trace events enable runtime debugging and performance analysis
> of SPI operations.
> 
> The trace events capture SPI clock configuration, setup parameters,
> transfer details, interrupt status.
Don't you need trace logs around PM operations ? ie. runtime and system PM ?
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]
