Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67931547042
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Oct 2026 00:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331432; cv=none; b=PFezxS6x+rvC9b0Yg+tds/A2krqFNLoeb/aAPBZ8PVDgyAQQrYjnXHw8xNODHAgaOFULhFTv8U91QuWPEWDVoD6r9tzsK1jk1UzbCFJuODJg8bbrz4chVEPnrSvD/qEBQuC8XSyEItV8I+AHjCHyiqx/3e3lykcaX4bjFIU8pb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331432; c=relaxed/simple;
	bh=ruCjfSGct3MizqSDE0TmtgUXUHy5mBaRnQhxTHqCOrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7hXaYSJcb5tNvmEJq/FgiHjxoegRghTwBvfOSjq5o3SZpUVzkltLGzj+58UwKIb6shxsq1DlHPPv63m+vt7u2ITrrNScwuOipJmAlgAjLjJj4ZXrIF1kaUVELGlc64x5uzghjQhSR33tiXqTmimRzipM0aVRo/k+FfhYtTSEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DODPSc5e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6YJXUVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DODPSc5e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6YJXUVK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LeIcL1029242
	for <linux-trace-kernel@vger.kernel.org>; Wed, 7 Oct 2026 00:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=; b=DODPSc5en+vzuHMX
	iBSMHbRqul1ViSDbLqtkcEm95A1obvei5t67JLIFPs6+sjiclHmd5FxRgvnLJS/i
	wxP2/q3a1cOkYwWRHaSgkhGkbog/jrszRKceroPxgurwIdIosJVGT9oZvpyewfC/
	A9u6zIXH45mg3s4hRMf5jImfGjSH6ugMcEQ7byo+h2ZVr3P/32Wouidvt2Mp0sX9
	kCJzoJQ/u5u4bM2h+kLD3Sx4hoZHN5Jf2Ns+qnq/SaytMgaINVXedWlVeSLS0wld
	M4NIxKvoR6C8FLOYX63x5gyugRTczckyXb68rasnQ5XihftwqMvBP+3660dUpz97
	8fSwyw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53asj22g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Oct 2026 00:03:50 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14fed306427so12439127c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 17:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791331429; x=1791936229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=;
        b=G6YJXUVKdYtCtZXr1zjYSey9uNHU3u1iWbbs9z1O++Ihi79w4PhDm7UJn0nUV3A5EX
         nKAst8fWcIqpGsnCGq5+P2Tr9lDroF0DPnmW6iLUqOmYcLfjoQDZVXR5DWI3aUsFQgXj
         0DJKVrUCpcxFSwuwKCU78cANtRq0Dv5IAJs0+AhIiogWRVFWwKrYRlnk7e6fvlF6uNOj
         4PNRR80atnTIHxhxkmBlqzcnSjcF6UEdf+BmSoRWS7gDG0DErXMY6hiX65GITGRb5Tq4
         SfQf3Jhyx6Zs9KzwdwIg4XENUVUpMzwlnM9skjbpYcTcaL2QJwFvpTViCYMmJ+FpOhSU
         Aw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331429; x=1791936229;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=;
        b=N2LVu2VRBOJkWpAEVjNOBgCThXYGMtdXiqXNrm0Wy3WiIIWh+MYYHU3mjXyOhwmGNo
         tFAWIY88v+iQTJONzXm+bMWvI5R6eLEZYDIwUTq4ApfTys0uq2YCnFy1pqdVtT3vz/WB
         mT9fvaavA9dJEI1vS8aqvsi1PuXAMBvEaELmDF3oZudsthnV4e1T5Ra48D8DqqybQpnz
         45B3DB89r5MtymyU5KZp3ccoOOnpRB248DkHRfmEpD+WplHHIsiVcPu30iN8dSoPbcYL
         OPzfPtbKcbG+Wn92vcPSPRDJK4kRNwsNxp+tUU5jAE1nWNWoU3F8feEv2JpbKm11z9mP
         H6kA==
X-Forwarded-Encrypted: i=1; AKwUvBwb2p0PsSPL1OdL9HFnlxKAWTz5WXJkTQi0YWrPJX8JZTZF+HjhQrZmI/QuqD7u61hMcCO4FQh0ZHVkFZ9dDW+QzEA=@vger.kernel.org
X-Gm-Message-State: AFuF++ld0G8Eq10Q+e61wi38L92Ylsdpk2aremS7evvZKatio2vYAdqI
	HNgbrRkraapyPn/cVfyzLsfz+Rx/cbThs1oqp3+wWrUiF1mGfT8N4vO/oAdd4dN2J16jBdHJGTH
	4zeQ+p6gB2qwqkLtAnDTbJQayxdDus4JpnkRY2LeJfNQMorW0x1zUnfAJNvmJpj41GMnHgEKYuU
	U=
