Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5A10E6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Oct 2023 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAfpjkhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DA3C433AB;
	Sun,  8 Oct 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696726223;
	bh=9MORRDmkW0p+QabaGRa5KHfF4bdABUb92yojCcyPGB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAfpjkhk44llOQ+1cmfUXPppAIFBhMSuzS5HQjhtR5oNBM9QZRpi8N8sCa8SWeXMK
	 avnqWZxlpw41nOOWJeYmUPc79jGyI6r3wLBsswRGmMFVe3+nX37bbMXfKvDZaaLmZp
	 L88SzjG/me715Nu6g+v5wRlGWuZ+YmGRV3/MhpXQHXzPUy4k7qiBYH0RWtvIsxb3P0
	 m8ffTmP5xpSyegJ522v5EPyHjqLR+xZVxp26p+xSOBaZiHLWk+QR1oSLGALgdm5wSG
	 iAFkNfMNapJQmK+mCiqyziFO1JbVEoG0l7wdbZietjY10nq4ucfUwna22Qp2f3TFPP
	 xowSjnRNIxsAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Atish Patra <atishp@rivosinc.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 8/8] tracing: relax trace_event_eval_update() execution with cond_resched()
Date: Sat,  7 Oct 2023 20:50:09 -0400
Message-Id: <20231008005009.3768314-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005009.3768314-1-sashal@kernel.org>
References: <20231008005009.3768314-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
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
index a46d34d840f69..1221b11ea0098 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2449,6 +2449,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_printk(call, map[i]);
 			}
 		}
+		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
-- 
2.40.1

