Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242901EB193;
	Tue,  2 Dec 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688128; cv=none; b=pu69KlhhdRdVJ0k9D8LMJwfyYebxawz2eh2WRaNoEELL0/upwTAZBW8ytpagzaDk95n/dyPeOsHRjSla0OHyFQofrH83OJvslLBvKFDKuC1X73//DMdMzKZED8yRjKUK35sUIjkzbv664gRzCS9BJtbeHhPKwOMzVpCSYXpbNwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688128; c=relaxed/simple;
	bh=9SUoB5P3+wbu/VC/ee1idmz9XakdYQShJohl162A928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUuA+NakRRKkdM8CVBjEUeGCT1xTiAuGd9Lcl/keHBSSpvqhxtFRpXTqbpXzblaWCVGMuVi3kbSDzFpkz2Qk0oI87CIEYTvpQyjFIOFXypx7dwKk8V/jfunMiMbfWcjeS3C26x9XsCcNUT4/8MrirzNBGhszeDVn/8QXwWRPiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZcV/MvmD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZcV/MvmD"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2A0EUL027811;
	Tue, 2 Dec 2025 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S397CtIQ2BgwPo3+H
	9k4MdgUl5dyw5002+960yfKThM=; b=ZcV/MvmDlkeAXiF79f8SHv9VGWDj0F9Dn
	nwxQAxnTkAu+EpYk+LUdNamMOMyuAv64c5knIeXtNwHp2y0z0QDVejIeZQ1DXAir
	tqjJJwRVeI+ZS992RWkIT2rlLDjZmGoRzQyajIbjYZmIdXLaqxPWXpyLv5V8Omjg
	F9QIDTivz4sLw5/ChGWKw3bn6QqxrEtJvBBqj8yT6/gBEsMYRHZi9RfCrMYjDJcS
	CW5m/qeVyu19bMgc4v3fBlM995bOG1uHwbtocq2tH9GzY3MZkJVEvH2o9XB2hxgg
	S8E582KSp5gt+K/TKYw3Xl3nb6i3IV40NRBk9lDc7HSxE8rPl3r4w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8pwn15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2E0LGj008636;
	Tue, 2 Dec 2025 15:08:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mw0k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2F8GlQ40960452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 15:08:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08E1620040;
	Tue,  2 Dec 2025 15:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEBF20043;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
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
Subject: [PATCH v3 2/3] unwind_user/fp: Use dummies instead of ifdef
Date: Tue,  2 Dec 2025 16:08:12 +0100
Message-ID: <20251202150814.3505869-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202150814.3505869-1-jremus@linux.ibm.com>
References: <20251202150814.3505869-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfX33vziMGAWTQI
 h3mBjZrDRsMhn3gEa3RGNWrGIbhjlyHo1t20jCbzozKwKs3DFMiSZAQPvWl2dSH0padsQN0P7K0
 bZ2BshulEceOTwtsRVb70OlVNZOHeN1Q+tkzy4bJ/EX6v6EEKqfmEbILfdFUlYD9UHH0eKZWmgM
 RS/hbIGaijxbVnStcuBTCR9wy0Y+diAymUX+knXtoDKDs6wm2v66xrNsNx+4gBdhpodsDGu+nBm
 R7o6YJ2MlhdI15FgB8IejXQw8wOukSin+1hUTYDwqbVsQl3JKsTZt0RZdJdPte1nvb8NajBlF+o
 OUOeDvt/vEI0pA9C7UqgRdFejNiqJiDLz20+93qrZn7zYKsKaZUzhvj7s8k7H88IzTSwFL/GYbL
 guyIPsXsmn4bD1bliEvcz/FzEOfRDA==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692f00e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pRS0VBzutSDFB64YrXgA:9
X-Proofpoint-ORIG-GUID: 8Uz1VdbT6pU3NAQq-HDWEqCXlEGE7c5G
X-Proofpoint-GUID: 8Uz1VdbT6pU3NAQq-HDWEqCXlEGE7c5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

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

