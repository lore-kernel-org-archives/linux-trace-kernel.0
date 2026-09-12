Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4FB415F2E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202347; cv=none; b=T9YWmxwLrJG1JulNwo9itbXzKVJ6QPCx3Do4xyILimQgEn2MmiWYDcCQGU1WJUTClkBIauUjmM6wCr7BziCnnGKhXJDST/00hOoXAzrxm2wb/eAKZ8eAx1HDshicUKUxvKuDp+hLm7I2TJRNuSRvtXb5tJEjV86cvuTIA4oEynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202347; c=relaxed/simple;
	bh=Pq+5Vgu1VB3PWyZZeir7bDV2i2ybWv7icU+9Zp4/3Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hDOiQOG+NeYj49G0+jK4KlOl87W1RkOwbmxeiBsizGB4Jm8Jq8kYf+xfvTB1XZVkClXUqnK1Yd6qQM+EyWPU++6D2VREgqRKcU4kCxNh4ncP/H+2Jf0A66D1rv5LuUvjzd4klALRB3ZHfflE5P6adh63gOV/W8zVfdEH2UAHzNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyXtX6kI; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyXtX6kI"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so174706a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202345; x=1789807145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GH+ZENoy9aMe0Fnez7m6DVSvXxhL01eGLIJjn3AWd2o=;
        b=EyXtX6kI1Gm4WJ1XS2riJPETYUt7+wK/1vBKP0AvXJ+GjlsTDkYQcib/A90Z1Nor17
         i9PO7oiHPl0pMm/0HRb0zQ5EdN0qx5FyIXoAm21as+QZpTVvzP6eMIAV9JBbJXCu/9tj
         izAHu/ggJQh7OvZYnEzw8M8vr/CrPixADSoCIx6ATAjqOq6W36kiBwtORoNlbSewl8MH
         c3esuRIF+5p9Kv7dDiWdp5WuDFq0ai8p1iHcTPwm/aN7AHuMA6INf0BWVo5sCJx+8DRm
         aafbfLcLUTHIzhpVWvQLAyNHmMgYwACXx3gv1p1TyYPKO1daCdn8FoxatPzgz5zGb3la
         RVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202345; x=1789807145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GH+ZENoy9aMe0Fnez7m6DVSvXxhL01eGLIJjn3AWd2o=;
        b=q5CXTxngaodULW/onot0rgxr07rULMWvN8Ss6+qqOKpU3IbTv31Z2Ex6bIAocTPMA5
         RXQs+Bhe/gho9lGmViZQ4Uhp40ELgzF+li3NsnZMENK0MAox1qZqegf6qP04kdclya/p
         qBoN+rnVFJKdeanFxOfLGQMkvyNoP3kCtgQIGzBxcbsF56QaJdRejdxlfTu29hRrm2uj
         ATXj35K4YUv+OUonOHZiHLMQC2twA6JeFFTFwNsKK8x7GP+H4Mn43zwPHHc6w1VSlKJx
         2My1fkA0k1iNm/oZDHQzLe36VstNxLoAnqPRqaCPWkFQwihKNX99YKJeXgdLZcwCML45
         rBiA==
X-Forwarded-Encrypted: i=1; AKwUvBxBFDIIk3Elz8fwxVJc3uQIBe8lQkUWCoiy+PqW+zCGvWqSWSivAt5CBc+xgVQLoaXK66YpMUNnUeCF0LAW+IMrwa8=@vger.kernel.org
X-Gm-Message-State: AFuF++kGNZ6PbL9b3PV6rT99iNmMW9vnKJxBmvEtHuB/G5FZxLr32HN3
	o7/L1qjHsgs5UHSAeNF4q5mi3NKUVj17Ikrkq05m199/sN1ky7627yH4
