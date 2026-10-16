Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59493468C2E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145962; cv=none; b=ONDMhe6YejDepzu+XVEXo+6xrK/boeGk2CaOtjFBqdgJ8uzixBNUYiZANAUwNVvRj4/9t/2o9C3UNGIyzCOcihNvxfnn8WiUkLrZkDXhx4q7w2q+WPMQwQS/k+C9lS3cM9wXmw3HsNgWyow0ZMOfLGG6100woth209BeWPKjYzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145962; c=relaxed/simple;
	bh=U9CRgRoLAmtk8E/dKxBycedliKECA2YqR+zLevH5pAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlH5WoZr4yentVje8uD/p2x17+c4WEMEKkPfzQ+E6jW7ye11TA57WK3Z5g7oKw0pucfF0YN1Ts7MsQmt+h06Efi5Jhqy/sx2tN7rn3Xuykuxt9wrsxAhRfEtQxPmrmlXTJ1N5Cd+NNv4/1q3/Twvy7Eeva+c5vuCV5sdtUkm3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tef+K4uB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/ql6neh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tef+K4uB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O/ql6neh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAA3v7942684
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 10:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GfCSAHxVxuL86t7uTRtCzziP8qEv+SHBLAo353w4f4=; b=Tef+K4uBkMBRv2OZ
	ZIiOtdCer65op6N/K79bjlIrA6CtrrEUEc9LXhP3QuzAnXN6uPRBFatwBZ+06z99
	1RhnVbmlxCd8x2teNLgAvv8nkog8QWwstqvaJ55Q6tCRXxpkHod0vYXZ5dxR2caz
	XnnmoeDEQbzukohzCJCp7iIGoqyMEmK7lBU7GS2/PkvpQsOQOSWbZlEu6u8oFZ9c
	q05GQIn31gG7eA1w/l5dBMG2ybl/sBk33R0qkTD8k/qct+qRSwOGmK5+61+TK3DJ
	L0y7dBIVNZBoU40FF3S8SUh1ClSHnIFIxSUkRDMuDqdlg28GLIuOSCvGDMbUS1VZ
	gwbkgg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur01um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 10:19:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so7840264eec.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792145959; x=1792750759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GfCSAHxVxuL86t7uTRtCzziP8qEv+SHBLAo353w4f4=;
        b=O/ql6nehyblNwZf3TUQrlbHI5yUDKLSSGj3vbL0j3dev+zwwZGwE9UOVXw8PsMp9U7
         /Iil+1Fm/zqhz1Q/cPIWO3mS0J+4bW7A3ijNdS/qZNSyGImted/FMGX9R5hDfXOX1OMj
         nV6twp6ptO8l/JPBJmqSCKPMsQASlPWvpvP6U1846GRw1zYB8MgeB1jV2PRMG6Iybct7
         qCt7ev78C4AW7qfE3TFE57GRHEprvKrzozmG/rZnekKxpfb+BpaGXZy+2DYmhhQFYbxh
         1zZBYQichv+keJH1iuJBNrdRZxEOrgtJhPbvXneigi9ccxjcbYWwZIZnhJgtszYR5SQU
         I2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145959; x=1792750759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/GfCSAHxVxuL86t7uTRtCzziP8qEv+SHBLAo353w4f4=;
        b=W0gxV5/OHp25cSKcaBaLskuO6wmDoxFdfnUCwL0XokBdV0Ulbnjhy8oWVzqauHUXBv
         kf1tbQIvIuDdSVhYFTZ2h6+8Zi/QUa22KYLqzt800Dj4ee+gtWn+CyU+yT98JbLPMCPR
         F1/4XSD0xCPj3mN+by4w20MzX4fnjPOIje4V/E7JdhARMbtiErPvusnxiC5Na4HsxcAd
         gRDWXX4T4Qx2Jw4w7KUYmW3rBJ8B2PTdB4fCCC6xAPMNhXGDGFthLUtX5IUWuClYC2tc
         m2Z61KtEXohZOOc++X20JKbSndeTijuBf870/o5oeCE57N33hu6bDchg80A98TBpbeah
         Gzvg==
X-Forwarded-Encrypted: i=1; AKwUvBx4lncCDbJMb9uAtP0TflGrRxm4jW9Cla/F6wkRc5iDLr6fG3FKDD746Yi2lkPFjvhQNftz9K/G6WkTb1Oc6tLiOYc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtdXlmT8h9W9G3Ys+yLohnDta67frwZUrcnjEgYzz7OM6JmscE
	a5Ta7R8/uaAY+BMygDP5neubwUs2sEvrNz+Il5NDuNQ5+J0hwdz7agXfeZ0koKG/oX1Ihfolw/b
	VKA4ym4/0sdsLuy0phIKm7XlguKtivy+MXCdY8ViepagJ//XVlxh+MBl1Fp2cj5elas3+IkbDhF
	Q=
X-Gm-Gg: AYBFou1BCo/oKh40MZobTAImK06SB4VJqAsD3NxXcSGPWeO7Nq44YZurMUCGZGwe0HR
	A96JoN8TmobJ8YHqEvAu2gU8hHWBwKsO6mGbS59BMaHUYKIciJGA2FEcE++Wy2FttrT6e4oGE5X
	8Bxu2AXIHF4VMi9wPipt+AQ9mghse7E7my/ZvwRzeA2jGbANKJ8E+r88BkHNeZCh9WV43LcoU9o
	uLZbaFiSC4XIuWyYBH09PgwNTGr8B4Nku+zXpKCe5xtnJs+8hLMFT/6zPUXd+G+NYUWMM/sum3g
	q4GHiGMxR2nw76psyNYJ8VSxrRadWptgvdWbye7UzsN8JbQUIkSvjeo0QjCl4MBOjVG4TXVXGmI
	+oVC6UV3qz1WsdW+rfmHR2zFwbNWrLIo=
