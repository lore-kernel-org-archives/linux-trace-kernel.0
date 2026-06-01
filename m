Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51162202997;
	Mon,  1 Jun 2026 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357052; cv=none; b=pFUObUlKfJEfchtn0MzW2KlbFs5hj5L8rWdRUeddvu92C1yLXgaQhviv+EY3mvy0hAkZUOAK5C+7+GNA6FxFly66mObkTJE2MoVuqGz24if/54ezADBQconWXYpwsFV5pATP4xnKlBPu7ztVWLBEWMdfvjRd4ne3LVA6BOHbG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357052; c=relaxed/simple;
	bh=gNwDZR0BOrpxnyTpz7sFAD3CEJUerX3hG1oJjsQngd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeFgyCx50iqa0WV2C6KUyjl42XDlAotrxvqZ1A+HPyivIjese9gM3qqY5qbfeVGGht9eSGHrKcXfvEY+GmlOROrQSWijVnBt3juatGI4dskG33OAv7C/QBFrvjI7qwlFey121RQ0+nVcLu9kM9VKWiTjtjzTitV59PYjdqGu4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N2iuMkZX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2iuMkZX"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Gu0ur665483;
	Mon, 1 Jun 2026 23:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8q06hpStnage6OU2+UFU0iKyf6hxu
	aWmy7wWHYyDPj8=; b=N2iuMkZXSpygOZNA/2Ga6N6bhV9iMZFi26wF45m5bxXEW
	kmFVdCNtZx7kb2zJ1YTKFDEO3iPvw+PfJSbsWGMDxBs/a3QxZ+lNLvyiO92wcIKn
	aG9Uw/MF5cZBB3Gs1XVwnNM5XVovCawixYobLhQ5SWfXbs2gk3Qu/7tLSVKxXppS
	sVNeeY8eg0Sh8z++KARDmbgfHQGvxTBv8y/PomBP83ALLQq2gH1E/wkaVEzP0hV/
	3Ol/VpmbvZ0H5cniZeaRbmtRj7Cdy1CQZbTyF3IYDL902ZZWE9aTHk/DowoSu0xs
	9cA/5SPKYfpmGR8Jv0dv9LE1Sf9U2888R0IZ/WJBQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpaau4m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 23:37:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 651NZGGq008349;
	Mon, 1 Jun 2026 23:37:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbqg394-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jun 2026 23:37:24 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 651NbOer014257;
	Mon, 1 Jun 2026 23:37:24 GMT
Received: from mbpatil-ws.osdevelopmeniad.oraclevcn.com (mbpatil-ol10-ws.webad1iad.osdevelopmeniad.oraclevcn.com [100.100.228.95])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4efpbqg38w-1;
	Mon, 01 Jun 2026 23:37:24 +0000 (GMT)
From: Manjunath Patil <manjunath.b.patil@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH] tracing/events: Expand ring buffer for in-kernel event enables
Date: Mon,  1 Jun 2026 16:24:43 -0700
Message-ID: <20260601233716.2517987-1-manjunath.b.patil@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606010231
X-Authority-Analysis: v=2.4 cv=T/S8ifKQ c=1 sm=1 tr=0 ts=6a1e17b5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=nvmwOJWoX3ZJLQ4Zfe8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13714
X-Proofpoint-ORIG-GUID: X85s225FTYFJBa6uLv3b5oE-5X4V3XY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIzMCBTYWx0ZWRfX8QLZ+UbH6Hqp
 CMht2HSGOO8GwTsCMYcZ9L5ZHCCJaA5MNW7UgQnji6OhUxo2whz2nhvOet5ugPe9j8ShzP9uPJ0
 /xyx5dRO11jMLuC9w854Fg/kOfa3BcgglHCLIfmAg3n701HUiS6hUjgKuhycpLF4abc9LoceXZr
 hR/c09EqjomcgPoKksX6yrJ4dhtcGfbXTqCSVUP1HGzbx7Mv0PZZ4MvBt2z56ogEcAMf0e3t5eK
 zx4ucC9N6p8llkliNN3CaArC5ElsMJFBdmo6RB439kCrDCVa5clC5sQxo6h3/Pwm373TuypwF0L
 WDQHx0cI7s6YkoffCHP4Qo8eOSKTgi01oPtGyzBG9iPuTzBKw+esOXXh/GvT0Al/vVyPc5m3+MT
 e4MjoJwX4WjXbMs60jFyKLnQrTeLMhXYZsFS6A7t1uFi7DUN9f5Tg76RlXS23qWRmiK+47T5GF6
 Pe3s7mbHuLBQACMJXSD9yjfSLce9BOBF8m++apY4=
X-Proofpoint-GUID: X85s225FTYFJBa6uLv3b5oE-5X4V3XY-

Ftrace keeps trace arrays at a boot-minimum ring-buffer size until
tracing is used. Tracefs event-enable paths already call
tracing_update_buffers() before enabling events, but the exported
in-kernel helpers trace_set_clr_event() and trace_array_set_clr_event()
directly enable events through __ftrace_set_clr_event().

This can leave events enabled by in-kernel users recording into the tiny
boot-minimum buffer instead of the configured default-sized buffer. Any
caller that enables events through these exported helpers observes
different buffer-expansion behavior than a userspace tracefs event enable.

Expand the relevant trace array before enabling events through the
exported in-kernel helpers, matching the tracefs event-enable behavior.
Disabling events remains unchanged.

Assisted-by: Codex:gpt-5
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
---
 kernel/trace/trace_events.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..3ce5b0121c5c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1479,10 +1479,22 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 int trace_set_clr_event(const char *system, const char *event, int set)
 {
 	struct trace_array *tr = top_trace_array();
+	int ret;
 
 	if (!tr)
 		return -ENODEV;
 
+	/*
+	 * Keep in-kernel event enabling consistent with tracefs event
+	 * enabling: once an event is being enabled, expand the boot-minimum
+	 * ring buffer to the configured default size before records arrive.
+	 */
+	if (set) {
+		ret = tracing_update_buffers(tr);
+		if (ret < 0)
+			return ret;
+	}
+
 	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_set_clr_event);
@@ -1504,11 +1516,24 @@ int trace_array_set_clr_event(struct trace_array *tr, const char *system,
 		const char *event, bool enable)
 {
 	int set;
+	int ret;
 
 	if (!tr)
 		return -ENOENT;
 
 	set = (enable == true) ? 1 : 0;
+
+	/*
+	 * Keep in-kernel event enabling consistent with tracefs event
+	 * enabling: once an event is being enabled, expand the boot-minimum
+	 * ring buffer to the configured default size before records arrive.
+	 */
+	if (set) {
+		ret = tracing_update_buffers(tr);
+		if (ret < 0)
+			return ret;
+	}
+
 	return __ftrace_set_clr_event(tr, NULL, system, event, set, NULL);
 }
 EXPORT_SYMBOL_GPL(trace_array_set_clr_event);

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.47.3