X-Gm-Gg: AYBFou3hUNCGX2dQc/xdprFuCjR6T5iEJtad8djwL70xZS1ecCQYF9097HF74pgHB78
	kwRo2OwlSwTcTrRIVM5b5gbcjAHf555H9+SMfsvzHOalNbJrsf/a/qM/lrhYP3eQD9ZrT+Fkdd1
	HBzWsxp33LaPmxLtExgNx9wZUKUVFlL7aDToteSop2DaWLpjNw1A6sEBYBzxCDmWM8e+Ct5Tg5j
	PZrgWFxZAr0FabeWQhFqr9lhgVcg5qSZyMLKgWcGUdlFnd9FKGs2LL9cN4jxZpg71konhNRTPJg
	Ok6m3hJvG9ehXQ5Ol8/gbm0pjJ2itKFCebHLL8+sfoSG/k6yFbOv0k7zpXDsgSms6vLXJr/ATu4
	8e1UuBHb/7cf7fZy6lToRKLeSFfv0Ij1pGAvnecol7hXYimX+ADsvxa+rXxluC2behqVDCps2y1
	IREbAOOI00BzCj3BVYttBxr+Al6F6vhtcJ1/iTM+0mAWYOpwhUQbdXahbauWP7IsdD+HjxmZdkn
	Ocy/0e/afOIYvemeP4q3mXXAglxpM8RSfN3FA1e
X-Received: by 2002:a17:90b:28c7:b0:390:84db:888e with SMTP id 98e67ed59e1d1-39d97f34734mr7587196a91.7.1789202344778;
        Sat, 12 Sep 2026 01:39:04 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:02 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	lkp@intel.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: [RFC PATCH v7 03/10] trace: add stackmap statistics interface
Date: Sat, 12 Sep 2026 16:37:46 +0800
Message-Id: <20260912083753.3426176-4-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Export stackmap counters through stack_map_stat: entries, table size,
successes, drops and success rate.

entries is the element-pool allocation cursor: the number of element
records claimed since the last reset. It is not a strict unique-stack
count. Concurrent insertion races can claim duplicate records, and a
sample can include a record claimed before it is published in the hash
table.

successes counts map operations that returned a stack id, while drops
counts capacity and probe-limit failures. The rate is
successes / (successes + drops), so it excludes bypasses that never
call the map, including deep stacks, reset windows and ring-buffer
reservation failures. A fresh or reset map reports 0%.

Take the complete sample under reader_sem. Reset clears next_elt and
the per-CPU atomic_long_t counters under the write side; read those
counters with atomic_long_read() under the read side to avoid combining
values from different generations.

