Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627F329383;
	Tue, 25 Nov 2025 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089080; cv=none; b=czXUmOYpjR6fLP/ZWFO21fCYz1cqZebZZf3leEmEznn857m/KdQe5h1Sd7U0takRrQuNXJLyBCDx+MOxkqro1o9i5O7N/ar8FmUdqFeG8LJc9Zt2yGrKlonJG0XJcFcWgLt38n3C/0XAi7HJ38GYMszTL54L77XtcP/665BPFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089080; c=relaxed/simple;
	bh=J4PyjTWZZy4AMR0cCiyLgwuuJeCOaxRSVWHewOd8ldY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxwlZiUu+vwBkBuKK/OxoLl2N3l27Uhmfu7hoEnXIhKrxDSmnoSo6LqUY3Ywkhcu9rfKkYOnh89F+0yF5wYpnRbeu5Bit0FI4XBdtQG0kDhIgKFIPac8U+mEQajjqJ3KPa6IecPgfTMDVO8wOxo3QJck4zuy/t5+098OVX680u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HoQz9oOG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HoQz9oOG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APEUs1I031548;
	Tue, 25 Nov 2025 16:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rpg5SPvkgel8a3b1b
	/FIgAvz7SBPHHvdD/JLyQb5oIY=; b=HoQz9oOGWHbuTGoVQdl6/yHDqmg5q9LhM
	tJZlkrpfqK2f1Hd6bul6IijAVG7PWlJbvHIbm2iGvX1dp0YmdjaKyworJFmH4bdQ
	uouc4sVbhE64P0gpEjb1YY/Ey7H+LEFrTtc7CORSzKLvyLlt98HV+hew7794fCfu
	SYZ/nL8EayrxRbDUWQ6N0vYKL4lKfDXItC/HuekYz9LEQdNTBVv8DU/bRC5LHJsw
	l1wd0uNo+AsepMA5GyMevtN1IF470w/r2eIltzymNMZw503wU/EnHM1MDcW6lkRZ
	tGVbBAgmGIXXoaD+Gc3c7mnxxTLI5WUBbJUIcE2xQPxsoj2b1MjRw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4phxvvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:44:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5APFOj7p016406;
	Tue, 25 Nov 2025 16:43:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0k50mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 16:43:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APGhtf728836336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 16:43:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDF8F2004B;
	Tue, 25 Nov 2025 16:43:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7874D2004D;
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
Subject: [PATCH 1/3] unwind_user: Enhance comments on get CFA, FP, and RA
Date: Tue, 25 Nov 2025 17:43:47 +0100
Message-ID: <20251125164349.2592874-2-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxNiBTYWx0ZWRfX1KXu6t2wPS0R
 A+0SmgvR1GoitXoFU4Br1S7HBPaHUG3FmF5e4049NZKCjY+jjlXUUNEH+2oP2fBIxQs6Z7uQeBo
 cBJGaZvFVou6fs5PRSWfQZ0osy+VWYDTtWotHEp35Y9aOi6VSOI1tOTCdRB/Goc2Ynj7nJOD4Py
 cDQUBkxHkhTRyIvGGKBz8T7dcAGiyNRMsgqygCk0yaSx7Dt24d427Kvb6bBFthCZhaTw6/i/y5A
 e20CBjxAxedu1IpaHp40bspODwVslVPNbXxn8oNYf8J2+bASxcb170LsqwdFaJfh5I4XxqP0kwR
 hEW1PPPrIRBJBsGP2wwo5cPoXxsQ1SBC0bl7jQbnyM+K/S56f7iqRPAqHsmOkEGvqs3JNkw8I8R
 Rs71FuKdAKaTlmT4ZLx+hoAshNM2cQ==
X-Proofpoint-ORIG-GUID: NOzabWbe7hh2k-PNGaQXU5L6shDSOH-e
X-Authority-Analysis: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=6925dcd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GRZQj7fo7pb9Qcd1f_cA:9
X-Proofpoint-GUID: NOzabWbe7hh2k-PNGaQXU5L6shDSOH-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220016

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

