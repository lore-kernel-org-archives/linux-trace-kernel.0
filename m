Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794758383;
	b=oLnAkLryOWA/eA05ZGxAJbL0mxOAwKV/BCDdGNl/fb/gwBFaqf393zUSrHn/wqFKDjXy
	 mXEMPKH1uWuPIJ+UyZ/ytI64pJbzvwv6vieK1EH6Bk3X5pbiY7PArxoSdkWsQRj++JGP8
	 y3GUarZ2IZPOgWPPEa+7cZaZR37jAJReqZhRFCUr9LmzgU30yPq6yFSAhUBBcyJv/7k4H
	 8/OqKMRs8fdEvxtRm1KNFJoEBHekUZKY4bidUj4Urj1qveiyZMckQDCPcVS4BYCaSJhCy
	 0DHO1mNETDgqnsq2wVRpJP0nY3aSbzPfTVyeoY5fTyS6F6xgiglLzltl/962tZCQiMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
	b=SUshswKeYe1DZ5nrtrBb0yuIErzM4hfGc+hUx3lwlBRClj+BjuXHZQ1lqZ26mhhnvNQT
	 PhQ3gmNFnGml1bculwSRfWqRpsyBlzRG2QeNPhy0BlUzAUsgA6114XEm/xz74NyIrO6mV
	 S0H5glpmCPyD5hdTkL04Sd4o2cb5qojUHV/Xwq4AR9itmqYzSbwCDIygqYQLAoaHMoRgb
	 gxSFtw2tIlKFppbaQ9t0TCoAGpJggnRw5RwXSmjK1tjtUMngwmAoh3kpXoUO0Xhfa9duA
	 EkfnCBMWL24YyEXCS4b/EjQnecW7UI78i88FEuREPApLfJEI0kmawvG4hxT5lVaHaoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygKzYaSv;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20239606A31F
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 15:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20239606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygKzYaSv
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so27679925e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 07:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794758381; x=1795363181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
        b=ygKzYaSvRhuzclPrvO3frMENam1XSgQqd7Xx9HDScTKCo8NIirBjMJiwM8H2cUbGsP
         O83Ax50tu+QQnbI40TxRpVBEgnveKIPH9iMgCGtcuy0JbVlDvcSuvtNkhBp911k90K/7
         idl0x1HqblOmNZ/fuTPHAOqtVVCYmyZP0Y4ZlpITuGRu/CdCaQQDk80f805XYmuC6X++
         DQZpxIuf76ogO7YxehSVTpbc0VorNB1MDesZnwNSI2pD4WAXuXo0kVGr1fCZ4Jwqp6Gu
         Idk9JZxXmych7XxEJFCp+kyD4vi3OKMNbSgh8PiI835smjhw5Ila3ypE1OXgiztbGni3
         OQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794758381; x=1795363181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTFQQMhK3UJMqexJFys6E1k1C7+dAh9ayaPYXn833+U=;
        b=HH4L6EZZk36nZfvdqqkzOVfkUO8VQRqy1llfeCkRQREdSvcVRGbY4ToMOM3w/xrcCI
         PkcaZ8gMOJDWhd9jfYGzh2S+oXlIknw5SV2oAyDMAoghczWGI2Jisy8EUv6jjiZaAW+I
         EEXuRKoLUBbBC4GIdBe/lqfgGrKW2o9xGu3QzRcRbyceoV43cDNo/vbkFClvE0ea2uAU
         egnsdY+ghVNHKWFEEQy4hCBKB/Tyii9F5Axf/QPl38MuQSssqTpUxem9lxP/UEfs+1KN
         MgAfwEmDb0oTAfBDOGZbA5RK27zzJUshVYznsNqwMcGen6fZY1lKLl1nSil60dUGeca4
         VzFQ==
