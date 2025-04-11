Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895123024D;
	Fri, 11 Apr 2025 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392142; cv=none; b=F7IE+Eprw/9nNLSv7pFda0dvdrq6IAv7uW/qxdpVgvvd85gAiPZidTToFfzvAk6HgHGCd/6guQiP0rhkJ8dBfuUnp4d8kcq7JJh4s+1yrodylXxA9oH4nvBdz+D2sdwslkJY4vwMXIn6aD1h6i03yWtc5F4xNyd3WWZx6OfVcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392142; c=relaxed/simple;
	bh=QCljS0hw9jKYBEZq4h0Bo4gAqwF4hc/z2hCoqHcj/+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMRWYffQLr5+k5Oc6OvhFhipRgG2/vbX3mEOJd49yxQRwGpxVSyed/m5P8rk2d/ZP5AgvqDrsqeH7xUd5FnRbfMnvHtwgZYgYJ2ej4htIv90M9qiwhJxcP2/GvE3iazRMsZyjfbtINPrwaYIH/DDN85Q0Jizf5vFfbsHZF9ih5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ho9QR8jJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ho9QR8jJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGjLkq024676;
	Fri, 11 Apr 2025 17:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WI7Lw1PTadnxACqs3n949dt5vWuUr+yt2TrxgU7cz
	Bs=; b=Ho9QR8jJ0Wblqik1k7VZ9e6lJX1xPJPRcdiy+R5+FTaVQz0fSAV8KcIoG
	OjwLRIgoLZIk7LSSoK2LjRAZhAFgYwnnfqS1d+171aV1ZF/Vz7GvZ6omQixJjoFl
	KC8MIWHMfwngaIegqQ6KcZHmyb0wLJCKUu0i8gyI6+4e603fa//MaPs8/tYTp5ZC
	gJyoY6QZiyeP9/RVWpgtdZhG8h/RlsmtbEKMrzHeah95ffA/QrPYBIn+L1P61WdW
	5Fd/kjsf/dJT/aQg9cmD0B+KCTXrXKkSdJwZSzgFaDQsVRjj2c3TafQyap4/OHyu
	eFu79frX7M81WeIfsVAHieJce2y9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufabqeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:22:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BGXgc6029517;
	Fri, 11 Apr 2025 17:22:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45x1k79utc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 17:22:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BHMAtn55443764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 17:22:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C00C2004E;
	Fri, 11 Apr 2025 17:22:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8026020040;
	Fri, 11 Apr 2025 17:22:09 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.71.74])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 17:22:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] ftrace: Fix type of ftrace_graph_ent_entry.depth
Date: Fri, 11 Apr 2025 19:21:41 +0200
Message-ID: <20250411172207.61332-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J4N7nojZ-DOIOCKeuLIr1PGkUZb2i5Du
X-Proofpoint-ORIG-GUID: J4N7nojZ-DOIOCKeuLIr1PGkUZb2i5Du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=854
 clxscore=1011 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110106

ftrace_graph_ent.depth is int, but ftrace_graph_ent_entry.depth is
unsigned long. This confuses trace-cmd on big-endian systems and makes
it print a huge amount of spaces. Make the types match.

Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/trace/trace_entries.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index ee40d4e6ad1c..ac6374b47fe3 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -80,11 +80,11 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
 		__field_packed(	unsigned long,	graph_ent,	func		)
-		__field_packed(	unsigned long,	graph_ent,	depth		)
+		__field_packed(	int,		graph_ent,	depth		)
 		__dynamic_array(unsigned long,	args				)
 	),
 
-	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
+	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)
 );
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
-- 
2.49.0