X-Gm-Gg: AYBFou3iXTKt7MAKjbaQ+H2/CgqBw3yHGw4h6UW3YmI19FC3wx6rhw4/t7+J8kFAhpp
	ziPh4i9JuqyMGeLOtAcOfqnLeC0dxLdo1veuP3oj9Fk4im+bj8hX8mF+XCepLjiC3X552ojNk7Y
	qkFwGeKeNxc6cBs1PsjbcpGs6nwRtQ1Zk+nodnTaLe10e8osDdobyk8iFD9RqK3le6WYEJmQIdw
	KPTv0QZhr7rc8PzLH2KX+EfoXITknO7WSw5yYAoXsygPd9YXI/L/cJSSwTLX9YTWdDSpEKGyhaj
	p+D3J6mvYXxJwcjq/IY/H4K1OSj55bDp1MYU7ZDIvTXEDwoUBTa/kNuAD21v4kMs4igQZN/KwaF
	dQFithsv+Ks7Bj/bZktZdiJk3emXEGvg2b+UKBR/Qe3yQaIIXgx6p6GLua9+iof0=
X-Received: by 2002:a05:7022:43a5:b0:148:306c:971 with SMTP id a92af1059eb24-16206f0616bmr619633c88.22.1791331429200;
        Tue, 06 Oct 2026 17:03:49 -0700 (PDT)
X-Received: by 2002:a05:7022:43a5:b0:148:306c:971 with SMTP id a92af1059eb24-16206f0616bmr619459c88.22.1791331425354;
        Tue, 06 Oct 2026 17:03:45 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm3343825c88.2.2026.10.06.17.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 17:03:44 -0700 (PDT)
Message-ID: <6d16d5fe-3165-4026-a3e1-27be256f5378@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 17:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20261001-dramatic-hasty-pug-68ebfd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HsVoQWytT1sK_rG7nd1HlCa_VygxT-Mg
X-Proofpoint-GUID: HsVoQWytT1sK_rG7nd1HlCa_VygxT-Mg
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac58c66 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=DSiY3orsq6dgR2GKpvQA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX7+vfdtNrnKid
 mUTgXztVhky0uy+NWlYzst9IwYjUfpKesFrrDgaO1078al/1r5UFce2m7Bt+l6/2uf/Czrm44CC
 KCJN0U/L4849iJzaGfEDHJctY2Ndd6EeD9A3vblTBmMTd7IaeZPBaWCRZEyHsKj2wwvAFWjsgmH
 BeMc3c2zW2YNM4gRYlpsQ8Z/tYIPqlpdU/S6E0SLwuk8etVrxkdc+Tu68A6q1OIttAj+ZnsKQn3
 38+IF24Sh5IvnoyB4K6sX1fyq0m9g6X3OkxOYIcUA3e6Y6cyzckMfWwFAp2uWyo9RaoxacUCZkP
 AzStu1IeOL9RQzv3tyj5ZdIdGhQuf/ZOA+e0pvwoo/MyOxAoXR6gv4Vk7ahxRF2lxGNzMYTD/Cf
 w+GRNSeKd6A+gLEulAAG4+qk8uoW00htYZHbD4XtxGh2LrxyFW0Sft/u30LFahYxq3xOgrooyFH
 JSLWIDQaoN4dYqciylg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX2PecCMbzu7rX
 DizdXc/gyO47OmxOWR3OKrtZhzbjHgxfCYLczkogIol4UVJaD9QkVrtgq0eSWdWXBNOX2rljm02
 EnZFYKpgQY0vguwrbgN9Hu1HI7Fkwu8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060095

On 10/1/2026 1:51 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
>> Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
>> zram can expose qpace-lz4 as a selectable compression algorithm when the
>> QPaCE driver is available.
>>
>> Compress and decompress operations are handled via the QPaCE urgent
>> synchronous path: each request DMA-maps the source and destination
>> buffers, issues a blocking hardware command, and returns the result size.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>> ---
>>   drivers/block/zram/Kconfig         |  11 +++
>>   drivers/block/zram/Makefile        |   1 +
>>   drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
> 
> So entire qpace should go here, no? Why did you create this entire layer
> of indirection, singleton management under drivers/soc?
> 

Since the qpace driver is not specific to zram and may be utilized by 
other kernel components, it should remain independent of drivers/zram.
Consolidating everything under drivers/zram would couple the 
implementation to a single use case and reduce its reusability.

The backend_qpace implementation was intended to setup zram as a user of 
qpace and follow the structure of the zcomp frameowork. As per your 
comment in the other patches, we will check if this can be done through 
the crypto framework.

>>   drivers/block/zram/backend_qpace.h |  13 +++
>>   drivers/block/zram/zcomp.c         |  11 ++-
>>   5 files changed, 168 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/block/zram/backend_qpace.c
>>   create mode 100644 drivers/block/zram/backend_qpace.h

Thanks,
Oreoluwa
