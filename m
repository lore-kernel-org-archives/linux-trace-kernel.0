Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA06369985
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111866; cv=none; b=o94SP5xpLF+ORtQJTi10G3M4JsF/XGv0tXSRFTukIC+6UnGx3dftSBpKBwga1Ntzv9HdAuL1b8gvr9eDb6Kf3adfz61p8dlYSS0QIKhEgmXy6TkLsEpNRsdaVPgLpJo33s+yyP0o6866ca69TJlof5ZuEy2xb9Dez3EzpQ8Es4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111866; c=relaxed/simple;
	bh=PZPkxgLVIgWDKULzLbz5EJ0WQuzhJ45VhRLCp03T/6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbP9/2HWJRqNe68gm0piz886MCVg8x2WOVGq4aThXgOh4eJGtvle4dcEawvZ3kvw7DwOmjpZF04AIFkWKLHKtkR6TtI7Ql9fMfncR5/iabL7IwRdq/plhIEPtBBgaj8IUtJBeNQPEVDOtE75V8WYMSV8Bp7AuH1+FSCc6iI7RdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2oPZ/Fh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TLul7rXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2oPZ/Fh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TLul7rXC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDYv0A2891952
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=; b=F2oPZ/FhxboVPYnJ
	AJxzVvbyyYbe3l5niKcNWMX3PbhXPKr5LR93SX2DFD9cwX2JvGFjTalxBsvSo/31
	JqM9sbYxChTNVByW5+k/u4EJfkEIAZJXxX+2awIX07zPJIRctECGVI+4vh8J2apg
	f899byuYdo97vX3+lxcJNbh43rLRW250tg5RBIDnNc3pRF2jytL9tnn/ZkYVl1B4
	V6hyOG8aEmnqcAESNt927tvwRw6pUfMDyioPr8BwrhbNFFi3PF/5L8YGvjiufP7Y
	zQJ8Ms7tlgqI3IKMTB+2YiL77PpjeAgy5Ad1N3RHZ5at0nAre5eI5w6o9XeXhfTn
	rhYwpg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk19f8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:44:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514b5cc5cd2so8401341cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779111862; x=1779716662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=;
        b=TLul7rXCrNURNdq15UMrA2vMuyBKtlhr+3JQ1TMFTmJup6OggPl0f9TSTB2VlGTm/i
         RWE03VOCEP5zMCYcZ1sD+GS8t5fG3yui7Q5DBsLR5o+LKCgRzg/v94R3LTGDW0dpT/Un
         6F2lQbg1HKTomswZ8BZcvqcGiVG/9qcGGHGbGY/lQFYe7evjymuST6UpAu1UHALpVsRo
         ZsajuvOYg5fz/1Tdf507zcebJ0yYbRrWOeFXBf3O6gU4nGL+rx822JCkS2Qi+7uYGAfq
         k/sFypOs8r3HB1gDVFmHY4fLcyEVuoAv1pUsIeydhZEr/8z7P/MMF4g9ZzNU+MoMV8f4
         Nccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111862; x=1779716662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMLAnLOji9kv4nRsZe1IlIymkTyn1nxERx4sdod9gaE=;
        b=Bsg+5lHPtH8ugItisU3aGnbI2dhFoPFuCMbAGkphRuaszdvVX0YZrH9gEjIzLF2uaV
         Ph4GXm31CB25/QyuMNQganyG4oyFE1rjKJP+rsaUzo33gJKRc/avlGbq5SCEDAol00nX
         OFQRVWD+5trvvVkQr/pjDE4fX522OE+tfQ97LY/66Df0g0Y0tOjs9UokV27yAMKZfi2Z
         gQ3+7I8jZPgeUpBD/BCTGnxF4WIipBEQAWQPcdouEh4BjivppQIQ+q1wbXyF3od+QA4s
         Ij0A44IV9+E3B7zjE6dUk9VLowwLZY/cJvNba5jyrdhLdRQiVy1aOoq7lbjXXSLaDV62
         /Cwg==
