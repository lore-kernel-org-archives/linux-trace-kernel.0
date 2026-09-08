Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5B51FCB1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858586; cv=none; b=mns8r5vcpus1HxpfSMBXKBPCQtDxr+WleSLsQbm0uqvzPdEVnQr8srKigo4yit6UfT7zABm3MSaMzvJAjUCsIPLir35CddnTrtVQ06bVQceOimNKyWXixY54FlTi3NIeYjuFeOb2drLIQAhr6klrkeX3TYRmO/KO7zx3K/Y/MJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858586; c=relaxed/simple;
	bh=WcDaN6hHiVluvOA2lS8pubL4eTLiYDYeTnKPFd3Fs44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VGtahgtjmIlfU1VPcVpSqmDKXVWPfModJRV/ajmK7U/gk9olExWStWHUSn8Youz4sYc9DNxzcMbWsKrv/z0NkoiuIpzI+TXgM3EaVK0+deVK3Ho+Qc8o1nAPRb4v6RrL4NuxgAAYtzBnBlERPfuiEuY65OQ84XT4dxvfFNitXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfKp1c6n; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfKp1c6n"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49d1a778b9dso6025285e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858582; x=1789463382; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJHTU/SBkLLmpaJ4t49Bu1+HFXy4GBXkX7+X7MengXI=;
        b=WfKp1c6ngkqs63mIu+eY03vs0bHj1YVZePAMw5yla3TtiEWd4pH0mgGY8O9eXbRILt
         W3O9+f2NaKAEFauYMef58rcLnCl+sPl0z332M0vnnQSYLkDTsio/5wV3XzmohhlshRjW
         lcY1ziGx8rlOtCbSwUJMJFP44u80aBpjXoVC+XRjbSR4f0K6DIiqrGyRYHMbxFNJj9px
         AOVA4IWlh+TpkvrvI5mnt+yeuubhZW41tHL8DB8S7HEFs8AvfNrLc1c48DX6yJ9Ke6vI
         5K+OdYL7mQ/4qP2ZhOvQuUonAg6DgsrUwmJsxw4b1uc+e+w/fTh/cz3JyG4gIqBHitBV
         Yf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858582; x=1789463382;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WJHTU/SBkLLmpaJ4t49Bu1+HFXy4GBXkX7+X7MengXI=;
        b=AXTixP42R+uSpUTnzFiFNH0YaVpy+iNgblh+6sY+n6qCcPgUrhTuiZnLZNFfk76Xkp
         48T5b68tfSuIILF9QK9rTPgcyhpkMItsmiQuHkHqH2ywZcDv0hULPVKbdyTDj0zO4SP6
         f9Ube9+Y9DP43g2pSdfaDnVcEPNNGJEah+Ty7GCXiej9HU8+UUPFz9cqvDq3T439LKVS
         2cG2z2cy7gyItRLE2XovCP6NheqVnBCfupHseJTnAI/Bem+vJnPey+sikj48WLFVGZrX
         OeeCES51vHAlglvZq9cuaxnT+I5yH5w4XUg0PU/IMu5J3bPiVQzO0WAwDZYFgemdJ09B
         ao4g==
X-Forwarded-Encrypted: i=1; AKwUvByVSxILoVJqk+FCuXZK+Nmk78/4nhzwVSCnh/sdSJ9m2l782cHXPEoZq6fUgkqyMQpxQLxZfmG+ltIlT4ts9FlEEa8=@vger.kernel.org
X-Gm-Message-State: AFuF++nMGrrKDGclJx3b+qkmb/h0Fgb1N3AvWR8Xygiblb5DPHyCDbrQ
	yCAMcZz5s0fTwwC+c4W2YdYfCj7OuoLIreaF60xLbiMoY9epBTs3qhtuBs8kOr7G0zVjiQv7L8Q
	55n7prOAvf1eqFsxPJQH1+g==
X-Received: from wmpo33.prod.google.com ([2002:a05:600c:33a1:b0:499:58e2:b51f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6d:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49cf7fdd67emr540341955e9.3.1788858582425;
 Tue, 08 Sep 2026 02:09:42 -0700 (PDT)
Date: Tue,  8 Sep 2026 10:09:36 +0100
In-Reply-To: <20260908090937.838544-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908090937.838544-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908090937.838544-3-vdonnefort@google.com>
Subject: [PATCH v2 2/3] tracing: Rename trace_array::entries to capacity
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit 8a5f63637890 ("ring-buffer: Fix subbuf resize race with
ring buffer readers"), "capacity" refers to the memory available for
events, while "entries" refers to the number of events in a ring buffer.
As a consequence, rename trace_array::entries to capacity to align with
this convention and avoid any confusion.

Rename also the helper functions trace_set_buffer_entries and
update_buffer_entries.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace.c          | 26 +++++++++++++-------------
 kernel/trace/trace.h          |  4 ++--
 kernel/trace/trace_snapshot.c | 14 +++++++-------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f0251788ec75..400d7a97e745 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4701,20 +4701,20 @@ int tracer_init(struct tracer *t, struct trace_array *tr)
 	return t->init(tr);
 }
 
-void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val)
+void trace_set_buffer_capacity(struct array_buffer *buf, unsigned long val)
 {
 	int cpu;
 
 	for_each_tracing_cpu(cpu)
-		per_cpu_ptr(buf->data, cpu)->entries = val;
+		per_cpu_ptr(buf->data, cpu)->capacity = val;
 }
 
-static void update_buffer_entries(struct array_buffer *buf, int cpu)
+static void update_buffer_capacity(struct array_buffer *buf, int cpu)
 {
 	if (cpu == RING_BUFFER_ALL_CPUS) {
-		trace_set_buffer_entries(buf, ring_buffer_capacity(buf->buffer, 0));
+		trace_set_buffer_capacity(buf, ring_buffer_capacity(buf->buffer, 0));
 	} else {
-		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_capacity(buf->buffer, cpu);
+		per_cpu_ptr(buf->data, cpu)->capacity = ring_buffer_capacity(buf->buffer, cpu);
 	}
 }
 
@@ -4770,12 +4770,12 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 	}
 