X-Forwarded-Encrypted: i=1; AL+hErHIJAd6jmbU2n2Y7B6hCXqRYkNmboHKXMCjrmjx/2HLmeWoUVkWUv/XwjYMrmL6Lthgco8mTPLmm4NyXzxdlSgr+8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5wyNg6i6SQBlzmziCOoN9qzcYifp3yoIOTvOlFFbjvhE/L+Hq
	maQAWfi72e1rUPpzkYZq34HwYhzuMTGZQxk+WxvE/Qk75o/Mp1gpCLTZ
X-Gm-Gg: AYBFou2SxQ2/6DURYI7stAC9PlWhqmZOigKEj27fUxHY5GpT5hup6n50KgSMPUFFoK9
	O7q4GiZ4knz8N2wiFuFnNAaozw1AK4kTqLHa+fF7Jza81fL7Ca12C3Zfl1gu+BMZKPH496t7nmB
	LJ7sduadrEt/o5zkaAGQrTvULoFBnfkedH/XBxeHRSVplWqqbrX41d/hELNhpk7Y8hJCrKzJPR6
	1qIt4F0+HO2j+/t3YXv1qyv2NGnJ/PQ/Cxy4JMSn5j+rfoCkCnwZOIjjn63gByhwqyNSapDPyh3
	Tpt5EZEDuun9gagZtZa4x91nRC57F3+35jvCNgnbvc8z+xX0j1Pl+TS2LXpmHJBzY+yBCMJd4Xi
	4Z9D23o2oUaPq6wexODQRXhevXHUD1M1MFNkRTghZmzF1TPoZrIe7VborruKcLN4sWJZfz6X8qn
	mrEhR7jffKd8oFa9THQd0TWSNX5/9QMf/tOJ89CGwiLLuVst/UaME2D79T30IpitX4zwf2iGD72
	3fLfXqII6EPHvBQ3xzEKtQLkgYKdo1LQf+7waun+EJAHqm6MB7AyRhnK5fPi0tnImck08gX9vAH
	RXIwwBU20qIIRpW4SZc90wQjcMJhTcCPjg==
X-Received: by 2002:a05:600c:8909:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4bb55a83e95mr127075265e9.24.1794758380829;
        Sun, 15 Nov 2026 07:59:40 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:474b:1700:f61b:bfec:b5f1:a453])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdfebsm204511085e9.7.2026.11.15.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 07:59:40 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: andrii@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] uprobes: avoid postponing return-probe SRCU lease expiration
Date: Sun, 15 Nov 2026 17:59:21 +0200
Message-ID: <20261115155921.260878-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

prepare_uretprobe() reprograms the per-task return-instance timer on every
successfully installed return probe. If a traced outer function remains
active while nested traced calls arrive more frequently than the timeout,
the shared timer keeps moving forward and the outer instance can hold its
SRCU read-side lease indefinitely. This delays unrelated synchronous uprobe
unregister operations that must wait for the same SRCU grace period.

Use timer_reduce() to preserve the earliest pending expiry. Pair a full
memory barrier after publishing a return instance with one before the timer
callback traverses the list. A publisher that observes the earlier timer
as pending must then be visible to that callback - otherwise the producer
rearms the expired timer.

In an x86-64 QEMU reproducer with nested traced calls every 10 ms, an
unrelated tracefs event disable took 7,740 ms on the baseline and 70 ms
with the change. A corrected monotonic-clock regression run measured
2,210 ms versus 79 ms, with 15 additional long-lived timer-boundary
cases and process exit/exec checks passing. Narrow LKMM store-buffering
litmus tests observed the lost-rearm outcome without both barriers and
forbade it when both were present.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/events/uprobes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index caf444762a27..82065863a6c1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2052,6 +2052,9 @@ static void ri_timer(struct timer_list *timer)
 	 */
 	raw_write_seqcount_begin(&utask->ri_seqcount);
 
+	/* Pair with prepare_uretprobe() to avoid a missed rearm. */
+	smp_mb();
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
 
@@ -2304,7 +2307,9 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
 	ri->next = utask->return_instances;
 	rcu_assign_pointer(utask->return_instances, ri);
 
-	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
+	/* Pair with ri_timer() after publishing the instance. */
+	smp_mb();
+	timer_reduce(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
 
 	return;
 free:

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

