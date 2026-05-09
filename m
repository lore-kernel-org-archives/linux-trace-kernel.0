Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC023F431
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 May 2026 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289560; cv=none; b=XKGE3POdwNTR/ZaAtnTcFjdy5TG+DuW6QjNyYhgI21+TlnkBJ+fWPCavrT4mUupmLzzf3ovK2o7zINOUn6Cc6fAiElwY4gbAtO+64xBI2ZGu2PgDt0H8bk5hLeUVarzavY5wGNCJuumYo9HksUFDXP6tMX30K1clb9d3YaX+APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289560; c=relaxed/simple;
	bh=akDT+lYONcbq4fIHNXiYeOOokqqF1TABlkQo5wHmVvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdbE6w8a632Xtdq0Mtuz+Tm9+IMGr4/BLPK499qT2tUuffspLNDoQ3CwoDXLfFAJwXxPs1+Ria60ZxvjWwe0op/kC87K7pn7wj862+DpERtNbDvpJsME+9j3Ul1nAxRjQjdgRVIu/ukwzWYvoR0Q+sQzvg9VGa608h0K8+ZlqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L/NuR0Uf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RMCxCkkT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/NuR0Uf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMCxCkkT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648HedNG1661877
	for <linux-trace-kernel@vger.kernel.org>; Sat, 9 May 2026 01:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=; b=L/NuR0UfsTpy473e
	mAveDI6EKxjmjbtZuaXprazRlbgBrvz/5j5arv9uRawLTF5kSWSzOo6SXuuB50bT
	lNGPlrHs4PoHvuksBjwNsLsRcJUKwSEd4mtP/hNIemwk7V9G6ABPDYM5hqqRNTmf
	/OoBi6aL+p1P9iGbFmr8LJ8pn8fWEcTMmRwySDXfEKqkTwmnR8Jb0mQCgeSU7DZV
	qQWuc+O4vsQ3paK/LEkKBOZblEsSSlLX4XbrFfsUhwq+ISENWluwmSDvyJiHvvAy
	EHZupNChhLpZHf29TghBTpaJ6wwDcNHzUssdxAU8EXx1UM2GSyFYwj8gaKmEsW/l
	KWKlIA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1men152k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Sat, 09 May 2026 01:19:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f1383b7439so2950923eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 18:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778289557; x=1778894357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=;
        b=RMCxCkkT3L7FEPRWmUhymlQ1Y7914etXW83vhGXwiYHcK/p4evSLa+0uwZBwBmo9TK
         zlieESMHaB0nIULgBaYdV5bEx/1gt6r/053sxPf7gok/qEwGQj73TDvnvx5tD7KglhpV
         iaR87TB9H71/XleBQunt6cfXOULvcC91ZHNqdFoxJx3f+YFAnHGYs/+fE/a/NUhPnZzD
         +20Gx8tj9ix1MPKZND6Y0nNNqa3pqliuy+mPIFKGkhR5S575HTXU1lSGhqZePCCPFgW9
         6fByGpYErAPP7N3nyeI60DDOsxuJYjZcTAdZrmo5zPOEZvT0SyCqye8SQ0PdY9+z1W9g
         Ik9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778289557; x=1778894357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CBYMEKKTRjFBCxhabXLvqdNhN84ux2TWjRDod/XXIQ=;
        b=gwy8P1VQcv42iu46ZOKbGSLE+IdkPrsWtpplH7lz3kOuvuIwis1Xa/ZfxmvNSH9QKi
         A/PrEG1SU+d2QIq8ct9WDZ0ix1EBVnudkjCU2ebZs4VO/qhZj9cKl/Zr/tdfOIPS9VFD
         QoM8YE7M6oY36dtDkoD29OS4eBGvK+sRS3oDeaohXPq8UNL7e3R4HO2j0ZgAunzZlPYj
         o3dxP9EKmnqEd2JXxJsShNgHMrf5tIsx4K3BuDFogrZBawqi7XRoXa2x+UArfLig5bLn
         u6kz1WTZbs2xqynIWo39hj7wQDuH1+3pHXFIaxNZjzmasD67sniHNl6HB0fr7nWitdKl
         VykA==
X-Forwarded-Encrypted: i=1; AFNElJ99n+3Zatr8uURMM0ZD/5EmD2u9Ay761BK5xucp6UWg8pZ5e083687uKzIdCE07Ux4WF4enP8DMtdsxWt4Vs12ifAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafLmnxOZKTXbEwTtY2THfAaY6u0KucORNt7FPczeG4rCGOK2P
	HuJzh50H6Os6Jxgp6oV7f7b5cztAUfKy8VwRpYnrTaazpElMIgHSaz7BTJLw2U/WEKnGMPrFGD7
	ZydHz7N0V44axZvkT56+2WVEfZW9h8OTCa6KRTaTJBPPtr2unJLh+I7NIesemhpak0LNQXyZbR6
	Y=
