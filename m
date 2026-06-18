Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8160B3B47C6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772921; cv=none; b=N/DPdJJQsjq/C0N2I3PeiyZU9JMaA8DJwrCkmgCC8eKYkqu89Ui7Q9J1lbRyGsOyqv5IVm1UsbbuLTfcXvFSpwxNJlgUGL/x0ydjXG0wMIs9mckv03znninl3rj9JI2D2sHwKn36IgNH0oka1B8jhkpzljTr1gXU/DI831JZPaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772921; c=relaxed/simple;
	bh=lnICbhLhzotstOZ8ZJozhEPKb2XQoYhegRFC/4ln0HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoF7uj1jtqf7LaseKeHfZ15UQGKENF1Hu1setUIJ28rZdQfApKeg+8WEfe2if4iW4Bgqn8k8g0xjr9Awg3kjN8HbtUNtqUR4j7OpR0mB9DJcKqJlOF181xu4wKtvZbomtZW5mKiM7bXwET4cXLTU6iNGGeOGAj56VCp/91r3WyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XwG4iIMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iBnEonaQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwG4iIMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iBnEonaQ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I8FPKJ1177669
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 08:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=; b=XwG4iIMKJeZ2D+Hz
	CKfKP+DHGqgj+Ue79HLYNl9b1uAnxAyVTsqGpS+ZYY6H6+hAsJiLGFM1ZFPc5Tbb
	NBfO2vCD0dAsDs7w6wuEArzY3SV/QITueh556KeyMZJ5l3JLmZ1Ql96dKdNatZSK
	old3Go6fSNOhonoI9JnR/xj55iXWG3df+alv/cfHEMNdz/eUDMprOoqR46iaKgOs
	FNc8bX++hZjuU3fRdeKOFz00+ZhtMAwMAHBHmLmOi2+eDybolD2/04eErECuIYsz
	e3/5kuiLxcKNk8mkXCWywCZHHUlJpeJ+cHEHlgwIFbSHdohakIet0i+2JmNZ9QJv
	U11AfQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kjpcv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 08:55:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8db6d4f1906so2367026d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Jun 2026 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781772919; x=1782377719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=;
        b=iBnEonaQR2w4BB3skIo30HZlN0FbjN/C8fuZh6UbSyus8eiCMIDjZtZYsA4dqfwJUH
         U7QSnmAnGvBlNVCl9zKhl2kTswQKNgR+/rV6qKymwgg4cg4S0re80mjqe76XDRzNAD2w
         OLZbZGIGy2tY08dPoaSjaI4k/oWmyVvVh0X92m4WCDJ9VrcTbbYizmquZfFS8tqTMJUh
         jE6PgnsudZRnc1d2lDHKsNN+Um6mvQ1v840n5Dhrmm4enBlPIjYtuRB9osDygL95U3kQ
         w2R8nEAOG0vo2P8tdcDj+zHbIMHA3UMCKG3torfhH1f+gf4DyF8MCvZRVBXjHkvA+UmH
         wEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781772919; x=1782377719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ogJB9t+p0KYYyOrWxZJxz3yT2aITfrtM/qLnmUX6xo=;
        b=pWVHQIiOC33vZIAgi0EVaL6tijDTe/xtG+1imjf19MDV7zrMqGJv+man+cjdBPNjUA
         uOnl1QrUMlSc8e4l8APvwSstSWoSBt9O2FkcIheXrtnF5egWZxeiZYk3du729vRpvLO+
         XMJF6I+Opqpvjnau5JuhUs7oSGLTT9BH9Cr60/qBbikc45+LvN63idyrlz2+bSQG111K
         oDAjLuuTubAMSqPCWnaUswK7kW+9OWjABJ0/kvaki8uG+UaOcTGR6D2aKPfi//h4o+Et
         t9dWfwD0izhi0M7F/RUDnqQ5bXEnHs0cgoMMV6gk1xJnCuXN+Li6Yxnfadyk9nmOZQGS
         C1FA==
X-Forwarded-Encrypted: i=1; AFNElJ9lRZ1UHOCgz3RG88WcLSs3cTTTRdS9NOFLq+bRxhxYFehFPra4ysAyunqBA6cMEUucvyTBN0UCiAkuQVbEkhKSZsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIRnx1iAWPxeccXqo82+cwNK2x39sw+U1bsgSrFce8pLk5GL3
	Z/aHw5Aa9xhYKrDplgeVmVhjs9DL5mbJHYRU4RpO5lPFs8is98F1+iJQGbshpEC56yzJkWSuGUf
	NZBWgKl8UXx5Z4Bri1GEKsZE8iWPRGx2NC7Vo59epncfxHnbB1P/4Om8HUHt+EmBKB7UZN/kWSL
	8=
