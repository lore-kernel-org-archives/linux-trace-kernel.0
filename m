Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C982BB10;
	Sat, 18 May 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716072911; cv=none; b=s6Sp5yK8cgeFUpiiwCcYoZc7Z3zrKjgU2VvHBvvKtB0m32/N0ipGx4pOrPHDKGHbsXS1yYnxI1np7T1bcfYz2qba75lv1esMZqIf8bHvJCt7I29Nmo9hbiPsV038kGijE6RZLcn65q2DZLk6tT5y2WjfPvcKi+BFwZmb8SWGWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716072911; c=relaxed/simple;
	bh=98IygC4khSqKvEBhieD52/i22F2Y9A/DR7XbipdVTMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=LkeCKOAYTWrPWf5DjMrWuivSv5qveyB3gP2rCxCmBN4nD5KLDt27rprhLIITjNUEvZMOaFdzGmsF8Hzb+Maw9+kGwyR4/WYHNDcwGkfewKl4vM1BRbcrBIAX8SLGVtDF/y67VJq2tVf+f5WCZUeP4xoyJN/AGWEWOfavYOnExZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ti0wqi7F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ti0wqi7F"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44IMCsK2021616;
	Sat, 18 May 2024 22:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=Whq
	QZT4PPzNDsGPrsaCNycZblGRyU4ILpoVivlMXHdk=; b=Ti0wqi7FagM3B9ZZBEd
	0xQiWtmDHyvWVJD4wCxyg/xcPjBr40bBMVE1Ghdnt5kW8fhyZVcoB+bACSEaUzMh
	nnejnYf0+3mhEMaxoFb+QwdLCQRPZ6WJAiy3cMuRBRJ3q38GjVIsiF7ZeV86jNZ7
	pXQZYuA8CQR0nfLrkrnez6ijXSTm3xLRP90bdNOh9YPWPJgh4REb7Hz3VfFU0FqN
	TQmpJvaKcfaPS+QTUME0dxCR/3TVJTyoTX54G/ZUH53XOGvtvQ2bQ0tiYAOJTVxI
	YobA3hFKhDUE4HrrEeonR5V6AsR53Q1XsObsJubyE+vQ5zIMnknlz9lb9+RR6R/j
	TCw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6pqagsbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 22:54:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44IMsq83008999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 22:54:52 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 May
 2024 15:54:51 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 18 May 2024 15:54:49 -0700
Subject: [PATCH] kernel: trace: preemptirq_delay_test: add
 MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-md-preemptirq_delay_test-v1-1-387d11b30d85@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALgxSWYC/x2MWwrCMBAAr1L224U0GBSvIlLyWO1CE2s2Skvp3
 V39HJiZDYQqk8Cl26DSh4WfRaE/dBBHXx6EnJTBGns0rj9jTjhXojw3rq8h0eTXoZE0dM7GZA2
 dggmguVp3Xv7r6005eCEM1Zc4/oYTl/eC2UujivOqKuz7F/2uGOWPAAAA
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
	<mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EsjHL1m0pHSYB64VXjx8BHz4fim6lQWh
X-Proofpoint-ORIG-GUID: EsjHL1m0pHSYB64VXjx8BHz4fim6lQWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=895 clxscore=1015
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405180188

Fix the 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/trace/preemptirq_delay_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/trace/preemptirq_delay_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 8c4ffd076162..cb0871fbdb07 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -215,4 +215,5 @@ static void __exit preemptirq_delay_exit(void)
 
 module_init(preemptirq_delay_init)
 module_exit(preemptirq_delay_exit)
+MODULE_DESCRIPTION("Preempt / IRQ disable delay thread to test latency tracers");
 MODULE_LICENSE("GPL v2");

---
base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
change-id: 20240518-md-preemptirq_delay_test-552cd20e7b0b

