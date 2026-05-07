Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421B4317D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124492; cv=none; b=VzXIABNphQCBsolGZbuPL09Ks4vn1t5CYSs747+DnCguvQQkXMFY9ce2GJ2hnAYVkAA6LAzov0dA4lJ3unaaWi0QKR02ADw8xpTA1SgYIGqhzhQunDkt8ojxDU0X5xtRvloqkbvnBP79mSZaH+C5lD/1fSVlchzvbFkcLA1iYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124492; c=relaxed/simple;
	bh=Xcj3OienWhKhCQV8lmue847Tozpcy05sx3/myZShVB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFbOoTkcjf/BQk4T3tVqp49SHGP5LMrDvikoBDrePP89/nWOB/XeHv1teHIjyIKi6FdqTlTV7ROFy1J7PtZYNM2NpYXWBAnhs8UtALuYr51XmBkfZFjcppOyDCXYoO9kI3wHP3W0AGvV+k078wcEeuXXv5nwrLhOhbHN0lwTXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itHj9n0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwggcVmY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itHj9n0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwggcVmY"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646HvjeC2581411
	for <linux-trace-kernel@vger.kernel.org>; Thu, 7 May 2026 03:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=; b=itHj9n0Cx1WI3fer
	0pz8ZDyx1jTqy5wiSbwB768nFhmGVjCrsJgcDcO9eelzqZ8uRrtD1vvyYBWlzmtT
	tcneewSnlJKk48pf2tZ0uP/dAp3IjszhqQL0Vmp7o2d3e1AJp4ItqM7DZGoDD/yk
	cb/bCahhLoGa3L21QkB3MdVypwH4cwTlp1p5oofB1o6FAvxBk0nI5YuJhfEKovwK
	qu7tO3ds64JaTGUFrJp+pzlZJKoc9y6DbiWz/Jx1zOqNIoeRV+bAJa6TRTrvPO/a
	rf5YOPLWGFa0Dbc858XcSRLCoHzH0+PoA5TdQ/erS4BhQunzJ/BvVs4XiK07b6LD
	gX95DA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw4byc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 03:28:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f485961555so1932199eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778124489; x=1778729289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=;
        b=ZwggcVmYDL9Gs34S014iAeDaWsbxU5rCq2WQTTsaiKuo+eHliaEslM4AyQDytDjI9A
         vWRGFXhAOfhZXb3IZzwLtCxMw62fpLx6UumKk+6V6C2hqVMGOMDGUFCEZH0yUhvplHMN
         olWPBfW6ShaRZ2uWoD6ti5wzk1v/iqIVKWY8IT/i/OYSB6c7cCOdPBELItbA8DIn0Tui
         WOgAaFxmW0HDUX9usrB4NtaYcqi0ZqaaHt5iQsxQDClp6jF9AFOXrdaNGPhoKV6jDR4I
         uS89pyf02iAr2cvbf0JetPLsgFo9ACW5qciVSlfqOsy2FVbK8gyIRiLbrbfe+LZ3erZU
         DmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124489; x=1778729289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=;
        b=T5A9/RbIPd7RXTPuqykE8CkVcQXmklHOd27hKdgTKX6f4du64JzPNrIln9wUSbcTh0
         zL1p+fBZUyz1jlDfAVg1pyKUSvFER4pt4J1+/gffTqGlIYcTUPIfiCM9g+qWxIWOHeDw
         vLwVJg8aW0XfgVac/9es5ioQErX4w9wOntDhgNNhTts7jaEEylDvkBBmu5WO40yuX/Kh
         mTzfp5DBN4bFoejIVWB6aAeL+X07NWDELcFos00b1IU0EvpU1tOOks5+mZ5CetFSW1mY
         l7RfrxJJ1vVcZRWn5TIEKYGW33iV7CKYEhgaCXEXa8QINMuOyVJq4qRmTdV4FZmJ811J
         VFaw==
