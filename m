Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793731561;
	b=cacGNHnPn+Xh6hDCOvRyaBDZbgiBPKtfDHMNFHMGWNa0k4B0R5KjnEkQqFyWrPU2OMh7
	 FA4burdNVF1jn25kZOOmFxmpS2HN2DaFkT+jJiPu2KGm19xk82Pd+GU2mQwqL+WZVjg3Q
	 asq1/RaREiM3wVwvTxw57sUNCSWyMbNCRAoVit/j9iUplMALc/WLGcZvKM1y6eNpnhuLl
	 EvCNn64K/wNQqcUe8Hv8GxpFyieAZ066hNOKCAFt92HaJUszis6kz/bDMyIVwy8X+J3Xh
	 vyTkrgcS8P5WCWIAwz2JYhRPJpJDFSIpT/uKeN+7hkHbo0rbyGFvU1AFud+giBC1wiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731561;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OLiL26+JaECzvxzhRI+kjCTDvuR4Lj34ib/t+JPRQp8=;
	b=mnLDAmvQbj1ir96FrHC6CQCgiG7bjqS9LLwlN62t8NLqXX9x2AZoDDdK9Pyqxd7i8oM9
	 WeT34ZH3qFjbJnGFhob86FCH2w4Tqj4Cf5txpgjw0IocAC2mM2nzcba4+R5BhaHrAC6d/
	 t96xcHr8VuOg+JbydBPKCZfIsyEHW5EozOEy6gHsKRmv9DiNhy4LvmzWvx5AbgqCGHC8e
	 GmVeGfsDoWeyhi8bSoERF0ejYXnzzB9Mx8sCkhMVhJ0v5nR7mBDiMI3gbjhTJjkqCkkmn
	 cws/D6OHy3kGpO0kgDwMvDqKIQ/QC5d2OWyOfxGiwZxW9wps/D5MC4ZFCjkV1Kp2Uhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nW9s8ZSu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0057606A329;
	Tue,  3 Nov 2026 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nW9s8ZSu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793731561;
	b=H2dov04ZuYfWR0gEwxWWtRBvmNXnKO6qPSxHx/nlGqGPzhRrQmg8HKDR4xPbVLvoXOnl
	 vAAXuoqPPXLjPdvdH6/kYpPjlU4UHeYGqnyM3v+i1cdMv3YsW/8YDlTkB8IxLfI0TEzky
	 yramL2k7qRzYPbZPsX4Oc2HPrD0Vc6mDJEdmBj6/sIlEWk8TyA9qKN7C350Idd2EqUl2O
	 Gf0ZTwHSbBCtHjOn8aNRiImSEAPsbASeUCOxVwMMjOANW8UbjIPFldrThxTBArlpQalG5
	 S+JDb/liNmYwEM8ufvX6X48ukAnnpWpDTTJ/88+O4Xz0k0Sm2JUjf0M4XHf3tt1o0Xw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793731561;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OLiL26+JaECzvxzhRI+kjCTDvuR4Lj34ib/t+JPRQp8=;
	b=Sw2hEoNjhmRx3hqtFSJq/UTYXb5BTCruOG6iY0iRTlwZoPnlurAy4HGQtaUp38+qEbDW
	 oOHWIJReLOKR3dTAIlrT6YSDgE9P1RHYOMTs34MiaXmaEPu5TlET3fiZoec0CJndzmBI4
	 z2/j9yyRZq3zI4BtAaZ8C5mygf5mXLLaQuB1O0o6ZKMAQl/BS3BxCSffhrzBZQp1k7Kzt
	 vFAW9TBKc4M4a2Hdy3fOhvXYeD2XRNvSN+YO0cYA4GxTgBaGqgT9i2hpA5ef9RyKaJr4/
	 qgzg9D9Lua2Kd0dGh4Fcl3mQkW/zDx5WWVtWJi3K74E16mbxx2l/lnBvLexcKdDU+Kg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 60FBA1F00A02;
	Tue,  3 Nov 2026 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731561;
	bh=OLiL26+JaECzvxzhRI+kjCTDvuR4Lj34ib/t+JPRQp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nW9s8ZSumVD7ng8Ak4Dnns98e+8HnCxfK/rqr+8a0BlOqC1OiT+IcpVd69AWAIIiW
	 8YP87WeFOEYj4fK/A4g595aNYa9p8vK+0muW5MTd4gy672F37UNGfWte64ohCb8Zid
	 1wSCGi+48hFzQCI8HcEA8EBEOZNji4j0I1WVtgrOeT1H+R7UEtx+/E13lty8J4s5Tp
	 0a6MVYO/0A32g0dD8O4NZcTfeaAhFR0i20ESQP2uvn2eNbIWpgYBoFZIgZCjNfjGrU
	 i5gC059tUa+/kHrhRaMamuWz9U2AGDErzbXaCNju3iQGjH3tq3CLPyOGEpIqQ0qDVl
	 DZWN6512XZb7A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C1ED346A8B;
	Tue,  3 Nov 2026 18:45:59 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 03 Nov 2026 13:45:59 -0500
Subject: [PATCH 1/3] kprobes: Disarm disabled optprobe on forced
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
Message-Id: <20261103-kprobes-optprobe-state-v1-1-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
In-Reply-To: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Naveen N Rao <naveen@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793731559; l=2481;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=O1s7x+S8Y9RffIFDZ2Gdq0pngTBLL9OlQLH23gRHjU0=;
 b=6In0Ln+1sBlRCxdaltggdp9+etXkgvKBsIvLEvYDDDm+3+6RbkcyxKYAkZwZum1rM/KeRedhw
 cPeWIbqJR7lBfKHD2S2s7tGL7fxZ5f9pqw0OG70lE/H0dB+IyAMMs9d
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

Disarm a disabled probe on that path like do_unoptimize_kprobes() does.
With the fix, the int3 is gone by the time the probe is freed.

This bug was identified and confirmed with the help of a deterministic
hypervisor currently under development.  The C reproducer below however
hits it within about 10s.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/kprobeopt.c
---
 kernel/kprobes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 11add929ea16..4c35cc24aadc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1006,6 +1006,9 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 					hlist_del_init_rcu(&op->kp.hlist);
 					list_move(&op->list, &cur->freeing_list);
 				} else {
+					/* Disarm probes if marked disabled and not gone */
+					if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
+						arch_disarm_kprobe(&op->kp);
 					list_move(&op->list, &cur->cooling_list);
 				}
 				kick_kprobe_optimizer();

-- 
2.53.0


