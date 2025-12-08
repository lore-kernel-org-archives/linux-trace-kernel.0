Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06A2E5B2D;
	Mon,  8 Dec 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209870; cv=none; b=ByZR/EhKtnMzGbmnUZG8LvZ5UYtrlXgDr394+ArP9CZMbUQPaMxl0eeo3u012Pj1VthB++rs6MlFTelNV0NF6xUvEvpfBlz/GFBWCr/lRq3845KEuuYv9BeH8onKhmrRLEUYhL/MWJPhLuOthTsuc5OWzr/pm9+RHO2tkV2QxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209870; c=relaxed/simple;
	bh=J4PyjTWZZy4AMR0cCiyLgwuuJeCOaxRSVWHewOd8ldY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTu8JDWJp3p6iWlIGBxnoNWfaemZPhktJavolS5IDs3lJ9vrbkec/9jXrrXO7mk0UZWaVG7uRLyIGikqmzv5ai/2sHFiFMRK69+rvrTMnSzedwwidoln5eF+9flavGQZwLj77FDncUj36K60nwfY7mkesW9stg/6Bj4rgMZMlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LfLvzYQR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LfLvzYQR"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B882Bit005499;
	Mon, 8 Dec 2025 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rpg5SPvkgel8a3b1b
	/FIgAvz7SBPHHvdD/JLyQb5oIY=; b=LfLvzYQRilZ1g+g+kgB3520zUbbdLGXOJ
	GOZcu8Rgc9/Tubm2DOizMOZOTC5c94Gi1UeC6VNxPMPyvslaKcVNM6PDiBGrTnbb
	vekRYY1Ju+DFqXVN1iw2gcfWJaKDpsaqFkgY9oxqvPr0UPYK/tMPa3i/++E5YrMO
	INnEC9bAbidmx2Sv/N2OZJ8Sl5BY8O0xA2juj5XdhFpaDicplt3pZmtR/Nj2Lqz1
	upoqeCkzXD2ONFTwoPEuNRYqqzFw3JlI0JGFS+hbvP77gbxGDLfTUt9/vInylsE4
	Ui2A2e94U7IsZpInYIKgJj1PCF1BQY1zk6Zf+TAYyz3uvhj/xvJGw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvgcre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:04:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8CrCOD026887;
	Mon, 8 Dec 2025 16:03:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0x5dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Dec 2025 16:03:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B8G3tQw54722840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Dec 2025 16:03:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A93120040;
	Mon,  8 Dec 2025 16:03:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B952004B;
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
Subject: [PATCH v4 1/4] unwind_user: Enhance comments on get CFA, FP, and RA
Date: Mon,  8 Dec 2025 17:03:49 +0100
Message-ID: <20251208160352.1363040-2-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: MN64_neTpb5r1Xf7D9bWW08PjblZgq8_
X-Proofpoint-ORIG-GUID: MN64_neTpb5r1Xf7D9bWW08PjblZgq8_
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6936f6f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GRZQj7fo7pb9Qcd1f_cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX6pEC+FgU+Ndq
 nKt63ZutUkSFY++ApEV8gHZw63Unp7uohqjxfRcT/KmJB2SbNjw9CeJlTaE+t/dkTOdkegTWDHj
 6m6r1aYSps8fXbFa2OWE8WMVZnlUTboWEEffFZJi8nZxdQj23ejyxNVYPTOuoCK+kdztVb+hrL8
 f8Wp+is4N3udUbRNZh8VJD+f0SFsBQ62qVUjxynpi9txz9+6FGufqzG+us3QBcuxXPoZWRKV+Ym
 wuJ5yFJtQpiK2+3kjg2qPxGtVOM4kWwQyOhQE/1nE93OM9AvQGiuJkw+ZZWwCizbj/IEHaM4rdl
 3cM83IVQC38YOCY3WHZsQA3HYfx7nVLuluIkHFQ1+frYgdGyCkua+boEBs3lCca3vi366imaclX
 qMlxfID2Z9a0oK0Nz45GlIozIANjgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000

Move the comment "Get the Canonical Frame Address (CFA)" to the top
of the sequence of statements that actually get the CFA.  Reword the
comment "Find the Return Address (RA)" to "Get ...", as the statements
actually get the RA.  Add a respective comment to the statements that
get the FP.  This will be useful once future commits extend the logic
to get the RA and FP.

While at it align the comment on the "stack going in wrong direction"
check to the following one on the "address is word aligned" check.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 39e270789444..0ca434f86e73 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -31,6 +31,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 {
 	unsigned long cfa, fp, ra;
 
+	/* Get the Canonical Frame Address (CFA) */
 	if (frame->use_fp) {
 		if (state->fp < state->sp)
 			return -EINVAL;
@@ -38,11 +39,9 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	} else {
 		cfa = state->sp;
 	}
-
-	/* Get the Canonical Frame Address (CFA) */
 	cfa += frame->cfa_off;
 
-	/* stack going in wrong direction? */
+	/* Make sure that stack is not going in wrong direction */
 	if (cfa <= state->sp)
 		return -EINVAL;
 
@@ -50,10 +49,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	if (cfa & (state->ws - 1))
 		return -EINVAL;
 
-	/* Find the Return Address (RA) */
+	/* Get the Return Address (RA) */
 	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
 		return -EINVAL;
 
+	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
 		return -EINVAL;
 
-- 
2.51.0

