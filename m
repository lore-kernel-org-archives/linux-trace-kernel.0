Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA62798EA;
	Mon,  7 Jul 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875353; cv=none; b=D7xULisZ/02+Kj0BY+EcvuRbqrrM01xwfmfSag0st+DIlM9Ij2tLWU8+IAf+Zd2mDfSqvCjtmo5vzeWQd01hxenWJr0KVySUbo8hS7tQzfv2CKca2fFdaWGIdWeucSmKxl0n1Nkkp5oAOcvUpjnWX5buqharYuVq/U0Vo50i+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875353; c=relaxed/simple;
	bh=lARdiQiADgYgkEt5lX0u1z/fVTK6JG75XBExtSpj7e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwefKFmL58xN3e2+A0Yk58v4y9NNKFaZZwuHOBUqUbH9G9PhdAuwyWWQk2bT6NiZD9NAbvidKvh/sUXZbSuNeEF1Q3P9E2aD0r2tSIyG7F5wm9o1MqXMYxM0xkusEXOk7ynhbDZyZbh1k6TmpBas6Yf22gwUhqleLMxIlJbe4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jb3BXnqx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jb3BXnqx"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566ElGFi026476;
	Mon, 7 Jul 2025 08:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vmhU+FR2k26av2hIZ
	iV+NNFmRQFDTiIkuVxAjb0IsSQ=; b=jb3BXnqxVUicitAdHvgfSUqNzpKpMXj6b
	+C6FeogoxevXVHbac2rL5KiC+LG2JNGbiKSJAQ6exqPhU71fm4MmpzRwKDlAU21g
	p4LutUUXAsfcB/wgfLC1cJ+hltNPcpYdJki+ZUrni+xgw6yM0H5YaYNw7nPWKKdE
	YptVQbqscHjUk1TJrfPnQMJogWkCmWztK8t5trQgHpT/IHCkw5mdreNUupeiBqK7
	R+4ma7jywF2VWlrtYVrPRQLPHgTGBO42kX0wZLQrdLbji0X/hbUD/UdAFqWOAyVJ
	JLZKrXMTW/BS8UQ7TcBzBSlO2bRoqfn+u09RES7/YsJwXYwZzc44w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusrr8sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 08:02:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5677mxpO004028;
	Mon, 7 Jul 2025 08:02:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pusrr8sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 08:02:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5674OPID025528;
	Mon, 7 Jul 2025 08:02:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcnw4kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 08:02:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56782BNX60359056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 08:02:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8412004B;
	Mon,  7 Jul 2025 08:02:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CED2004D;
	Mon,  7 Jul 2025 08:02:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.94.242])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 08:02:08 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Bodkhe <adityab1@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/fprobe: fix updated fprobe for function-graph tracer
Date: Mon,  7 Jul 2025 13:31:56 +0530
Message-ID: <20250707080156.64874-2-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707080156.64874-1-adityab1@linux.ibm.com>
References: <20250707080156.64874-1-adityab1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686b7f08 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=eJdZZeSqwtc_5qrUTOUA:9
X-Proofpoint-GUID: ATgY4xVqoYy0zFQSa2JxU8rxQcmuDFq3
X-Proofpoint-ORIG-GUID: _GclW8kBloXE7CtCBkTpiYDakd8G5Bsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0NCBTYWx0ZWRfX45WWdWiqH+H6 zsEF8g73Ft4aEfhHN2VazVV1jF6hsvDjS3v5B4BiN0/lTYWWqhhHhBhH8OrasTEcVWuUoIwT69c HGauyyVa2URH8NGWcDzv3UoaqI9RP5GABTxxHuv9iUshGWlVWiLhLCbTthzVkjyeD8uZi+hH7ak
 Pg7cYSnEcbdhBherRwW5Pb8bwrXU7fRgpO9ED3YcnMcE3hFghdms5kAsORKC33M7VVUclENsb++ 9/XNHkKmw7sqvvyshmRDMFzuD8Rtm3BVOAlMCBSVPxzlTKFIYar3VOh4CeXqgMa7C9lLltps0yV I3Jx0TAlirwCV1Lu3SYlxZz9mM3EIP3H9VSG6CopYdNi40WGE56BDPZuTlSMWRP+K4dLLkmRCcJ
 B5lt/hC5/KqCIZEWW7Y7h9bv+Lzf9/7y8npoHhZZDA37SblU+KW6s9O02ZcvlZI0uE9WzW/T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=606 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070044

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

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/fprobe.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100644 arch/powerpc/include/asm/fprobe.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9163521bc4b9..2203e4fb64c1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -246,6 +246,7 @@ config PPC
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
+	select HAVE_FTRACE_REGS_HAVING_PT_REGS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
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
2.50.0

