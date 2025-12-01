Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD030DD00;
	Mon,  1 Dec 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593689; cv=none; b=j+1QSH9C4dwGRz5VYyXnzvFQJt4gZf9E3NSBednQvaTcnG2HdC4ij3N+4Ic0kPy6F94IXN1oO4WS9QJ2ujLjppjkaPh0+PmlLfr1BpPKHbOo4o5svv64y2mSdLZ/JtsuhLvAAR0zH6zk6lbCFN7oR3AWfzqLPiYnRM8I0TrjID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593689; c=relaxed/simple;
	bh=J4PyjTWZZy4AMR0cCiyLgwuuJeCOaxRSVWHewOd8ldY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac/tA8Wn7p+gv4b2Nb49ijK82f49hvVTeZhMYzi1OAqUt+egc9lKI10FhcWZAvYzWeEaVCLXNRV7YA8S2v8D+0gU7oQdnb3pdkbRA3Zix8xPKnu4nWK5EeisKXtDG1fi8DebYdpjJMnpYc0sMOZrylJDPRbswfNc74ikxHYPVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePpeZwwI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePpeZwwI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B192Hvw031345;
	Mon, 1 Dec 2025 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rpg5SPvkgel8a3b1b
	/FIgAvz7SBPHHvdD/JLyQb5oIY=; b=ePpeZwwIlhO0w2fu4S2QQ+VD1IHziEPpC
	HVqasVAXzLPmS4l4KBmKGs6mvV1ILGlXaY0kp2zoqR6TT3fXK6oByWB79tY0yKfw
	dlELBV8tsCIIqEu+VVjCaqAiRcQrm9CusOAKtW8jsAXuYOMXJL5+yfaWngi7zhG8
	HLK814Cbf1z/ViZvYLVljpqLoohvaIe0T+m0nzOioXdPsYGgIteKscucmRF8EAd4
	yTLIBG6kZo1bDxKjZBL3kapctqv0HsUr7V5QMLJeJn56upk6qst+lp32Ny0IkWMM
	ZhzxSe415nxnIQ0fqf06FxJ6+PuNqG8mzz/Q7Fs+YsRePsLLyif6Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqp8pq6ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1AJSaR003853;
	Mon, 1 Dec 2025 12:54:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardcje74a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 12:54:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1CsJ3U49611124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 12:54:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F186E20043;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB88E2004D;
	Mon,  1 Dec 2025 12:54:18 +0000 (GMT)
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
Subject: [PATCH v2 1/3] unwind_user: Enhance comments on get CFA, FP, and RA
Date: Mon,  1 Dec 2025 13:54:14 +0100
Message-ID: <20251201125416.1239568-2-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAwMCBTYWx0ZWRfXw6oZBCN9gdcL
 eu43bH7BgVtoCaMRgfyqcvK5Om/dxPbe8wMzlzNy6nYxNtjwNzx5oOgD23Zm2zKgTzmxVQXkIhA
 oNlw7sDnw+dyyLoYck3gEsMfssljus6NuYZ4wA0fQB3y5FnsffMvRIxKKIq3MJ6GyeE02zxgDkA
 mgrkxIz20eVl+uN43MTFtUpuhog1GdiDfcIFxi4615cb9TRnty5qjPwa/AB9YVokZDKZVk28ibb
 o+KNUL15zWI30AFjhK5NUNaBY3lgBF+RR2ldfmsdTIwB7fQ52iPpAgZJJV2XlJ2m77Cp3Ek4Nz5
 XRnom+FHJiw4Ajxaq/I10bg/MfJhCOi0j4ujJZCsS2xcKQ1bNij2oM+eIjuIm1fedyq3bXYamHJ
 15bLDO04DRHU9b10HuMc+YOy0+zj7g==
X-Authority-Analysis: v=2.4 cv=dIerWeZb c=1 sm=1 tr=0 ts=692d8fff cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GRZQj7fo7pb9Qcd1f_cA:9
X-Proofpoint-ORIG-GUID: 4j_gxdZkdQ-70Rizih90eveM5qMcnj94
X-Proofpoint-GUID: 4j_gxdZkdQ-70Rizih90eveM5qMcnj94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290000

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

