Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C536B930
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345414; cv=none; b=NjUVFew93pRVF1mJbFCqSo9KRxJ7Dpg9BrZC5kevTXQqkkshftrg6dGhzM0Zw9qW9I0Hp7OFoIGBnJGCeNtX7TtBxo4hA8M3TfMH075RLH7kbiAUMb2i7iZ/S10C5JLMrq/3NI3xNJ0M+WFwNimQ0YUcOT/YVbg7ryIcd8/Kyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345414; c=relaxed/simple;
	bh=MaqbqWc2/dFkqoXAaoGX/GjWl4wzzfu9GUD+ZiHRzEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj3Q3j/ks+t/5ZnRYUav/WZAnEf039sux8Kkr231ddisXxCJZ/kI0fn7C+p0Xi8oWWSeRTBqG/p6sdA84vPRScf+ZhTdX/qLbIAUkgbjPq0jlXJqU6GQ1eXSTXIlYFnYpOknYugU/B+mwhfTompZDLMW6zeb37SZPL2axvFRPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kcW744Pl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BW4fZdsD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kcW744Pl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BW4fZdsD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PE2NI23628196
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H/EQVVKLz9a3Hib3j2NdYC7VuMgC/jlWCcU786W+/ts=; b=kcW744PldxktVsEr
	tWdN352+Mos0thb7P7hASOQNLDOmni5xagL4mDoMlY7N/J8Ax2TqM6O23tIuzF2L
	DFR7t1l6YXkeE+If6dhXErKFXbpuLl97NeA8XxbTe05oKZx8mesPj9qOnhCKWADp
	RNwFX8QRsY7YrfeGdb0oS1uVu7skN0Zmnr2Qnd6NITXejrJaYRYlasHAV4uPJpd6
	1NYdoFlPlJL5YdC+KNdrrj+jYA6SCqimI4GEMVRXMsSXwkm/ViAw6j69vgIRtZD+
	WsnGh4Mp+WkPqu3ob9Ejyg8ACLTNcJ5nkt7aXObzoDyqQkEHEXpp5VuKmPWl0W2o
	4CsunQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq39nuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:10:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so572774a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790345410; x=1790950210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/EQVVKLz9a3Hib3j2NdYC7VuMgC/jlWCcU786W+/ts=;
        b=BW4fZdsDFPEFTbgomRsk/AQF4h7rTpdXyBqXl4lbNGYl0HXoqSUn9N16yHMQsizQEK
         3JhGLzrOFsDaSmMEHyBzFjYLhpR0pgiDLm2loWGix7XOvWudcN9k3hC/1uSliVTVW0zC
         UxFhiXzJKZRUEuQz7Eumql0r7K9sXcLIhgjW0+VMYZ/Ni4M2pUIrmF+gw2TUtDKDO8p/
         kxAZkzB37np/pg0t4RvSt8wHVZ26ZKeiMYFGW1Ibd5jWIYlYrW6ifcSZJCUZNE7Q2BXn
         Qgp5LW6eAOMePxHQTg69H05xWTSnA7fyPSYsblB+Ys9WAynDNRyh7tdKr0noQQtGhHr3
         mMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345410; x=1790950210;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/EQVVKLz9a3Hib3j2NdYC7VuMgC/jlWCcU786W+/ts=;
        b=kZLZagGR1tUpCpc6yhNa4TBBKya3jTprI7N+sehPl8vWQxUlQosvaPn7iLU452Axai
         DWph/+CQ545z/GHmgLGH1CVgwAbo2WibzjlTozIZMGgRsmcPuGC3yAWuyxhT9LDQCWYm
         j+y03s08ZfW4296MRXLMYRz9K0XLIMN/9ehGgoc93jLA7iuvWmaOyxmpLUdX9iq/gJuA
         S9uGZtksbuYL+Ixt2I0RPGAxDSYzi4YKcmeJnEwEniuTl9aNnhlu1i0uT+ndL0FP56By
         n+3n9OIei5oLf15IyP1SqhQE3o5+c1v/TZnqIT99y/x1REsucv+7jbOba7kA1tMzlsd0
         Xjgw==
X-Forwarded-Encrypted: i=1; AKwUvBxQJ0LSQ7cFh1CNT90CDODhDuZEr0cwjSGF+iR6BIcJGq8RAfELT6KmhioFeXr5r9d0NqGxe0rAKEjvYHmUsDOvKzA=@vger.kernel.org
X-Gm-Message-State: AFuF++l6UHACokiIBXO1MhgJ3rhzw4/prlJzi2vyENZvTzvOfqQk+Yr5
	H/1n8mwmB5Jzt3JM19Sf3m6mDGZsJOxhKH1vZEupDAnGH4ikGy9m0eCO28kpxonJSZy2uQXRKBV
	YjxhRW53hyKATDEiuHghOSSSACNeF2RnT8LcPmy7Vb1U6p1il1dkwW4rC6sW/WAld9qvh5zAEcQ
	0=
