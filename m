Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FF547078
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 00:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331475; cv=none; b=lTT1ilkWBxpMlPCHjqZw+98Ro5v0p7L+wwPjx+2YpXIWpUgJkXyDApiGIgUxrWl5fjqVW6a+B3Z9mGL3jmFcbycHOp5kSGZc6zIeKZWQ/JY248UJ2tIFPeH3QlW3W8zycdqhDzpHQCQs6SghtNjPNr98Y91HcvoXuIwQxf8oLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331475; c=relaxed/simple;
	bh=VO4HprmEH26bPDpYKpkRUcTkm48LKb/lQGoubvhwlB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9k+30diHxU00JEqTGti0vhsmv79xl7zfuDvAslxerMisDqAyxLr3h60wnJ2Xw8CKZgv893K4Ob7Q3xEykJIlp6979epOP2GLgMZVJC1jTO/fcwznSQdLKrqxd34nXJFsZ3M6JLNXjYnuIbHCZ6zEuNX625zE8+tblYQbIA0Q9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tas6yyzW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvBYxDAe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tas6yyzW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvBYxDAe"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LeYZL2514095
	for <linux-trace-kernel@vger.kernel.org>; Wed, 7 Oct 2026 00:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=; b=Tas6yyzWLItqucKS
	dl8jKUO4sIMPfRmjsoIwJHH65AtlbBDNF38QAKrvnnYDFYDVUBumtF5eBNxc8jXW
	bYI5kMo5syUPyHzMdl7XUOCWMqPwhXIYl0WJzs8c38bj6jx2pmYgztfoUkpnEoca
	QddmSkahpwP06C0ciybD+Fj25oizt/IXikLsx+T/ELm37UQ1ZXoAJLSVgRJofKT3
	IbeKzchhTCEN2yNXdFgxeSzGhSO19G4mzz+TG9LCEEjMWFDUlEyoi+IBZ23FaDQ1
	pC9zhRkxANkzOhYDAPbmlpSdwyv7UDR/sJgO7yCmdQX3BlDIJ0tAb4JKBZ9kWGxk
	832VfQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwu4c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 00:04:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1416f32fe11so6887367c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791331472; x=1791936272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=;
        b=dvBYxDAeh/6rvzeVyi0C6hCpkaWyjBIghEFwr2C5lWWZcP29qEKBi1BDi5gkVAClDp
         z36lui2eODOB9XwxX5CZliBZ2RGig3WwIsZiT1PemzRq9H/mq9ILcqZk1Mz+fP54HMKT
         hi8gjhdd6GFHypUE3n1MhaTz2Sd/FlNWqOCU3OY1vK0uPFOa+2ywn6N8DWketisBWfky
         uGCP2gdcXX633SkazQ3WBSx0htH3mdWEvT2b79+TD4wJeAmwZ7kB9DFiRkc/kQAOKu3F
         gIz9JsXvozUxKeGNXYanWS53uk9rK7HGIhI7PJeJDakLwiFs8PwoZwe5qTuLYU5lV2oj
         zwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331472; x=1791936272;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R3JSQSkvd1It0UiMktc5j45ZpdPQLK3YDm6tjbqw98c=;
        b=bK5TkWmL3d+YQpToXd3wKP8n87UowDXMRaQf7vofgTX0XtbYb2fywM7IDRABDSsvAm
         jiTPuo9hGYtrVHxUBvqEcACtQa+NQI26XFNvpAsrjjww3KakhvSLZM44S3z1Rn+jV7Rg
         UM4nrq9V9ywqPd0xy+zuetca34W62UfeW3R2q4rLDpe7BIB2gLXhPfb4gq+pD9DGsTCv
         DHcxarHQ8zwRswwIrmBeCo6PSfKIa3wsOZPtYe3L4nwq9O69rP53LZuSiJs3qG8XP7dQ
         60IJnJV7qesLXQLTQQkZRrD7BSYaD0ITsZkVgequ11RI99p2iMJWDjKkqlOuB7vbtS7U
         P54g==
X-Forwarded-Encrypted: i=1; AKwUvBzJB7/P56D3Y/zSZP0ouEZm++UaLfgPWXcmO0SEYZmu38vdAUgp1uED4HwEUmeaNYyrLv1/8jf19ryAkdovltPc75w=@vger.kernel.org
X-Gm-Message-State: AFuF++nEtbA5T+2bZw2Fho+pRgG2pusZu4FAoKDXSdmABpPeSITrha65
	mBkz9bJqrpNmIY54/JMdBNR1P2K8HVnZJYpbCFgZErXuzf49JWG4pLHdmWF4NSlGCTUddSSGtn+
	bQi3ncM0+pL5fvJphZ64oWINyhQTkFZqeOhAKuTNfLFgmmEJFwH4eSYqiG/iC5mt+HCv9/TV3CC
	c=
