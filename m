Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B7D3644C7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706410; cv=none; b=eqBlI4W6zbnzUDH2Kl8+GYceq8dojlixlBYIjEqYvO7gvrH/R9jEy3tdScjNzI5Mtf12lLiqiB/X51uAWvwMxnM1BsWxLTKEmzhMM/RRnzR0uEB9wFMJfcGFi1by5W97C1pr9GEYnNUlXH2RK4GJx4JeDqPqyugpnCY/B1wK25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706410; c=relaxed/simple;
	bh=xHKfaYtwUIkx3shdtSvDnmtCH//+t6oNn2Cl7jEfUR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq2FVL8x7i9ZA/wX8bg6m9F/IifqgSMJLdfK6WCfdKiSw+01xIDKnNFsDjdAzlu18jnp3AwY82TfzaoYya0OgAQ6ShTt9jIHoIQ3Adi76pU/81S2WOxokrVsXEVTeVfq2cpSsdQKB+Oukprr4finlWGBkYRup3n4r5H6qQps21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRmIuuJ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUuhcVhh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRmIuuJ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUuhcVhh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH4DFD1234415
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=; b=XRmIuuJ9POsh21CD
	6GDcyNx0bP4OA7lDgs2mBClMNmdpbr72UQ1Qm6QGoHwn95dZhVq4WUMa+JMdUdsk
	iwQQmYkp3EmUsp3pLILqSL/D3EC0dA0gXEeiQEf/4kTXBf3OTwDJfjVU0JltWjfD
	LUZkC2wfl+laMGj4RQC2Gy7QJNI35llla5dYw8K/kz9wvBjXLW6NcbaXR5gU2ZYh
	xH0qG5Xtyu4hUrBvbvqunQpJ1taPts3gMN3ZIEGGuBXxHsoyEACVzgUDncalpd40
	8pELUy83FN4twPlFAVGAvjgnFKIiRmqQGh0tAjR7/MKImwv5lSpwJGAfCBetvqfy
	T2O07g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm876y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:00:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8895156101so1800474a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783706408; x=1784311208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=;
        b=CUuhcVhhD/14b6GyUrSWmhPhK7Ssz7v3P0CHxCGitxZfoO/Nm/yodpvCCxQuvEtSjR
         KtPw5IutAUkdKp+dUhUNGx2fjEN8ev2v2DzUhrNoM58kLVQ3NXsWqyGlGXXIJD6sF/j+
         5YyAD8RTzqnXGcnTm+58ySEsYBlc1TyIZm5y4zXYEiQHd/bHFFCxYObccjUuh/NLj5GM
         TdXJOfuNOGn+lbNPkojcaJyw0wtero3Zeq9Gfgup3vvA+gola5t5DLFlLq3onVV+qLZJ
         L6jZxEOsLocQ1eeUgToBPueL860jk8WQROY71jsBWOA5p4aoOrWYPe70CnFGJgjChz2S
         esng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706408; x=1784311208;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp7gCHgdcpX+eKY+k/SBZCoX5ANHXz2bcvfFyVk4fWg=;
        b=I/t17+pRnSiQhzNxjZLjpNieTngf3ozXDqQNuwUytH18rp+Svmo8lypCj1dxLnX273
         +xsRiJiaHJo632q2nIQHc+WLXeHVRN40HfpSVY1GQZaBZ5j4X+xxaU2M21BXzxI9qa2j
         HXtqqEsoNnzOaa84PFgExDxHBNy4viYhc/s+swfgdT7vMmVuWUxjorNwVvUNj5ovMHGi
         sqf+floAGNLa+tJlPv3QRer9O6QitdfUK1+O03CS0WZcar/JxkUKPXdQ4vp/v3JA3ykh
         TS/gbjAW202FhtlF2Do35xgvK/LM+razOzj1yo56oUhi/AC6lau7AjqlTLMu2NliEStw
         dBzA==
X-Forwarded-Encrypted: i=1; AHgh+RrhJsdowNGCjI3fvBcNinLTgFNm+v1cp8T+M+qk2b78nCBW6fT1qtmVODU5Q9bsdh9pjdxtVn2wTTrKShQwKGuwbOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FjuSGi8Y+jhn1DtN0ZHbE5NBSkt6m/k4cvPBKUJffaXjDnc6
	pLNhNCiqjATQxWLk5NGz10jkbH3K+WCDVbWOqpB5+6k+qbr754BryHMxWOHaUcq6qXlS4rxwjRE
	zQMT2M5WDSCFDpss0xw6aP9K67i31pD8js2xahVW7kSxFu7jW2VrhIX1zK5slG/3m0tOKKACfWh
	8=
