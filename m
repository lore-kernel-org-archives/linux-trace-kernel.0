Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770F1E98EF;
	Tue, 25 Nov 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089081; cv=none; b=q01VFr2+st4ZGQa4e2ojglE02PnyxB6ss+zvUeuOSDodNaeCQhYQFl0Nxmab9xYDgilY+wA4RXFSujWIaDKS2/GK+gMmaFsxbQPru7gaENmckDwvJbGtG1hia8H/QwGa3ja5WnhfKo7J82pL0TUb18bdfEUk/XJfmDKS7+lIV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089081; c=relaxed/simple;
	bh=0mRriTaFoP70OQc8yqQ+ND2TAs25kKeuFOBJJ7uoEiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haY59IGCDaqi83PxKSW7q4GuABowh2hg6rY27PsB4n9oY71Do0qLstrUINq4tHZar2pJ6nMDHH2uqX0eBl2P673DYO/WfjryzScF3+OhYFoa7seWGQNBRkvGfanUafrwl0BKkDX9kccpVHilQ0IcV+uSMb77aouEzteQRpKZ2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jROLtr5l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jROLtr5l"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APDQMUa014484;
	Tue, 25 Nov 2025 16:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QxqDNurIdSF3zjDDc
	lZ+vL6ghkNAs5JJUL00xCyjypU=; b=jROLtr5lkW3G5z2xtYM/OyuVK4b8vx832
	SXKytld6WKwqux+MoRjR3bHB5yM+UQOAu4IW/BRW3OepFcnrboeD65yXImcTImzi
	/bKkC40Wn3kha7RXtV9B0aQKYTRYCME1GrdVMCenIqONo5eaB28xkH7fekWWY8bC
	F4Dlbyxbwq2Zv9p/5uAu+a4nHuiA5vMkuPxg4dr5Gh2xTCholnN0A0XG+7EhPrG7
	rtutkc+ooJLl4ZoRcfleZjENtTUBo5/nuD6Kk6pAfMSYqwewuerNXs12ARO2jjM8
	3MU4I4nMyXujDQImEIjIri0LgNG++r9zu1zyxV5wggwJsWPTz0XNA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phxvvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:44:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APFB3E0013916;
	Tue, 25 Nov 2025 16:44:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akrgn53qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:44:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APGhuIB42729876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:43:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D49E20040;
	Tue, 25 Nov 2025 16:43:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A28A2004B;
	Tue, 25 Nov 2025 16:43:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 16:43:56 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
Date: Tue, 25 Nov 2025 17:43:49 +0100
Message-ID: <20251125164349.2592874-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125164349.2592874-1-jremus@linux.ibm.com>
References: <20251125164349.2592874-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX0rPNKNTPbC7g
 buq3OMbvF+IOL0sr/pFQhb9mXcU2AXgVvJmdA9qgv4pJAK4zhHi0SUYj5HdO4fkathO0FaRkHzf
 YHlZIL19Lch7UGi0+tkPRS1dkhD5+RnNqDRcWnlUW2XaSjDBTkuioKhaIVn6FV85PRbaUzriEtM
 LhPq0JrFmI62O2xaU2/nAHwsyEp8u2RmLSK3XPxXPGEK9DfmEUbUgaQwlUzb7uEvtNqczvlqRjV
 3n6Cc6iYNEq6MMm78n/zfaClq1MURsG9DEsvGHDV0fRyhNpB0cE/abY4v4NaDm49n2wWnHgFV7L
 HMVkX3vqDKW9y9BzfxDoCeZC3YqdTZAOEqcr15vseOO1K+Hbp6PQLcKr49SycRyeOez+Th95OIE
 m0+fnxjJgkVj632b8pNPQbNdCMidBQ==
X-Proofpoint-ORIG-GUID: mzODBbdxDN-9AkXQRubUgownfjMy10xa
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6925dcd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LIcl9UMsB3m1Xa-0CCYA:9
X-Proofpoint-GUID: mzODBbdxDN-9AkXQRubUgownfjMy10xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

The unwind user framework in general requires an architecture-specific
implementation of unwind_user_word_size() to be present for any unwind
method, whether that is fp or a future other method, such as potentially
sframe.

Guard unwind_user_word_size() by the availability of the UNWIND_USER
framework instead of the specific HAVE_UNWIND_USER_FP method.

This facilitates to selectively disable HAVE_UNWIND_USER_FP on x86
(e.g. for test purposes) once a new unwind method is added to unwind
user.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/unwind_user.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 12064284bc4e..77d776c7fca9 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,6 +2,22 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
+#ifdef CONFIG_UNWIND_USER
+
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	/* We can't unwind VM86 stacks */
+	if (regs->flags & X86_VM_MASK)
+		return 0;
+#ifdef CONFIG_X86_64
+	if (!user_64bit_mode(regs))
+		return sizeof(int);
+#endif
+	return sizeof(long);
+}
+
+#endif /* CONFIG_UNWIND_USER */
+
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
 #include <asm/ptrace.h>
@@ -19,18 +35,6 @@
 	.fp_off		= 0,				\
 	.use_fp		= false,
 
-static inline int unwind_user_word_size(struct pt_regs *regs)
-{
-	/* We can't unwind VM86 stacks */
-	if (regs->flags & X86_VM_MASK)
-		return 0;
-#ifdef CONFIG_X86_64
-	if (!user_64bit_mode(regs))
-		return sizeof(int);
-#endif
-	return sizeof(long);
-}
-
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.51.0

