Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B26CE2B;
	Mon,  8 Dec 2025 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209863; cv=none; b=E0TXpseemQsm0IH8RO5YcEwg0vFPLtFx0bsGWyWi+upxja9L4pZVcmxIIKqQl8UNnx34Dz9XMIdKKbZBAxgpKfKq+zPPCrpFGW7f69MJKYryY3kBnP+VGoejoPwVheCWdgKZo+WctliwRwp7ov0VW+x4n9NhlM5GiPgdeWetBzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209863; c=relaxed/simple;
	bh=jkg8tRwFsBh4lQCKIUPxTfTkJTsnZ3FRJaagjPpOxBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vs/dMm6NbUqSB00SyJxNTzAwG6t507V6iNLMeQRbVuEglhLJ98UzGRvexJ7fnRiyOLUx7reo4BSYSkiSF3Jaz6UY2Reeeq/0sTAj32bdG+LSae1yuku8jWS4WIlKcmaq2kJP6zAZLyzN8vMtF3y+X/wlRq8NEtp6MtLrc7LLFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OIacjhw+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OIacjhw+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B883t14031236;
	Mon, 8 Dec 2025 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQBdhMIcp6DAZi9Zx
	Vexr6Oh5CmqajUNW2WLiVkcNP8=; b=OIacjhw+ehZGV6jcZ+fW2qoMDzsqNzob/
	UW+91SagcMe8qsSSZDEvu8OYFXxMvSOkIy5SK94NaiUDHYlpdhDVsSUH+XKcc2iV
	lW1fanOZlwFOKqY6e0RVGYkRaJrI9nBF8VSV4ghkp0t2Qe3HDYQojBynCpDPnu3r
	AObq8Jh8ECoIRtHWvnxGlqY/+HY+LjT6nP+TKLN1h0YxnRWYuVrRZ+/glZKdE33Y
	Fp610jCSyDSIgesdC5MBF9hMPWUyILh2m1/0VNiJwSnljyAhlHtvwx/j4EUbRd3E
	29+hnMn5+ArlJE+IX45LgrS0/NChMVfy/oG6T/z+G9qV2Q+VVaEAg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc618jy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8EFeCA030254;
	Mon, 8 Dec 2025 16:04:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4avxtrxmhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:03:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G3uCI25887356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:03:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 471A120040;
	Mon,  8 Dec 2025 16:03:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1A632004B;
	Mon,  8 Dec 2025 16:03:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 16:03:55 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 3/4] x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
Date: Mon,  8 Dec 2025 17:03:51 +0100
Message-ID: <20251208160352.1363040-4-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208160352.1363040-1-jremus@linux.ibm.com>
References: <20251208160352.1363040-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX2oN9OtxNAJNU
 DaaQAYndx34Y1Yi8LhOI+BxJ8xyrwPIvmH+fnE5OPVFv+wq8HJ0qjVVNOhgXL5Wgka/9NUqRAiK
 F+LvJgqUvcR8g8h5RyzQn4RQwxfaBCXH6bibnGeEY7QP7MpIOOnD4dPaR3KWlTMCMclbYHOhzP5
 AsfqSwujk6/QpW81pEHjnULYx8DjjG48XPhOEoAFMDOTjuiOJhsTiyrLavz9vR1a+Se3BB89SnK
 i0XtdrG7TNnC0QgrqUAscUjOO0XuBQOEpCEBCNhJUM1Yny2SWwZ1FBzO/qfxKcERD+t0+J2YkqG
 hYaOPfhy+HoYVtndC+w5J+IhmvvAnWbFvnHtg+8RgXPILJCIFx1nj+5tzqYtrL7vFEfl1QIO9ym
 z4S4s6gK/Xof8z0mDqaFAcp1EI8bCA==
X-Proofpoint-GUID: M7IliblS3NP3oFtT1pQZe1W5kBbkMTSD
X-Proofpoint-ORIG-GUID: M7IliblS3NP3oFtT1pQZe1W5kBbkMTSD
X-Authority-Analysis: v=2.4 cv=O/U0fR9W c=1 sm=1 tr=0 ts=6936f6f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EUPQYQbpjl04SHwYsagA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

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

Notes (jremus):
    Changes in v3:
    - Move includes into more common UNWIND_USER guard at the top of the
      source.  asm/ptrace.h is required for struct pt_regs.

 arch/x86/include/asm/unwind_user.h | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 971ffe937d50..7f1229b33d06 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,23 +2,11 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
+#ifdef CONFIG_UNWIND_USER
 
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
-#define ARCH_INIT_USER_FP_FRAME(ws)			\
-	.cfa_off	=  2*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= -2*(ws),			\
-	.use_fp		= true,
-
-#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
-	.cfa_off	=  1*(ws),			\
-	.ra_off		= -1*(ws),			\
-	.fp_off		= 0,				\
-	.use_fp		= false,
-
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -31,6 +19,22 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return sizeof(long);
 }
 
+#endif /* CONFIG_UNWIND_USER */
+
+#ifdef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=  2*(ws),			\
+	.ra_off		= -1*(ws),			\
+	.fp_off		= -2*(ws),			\
+	.use_fp		= true,
+
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
+	.cfa_off	=  1*(ws),			\
+	.ra_off		= -1*(ws),			\
+	.fp_off		= 0,				\
+	.use_fp		= false,
+
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.51.0

