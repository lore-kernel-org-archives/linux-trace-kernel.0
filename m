Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF359472094
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345457; cv=none; b=hD+pTLd73I1TJM4k5B2UY+kZdWzj4Cp94tgeZyPDtojdklxC20WSpEMwevlC/SkHeALnsJATxM0xC7x9zIiL7OlvWeNUgvuwPoz74zqmebSzDX1a0fbMFAqAw04pOSw4QORkv0UH2X9K+MBVUvobDELXM0hY1wWEmo6eTFu86cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345457; c=relaxed/simple;
	bh=itBJES60RMp9qTnVjDVU6fwJJ9IUAne92eVMwTA1po8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIpTMhfnQrYkdBOy8q+JuOnayPDTM2CUq8qzBbQkwHDHPsV9EVNAWY83PX6kBytW1zmxtWEKgJtLWHvYrhzQ40SI/sxjqlV2WjzH8/B1D6AGsHroHQyVuBZmXUQ04y0ATcNSQUR31y7r4/nuN8OIynvJqOiY2Nk7NUw5+BQLrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QUvINafy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drfeb5lj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QUvINafy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drfeb5lj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDb4eN3627541
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgVIs0/RJKVOv08WQ9oErS5WnuLl2yv8yGRz8Gn+/YU=; b=QUvINafySfh61Y8i
	7iSJlG09r1YiPJh5vYN0UW6hlCgKoi6OY2OjlG1hljwqWZGG4GWBwjAeYN3DPy5s
	lHARp35SoiNH7N2hO9iHKmbjsD0dfkJNKoDoOFKirtrFqfvT314PGcpyPRNqDgc1
	nqA7f5Onz9nnZN5jxIV0hTtAeECKy7Jv7IXOOuBuqNsIYi+iq2HgO2OfWb+DljyK
	Z6KsFRzsGMEZgsZXWvsK05Pcc065ZQn7BLEiO0jQsEAZwu5HxcHm+344HUtenst2
	ycl4WYd1MM4lI6YjaBtJmIFlwX5ZxXbF3nUIEC0MSduGhfwLyOWCJw0bOEqMW5pa
	oPI9pA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq39nxw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so1942404a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790345454; x=1790950254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgVIs0/RJKVOv08WQ9oErS5WnuLl2yv8yGRz8Gn+/YU=;
        b=drfeb5ljfuGrZdxvG64a95wyY0GRl7CG6/pYHWeViPEdBLDxHT14D/V5gRdOesY1qX
         D62+cW8ibaqmu1slpLYqXQ6oBf0G432umKYWelrTUc2fA3yl0Bit6X94V4ByeAMIpeyb
         OlNcqnV99WxGBl1vUk46sNxuQzQscmLceIoSrkDzmYng8qAcCIPLjZr/7FVlc9dty+3v
         2F40sWrXfTClbPzVood7nID3RLBEEAHONotRSMfOnUErHP/F70M8KGDHKvOtC74w7+I5
         Aeyn2B8VJg3RHa7pkc6RnY8Sdqj19F/HVpGAE+23auNSsrSZvsUnzZToquRoRl/MVsVJ
         Bs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345454; x=1790950254;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgVIs0/RJKVOv08WQ9oErS5WnuLl2yv8yGRz8Gn+/YU=;
        b=Ghr/43k8zRFzXCBOKiqEhOjiCdvAgwx2qVc4gb1vDBmfP63/r6YKIWy/BtwTpjspnS
         olDOPyNQVP68nzWBdIrByxS049wG2F/J//AlFZea6I3K4niXhEhumElgfPtkblfuxSv8
         tZGXH/RdMWn7FbhBFrnvA4efG6FUvuCREkGm76f1LjTZo++GIfmu9DAYGXDT/YvHl6BF
         gN0pEfvM/f0ceqkZM3ymJxd8SZV4ciw8DxTZPSyE9jloF31idIG+sfyxFnOJxOQu4L2G
         pWskw9Ry20llNpgdXWklOdPSr2X+0vkpUjoeQ28bKBU/6vXyb6d7SWWoM8LytZ64905c
         +i2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxoygIXbo0LuoixkaJs+l1KYTQEUzuvx1CUu7QznJwIlrcXuw1mS/dDpUlwlT9DEOgGpBoR2BMfgxMDXxPFmmxRVSs=@vger.kernel.org
