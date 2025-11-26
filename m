Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2E2E22BF;
	Wed, 26 Nov 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764148552; cv=none; b=ARqA9G35X/7IrZlY2YnJj9ctPvFftTlTI7omY2I2qfMIFJru2BJfvPuWyy6Pes62AeeKZRK1tvxd1nxbdhVKpidQyz9ga50ttpEFNDUYiBpRhHRkILtO8PGWggz5dF5Q1aQ/fhly/czf+Y+pS8UX6/SQuaLIl6U5bbK4LQ80HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764148552; c=relaxed/simple;
	bh=IsIc2pSWMHVY+KC3Uw4pPzqTZExp4W6SHPUXaRMlIns=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=cxdBgid1Pzc8eo1GazkIymjDsEY+GiRdFvinAmmN6B+N8ocPvKSX3B9UL3QKYhv4A2jLL3wY0TA79c4g1W+WInf0mEmIbcZ+PWR5YmTBqZoU4u9RGkI2b80MOfoYi2JxileKu/EOQ3zX+d45JXRJZRX90llpaWP+ogm2aqXfgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4dGYdr5pnkz57dq;
	Wed, 26 Nov 2025 17:09:04 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4dGYdk49tGz5TCG0;
	Wed, 26 Nov 2025 17:08:58 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4dGYdW6Xskz8Xs7T;
	Wed, 26 Nov 2025 17:08:47 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 5AQ98LU5054204;
	Wed, 26 Nov 2025 17:08:21 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 26 Nov 2025 17:08:24 +0800 (CST)
Date: Wed, 26 Nov 2025 17:08:24 +0800 (CST)
X-Zmail-TransId: 2af96926c388486-e69b8
X-Mailer: Zmail v1.0
Message-ID: <202511261708240123PvauPcd7Xbqx_EDrKkNn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.desnoyers@efficios.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <hu.shengming@zte.com.cn>, <zhang.run@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvM10gZmdyYXBoOiBGaXggYW5kIHRpZ2h0ZW4gUElEIGZpbHRlcmluZyBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5AQ98LU5054204
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Wed, 26 Nov 2025 17:09:05 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6926C3AF.000/4dGYdr5pnkz57dq

From: Shengming Hu <hu.shengming@zte.com.cn>

Function graph tracing did not honor set_ftrace_pid() rules properly.

The root cause is that for fgraph_ops, the underlying ftrace_ops->private
was left uninitialized. As a result, ftrace_pids_enabled(op) always
returned false, effectively disabling PID filtering in the function graph
tracer.

PID filtering seemed to "work" only because graph_entry() performed an
extra coarse-grained check via ftrace_trace_task(). Specifically,
ftrace_ignore_pid is updated by ftrace_filter_pid_sched_switch_probe
during sched_switch events. Under the original logic, when the intent
is to trace only PID A, a context switch from task B to A sets 
ftrace_ignore_pid to A’s PID. However, there remains a window
where B’s functions are still captured by the function-graph tracer. 
The following trace demonstrates this leakage
(B = haveged-213, A = test.sh-385):

 4)  test.sh-385   |               |    set_next_entity() {
 4)  test.sh-385   |   2.108 us    |      __dequeue_entity();
 4)  test.sh-385   |   1.526 us    |      __update_load_avg_se();
 4)  test.sh-385   |   1.363 us    |      __update_load_avg_cfs_rq();
 4)  test.sh-385   | + 14.144 us   |    }
 4)  test.sh-385   |   1.417 us    |    __set_next_task_fair.part.0();
 4)  test.sh-385   | + 77.877 us   |  }
 4)  test.sh-385   |               |  __traceiter_sched_switch() {
 4)  test.sh-385   |   2.097 us    |    _raw_spin_lock_irqsave();
 4)  test.sh-385   |   1.483 us    |    _raw_spin_unlock_irqrestore();
 4)  test.sh-385   | + 14.014 us   |  }
 ------------------------------------------
 4)  test.sh-385   =>  haveged-213  
 ------------------------------------------

 4)  haveged-213   |               |  switch_mm_irqs_off() {
 4)  haveged-213   |   2.387 us    |    choose_new_asid();
 4)  haveged-213   | + 12.462 us   |    switch_ldt();
 4)  haveged-213   | + 45.288 us   |  }
 4)  haveged-213   |   1.639 us    |  x86_task_fpu();
 4)  haveged-213   |               |  save_fpregs_to_fpstate() {
 4)  haveged-213   |   1.888 us    |    xfd_validate_state();
 4)  haveged-213   |   6.995 us    |  }
 ------------------------------------------
 4)  haveged-213   =>  test.sh-385  
 ------------------------------------------

 4)  test.sh-385   |               |    finish_task_switch.isra.0() {
 4)  test.sh-385   |   1.857 us    |      _raw_spin_unlock();
 4)  test.sh-385   |   5.618 us    |    }
 4)  test.sh-385   | ! 446.226 us  |  }
 4)  test.sh-385   |               |  __pte_offset_map_lock() {
 4)  test.sh-385   |               |    ___pte_offset_map() {
 4)  test.sh-385   |   1.933 us    |      __rcu_read_lock();
 4)  test.sh-385   |   6.271 us    |    }
 4)  test.sh-385   |   2.056 us    |    _raw_spin_lock();
 4)  test.sh-385   | + 14.281 us   |  }

The following three logically independent patches fix this defect while
preserving the effectiveness of PID filtering in fgraph：

Patch 1 properly initializes ops->private for fgraph_ops.
Patch 2 switches gops->entryfunc to fgraph_pid_func when PID filtering
is active.
Patch 3 removes the coarse fallback logic, making PID filtering reliable
and consistent with function tracing.

Changes from v1:
https://lore.kernel.org/linux-trace-kernel/20251113135627439rGwzvG7JzdmnN8VMHAfMs@zte.com.cn/
- Split the patch into three independent commits as suggested by Steven
- Add a space after "ftrace_graph_active++" as suggested by Steven

Shengming Hu (3):
  fgraph: Initialize ftrace_ops->private for function graph ops
  fgraph: Check ftrace_pids_enabled on registration for early filtering
  fgraph: fgraph: Remove redundant PID filtering from graph_entry()

 kernel/trace/fgraph.c                | 10 ++++++++--
 kernel/trace/trace.h                 |  9 ---------
 kernel/trace/trace_functions_graph.c |  3 ---
 3 files changed, 8 insertions(+), 14 deletions(-)

-- 
2.25.1
