Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEC21D59B;
	Tue,  2 Dec 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688139; cv=none; b=GPUz631nYDWjUity506pNMFMpuofLliNo6zs8seJGHAD3aR7EAS6ZFRkHpK8TFh/qGlW9YEuhksVEtIG7bwm5k8NXkDutL1UzryCdt4ffSlGjdWDVwUeQwU6fGzVXHOFA/jLxfnawYfeD8fFe90/8ptdZSX0jNMuI+Ut3TwL0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688139; c=relaxed/simple;
	bh=J4PyjTWZZy4AMR0cCiyLgwuuJeCOaxRSVWHewOd8ldY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKzJWR0zgla8+sl0AKeWwxhZ5RwQPH5e849oandkt0sFKs5itttLNmkKjfactFxXNAywERNOzKRB55STt0sD746uqA6DfpGHmG1ZsIZQD8m5Q4kEexjkjkNRTv0NxfdJZim2FpUap1FU2toMCGBAh7mt/IS0uz8LS+DXVBEYiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OxtyIOMx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OxtyIOMx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B25hdan008240;
	Tue, 2 Dec 2025 15:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rpg5SPvkgel8a3b1b
	/FIgAvz7SBPHHvdD/JLyQb5oIY=; b=OxtyIOMxesdbRGJu7vXa3Wy1/20afJwZs
	olQkhpFrY6wOKx7yj76zagKof5CBChIFOb/aD84aYG+YcW4FHcgtvjX/drO5vvoW
	4t321Ip8N0cM74wMnbtBlaauLe0WzUJ1mICaQ/luoN0QevBShAl0NsmlanbRah8W
	M43Y/00HOuaYfQ+XH7shb2cCFqHkIbG/szoYcUkZO/DVpyx71M3hsQkru+1Z0GPm
	uyoopqKHhZFWtISRED3b985j4wuFwrDyq2iIWn9ejGBClUkqg0rDA9U2HrEbxHkX
	iiX/Fea0fkhnTPlIWXjTrmt3BJv4WFlbodj1gL+i4r8zBPxJjtQaA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg5t3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2DGx1n024045;
	Tue, 2 Dec 2025 15:08:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5sd6b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:08:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2F8FZL49348974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 15:08:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97CD20040;
	Tue,  2 Dec 2025 15:08:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98B7D2004D;
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
Subject: [PATCH v3 1/3] unwind_user: Enhance comments on get CFA, FP, and RA
Date: Tue,  2 Dec 2025 16:08:11 +0100
Message-ID: <20251202150814.3505869-2-jremus@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: SVlJ4mMwXMYe1KhvuK4Dv1EETDjg7mqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfX5FXSDTJFfssB
 3Gm4oRmzAvmt0WuAIJafFXZ5kLI905Zhl/vKNaCOFhCgl9KUklHQEFBl56E1fKQXeea+L/4PAJX
 SaaI8mwdtVdjuOhwNCcnxb37jFn1gf1l8L5qK49eOxbvfrwe/IzjiQtTeoCNEOqINn3H70cz3lD
 +CpxjToMgw0B8IcSBQYzv57T5y9TTthj3cNJFUkrUJcBCzQPN61aS6QTKHrU4Ko6zydquJKmg4H
 HOl4vPQXYkwbHnY7fkHK5EnQPVbdUNfRH3vBDIL+xw+dERyDRJnGdC3MJIRALx+PVy51tzfRu/a
 4AA7cT/TI5ALV84cyhTn5Ou3bdYeVCNFwnwUWmrniZyHa7QT00mYn8NTkpTS2KPU4zseSKPyBld
 492cIFlxdeHK786c/JOe0dzNQk4sFg==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692f00e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GRZQj7fo7pb9Qcd1f_cA:9
X-Proofpoint-GUID: SVlJ4mMwXMYe1KhvuK4Dv1EETDjg7mqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

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

