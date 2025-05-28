Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97E3D561;
	Wed, 28 May 2025 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440143; cv=none; b=V6TWQUPF99EHGa1ty0+DjhxsHIvZqiO9F3kWzS9P9Hnobn27Yx3cE1Bhn1nSRlicEiQjdO9jAj6f/hhJuRYq1M5PPil04gjddCKCfmMyVttZ0UQMZsWQtNMdw/zVR2XPPf04khKY2j5nZYwQwSN1f5HsGoGLVrzcYT1zruHKBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440143; c=relaxed/simple;
	bh=U3Zeg461BcQ45bSY3V6xOeWA6myBDPj8t0xHlLX5S68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MahCOx6GAZNuTCw25MvA6GLMwmbQ7xag2ZAq2h7jPsu+4J7wcfxxB0bVr7CnoH77Pq672W0AN4oXvsGuMKlePcX1RGIBDe7UBvfNXmO5q0ELUnq84K6j+QMYayVWIQOoFqR+HDM9C+7cNs5aoyTTNP3cLmh3NKvskMLQ1ybmhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GLxs0TxI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GLxs0TxI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5ZFbb007498;
	Wed, 28 May 2025 13:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=d39gSKHNC284284u0Og7cE96FODSGufXxda6EnOsZ
	O8=; b=GLxs0TxI4I7EX+bqm08L8v4oyGatExbpAlP7pKDWFxeavgqismlzzE2LP
	/TwG0lN3i/n/c2QSMNhnz80BHmukaYrs+wjYqozL75mxdzE1wKvOmZQVOSMfzQ4W
	RaO50Klngr3HXdtvw/WYLx33e0mbvOpio7hDJAuJEofkvFn0xyk1Wu5tzi4hpJWa
	mCDEIq+GKD55etFGFnHmdVFHSKS34WwEBz3QkiFyz53S22uFSXBubezCNXAVXgEc
	+4kEhIwHxOT4Hcn6XOw6GtzG5SaI8AhkrZWXuyKyDITclheGQTHbcNmjSI1qBrj3
	0EKwEGxiM9YvN7vgNSX5oKLiVl8pQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb27sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:48:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SDdMRb003075;
	Wed, 28 May 2025 13:48:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb27sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:48:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAl0Vf016202;
	Wed, 28 May 2025 13:48:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0qu3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 13:48:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SDmWaO36372936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 13:48:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7764920040;
	Wed, 28 May 2025 13:48:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C5F320063;
	Wed, 28 May 2025 13:48:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.74.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 May 2025 13:48:27 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, Aditya Bodkhe <aditya.b1@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
Date: Wed, 28 May 2025 19:18:19 +0530
Message-Id: <20250528134820.74121-1-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExOSBTYWx0ZWRfX+pg/+IcbRaFj oXqbKnTslzKV8Q6pwrBpAR5KSCLy6q2zhvYupIc/UDOSiV9tVKqM9g/GqwuOySPWrLcy89AfaL8 eVneIkEV3Y5w/3pfRU4NnQE3zIqKA1lVhKcAs6PlYLp4Fyi8dlvG3/Zu4JIXYS+dRnZVOtzvlMX
 +6jdZd/xGiWr+N9OjnUO3ccuQG0kNP8AaWlLTa+3grfNmYNKdAHxtnbWU6D28L6Ml9UQZbY0CAt onwUwrpSQuYrqRLsTITnX3w07t0M34M2kHxqiDIycdHW7Art1G0aRdSWNrghuM4wRyoROg1vn/8 JTg3ASbKR+XIsOm4PLjOOhLmRL2q/3BFhdhejx9ntjX3DkkdN2iWUAjTLfYVQPAEDpu2imkDyQx
 RPE35R0pHKmstvSNhzk+VSTRoXaiW+Mat9zsOmj+aRHHKnU2ZJpifO4i6bRNVoj6adk1L4dT
X-Proofpoint-ORIG-GUID: KKO0TYATbZexYmOzXBgc018ZPDY4dIDL
X-Authority-Analysis: v=2.4 cv=bt5MBFai c=1 sm=1 tr=0 ts=68371438 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=f-JPSP1mq3vSRxYuwIAA:9
X-Proofpoint-GUID: uTXIcz3ei5cApGLwxDGX-hcXMplvJDKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280119