X-Gm-Message-State: AFuF++kpLE9H1FHcq0jneVokIYR7Me3aHpSzydOOoWyyJgEbFqZOQX3/
	5MuDexE75GG1qAsskIK8Apj4cYxuczG41Gc/Blcg6PAKPvtiqrH1nnjSyYzagGBoOwCERDvfYNf
	eXmoyUIa+opkOSef8Oi1Jh1UAt+gjYY+q7yPsgzlarOKyF9lw4jsj8HJSl5bKxSh4f8l8XWB8Af
	8=
X-Gm-Gg: AYBFou2CHsOD5f/Kyz245LB4hwXIzjR9unWMs7WpjtYda5GueD3TQmrd36GU6KzsYwh
	XJEjcSU5Rjy2edpI77uzdlT9l8c4IeCLicjReg5M26N9cgyrRFajegSOdLR/PPalSJkDnHHVSf9
	MVKT1K+35wLcFj/SjJr4YXQknHMMQPgoFqQDwfAXv9iKKuUufj+USOZZgBkqNWDu9SPtXn1Pc/6
	dKUaJT4SvxrvrZTClKQDBd8Iqv8xWiX66EKfTQSaJ2mHqNpL1XIXlV5IkjMc8kFQoJSV6yVoVIF
	g9tzuZcwOO0ZBWQhyrBoAwxsVYNoe2YAd8Spn+QcvislW7Vlw6bdDOXCBbyvPqXRrzG7Pppubn2
	Q8tiBWPZupHmZqLT2JFkxuQwL6Zxj0D0=
X-Received: by 2002:a17:90a:d40b:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-3a0bb573f4amr2062386a91.15.1790345453379;
        Fri, 25 Sep 2026 07:10:53 -0700 (PDT)
X-Received: by 2002:a17:90a:d40b:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-3a0bb573f4amr2062342a91.15.1790345452588;
        Fri, 25 Sep 2026 07:10:52 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.107.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91461d38sm11277345ad.76.2026.09.25.07.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 07:10:51 -0700 (PDT)
Message-ID: <b2befdae-09b6-4ffe-aa67-05d6172f4823@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 19:40:46 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
To: Frank Li <Frank.li@oss.nxp.com>
Cc: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
 <aqHIiBMVmuBKx6lM@SMW015318>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aqHIiBMVmuBKx6lM@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfX/Xv4P58xWgPQ
 VL9cPqvYKukO3gwOW0XiqncSiAMusY5k2JrqsdCuGRq1ijCKeJVBy2jAR1P2Xplt/sQ8x5yl8z+
 gegRykvpMNSlTBIq7Oe5iRnTaATRVLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfXzkBg1SCW7kSE
 rbqcKfkw5p3ua3wrVc/EshW2OYFe9qM5Oq+qxnRuUEndNN5AEQf2WcIheUHRHee9zK/nKKhkKVa
 rysgDHoBZLEr1QbLt39/gj4dTB0KVgJz9lEGkQp+XS4NFeIB276veLTj+0xtyP+ghWJZFB5YLA4
 71v0XaJddYT1OzBL/VG1+tEcBPP7OPoTzoW2qMB4Iufp2KfNnmuimEF8Yg/y2roSiKsXl0FJDyi
 Htl0K36KeKy6Vyc9vmlsyCDwHxf/yGV+zo5EmoZ2Wv3xuFf2QL77y9Nuk+qTP0OebjH7IZQiR47
 BgBtkEu7N8a7hrIjs50onuBYeAPnWvTzPUrRacFJCetiVTZZqwy/pSbpsh/D4AJGW5PYgM3kWsz
 ybkeClegwJHdTHTX/05YynaK4C5qwZXp03jw0dS3ZOOM2+82+atcP7rVYmLERefUJJpcpXlZUtH
 S5zwxT8d1oVRvyJfmEg==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab680ee cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=LbQqD9KVPf5lhnc1gAYl9w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=d3xK7mIYCK7McAmqHKAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: uyG-vFjmsRgK1xrALmlKPDfnfCExUE-e
X-Proofpoint-ORIG-GUID: uyG-vFjmsRgK1xrALmlKPDfnfCExUE-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250056

Hi