X-Received: by 2002:a05:693c:2a13:b0:35f:a2ad:603 with SMTP id 5a478bee46e88-35fa2ad06cbmr4910711eec.16.1792145958988;
        Fri, 16 Oct 2026 03:19:18 -0700 (PDT)
X-Received: by 2002:a05:693c:2a13:b0:35f:a2ad:603 with SMTP id 5a478bee46e88-35fa2ad06cbmr4910675eec.16.1792145958247;
        Fri, 16 Oct 2026 03:19:18 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm10937298eec.24.2026.10.16.03.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:19:17 -0700 (PDT)
Message-ID: <7337fb06-0953-42f6-acdf-ccd29549fd8b@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:49:14 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
To: Frank Li <Frank.li@oss.nxp.com>, sashiko-reviews@lists.linux.dev
Cc: dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
 <20260926-add-trace-support-gpio-v3-2-8572bf7456b2@oss.qualcomm.com>
 <20260925210244.D6D5F1F000FF@smtp.kernel.org>
 <as6nEloHzo_YkEW9@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <as6nEloHzo_YkEW9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MCBTYWx0ZWRfX91I0Yd68zOOF
 H+F+7B8AjvmGBoYjWdrZPH+1d0gy6LM5I4KfWXAkOQNSWcJAzFNVGXaT4kfVoHmYYGKr2eYQ5Oo
 CAMatHL83asWvfKHwiSdabF6FtcUaTN8I/9IpJKxs62a0K1pT6bbpE5Gc7tTYqDTuChErMNmLKN
 PuM91Y7qnrQTMb9lXzET9pCHJjIfSTqLD9PKCd7BtcKtBem9xDwSSRj+yx9tRnC4Q1ox+IcRVdb
 2H3b82YZxvyiTQMwpWbQYRfiSj9RYuwLElSWBLA4p+DWFmq2S2lPD39acGlb2IKtW74smO3z4H3
 GA141Kq0ElOtnboO3shYWcfhIUPcLjMLjV+Z8hq1+lSUdDN+lGIa2qO05pc9x+5JNfJ58vkcNVO
 TAbcesLT4m4wVCbscjo8SBSq/dTmq12V7BjgxDF2xa/qgmVdg8McxFl5SkCuf7MdafTNAYnJOJB
 R5au0HqkTXV+6oQuQ9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MCBTYWx0ZWRfX2RmQQdSw1dF7
 NLovgaNEfMpwoKpNe+3tbxI6ireC2xYj57Z5g2BCvztOI6RKmBM1hKmSY2NnJad0TGUJqCqIV1X
 gWMET7beuLtSeHsHjA5vVuiHGrdEBvc=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad1fa28 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=0yzcsfwEXPjLm50L98AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 8g6hwpO9jOKOoft6et7uyNQfGLzCq-8n
X-Proofpoint-GUID: 8g6hwpO9jOKOoft6et7uyNQfGLzCq-8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1011 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160040

Hi Frank Li

On 14-10-2026 03:18, Frank Li wrote:
> On Fri, Sep 25, 2026 at 09:02:44PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] dmaengine: qcom: gpi: unused variable gpi_ev_state_str causes compiler warning
>> --
>>
>> commit 16ff3240f7873902688743d98570cd5eebf13594
>> Author: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>
>> dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints
>>
>> This commit replaces dev_dbg() based debug logging in the GPI DMA driver
>> with tracepoints, providing structured runtime visibility.
>>
>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>> index fafe6ac848d94..6aff2a0d54161 100644
>>> --- a/drivers/dma/qcom/gpi.c
>>> +++ b/drivers/dma/qcom/gpi.c
>> [ ... ]
>>> @@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>>>   				ev_state = DEFAULT_EV_CH_STATE;
>>>
>>>   			gpii->ev_state = ev_state;
>>> -			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
>>> -				TO_GPI_EV_STATE_STR(gpii->ev_state));
>>> +			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
>>> +					      gpii->ev_state);
>> [Severity: Low]
>> Is it possible that this change in gpi_handle_irq() within
>> drivers/dma/qcom/gpi.c leaves the gpi_ev_state_str static array and
>> TO_GPI_EV_STATE_STR macro as orphaned dead code?
>>
>> Since trace_gpi_ev_ctrl_irq() only takes the integer value, the final
>> consumer of the macro is removed. Could this regression trigger a
>> -Wunused-variable compiler warning for the unreferenced static array
>> when compiling the driver with standard kernel warning flags enabled?
>>
>> For reference, the array is defined earlier in the file as:
>>
>> static const char *const gpi_ev_state_str[MAX_EV_STATES] = {
>> 	[EV_STATE_NOT_ALLOCATED] = "NOT ALLOCATED",
>> 	[EV_STATE_ALLOCATED] = "ALLOCATED",
>> };
> Please Remove dead code also.

Thanks for pointing this out. I can reuse gpi_ev_state_str in the trace 
output instead of removing it. I’ll update the patch accordingly.

Thanks,

Praveen Talari

>
> Frank
>
>> #define TO_GPI_EV_STATE_STR(_state) (((_state) >= MAX_EV_STATES) ? \
>> 				    "INVALID" : gpi_ev_state_str[(_state)])
>>
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com?part=2
