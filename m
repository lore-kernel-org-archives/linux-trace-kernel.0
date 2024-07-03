Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C78E6945A;
	Wed,  3 Jul 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977669; cv=none; b=ltnfaYQCesTBdOj5JQWk1+o2CAiMGn/vtghofu5OZMGE1MR0QB13xSET1k7QKsuGxgAI4H2rR+q9+gw6uNqx2bLwk5DVfSsRRguhpT3TMYF/JXEZzJVdOyGkczGeITCoKfOonqJn1yn3+eJwqbtxUqJwj9z1jfoyu5kAXLEBOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977669; c=relaxed/simple;
	bh=OXS1bOzvLhqNwCViyagDjz4vM7bVgZBNZ7u3g4eWfkE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Azz7gsN7udfpLrigg01i8qMF9f3587SthMthuhJvRxNm2bA4PCP7x9vCQcOTHRZD5R/os4HNxp3JTzwaovOIxfzByofgMMmUMXNgRkFZOx2hxcTdOhsudgpQygLOfxipD4p6albeSGiIaENG3pUlssoSoW+jxf4pML3zJgg0R64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 977FB183104549;
	Wed,  3 Jul 2024 11:33:57 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 11:34:02 +0800
Date: Wed, 3 Jul 2024 11:33:53 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: Tio Zhang <tiozhang@didiglobal.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<vineethr@linux.ibm.com>, <akpm@linux-foundation.org>,
	<mathieu.desnoyers@efficios.com>, <tiozhang@didiglobal.com>,
	<mingo@kernel.org>, <mgorman@techsingularity.net>, <peterz@infradead.org>,
	<qyousef@layalina.io>, <vincent.guittot@linaro.org>, <elver@google.com>,
	<zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>
Subject: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Message-ID: <20240703033353.GA2833@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	vineethr@linux.ibm.com, akpm@linux-foundation.org,
	mathieu.desnoyers@efficios.com, mingo@kernel.org,
	mgorman@techsingularity.net, peterz@infradead.org,
	qyousef@layalina.io, vincent.guittot@linaro.org, elver@google.com,
	zyhtheonly@gmail.com, zyhtheonly@yeah.net
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

Switch the order of prev_comm and next_comm in sched_switch's code to
align with its printing order.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
---
 include/trace/events/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbb01b4b7451..a4bd4330db4c 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
-- 
2.17.1

