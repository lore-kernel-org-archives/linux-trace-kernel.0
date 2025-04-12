Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B7518F2EF;
	Sat, 12 Apr 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744496343; cv=none; b=WQ3vdtfuh3icHFc2B40k2h3iXlrT2CGmw+t/91jiPElDuX5ekf+BoMnmvm/dzlMMwetlzrkbv3flkKnjxsOyGDQVkQw0v8cfkjIrmOa/4/jI6UTv9s08ZeBflCKl8sr96R5cUS3DTJa81c0Sy8UlBKQbwL0WOqE0Nes23qdl1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744496343; c=relaxed/simple;
	bh=bUoyTR7zWuPOeu9znbGSLLWtFmzYgUkuz+IwAkY9WZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3p1l9FiBWLbSkydvn5WIan4HLKZu6McL6Aeto2VKMRkqrkbUNBUujLyr619hL8dKffu+8w4wHOFsZ8z48dBKSZ9Rjgsh7nR9Tdzuy0/lf52h8CUBvGJg25Te/e1nRWUMLRC+a+qXDJ3zkLkBc6q8zfNalFvrPCd3PA+9cVNKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4NW2k0F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4NW2k0F"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CLu7S5012339;
	Sat, 12 Apr 2025 22:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e5lxLau2HhvDmAhkl
	x7/Ooouz1ck21AGSWcyFSPkON8=; b=E4NW2k0FSvyCnrV+8sD17J1qzDGCHpPoE
	wMwxAfhkJt2ziUD0o4TluzR+UIa06ymZJ1tXnLGbiuQkHYAFDfJwK/+2Ek3gwBvL
	URumDgEK6o1HoB4kLbe8jnSDjvNVKv0agM9T3HlKHFW858Tb/oJm5UF7aO6/HSUo
	GUm61dJ1gC4IooyQGdEJqXbWUKpQuJu8PU6NLq3lkfLnhmOeVo/fwu/d1cEYBg1k
	6eVs9lbLjROwGJWKPh2pDtUEL+Hen4yKq3GiIz2GV2ps6ep/tfIR11QPn71efE8J
	W+YQv1if0htTBKaIxrauQmCoh50Bc4kiUSowun4xSPsYnxOCZF++g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ypmpa9ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53CJqRZh006030;
	Sat, 12 Apr 2025 22:18:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ygu1ubqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53CMIqpo15663434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 22:18:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3E5A20067;
	Sat, 12 Apr 2025 22:18:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6702720065;
	Sat, 12 Apr 2025 22:18:51 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.5.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Apr 2025 22:18:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/2] ftrace: Expose call graph depth as unsigned int
Date: Sun, 13 Apr 2025 00:10:44 +0200
Message-ID: <20250412221847.17310-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412221847.17310-1-iii@linux.ibm.com>
References: <20250412221847.17310-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ksuD4hXsFTfVf5ZCPsQ_-upy_Hp13i9X
X-Proofpoint-GUID: ksuD4hXsFTfVf5ZCPsQ_-upy_Hp13i9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_10,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=897 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504120170

Depth is stored as int because the code uses negative values to break
out of iterations. But what is recorded is always zero or positive. So
expose it as unsigned int instead of int.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/trace/trace_entries.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 4ef4df6623a8..de294ae2c5c5 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -97,11 +97,11 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
 	F_STRUCT(
 		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	int,		graph_ent,	depth		)
+		__field_packed(	unsigned int,	graph_ent,	depth		)
 		__field_packed(	unsigned long,	graph_ent,	retaddr		)
 	),
 
-	F_printk("--> %ps (%d) <- %ps", (void *)__entry->func, __entry->depth,
+	F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->depth,
 		(void *)__entry->retaddr)
 );
 
@@ -124,13 +124,13 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_struct(	struct ftrace_graph_ret,	ret	)
 		__field_packed(	unsigned long,	ret,		func	)
 		__field_packed(	unsigned long,	ret,		retval	)
-		__field_packed(	int,		ret,		depth	)
+		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
 		__field(unsigned long long,	calltime		)
 		__field(unsigned long long,	rettime			)
 	),
 
-	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
+	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
 		 (void *)__entry->func, __entry->depth,
 		 __entry->calltime, __entry->rettime,
 		 __entry->depth, __entry->retval)
@@ -146,13 +146,13 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
 		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	int,		ret,		depth	)
+		__field_packed(	unsigned int,	ret,		depth	)
 		__field_packed(	unsigned int,	ret,		overrun	)
 		__field(unsigned long long,	calltime		)
 		__field(unsigned long long,	rettime			)
 	),
 
-	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
+	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
 		 (void *)__entry->func, __entry->depth,
 		 __entry->calltime, __entry->rettime,
 		 __entry->depth)
-- 
2.49.0

