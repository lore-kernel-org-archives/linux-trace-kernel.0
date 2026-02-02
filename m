Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD1721FF4C;
	Mon,  2 Feb 2026 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001193; cv=none; b=XIBVRAYoNqWXwWDbLTqQw8ZE4dp3/Rrqb66b+n7Zb9SO1+VRgPAvNdrBEZ6bNPCkseNFbSfwHuaWdQ9kFi6uJvIldgo0oWzuxT5xn1d/DwDO82tQWuS454Ka/rnKfmzCv73NgwIkFZTYWKH58YxkoJmgQLsquIlE8+kMdXh0Yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001193; c=relaxed/simple;
	bh=hdx1xEeI7N48WsxyAwajkyI2Sjasvb03Zdmp0eCVGdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzsLcwLl6JB2ik44lxGJdmXCqOOsHxAhMen3zBgA7R1GYzcNGqcZZtI0k4n/gcERcticODp8lotJz76aYTJEyTYMiirq2O15zyfEI42phmbBFEks/REZ6yhmG+yOCwe9HEscJNIrLv40EqhHo+iOSEv7ChamF7UHuwV6fKC4+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com; spf=pass smtp.mailfrom=mykolab.com; dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b=b5YT0vZ/; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mykolab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="b5YT0vZ/"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 53DCB20B2772;
	Mon,  2 Feb 2026 03:59:41 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=mykolab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
	content-transfer-encoding:mime-version:message-id:date:date
	:subject:subject:from:from:received:received:received; s=dkim2;
	 t=1770001181; x=1771815582; bh=r+XepG8X/3S71IOhnrQeLWuKEtfEL9kK
	l5dypeRT4Fg=; b=b5YT0vZ/XrPZGVwHlMK84WUBoivtGOjbV+FAg/kHMGqN+MVy
	Gqa3FBs+XtTd/Yl0HmZzJ1pyC2vU/jChbfybOVCxGamD+fknccBpr/yPJGnHgCUY
	B33CPRD0XSpxQV31O0sCAb+rlwKU64XwupE9HWy6m0W7Ki30PrOvbg9/UldWzKgW
	S38r31aqjTn1AglMNdCz/gexc4hvbiYne/PA1S9Ob5J29kZp55hFv1cwArSTkpjL
	50sqsjCH23CxfNXPVl3YW53qO9eulvbVUXl9Hj6cgfLGln5waKCvjPY+QU0W8B/+
	6cG4e3ilyLn7jPORERYovATqUPTX63Ru0194SQ==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ipJA5AqUonMh; Mon,  2 Feb 2026 03:59:41 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 7CE5E20B275C;
	Mon,  2 Feb 2026 03:59:39 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id 250E320C19A5;
	Mon,  2 Feb 2026 03:59:39 +0100 (CET)
From: Colin Lord <clord@mykolab.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Colin Lord <clord@mykolab.com>
Subject: [PATCH v2] trace/hwlat: prevent false sharing in get_sample()
Date: Sun,  1 Feb 2026 18:58:38 -0800
Message-ID: <20260202025838.32057-1-clord@mykolab.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_sample() function in the hwlat tracer assumes the caller holds
hwlat_data.lock, but this is not actually happening. The result is
unprotected data access to hwlat_data, and in per-cpu mode can result in
false sharing. The false sharing can cause false positive latency
events, since the sample_width member is involved and gets read as part
of the main latency detection loop.

Convert hwlat_data.count to atomic64_t so it can be safely accessed
without locking, and prevent false sharing by pulling sample_width into
a local variable.

One system this was tested on was a dual socket server with 32 CPUs on
each numa node. With settings of 1us threshold, 1000us width, and
2000us window, this change reduced the number of latency events from
500 per second down to approximately 1 event per minute. Some machines
tested did not exhibit measurable latency from the false sharing.

Signed-off-by: Colin Lord <clord@mykolab.com>
---
Changes in v2:
- convert hwlat_data.count to atomic64_t
- leave irqs_disabled block where it originally was, outside of
  get_sample()

Thanks for the v1 review Steve, have updated and retested.

cheers,
Colin

 kernel/trace/trace_hwlat.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f7b94e98317..3fe274b84f1c 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -102,9 +102,9 @@ struct hwlat_sample {
 /* keep the global state somewhere. */
 static struct hwlat_data {
 
-	struct mutex lock;		/* protect changes */
+	struct mutex	lock;		/* protect changes */
 
-	u64	count;			/* total since reset */
+	atomic64_t	count;		/* total since reset */
 
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
@@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
  * get_sample - sample the CPU TSC and look for likely hardware latencies
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
- * hardware-induced latency. Called with interrupts disabled and with
- * hwlat_data.lock held.
+ * hardware-induced latency. Called with interrupts disabled.
  */
 static int get_sample(void)
 {
@@ -204,6 +203,7 @@ static int get_sample(void)
 	time_type start, t1, t2, last_t2;
 	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
+	u64 sample_width = READ_ONCE(hwlat_data.sample_width);
 	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
@@ -267,7 +267,7 @@ static int get_sample(void)
 		if (diff > sample)
 			sample = diff; /* only want highest value */
 
-	} while (total <= hwlat_data.sample_width);
+	} while (total <= sample_width);
 
 	barrier(); /* finish the above in the view for NMIs */
 	trace_hwlat_callback_enabled = false;
@@ -285,8 +285,7 @@ static int get_sample(void)
 		if (kdata->nmi_total_ts)
 			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
-		hwlat_data.count++;
-		s.seqnum = hwlat_data.count;
+		s.seqnum = atomic64_inc_return(&hwlat_data.count);
 		s.duration = sample;
 		s.outer_duration = outer_sample;
 		s.nmi_total_ts = kdata->nmi_total_ts;
@@ -832,7 +831,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
 
 	hwlat_trace = tr;
 
-	hwlat_data.count = 0;
+	atomic64_set(&hwlat_data.count, 0);
 	tr->max_latency = 0;
 	save_tracing_thresh = tracing_thresh;
 

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.51.2

