Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E92DF131;
	Mon,  8 Dec 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209866; cv=none; b=TZVbOW5vx2MW3I2J48yoR1ffdQ7seWk5wfS4vB10akyPYj9oFpbO5Raqh7BRDELAoJkZOnUWaj7z5pGDNTTxEMR8Tcfkg8bPWDUx2aeY5AbkvqsnrWM8sFmQwLLbXDHF9h7uYmWOSO0BukIlkkz28RS7tQV6JvbSg8rcFyVbKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209866; c=relaxed/simple;
	bh=00bHRxShUqHix+Y0pHMMqSsVTIss5SLCtn4lBjUJjV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV9xvThUmjlsMGIVFuczVHppfpJaQVyWidAXcCIbtuUeh3yQq+SPnL392xagF14PUdiIa3m9ZVVscsMnRfh+VKSoTCsA43b+Svr6DF+6reZVXUrNVso5dfPwjy4DzjMAYXPQB6UH7dZn8n7sGvRV/KlKmdXX72gUxqXRvNYTIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ati0PLst; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ati0PLst"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B88eOek031277;
	Mon, 8 Dec 2025 16:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/jwmOufW3UEbDvJkr
	0/+cmHyBma1CCf+zH46v9RXjXU=; b=ati0PLstk2R7gBKoOgRYX2M8Y8OnHSaNA
	ryGKABpyZhgqGtU7kAwAOKncVvOfCG1PdMPK5p1Ctc2mBVNfBd45XtlbmAEsalyn
	CN0XUu5TVMU0W0V7S7noCXmRc9YIDKY2ZKkvtG76MQmnBVb4jj/HtIebLBlAY0OG
	6mju1N8Q7lh+tsOdWWrmsqK1bitKNLgI8RDLt3mVSiBr9j429CpXlIcQkxBTnpm/
	HrDDtfHnGlFk9hHg+9jnqIqZ3a1ZXcuk66DgnqC1C1DxSuIy2u7Lx6fHvBdc4llm
	BNCZkE+4ohnjVnjA4SKAfF0KsBE60vdVscwxpVn3iv+lifPs4LC1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7brjf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Epful009044;
	Mon, 8 Dec 2025 16:04:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4avytmpfk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G3uYW25887364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:03:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D8AC20040;
	Mon,  8 Dec 2025 16:03:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D77020043;
	Mon,  8 Dec 2025 16:03:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Dec 2025 16:03:56 +0000 (GMT)
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
Subject: [PATCH v4 4/4] x86/unwind_user: Simplify unwind_user_word_size()
Date: Mon,  8 Dec 2025 17:03:52 +0100
Message-ID: <20251208160352.1363040-5-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5vPgliLQDmTeZWPvCGjdEAqB7Ai1wnvY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX2dIgauyK8w+y
 tssMp5UYHDhv32TiM4/zvc4xxkh75f7xTL92p8ru7ziAlkuG2F4AGM2wW7TTS0i0jxzcLGzukz0
 qysuZeTSdSpv5FpCQHrndBgBGM6UB0WEzt5uZBsY9FZ+rs+EqK84HbCWqiqqfVAqzYML8cmdOzh
 XPzJTlUpv8cfujX7aakjxUUNYBbK7K5d1Udrb3+1KshhUxOjbR3Tqb286ivRicCwHsMWGjkRXvO
 UbNApFYvC+PfYa7jlc+arRVF2Pl0orZjTGBSNJ5YV9NEPX3wvyZCYVr5Yu8yebPwBSscqaxCTfN
 tOj2ZsmA+ass00LxXruoosBeh30cRUvh5y/gLJVjsYgZXib5sJuNv63guxgvb0P4pKi/3XCx4zL
 PY4NzuCti0tC4xUxZDQOhcdN7BK3Cg==
X-Proofpoint-GUID: 5vPgliLQDmTeZWPvCGjdEAqB7Ai1wnvY
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=6936f6f1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8 a=U3zWcbju4HIoyLPczGQA:9
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

Get rid of superfluous ifdef and return explicit word size depending on
32-bit or 64-bit mode.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - New patch. (Linus)
      https://lore.kernel.org/all/CAHk-=wh4_BPvniQZqvEQ4cCC3WfvQqruWk0b1Yek+0d5S1LuxQ@mail.gmail.com/
    
    This aligns to sizeof_long() in arch/x86/kernel/uprobes.c.

 arch/x86/include/asm/unwind_user.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 7f1229b33d06..6e469044e4de 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -12,11 +12,7 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	/* We can't unwind VM86 stacks */
 	if (regs->flags & X86_VM_MASK)
 		return 0;
-#ifdef CONFIG_X86_64
-	if (!user_64bit_mode(regs))
-		return sizeof(int);
-#endif
-	return sizeof(long);
+	return user_64bit_mode(regs) ? 8 : 4;
 }
 
 #endif /* CONFIG_UNWIND_USER */
-- 
2.51.0