X-Gm-Gg: AYBFou2aEaE3z/lrVeGu+368iFpujj1UIL1gbATe7V6JE0zGc6icIGnLC1x0we38A37
	4ajI5o+GSw5kZlNvNgmuXxauoJL+6zD6KR0CCqHOO/PFCLlic4pf1mqDlSgOCL4Ub4e/Ac3sNUy
	pPQYBYyx+J9FLuSMD1HMz0AAQIUYCTaFvx+7xTBscX4c/yRyF/MM8kkEzPGIXh38Gxo0epvangW
	AkLN1VvXz3KgUWlto99QfytrLaV/BSEcJ6dufvUF5j4wkC8FBlpFerDDxJxFINvcxlKIvbUGIXR
	If85ysUim7enduy8ZIP2ETOqVP14gKr95iByUOJ2aUpoT6m/UpNqm6nirfpaoiLs7RSkzutjpIk
	+Qrlqbp7+Yp9Q/8UQlhL/L4KM5srKZCI=
X-Received: by 2002:a17:90b:224e:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3a0cbe2a16cmr701474a91.63.1790345410284;
        Fri, 25 Sep 2026 07:10:10 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:3a0:cbe2:9e0c with SMTP id 98e67ed59e1d1-3a0cbe2a16cmr701438a91.63.1790345409560;
        Fri, 25 Sep 2026 07:10:09 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.107.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8ce3f12sm1664008a91.2.2026.09.25.07.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 07:10:08 -0700 (PDT)
Message-ID: <4ec85347-1d84-421b-9a49-1d2fc21a2e36@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 19:40:01 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dmaengine: qcom: gpi: trace: Add trace events
 header for Qualcomm GPI DMA
To: Frank Li <Frank.li@oss.nxp.com>
Cc: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-1-01f81739bb88@oss.qualcomm.com>
 <aqHH8rliEDTmrW9P@SMW015318>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aqHH8rliEDTmrW9P@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfX82NBUNKfROL1
 1W1839R9UeGdXllWj5JQNxJoOWLMFhwWyr3irYnWRcn/T0KtJl429rnM/05950CTTlwrYfHllIi
 rOmw0kVSOX9aSmFZ8dZSPmCpFAvot7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NiBTYWx0ZWRfXyneRQ6mwNYJD
 Guqs2RMyOpcvrs7hS71CYjz/DSCIXc92IbldUBLz3gjXds1ZJ2yo2fNwtU6lWAr46oDld5PbxRQ
 WQwjdwr11+0YaAbIAlYxAQJTklqTOAen7vB7nlLD9f90D8xtSZ+GWB2bfgFDCDXix074+H1FUMk
 nBKrzPWIOJzVzdEo/M+01BqjIRfL57TDTN6Z1nTiPPfy8noyhzycaY+jDP0nsmwWiOvFv2QRjn/
 SXnjWsIGM69QtEP5Tnjq8zxiMAtYRDdDHKMVdtD4xXiMrjYxNYJMX2H+99s8T5yINuQ1w+RdwJz
 Kkof2XrFakRDfYZ4/D3wH5pZT3hIlCNQaLYKDPjG1++9od5r4NbJhkyUWr9/Q9yAsnxJb+0yVJh
 TADVbaEMmvy7YNZvebqCWaCRT4axwnvTEPyTcr1fr6N0Cm2fo4QWaKfZbSpwBLO3SUpAXBAz02K
 CSBgKWfhGZdCfULG7rQ==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab680c3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=LbQqD9KVPf5lhnc1gAYl9w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=9voflSBtY7004n_qTS8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: V3hesMfPspvPOskLbvr9wMZP04TARTw6
X-Proofpoint-ORIG-GUID: V3hesMfPspvPOskLbvr9wMZP04TARTw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250056

HI Frank LI,

Thank you for review.

On 10-09-2026 02:26, Frank Li wrote:
> On Wed, Sep 09, 2026 at 10:39:41AM +0530, Praveen Talari wrote:
>> Add a tracepoint header for the Qualcomm GPI DMA engine driver.
>>
>> The events defined here cover channel/event command dispatch, IRQ
>> type handling, channel/event control state transitions, error IRQ
>> status, completion event processing (including the no-pending-
>> descriptor and transfer result paths), per-event processing in the
>> event ring, ring allocation/programming details, already-in-state
>> checks for pause/resume, and TRE queuing and contents. Together they
>> give full runtime visibility into GPI DMA behavior in place of the
>> driver's former dev_dbg() based debug logging.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   include/trace/events/qcom_gpi.h | 313 ++++++++++++++++++++++++++++++++++++++++
> Any user use it outside drivers/dma? if no, move it in drivers/dma
>
> and please squash to patch 2, with user together.

