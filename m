Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05125B0BB;
	Thu, 24 Sep 2026 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218926; cv=none; b=SIOVmOg+uHCkxPgkUPRMTCmM6OJxS84Sp5NfqvWWXsK3CKyrl+Wg/rBoK69tmqK/4mzg/Bno3U70KE7kxvz1NyasAAAEjiaI2xyQ/m2hVFpQ0d/hbOqKnmyefaLRQS/b1UV1CRvnaL8/vj5+VntIldEjckBZnUVDEpUzFqhaVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218926; c=relaxed/simple;
	bh=MmhTlul3whAnFNcoQH5VFn2cXzhlWyVMv/zdLsaJoSA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sr8JW/FcaDguefMVCoW/dY0VzUZu9y/sz12Lxnbr1YYqFjA0pKsq2m5+AHqjuRfPsjnir9KuLQkMlrw/gPpxoRLLZPAwjkOVLHf+9hEFGnb9IYSE4kAR9lzMYXPKzSxMA8bbmLYIb1arbiqwup7M+7emPbQiAl26FVJXqj38uQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SUXXUYu0; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SUXXUYu0"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2JWoI3160168;
	Thu, 24 Sep 2026 03:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=qxAcZQ01E
	+RSQiaT4qMSzA15+vXM98J20kJ4iYN/d1o=; b=SUXXUYu0g00s+ciRjk8d903T4
	I1zotUhItD4VH5/ZkTIxAIxbJXphBIMcNZtDzkHtuysN8UQjk8vUxPYpxDlwaYTp
	J68Nq+AIQ+XNBRix6M+fI/eq5KVv/jRwRyyFFffjFoiiKW4OceQDcspBZwuNbhMB
	KAFqN4BsimBchLWW3cCo6Mkg+Mtt4TN6hZ+lFS9V2Z347c+sqsAJIERb8xlvAk3Z
	Fzbi2RylY0ie9jA+6GXj9lh2eNmh4fzxutCdf1stzheAKYg/SWkok/Aum8XMc9D1
	zfInwQNHi2TeTXPa37s/K4OnQA+Q0LrucUEZzjhXuciRTIOjG7wQcoW8aleLg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gshc7r4s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Sep 2026 03:01:12 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 23 Sep 2026 20:01:11 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 23 Sep 2026 20:01:09 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>, <yun.zhou@windriver.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH] ftrace: add max field to function profiler stats
Date: Thu, 24 Sep 2026 11:01:08 +0800
Message-ID: <20260924030108.2673654-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMyBTYWx0ZWRfX4LfYGpPAAg0w
 n0/hA6Atc21gs1RX4gqiz5xYeh0nyGRBu7JQJnTLjqnjkzncCCoFbJJN3eWah5ToRhZ8sNHxcEH
 UzoP053+7J9jW2tyV0j7mD9f89OO8P80i/PclQqiqAtJD2TOgHcx3RH9lX15zyBk1Yueu/c0cLI
 011cMqSFKxtxSpxUq4iDdYXqK/PlyZXOsqUKDHYMUGk7vlh708GU7od0BtKuiFvwFeNseEmqNxr
 i5eA6i8E3v3KVMc24wLgbNBA+3sdix19H81iqVmVLKltgkj9sldtCk86DRgSTo/l3Kt+fOn2D9t
 rriH9P/StX7Q8ukIeUiH5ljV/kqBiB5f0CgpC9Fm4Ecu0PXZSzmEZLXdSr5tf12SXU6GqxB2Sec
 un13qAl7hsA9Yf2MJxJ1SEIwbs0DlS9pV837xUhX3m4r76OD+kAViHFGGnnsadYFT4QV/qOf/dt
 t3L6dX03ohyrmmPqasg==
X-Proofpoint-GUID: u2NJddyI0oNm_Bs5EnwybAqh5mXegNUs
X-Proofpoint-ORIG-GUID: u2NJddyI0oNm_Bs5EnwybAqh5mXegNUs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMyBTYWx0ZWRfX9UrEhYodE5y0
 F2rcXNGKRqHX62LJ5lgX6eX8sPBpBELKDcS6cSS8d67TlFpERS4XCGGm491jkQgFRzw4TgjrtD1
 HAAW8nCy28cPrfvd3Kthz/2/q3u+qA4wPGLRf0eDZ9axWhWUpmD+
X-Authority-Analysis: v=2.4 cv=feM4WEQF c=1 sm=1 tr=0 ts=6ab49278 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=2KTbmC8ocYsl8OsA7GEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240013

The function profiler (trace_stat/function<cpu>) reports Hit, Time,
Avg and s^2 per function. Add a "max" field recording the maximum
single-call duration, which is valuable for real-time tuning and for
investigating occasional latency spikes.

Like Time/Avg, it honors the graph-time and sleep-time options, so it
reflects entry-to-return wall-clock latency.

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 kernel/trace/ftrace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 673a54fdf392..98535f5533db 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -428,6 +428,7 @@ struct ftrace_profile {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned long long		time;
 	unsigned long long		time_squared;
+	unsigned long long		time_max;
 #endif
 };
 
@@ -530,9 +531,9 @@ static int function_stat_headers(struct seq_file *m)
 {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	seq_puts(m, "  Function                               "
-		 "Hit    Time            Avg             s^2\n"
+		 "Hit    Time            Avg             s^2             max\n"
 		    "  --------                               "
-		 "---    ----            ---             ---\n");
+		 "---    ----            ---             ---             ---\n");
 #else
 	seq_puts(m, "  Function                               Hit\n"
 		    "  --------                               ---\n");
@@ -613,6 +614,8 @@ static int function_stat_show(struct seq_file *m, void *v)
 	trace_print_graph_duration(avg, &s);
 	trace_seq_puts(&s, "    ");
 	trace_print_graph_duration(stddev, &s);
+	trace_seq_puts(&s, "    ");
+	trace_print_graph_duration(rec->time_max, &s);
 	trace_print_seq(m, &s);
 #endif
 	seq_putc(m, '\n');
@@ -920,6 +923,8 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 	if (rec) {
 		rec->time += calltime;
 		rec->time_squared += calltime * calltime;
+		if (calltime > rec->time_max)
+			rec->time_max = calltime;
 	}
 }
 
-- 
2.43.0

