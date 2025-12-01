Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54A30DD00;
	Mon,  1 Dec 2025 12:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593699; cv=none; b=KHhD8qM5AVSuDEBZDxW0dyodRPRrQSniSuffsgqn1vgVM2eblBtOF0X9YmmgtGNyTNPGouYzyiqVbp3/kZfrObc8TSb/UDyqs7AT0XykgS5pbQ/lYISmI2ODWcSFQmOXxTYn3Y59Jjx3LfsL/2zGYeYFHjAgbywWf7ckHCCixc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593699; c=relaxed/simple;
	bh=YK2+e+li4DwmSYpreN89JRePxJfIhSXQuRbGgpwaXxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXo5i55a9C0rANb6rMKjTAqqw0D2VouU07XzhIRbNLcmGyRD6wJoaSCaxJZtX/S51x35FqP93psZ0TBNyUXoeEaEFackPJTl4sxPzmw/Ap5ftr+/8ayx8lpbxAQVwrQqX7CBgukwO8zQl4KNdJVujA0va0Yzvd80Ocw+FxVJUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A3kYw1Ar; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A3kYw1Ar"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B175ExH003477;
	Mon, 1 Dec 2025 12:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9e/g6zDE7foN3dYee
	FMnVHSDJwzVUqZPVmHPFREias0=; b=A3kYw1Arce0ECoAbzZJW6PxajYj4VHrDn
	pSHlfM/S0WuUE0p1iiPhLcdakackSIP9ismfCFUPVFvejkzMWTRqx9JHwF2BuBbr
	OGmkhzTUGUn1Tye12s2Bt8sfDM9B53T7YsXxNr36Qc4hPGignoNMQkJGyilHHW+R
	/vMfI8XLT5JQt1bv1pbxcWiRckirdAsRQyvk+HokGQePKm40PVOkcPzL2bgdhDX9
	quGPqtopqaqjpzG6kj2/CezomJk58k2loolArWABxZsizrBLGpMvu3N+lZmdsK1H
	C9a6EaraD+DYytSPXYNSKlC6wzekAjbcQzRz2jVc/xfaq6uDRh/hw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9f4yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1AHGF5029328;
	Mon, 1 Dec 2025 12:54:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv165fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1CsJgO49611126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 12:54:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4824820043;
	Mon,  1 Dec 2025 12:54:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C822004B;
	Mon,  1 Dec 2025 12:54:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
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
Subject: [PATCH v2 2/3] unwind_user/fp: Use dummies instead of ifdef
Date: Mon,  1 Dec 2025 13:54:15 +0100
Message-ID: <20251201125416.1239568-3-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201125416.1239568-1-jremus@linux.ibm.com>
References: <20251201125416.1239568-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4CodtcTOkQ4t1deejzYrMvv54IMRBiC
X-Proofpoint-ORIG-GUID: r4CodtcTOkQ4t1deejzYrMvv54IMRBiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX0t2BOGyIz5Fw
 k+t4AAchNgKZMSWeW3YDCKBzdaxZTZsDva8Kv/yg0fwJTuAWSvTEUwzpMS4VAmBuYNbtYZqZaJm
 6DmtRvSbnj89oXgIbNNhdn93VhcnhaxuKsBUhKbIYMWdQ3sxaCw5HNJrU2ay7BZyWxVyyI7YLxf
 8kgkLpTdJ64vuoNUcg3EpT6dZAxfzmNdnP6ELHJYbGl2ANXiwQcpJKRVagOmERnOKVB8USimH4/
 pChU5A0p54ourbxifuMape1G8I9awivkIGQJDeTD6W9PXgj/BVMHD52dLX9ZdOk8fpbgEUUI6Oe
 UNM/IH7MLXNXKclu8JgvVaq8G54vGiLSJKpFSUJDcDDhl7eizkRLe/gCcv9bndEZkNgTJ+Nw/0e
 ZR7atW9it6ktMcPM0wrkrUGepCbdwg==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692d9000 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=pRS0VBzutSDFB64YrXgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

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
index 7f7282516bf5..e3e65c2955cf 100644
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
+#endif /* !CONFIG_HAVE_UNWIND_USER_FP */
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