X-Forwarded-Encrypted: i=1; AFNElJ/qxXkhANujj9yezUm6AkLf4c/ExbI3X2x0mNVlAuE9ipnGgHzIuSRVfHG9Zse7fEROC6YN3fasMtwvx4cM49D5FUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggBgvv+BmGuYfhTaanV/Hq2GZ7uVEDuBTOO8BGwAwT4X86KHq
	zTVWGELgn+vDATHPCtJ9rFjCIiERC0+xOh37ZH2h/CnWSyy+0rxpcx8wgWQ9fs4lHsX/F7TKWoF
	NYxJNs5+HuKBausWZqCA2UpxcLmk0AORhyObYeo9h9ox8Iu0h64SghF7IWPgZFlo/D8TkluBw1T
	0=
X-Gm-Gg: AeBDieulPE7YAt30/E3mLoVrWL0H/eKzfR0wO5CX3ziu8zEeiw9zcJdxVYuf0ojyuut
	HPt/VlF5Qyu1gqW7T47bgHUC2UooBUux6hoeLLIlGfftQap0+3dz8Ei3xRQvQM+rrOpRPVRx9C3
	eF5U+jSHmNEjUhOYcRVN0zNwXkn3d2oZ68HF9tB2mTsZncIomV7VhmXWvXMkGxCFCm5d8clp15S
	SFlWqf2Hjhu/0mPISUFIOpXeW3iKBCObsK4OAGvux+40CqUlLiCzc9UvIGVECpbZfTewCBkqOME
	855o4OlbeEJTNaJ6LQbT0kaI4Kzfu7496jl/UYOD8rH8gmhjqBB4MQBPGVOoP7P4DrVGnIGXmRL
	TCkxlLC2JEOKz1XycQpfAmgbyBKBpfuMV1tzPykW7jlJayBsEKYqd/Zc2cUrgQb4=
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr3245334eec.12.1778124489125;
        Wed, 06 May 2026 20:28:09 -0700 (PDT)
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr3245319eec.12.1778124488482;
        Wed, 06 May 2026 20:28:08 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f89csm6086152eec.15.2026.05.06.20.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 20:28:08 -0700 (PDT)
Message-ID: <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:58:02 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <afvkiT50ZUEXZ-YO@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fc06c9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=RmYZSZXQ8PJLqAOd_dgA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzMCBTYWx0ZWRfXySvuQseF0aa8
 898XWpnw+2b+WfoW494YsSEO4xyxiXu9oiv276u5JlCkvJUQl+uDN2OI8L/Wm18mCgiXJy6opEq
 Yv7gGxNEnTHZgywEXWXNHPE+7xJNrzudiOoUhUvZbN2rln8PGqExpQCKMz6rBMcTP0L62B337dJ
 A0fqFI63BJmeQDLwhdf3wMylS0zpNnSBcx9N6MZdOlXlNA8A4J1A1A6qpTPzjPqw5cc5X3LIGLG
 UXFmw4POV9Wno6qnhIlS6NmYQylssFYSXKgmydut3cjm6D1ZYseZK0vuKeteWx4IZGSEh79a/Y0
 9mjXLVO+j32e/ZTesEGr5UdRA5bJo9sDBzDNoh6+af0FUpFwV86ldVmj6x4OHCoNTU9lPp1vwLA
 eHs3dw/kXEG6gTvyBaq1+x+pmNRvUh47dx89fT9yD4flExpui+Bl4aaO3QMb51hoVehXspbO0IO
 ORJPxEi9cOQPeBvPlug==
X-Proofpoint-ORIG-GUID: bRE0A8GF0R3aLZ_MXdVZwosfEKAb_4Yz
X-Proofpoint-GUID: bRE0A8GF0R3aLZ_MXdVZwosfEKAb_4Yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070030

Hi Mark,

On 07-05-2026 06:32, Mark Brown wrote:
> On Wed, May 06, 2026 at 10:59:42PM +0530, Praveen Talari wrote:
>> Add tracepoint support to the Qualcomm GENI SPI driver to provide
>> runtime visibility into driver behavior without requiring invasive debug
>> patches.
>> +TRACE_EVENT(geni_spi_tx_data,
>> +TRACE_EVENT(geni_spi_rx_data,
> At least these feel like they really should be generic events, there
> hopefully isn't anything driver specific about them.

Initially implemented as a generic event; however, splitting into 
separate TX and RX events may be more appropriate.

Which approach would you prefer?


Thanks,

Praveen Talari

