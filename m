Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDF17FF;
	Sun,  2 Jun 2024 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291932; cv=none; b=naKw/wiG4yk6DlNcSLUxSh3NY9p4EGcm9edcRhblvRK09J8kQ2DfG9wH2vhqG8pVkwzeMh2mbePzCqTCXeayxjYJVECHDfF2F1YCOhBZlVAdVMmoPUNNao36ERtCoS1Nbmwb3hYhzcQ55qYf2MX8G4zglGJZh9EW8k+FvX8TMLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291932; c=relaxed/simple;
	bh=mT+6nJ8FcVSsFnNcnZugIXFAnJtFvgLnp40V97LZUMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ie/8BwUIiRUEeAlDZQwoCUK/IOXnJlXr8zcpj13yJ7W2hHJIhWEGV06ipz/sB2EsQbrW8aOo8Kf3f5KqjXtM/sHqQP/NSR6kX2VxfbwEM0ixjJ79Z0Z5rT7y8cwRcpP+NY+738ykHmRP1VOEmZy+SInoR7rWeLNRo9rOXqMYFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C3m+Z6mf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C3m+Z6mf"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4521Ra3Y032528;
	Sun, 2 Jun 2024 01:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jeGhGowDT5KeLSUfSBOevN
	8jGK6lhtgn0lpn7jZgyYQ=; b=C3m+Z6mfHp7eOK3uWt+c0wanTrerRf1BZ1XFge
	OaRQIUj9RBeAja8ly7jsveNZHJTApUFsFKDkR+Am01HGKytZHy0nThlF828qTQ+S
	07hyntTgJCn/2JZ0XKnukbQHpKvyQOxeIDuNUuRa6KVAvcNxJXdka7SghW1gsNfe
	4D91Iga9jCLwIgMa6R1fXDM1MANNOS2TntfXhgiPjTYOagTyqR8MVjyZTvn+VasJ
	hrYS0ZjuCuVwtk8jgwP5MGCU8le1KLvN+b1JSAv7lLZOADfbV3NsSGxZpXaOBimJ
	Vx9t95YrRLkrH3iyRIJaubG/oCFABczHHkEEZ0XzQOKyKjRw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4d1hdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 01:31:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4521Vtc5007563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 01:31:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 18:31:55 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 18:31:55 -0700
Subject: [PATCH] samples: kprobes: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-samples-kprobes-v1-1-b6a772353893@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIrLW2YC/x3MywrCQAyF4VcpWRuYjkXEVxEXc0ltsDMdEpVC6
 bs3ujp8i/NvoCRMCrduA6EvKy/V0J86SFOoT0LOZvDOD+7ieiwZNZQ2k+KryRJtaYxnn2JK15z
 Bjk1o5PUfvT/MMShhlFDT9EvNXD8rlqBvEtj3AzrptdGDAAAA
To: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy
	<anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I1V2_EoRLvh0-cLZFrtMsUtLri_B_7eJ
X-Proofpoint-GUID: I1V2_EoRLvh0-cLZFrtMsUtLri_B_7eJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020011

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kprobe_example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kprobes/kretprobe_example.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 samples/kprobes/kprobe_example.c    | 1 +
 samples/kprobes/kretprobe_example.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index ef44c614c6d9..53ec6c8b8c40 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -125,4 +125,5 @@ static void __exit kprobe_exit(void)
 
 module_init(kprobe_init)
 module_exit(kprobe_exit)
+MODULE_DESCRIPTION("sample kernel module showing the use of kprobes");
 MODULE_LICENSE("GPL");
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index ed79fd3d48fb..65d6dcafd742 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -104,4 +104,5 @@ static void __exit kretprobe_exit(void)
 
 module_init(kretprobe_init)
 module_exit(kretprobe_exit)
+MODULE_DESCRIPTION("sample kernel module showing the use of return probes");
 MODULE_LICENSE("GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-samples-kprobes-efb32cbcc8dd

