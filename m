Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B023E7BDD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527167; cv=none; b=gi4wBVFxepA0BquTnzjSQZPlVBPHk6o8ppCl7ORYHi4O2VIV/njhspXmA0kMhUbjJFYeNRkKi/2aP9rV/Pfo9Wz5T63EOPBfYUT9oyeSOvdmsHz1pdivkbx/ZnTgLP59zPjEAswDK/fthU3k2ivBQUq+d1De1fF39kCNvfUE/TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527167; c=relaxed/simple;
	bh=Y5prCy5+X71R7ukzr0TW8cLU1IZdPzDKmXZeqLxAJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qol3JjysOdfuMZHzDtSZmtlt3hr4JYfOFtyy9nHrNqKgzloFj1jtCRydUs0rcvdvYnXpERLVM3Q7rcRlz6r5xDyDAVbnxHhpO3WbFR68bw6hTR8KyAYp+iJKhQrDnWps+E2VceJLfr1isUEufn1ZOcX9SAuMRSCSVZa+5+PcMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I15gNtEg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZMArD7cc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I15gNtEg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZMArD7cc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZAWV2712642
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=; b=I15gNtEgbJFa3B2j
	oF2UfjblXkO2+xaZprLAY3bykuh+O2oyNVvKV1GpUMmRtVtbnrce/zW/EcpVsnNb
	PO36+hgg7n4VQ7FH83Q9gZ4WU+xJr9dK750kVKL0RbDOpFuFzlOQLv6oEg2LDwoR
	V4fjnxOB2Wgwhe3gDVE9KDYMIElRUdimqWd80Dtx+iry1BhuDjMPxR1/KsAdMxeA
	nN/VkD0yd2NdxRzJX/tiszcOM8KqhkJJOCZUDkqS/t1ZwJkMY6y1L2EOOOrouEV2
	5k7y3T5w50GTHHGbVU3VWctL21bxGTv+lrCm2DI20Blc5p2PJyeqJgV9yesLoXgP
	iQlbUA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete980un8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 12:39:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1394c3ee7f2so6655329c88.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781527165; x=1782131965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=;
        b=ZMArD7cc+bViQJNq+abiNgFiBNPB1JZ2vsARTz4y5k2v29KblIOfg8y8FoLnz1oJv8
         lBrwiI+UdmDlcVIqtH2JewyFxs3mUhIdDDOYLKN0JdLXlTI2zXYI77caqWHKBsBbCjvd
         YYDBpLvb73kYTeUR0xhk3QKnzMDM53iIE9pLCCMCKD55GhWf/cxB2jmiymt/Y7crs7PO
         YoCcC0ep+ptwZ0YQLuz6QZOSE6g3DEigWCfc73gykA2GqYVai3LWj5H4dYTl5WUVisiG
         MburxA8QNw3EApmVGgSDCxf3pwnCuhAbFsQefto658RNyiyc+cxFcEeCMQSI3JEOoKBr
         Xj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527165; x=1782131965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvAUEeqrTnOOtIH0IwXD0ePwoU1h7XJ2wsmVx9GGNbE=;
        b=As1WIhTr2+K4tnZm8OdgjeSuQNJDmXF+tShNE1uGN1+ml1IEY2dRFiSgEErtD/YWMq
         x4ig2jh58SndgMRha7QRYvJYIv6B4Pml/uSBM+s2qXgBa9UhKNCbnVGdxz6jwILBvVHy
         AxNEd4xiXH5a5HKUMMCZhQawfQmOsEnhG8Ug06AD11RVBTY1MRDfCtc3En5O5LdMqwd/
         ZYyQ6L/8pfDKJJkXOSxK8C7NJFPZJNbTrF6f85q+l5cNHAT3QoCiyVf2JkJ2gYsBKPnO
         EDdOQqw83Ptk6kCTS8B8/AUmrMQXdaX9O/v9tfxhSVNgZ00eds7SvsZb7dpye64YqL/A
         h2ZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4zGqgjMrel5sLlaU867YemyoTcIPx1Tkb63Gm8OaDYg3KJxRwP52rthSX3ZzFWaCsNkNHNI/JYXJtEzJa5Y7NgzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMhWjJqRMQq+Xn0wKArPVTJ2tmXT2wCA8zCmrKRMgDswaOH+F
	ScK89ftnePcq+TMn8IRKqZRrUPWmMCyD+rTuR6li3WuycWSaUIoMCEDpIcwkYaW9xCJ/gXxz6So
	5KdI2iUTctmMHQ0F0s0Tyw96nabqYUWtCW1IHG6Etgz4CU8gzh1GHj8tw++dex4sg8SKkLTw6uM
	wCDHHiaBA=
X-Gm-Gg: Acq92OHSVSFdUszXKlOJuMWUFV9lzKO9Hj0eeTWoF0fUKVbEmZ4QEjFB86vWp8/Kfac
	/9DgY4Y4cZyxTWfN06GA3gr3ygpuG0D1sjimULSG7AC2P/4bIh+vJoqvXl5aj5qOH6nq68Z0K+M
	ZxoxEun+7BT/UgZCEcA9RRGL7O79fOK1bvAEstubI5U8eOb/agZB+vRWfHR9rTBKpOpfhk6ahCV
	xPQNwmC+LGAKUXQKtghCWlJYZroH9nX3yK9wTzN7jfryRyh2uyQaeU49ehqFpYlOXbJf2/fwMC0
	VnbsQd4qA0zfC2S762cP+UAdmxsyLbVftiUxFZ+dxqhFYcXm4O+ea1iChEG1jMHC2lI2ddUcREx
	RMy+mOD1asQ0ia2aSBf6NfU/wEQroBcla9zWnYHxgwsbz/AdoGxrMmw==
