Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750357;
	b=078bWGw56KG/u+K0hVynKH6+DiiuXoeTABj/wW8VvfXTM/Sxpw8Te9DpXTwbXiiutSuf
	 oelddVPCp2/MEGeIijIwarHVW7JteXsQzxW1LBQYBHyKwZpI+SAe9x+r3+wbx9su89ugs
	 Q8Fg1Yhms5yhIip5/JAGR86nnssXw28/I08zUK2ZsMkbg20lTAbvYqMqILJoKeKM7owF+
	 DLuWOYKlMYH0T+3Zw7OV8xum10ZPo/i6hJBK516S5JQ5F1EPcFWpjiRtutIZMQ80Fr8Qf
	 2v7UHldhWX4TmcfWUqAkZiK6bUo/Gf5os39xoWS5Kx7ZNZnKJzKLcZcc6H/J5C3uVQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OueITjgPJiOqPhTlLFS3/DWCPGpRJaYBRkjxNsSisag=;
	b=FDoZhY1/VA9aTSGGBkIUSDcVZNaquwEVtcUeWwcNYAwilDezj6Zwp3UWf5704VS0K9SC
	 bsSo5mPWEkRciUOTLZcXz9dmwCGJWJdijBuQExMLsP9WZ9e242jIK6u1KmAP+MdGnpriX
	 ArKK3tNCAEujtj/MFKdwiQ7l7Pl5vl5iEhpJF19veQ1GTIrSI8jwXpztGnUQiJO/8dkKF
	 P0MPPm/QQVqiNI+UGmah64IRcqN3NemRIblj9Ys5XzdgU2yP9PIeNtc9Uwpk6xD18Jqth
	 bcES5bVMfBts0+p/LGF5+PiYu+GwhRa84xkbWMlE99dXNAsE4Xttjwia9E6TK1cytCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSIw5J2R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8C606A324;
	Tue,  3 Nov 2026 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSIw5J2R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC031F00919;
	Tue,  3 Nov 2026 23:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750357;
	bh=OueITjgPJiOqPhTlLFS3/DWCPGpRJaYBRkjxNsSisag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YSIw5J2RdBHVm8f5HAm2MoplqMssosm13JN9pftJwLijhrfIGS8jBfupbWfKo2pVL
	 Yf9n0QeHf9lj3dYnOBg2tHRXnFhGrepoBX5Zr2XOH0waiSGr8FHW2uU9mjlg7kdlw+
	 7+TV4w6yLP4EYc6aLu5DYPf3HbOSTHdjObzoRjzfKInFjFeCCDjvIYiIgIMMEUhWMl
	 F/nV0A+uwlmdHNh1a7bcObc8iq2o6UEXQywtpc4GofHvtjA9upSnZtaEKn4RRAQxKv
	 b7vaIe15jDIWz9x1IbDrwQHtgcbuAxK+mMimr88qCm6k74geuY0H7anu6HH6Q23ISV
	 Su1RwOZVp+KkQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 6/8] kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe
Date: Wed,  4 Nov 2026 08:59:13 +0900
Message-ID: <179375035312.247640.1506834064717441186.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
User-Agent: StGit/0.19
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
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When an optimized probe is temporarily disarmed or disabled,
unoptimize_kprobe() places it on the unoptimizing list, but leaves
the relative jump in text until the optimizer thread runs.
__disarm_kprobe() explicitly skips arch_disarm_kprobe() when
kprobe_queued_unopt(p) is true.

However, if __arm_kprobe() is called before the unoptimization pass
executes, it unconditionally called arch_arm_kprobe(p), writing a
breakpoint instruction over the first byte of the jump while leaving the
trailing 4 bytes intact. optimize_kprobe(p) then dequeued the probe from
the unoptimizing queue, leaving the jump opcode overwritten and corrupted
in text.

Skip calling arch_arm_kprobe() in __arm_kprobe() when
kprobe_queued_unopt(p) is true, keeping the existing relative jump intact
while unoptimization is cancelled. If optimize_kprobe() cannot optimize
the probe (e.g. due to a post_handler or disabled optimization), force
unoptimization immediately. Also, in reuse_unused_kprobe(), do not
prematurely clear KPROBE_FLAG_DISABLED or call optimize_kprobe(), leaving
arming and optimization to register_aggr_kprobe().

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ceacd56245c2..0ef3a8701eda 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1059,19 +1059,11 @@ static int reuse_unused_kprobe(struct kprobe *ap)
 {
 	struct optimized_kprobe *op;
 
-	/*
-	 * Unused kprobe MUST be on the way of delayed unoptimizing (means
-	 * there is still a relative jump) and disabled.
-	 */
 	op = container_of(ap, struct optimized_kprobe, kp);
 	WARN_ON_ONCE(list_empty(&op->list));
-	/* Enable the probe again */
-	ap->flags &= ~KPROBE_FLAG_DISABLED;
-	/* Optimize it again. (remove from 'op->list') */
 	if (!kprobe_optready(ap))
 		return -EINVAL;
 
-	optimize_kprobe(ap);
 	return 0;
 }
 
@@ -1262,6 +1254,19 @@ static void __init kprobe_sysctls_init(void)
 }
 #endif /* CONFIG_SYSCTL */
 
+/* Return true if the probe is queued on unoptimizing lists */
+static bool kprobe_queued_unopt(struct kprobe *p)
+{
+	struct optimized_kprobe *op;
+
+	if (kprobe_aggrprobe(p)) {
+		op = container_of(p, struct optimized_kprobe, kp);
+		if (optprobe_queued_unopt(op))
+			return true;
+	}
+	return false;
+}
+
 /* Put a breakpoint for a probe. */
 static void __arm_kprobe(struct kprobe *p)
 {
@@ -1275,21 +1280,11 @@ static void __arm_kprobe(struct kprobe *p)
 		/* Fallback to unoptimized kprobe */
 		unoptimize_kprobe(_p, true);
 
-	arch_arm_kprobe(p);
+	if (!kprobe_queued_unopt(p))
+		arch_arm_kprobe(p);
 	optimize_kprobe(p);	/* Try to optimize (add kprobe to a list) */
-}
-
-/* Return true if the probe is queued on unoptimizing lists */
-static bool kprobe_queued_unopt(struct kprobe *p)
-{
-	struct optimized_kprobe *op;
-
-	if (kprobe_aggrprobe(p)) {
-		op = container_of(p, struct optimized_kprobe, kp);
-		if (optprobe_queued_unopt(op))
-			return true;
-	}
-	return false;
+	if (unlikely(kprobe_queued_unopt(p)))
+		unoptimize_kprobe(p, true);
 }
 
 /* Remove the breakpoint of a probe. */

