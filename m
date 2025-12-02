Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242FB1FA272;
	Tue,  2 Dec 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688128; cv=none; b=Lxo7X/wX9+MlBVk/ArkX37n5pZqMILCenoo924mPFyK0ny2uAIMrrafvtVz1yz1c/uKqLskQHBFuyGBKKWQXMacnnOzvkkSz9rQFmUkZRj5YXuzHODg7Ynhm52NzKkaGTX8AkjIt5vq6VDPeVrGwKCbREpCMCO5qqdV6/lSt0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688128; c=relaxed/simple;
	bh=jkg8tRwFsBh4lQCKIUPxTfTkJTsnZ3FRJaagjPpOxBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH1y2ybN16qZskx4AICvIWHCkfIjZTU4LYogW6psnDr2e2DmqwP3PUIQPxZPh7A94X/udcSKR/OxJEFAKkWlZ4iM6zHMH9ukHHDKhjABAnx2/LBo8g7kH8Dv6hkFH/PW290ra181Beuq39bwZHs+Fl0Bq+MA82xI4usu1qQztqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VA9i/mAf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VA9i/mAf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2AFZYD007787;
	Tue, 2 Dec 2025 15:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQBdhMIcp6DAZi9Zx
	Vexr6Oh5CmqajUNW2WLiVkcNP8=; b=VA9i/mAfBk24XoqWqmzk8p8SUdlxP5M+B
	Dn/Lj0Iva3ndZfMJ6WDjYkzN8lYuZt4U+tGMu/FHnID/xb2mwC21YabG/RG7q59X
	IkfE8w/QgLlEGs3XADqqM7YzDLG5fDh8Kcwe8YyZO44kZAb3xkCP95gp7l0Xzz6L
	dRmb83AyFOzX6ih/nhSLYKlE6uvo32OmW3nbJecITd7Sg49nvg3Oa7Tk+BWWuF/T
	P15Hhf3MZ1rYwnybqb1+I5Ij5YFHvoS+5eTlOSBn3wUMuQMbnPa0P8L4ScaI23IG
	6btzC8GGSxvhQm/lg8wkFnUgKgJm18LNssDT9qfudMEIU1Ch8osSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8pwn17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2E2o0r019133;
	Tue, 2 Dec 2025 15:08:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arbhxw35x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2F8GVl44302716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 15:08:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C25520040;
	Tue,  2 Dec 2025 15:08:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D1712004B;
	Tue,  2 Dec 2025 15:08:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 15:08:16 +0000 (GMT)
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
Subject: [PATCH v3 3/3] x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
Date: Tue,  2 Dec 2025 16:08:13 +0100
Message-ID: <20251202150814.3505869-4-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfXzkYD9Vwg8P08
 Qg8YhZ8iLfU1akzU1yfWnUzT5Yj0A+Ko4cn5Yul8RDzrfPmQSRk+wfRkWvDDFzgQ0JDfCTdMVXR
 w0FDAspSQrHbL/PFeLqylHNMKx43FaAmggXEvUpXzfkyh8l98tytDRLpsqSSbsPB5XHM8MrmfsH
 pQj2URBqC7TeATBR4LgZI7zMXfYkJIPEN4IfEvD0nLGyoCfoauTM/T3n/jwKp4khNiVL9IPGC1X
 NFP1p1DAYFR6ohTu37ztTzlxkMTfqx0iw/hGKzPbvTtCRoRe4svLATpQRJk9dFxxCqzkT71k3ge
 tOeh86tfyJ8n7hPqOFLQ8mVICaR6C0Ut54Ass8dtxuJOm7ii7JLfxMeHijGRpSGxHxbzqJL79/H
 vVHS5RAmnVPC0HPmqedHKx6M4LnARw==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692f00e5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=EUPQYQbpjl04SHwYsagA:9
X-Proofpoint-ORIG-GUID: jTCte1t2R41GFG_ziEfzwZaB4OTMIOjr
X-Proofpoint-GUID: jTCte1t2R41GFG_ziEfzwZaB4OTMIOjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

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