From: Aditya Bodkhe <aditya.b1@linux.ibm.com>

commit a1be9ccc57f0 ("function_graph: Support recording and printing the
return value of function") introduced support for function graph return
value tracing.

Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
ftrace_regs") further refactored and optimized the implementation,
making `struct fgraph_ret_regs` unnecessary.

This patch enables the above modifications for powerpc64, ensuring that
function graph return value tracing is available on this architecture.

After this patch, v6.14+ kernel can also be built with FPROBE on powerpc
but there are a few other build and runtime dependencies for FPROBE to
work properly. The next patch addresses them.

Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
---
 arch/powerpc/Kconfig                     |  1 +
 arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
 arch/powerpc/kernel/trace/ftrace_entry.S | 41 ++++++++++++++----------
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c3e0cc83f120..9163521bc4b9 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -250,6 +250,7 @@ config PPC
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_DESCRIPTORS	if PPC64_ELF_ABI_V1
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 82da7c7a1d12..6ffc9c9cf4e3 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -50,6 +50,21 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 		asm volatile("mfmsr %0" : "=r" ((_regs)->msr));	\
 	} while (0)
 
+#undef ftrace_regs_get_return_value
+static __always_inline unsigned long
+ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->regs.gpr[3];
+}
+#define ftrace_regs_get_return_value ftrace_regs_get_return_value
+
+#undef ftrace_regs_get_frame_pointer
+static __always_inline unsigned long
+ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
+{
+	return arch_ftrace_regs(fregs)->regs.gpr[1];
+}
+
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 3565c67fc638..eafbfb7584ed 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -409,23 +409,30 @@ EXPORT_SYMBOL(_mcount)
 _GLOBAL(return_to_handler)
 	/* need to save return values */
 #ifdef CONFIG_PPC64
-	std	r4,  -32(r1)
-	std	r3,  -24(r1)
+	stdu	r1, -SWITCH_FRAME_SIZE(r1)
+	std	r4, GPR4(r1)
+	std	r3, GPR3(r1)
+  /* Save previous stack pointer (r1) */
+	addi	r3, r1, SWITCH_FRAME_SIZE
+	std	r3, GPR1(r1)
 	/* save TOC */
-	std	r2,  -16(r1)
-	std	r31, -8(r1)
+	std	r2,  24(r1)
+	std	r31, 32(r1)
 	mr	r31, r1
-	stdu	r1, -112(r1)
-
+  /* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
+	addi	r3,  r1, STACK_INT_FRAME_REGS
 	/*
 	 * We might be called from a module.
 	 * Switch to our TOC to run inside the core kernel.
 	 */
 	LOAD_PACA_TOC()
 #else
-	stwu	r1, -16(r1)
-	stw	r3, 8(r1)
-	stw	r4, 12(r1)
+	stwu	r1, -SWITCH_FRAME_SIZE(r1)
+	stw	r4, GPR4(r1)
+	stw	r3, GPR3(r1)
+	addi	r3, r1, SWITCH_FRAME_SIZE
+	stw	r3, GPR1(r1)
+	addi	r3, r1, STACK_INT_FRAME_REGS
 #endif
 
 	bl	ftrace_return_to_handler
@@ -435,15 +442,15 @@ _GLOBAL(return_to_handler)
 	mtlr	r3
 
 #ifdef CONFIG_PPC64
-	ld	r1, 0(r1)
-	ld	r4,  -32(r1)
-	ld	r3,  -24(r1)
-	ld	r2,  -16(r1)
-	ld	r31, -8(r1)
+	ld	r4,  GPR4(r1)
+	ld	r3,  GPR3(r1)
+	ld	r2,  24(r1)
+	ld	r31, 32(r1)
+	ld	r1,  0(r1)
 #else
-	lwz	r3, 8(r1)
-	lwz	r4, 12(r1)
-	addi	r1, r1, 16
+	lwz	r3, GPR3(r1)
+	lwz	r4, GPR4(r1)
+	addi	r1, r1, SWITCH_FRAME_SIZE
 #endif
 
 	/* Jump back to real return address */
-- 
2.43.5

