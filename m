Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715F2EDD75;
	Tue,  9 Sep 2025 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393815; cv=none; b=bRq39rFh3jcrKazDVfjQXmO6UEvvJnGAt3lwCc01camIm53mlCWnCvTqiMNW8fOjLyjiJ3h4IkTbqcZi6OFYXZ+bm5iQ3l+BgO+VqsymgKnsz+h/U3TDigEq6+SdumQOQ/7COdQ84e+UJn01uA0Dg1f7VrUv8z7aAKqVeIvsm+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393815; c=relaxed/simple;
	bh=/HyIIgPLZb50eZ5QZHtehqP4UA9+BRMtPUQfqVLuSf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sByqPh/9ATRDcXt0C5Af/YmgcGw9cmSMTsJ5VV/AbdHti3oZkPdR5OVPmQHhSA3J5r2K2HYWBhufT9FDG0i0E9x0QWzWCLLFz0AYYjLz1thv6ImQtklnk5WmKu3FSAgHT5DZsjbnYVSw5o24/qDlMnyDBmrML0wEX/dj26iSQws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/j7Vd33; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/j7Vd33"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Kb7hs006132;
	Tue, 9 Sep 2025 04:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ege0PpU3PXIxwrWk6
	aL4+g/xV/+bR77zChowZVDxpLc=; b=q/j7Vd33laRvAxz7z1/ccAMY/UdBTSQ1/
	YJ7LmDdeZwSbgfwu8xdCMRagg/TKoSOGU+7ymD+jhMrBJgzg7bfpDN5mYeUNJrKA
	aMYqRB0YIYP4CDtIbG6rQ2fUUfuRMXuE1wPqLrdC3d+9YJoEaFSM/1d7P84f4bo7
	K0+MGdwkp9jMyFP72CFkLDD56rL5Lq0lcmN7EF8/h98r47GQMbNQaD7qQp2lDjuu
	tmFFLn7KF20eEiQI+LhhVtCC4RH2/gBs9fIWYYbkXZK4F4MnZ7KUU3BC7ga0rxTG
	I5gordvQwD8WHosPXP6KJ3IhAIZwPuu44C3DC7nYTtrcPwr4F2oxQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwnfpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 04:56:37 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5894nhIc006175;
	Tue, 9 Sep 2025 04:56:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwnfpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 04:56:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58936HMS017187;
	Tue, 9 Sep 2025 04:56:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gm951q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 04:56:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5894uTGJ44630384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 04:56:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E8282004B;
	Tue,  9 Sep 2025 04:56:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97F0220043;
	Tue,  9 Sep 2025 04:56:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.199.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 04:56:26 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Bodkhe <aditya.b1@linux.ibm.com>
Subject: [PATCH v3 2/2] powerpc/fprobe: fix updated fprobe for function-graph tracer
Date: Tue,  9 Sep 2025 10:26:15 +0530
Message-ID: <20250909045615.50251-2-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250909045615.50251-1-adityab1@linux.ibm.com>
References: <20250909045615.50251-1-adityab1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _fmrD5P7y9BGUtXruOOdD691ezopI8kR
X-Proofpoint-ORIG-GUID: 1iBxPOlWrYefmL6pjBeK0-NJscggtXjP
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bfb385 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=eJdZZeSqwtc_5qrUTOUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxHtI/Gq4Wm9o
 7bxqYB2xPdblwqi0ddwZFIqChhi3UvogGertggcswaQIDc/NUbgod491S3l8f/WdNwmVKM7C97r
 tNjUwMaOz3zI8EBCM+Dha5031FYW1JO/WZ+a2rpYh5mZ0qKd5+BHWnWAUDLOWaw3HrpZIRt49Fj
 gARCRi+XzViEf+zQa3aqwAxJXYrRxVJYPLPx4d5l2X2evufjJuOb35MYLOjAsIBPS+6K0QNQ6UJ
 JpPPv+TcijZoP7hHpWCfSmk2J1wicmkX9Ev1s5qd3BqNyDLg6bv4Jpf7viLD7cW3B7MM9RvgopT
 eZfO8WcmUM2w0vcF47Swe+t+1yl1GKfOvGbb0hX8kLS/MhsN0uPYxfjmn64AlJMrwnqb2/RG0VH
 wYIqtsxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

From: Hari Bathini <hbathini@linux.ibm.com>

Since commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
tracer"), FPROBE depends on HAVE_FUNCTION_GRAPH_FREGS. With previous
patch adding HAVE_FUNCTION_GRAPH_FREGS for powerpc, FPROBE can be
enabled on powerpc. But with the commit b5fa903b7f7c ("fprobe: Add
fprobe_header encoding feature"), asm/fprobe.h header is needed to
define arch dependent encode/decode macros. The fprobe header MSB
pattern on powerpc is not 0xf. So, define FPROBE_HEADER_MSB_PATTERN
expected on powerpc.

Also, commit 762abbc0d09f ("fprobe: Use ftrace_regs in fprobe exit
handler") introduced HAVE_FTRACE_REGS_HAVING_PT_REGS for archs that
have pt_regs in ftrace_regs. Advertise that on powerpc to reuse
common definitions like ftrace_partial_regs().

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/fprobe.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/powerpc/include/asm/fprobe.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 451d0e140051..35d32cc43255 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -243,6 +243,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
+	select HAVE_FTRACE_REGS_HAVING_PT_REGS
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/powerpc/include/asm/fprobe.h b/arch/powerpc/include/asm/fprobe.h
new file mode 100644
index 000000000000..d64bc28fb3d3
--- /dev/null
+++ b/arch/powerpc/include/asm/fprobe.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_PPC_FPROBE_H
+#define _ASM_PPC_FPROBE_H
+
+#include <asm-generic/fprobe.h>
+
+#ifdef CONFIG_64BIT
+#undef FPROBE_HEADER_MSB_PATTERN
+#define FPROBE_HEADER_MSB_PATTERN	(PAGE_OFFSET & ~FPROBE_HEADER_MSB_MASK)
+#endif
+
+#endif /* _ASM_PPC_FPROBE_H */
-- 
2.51.0

