Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD647F4D;
	Wed,  4 Sep 2024 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433187; cv=none; b=G7EGG/NdGsvsmz8S8F/s+E+Pp9HsSlokqBmGpp3oqTH8O3fh+NHt0fXGZa0ZqDS6gkUnrcaUV4aoIwTRySe5Qbz1QQvHxUZ1+/YPztDQmZGGWStqPoCVnEffdMqNboRpNRWlbDvqdZpshcuvkRHH3nYLlGrRrC1V8truO1SsV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433187; c=relaxed/simple;
	bh=e58CG+AcikgqXnrXSqI6oEBC59bbF39mHDrZelCdUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDOjNlykVAmAU8Wksu0LFFUva1zYRG048l1MYRYLUV3he5aKCfUkLcygWN3D/OTHdPqq1ndZjBMoqRDbKEQQPmaeA9Ux9PBCBQr0KCzwDDKM5ZE6yAZJv1Mb/T2uGA36ZhsWk+6FOON6nPriTMmY9ZxSJzpGTXbo8o9MCpsR7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oG06pXe2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oG06pXe2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4846mw6F007038;
	Wed, 4 Sep 2024 06:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=LsyxFV6hi1/6W
	RqskN/bUYJbWT5DOE92Idx8C1CSDTQ=; b=oG06pXe21fijaB47NWaeMeC4Q5oUv
	1PsVHWFv96Ryqmyt4EcU82bMNMNPrXMm7Hhn9WvNhnXkRvqfDDSPt3NdLydFT5pq
	z4GXoqsU51gPkAr8IWL+4DcyFPMD0pMgdjSectwEENmFKMnqctkNiHHvd1iOPgyC
	2ColRu3I3VRe9HLlbN/riGA3MQanwc8qt7onlL7GbwE6zG3AT+clbNrcfvrOOxpP
	fJxn52cb6jyQtaf9/jIu27wUGS8i29afE8iYEoK+D8BB5aNByMfg/OsX0LPWsuw5
	zAdixWfUHPeqHYsRvMmUjcrqEIizjArwgITZRcGBs+vV01b/KfrFLxibg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bskm1w7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:21 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4846xLwZ028361;
	Wed, 4 Sep 2024 06:59:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bskm1w7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4844MPmr018672;
	Wed, 4 Sep 2024 06:59:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw16kpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xIFk33424054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4185C2004D;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30BF82004B;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 06506E0297; Wed,  4 Sep 2024 08:59:18 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/7] x86/tracing: pass ftrace_regs to function_graph_enter()
Date: Wed,  4 Sep 2024 08:58:56 +0200
Message-ID: <20240904065908.1009086-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rnkbJHoNSdnGsWppD9zB_2A00H9vu87N
X-Proofpoint-ORIG-GUID: th6i1OWPQT5Q1UVV0zsfPK0dS1Tl3KR_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=773 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040049

Will be used later for printing function argument in the
function graph tracer.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/x86/include/asm/ftrace.h | 2 +-
 arch/x86/kernel/ftrace.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0152a81d9b4a..9843d0c08e61 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -105,7 +105,7 @@ struct dyn_arch_ftrace {
 #ifndef __ASSEMBLY__
 
 void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer);
+			   unsigned long frame_pointer, struct ftrace_regs *regs);
 
 #if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
 extern void set_ftrace_ops_ro(void);
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index b325f7e7e39a..a016b82de5e2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -610,7 +610,7 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info.
  */
 void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
-			   unsigned long frame_pointer)
+			   unsigned long frame_pointer, struct ftrace_regs *fregs)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	int bit;
@@ -637,7 +637,7 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	if (bit < 0)
 		return;
 
-	if (!function_graph_enter(*parent, ip, frame_pointer, parent, NULL))
+	if (!function_graph_enter(*parent, ip, frame_pointer, parent, fregs))
 		*parent = return_hooker;
 
 	ftrace_test_recursion_unlock(bit);
@@ -650,7 +650,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	struct pt_regs *regs = &fregs->regs;
 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
 
-	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
+	prepare_ftrace_return(ip, (unsigned long *)stack, 0, fregs);
 }
 #endif
 
-- 
2.43.0

