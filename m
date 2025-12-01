Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB5430C372;
	Mon,  1 Dec 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593699; cv=none; b=OcZYi/XKI2Kru3YbatYZwK49USLh5sv2v2IDtqpDYk269oYmggyd8vTUiwoQuOSvxbysEenhRjpuk2b4ZRFsaclR4V9T4b48fMu95MUUiv1O3rmzQ0/4g/OWH/iMmBqtjMdq9m12pT/Ls7nSX+IE8fKTGeyYHccKLI4fr9T+MI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593699; c=relaxed/simple;
	bh=+IjpNszmC6izWxL7EJv2qbrRxvopvddxR3SE6ucnsJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlujFE2gBzQnRhv+DPWDjoznOIgx6VMsMhOoGVsyJPK4v9lVkI4ax3Yy4i0P2YftG1/Q8MJZPy4N1JPeoESoUF7FTzK4UutSRpBT9Ie/5g2moId50E0wTdBIv57hTF6AkmEkxHvTVX5Btan2PV8R5mM6O/rqBYvQj1XJhwiQukE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJKMes2+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJKMes2+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B18GHnX008018;
	Mon, 1 Dec 2025 12:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=up2QFoBk2TXh38F/D
	siKDh1hJYwb60yrb1wGwxwf9Eg=; b=XJKMes2+A54q6fSAfcgcJm0R4Z30bLL9C
	7WdUm9k8djTsb7HftI0hFuuguSC94ki8AeZgThMBIIUkGdvNOhpbEOLZcoV1rQ7O
	PkBAGdVkaf55jsZiO6NKtn3vZh+28MxfPFx88vMv6OiHxJm3B6z1vAq01/0KMDet
	0PdeK9ESnLbWvFHSvi7/1Hyb2eWQgpnq/DusGJfD2m0hAiCiWYdw4PPd9K95ibkh
	kZsu0twHiXhPpnzdG/BlWFpi37N45z/KS6vfRTGGCy/aW3VpKl+5ixeZSs6mAP5p
	bprsi24DwvALIWy/aBYONEKYocKlzUlQqCKiwYSp4ZJ3xsn250uYQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrj9f4yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1CoCl0008558;
	Mon, 1 Dec 2025 12:54:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4arc5mpdha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:23 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1CsJgH41288026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 12:54:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CF320043;
	Mon,  1 Dec 2025 12:54:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DE752004D;
	Mon,  1 Dec 2025 12:54:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 12:54:19 +0000 (GMT)
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
Subject: [PATCH v2 3/3] x86/unwind_user: Guard unwind_user_word_size() by UNWIND_USER
Date: Mon,  1 Dec 2025 13:54:16 +0100
Message-ID: <20251201125416.1239568-4-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: ux6Jur0DqRBvn2KZr78y_3DE9OB7S3gr
X-Proofpoint-ORIG-GUID: ux6Jur0DqRBvn2KZr78y_3DE9OB7S3gr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX1iCwIiFM29T7
 vFvCQ31ZdZhzioQZBI9DW+MFuganRxfbrzoEiLKfCFtIw72RBsrRsc/lYgetnhFdexhs8ZXHnh5
 RdnkfUWoSX+0cwJloNwFJ0P8jglDgs4nYWAp+AvSkEjRQme5KkFdx/gHc4rVUIkY3K7Y9jVy/CI
 PITMAgCk8aNjD5hzFaL2UFalwdTeEizAz7dyVOIvPycMQW8S0JezglqjUOBCbqMtb0dfkXLNArG
 q/8biuGUDzr7iAXTfqFh2aELbRaydWwtNeKCx9ngyL4SVuuJHb139u/2DwJ3cdTlyjW9Xe50ut4
 boyOh+LL9IjsNCiE7X356VW1lVllbNu/peeyS009kqqgKgQmPQhnYL0DBaTIKTCdj+j0+bOumQf
 sY/+MAFpWNRRqyv0iOOTASXfCD9uKA==
X-Authority-Analysis: v=2.4 cv=dYGNHHXe c=1 sm=1 tr=0 ts=692d9004 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=LIcl9UMsB3m1Xa-0CCYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

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
index 971ffe937d50..e1137eb67ab2 100644
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

