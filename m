Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7959E364AE;
	Wed, 27 Mar 2024 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529657; cv=none; b=PM/toD/F1Mo/HstrC9Lhjuh7sjVXKBDKKVCVxcvqbWNRgODcFJuu4B+IPvC3PwZgzUvQUIcxj6CB1YIIhnvejcR7e+2LVz1RipHPgAxRNrd9P8eebTGUkFQXbyqi6cPRT5/IHAw2Onz++w+TtR9LSGgNk3BQIUteqBNcnHbUoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529657; c=relaxed/simple;
	bh=F0q1atU/QCJOZoZpsRigCnnKYENo2GCPE2bMe3TQydU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YKmABU3Uv+fMQZCcycH4FtatCY0QmdG2ycucotpDYODoJgyGxxmV7Ld9Ch89mfwsYiLwNn8IxWES+wYBsP6/tdS5BxzlFZ4oPvAQT4BmZxwZBY1/y2tjoZSXVEd0MgDTW1qmJZ/yOXgC43/OMBGrjOaK1cuo5njlYv3+KA2HLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id D794318C709D10;
	Wed, 27 Mar 2024 16:51:02 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 16:51:02 +0800
Date: Wed, 27 Mar 2024 16:50:57 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<tiozhang@didiglobal.com>, <zyhtheonly@yeah.net>, <zyhtheonly@gmail.com>
Subject: [PATCH] trace/sched: add tgid for sched_wakeup_template
Message-ID: <20240327084948.GA28114@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, zyhtheonly@yeah.net,
	zyhtheonly@gmail.com
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

By doing this, we are able to filter tasks by tgid while we are
tracing wakeup events by ebpf or other methods.

For example, when we care about tracing a user space process (which has
uncertain number of LWPs, i.e, pids) to monitor its wakeup latency,
without tgid available in sched_wakeup tracepoints, we would struggle
finding out all pids to trace, or we could use kprobe to achieve tgid
tracing, which is less accurate and much less efficient than using
tracepoint.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
Signed-off-by: Dylane Chen <dylanechen@didiglobal.com>
---
 include/trace/events/sched.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..ea7e525649e5 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -149,6 +149,7 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		__field(	pid_t,	pid			)
 		__field(	int,	prio			)
 		__field(	int,	target_cpu		)
+		__field(	pid_t,	tgid			)
 	),
 
 	TP_fast_assign(
@@ -156,11 +157,12 @@ DECLARE_EVENT_CLASS(sched_wakeup_template,
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
 		__entry->target_cpu	= task_cpu(p);
+		__entry->tgid		= p->tgid;
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
+	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d tgid=%d",
 		  __entry->comm, __entry->pid, __entry->prio,
-		  __entry->target_cpu)
+		  __entry->target_cpu, __entry->tgid)
 );
 
 /*
-- 
2.17.1

