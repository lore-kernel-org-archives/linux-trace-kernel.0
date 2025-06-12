Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BF24DCFD;
	Thu, 12 Jun 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737192; cv=none; b=G1GIiD6Joh227uu9FvZXfN5ZBI6EV/Cj2h+YZJ+e1NWAnc5w7VDwVkk5IARnjlMR+AROGxGLTsskPQl2CO0jxb0Ne98iXcE8m3dDajAuimpeO52cD5BQR2mGxVEoAVFbWe8Ga+14IZa8cClyy/fkcfkVSKqvgfhjRM5Fs2ZglYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737192; c=relaxed/simple;
	bh=+MYLmO3h45+3FluaqjNo1C4kGUkm33i9p/7QserXbWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LcHAtoArjrMET8Pil9QtosRCtD40kTaiiqhJccucAiDYqMqOLD1rnrdxbHijlc72GilrNmn8gg+ke63Hpe/E3Nr+sYs0Q3OwMzlG+uB5SGWxt9MrwqAFJcMuxVkIIhD6oyjsusTm6TVxFd9HEG1GbwvMIvV54tZwlv0cRuZMoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2EA641A18D5;
	Thu, 12 Jun 2025 14:05:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 8114617;
	Thu, 12 Jun 2025 14:05:53 +0000 (UTC)
Date: Thu, 12 Jun 2025 10:05:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracing: sched: Hide numa events under
 CONFIG_NUMA_BALANCING
Message-ID: <20250612100552.39672cf9@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8114617
X-Stat-Signature: f6rcxqiho6dwpqtzg6siqdc7cko7i3qt
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kV1mkGVU8EiBZZ7irNHSZ9kWUPeCW62w=
X-HE-Tag: 1749737153-962936
X-HE-Meta: U2FsdGVkX1+A70jatS1iP0flvejFZwvF1pL9RG8gPNm67dUnGPV24zuaCmb4spnnTN2u6Xp8xCSU0QsQPn/xbyhzJ5yXjU8XSYK203VgGvKkAgHi9qiW9KX9Y/FY3cezcEHSU3UYbgesT2ljDxxTAvHVnqcufGeBo8S0hXOr0IA4bO2yHDE5vHX2lKgX9LPl+xT1Al9XSSo8C8CR9rbmf4shhK+FcixAFRH5yBeGPfrIBJ3397AS1ttIsJ+1O0PYpd9GP/s7p5z/hQ0G1oLef8cPzJu7fVMaUL8esnEAZ7F9OrAtaIvqqoioqGi4p2byYOp+vHob3udAEVXUXtTQ3M9HNNmr0OMIzzS2y1MsYJ/AB5f+7fq+lOtMQFxJ4xlH

From: Steven Rostedt <rostedt@goodmis.org>

The events sched_move_numa, sched_stick_numa and sched_swap_numa are only
called when CONFIG_NUMA_BALANCING is configured. As each event can take up
to 5K of memory in text and meta data regardless if they are used or not,
they should not be defined when used.

Move the #ifdef CONFIG_NUMA_BALANCING to hide these events as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused events cause a warning.

 include/trace/events/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..0243f32e068a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -628,6 +628,7 @@ TRACE_EVENT(sched_process_hang,
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
+#ifdef CONFIG_NUMA_BALANCING
 /*
  * Tracks migration of tasks from one runqueue to another. Can be used to
  * detect if automatic NUMA balancing is bouncing between nodes.
@@ -720,7 +721,6 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
 
-#ifdef CONFIG_NUMA_BALANCING
 #define NUMAB_SKIP_REASON					\
 	EM( NUMAB_SKIP_UNSUITABLE,		"unsuitable" )	\
 	EM( NUMAB_SKIP_SHARED_RO,		"shared_ro" )	\
-- 
2.47.2