X-Gm-Gg: AfdE7clqeqKRbhOMPJuLpI6KBQGLXVprbChEA+o+zD4wgvPrESoOO/iUMg5+4nLXYFe
	QL4Qyp25zV0E0VjmP3Kmh0xwdQIHwTlO9supg1RFOQqs24hPdfvzWatgw5yAK2oo54JbfXgYfnJ
	nYm8XG0rLeMNbJ7u2PE46nxqKR4lCEFZmkbi4kUku7oynMH6/SyyfIb5+E0UjumuE8LTISaP+9S
	S3saIXlqsZ+LQxC86dYVuUlOGEYa2nzxk9+8xMkNRVZHmcz3SuGNSzBY2GO9zkKC9o14VjhQHic
	iWtuxQnuJQkCPoP7kvcG+Ah5xOv0xwtjqEJbft40HOVdjp+B4moM+VC/KS5ZMGg1YbDZq/3e1IJ
	hIdJoscHVgRxmZ9bNyTYWvvUKRqVHmf2z74R3E7nW0A==
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr13543a91.39.1783706407695;
        Fri, 10 Jul 2026 11:00:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4fd2:b0:38d:a76:6470 with SMTP id 98e67ed59e1d1-38dc77c61d6mr13517a91.39.1783706407129;
        Fri, 10 Jul 2026 11:00:07 -0700 (PDT)
Received: from [192.168.0.4] ([49.204.105.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm12368610eec.6.2026.07.10.11.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 11:00:06 -0700 (PDT)
Message-ID: <31205f19-1a8e-4f97-a7f7-b6236a52a5ea@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:29:59 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: trace: Add trace event support
 for GENI SE registers dump
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-1-48bd08e28cf2@oss.qualcomm.com>
 <a2491042-b7a4-429c-828f-905c07adbc5f@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <a2491042-b7a4-429c-828f-905c07adbc5f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: f2GFgKu0eHyje1ux9h9DuvX0yxZDGhXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4MCBTYWx0ZWRfX750Nuq32Dorz
 dxVReByjlnJqZrUVlaxWC+xIWldVKyWUOPEYbYO76/Do9PgDXA9OdiRyJfpAyQrnPr6qhjGitaC
 56TpoD6CW7zzCWZY/C2pOpA02/1SK6OthBojlLv7I66VFBnU7+DQ1X+BHcEcHrto9OrorWyTYbL
 FX9DvtrN0pi0b/HIIIXFJAqacQ1rgUrSDkAOEU4ZCYZh4UkyiAuN3yNDiyL6oa2qWlUhDMsJlZc
 wR/US8ghJ3x9WQ5cnOQTRNv8Zeyw3v5uJm2+ed5R9/KCCQPPYl8d1EJqJhG4Qp+alRqN+t7QB7h
 ac9CFIYmt/A4qU460qF6OYfs/QQDDtcsnabtcBC1Kn2jFsUmL5r3ozoYHDZIJ4KavRPw0bPEAnp
 pKttlgKW/8XBPKwUPbgKu53E1jRnOLZ6yFOGMzNx/mP3NZuw+PZvwryIJ5GTZaeaxlhGX87zmzR
 uSIKtJe5hbnNKE5QUlA==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a513328 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ua2K4HyBCek8nw/sr3ra2Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=j152-PXcblSeZ8F-r_EA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: f2GFgKu0eHyje1ux9h9DuvX0yxZDGhXa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4MCBTYWx0ZWRfX+obOrzVVdPN4
 BX9VW67DJFdaY2bZHpqJ3sLw/5YtLiv9lIujPHNLJV2kqxpx/yc+twG1yK4Q8Vgi9K5W6kw7jrd
 L2WAZlhrstQC7WdaBHYo0btlFMgF2P8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100180

Hi Mark,

On 10-07-2026 23:07, Mark Brown wrote:
> On Mon, Jul 06, 2026 at 04:38:12PM +0530, Praveen Talari wrote:
>> Add a new trace event header for the Qualcomm GENI Serial Engine (SE)
>> framework providing a geni_se_regs tracepoint. This tracepoint
>> captures a comprehensive snapshot of the GENI SE hardware state in a
>> single trace record, making it possible to correlate register values at
>> a precise point in time without multiple sequential reads.
>>   /* Common SE registers */
>> +#define SE_DMA_IF_EN			0x4
> drivers/soc/qcom/qcom-geni-se.c defines this as 0x2004, that'll break
> allmodconfig builds.

Great. i will review and update in next patch.

Thanks,

Praveen Talari