X-Gm-Gg: AeBDieuV/JBJGjmK0lvE3p7AAo6RVkpPic7kEEsSriITS1xoG+l8GdpxQJc2l3pkdDI
	ySeCpv9z8Q904l4iQgSakpXQcXweYGLxcBAtojgXEe3+03WLaKGv87iFI7Au2VredXvwjixQ6eK
	FeVaV6gPowY2pX80tjoEzemJrUI7L6+hLQhwvk0HhDMMuW4s1tEFAhySI7xXZzvCaoiM6V9Qqn2
	bVNpiCOfEDpjnxt/B7AM1PNVazzlxlynFFVbTiiQde8wL2ngx98fTyo5FFL0Wt065vAnDD41ep4
	aKZSVA1KoiE/Qd6jR6bJ9A3PH7ixGmMSoJrjahN0ehz/v/6ccwczw9TSRL/hfdndj5rNwEao9sk
	ekwKmS0bmi3MQPHLCeB7EVJMk4GNK+Px6fgnoeIO3SaB8CetISwgQeg==
X-Received: by 2002:a05:701a:c94e:b0:119:e569:f86d with SMTP id a92af1059eb24-1323ae991aamr4128635c88.10.1778289556619;
        Fri, 08 May 2026 18:19:16 -0700 (PDT)
X-Received: by 2002:a05:701a:c94e:b0:119:e569:f86d with SMTP id a92af1059eb24-1323ae991aamr4128628c88.10.1778289555965;
        Fri, 08 May 2026 18:19:15 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327821fd00sm5674706c88.8.2026.05.08.18.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 18:19:15 -0700 (PDT)
Message-ID: <2e694c95-83af-4548-b453-19904d24d924@oss.qualcomm.com>
Date: Sat, 9 May 2026 06:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-serial-v1-1-544b22612e08@oss.qualcomm.com>
 <20260508132543.4f100ae0@gandalf.local.home>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260508132543.4f100ae0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAxMSBTYWx0ZWRfX82j63CA/mUSQ
 uvxGfwxpLu/zuH2VF1kjEaB7pJWvgYvbO0j+0SL/bEdVnLigRQiuxDGP4/ips8QkDaK00QQxDNt
 EfPBlHLFm4FzEbRH5WAkyN4UV/V0zKmsYlekva16HAzBUqCP62fb2GZjYRH1gLaxTFuzkfhNEN5
 WYfIqgCERlsjkkMfLkinZsiJoHZB4NZ8/oNKLWbJmAbt7maj+kpMEFVV3bCFSyGSvz8py8yY88x
 wLhBxjUZgVj+Dj02nTyRE5U7DkL3lI3+x+2ixIXsB5UqwQFW/GNTewGoWbfiqj88R0NHRk37XVH
 F5BaeDwbXAi1wJHlYL0NN5ySNRBzzYzsumA4DB7xpDiuosNBDaVp+NGes/AGSJBrR7w9edg2USf
 ohXGVdTsSsiylnPFONTncq3ZDOpI9w7ErFH0bBh09PxeWtyYPhHkftmQZvQtLSh4240Xwm1Mfkm
 ogVdjVMVQFmOEvW7iVg==
X-Authority-Analysis: v=2.4 cv=LORWhpW9 c=1 sm=1 tr=0 ts=69fe8b95 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_ZtuFXLZ6xHUn8lUtBkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: qEnnlrF_-8K0tcE1fgLzyqDQ5rtipmQd
X-Proofpoint-GUID: qEnnlrF_-8K0tcE1fgLzyqDQ5rtipmQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090011


On 08-05-2026 22:55, Steven Rostedt wrote:
> On Wed, 06 May 2026 22:54:44 +0530
> Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:
>
>> +TRACE_EVENT(geni_serial_tx_data,
>> +	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>> +	    TP_ARGS(dev, buf, len),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(unsigned int, len)
>> +			     __dynamic_array(u8, data, len)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->len = len;
>> +			   memcpy(__get_dynamic_array(data), buf, len);
>> +	    ),
>> +
>> +	    TP_printk("%s: tx_len=%u data=%s",
>> +		      __get_str(name), __entry->len,
>> +		      __print_hex(__get_dynamic_array(data), __entry->len))
>> +);
>> +
>> +TRACE_EVENT(geni_serial_rx_data,
>> +	    TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
>> +	    TP_ARGS(dev, buf, len),
>> +
>> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
>> +			     __field(unsigned int, len)
>> +			     __dynamic_array(u8, data, len)
>> +	    ),
>> +
>> +	    TP_fast_assign(__assign_str(name);
>> +			   __entry->len = len;
>> +			   memcpy(__get_dynamic_array(data), buf, len);
>> +	    ),
>> +
>> +	    TP_printk("%s: rx_len=%u data=%s",
> Do you really need to say "tx_len" and "rx_len", could it just be "len" and
> have the name of the tracepoint show what it is?
Sure. I will review and update next patch.
>
> Each TRACE_EVENT() is really just a:
>
>    DECLARE_EVENT_CLASS() followed by a DEFINE_EVENT()
>
> underneath.
>
> And each TRACE_EVENT() costs around 5K in size, where most of that is in
> the DECLARE_EVENT_CLASS() portion. Thus, you can save some memory by using
> DECLARE_EVENT_CLASS() and then define the above two events with
> DEFINE_EVENT().

Thank you for suggestion and will update in next patch.

Thanks,

Praveen Talari

>
> -- Steve
>
>
>> +		      __get_str(name), __entry->len,
>> +		      __print_hex(__get_dynamic_array(data), __entry->len))
>> +);
>> +
