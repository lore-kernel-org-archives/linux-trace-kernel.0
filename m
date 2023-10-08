Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1110E6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLXsHeUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731F7C116AD;
	Sun,  8 Oct 2023 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696726265;
	bh=8D8u97XDPoWyNaB5aP1e19AHVlAsc8+LTpc7EvD2PFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLXsHeUm0QLB9a5oEg1YIk/BcExTt8EHZgZ5JXPyJ0Ilhxn4xr8NRCjlFfzCMWRn7
	 okPoXq63C9LqVUF5fHZ+3psvWR78ZDK9e0f5ukr7+SDAJjRkfVWUc3JMoeHR8ThRSC
	 S7337kfc0w/hGM34HRtNxgz+zNXrVHUHiVWjrIWrmTL5tLRJGq63pGMCZiFcNDrhAx
	 yCeXTz77JZMWFXXxx072uKMbHKVvrxDyUInbto+BEPZA/LEcJe1woOzM2PuluEjfFX
	 yqQ2Wqv57HdCJTdI3aqpYpN5KAszRc+MAb+7vwcHngCFO1Qf/ZLWTmC1J6Dy+TeYiD
	 h239kIMypJ12w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Atish Patra <atishp@rivosinc.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 7/7] tracing: relax trace_event_eval_update() execution with cond_resched()
Date: Sat,  7 Oct 2023 20:50:53 -0400
Message-Id: <20231008005053.3768625-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005053.3768625-1-sashal@kernel.org>
References: <20231008005053.3768625-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 23cce5f25491968b23fb9c399bbfb25f13870cd9 ]

When kernel is compiled without preemption, the eval_map_work_func()
(which calls trace_event_eval_update()) will not be preempted up to its
complete execution. This can actually cause a problem since if another
CPU call stop_machine(), the call will have to wait for the
eval_map_work_func() function to finish executing in the workqueue
before being able to be scheduled. This problem was observe on a SMP
system at boot time, when the CPU calling the initcalls executed
clocksource_done_booting() which in the end calls stop_machine(). We
observed a 1 second delay because one CPU was executing
eval_map_work_func() and was not preempted by the stop_machine() task.

Adding a call to cond_resched() in trace_event_eval_update() allows
other tasks to be executed and thus continue working asynchronously
like before without blocking any pending task at boot time.

Link: https://lore.kernel.org/linux-trace-kernel/20230929191637.416931-1-cleger@rivosinc.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Tested-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 37be6913cfb27..f29552b009c80 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2240,6 +2240,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

