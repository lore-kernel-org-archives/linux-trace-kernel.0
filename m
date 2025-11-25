Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D561E98EF;
	Tue, 25 Nov 2025 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089070; cv=none; b=OQQJkLTpSDKfEaYdFgZ+i3TFwoyNfI25newTPy2l1T4Vr2H+pl9pzq9WdpdreIadOB3Ynk2l5f9ly5Hw+WdoU2ne+l8Cj3HBesDm6aPglqzj6OQxiX/U/w4k5D8DS9i94zvG1eChMXgEPkJo6+sW6b2kujive7f5HBKQgE6K4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089070; c=relaxed/simple;
	bh=R+98Nv6YH0BT1ZrSou0D7Pr6OskBNUtuqhn9NtWJ+SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN2wYdomi5rQFXJIF2FX/zwVKkgT5WiwuZINh+xEsLWasbGW7xsspTcd9sD2kbaBPpFcTKfRAa9pV+aUYQVhpmj4/mxfVkPOLF4WaiOirrDFSHbbaRRBp9PBwfn+Oh8wqvSTT/poHNROQwjuFpwYnzdi8qnjvwORBz5EQ+U4VDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8Ht9Vxg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8Ht9Vxg"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APEVeSi002195;
	Tue, 25 Nov 2025 16:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CuGvhipiqVabDot0c
	Hsec6MRFiOsrQtODCKUg39f95Q=; b=C8Ht9Vxgc89zyguSbpj7MZKsd5UiDcW2a
	KB48FwpEs1irAsvlfm1exr46YN8pK4fnHF3ImHMwTUBPEdmmOmYRoW8tjyM7Telv
	oRw7tcP1uYAomzXZT1tv6clBWs2LbEzSwj+QrpLJ6k6uLaBYkuc7YCx+IhkQDLju
	5BQ+6o4fh4R7yg1Fj1P/hOOrwWB6O9/0n9D/mXj9C5aSBqnPdatCwFRmsd7iXe3n
	wHY2lK69hnCbEDsAAoYS4qFngQYtEGauWLzL/226LOgPmoQ94BEhKU+ppw1psqzT
	26dyP9OXfS5JyYObAH+ovHlB32O9qhgwgxgg72cDqoBZlpn5VOQww==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpxc5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:44:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APGKWRf025097;
	Tue, 25 Nov 2025 16:43:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akt71csbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:43:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APGhuiP42729874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:43:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 140AE20040;
	Tue, 25 Nov 2025 16:43:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C297320043;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
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
Subject: [PATCH 2/3] unwind_user/fp: Use dummies instead of ifdef
Date: Tue, 25 Nov 2025 17:43:48 +0100
Message-ID: <20251125164349.2592874-3-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfXzy2L3j4qIq3y
 OmhpjPD9pnsmO56v7NAc4RCuz64IvzZCAFuJwF18BhIN7MBlIXSlgjggxmHO0nFCY5Il723wbqN
 boMo8pWKMl0lmmOO3ryDaFKCXU+U/OTp98E6C3jngvj+M/ES/Rx2ciDvUftcVviVDa0Z3a1OQDf
 aXUIqHI/rx8Pw5YkOGlpwY8R3TggvZIMior+KeEJbBCGDF/gVQA178ifU+UFRrDWNuFr786CGWJ
 zkKKwgAjDuDBpiNpYVXF3QBAIOsBwBBgifeY+1AiQIxF7lmaYY/1OIZ015SATxVDrIHLmXAFoDW
 FV+moNSpFFqxNchhxQXCQ49m5CJM/uHJdTi9o1PIHUr4Uyk5+2ikIHzZ4uXZHxxzZTOTFJKW3oE
 YhBQBx0Hx/T5N9lSdKmfU2lDvRpxZQ==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6925dcd0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=rKYaUyGAOQbTNo1-z7kA:9
X-Proofpoint-GUID: quMiFihkcSSnyd0lqETBrY6UjcT5Tikg
X-Proofpoint-ORIG-GUID: quMiFihkcSSnyd0lqETBrY6UjcT5Tikg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

This simplifies the code.   unwind_user_next_fp() does not need to
return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
unwind_user_start() will then not select this unwind method and
unwind_user_next() will therefore not call it.

Note that enabling the config option HAVE_UNWIND_USER_FP without
defining ARCH_INIT_USER_FP_FRAME, ARCH_INIT_USER_FP_ENTRY_FRAME, and
unwind_user_at_function_start() will result in a compile error, which
is helpful when implementing support for unwind user fp in an
architecture.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/unwind_user.h | 14 +++++++++++---
 kernel/unwind/user.c        |  4 ----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 7f7282516bf5..c3ff690a43e2 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -5,9 +5,17 @@
 #include <linux/unwind_user_types.h>
 #include <asm/unwind_user.h>
 
-#ifndef ARCH_INIT_USER_FP_FRAME
- #define ARCH_INIT_USER_FP_FRAME
-#endif
+#ifndef CONFIG_HAVE_UNWIND_USER_FP
+
+#define ARCH_INIT_USER_FP_FRAME
+#define ARCH_INIT_USER_FP_ENTRY_FRAME
+
+static inline bool unwind_user_at_function_start(struct pt_regs *regs)
+{
+	return false;
+}
+
+#endif /* !CONFIG_HAVE_UNWIND_USER_FP */
 
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

