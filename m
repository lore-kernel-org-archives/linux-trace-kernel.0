Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7503655EE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Oct 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590172; cv=none; b=l9ojs53mWNieolz9qbaV2NJd7fhu/BneGxAEjLxMwNQXsAjsppWpSvx8u5UEbCYPfbKK8FwKpDvAR0IPy1HGVhtJm3nlQbEDH3uhzalMt6DqP9UlykViI4hYzjyqgc5xaFStYN7YuE4nrCF+o5y9pm5m3LFo+ZoVgny6ko1vshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590172; c=relaxed/simple;
	bh=9z7hYxQOC56YcYk/la0dPkEnEgUTeM+W0hts9a9DAQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caf2DjR7VfvXwjD6MMoS8676nQRGrwBP9TmleeuF+THFjsfKs8/Cf/HJffBrzEywBWUvxJwXOx1wLFhzrbVQGvdJn5yT9ZayxPFNsAWEuig2KOU72CgeQnH1OSjMr+Jj7e0bTnNDg2o+4PJtUdmEG2OwQvizSMDvR/cm8ejJ8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QJj/w0u2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Oqzywpsc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QJj/w0u2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oqzywpsc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699NKdmB3602111
	for <linux-trace-kernel@vger.kernel.org>; Fri, 9 Oct 2026 23:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sm8UHt0kUeP9v337omYSKLBHjxWM+fIM1E1WXPZ4J0k=; b=QJj/w0u2RDGgekrd
	cAP3WliD2fOKkfKMSWKRMxj9RMXdqP92SDKtMDO0fMw/aG2qMd6m+5hW3PchhkHD
	2nvWkBY9O/wR4TKcuwgXPKXepmDA+we3drKc592+/1OenSWZ/kYzW1U0TUtUIjIf
	y3DEqFwcKSaGhjHRudqXtidWUV+em31rSJWV+mBPYq9a+kgs4DSuifEgW/gbTIDZ
	oEMrqn94bujPXuOktGUlicG3clXjCQz6UQhhbTKuO1P12m6+aR2/SGPCmfunOLNk
	wYlmjcIjta628pgRGhCrjVtGCflClm1D2bG7MZk9nppSwU7E631i0Hju6Kw9kuPO
	UWaTWw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t7h63r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 23:56:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a082c014aso44005985a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 16:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791590170; x=1792194970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sm8UHt0kUeP9v337omYSKLBHjxWM+fIM1E1WXPZ4J0k=;
        b=Oqzywpsc0p3pGSXaYuY1qf6oV3ajs8N3qhcqhrs/Jhf0SRI+FKpbWfIXsr6rdhY/G8
         bFGQpEVrNPbFVHYOIxNBcPKVvza9NouD3nMM89YPjOy6VTu5BQDtpPUJYNcFkQcrPvR3
         j1SJjsszukTpPQ7WoUPwYngzAyXW+aYCG41WNx2T0HMGubKnbp+x2aGNOZPtAo4bGKgm
         267v1OvRrrVWy52ncCspa7x0P34cHmgqQe/3Fv2HR7awNgIK5p0E2HVIQZOx6hUqVLP8
         W/9nMbD9tQEG0gzkEK6UStQmimaNs1fSxF6slWBje6DG57lUvd3D1txbZIMRAntG/Urr
         l/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791590170; x=1792194970;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sm8UHt0kUeP9v337omYSKLBHjxWM+fIM1E1WXPZ4J0k=;
        b=rWWsWNd8RypOok5ThUqmlkac7XdWtw2xWEEYa8GRkMREbq0LZJ0YzwdhYm2uUocwvv
         3XfxYrKGd6khgVTy1O3Z7Hd6RlmZspwVVRH/548hK+hZE3uv9o2S6QsZIREC1iXQlHrc
         MNcxRr72F8w6ZvyyjNMpBYbJhX+0YbDMIykN8w1QYMmUdOZqkX4JNdkKG3rlM+l8APzH
         dSMeN+K0iv7u9OygMY6Iwux2AXaEM1VkXFgLNP/x31zII9VbHa10xoIvjJAAQKvoHGX2
         S0+RCbIGxfsGgwRCvxuTQp9UYkEXKB3EyErlXHkAzBb0zRwms0UR2mXCWWA6hQQoBEOw
         cdVA==
X-Forwarded-Encrypted: i=1; AKwUvBydqGN6uLVMkk28SAhBHcltGCiJW1STZwDJgjE/vTMlvEj9fNzJXw1t0IHRzL4IuP8i4QtY4007m/ugI47c4O6INWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUTHOrmv2DKjSC49trQf1Jpmd3GDOzOyqf3COxHM/lOfp6Q/Sz
	6Ci90ojAd4Mhhd1K6sFIsp4fVZ3OPK/X0DY9i56JkK89M0XmPTpMd4fE3y1RTql3GSxzsYhn7bk
	3w4cQu1i+39chrEc+Gid31pAWEx1QLoP+85z3h2oimdJgi7aFIvXVxh8E+CBqhXBSC1tn5JeBs7
	E=
