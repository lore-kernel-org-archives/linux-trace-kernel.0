Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699713;
	b=g9vW83fWW3UOUkfHvhixnlB8Kq2QqInhlhh6RLIsK7aJM9bbmNqe0zGwadlBL8/AaQzD
	 LXmJSUkq7c8mF7AygUeIBxLoQkE9ZC7CJb/plo4w4gVCm8asXu6aKEEySD2l3w9vZcRom
	 I1A4NKYl4TTu1ORXU5/N9lcmmeCcgxM4pNT+cvPgXpDG0CwrIILDaY5it7qTF3B7O4QwP
	 g8BFd610xj/Q3kgP/hSX84opIx88i3QdLkvi6YfPeVeEOssJTGBX101GOhdtxwnt1eeDR
	 r2k4AlkilrXUxw/Lz+XJin4t96PLEKA2dNnT+visUk1vsMoA2q+BOKzGkBtFyQIXqgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699713;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9rBo4/E1A2GKNQ5V40S5PrBgHp8w7dTBmq4UoL+RtdU=;
	b=tD5L8fxM5J8C57UnaML+3QytRwlUZjQf7PwDCnko3DxpaeTw/WpLC2v7fFnoyCl4B3xt
	 zi4GnA/YXF85unhUvXrSQ2mGuAbQFI9dDcSE3d7VqDiyN1Og/84tuWyhfI5wfrJXLYcX9
	 fW9Vjr+0KggZFCuB7vTg4m0TG6bMja0uoRL2eahN7eZk7rxQdcMXm/8tCIaF5WUW10WHb
	 pgOXUtbiLILk1gdZX0WtZz9hIdsBVRzP44Ln3ZHKgDUhJJSXeP+VLdagqK0ge73Lb3ed8
	 UgW7HkyJ8LzMyT2AypL31K0yoL4CSyAP+J1NRYtQy9RVC/jpRhHLl219W1cCqylMEOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuBleby7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145B606A31C;
	Thu, 26 Nov 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuBleby7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC6A1F000CF;
	Thu, 26 Nov 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699713;
	bh=9rBo4/E1A2GKNQ5V40S5PrBgHp8w7dTBmq4UoL+RtdU=;
	h=From:To:Cc:Subject:Date;
	b=KuBleby7o1xJBzpPf0++1wnhc87YkP2JAERZaJ7SXBIwIyfcAmNmLFDJQno3PEFW0
	 SFug88phwZIOrN7Z2pXYEtBOYE9/KpBUMCu96rPbXEpfYJpHt+d03HG8VjRnuG9ghZ
	 VuBbrKE8pmsxNVpFMFwc4k7PgZmdLDxmFtiK6JkbVgDzVDoLm1V43K5VUwRa3E0oSB
	 KJBM6dzkSF5rA0UYYOAVAZ/dxF6zdxR8CTr7RTKQqBaGtHo5c3p11zmh67ByLVHZTi
	 q/7k09Lc87laWgl4TqGDvrtb1vOx3q0rFm0f41wToyC1YBqVmbHpoon+7KRGF6/PKH
	 i4zsG2ltXY9tw==
From: Antoine Tenart <atenart@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: vmalik@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Antoine Tenart <atenart@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH] tracing/probes: fix race between probe execution and event unregistering
Date: Thu, 26 Nov 2026 14:28:30 +0100
Message-ID: <20261126132830.14992-1-atenart@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A probe being executed can race with its unregistration happening on a
different CPU and lead to a UaF, which can trigger KASAN or crash the
kernel.

  BUG: KASAN: slab-use-after-free in kretprobe_trace_func+0x68d/0x7e0
  Read of size 8 at addr ffff888173328390 by task hammer/1619
  CPU: 32 UID: 0 PID: 1619 Comm: hammer Tainted: G S   7.4.0-rc1+ #1 PREEMPT(lazy)
  Call Trace:
   kretprobe_trace_func+0x68d/0x7e0
   kretprobe_dispatcher+0x128/0x220
   kretprobe_rethook_handler+0x10f/0x1d0
   rethook_trampoline_handler+0x181/0x510
   arch_rethook_trampoline_callback+0xcd/0x160
   arch_rethook_trampoline+0x2c/0x60
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

The race is the following:

          CPU 0                             CPU 1

  kretprobe_dispatcher
    kretprobe_trace_func
      file = link->file
                              disable_trace_kprobe
                               trace_probe_remove_file
                                 // Frees link after an RCU grace period.
                                 kvfree_rcu_mightsleep(link)
                              unregister_trace_kprobe
                                unregister_kprobe_event
                                  probe_remove_event_call
                                    event_remove
                                      remove_event_from_tracers
                                        // Frees link->file.
                                        event_file_put
      // UaF.
      file->...

Looking back at history, disable_trace_kprobe used to have the following
snippet:

  /* Synchronize with kprobe_trace_func/kretprobe_trace_func
   * to ensure disabled (all running handlers are finished).
   * This is not only for kfree(), but also the caller,
   * trace_remove_event_call() supposes it for releasing
   * event_call related objects, which will be accessed in
   * the kprobe_trace_func/kretprobe_trace_func.
   */
   synchronize_rcu();
   kfree(link);

It made clear synchronize_rcu was not only there for link users, but
also related objects. The comment was lost during refactoring in
b5f935ee1339 ("tracing/probe: Add trace_event_file access APIs for
trace_probe") but synchronize_rcu stayed, in trace_probe_remove_file.

Later, a6ed2aee5464 ("tracing: Switch to kvfree_rcu() API") removed the
synchronize_rcu/kfree pair into a single kvfree_rcu call. This works for
freeing the link but the side effect of protecting related objects was
lost, leading to the UaF described here.

Fix this by restoring the synchronization point in
trace_probe_remove_file. The other snippet of the commit mentioned in
the Fixes tag was fixed in commit fe58f457ad8d ("tracing/osnoise: Call
synchronize_rcu() when unregistering").

Fixes: a6ed2aee5464 ("tracing: Switch to kvfree_rcu() API")
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Hi,

I found this while debugging another (downstream) issue, reusing the
same reproducer on mainline. The reproducer registers/enables and
disables/unregisters a kretprobe on a syscall in a loop while triggering
it (I can share if you're interested). It should work with other probe
types.

I'm not versed into the tracing subsystem so I went the safe way and
reverted back to the previous behaviour. There might be something more
clever to do.

Thanks!
Antoine

 kernel/trace/trace_probe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index cff55dcae36f..8addaf641431 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2841,7 +2841,13 @@ int trace_probe_remove_file(struct trace_probe *tp,
 		return -ENOENT;
 
 	list_del_rcu(&link->list);
-	kvfree_rcu_mightsleep(link);
+
+	/*
+	 * Synchronize with probes being executed. This is not only for freeing
+	 * link but also for related objects (e.g. link->file).
+	 */
+	synchronize_rcu();
+	kvfree(link);
 
 	if (list_empty(&tp->event->files))
 		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-- 
2.56.0

