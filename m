Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793910734;
	b=0uDNQKFvCZ8Yul8R8U4OQEDakEzeHgtFt3JrheBBE4tGJaQdB+aaWjv5Iw+qb4BUDSfq
	 CspSR29Dt0HaYfcnOsJ44v3Q01/a9a3xqP4Z03nxirPcH4R6f/okIzpq9fjKFVgYEaiMR
	 6PZV/J9mF5S5k6wftM/F4mS/OEnxi0iD2CTaNvAyo0SIPqh/QlO1sM+/d9IbkczS6sscr
	 uFs82VnynJPpYLUFXHpqcQDTijKrUhSM2m++l0qIWA5rBYxllgO8RQ1MoMEUIwcPlMaw4
	 i6N+kmFdstGxn6uehR4wGBCIraKEFPKREP16+s8pjxEhnYqG8blkhWkbr7EPbONMP6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910734;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B4pqTC18lXPsv54Q0j7j4WazEvZLfhkTdtoMDKoEZXE=;
	b=d2Q5OjQ07Tfa6EoxhVNRmuOo1cV/T2blGkGphPzdlpPZpqWaZP8H85VY22T/pqu6poY+
	 uQXbJMYhY4DzyC4RZQ/Ab4YPuFQWD2bBgkhUdCzr+3l7TycCkr50PDyrfAL4LvoQxgg2K
	 HaubIu8GNdwrh10BN9y3lAzNwxXpJ7ryHe3+sUBX23QJm6B/B7q/iYnKs4hiA1xE3ehG4
	 4L4fctxBPYHBVWjsUDgS+hEzc5vGmylx6viZyskx/PUp38e5efyfZynE65oe0u9clmGUI
	 xhM4QyV6Xghba4hAJHAYjM5vWdP4G0qonF5VGRu0FPNp+hFwBqQyncktsN4fU4ZBegg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fr+4IKDW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B3606A32D;
	Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fr+4IKDW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793910733;
	b=PC4eJeUfWzsqoI01FxLenDrN/GKEkLRwWb2BbQN7EZDcwhtIkmNTtwxSV5+g5wdWLWWU
	 jLkwWwf9nLWTDXF3agMRHT7k9pq7LamOgRNSwCJxm40A3JvS3ia972ud9O9GZ+jJ3ThLF
	 AiIHtrhXb6Ju8bnG32vUmXKnNkSduO1tdPSvCXntK3lnwQ7X4ZCBQOUtfIgMh+9HQEAIK
	 62v09WNw83Vj1fOtJRolHRghPdJasWMTduF5DGiDVkRz6R2NXc3VXIr0tolDLHexK+k9L
	 4SHdFFK0yX31mLNjp6yj6qCaGS+6Qp6ggpIlx1cVIHLUvqEBSq6V///tR6N644uWScQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793910733;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=B4pqTC18lXPsv54Q0j7j4WazEvZLfhkTdtoMDKoEZXE=;
	b=ntcg+oIJq81IbpHyKnDjluMYDALTbFj4RR0ztJfdvTQbcB0jKe6TD4Bpg9FcEepYKr4V
	 z/IqKQ1QQkVkk2Aaeo6+sJPAUL+FQTY33B5l3WZ7hiUHXf3fjP+k5YdD9Z5fbHC0RMunI
	 QOiy+EZDXlThz93E/e7AwzRcaa79kbpjn04VeHWMQW7TyPLXEy3J3Th6uQmIyJ1K/f50x
	 Ml49D+upsCKBJ9glLQ1XOjE2DdOY3XHWLqmO+naOyPrREJBGwqNW5PXs/o7HkzG96VSfT
	 yiXF8+hKuWzre+J039O4hu0I/fFJdAaPehIgG44UYVHJ4vhumWAGAw1mp2DSU7OBIKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1ABC11F008A1;
	Thu,  5 Nov 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910733;
	bh=B4pqTC18lXPsv54Q0j7j4WazEvZLfhkTdtoMDKoEZXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Fr+4IKDWnkyq3SQ1Fk1n78Sj9ULNeb0cGuQw/CuOXe9bDs0mR/QakSw/alN4nvYo8
	 8CD7/qbsv6zcdQGe4x//LqL6ho9y+0HfcSSSm9Jy5GNQ2Jr0jMabKXCOx4GoClcWK7
	 4PlH18t5uuhymxT+T/BUFK6ue6q1ruubVse5w48OZdvHlgaRL5JV8tTzple9wk7oFZ
	 tR3SFz8aOriwGyjGbV5azqs89SG2AhKoM4nDZXlCzCF9svzpn0oTgRWh1GVhlvbdc3
	 nY4mpTSxSgd8nTmuE2lB4D72spL4orxItctAIfiPlmIw7TCKADdUk6Kq3MtD+MR5eF
	 DBkVyjZYSMpmg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 982474036F;
	Thu,  5 Nov 2026 20:32:12 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Thu, 05 Nov 2026 15:32:12 -0500
