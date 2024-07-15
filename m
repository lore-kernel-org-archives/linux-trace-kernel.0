Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92244C7B;
	Mon, 15 Jul 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059917; cv=none; b=sfXQomfBYCm+5/tKAmTM4JQGT1GG8Gi2ehXsdQIj9ItU+P5o6zoX63GcZ/V9anWqyXgTJS47vI/oRxYMjVuMrH85FeFm/S0jWr0jjqAvgfVTLM1fGo7TRdZ6sGssQ/kuhCe1adLgcvlvLxpuP/E33apAXJ9kPxm2KQfQD7BfGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059917; c=relaxed/simple;
	bh=lZyyMvIUs7/HjbhCjJZz0kSyihW8Dlkez71/TFQFgMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IJ5PDaWoSvLsNxjf9aKAyU1loe9I20qbvfZ5E9s3IzcT2TcEbuVNJsxN/WuCwLWGaIs4jBfpbfVCjfbA6NW1N3Ui0NLm8uiS18keEn9GZKqA7ckOU9u6Siqq72+2KEjisPGUEVJNj96XETl0dTRRD2/iRSlKAz5yA1uY+pnu424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ez/TFzue; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ez/TFzue"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FBSm1c020977;
	Mon, 15 Jul 2024 16:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lZyyMvIUs7/HjbhCjJZz0kSyihW8Dlkez71/TFQFgMc=; b=ez/TFzueq+G9FXoo
	EmcfqXge4FdmPyAKDGL1wGUtgCwl3QL5nsuJIyPK9m5rribGm2OJSMEWzS0udgo9
	H6P1ZSAu0zyjlK7Zm9Qmbxy0BYMbIyI/bVutNm+5IbxIAaXVHPJ7SvZabSgeZeuW
	RloMdNraYw5QBsKYLsp2Tn2npGEMIsKd5QaLvwA2K1BRu/SrViMfBmwwPXEmsAKl
	bX+MCGCa2Sv+WYLAzKLQ6Ou/ZHt21y7TbLxLcocxhq+W8sXqtXN2oYHPQxYExVDm
	rsn5AzCs7yYgZPykqPtFxNHMya+34wPuF+ix1+H0h3scW+pKJ4WHzC3nLFK/xIFa
	eQCzwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bgwg4qyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 16:11:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FGBktK029643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 16:11:46 GMT
Received: from [10.48.247.129] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Jul
 2024 09:11:45 -0700
Message-ID: <e02cd4c2-cee5-4f6f-8d20-6ceaa8336a84@quicinc.com>
Date: Mon, 15 Jul 2024 09:11:45 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: wuqiang.matt <wuqiang.matt@bytedance.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
 <7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
 <20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
 <3edb1529-744c-4b7a-acc9-12e166ada738@quicinc.com>
 <20240715181206.f0b6c9e6bfc548c2b729b76b@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240715181206.f0b6c9e6bfc548c2b729b76b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: O7b3mUmt5zRBPOXsfWTxH5hznJPPip-T
X-Proofpoint-ORIG-GUID: O7b3mUmt5zRBPOXsfWTxH5hznJPPip-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=238 lowpriorityscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150127

BTW I have another patch in arch/arm/probes/kprobes/test-kprobes.c

Is that one you should handle?

https://lore.kernel.org/all/20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com/

/jeff