The file is auxiliary. Failure to create it does not disable
stackmap because stack_map remains available to resolve and reset ids.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c          |  14 +++-
 kernel/trace/trace_stackmap.c | 137 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |   1 +
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06ae8ed11475..17df5f85da7a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2199,7 +2199,7 @@ void __ftrace_trace_stack(struct trace_array *tr,
 	 *   - get_id() fails      -> discard the reserved slot, then try
 	 *                            full-stack fallback
 	 * A failed stack-id reservation therefore never consumes a map slot
-	 * or updates the map counters.
+	 * or updates stack_map_stat.
 	 */
 	if (tr->trace_flags & TRACE_ITER(STACKMAP)) {
 		struct ftrace_stackmap *smap;
@@ -9411,6 +9411,18 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 				 */
 				smp_store_release(&global_trace.stackmap, smap);
 				WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_DONE);
+				/*
+				 * stat is an auxiliary observability
+				 * surface. If it fails to be created we keep
+				 * dedup enabled -- the kernel side still
+				 * works and stack_map alone is enough to
+				 * resolve and reset; trace_create_file()
+				 * already pr_warn()s on failure.
+				 */
+				trace_create_file("stack_map_stat",
+						  TRACE_MODE_READ, NULL,
+						  smap,
+						  &ftrace_stackmap_stat_fops);
 			}
 		} else {
 			pr_warn("ftrace stackmap init failed, dedup disabled\n");
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
index b2e2115a15f9..2382c7459712 100644
--- a/kernel/trace/trace_stackmap.c
+++ b/kernel/trace/trace_stackmap.c
@@ -56,6 +56,8 @@
 #include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/overflow.h>
 #include <asm/local.h>
 
 #include "trace.h"
@@ -716,3 +718,138 @@ const struct file_operations ftrace_stackmap_fops = {
 	.llseek		= seq_lseek,
 	.release	= stackmap_release,
 };
+
+/* --- Stats --- */
+
+static u64 stackmap_u64_add_sat(u64 left, u64 right)
+{
+	u64 sum;
+
+	return check_add_overflow(left, right, &sum) ? U64_MAX : sum;
+}
+
+static int stackmap_scaled_cmp(u64 left, u32 left_scale,
+			       u64 right, u32 right_scale)
+{
+	u64 left_hi = mul_u64_u64_shr(left, left_scale, 64);
+	u64 right_hi = mul_u64_u64_shr(right, right_scale, 64);
+	u64 left_lo = left * left_scale;
+	u64 right_lo = right * right_scale;
+
+	if (left_hi != right_hi)
+		return left_hi < right_hi ? -1 : 1;
+	if (left_lo != right_lo)
+		return left_lo < right_lo ? -1 : 1;
+	return 0;
+}
+
+static u64 stackmap_success_rate(u64 successes, u64 drops)
+{
+	u32 low = 0, high = 100;
+
+	if (!successes)
+		return 0;
+	if (!drops)
+		return 100;
+
+	/*
+	 * Find the largest percentage p satisfying
+	 *
+	 *   p * drops <= (100 - p) * successes
+	 *
+	 * which is equivalent to p <= 100 * successes / (successes + drops),
+	 * without forming the potentially 65-bit denominator. Compare the
+	 * products as 128-bit values split into high and low halves.
+	 */
+	while (low < high) {
+		u32 mid = (low + high + 1) / 2;
+
+		if (stackmap_scaled_cmp(drops, mid, successes, 100 - mid) <= 0)
+			low = mid;
+		else
+			high = mid - 1;
+	}
+
+	return low;
+}
+
+static int stackmap_stat_show(struct seq_file *m, void *v)
+{
+	struct ftrace_stackmap *smap = m->private;
+	u64 successes = 0, drops = 0;
+	u64 cpu_successes, cpu_drops;
+	u32 entries;
+	int cpu;
+
+	if (!smap) {
+		seq_puts(m, "stackmap not initialized\n");
+		return 0;
+	}
+
+	/*
+	 * Sample every counter under the read side of reader_sem. Reset
+	 * clears next_elt and the per-CPU counters under the write side,
+	 * so without this an unserialized read could straddle a reset and
+	 * report a mix of the two generations -- a non-zero entry count
+	 * next to counters that have already been zeroed, for instance.
+	 */
+	down_read(&smap->reader_sem);
+
+	entries = atomic_read(&smap->next_elt);
+	for_each_possible_cpu(cpu) {
+		cpu_successes = atomic_long_read(
+			per_cpu_ptr(smap->successes, cpu));
+		cpu_drops = atomic_long_read(per_cpu_ptr(smap->drops, cpu));
+		successes = stackmap_u64_add_sat(successes, cpu_successes);
+		drops = stackmap_u64_add_sat(drops, cpu_drops);
+	}
+
+	seq_printf(m, "entries:      %u / %u\n", entries, smap->max_elts);
+	seq_printf(m, "table_size:   %u\n", smap->map_size);
+	seq_printf(m, "successes:    %llu\n", successes);
+	seq_printf(m, "drops:        %llu\n", drops);
+	seq_printf(m, "success_rate: %llu%%\n",
+		   stackmap_success_rate(successes, drops));
+
+	up_read(&smap->reader_sem);
+	return 0;
+}
+
+static int stackmap_stat_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_stackmap *smap = inode->i_private;
+	int ret;
+
+	if (!smap)
+		return -ENODEV;
+
+	/* Same open-time tracing policy as the other stackmap files. */
+	ret = tracing_check_open_get_tr(smap->tr);
+	if (ret)
+		return ret;
+
+	ret = single_open(file, stackmap_stat_show, smap);
+	if (ret) {
+		trace_array_put(smap->tr);
+		return ret;
+	}
+	return 0;
+}
+
+static int stackmap_stat_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct ftrace_stackmap *smap = m->private;
+	int ret;
+
+	ret = single_release(inode, file);
+	trace_array_put(smap->tr);
+	return ret;
+}
+
+const struct file_operations ftrace_stackmap_stat_fops = {
+	.open		= stackmap_stat_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= stackmap_stat_release,
+};
diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
index 979d6fd76460..7615e346dfa6 100644
--- a/kernel/trace/trace_stackmap.h
+++ b/kernel/trace/trace_stackmap.h
@@ -19,6 +19,7 @@ int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
 			   unsigned long *ips, unsigned int nr_entries);
 
 extern const struct file_operations ftrace_stackmap_fops;
+extern const struct file_operations ftrace_stackmap_stat_fops;
 
 #else
 
-- 
2.34.1

