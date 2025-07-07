Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A419DF48;
	Mon,  7 Jul 2025 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872751; cv=none; b=ipvVMlwKuJ81SNpKufde0BeueOVmXBkPnIJKKRIZ+6GOQBPLoZ3k6J0zjQwGcvz0NqSbwZjLqkdl9KqGRjUTwP64BzKDXomQC5dsj0yaPmKmFADT73GP7S+5LZbf8F0+MJfREByjKSZuY7Zkq6K84OAh9k7KukDwrbRjJ3AeTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872751; c=relaxed/simple;
	bh=lARdiQiADgYgkEt5lX0u1z/fVTK6JG75XBExtSpj7e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzNdqMd9Iyq65hEqjrV1XfkyH6URlDTIIVDpSHsoyj48n7BLako2pSrcw7MGrTJKIhBZMa9lMQ4X3+DMYwG/VOS48vwNi7A750yexMZ1fihecn2Uyqvs3fqZaYveLEOcowx3YfaavGCYnFfFWJgrwGubxDLkjznW/qbVPOL5cIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KOguK/hh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KOguK/hh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5671viqg005853;
	Mon, 7 Jul 2025 07:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vmhU+FR2k26av2hIZ
	iV+NNFmRQFDTiIkuVxAjb0IsSQ=; b=KOguK/hhV7beF5WHCKuHYdwqsx0xNzVEn
	M3iOkRnzwgIZwZ+fqFoc0sqOZrdV5DCNCs9byC5AAw3OvCK5abfo9xeElI1g5S7b
	DYcqaZfxu1rgTsAAOBgY4gmOS+RO5CLmUy516L0Lb5igSlkfXvs8k6royznM7cJH
	tAhf6CYS84i9rcET1uQjsOEICSns4qnIc0NzeCLq++r3sOPobXw/2z/8rUhBaGyn
	+UDTvs1pCvO0S/YlfRqNt58RDfDZtiWU51OhEgR6B08p1Yq0I4l5aWl9Aj91Hr6N
	iEjmzcrLZJZWuY6dEeGUCrRu0w1GjjEdJYEpU480uyBlTHyafS1vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqqs1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:18:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5677HAsm028374;
	Mon, 7 Jul 2025 07:18:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjqqs17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:18:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5673quZP010918;
	Mon, 7 Jul 2025 07:18:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qeryw3rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:18:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5677Ilvh49283496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 07:18:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A0982004D;
	Mon,  7 Jul 2025 07:18:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4583C2004B;
	Mon,  7 Jul 2025 07:18:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.94.242])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 07:18:45 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Bodkhe <adityab1@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/fprobe: fix updated fprobe for function-graph tracer
Date: Mon,  7 Jul 2025 12:48:37 +0530
Message-ID: <20250707071837.59753-2-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707071837.59753-1-adityab1@linux.ibm.com>
References: <20250707071837.59753-1-adityab1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=686b74dc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=eJdZZeSqwtc_5qrUTOUA:9
X-Proofpoint-ORIG-GUID: rSGRk3kl0fZ0FeTzlLgvd7xDo42pBiA2
X-Proofpoint-GUID: E8xp5ao3WglrIsD1bmqhqvgHIAOPqvCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0MSBTYWx0ZWRfX2BK1ml4nEek3 woN8RTVus9mXktBP5ZuLcrIFKyl1SgO6wH8UDMdbQ7v9ySrIq4r/TM2vZlHiFhpT61bAReeCc6f vHl5UU5ebUeSFWyd8LEGBxJ9VTmTISKpnqnghtlY1s6eYcZkWt6fvCmf1zUgLvu3ilD3lgXPVlf
 hNPFiMKnKji0O4uy7lrVroBXCFez9JgLSq7lvOo4vaVxI2hlvE07cjMxj72ypacUku1VMx1ZvxT /MTMrYDtoQWlFCTETbGpsMirOINYOP0P12C5qtNq3ZZkt8WccLDzaGfBVoz9BSYsKv3D7rpWXop olTZcsVait1y2l+wzNWMs7nZHa1x5sYU2MD5a5kA2qBHPNuUlktQe/4U9I1D4e6DOaQr+lHaG1P
 94SAgyNI7Hxyw4l2CR0Tkv7o4bepfJyv3jisCDjT63aZg7gjlc83bmgEvMLqYBXsva6X5NH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=606
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070041

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

