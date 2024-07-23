Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D113C8EE;
	Tue, 23 Jul 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721760706; cv=none; b=BB8FB1TAQVCTjYW0aw+B6qjF35r00rHYiTkQHvKI3AqxnD6wonva356/zlmcj2F/Ci0jAp4/TWAe4+2CFNl6N/JG+1g8LbOW0F33/YF/2RuUeRgKmAdGD2HIADulcD2VZXBhBtVhzFXzBV0UHSYISOidPcWrA9w3eTu9r0UiuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721760706; c=relaxed/simple;
	bh=zgEgzPzWIL5/uR06XUc4aHE8qz5w7Gc0KiYpZls9yH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A2fSwvTDnUWQ7Lt6GAMJ8VOmLdqPY0JUO/6F0Os//dRaXZz8Z/c0q4TBJG3Cz8j9nnfonbRmrX/E5IaEdqfYUcd0ySjYIsQxSYUsealD26v3n4TfURjcQ8UY2pt7Pb6qGuRUphpVgmoawQcSsVZtiG4QZEWNQ+lq3tbPNn5/jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FCzAKF2T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FCzAKF2T"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHeIaq001122;
	Tue, 23 Jul 2024 18:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J6qbwvgfpGm7xn7klCCRE2coOxI0Cm8K6uhuWyo3smM=; b=FCzAKF2TWRhkC0WD
	rNGUGlghQPitHSdj38dzd1tg3U2KLDI9k59j3QQF1xV4ZV5kJVF30fffww08SwDB
	YnH4h98atECc4H5j98qCzgAMMyZUaguJhRL/mbUtft/nADP83Om7+NX32xGWjZno
	XArd9rimPG0F62DvXTjCB/iJ2yLE+/e7HHfmzkX80BKSuWaFfzj21jmj07o0WoY2
	eTdyQV4XswgzTqxFzWW2F4pHyLW4o2U+3wO1XsTsJA6YFUe0Eh1gkxh8h/D3aQzs
	9otDQoK8yVWrA4VO3uZkUON78cl/zudBkhTc+1S3jsp9uEoNW7ZMjACDsBTaYN/2
	cz7dig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5auqxtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:51:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46NIpaNK020641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 18:51:36 GMT
Received: from [10.111.176.36] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Jul
 2024 11:51:36 -0700
Message-ID: <eeca779c-233c-4b26-b5a6-d2104a2d834e@quicinc.com>
Date: Tue, 23 Jul 2024 11:51:35 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib: test_objpool: add missing MODULE_DESCRIPTION()
 macro
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
        Matt Wu
	<wuqiang.matt@bytedance.com>,
        "Masami Hiramatsu (Google)"
	<mhiramat@kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240715-md-lib-test_objpool-v2-1-5a2b9369c37e@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715-md-lib-test_objpool-v2-1-5a2b9369c37e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EmSBpHuImWrR9WXVZOh1ZDof3iSMiaEG
X-Proofpoint-GUID: EmSBpHuImWrR9WXVZOh1ZDof3iSMiaEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230131

On 7/15/2024 7:18 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - No changes to actual patch, just rebased, picked up Matt's Reviewed-by
>   tag, and added Masami & linux-trace-kernel
> - Link to v1: https://lore.kernel.org/r/20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com
> ---
>  lib/test_objpool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> index bfdb81599832..5a3f6961a70f 100644
> --- a/lib/test_objpool.c
> +++ b/lib/test_objpool.c
> @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
>  module_init(ot_mod_init);
>  module_exit(ot_mod_exit);
>  
> -MODULE_LICENSE("GPL");
> \ No newline at end of file
> +MODULE_DESCRIPTION("Test module for lockless object pool");
> +MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240531-md-lib-test_objpool-338d937f8666
> 

Hi Andrew & Masami,
I see this landed in linux-next, but is not currently in Linus' tree for 6.11.
Will you be able to have this pulled during the merge window?
I'm trying to eradicate all of these warnings before 6.11 rc-final.

Thanks!
/jeff
