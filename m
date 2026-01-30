Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8CF30B527;
	Fri, 30 Jan 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764761; cv=none; b=t19uPJjDhDAdGkWc/xBBuBg8l0FeVnkT6jK9Olg+xVHGpy3E1SXGqQUzzHN8MGN/zaTyhP84pOSdAy9r3qsIaqzLiTgpDhFXEHU+k1dfbZe+6kiJFVYT7yTo3JdsB/sw6kr8Y3ECNQuLdulUs/Wy5xo3vNSZmk/AGwfMqyoHGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764761; c=relaxed/simple;
	bh=iLX4y0rPHJDmXXxwQt4fRkJd2Se+iOij7bRTSePc8SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0vdKoOaob7s7zsusSBSSApzQmM7wi6WPVRs+xGrzEmMymETeoE/PaJ2to25vs714UmC1stcyz0BZiGy/9WNFDELhd5CU1Pl894B0gMnWsPJ8EW6eXiRG27muBSb1xVCznaiLR85fLb/Ghn4ctGrD6wYQnqyC1eh8rcRWpPGAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com; spf=pass smtp.mailfrom=mykolab.com; dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b=qnpXbEpn; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mykolab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="qnpXbEpn"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 267083004C6F;
	Fri, 30 Jan 2026 10:12:35 +0100 (CET)
Authentication-Results: ext-mx-out013.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=mykolab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
	content-transfer-encoding:mime-version:message-id:date:date
	:subject:subject:from:from:received:received:received; s=dkim2;
	 t=1769764354; x=1771578755; bh=ROaqE4xBbu8kLCe9Fgw62V84+APwwmK/
	IZVuGt4P9Iw=; b=qnpXbEpnZrbAA/kYxFz6Xm0n91+VRtTR7S/50d8hOlbuVQKi
	oKbaMG+MpmZaMuzfy16hv1KbTk6sPp0fKwvDXhYVPhaJ96EnmasXEEdtC5/Ujrmj
	Iq9jESPtXVH0coXzXsu1z/oFy6y7WgFSZS4Ts9k2Nd7Jkzc+gReVYbKoxuSMst7m
	73txNc6iYcWVjQPt8oXjxTRsQGwkJ0VzY1vNm2ccDRWNCTmg2cvx3fOeLHGr7XUJ
	pXwl+falTxEs0OPGV3zQ7eRTDmyOzOKDO21EWUx3FqKRW+BoEiWr0wXPptR4knj3
	srCqdsn/UPXo0O0Oe5YgldKGn2e+kxdmiSCO0Q==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: 0.001
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out013.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id e6u4yQDVEHdQ; Fri, 30 Jan 2026 10:12:34 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id 4697930011B6;
	Fri, 30 Jan 2026 10:12:21 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id AB73A2093AC8;
	Fri, 30 Jan 2026 10:12:21 +0100 (CET)
From: Colin Lord <clord@mykolab.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Colin Lord <clord@mykolab.com>
Subject: [PATCH] trace/hwlat: prevent false sharing in get_sample()
Date: Fri, 30 Jan 2026 01:09:06 -0800
Message-ID: <20260130090906.24108-1-clord@mykolab.com>
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

Lock before accessing hwlat_data members, and prevent false sharing by
pulling sample_width into a local variable.

One system this was tested on was a dual socket server with 32 CPUs on
each numa node. With settings of 1us threshold, 1000us width, and
2000us window, this change reduced the number of latency events from
500 per second down to approximately 1 event per minute. Some machines
tested did not exhibit measurable latency from the false sharing.

Signed-off-by: Colin Lord <clord@mykolab.com>
---
Hello, while debugging some poor hwlat results on a server I found this
false sharing. I've tested the patch on multiple servers with many of
the configs suggested by the patch submission checklist. A notable
exception is I wasn't able to test with an SMP disabled build as
multiple tags, including unmodified v6.18, were unable to finish booting
with my config/hardware, however it did compile successfully. My
understanding is that SMP is on its way to being required so I didn't
spend more time on it, but I can do so if it's important. Thanks for
your time and any feedback!

 kernel/trace/trace_hwlat.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 2f7b94e98317..1a4b1409226b 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
  * get_sample - sample the CPU TSC and look for likely hardware latencies
  *
  * Used to repeatedly capture the CPU TSC (or similar), looking for potential
- * hardware-induced latency. Called with interrupts disabled and with
- * hwlat_data.lock held.
+ * hardware-induced latency. Disables interrupts during measurement.
  */
 static int get_sample(void)
 {
@@ -204,6 +203,7 @@ static int get_sample(void)
 	time_type start, t1, t2, last_t2;
 	s64 diff, outer_diff, total, last_total = 0;
 	u64 sample = 0;
+	u64 sample_width;
 	u64 thresh = tracing_thresh;
 	u64 outer_sample = 0;
 	int ret = -1;
@@ -211,6 +211,12 @@ static int get_sample(void)
 
 	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
 
+	mutex_lock(&hwlat_data.lock);
+	sample_width = hwlat_data.sample_width;
+	mutex_unlock(&hwlat_data.lock);
+
+	local_irq_disable();
+
 	kdata->nmi_total_ts = 0;
 	kdata->nmi_count = 0;
 	/* Make sure NMIs see this first */
@@ -267,12 +273,14 @@ static int get_sample(void)
 		if (diff > sample)
 			sample = diff; /* only want highest value */
 
-	} while (total <= hwlat_data.sample_width);
+	} while (total <= sample_width);
 
 	barrier(); /* finish the above in the view for NMIs */
 	trace_hwlat_callback_enabled = false;
 	barrier(); /* Make sure nmi_total_ts is no longer updated */
 
+	local_irq_enable();
+
 	ret = 0;
 
 	/* If we exceed the threshold value, we have found a hardware latency */
@@ -285,8 +293,11 @@ static int get_sample(void)
 		if (kdata->nmi_total_ts)
 			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
 
+		mutex_lock(&hwlat_data.lock);
 		hwlat_data.count++;
 		s.seqnum = hwlat_data.count;
+		mutex_unlock(&hwlat_data.lock);
+
 		s.duration = sample;
 		s.outer_duration = outer_sample;
 		s.nmi_total_ts = kdata->nmi_total_ts;
@@ -303,7 +314,10 @@ static int get_sample(void)
 		}
 	}
 
+	return ret;
+
 out:
+	local_irq_enable();
 	return ret;
 }
 
@@ -361,9 +375,7 @@ static int kthread_fn(void *data)
 		if (hwlat_data.thread_mode == MODE_ROUND_ROBIN)
 			move_to_next_cpu();
 
-		local_irq_disable();
 		get_sample();
-		local_irq_enable();
 
 		mutex_lock(&hwlat_data.lock);
 		interval = hwlat_data.sample_window - hwlat_data.sample_width;

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.51.2