X-Gm-Gg: Acq92OEkQrHOXMgkOLXusos/y/UskwPANc2e18tGAmJkEBs0+5FsqcRK7JkFle5a5qC
	dk0rRsCBws4kA8SwIuZ68vBwb6MA39rEQid0zoLEfylynWrY3jWNgbZR7qelDvsFXowpBUTiwIi
	rabncGPntL6t9Su0VN8/QBsVXF5WfSL661rGVdM71+dqaSs9U2BXYl8zNtz/Bh1W1uDTxiPCuSR
	0dFt/JczHaVq/BoKOmJDDbw14Sm8Nzn//o5Ojv4kXLPx2U2iJal4wuPyFfIR7URNdCS0+AiSNTb
	U2rVNropse24VgA/REsOMdUL8nqfLy8B5Fzruj8tErAQSqoprZWlTKhSpQHrLRld4YIYvFTvni5
	7n+4RCcBDtLttv4ioa+MH+rRkLT1AciZCn4Y=
X-Received: by 2002:a05:620a:19a7:b0:8f3:5988:f97c with SMTP id af79cd13be357-91dbb8439b9mr682169485a.3.1781772918867;
        Thu, 18 Jun 2026 01:55:18 -0700 (PDT)
X-Received: by 2002:a05:620a:19a7:b0:8f3:5988:f97c with SMTP id af79cd13be357-91dbb8439b9mr682167685a.3.1781772918343;
        Thu, 18 Jun 2026 01:55:18 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0463a2d1f4sm407481066b.51.2026.06.18.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:55:17 -0700 (PDT)
Message-ID: <9bd02660-c6d4-4c3f-bea3-95b87eaf57fe@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 10:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] serial: qcom-geni: trace: Drop redundant len field
 from geni_serial_data
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
 <20260615-add-tracepoints-for-qcom-geni-serial-v5-1-2efa4c97e0e2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-1-2efa4c97e0e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX3brRl+qGbdo6
 yXnRdsWRX0jIRS0USBBG3n605r/oxPTVzULel/OXQo3Y2ZADb5O3ziHoug/JNQN9FE2ZaaNUGIS
 kL95+NgUNJ1S95G49aeHGsY4oYVF8AKbWR+hlFUdjpifc9/Alf3lGjoAtGT4JSWR+56pnGaw1i+
 2NsQHFsPJI3eIBiyNMkrrznxC6huqTlQbTrl8PYU8irG9Ue/sZ9NHznyRcQFPTPRSa3JPopmUsc
 R21JNhL4WbsjSjMM4xm0EzKCLfK8xGhJqf966Kvvwble20VTUgjbgyjL/JdJtAcJIti1PQqW6HM
 D26mMvJ9GQxq1Q38nNM0EVj54KCaqQ+sfnSozSecNmnTMNKU/r/W1AoenuPp6RFOvk0XjYkbYF3
 BVUw70mSAybDsMsQGX0Q8MA3o4IVcMpP44VaViNvD582l7MLkyYSNVMUc/5EvMQLKPEXOXsusOz
 RKvqXVvQI7Vgc7Tk6BA==
X-Proofpoint-GUID: 4IO8DCPcBMVK9QAE5tgGn0oozT0pOm92
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33b277 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=FD2fNTgVWL2COFQd-LoA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: 4IO8DCPcBMVK9QAE5tgGn0oozT0pOm92
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA4MSBTYWx0ZWRfX7HqW28tjIYP4
 3f5mFiTDX2Gvd/v8ElNDypo7qgpeNUfSEAIkBAO/r6O2ujSDHSdPeuCnsG6o9oU9IVbRhAEDpUM
 aNtBHy3RBLCQZs+qemkjAGgrfQqrGlA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180081

On 6/15/26 4:16 PM, Praveen Talari wrote:
> The dynamic array stored in the ring buffer already carries its own
> length in the array metadata. There is no need to also store it as a
> separate scalar field in the entry struct.
> 
> Drop __field(unsigned int, len) and the corresponding __entry->len
> assignment, and use __get_dynamic_array_len(data) in the TP_printk for
> both the len=%u format argument and the __print_hex() size argument.
> This saves 4 bytes per event on the ring buffer.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
