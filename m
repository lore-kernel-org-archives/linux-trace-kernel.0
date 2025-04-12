Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B29151991;
	Sat, 12 Apr 2025 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744496342; cv=none; b=beDuckDDhP2OPjzXGeLx1tz/7Cl+FCobof2BVmwXbIc+PhUDLoWsr0HZ2IstpjqkqjG5Xz+iIxvvsnaCeyBCni0VK7pwzLuNrqxKKKA+TVlkQER03KcIrMW8/kIEkYa0ypnHF+SRS7ZFqolLkTgUO9vltaGTXfRFLwGtFTKVdNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744496342; c=relaxed/simple;
	bh=uRhpV3OE9uIKRjCN8KwA0z6HP1xwtPJs4K0j6afjfM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k13cH/vEy+s43dx7iVUIIZQckn+JFC7CG4I55zu02UljHsE0M/61PciOK4W30yg80rSQYTHOUW5iBui99t64dGQrXtc9GZa3MeGpH/8Jkf2eA7My/8X4zevS9qaP4ymbu4Z1OcX1BtQPS5qZZ1gp85B9VCXA4N9y2+9Zx34cI/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R2JwXa6v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R2JwXa6v"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CF8kLx023387;
	Sat, 12 Apr 2025 22:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EdpbFwCNmQDH6XmT/
	HxpnLTDzMdhlQ817LeBL2lp0bs=; b=R2JwXa6vBc/kX+ao49T40oKBHq/8Ja1SL
	WcyoqyMZ/g8XHQRV+yumbGYe7iTJXpAOVX2GfCk4CgUBtm+Vru/XRwUH8a9BfCE0
	T5jOkb+j0+MXpEVnA/FoBM261HuayTUHMQ1949mDZU2vWFF8m3Gb/dygGxrW4pPg
	EejM5eYneHo9l6T7c3X9buwdnFxesAblz+KNs7ndJ5wM10OALA4zWAIGeSfGAtCp
	uggEpuNfIBAYHxkw6h4S2LDoPKUgoafoSFUxaVGoBVqd6fV909gwXqd0jXK9ZevO
	6BK/y/zejeblNIB/aqfUR2rXWLWtSOISyHH3TKYysn4L18VRphInw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ypmpa9fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53CJgXp3002564;
	Sat, 12 Apr 2025 22:18:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ygs7bc19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Apr 2025 22:18:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53CMIo7151184004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 22:18:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB3E020067;
	Sat, 12 Apr 2025 22:18:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4411B20065;
	Sat, 12 Apr 2025 22:18:50 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.5.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Apr 2025 22:18:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 1/2] ftrace: Fix type of ftrace_graph_ent_entry.depth
Date: Sun, 13 Apr 2025 00:10:43 +0200
Message-ID: <20250412221847.17310-2-iii@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: fBMZsFH_NTg87zf53SJ2J-l9xH-xxCox
X-Proofpoint-GUID: fBMZsFH_NTg87zf53SJ2J-l9xH-xxCox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_10,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504120170

ftrace_graph_ent.depth is int, but ftrace_graph_ent_entry.depth is
unsigned long. This confuses trace-cmd on 64-bit big-endian systems and
makes it print a huge amount of spaces. Fix this by using unsigned int,
which has a matching size, instead.

Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/trace/trace_entries.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index ee40d4e6ad1c..4ef4df6623a8 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -80,11 +80,11 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned long,	graph_ent,	depth		)
+		__field_packed(	unsigned int,	graph_ent,	depth		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
+	F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
 );
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-- 
2.49.0

