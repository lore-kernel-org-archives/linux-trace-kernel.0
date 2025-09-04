Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979F13D891;
	Thu,  4 Sep 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954582; cv=none; b=QuDJs3C8AgQNQIQaYZFyRbhr9JGJ5fccQ0ZWSxqjzp+RnTDTJ0vvg9zH3LtDxf0wIVJb4hq1expvKdxGeycHbYm5UnDqGrxfru9U2NQf+xQ7C4qKnoAq6l3UGXu2tbM8yUCdzXN6Rrw7q2Jxlb67L2IT/igSuwGXQw/2yqZuymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954582; c=relaxed/simple;
	bh=Ejp+lg8gINEoy0MBHN/XIRMKOlDhM8ESEDoQsLHHuA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+LqqYPxBs1ylhn67+bqr6BJaiyzwDdCGKkH7c4fOmiBGBYRCl5Np6lUrLjA0/mNBkcJy8udLQNoHZ+4kwagudK4058J2FEjAlhllAMCl2Bv2D2VtR8zxkIHJnDbjHhMpWycPZr7uIk6cqmlJSpN/hxmLAuULV9lNj/KmmqP8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O59jBCvF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O59jBCvF"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5841FwwQ005260;
	Thu, 4 Sep 2025 02:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ejp+lg8gINEoy0MBHN/XIRMKOlDhM8ESEDoQsLHHuA8=; b=O59jBCvF2ICqwLVb
	t9JaKEau+qXN/urYCuizrLjH0cquYodbZ08tsTDBmhbP+NI1iub+F2Gi/wihg6DQ
	Ouk76+rDehwe5o2iEyrd/Kcr+nsL0Rovix7yfWi7MW0A2ZbnDuR5KMUkflgf5ov4
	x3SWws06tAR+aLGFZXxZPQ4vwQLARDwSFjunhQVZXuaV070xPi/MOh3jPpCvFMfe
	3sMPSNJgCUFmPQLpTKtIDkUl/8THKrRMyvIwSezyDxYo5fRlEfE7t4aXagchYHeb
	X7S4WB60lMRRdWQCvLB3CHvO4YNsOjzlCAk4ZdQAX0Sj6VQJELk3yRrcUGZ4Tofp
	AEXrrw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjnvcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 02:56:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5842u8vi021511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Sep 2025 02:56:08 GMT
Received: from hu-panfan-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 3 Sep 2025 19:56:08 -0700
From: panfan <panfan@qti.qualcomm.com>
To: <panfan@qti.qualcomm.com>, <mhiramat@kernel.org>, <rostedt@goodmis.org>
CC: <ardb@kernel.org>, <catalin.marinas@arm.com>, <dylanbhatch@google.com>,
        <kdong@qti.qualcomm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <samitolvanen@google.com>, <song@kernel.org>,
        <will@kernel.org>
Subject: Re: [PATCH v1] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Wed, 3 Sep 2025 19:55:57 -0700
Message-ID: <20250904025557.2002080-1-panfan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819063418.1263119-1-panfan@qti.qualcomm.com>
References: <20250819063418.1263119-1-panfan@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b8ffc9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=yJojWOMRYYMA:10 a=S8iKQRKk4SiPzSIsZgUA:9
X-Proofpoint-GUID: MGCDhHIdEi94weTppguHRSFxRXu0UO34
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXxykn31WwF5h0
 FUssFX1Pg6Fo28epVw+3FvxOHMOpZE7PyeCJkkBjMGcRe7isd9U/lK639lhTWvZkMmCDkzppAZ5
 2j7UyBXPeJccIAlKx99ulwOvjP3quTK7K3OCIQXPPKX9dn99Hswu1cRbqXQDQ4B6+T+ERCvaddp
 eFNva7nxgEs82Dc/6Xljs0hgHLWlIdA25fERApygYjNOjE0pOXjqAWRZDoOR8Vskvc3qY5ePQEs
 I/3sAnxSjODNHJJM4tLqRtc7Beo6pD0BnF+fJX3GO8dPSr8QjM8lB1hbep0JDxtVtxBiMlxvvSz
 q8NKh/QFd8UlxLyQt0RRAyp8CK/QcawAwcg2Yp/1gcMsmHj3vnm0gm5C1aQijTZuOfdWGHEpEbB
 JENVi0VP
X-Proofpoint-ORIG-GUID: MGCDhHIdEi94weTppguHRSFxRXu0UO34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Hi all,

Just following up on this patch. Any feedback would be greatly appreciated.

Thanks for your time!

Best regards,
Pan Fan
