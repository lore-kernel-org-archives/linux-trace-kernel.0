Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C321283C83;
	Mon,  8 Dec 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209866; cv=none; b=a6ZR+dowpcD6Dfh1BaE1PwmKPO+Gl/eG+yHfQKNpbkaR+5Fbk/ULI3dDVp1s7VWoqtA3tkAwtBJug3y8aFuSDxkoWBL99i8bDXlfqG7zIQyYYyQMpm0IweUyKYgz2RbF5wFArkwPUw/QDJZHFpSB1CdRSvTyGB1ypOKryQqoZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209866; c=relaxed/simple;
	bh=9SUoB5P3+wbu/VC/ee1idmz9XakdYQShJohl162A928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNpaMbO1rGETaAYIqvHc84XEXbLSihZXvbH3lQMIf1+3ysK9cYfyH+vpz141ZdeWXSb3S9hJJcOj1FvPdnizA6qwgosXVm9N1mtJIBuIGnAZfD7FSFQIflH8+3LneTlgymXs0S2/RtteTxKiPkqvmY/q3pApPMXPPbKx/afWugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d+x4hXXS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d+x4hXXS"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8DwDwW019550;
	Mon, 8 Dec 2025 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S397CtIQ2BgwPo3+H
	9k4MdgUl5dyw5002+960yfKThM=; b=d+x4hXXSsnTNN9cUW4wv459MLwJkUTwL+
	Yix2Iqp3ZvIK/FUAMesO9jQWS2Xtx+DKp2qakze6vYfTdA4tyKK3Qgr46YvO6c0k
	g8wUGrk0XSZStqQ5DxfmhKVRwJXREmIfIPjZKT47zw0nV0oYGEQiHuXn8XjLQ/9q
	a0KmnAUjx3YzVv5eEMd4sNkhi2HlKnXNaRH2dEf4BEwIbSIDxrzEE9mqXIRnPsZ1
	/HattQiEy7Cp2IwCkXCe74wIGZfdzvj/nT139K1sUclIYRe8bZbnHuJQjQgitcud
	pBXzDy6P4fNDiAbnp5jsrVSeAMxrChVPFVcwg5FWSsuO7y/J5OWyg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc0jrk0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8CoRNs026799;
	Mon, 8 Dec 2025 16:03:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0x5dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:03:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G3uhE10879234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:03:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8F2520040;
	Mon,  8 Dec 2025 16:03:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A108120043;
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
Subject: [PATCH v4 2/4] unwind_user/fp: Use dummies instead of ifdef
Date: Mon,  8 Dec 2025 17:03:50 +0100
Message-ID: <20251208160352.1363040-3-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Cf8FJbrl c=1 sm=1 tr=0 ts=6936f6f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pRS0VBzutSDFB64YrXgA:9
X-Proofpoint-ORIG-GUID: Pdrm9UDzr0leYcUom_wL5XuSwXmBDqJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAxNiBTYWx0ZWRfX2sjUOLFHlvXE
 EX9qXAjxGBBqFmnau33bSCJ03VRutv0E9+SN9aHBsf1fHHAxmomscg2SM7dkRuQlI6Oym+UEfmo
 1j7pXnm8UawmH6EjOGVm/144yprwM5PBib2Rpc9Mcm7xl/6fZ5B3w/v6krFa63QZ3VsGLQ7NYu1
 dMsXhD+OTHLDXM6mLmB8cnKlOREM2T3h5dYWggq02Xu2zgC45OXqeeks515p0PWH5mSs7p8CjHG
 BraS69LpUS/IhGTcVbspUi/C8nXYcNIhKgL09nVh4NhZlMiQfz26K0+x3xuiRuezLWlNagrW34t
 wfQ56UNIpx1hqc2cdY5F9qBZJRXBm7MakPH/P8xB7MCa5iHSF9m3PlrL+Ovaukg4tnR4l4xq2Sc
 9+giL5/mZRV2lOtgrDZomeranSvs7A==
X-Proofpoint-GUID: Pdrm9UDzr0leYcUom_wL5XuSwXmBDqJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512060016

This simplifies the code.   unwind_user_next_fp() does not need to
return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
unwind_user_start() will then not select this unwind method and
unwind_user_next() will therefore not call it.

Provide (1) a dummy definition of ARCH_INIT_USER_FP_FRAME, if the unwind
user method HAVE_UNWIND_USER_FP is not enabled, (2) a common fallback
definition of unwind_user_at_function_start() which returns false, and
(3) a common dummy definition of ARCH_INIT_USER_FP_ENTRY_FRAME.

Note that enabling the config option HAVE_UNWIND_USER_FP without
defining ARCH_INIT_USER_FP_FRAME triggers a compile error, which is
helpful when implementing support for this unwind user method in an
architecture.  Enabling the config option when providing an arch-
specific unwind_user_at_function_start() definition makes it necessary
to also provide an arch-specific ARCH_INIT_USER_FP_ENTRY_FRAME
definition.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v3:
    - Remove comment on #endif. (Ingo)
    
    Changes in v2:
    - Add parameter ws to ARCH_INIT_USER_{FP_FRAME|FP_ENTRY_FRAME}.
    - Provide common fallback of unwind_user_at_function_start().
    - Provide common dummy of ARCH_INIT_USER_FP_ENTRY_FRAME.
    - Reword commit message accordingly.

 arch/x86/include/asm/unwind_user.h |  1 +
 include/linux/unwind_user.h        | 18 ++++++++++++++++--
 kernel/unwind/user.c               |  4 ----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 12064284bc4e..971ffe937d50 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -35,6 +35,7 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
 }
+#define unwind_user_at_function_start unwind_user_at_function_start
 
 #endif /* CONFIG_HAVE_UNWIND_USER_FP */
 
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 7f7282516bf5..64618618febd 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,8 +5,22 @@
 #include <linux/unwind_user_types.h>
 #include <asm/unwind_user.h>
 
-#ifndef ARCH_INIT_USER_FP_FRAME
- #define ARCH_INIT_USER_FP_FRAME
+#ifndef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME(ws)
+
+#endif
+
+#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
+#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
+#endif
+
+#ifndef unwind_user_at_function_start
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return false;
+}
+#define unwind_user_at_function_start unwind_user_at_function_start
 #endif
 
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 0ca434f86e73..90ab3c1a205e 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -67,7 +67,6 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
-#ifdef CONFIG_HAVE_UNWIND_USER_FP
 	struct pt_regs *regs = task_pt_regs(current);
 
 	if (state->topmost && unwind_user_at_function_start(regs)) {
@@ -81,9 +80,6 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 		ARCH_INIT_USER_FP_FRAME(state->ws)
 	};
 	return unwind_user_next_common(state, &fp_frame);
-#else
-	return -EINVAL;
-#endif
 }
 
 static int unwind_user_next(struct unwind_user_state *state)
-- 
2.51.0