X-Gm-Gg: AYBFou1Ds5ToLacsF51A1pLY7J7lmB37WOAS2VDSRAUn1Dl32LAUcZdcSbBZ7IQp8gH
	UUbI5eM2Br+CC13gejwue9Uz3y81FNjmmTfMOPbzEtEEq0skHAoGLjVpypjPwPh0sVIU9rMHdPX
	PHpIm1xj1ls5csUelvwlf3kjA3VE5IUfcbpmry3+39ids++DKLF6D6O7G7fnwBfNpfWPNX0kpF0
	Q9vbueBOa73i6lV5wj0JvmQPOW5ACR+4Ga21sHX5KpGpz0EBEr1bHM02g9207PZpJ19J1GVGVHE
	YVzLBvmWCwEjbNqC+3pVQyBGSbXBj5gMn8Mvu71iQ+24MUph4ztmoXR1RA0I+wwlhB8jn/jAh/F
	8jblphzTkxokDeSyPslQ+WP1YwVY7eg==
X-Received: by 2002:a05:620a:17a0:b0:93e:c12d:4ec7 with SMTP id af79cd13be357-93ec12d54f1mr427905385a.39.1791590169760;
        Fri, 09 Oct 2026 16:56:09 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93e:c12d:4ec7 with SMTP id af79cd13be357-93ec12d54f1mr427902885a.39.1791590169279;
        Fri, 09 Oct 2026 16:56:09 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db94e30a7sm6357514f8f.12.2026.10.09.16.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:56:07 -0700 (PDT)
Message-ID: <6713512a-d879-4fdb-9138-12e125c21ed6@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 02:54:36 +0300
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
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll> <ar4070oH8lRCJMRw@google.com>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <ar4070oH8lRCJMRw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8atxhWk c=1 sm=1 tr=0 ts=6ac97f1a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nv9Pdalr7dmODPptRzIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: lu7oECHJzROpM7i431qCdwMQDfiPdq9K
X-Proofpoint-ORIG-GUID: lu7oECHJzROpM7i431qCdwMQDfiPdq9K
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX+6pDQhBouL/F
 oDpbtKPysLg4IERb2GZp1GxFCU3CxnXxIZD4BqR4COsZ+QFVH1IISNkY9maWavyQqcNOyyqUstI
 IY6IJr6CtVWqWeAyzx11bzf7Nx2yoH4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA5NSBTYWx0ZWRfX3D/C2THZ2CIt
 8VJJ75vpuUjS1Vx8v03gefpq7Lb37rIMUZCGVkI+pjhQp8vgZZVoLPTkJ7exwM0Ig4+DXN+63Fs
 IBEfKo7OlXyUNeNjGbWfJjk8lJQlhacuxEfmgfQU3astO1PV12eKmtsKLdsnFgiPKobUzh5ppCJ
 jdFNuivxdRA2gXDuKHVVyRSRSoIkw64pa0S+BcpDAEuWBNH20sahDa+CbuPKZ4XnqYSi5WrODgY
 FY87LmTIcOsZae4G6++W8bIhkVOZE6TVCdZWReo4DZ1oKl+R5PjU2DNV1LVDKNp+2X6VnyeuMG9
 y8Ajnm7cC+9rxzUMzmAhGfDjJLWTEdll4ePBBw+zD95OZ4dk7B/Gsdsr4dHH4c80hpz2LNEUk16
 xJCWpPNT9dNEcblbSwaJonDibzsoyP0zGvC9WSq36TJQWOmQuM+rhlO34Lvw2r1OpHuwvclR9Nw
 SeDLxcILnTDDU9e7yFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_07,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090095

On 10/1/2026 1:27 PM, Sergey Senozhatsky wrote:
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
>>>  drivers/block/zram/Kconfig         |  11 +++
>>>  drivers/block/zram/Makefile        |   1 +
>>>  drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
>>
>> So entire qpace should go here, no? Why did you create this entire layer
>> of indirection, singleton management under drivers/soc?
> 
> qpace seems to be standalone/independent arch/soc specific, and can gain
> users outside of zram (fs compression, zswap, etc.).  zram's backends
> potentially can disappear all together, if we switch to acomp crypto API.

Are there any plans for switching back to the acomp crypto API? We moved away
from it some time ago and dropped all the crypto dependency in favor of the
custom comp backends, right?

Thanks,
Georgi