Subject: [PATCH v2 1/3] kprobes: Disarm disabled optprobe on forced
 unoptimization
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-kprobes-optprobe-state-v2-1-7a2f5290baa0@columbia.edu>
References: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
In-Reply-To: <20261105-kprobes-optprobe-state-v2-0-7a2f5290baa0@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793910731; l=2758;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=P+y8hEYt4+rURc1WfT56NFQrukM5dnD5O1ElqHoK6k4=;
 b=g4Vej81DGMv71RaTmwcVscVn0Tsi4i01sNGwRqDTpHJhsCLaooLn9V5Hn8rhjAV55Fu49N1Bg
 y15Kl1B+rhcARZalbXqs/cIhsuEja57c5W4JBZVFO6GVhOpD4vMY704
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A disabled optimized probe can be freed with its int3 still in the
text.  It waits on the unoptimizing list for the optimizer to remove its
jump.  If another probe is armed on one of the bytes that jump replaced,
unoptimize_kprobe() forces the unoptimization and moves the disabled
probe straight to a cooling list without removing its int3:

  Task A (tracefs)                       Task B (optimizer)
  disable k1
    /* k1 queued to unoptimize */
                                         /* still on an earlier batch */
  enable k2 on a byte k1's jump replaced
    unoptimize_kprobe(k1, true)
      /* int3 back, k1 on a cooling list */
  remove k1
    /* k1 freed, int3 left in the text */

The next call into the function then oopses:

  [    9.924313] Oops: int3: 0000 [#1] SMP KASAN NOPTI
  [    9.925627] CPU: 0 UID: 0 PID: 68 Comm: kprobeopt Tainted: G        W            7.3.0-17087-gd865f2677c44 #1 PREEMPT
  [    9.930933] RIP: 0010:__do_sys_sysinfo+0x8/0xe0
  ...
  [    9.949348] Call Trace:
  [    9.949890]  <TASK>
  [    9.950404]  do_syscall_64+0xfb/0x590
  [    9.952027]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ...
  [    9.966436]  </TASK>
  ...
  [    9.968009] Kernel panic - not syncing: Fatal exception in interrupt

Disarm a disabled probe on that path before it goes to the freeing or
cooling list, like do_unoptimize_kprobes() does.  With the fix, the int3
is gone by the time the probe is freed.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 10s.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Changes in v2:
- Disarm a disabled probe before choosing the freeing or cooling list (Masami)

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/kprobeopt.c
---
 kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 11add929ea16..809ed63d6dd8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1000,9 +1000,10 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 				 * for cooling down (or freeing if unused).
 				 */
 				force_unoptimize_kprobe(op);
+				/* Disarm probes if marked disabled and not gone */
+				if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
+					arch_disarm_kprobe(&op->kp);
 				if (kprobe_unused(&op->kp)) {
-					if (!kprobe_gone(&op->kp))
-						arch_disarm_kprobe(&op->kp);
 					hlist_del_init_rcu(&op->kp.hlist);
 					list_move(&op->list, &cur->freeing_list);
 				} else {

-- 
2.53.0


