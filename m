Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CB428B519;
	Tue, 22 Jul 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195713; cv=none; b=qYJqRLz6u3YW8DriPq23TyEV8HrSKRE44jzX/SJjY56S0UoCYIjv0l4BwWv6BT474b7FdXK3woVlkAgiwA55mhq4ostv3ELfP39+P5zcJbk/DxJ+Rbq0/TNog5jnqI6ZEhx/I4sRW9AqYg/45GGCmdTOnZVf1OMIKqALT84qzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195713; c=relaxed/simple;
	bh=ik0LwPPBChYMFbJvzVNvj+UKK1VK9GaCVSwA3ajzh2k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RRViLtHSNp8RPBEreDzbHYNuFHh7BJfBx7iAh9/vL/5jWQi+sdD18SfkT2Uwf126qubyYma9Cmx0cOh+dNnooP6ILgPApYWScy8+8WuEDyalFdzz8/v9V4xn2qWdIE+nF0Fz8l5idgtq2lQBA9qK2xdnNgXf/1G3aS3bFrQPTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A6B911313C0;
	Tue, 22 Jul 2025 14:48:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 6F4902001C;
	Tue, 22 Jul 2025 14:48:21 +0000 (UTC)
Date: Tue, 22 Jul 2025 10:48:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] tracing: sched: Hide numa balancing trace events
Message-ID: <20250722104820.6c629734@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F4902001C
X-Stat-Signature: fwniytg46qo6tpj7343k6q7z37zn1h5n
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19deXbdr2jf++Lj2CTNE9ICkeETqJpM14w=
X-HE-Tag: 1753195701-141249
X-HE-Meta: U2FsdGVkX18UINabZgWQ5bRdL1G8W9KSlZizNcUi1ky6a/CmyeLvztJwousOBhLgIBNmh1dRL1LSOqoySYCvXjLZz7+1vOTyH+zLahLTcz4bRTGpmiX6jnW3U1ytkHhAmtj2bB8w2RPJKy2qpscj+IVvWXIOwatFWJMvVAn7N+A+cjDHr7QRLJLlVl9Z0cAb/3vNA5Hg8897sYsjp8Kq5YeDD+gCTilZqcrfJbQFkH3cppn0Enz8OxMeJ/mhwxSqez/hr0/NGPVVxJ27kzeZL8GxoSKmPIaQNfrcMBxQm4HJYiRkVMhImF2pBkI7GcnBMKcyqApIlSGI9oW9tON484+xnpfa8pPAdcZXZ3dyfnl3vEFaOK4Z6BUwuKJgFUtN

From: Steven Rostedt <rostedt@goodmis.org>

The trace events sched_move_numa, sched_swap_numa and sched_stick_numa are
only used when CONFIG_NUMA_BALANCING is enabled. Put an #ifdef guard
around the definitions of these trace events so they are not defined when
numa balancing is not enabled, otherwise they waste a bit of memory being
unused.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 4e6b2910cec3..51776b45549a 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -628,6 +628,7 @@ TRACE_EVENT(sched_process_hang,
 );
 #endif /* CONFIG_DETECT_HUNG_TASK */
 
+#ifdef CONFIG_NUMA_BALANCING
 /*
  * Tracks migration of tasks from one runqueue to another. Can be used to
  * detect if automatic NUMA balancing is bouncing between nodes.
@@ -719,6 +720,7 @@ DEFINE_EVENT(sched_numa_pair_template, sched_swap_numa,
 
 	TP_ARGS(src_tsk, src_cpu, dst_tsk, dst_cpu)
 );
+#endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_NUMA_BALANCING
 #define NUMAB_SKIP_REASON					\
-- 
2.47.2

