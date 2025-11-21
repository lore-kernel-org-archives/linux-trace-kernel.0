Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF630DEA5;
	Fri, 21 Nov 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763552; cv=none; b=HyfnyREn7lpoSZolnk6F4ybHJL7yO4SfHNaIm7ix+yTG/xcJhTbJiDmCzQp1+MGugOB/OeuwL+Uuj1W9EhvxRFM5vBaOJXbdhveJ58LOTWt/H55s9cVpBjspUjTn3/IrQJbBpfTbRBkUE7lzfoh4nkcZ1pY+1/kKkb5PIdBLBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763552; c=relaxed/simple;
	bh=r06lMOju7dH3GRCct23C6+rvA8dzR1iqs8MXWgmhYVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVjkzCmqZPugtXlWMzwe15u9a7leIA815tirgY2R4EXkZ3axCp4M5UN3Eiei9LzvwqzmlZtqKLEYBk1zrTzjsUw7Hel62i6rSD/ogPiYq2YUrwFqTo9NUvG4avhNy6iXENi3oHl0c/2hhK2+0cLszgyFXxQO1Cc58Qr8HxBdJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yKgr93Zu; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L5zJrvpO; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yKgr93Zu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L5zJrvpO"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dCqPk0QmMz9spZ;
	Fri, 21 Nov 2025 23:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8QdM0xOsjAT+RMdPSX35xcAqOEAYrJUatK3vwkqKuc=;
	b=yKgr93ZuwRqifyJDjvN8LAFkFG74goWi1Sm8otTxq9BKYb3URszmTWZ7ayz10KtHHCENvf
	zVPkEeaexxJFER5RVpnxSOpnyc3J7lD991lPXRytZlXDDy2FX+V0U+pyorwgsE8rVEceX2
	BuNEyUBdUkZys5vvlYBh7y2LqJvSZ7+A25geH/xJmcAUvzuJMQxNKRzCuj7UweMGowgHxf
	2hLWR/OCGdOQ2MXY19nkvaY+BnKd9VUUQVRRNSu4f+spsopV/6iCaog8/KipTQzn+CXpdg
	inCY28OFNAWd3GQhHh51vf5nIElpE4NJvxYihMgpqdywtFdRcsjuBnjX/3bXrA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=L5zJrvpO;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8QdM0xOsjAT+RMdPSX35xcAqOEAYrJUatK3vwkqKuc=;
	b=L5zJrvpOJRHg/DPIhSna65fSkA0KNGVMRuMD1HwZ0X/w3oq2gOTTuJfhCtPX3XdmZSf4lY
	IDB7RDkffSYV+fmRB3bC9kfm7i2+q1Q85OGXBx+4yeYZhwz6W3lx6i7eeXDevYQmzaIldo
	ahAb0iUiTfOZ3S37dG4+/RKTEmfD+T11d1YSDZDWW3kEUpf+sKt5o7w+427K7RBvA5HLhH
	wQMp9SjtDBOPkTPUq5g8ccPPLBpZmo1x9/IGobdHfr14um3G/jauIFZcJg5MT9oJ/vdW2n
	uQj3SXOZpWoewHLTmY2LTQbpCGRHxYFuJnjWmIyxnVXzVpUPbvr0zVrNgwZxCw==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 05/13] tracing: Fix multiple typos in trace.c
Date: Fri, 21 Nov 2025 23:18:27 +0100
Message-ID: <20251121221835.28032-7-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e38701ffb1e08e8b465
X-MBO-RS-META: s1i6eok75wtecs8r6rmd49drk5xjn8g3
X-Rspamd-Queue-Id: 4dCqPk0QmMz9spZ

Fix multiple typos in comments:
"alse" -> "also"
"enabed" -> "enabled"
"instane" -> "instance"
"outputing" -> "outputting"
"seperated" -> "separated"

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae95800592d..966d29cc7513 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -125,7 +125,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * If there is an oops (or kernel panic) and the ftrace_dump_on_oops
  * is set, then ftrace_dump is called. This will output the contents
  * of the ftrace buffers to the console.  This is very useful for
- * capturing traces that lead to crashes and outputing it to a
+ * capturing traces that lead to crashes and outputting it to a
  * serial console.
  *
  * It is default off, but you can enable it with either specifying
@@ -134,7 +134,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
  * Set 1 if you want to dump buffers of all CPUs
  * Set 2 if you want to dump the buffer of the CPU that triggered oops
  * Set instance name if you want to dump the specific trace instance
- * Multiple instance dump is also supported, and instances are seperated
+ * Multiple instance dump is also supported, and instances are separated
  * by commas.
  */
 /* Set to string format zero to disable by default */
@@ -5279,7 +5279,7 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 				return -EINVAL;
 			/*
 			 * An instance must always have it set.
-			 * by default, that's the global_trace instane.
+			 * by default, that's the global_trace instance.
 			 */
 			if (printk_trace == tr)
 				update_printk_trace(&global_trace);
@@ -7557,7 +7557,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		migrate_disable();
 
 		/*
-		 * Now preemption is being enabed and another task can come in
+		 * Now preemption is being enabled and another task can come in
 		 * and use the same buffer and corrupt our data.
 		 */
 		preempt_enable_notrace();
@@ -11316,7 +11316,7 @@ __init static void do_allocate_snapshot(const char *name)
 	/*
 	 * When allocate_snapshot is set, the next call to
 	 * allocate_trace_buffers() (called by trace_array_get_by_name())
-	 * will allocate the snapshot buffer. That will alse clear
+	 * will allocate the snapshot buffer. That will also clear
 	 * this flag.
 	 */
 	allocate_snapshot = true;
-- 
2.50.1