X-Gm-Gg: AYBFou2VsHBGvrSC0+GjnMMmETJqq31bEGXRyTJcX0/obLAtLZxyqHlnl0/MM3htr2A
	GKCJrPa2F9mBIC3mvyUpQtAUhvTcV+8zIPlBOnrmKa3/PwEIk7KVkkLDm/b42wQaWU4i3vtyTpO
	nUJFdOf/E2kXbzKdTGHSvDe5xKW/ATWlLjN9cHRd853axsekd8glrtXhSx0WViO8SsmXA/JARSn
	7FCOpuQxE9MNmWtB5vOVzOaWBgFP/3aQkWJnUmjIqZ8uj1TMVTxFCZwL84FAPjR5kk7Fxm/YyfC
	IU5vonZ9Epn9zGQ+0dcgSaqkn0IxJ1vD6ywmQw+P45hzyzQtdwi6mkdiVN098hFD5SlFSqoec2H
	0CGSIWkBb1ToSKOriu0cq15KcfhHmFXSvuKmdJF2CgB+rM+zFQNnI3HJqPOAZRRk=
X-Received: by 2002:a05:7022:225:b0:148:8aa2:91e2 with SMTP id a92af1059eb24-16207d7ca8bmr589098c88.38.1791331466102;
        Tue, 06 Oct 2026 17:04:26 -0700 (PDT)
X-Received: by 2002:a05:7022:225:b0:148:8aa2:91e2 with SMTP id a92af1059eb24-16207d7ca8bmr589063c88.38.1791331465559;
        Tue, 06 Oct 2026 17:04:25 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166121f2asm1995815c88.4.2026.10.06.17.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 17:04:24 -0700 (PDT)
Message-ID: <27eafbb4-22cf-4706-b551-34c0c8d30ae2@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 17:04:23 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <georgi.djakov@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, abelvesa@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, minchan@kernel.org,
        axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll> <ar4070oH8lRCJMRw@google.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ar4070oH8lRCJMRw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX31Qa2E3fYMVJ
 7ktEHGvZIe7D6tOwqqZXnlhZ7B+Yl+1sUgwnxzbphN4NlwZ9m/DlX/jYuzSo2GbKXBbqJj4zxi4
 b07+JA0fBX/jdYzqkD9MtFN7Yw6mI9n1sJiR8nz+n3jL8vT3zRK5tWnlCwODEYpWQ5PtjvvHEJS
 FvT1kSaVz20MXJVLequqv24/p7XVdbsWyxUc6j+e2SFoEEoCNB47LxvQPURSUwZvFoCiCQJqMG6
 sJnVdHhimak91jdYF8gM1V3jOgVLWyhRrCPvGuC9itO/p6H99p7BhCvhMorAbRsQb5gScuGcwnG
 zyTvueVyd4JYaoKUYJzKjyADNOjmDukv4HiFk8TbTcbhvFd9NRxcsChzjZhD7HCXF7fIPBcS6fC
 uDZAdnHDAvtufV8GmlPL7+Itfp8Y74rC2hHafBuTMCoBvWfc+Q5fjdn6AeaOJVM8gyQj8P8M5j1
 8PRJv7DmmP1JQEBcXag==
X-Proofpoint-ORIG-GUID: sMWh3SHFky8cEFaNOZiAv0PCySMzdnfE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfXyxzbVSjB2StV
 QdmcTBFUTE2zuL3Tcj/LWr2GY8XZV4BjTmwY6/bZ9dqRCSiSsKyGxiimtLWhckUcismPxcvkKoX
 hdTP5MZYntFr680O4bNpfFxCXLw9RE0=
X-Proofpoint-GUID: sMWh3SHFky8cEFaNOZiAv0PCySMzdnfE
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac58c91 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=UI1gRxWom6vz8qzGwdkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060095

On 10/1/2026 3:27 AM, Sergey Senozhatsky wrote:
> On (26/10/01 10:51), Krzysztof Kozlowski wrote:
>> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
>>> Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
>>> zram can expose qpace-lz4 as a selectable compression algorithm when the
>>> QPaCE driver is available.
>>>
>>> Compress and decompress operations are handled via the QPaCE urgent
>>> synchronous path: each request DMA-maps the source and destination
>>> buffers, issues a blocking hardware command, and returns the result size.
>>>
>>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>>> ---
>>>   drivers/block/zram/Kconfig         |  11 +++
>>>   drivers/block/zram/Makefile        |   1 +
>>>   drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
>>
>> So entire qpace should go here, no? Why did you create this entire layer
>> of indirection, singleton management under drivers/soc?
> 
> qpace seems to be standalone/independent arch/soc specific, and can gain
> users outside of zram (fs compression, zswap, etc.).  zram's backends
> potentially can disappear all together, if we switch to acomp crypto API.

ACK

Thanks,
Oreoluwa