-	update_buffer_entries(&tr->snapshot_buffer, cpu);
+	update_buffer_capacity(&tr->snapshot_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_SNAPSHOT */
 
-	update_buffer_entries(&tr->array_buffer, cpu);
+	update_buffer_capacity(&tr->array_buffer, cpu);
  out_start:
 	tracing_start_tr(tr);
 	return ret;
@@ -5694,8 +5694,8 @@ tracing_entries_read(struct file *filp, char __user *ubuf,
 		for_each_tracing_cpu(cpu) {
 			/* fill in the size from first enabled cpu */
 			if (size == 0)
-				size = per_cpu_ptr(tr->array_buffer.data, cpu)->entries;
-			if (size != per_cpu_ptr(tr->array_buffer.data, cpu)->entries) {
+				size = per_cpu_ptr(tr->array_buffer.data, cpu)->capacity;
+			if (size != per_cpu_ptr(tr->array_buffer.data, cpu)->capacity) {
 				buf_size_same = 0;
 				break;
 			}
@@ -5711,7 +5711,7 @@ tracing_entries_read(struct file *filp, char __user *ubuf,
 		} else
 			r = sprintf(buf, "X\n");
 	} else
-		r = sprintf(buf, "%lu\n", per_cpu_ptr(tr->array_buffer.data, cpu)->entries >> 10);
+		r = sprintf(buf, "%lu\n", per_cpu_ptr(tr->array_buffer.data, cpu)->capacity >> 10);
 
 	mutex_unlock(&trace_types_lock);
 
@@ -5758,7 +5758,7 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 
 	mutex_lock(&trace_types_lock);
 	for_each_tracing_cpu(cpu) {
-		size += per_cpu_ptr(tr->array_buffer.data, cpu)->entries >> 10;
+		size += per_cpu_ptr(tr->array_buffer.data, cpu)->capacity >> 10;
 		if (!tr->ring_buffer_expanded)
 			expanded_size += trace_buf_size >> 10;
 	}
@@ -8475,8 +8475,8 @@ int allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int
 	}
 
 	/* Allocate the first page for all buffers */
-	trace_set_buffer_entries(&tr->array_buffer,
-				 ring_buffer_capacity(tr->array_buffer.buffer, 0));
+	trace_set_buffer_capacity(&tr->array_buffer,
+				  ring_buffer_capacity(tr->array_buffer.buffer, 0));
 
 	return 0;
 }
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5e76f94e7a80..d3d7e88d6172 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -191,7 +191,7 @@ struct trace_array;
 struct trace_array_cpu {
 	local_t			disabled;
 
-	unsigned long		entries;
+	unsigned long		capacity;
 	unsigned long		saved_latency;
 	unsigned long		critical_start;
 	unsigned long		critical_end;
@@ -730,7 +730,7 @@ ssize_t tracing_nsecs_read(unsigned long *ptr, char __user *ubuf,
 ssize_t tracing_nsecs_write(unsigned long *ptr, const char __user *ubuf,
 			    size_t cnt, loff_t *ppos);
 
-void trace_set_buffer_entries(struct array_buffer *buf, unsigned long val);
+void trace_set_buffer_capacity(struct array_buffer *buf, unsigned long val);
 
 /*
  * Should be used after trace_array_get(), trace_types_lock
diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 07b43c9863a2..d7308f3b505f 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -142,18 +142,18 @@ int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
 	if (cpu_id == RING_BUFFER_ALL_CPUS) {
 		for_each_tracing_cpu(cpu) {
 			ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu)->entries, cpu);
+				 per_cpu_ptr(size_buf->data, cpu)->capacity, cpu);
 			if (ret < 0)
 				break;
-			per_cpu_ptr(trace_buf->data, cpu)->entries =
-				per_cpu_ptr(size_buf->data, cpu)->entries;
+			per_cpu_ptr(trace_buf->data, cpu)->capacity =
+				per_cpu_ptr(size_buf->data, cpu)->capacity;
 		}
 	} else {
 		ret = ring_buffer_resize(trace_buf->buffer,
-				 per_cpu_ptr(size_buf->data, cpu_id)->entries, cpu_id);
+				 per_cpu_ptr(size_buf->data, cpu_id)->capacity, cpu_id);
 		if (ret == 0)
-			per_cpu_ptr(trace_buf->data, cpu_id)->entries =
-				per_cpu_ptr(size_buf->data, cpu_id)->entries;
+			per_cpu_ptr(trace_buf->data, cpu_id)->capacity =
+				per_cpu_ptr(size_buf->data, cpu_id)->capacity;
 	}
 
 	return ret;
@@ -193,7 +193,7 @@ void free_snapshot(struct trace_array *tr)
 	 */
 	ring_buffer_subbuf_order_set(tr->snapshot_buffer.buffer, 0);
 	ring_buffer_resize(tr->snapshot_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
-	trace_set_buffer_entries(&tr->snapshot_buffer, 1);
+	trace_set_buffer_capacity(&tr->snapshot_buffer, 1);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
 	tr->allocated_snapshot = false;
 }
-- 
2.55.0.979.g7e5102b832-goog