X-Received: by 2002:a05:7022:ba1:b0:12d:f0e8:9696 with SMTP id a92af1059eb24-1386f237657mr5141959c88.4.1781527164590;
        Mon, 15 Jun 2026 05:39:24 -0700 (PDT)
X-Received: by 2002:a05:7022:ba1:b0:12d:f0e8:9696 with SMTP id a92af1059eb24-1386f237657mr5141931c88.4.1781527163931;
        Mon, 15 Jun 2026 05:39:23 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.111.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b8f9927sm9787181c88.1.2026.06.15.05.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 05:39:23 -0700 (PDT)
Message-ID: <945821ea-5065-4e20-a1f9-32f7c9adb66a@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 18:09:17 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
References: <20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com>
 <20260526-add-tracepoints-for-qcom-geni-serial-v4-1-e94fbaec0232@oss.qualcomm.com>
 <20260529101422.18dda2ae@fedora>
 <688f0529-44ea-4cdf-bb0f-6c42cb3fa07e@oss.qualcomm.com>
 <2026061536-skirmish-nuptials-8fd6@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026061536-skirmish-nuptials-8fd6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a2ff27d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=f811rhDWPubbsD7ecTZfYg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=77qTbivRXhmBWYv1PLEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 7w9falt5ozHDcgrKqzugeDgDMzYhzp3z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfX9eLcXpZl8vyM
 YDw4lWE4K0/LxcmriGY5RzD1ZWXYxMmvC5Y/I2O7uD2En56DBlh1udeqaJtPvjL8wcScCendR8b
 TfxxGmt9dslNPmxOweh0YcdWDKFPCZk=
X-Proofpoint-ORIG-GUID: 7w9falt5ozHDcgrKqzugeDgDMzYhzp3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMyBTYWx0ZWRfXygGMNzmOCdtN
 hH71oLDFUEVHA23/HmRODnHbk3+6ZOKEJqjYiXM4tfkT2YNjr0TRGKV54pyT1QchreCpupG+nma
 aHlby7NTkhot4O8mQyIaW8sws4pDDpTgSF1aKqecwhToEzCMXwz0X5T7B2xzxTtjXNTB145BbNU
 El7cMf1ZDz9LvwGv2CTSPRiU8KnKs6VFStOiRsm1UKdCzAfNoB+4Mah/mz97Q2dbHIaU6+iACFG
 axxrANlCTgtXicttvFiWD1Kv/0HQPCnbxfUDGB5wORQjGZ8Jwli9QRSzCNq6LjIwrAn4fG7cO/9
 FY8b/iwjPuUgcrcn9ncJphEV2OWLi3ysLTcRLTmpSVZI5v6dTNLDvwF6Y5nujVkIXoaJDTzj4aq
 +wkhqraJS4i8yEeGGhaU5lzTjmEf/9wDXBvew9b6fvvAqPYB6CiLqEk4Ch0CrrRv5ZlwlLZg9ir
 X9MKGbYLX0l4sbL+X3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150133

Hi

On 15-06-2026 16:12, Greg Kroah-Hartman wrote:
> On Mon, Jun 15, 2026 at 03:26:25PM +0530, Praveen Talari wrote:
>> HI Steven,
>>
>> On 29-05-2026 19:44, Steven Rostedt wrote:
>>> On Tue, 26 May 2026 23:07:39 +0530
>>> Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
>>>
>>>> +DECLARE_EVENT_CLASS(geni_serial_data,
>>>> +		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>>>> +		    TP_ARGS(dev, buf, len),
>>>> +
>>>> +		    TP_STRUCT__entry(__string(name, dev_name(dev))
>>>> +				     __field(unsigned int, len)
>>>> +				     __dynamic_array(u8, data, len)
>>>> +		    ),
>>>> +
>>>> +		    TP_fast_assign(__assign_str(name);
>>>> +				   __entry->len = len;
>>>> +				   memcpy(__get_dynamic_array(data), buf, len);
>>>> +		    ),
>>>> +
>>>> +		    TP_printk("%s: len=%u data=%s",
>>>> +			      __get_str(name), __entry->len,
>>>> +			      __print_hex(__get_dynamic_array(data), __entry->len))
>>>> +);
>>> No need to save the length of the dynamic array in __entry->len because
>>> it's already saved in the metadata of the dynamic array that is stored
>>> on the buffer. Instead you can have:
>>>
>>> DECLARE_EVENT_CLASS(geni_serial_data,
>>> 		    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>>> 		    TP_ARGS(dev, buf, len),
>>>
>>> 		    TP_STRUCT__entry(__string(name, dev_name(dev))
>>> 				     __dynamic_array(u8, data, len)
>>> 		    ),
>>>
>>> 		    TP_fast_assign(__assign_str(name);
>>> 				   memcpy(__get_dynamic_array(data), buf, len);
>>> 		    ),
>>>
>>> 		    TP_printk("%s: len=%u data=%s",
>>> 			      __get_str(name), __entry->len,
>>> 			      __print_hex(__get_dynamic_array(data),
>>> 					__get_dynamic_array_len(data)))
>>> );
>>>
>>> That will save you 4 bytes per event on the ring buffer. And a few
>>> cycles not having to store the redundant information.
>> This patch has already been accepted and is available in linux-next.
> Great, can you send a fixup for it?  Or want me to revert this instead?

can i add fix patch in same series by removing original patch(0/1)?


Thanks,

Praveen Talari

>
> thanks,
>
> greg k-h
