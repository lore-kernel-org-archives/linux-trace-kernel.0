Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C928A1E2;
	Tue, 22 Jul 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174641; cv=none; b=qOLh5ogDtgIj6bY61Lu9D1LQKGeyLhfWBdMoXlyijBmLuPZ6IERyKox6vBRsXjnDSGEUUvhTMvEIitE38vNQoWL8g/7UwqrbJDr/lm03HnSs2PDFJp9izPecvBsPYlnfn0+fGVgofP39ieoWh503Gyai2UdpaAkzoawbdpVfBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174641; c=relaxed/simple;
	bh=avzYwl1D5htWnomlWCZICjt56o3BYr/mQ6uyDMa1Rw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSlxCFtClHz2FrINAED1pfLE+jyuWCWl0cDzbkKzuwqoKKoKDxywBw+4VCVS9Nn4KQE0V9JrAVfBE0sBpBeOspPDDYaniEd0/izWOatud7RyKOrAm++ixn0EV338+pi0dVDIXIto0dwu+81oX1yVnQ20ujOhNBa2QPUE0lUxO50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=azfLFVPJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="azfLFVPJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M15RGi011010;
	Tue, 22 Jul 2025 08:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=em+kt+G+S8hZmWj+BUrIILDuNJsbBL+CX65OlPE83
	lY=; b=azfLFVPJu9V9/yc+yBwcHqATte6YucGZlKlB2gWE/+kgOwSejryINyqua
	rYbV2G8uPY+DF4sFRbuuJHV6EHhv+HvU/8+d99ETMVDwi4eHpWEIFGKZgV9RxiLA
	1DjlcJr1YLXS4q3H5kHlqgGaqsYQNtDyV7R2klmWwBYHIsxzdnwotH189+9D2Gyv
	4Gmv/Lh8amYjcB6LBMGcf/fUfbP7g9AZOt1QSSzeJRRduqCvXiZul+KXygfi0c7m
	/DUFtlIdwJeJzcZiqFnMtgorMWtpezf4uu+CQARqkqqKbkYBBDID/poRjfladapa
	FvLBfGECaxXF4/Kk6vVLQvaUyk4Vw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqwbeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:57:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56M8lWei024513;
	Tue, 22 Jul 2025 08:57:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqwber-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:57:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6ZYWC004133;
	Tue, 22 Jul 2025 08:56:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fs89f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:56:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M8utdd45613502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 08:56:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBDE20040;
	Tue, 22 Jul 2025 08:56:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D100720043;
	Tue, 22 Jul 2025 08:56:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.199.41])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Jul 2025 08:56:52 +0000 (GMT)
From: Aditya Bodkhe <adityab1@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, venkat88@linux.ibm.com,
        Aditya Bodkhe <adityab1@linux.ibm.com>
Subject: [PATCH v2 1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
Date: Tue, 22 Jul 2025 14:26:47 +0530
Message-ID: <20250722085648.1640-1-adityab1@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U8dQhvN24Q4MFv_KRg1SnPiwVjLESJwb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MSBTYWx0ZWRfX1AN4ZemIuZa0
 olXWi+IJZXqQDOFIhwbcIwzD4r9EJr45Ht64Xgo1W/idIvRSxCv3hDJffCKEYrwoqsT8SO/nq37
 dgD802z6dy2fl0limv31NUBZCAqXYv6gwNt1HfiInJELS2f9Q+w51XaIroD/rhBGxUhoqQVq1XY
 5q7Y0V6M/Mb7gKKCxqabn8RFsuAe5JiUzz9eo1fF+RnjKI7TnQtQGY2WoTm7uppja+T8bxIKNmw
 HutLlDvWOPRrdpr/eDSgKETxckkkSvIaLqZYixletRHoK1Ac+gTghjc0q5ZB6S8QqMb7ndUUnMU
 FxLGNwX8537jJgWIDCktCE77CEbhlOPx+Xl3ZwiWutMTuJYj+MgZqLAqspxxNg7KfxAlqlzBuTD
 HHQjoZ4ufLkZRVELcU2ndnOJnQ3qFF9O5M6O5HzEhSbqKrXN96BRCqM7Xerklgb3nqWngklc
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687f525c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=f-JPSP1mq3vSRxYuwIAA:9
X-Proofpoint-GUID: Zqytb6L4fNSzmhhgppjFwLE_bxEJ82nN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220071

commit a1be9ccc57f0 ("function_graph: Support recording and printing the
return value of function") introduced support for function graph return
value tracing.

Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
ftrace_regs") further refactored and optimized the implementation,
making `struct fgraph_ret_regs` unnecessary.

This patch enables the above modifications for powerpc all, ensuring that
function graph return value tracing is available on this architecture.

In this patch we have redefined two functions:
- 'ftrace_regs_get_return_value()' - the existing implementation on
ppc returns -ve of return value based on some conditions not
relevant to our patch.
- 'ftrace_regs_get_frame_pointer()' - always returns 0 in current code .

We also allocate stack space to equivalent of 'SWITCH_FRAME_SIZE',
allowing us to directly use predefined offsets like 'GPR3' and 'GPR4'
this keeps code clean and consistent with already defined offsets .

After this patch, v6.14+ kernel can also be built with FPROBE on powerpc
but there are a few other build and runtime dependencies for FPROBE to
work properly. The next patch addresses them.

Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>
---

Changelog:
v1 -> v2:
- Added explanation for redefining ftrace_regs_get_return_value() 
and ftrace_regs_get_frame_pointer()
- Explained why stack space equivalent to 'SWITCH_FRAME_SIZE' is allocated.

 arch/powerpc/Kconfig                     |  1 +
 arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
 arch/powerpc/kernel/trace/ftrace_entry.S | 42 ++++++++++++++----------
 3 files changed, 41 insertions(+), 17 deletions(-)

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
index 3565c67fc638..3da14d8271d9 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -409,23 +409,31 @@ EXPORT_SYMBOL(_mcount)
 _GLOBAL(return_to_handler)
 	/* need to save return values */
 #ifdef CONFIG_PPC64
-	std	r4,  -32(r1)
-	std	r3,  -24(r1)
+	stdu	r1, -SWITCH_FRAME_SIZE(r1)
+	std	r4, GPR4(r1)
+	std	r3, GPR3(r1)
+	/* Save previous stack pointer (r1) */
+	addi	r3, r1, SWITCH_FRAME_SIZE
+	std	r3, GPR1(r1)
 	/* save TOC */
-	std	r2,  -16(r1)
-	std	r31, -8(r1)
+	std	r2, 24(r1)
+	std	r31, 32(r1)
 	mr	r31, r1
-	stdu	r1, -112(r1)
-
+	/* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
+	addi	r3, r1, STACK_INT_FRAME_REGS
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
+	/* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
+	addi	r3, r1, STACK_INT_FRAME_REGS
 #endif

 
 	bl	ftrace_return_to_handler
@@ -435,15 +443,15 @@ _GLOBAL(return_to_handler)
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
2.50.0