On 10-09-2026 02:28, Frank Li wrote:
> On Wed, Sep 09, 2026 at 10:39:43AM +0530, Praveen Talari wrote:
>> Replace the remaining dev_dbg() based debug logging in the GPI DMA
>> driver with the qcom_gpi tracepoints, providing structured runtime
>> visibility into GPI DMA behavior without requiring invasive debug
>> patches. dev_err() calls are left untouched.
>>
>> Tracepoints are added at the same points as the dev_dbg() calls they
>> replace: channel/event command dispatch in gpi_send_cmd(), error and
>> top-level interrupt status in gpi_process_gen_err_irq() and
>> gpi_handle_irq(), event/channel control state transitions in the IRQ
>> handler and gpi_process_ch_ctrl_irq(), completion event handling
>> (including the no-pending-descriptor and transfer result paths) in
>> gpi_process_imed_data_event(), gpi_process_xfer_compl_event() and
>> gpi_process_events(), ring allocation details in gpi_alloc_ring(),
>> already-in-state checks in gpi_pause()/gpi_resume(), TRE contents in
>> gpi_create_i2c_tre()/gpi_create_spi_tre(), and TRE queuing in
>> gpi_issue_pending().
> needn't this paragraph. The first paragraph is clear enough.

Sure, will update in next patch.

Thanks,

Praveen

