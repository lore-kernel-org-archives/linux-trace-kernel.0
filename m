Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1608446A1;
	Mon,  9 Dec 2024 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712131; cv=none; b=i8Vg+2Gz/W9snZqZvtpS5G/UK4wXRiX+MCrGj8XIR7SP/fIdE8noi7bu3oemtxD/LhVIBs/59yGp8g2JVFlef4MdrsWkG7VDSkvaiPFTE7yalqtb5mm1l7GSYDGeCuXOdZysvDETz9ZaDb44y0WJ5WFN+xLxcv4xHzma7Thottk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712131; c=relaxed/simple;
	bh=IuZ2XQ5La6w2CIYPeJ7tRxYaceO2siijVzc5McVgygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaVYMieAAstb7drfREPcaec+LBofJkXkmrs8Dp93FSCt+ToIMILfSn2L+GQ08RSaA0Bv9Lq8yzYf47DYXlzKeVHKRx2yw6t2CH+RA+t//t8/cD8fjW/k9RWUDF/Wtgc6ucNunK817ctQ7NkpzLglPwZG2ZLSBT88LO3Rd9e4UIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrHEIhcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrHEIhcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B399C4CED2;
	Mon,  9 Dec 2024 02:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733712130;
	bh=IuZ2XQ5La6w2CIYPeJ7tRxYaceO2siijVzc5McVgygI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrHEIhcSoaQxFNZbjtOj/W3JjvLbjtMZmKY/DOEdJzgIGKfX0OfMMTpmM30qe3VGM
	 V0o6LI7YV9NhBn+b3BULFIFlzP+vuiYg5QVYmEoV+8TZIjBV8L+gIB/tpARl0CpOHs
	 OwKeA+EzWwBwCkk2FV43YlKUIWqEPT+VNOtyEKaozntboiPfXBGXqwSv+g6Rudteoa
	 36KiZPeJbYeAzBYU75PmM/PsVQQ83tVfNtxG/veYhIv8E1FDvCjvAM/r1LTpIbnvtA
	 NleMc7s+9fSXBsECqkpNC+oDTNZG9bokI7a1a6zsdWAt2mAqRi1aVaDSGNcH6SDWX/
	 bITnwsZhPbnNQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/5] kprobes: Remove remaining gotos
Date: Mon,  9 Dec 2024 11:42:04 +0900
Message-ID: <173371212474.480397.5684523564137819115.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173371205755.480397.7893311565254712194.stgit@devnote2>
References: <173371205755.480397.7893311565254712194.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Remove remaining gotos from kprobes.c to clean up the code.
This does not use cleanup macros, but changes code flow for avoiding
gotos.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   63 +++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 34cbbb2206f4..030569210670 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1730,29 +1730,31 @@ static int __unregister_kprobe_top(struct kprobe *p)
 	if (IS_ERR(ap))
 		return PTR_ERR(ap);
 
-	if (ap == p)
-		/*
-		 * This probe is an independent(and non-optimized) kprobe
-		 * (not an aggrprobe). Remove from the hash list.
-		 */
-		goto disarmed;
-
-	/* Following process expects this probe is an aggrprobe */
-	WARN_ON(!kprobe_aggrprobe(ap));
+	WARN_ON(ap != p && !kprobe_aggrprobe(ap));
 
-	if (list_is_singular(&ap->list) && kprobe_disarmed(ap))
+	/*
+	 * If the probe is an independent(and non-optimized) kprobe
+	 * (not an aggrprobe), the last kprobe on the aggrprobe, or
+	 * kprobe is already disarmed, just remove from the hash list.
+	 */
+	if (ap == p ||
+		(list_is_singular(&ap->list) && kprobe_disarmed(ap))) {
 		/*
 		 * !disarmed could be happen if the probe is under delayed
 		 * unoptimizing.
 		 */
-		goto disarmed;
-	else {
-		/* If disabling probe has special handlers, update aggrprobe */
-		if (p->post_handler && !kprobe_gone(p)) {
-			list_for_each_entry(list_p, &ap->list, list) {
-				if ((list_p != p) && (list_p->post_handler))
-					goto noclean;
-			}
+		hlist_del_rcu(&ap->hlist);
+		return 0;
+	}
+
+	/* If disabling probe has special handlers, update aggrprobe */
+	if (p->post_handler && !kprobe_gone(p)) {
+		list_for_each_entry(list_p, &ap->list, list) {
+			if ((list_p != p) && (list_p->post_handler))
+				break;
+		}
+		/* No other probe has post_handler */
+		if (list_entry_is_head(list_p, &ap->list, list)) {
 			/*
 			 * For the kprobe-on-ftrace case, we keep the
 			 * post_handler setting to identify this aggrprobe
@@ -1761,24 +1763,21 @@ static int __unregister_kprobe_top(struct kprobe *p)
 			if (!kprobe_ftrace(ap))
 				ap->post_handler = NULL;
 		}
-noclean:
+	}
+
+	/*
+	 * Remove from the aggrprobe: this path will do nothing in
+	 * __unregister_kprobe_bottom().
+	 */
+	list_del_rcu(&p->list);
+	if (!kprobe_disabled(ap) && !kprobes_all_disarmed)
 		/*
-		 * Remove from the aggrprobe: this path will do nothing in
-		 * __unregister_kprobe_bottom().
+		 * Try to optimize this probe again, because post
+		 * handler may have been changed.
 		 */
-		list_del_rcu(&p->list);
-		if (!kprobe_disabled(ap) && !kprobes_all_disarmed)
-			/*
-			 * Try to optimize this probe again, because post
-			 * handler may have been changed.
-			 */
-			optimize_kprobe(ap);
-	}
+		optimize_kprobe(ap);
 	return 0;
 
-disarmed:
-	hlist_del_rcu(&ap->hlist);
-	return 0;
 }
 
 static void __unregister_kprobe_bottom(struct kprobe *p)

