Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81111C27;
	Fri,  5 Sep 2025 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043264; cv=none; b=P13fOsaKWNbJyiOhjecRn8ji2VeWH9AVeRGN0z4hT/sPW8t1aU/A7ye53KZktJRQ+nhi4K0fuoRiUA4YpTVSS6xn+0vY6FT1CE2lP1tQ8JZ6uvGPJ+SjTYZD9hmyO8dcCEGqtKLQgDzP3yFcVeh8laPvjgtaJVd97hP37KezYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043264; c=relaxed/simple;
	bh=bg9B2eeRJo3gUlWIVEoP03Qfn9/40VtBXttXUotEDb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We4CJTSEjVEhh9aavSS32T/3ooMJu9HjRNYomAGlfH3KQ0U5n1osNLvhd6aRU52uIeGDRiPcT77BHhZUNEKi3Cc1OJ1HOJN1XSxQeAn3navK/qMqWkoJtjxim9HhscvMYku1VlFc5Yt2TCK01R92BdWXvod4+icx8QxoE9yS3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TKrcZdo0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TKrcZdo0"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584JA1C5031806;
	Fri, 5 Sep 2025 03:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JpuyT/5XEpYp3ndZ4kv1I9X8npAH/eSsVWL2KX4ktNI=; b=TKrcZdo00DSshiNA
	0dwjXllg43qgxRjxBQRs7YSdHIkhCjGdrI+mko1XxgCHQ6Ccp4H1tlT1zOuDa/ok
	SWD3s0y4Pqvi/42GtiaR35DmYtBYNW5JcqgjL3yu83ZjoI0idy6SNSV+RwKV8Uu6
	Wkd+FuAGlw17Uy4nS7pIMCGo8ioPnqEHzbNB1MkmQV6PscBrJIpWBVeGzcCHoAWS
	pzYMWrmeAD6DuksQRdGGEnnjK+H2NYmpDSVn//tA/nIC39xA3nUsXwHdyFxxHsZe
	IAxgHcLRUuRtVcd9srb2+rHfdLKLN3N65jT/NPFQEgWcr3gotiJkqT7YpggPS+K9
	kE91VQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw09r6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 03:34:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5853YBL5012620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 03:34:11 GMT
Received: from hu-panfan-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 4 Sep 2025 20:34:10 -0700
From: panfan <panfan@qti.qualcomm.com>
To: <mark.rutland@arm.com>
CC: <ardb@kernel.org>, <catalin.marinas@arm.com>, <dylanbhatch@google.com>,
        <kdong@qti.qualcomm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <mhiramat@kernel.org>, <panfan@qti.qualcomm.com>,
        <rostedt@goodmis.org>, <samitolvanen@google.com>, <song@kernel.org>,
        <will@kernel.org>
Subject: Re: [PATCH v1] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Thu, 4 Sep 2025 20:34:00 -0700
Message-ID: <20250905033400.3223310-1-panfan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aLnLpArhiT-mQxn9@J2N7QTR9R3>
References: <aLnLpArhiT-mQxn9@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -nGpMRxczFvANa0QEIhaqcP3dSibql49
X-Proofpoint-ORIG-GUID: -nGpMRxczFvANa0QEIhaqcP3dSibql49
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX5fEsYrnRho3S
 o4Pi+LhZFvauQW2USB8/LkFfz1t4j//E3zUe1hTM9FDdUwbXsEimtRuadlPCwhx0LLqwYATsLXI
 hTxSheKEFaDYLweuJOY1g4DqVUilKDiYr7FArQatpWag+fm8TTJ73udnY2A6I+eV0iHooJ7yQYg
 ZvmIXziDqk7TukQE417FbaIQh6hHsP3Gd+cX4KoTl+Evi6A47NY6X0ZxWUd0p0usMZ9Rg7Ae/al
 fEEgyxaR1C0TBImiVKN7ZGVHQWiE8vw0sHqRDdUjgxHvZz31YonS39v7oxeLznAvg//LWK+jCMq
 G7sq+4/FjAeOO6Bf0KnKLYV0s/S12PE7X8oVU6o3a4WdxcK78e+SYV0FOHdnzOeQw2p4MF+rUWO
 K6Bef+tm
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68ba5a34 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1vadqSz47zZtUf88aekA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mark,

Thank you for the review and ACK.

I’ve addressed the comment by adding an explicit check to ensure the
address is within MOD_INIT_TEXT or MOD_TEXT, and sent a new revision:

[PATCH v2] arm64: ftrace: fix unreachable PLT for ftrace_caller in
 init_module with CONFIG_DYNAMIC_FTRACE

Link: https://lore.kernel.org/all/20250905032236.3220885-1-panfan@qti.qualcomm.com/   # v2

Please let me know if anything else is needed.

Best regards,
Pan Fan