X-Forwarded-Encrypted: i=1; AFNElJ8NbBDeqnkWjOYra+1QpZGse5t7ilRbJ/LDUlp5jlVYF0yckNc5c16lVG9VuGHE201HfEjbNnxZtAb8XuaKqGBn/Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqs254mB8d2UcnXLLlBHb5U4mpSzoL35GTImVNP9i7TgIWuNo4
	ilb8AOTC9OTMe5ic685QjbSvsWaxUmpvxy5oParxVnYBP5pk1O5tOmKK1xdP3uGfJgNFM4XWe76
	GFUyZFAyZ8A/2qGivLVoG4dAs3DO2GQWYb6MmcM9n7p+V5qlpD8fkI5AVxF4LheamGyGEtlMPnA
	o=
X-Gm-Gg: Acq92OEvG/YFFGLWlPLBxfEdQJwswJlJ1NfVolaJCVCh11gKjzzG0UNxmXrA8EYU/O3
	oCzUUkgSLkUp3R8iHla8ZelPKDLsc0qLQRocxScQFXpDUob4QzoTR6f2fI5Z1dP+i4HR2N8vSh0
	YOU4sO53ZQ9XJJC1P1FK/cwOxaEHOJc5b/z3ZcvAYnBV+JSh9auUCd6HWcoMQI/EMuLUVEzCB/y
	Fg+6/t8jUsKgwKmiIJ48W/IPKm7jx6QPCgkGhrLIN/B3KLzkQ/5XFj2D5sqmT6pL6FN1EEw0EWl
	LVfIYdeLvZAmxOizJUcio/okdwpjhIioBg9KkVpptDLnciycX3vHVzGOGxMeZreWTu6lnIsNH/N
	hcG0onb8F0/ONE81ZvZNHbVWWuy/34mKNAi0JxnppNH5Ba/Mb+mnWHB8Xc2nTByKiYi8G5lytlP
	fw298=
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr138119221cf.3.1779111861639;
        Mon, 18 May 2026 06:44:21 -0700 (PDT)
X-Received: by 2002:a05:622a:155:b0:50d:a92e:fead with SMTP id d75a77b69052e-5165a0c1de4mr138118961cf.3.1779111861040;
        Mon, 18 May 2026 06:44:21 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c313f7sm574499666b.21.2026.05.18.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:44:20 -0700 (PDT)
Message-ID: <5dff16c8-5e30-40f5-98b9-c6b423013448@oss.qualcomm.com>
Date: Mon, 18 May 2026 15:44:17 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
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
 <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-spi-v2-1-3b184068ecf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kQokggdDxr5rl8hZ6CLsVT9RpBRib7nA
X-Proofpoint-ORIG-GUID: kQokggdDxr5rl8hZ6CLsVT9RpBRib7nA
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0b17b6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rSx38Zwr_KSaChy-qZsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX7kakwBUtFiWI
 4tCEE2gZUSLfHP1+XdurDrU/fWkudnW26/vKVtBlpYf26LtbuancCfxn1tBnYsjLCHerFSklQca
 ogEeYne3EtEZEugYaZ9vCFPmO4HEIJ83kx8TMn3Gl38jOlNzjOIZZFUIjs1AFOB4yzEdp+GO+Pv
 D0DvATpgJVt+XbEm3ErftXkS5N0Ce8Twyf2A2HJe67GvnrMX5uS5HYkvowv/0YDWcokzBlOjo1y
 +DBgJn9jL/Ilio4pGUiVSh3DvF9dXB4tCAgtED17i+Ojj+5LZu0W3kpWuOYVUfhbRnBmzolbTCC
 6trNZ3zfdNZrMMuInpEmG1owASG81XLFWtrSWiiID9Yxw8MwCJ13aFMPDHh9KDge5IGEGNUeisA
 7fsporyF5/RGew4A+En2CVuxlECsi2o6wL+uNc1lU+gsfJ8fKZwiyImfjxd/SnyStZwW7qfFTg9
 xUYoqQpP21a1SuR6dUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

On 5/12/26 8:12 AM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI SPI driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover clock and FIFO parameter configuration,
> transfer metadata, interrupt status to be making it easier to diagnose
> communication issues in the field..
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> - Removed TX/RX data tracepoints.
> - Updated commit text.
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
