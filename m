Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573A21171A;
	Wed, 26 Feb 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580039; cv=none; b=IsyljDn3KXgvXUHy3Jk/kb8E0kYn/LGyfjOgA2bNrxAWCQZJFQ2ud26QrtUb32a5qYaIDXV1jeY2qOZZzzLyDL/sDLdiksu0zrJPp+tt0BDwxsZ+tGq4PgmceRnXfpDkYBM3iRO5FVREvZTPFuZZBJVmwnC9VOGeV2UAb8/cN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580039; c=relaxed/simple;
	bh=dYFlL32N8DX1Xl0oKGBDfnt4Dp/7shZ7JfzayKZkIto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnRJ/K8VxbwQ9/FHuoRCG+KMep+Wwa206K3lWvSfwq0QITfV1hJbybh4+F/lIA3IInKyaLYZ9/TSWCpqNKVHiXnwpC6hfBY8p0BD6FgR1H1zlgnrS3ef9mtM9kGxHCy0rN+jMh83BNHk7dCaXEp0l7hYb3i2BIQ3zEsBroQOV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g1N2SYnY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g1N2SYnY"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDZ55e029108;
	Wed, 26 Feb 2025 14:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LBqcteT4tdYdKHL/7+g5XlDYiuAXlFBQoB4+G4OES
	Qs=; b=g1N2SYnYXXgK9QYLeRQUFYF2O6O5x39KdRzGWIM5o3DQERuvO5nKcV0hu
	63JiBeDB/ByAFPcVoN41k2ANRWQoBmjBS0txfGnTvvHHoFZ2qk7F1A2l2zNySCww
	Sq8cM+0tWK0753d6s49Y3MoDMLrilfW4QcEPkLG5Uvys9980xV+T5z7o6p/w8z4u
	r0B7jLAQe6xHZX03QGLDXJToEsYIVOXs23jCIQRnohS0YJSFlBvL7dliPFXjH+sS
	jdLTSN5uqX4zmiqcI8utcUiyWcZlmf1Kvb7W0lwH4Zt4GDn/cl6vPPuy95LSq3Tz
	Rq0OCJDlJ/FCx6CMIfkT56l4Sk/ZQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5jbmq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 14:27:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDPMPi002588;
	Wed, 26 Feb 2025 14:27:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jtqr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 14:27:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QER4Se55509292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 14:27:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 681FD2004B;
	Wed, 26 Feb 2025 14:27:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BD320043;
	Wed, 26 Feb 2025 14:27:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 14:27:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Let fprobe test consider already enabled functions
Date: Wed, 26 Feb 2025 15:27:03 +0100
Message-ID: <20250226142703.910860-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -2MmPF4lgE4DXYssnY9AyMYkhFxESotJ
X-Proofpoint-ORIG-GUID: -2MmPF4lgE4DXYssnY9AyMYkhFxESotJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260112

The fprobe test fails on Fedora 41 since the fprobe test assumption that
the number of enabled_functions is zero before the test starts is not
necessarily true. Some user space tools, like systemd, add BPF programs
that attach to functions. Those will show up in the enabled_functions table
and must be taken into account by the fprobe test.

Therefore count the number of lines of enabled_functions before tests
start, and use that as base when comparing expected results.

Fixes: e85c5e9792b9 ("selftests/ftrace: Update fprobe test to check enabled_functions file")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 .../test.d/dynevent/add_remove_fprobe.tc       | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
index 449f9d8be746..73f6c6fcecab 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe.tc
@@ -10,12 +10,16 @@ PLACE=$FUNCTION_FORK
 PLACE2="kmem_cache_free"
 PLACE3="schedule_timeout"
 
+# Some functions may have BPF programs attached, therefore
+# count already enabled_functions before tests start
+ocnt=`cat enabled_functions | wc -l`
+
 echo "f:myevent1 $PLACE" >> dynamic_events
 
 # Make sure the event is attached and is the only one
 grep -q $PLACE enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -23,7 +27,7 @@ echo "f:myevent2 $PLACE%return" >> dynamic_events
 
 # It should till be the only attached function
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -32,7 +36,7 @@ echo "f:myevent3 $PLACE2" >> dynamic_events
 
 grep -q $PLACE2 enabled_functions
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -49,7 +53,7 @@ grep -q myevent1 dynamic_events
 
 # should still have 2 left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 2 ]; then
+if [ $cnt -ne $((ocnt + 2)) ]; then
 	exit_fail
 fi
 
@@ -57,7 +61,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
@@ -65,7 +69,7 @@ echo "f:myevent4 $PLACE" >> dynamic_events
 
 # Should only have one enabled
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 1 ]; then
+if [ $cnt -ne $((ocnt + 1)) ]; then
 	exit_fail
 fi
 
@@ -73,7 +77,7 @@ echo > dynamic_events
 
 # Should have none left
 cnt=`cat enabled_functions | wc -l`
-if [ $cnt -ne 0 ]; then
+if [ $cnt -ne $ocnt ]; then
 	exit_fail
 fi
 
-- 
2.45.2