Sure, will review and update in next patch-set.


Thanks,

Praveen Talari

>
> Frank
>
>>   1 file changed, 313 insertions(+)
>>
>> diff --git a/include/trace/events/qcom_gpi.h b/include/trace/events/qcom_gpi.h
>> new file mode 100644
>> index 000000000000..241d76855ac8
>> --- /dev/null
>> +++ b/include/trace/events/qcom_gpi.h
>> @@ -0,0 +1,313 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM qcom_gpi
>> +
>> +#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_QCOM_GPI_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(gpi_send_cmd,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 cmd, const char *cmd_str),
>> +	    TP_ARGS(dev, chid, cmd, cmd_str),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __string(cmd_str, cmd_str)
>> +			     __field(u32, chid)
>> +			     __field(u32, cmd)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __assign_str(cmd_str);
>> +			   __entry->chid = chid;
>> +			   __entry->cmd = cmd;
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u cmd=%s(%u)",
>> +		      __get_str(name), __entry->chid, __get_str(cmd_str),
>> +		      __entry->cmd)
>> +);
>> +
>> +TRACE_EVENT(gpi_irq_status,
>> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_type),
>> +	    TP_ARGS(dev, gpii_id, irq_type),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, gpii_id)
>> +			     __field(u32, irq_type)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->gpii_id = gpii_id;
>> +			   __entry->irq_type = irq_type;
>> +	    ),
>> +
>> +	    TP_printk("%s: gpii=%u irq_type=0x%08x",
>> +		      __get_str(name), __entry->gpii_id, __entry->irq_type)
>> +);
>> +
>> +TRACE_EVENT(gpi_ch_ctrl_irq,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 ch_state),
>> +	    TP_ARGS(dev, chid, ch_state),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(u32, ch_state)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->ch_state = ch_state;
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u ch_state=%u",
>> +		      __get_str(name), __entry->chid, __entry->ch_state)
>> +);
>> +
>> +TRACE_EVENT(gpi_ev_process,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
>> +		     u16 status, u32 length),
>> +	    TP_ARGS(dev, chid, ev_type, code, status, length),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(u32, ev_type)
>> +			     __field(u32, length)
>> +			     __field(u16, status)
>> +			     __field(u8, code)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->ev_type = ev_type;
>> +			   __entry->code = code;
>> +			   __entry->status = status;
>> +			   __entry->length = length;
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
>> +		      __get_str(name), __entry->chid, __entry->ev_type,
>> +		      __entry->code, __entry->status, __entry->length)
>> +);
>> +
>> +TRACE_EVENT(gpi_queue_xfer,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 num_tre),
>> +	    TP_ARGS(dev, chid, num_tre),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(u32, num_tre)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->num_tre = num_tre;
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u num_tre=%u",
>> +		      __get_str(name), __entry->chid, __entry->num_tre)
>> +);
>> +
>> +TRACE_EVENT(gpi_gen_err_irq,
>> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_stts),
>> +	    TP_ARGS(dev, gpii_id, irq_stts),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, gpii_id)
>> +			     __field(u32, irq_stts)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->gpii_id = gpii_id;
>> +			   __entry->irq_stts = irq_stts;
>> +	    ),
>> +
>> +	    TP_printk("%s: gpii=%u irq_stts=0x%08x",
>> +		      __get_str(name), __entry->gpii_id, __entry->irq_stts)
>> +);
>> +
>> +TRACE_EVENT(gpi_ev_ctrl_irq,
>> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq, u32 ev_state),
>> +	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, gpii_id)
>> +			     __field(u32, ev_ch_irq)
>> +			     __field(u32, ev_state)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->gpii_id = gpii_id;
>> +			   __entry->ev_ch_irq = ev_ch_irq;
>> +			   __entry->ev_state = ev_state;
>> +	    ),
>> +
>> +	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%u",
>> +		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
>> +		      __entry->ev_state)
>> +);
>> +
>> +TRACE_EVENT(gpi_ev_no_desc,
>> +	    TP_PROTO(struct device *dev, u32 chid, const u32 *ev_dword,
>> +		     const u32 *tre_dword),
>> +	    TP_ARGS(dev, chid, ev_dword, tre_dword),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __array(u32, ev_dword, 4)
>> +			     __array(u32, tre_dword, 4)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   memcpy(__entry->ev_dword, ev_dword, sizeof(__entry->ev_dword));
>> +			   memcpy(__entry->tre_dword, tre_dword, sizeof(__entry->tre_dword));
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u event=%08x:%08x:%08x:%08x pending_tre=%08x:%08x:%08x:%08x",
>> +		      __get_str(name), __entry->chid,
>> +		      __entry->ev_dword[0], __entry->ev_dword[1],
>> +		      __entry->ev_dword[2], __entry->ev_dword[3],
>> +		      __entry->tre_dword[0], __entry->tre_dword[1],
>> +		      __entry->tre_dword[2], __entry->tre_dword[3])
>> +);
>> +
>> +TRACE_EVENT(gpi_xfer_result,
>> +	    TP_PROTO(struct device *dev, u32 chid, int result, u32 residue),
>> +	    TP_ARGS(dev, chid, result, residue),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(int, result)
>> +			     __field(u32, residue)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->result = result;
>> +			   __entry->residue = residue;
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u result=%d residue=%u",
>> +		      __get_str(name), __entry->chid, __entry->result,
>> +		      __entry->residue)
>> +);
>> +
>> +TRACE_EVENT(gpi_process_event,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 type, const u32 *dword),
>> +	    TP_ARGS(dev, chid, type, dword),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(u32, type)
>> +			     __array(u32, dword, 4)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->type = type;
>> +			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u type=0x%02x %08x:%08x:%08x:%08x",
>> +		      __get_str(name), __entry->chid, __entry->type,
>> +		      __entry->dword[0], __entry->dword[1],
>> +		      __entry->dword[2], __entry->dword[3])
>> +);
>> +
>> +TRACE_EVENT(gpi_alloc_ring,
>> +	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
>> +		     u32 req_len, u64 len, size_t alloc_size),
>> +	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
>> +
>> +	    TP_STRUCT__entry(__field(u64, len)
>> +			     __field(size_t, alloc_size)
>> +			     __string(name, dev_name(dev))
>> +			     __field(u32, elements)
>> +			     __field(u32, el_size)
>> +			     __field(u32, req_len)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->elements = elements;
>> +			   __entry->el_size = el_size;
>> +			   __entry->req_len = req_len;
>> +			   __entry->len = len;
>> +			   __entry->alloc_size = alloc_size;
>> +	    ),
>> +
>> +	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
>> +		      __get_str(name), __entry->elements, __entry->el_size,
>> +		      __entry->req_len, __entry->len, __entry->alloc_size)
>> +);
>> +
>> +TRACE_EVENT(gpi_ring_info,
>> +	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
>> +		     u32 len, u32 el_size, u32 elements),
>> +	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
>> +
>> +	    TP_STRUCT__entry(__field(u64, dma_handle)
>> +			     __field(u64, phys_addr)
>> +			     __string(name, dev_name(dev))
>> +			     __field(u32, len)
>> +			     __field(u32, el_size)
>> +			     __field(u32, elements)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->dma_handle = dma_handle;
>> +			   __entry->phys_addr = phys_addr;
>> +			   __entry->len = len;
>> +			   __entry->el_size = el_size;
>> +			   __entry->elements = elements;
>> +	    ),
>> +
>> +	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
>> +		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
>> +		      __entry->len, __entry->el_size, __entry->elements)
>> +);
>> +
>> +TRACE_EVENT(gpi_already_state,
>> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 pm_state),
>> +	    TP_ARGS(dev, gpii_id, pm_state),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, gpii_id)
>> +			     __field(u32, pm_state)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->gpii_id = gpii_id;
>> +			   __entry->pm_state = pm_state;
>> +	    ),
>> +
>> +	    TP_printk("%s: gpii=%u already in pm_state=%u",
>> +		      __get_str(name), __entry->gpii_id, __entry->pm_state)
>> +);
>> +
>> +TRACE_EVENT(gpi_tre,
>> +	    TP_PROTO(struct device *dev, u32 chid, u32 idx, const u32 *dword),
>> +	    TP_ARGS(dev, chid, idx, dword),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(u32, chid)
>> +			     __field(u32, idx)
>> +			     __array(u32, dword, 4)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->chid = chid;
>> +			   __entry->idx = idx;
>> +			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
>> +	    ),
>> +
>> +	    TP_printk("%s: chid=%u tre[%u]=%08x:%08x:%08x:%08x",
>> +		      __get_str(name), __entry->chid, __entry->idx,
>> +		      __entry->dword[0], __entry->dword[1],
>> +		      __entry->dword[2], __entry->dword[3])
>> +);
>> +
>> +#endif /* _TRACE_QCOM_GPI_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>>
>> --
>> 2.34.1
>>