>
> Frank
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/dma/qcom/gpi.c | 58 ++++++++++++++------------------------------------
>>   1 file changed, 16 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index b09354a73b46..8e7d25a46147 100644
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -684,8 +684,6 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
>>   	if (IS_CHAN_CMD(gpi_cmd))
>>   		chid = gchan->chid;
>>
>> -	dev_dbg(gpii->gpi_dev->dev,
>> -		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
>>   	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
>>
>>   	/* send opcode and wait for completion */
>> @@ -797,7 +795,7 @@ static void gpi_process_gen_err_irq(struct gpii *gpii)
>>   	u32 irq_stts = gpi_read_reg(gpii, gpii->regs + offset);
>>
>>   	/* clear the status */
>> -	dev_dbg(gpii->gpi_dev->dev, "irq_stts:0x%x\n", irq_stts);
>> +	trace_gpi_gen_err_irq(gpii->gpi_dev->dev, gpii_id, irq_stts);
>>
>>   	/* Clear the register */
>>   	offset = GPII_n_CNTXT_GPII_IRQ_CLR_OFFS(gpii_id);
>> @@ -866,8 +864,6 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>>   			u32 ev_state;
>>   			u32 ev_ch_irq;
>>
>> -			dev_dbg(gpii->gpi_dev->dev,
>> -				"processing EV CTRL interrupt\n");
>>   			offset = GPII_n_CNTXT_SRC_EV_CH_IRQ_OFFS(gpii_id);
>>   			ev_ch_irq = gpi_read_reg(gpii, gpii->regs + offset);
>>
>> @@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>>   				ev_state = DEFAULT_EV_CH_STATE;
>>
>>   			gpii->ev_state = ev_state;
>> -			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
>> -				TO_GPI_EV_STATE_STR(gpii->ev_state));
>> +			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
>> +					      gpii->ev_state);
>>   			complete_all(&gpii->cmd_completion);
>>   			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_EV_CTRL);
>>   		}
>>
>>   		/* channel control irq */
>>   		if (type & GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL) {
>> -			dev_dbg(gpii->gpi_dev->dev, "process CH CTRL interrupts\n");
>>   			gpi_process_ch_ctrl_irq(gpii);
>>   			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL);
>>   		}
>> @@ -945,17 +940,10 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
>>   		struct gpi_tre *gpi_tre;
>>
>>   		spin_unlock_irqrestore(&gchan->vc.lock, flags);
>> -		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
>>   		gpi_ere = (struct gpi_ere *)imed_event;
>> -		dev_dbg(gpii->gpi_dev->dev,
>> -			"Event: %08x %08x %08x %08x\n",
>> -			gpi_ere->dword[0], gpi_ere->dword[1],
>> -			gpi_ere->dword[2], gpi_ere->dword[3]);
>>   		gpi_tre = tre;
>> -		dev_dbg(gpii->gpi_dev->dev,
>> -			"Pending TRE: %08x %08x %08x %08x\n",
>> -			gpi_tre->dword[0], gpi_tre->dword[1],
>> -			gpi_tre->dword[2], gpi_tre->dword[3]);
>> +		trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
>> +				     gpi_ere->dword, gpi_tre->dword);
>>   		return;
>>   	}
>>   	gpi_desc = to_gpi_desc(vd);
>> @@ -1064,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
>>   		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
>>   		result.result = DMA_TRANS_ABORTED;
>>   	} else {
>> -		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
>>   		result.result = DMA_TRANS_NOERROR;
>>   	}
>>   	result.residue = gpi_desc->len - compl_event->length;
>> -	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
>> +	trace_gpi_xfer_result(gpii->gpi_dev->dev, chid, result.result, result.residue);
>>
>>   	dma_cookie_complete(&vd->tx);
>>   	dmaengine_desc_get_callback_invoke(&vd->tx, &result);
>> @@ -1100,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
>>   			chid = gpi_event->xfer_compl_event.chid;
>>   			type = gpi_event->xfer_compl_event.type;
>>
>> -			dev_dbg(gpii->gpi_dev->dev,
>> -				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
>> -				chid, type, gpi_event->gpi_ere.dword[0],
>> -				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
>> -				gpi_event->gpi_ere.dword[3]);
>> +			trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
>> +						gpi_event->gpi_ere.dword);
>>
>>   			switch (type) {
>>   			case XFER_COMPLETE_EV_TYPE:
>> @@ -1113,7 +1097,6 @@ static void gpi_process_events(struct gpii *gpii)
>>   							     &gpi_event->xfer_compl_event);
>>   				break;
>>   			case STALE_EV_TYPE:
>> -				dev_dbg(gpii->gpi_dev->dev, "stale event, not processing\n");
>>   				break;
>>   			case IMMEDIATE_DATA_EV_TYPE:
>>   				gchan = &gpii->gchan[chid];
>> @@ -1121,11 +1104,8 @@ static void gpi_process_events(struct gpii *gpii)
>>   							    &gpi_event->immediate_data_event);
>>   				break;
>>   			case QUP_NOTIF_EV_TYPE:
>> -				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
>>   				break;
>>   			default:
>> -				dev_dbg(gpii->gpi_dev->dev,
>> -					"not supported event type:0x%x\n", type);
>>   			}
>>   			gpi_ring_recycle_ev_element(ev_ring);
>>   		}
>> @@ -1409,10 +1389,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
>>   		bit++;
>>   	len = 1 << bit;
>>   	ring->alloc_size = (len + (len - 1));
>> -	dev_dbg(gpii->gpi_dev->dev,
>> -		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%zu\n",
>> -		  elements, el_size, (elements * el_size), len,
>> -		  ring->alloc_size);
>> +	trace_gpi_alloc_ring(gpii->gpi_dev->dev, elements, el_size,
>> +			     (elements * el_size), len, ring->alloc_size);
>>
>>   	ring->pre_aligned = dma_alloc_coherent(gpii->gpi_dev->dev,
>>   					       ring->alloc_size,
>> @@ -1437,10 +1415,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
>>   	/* update to other cores */
>>   	smp_wmb();
>>
>> -	dev_dbg(gpii->gpi_dev->dev,
>> -		"phy_pre:%pad phy_alig:%pa len:%u el_size:%u elements:%u\n",
>> -		&ring->dma_handle, &ring->phys_addr, ring->len,
>> -		ring->el_size, ring->elements);
>> +	trace_gpi_ring_info(gpii->gpi_dev->dev, ring->dma_handle, ring->phys_addr,
>> +			    ring->len, ring->el_size, ring->elements);
>>
>>   	return 0;
>>   }
>> @@ -1542,7 +1518,7 @@ static int gpi_pause(struct dma_chan *chan)
>>   	 * client needs to call pause only once
>>   	 */
>>   	if (gpii->pm_state == PAUSE_STATE) {
>> -		dev_dbg(gpii->gpi_dev->dev, "channel is already paused\n");
>> +		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
>>   		mutex_unlock(&gpii->ctrl_lock);
>>   		return 0;
>>   	}
>> @@ -1578,7 +1554,7 @@ static int gpi_resume(struct dma_chan *chan)
>>
>>   	mutex_lock(&gpii->ctrl_lock);
>>   	if (gpii->pm_state == ACTIVE_STATE) {
>> -		dev_dbg(gpii->gpi_dev->dev, "channel is already active\n");
>> +		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
>>   		mutex_unlock(&gpii->ctrl_lock);
>>   		return 0;
>>   	}
>> @@ -1703,8 +1679,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
>>   	}
>>
>>   	for (i = 0; i < tre_idx; i++)
>> -		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>> -			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
>> +		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
>>
>>   	return tre_idx;
>>   }
>> @@ -1797,8 +1772,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>   					 TRE_FLAGS_IEOT);
>>
>>   	for (i = 0; i < tre_idx; i++)
>> -		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>> -			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
>> +		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
>>
>>   	return tre_idx;
>>   }
>>
>> --
>> 2.34.1
>>
