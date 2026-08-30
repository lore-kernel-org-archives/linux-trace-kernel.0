Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4174352C35;
	Sun, 30 Aug 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088082; cv=none; b=uHKP6cDQY8r5H2HGqBt55IS5/xm+de+tk5Ral6mjtgL628UNeMocRHQZWMzejCKuFPase5gE21BoTq9/vhQ2vmNwHggapBbk6zFNCx7IMfk/NXS6ORD96AyE1pXVjf0dSFfGFsXat24rnwVeUHk7b6cfca+pI1KoFULXf4Qd4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088082; c=relaxed/simple;
	bh=1NFyqTOg+03XPnHmRfEQV3E/SZ/glhCG7tkjVKm3+qk=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=UoQwAuM7DKGA50mT6xAbjjBw9WSLOewNqVpb3YVUyiQtnARNT8E4a7AF9+XNz7wj87TDxKpIs1byWVDNvffQwNPXb2QpGEgkvTiXGgbfygQumuvNnvEOfXwvjFbXJPW9K1DqVWjyzwbnL3GXFpqTXE2TRQxKLbA0IrsOQSm+5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hXq9203CTz5BNRf;
	Sun, 30 Aug 2026 19:07:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 67UB7gPo002739;
	Sun, 30 Aug 2026 19:07:42 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 30 Aug 2026 19:07:43 +0800 (CST)
X-Zmail-TransId: 2af96a940effb92-dcc0f
X-Mailer: Zmail v1.0
Message-ID: <20260830190743637MhXoixrAPc1rfm-G8eIcg@zte.com.cn>
Date: Sun, 30 Aug 2026 19:07:43 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>
Cc: <mathieu.desnoyers@efficios.com>, <mark.rutland@arm.com>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <zhang.run@zte.com.cn>
Subject: =?UTF-8?B?W1JGQyBQQVRDSCAwLzRdIGZ0cmFjZTogQWRkIHRhc2sgY29tbSBmaWx0ZXJpbmcgZm9yIGZ1bmN0aW9uIHRyYWNpbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 67UB7gPo002739
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sun, 30 Aug 2026 19:07:50 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A940F05.000/4hXq9203CTz5BNRf

Hi Steven and Masami,

This series adds two comm-based task filters for the function and
function_graph tracers:

  set_ftrace_comm
  set_ftrace_notrace_comm

Function tracing currently supports selecting tasks by PID. This makes
it difficult to configure tracing before a service starts, because it
does not have a PID yet. It is also inconvenient to keep tracing the
same service across restarts, as its PID may change. This use case was
suggested by Xuxin, a KSM reviewer.

The new filters match task comm names exactly. When both PID and comm 
include filters are active, a task must match both to be traced. A
match in either the PID or comm notrace filter excludes the task.

To avoid string matching in the function tracing fast path, the filters
are evaluated when a task is scheduled in. The result is stored in the
existing per-CPU cache used by PID filtering. Changing a filter refreshes
the cached result for currently running tasks. If a task's comm changes,
the new name is used the next time the task is scheduled in.

The first two patches prepare the existing PID-filtering infrastructure
by using general task-filter names and centralizing sched_switch probe
registration and per-CPU cache updates. The third patch adds the comm
filters, and the final patch documents their interface and interaction
with PID filters.

This is an RFC intended to discuss whether comm-based task filtering is
a useful direction for function tracing and whether this interface would
be suitable for eventual upstream inclusion. Additional selftests are
planned for the next revision. Feedback on the overall approach and
interface would be greatly appreciated.

Thanks,
Shengming

Shengming Hu (4):
  ftrace: Generalize function task filter names
  ftrace: Centralize task filter state updates
  ftrace: Add exact task comm filtering
  Documentation/ftrace: Document function comm filters

 Documentation/trace/ftrace.rst |  31 +++
 include/linux/ftrace.h         |   4 +-
 kernel/trace/Makefile          |   1 +
 kernel/trace/comm_list.c       | 314 +++++++++++++++++++++++++
 kernel/trace/comm_list.h       |  17 ++
 kernel/trace/fgraph.c          |   4 +-
 kernel/trace/ftrace.c          | 402 ++++++++++++++++++++++++++++++---
 kernel/trace/trace.c           |   5 +
 kernel/trace/trace.h           |  34 ++-
 kernel/trace/trace_events.c    |  16 +-
 kernel/trace/trace_functions.c |   2 +-
 kernel/trace/trace_pid.c       |   8 +-
 12 files changed, 791 insertions(+), 47 deletions(-)
 create mode 100644 kernel/trace/comm_list.c
 create mode 100644 kernel/trace/comm_list.h

-- 
2.25.1
