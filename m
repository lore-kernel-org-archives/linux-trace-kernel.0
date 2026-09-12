Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347B29B799
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202358; cv=none; b=mBQtIPTRVIno0EkvUN+wH41okyenBtn5ravG0VG37IPhVkv56Nbaq2/th19QPK7qNBNGjs6qWN3ey/HMcLIr1zODbL+eGmpwcBmGhgYyEFauvj7Wpy/YfBj/rkuuHAdG1o7rPMpCTWYp4taMmDd+E+YvCOiaEmOXXNCtTigy9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202358; c=relaxed/simple;
	bh=AfM3SFtvPJuTCq/8cbw7DweeLdqiDG5N19h0y2wwpXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTahSXmyQV0fgujoY8fuPgI6DrR0DG24uTVXD6rc7jh1jJc7/N8wPZjOloRxSSstm7Db701doMLa2SqKhe5M01/2MvXV/Jry7OMnHCbQaC5aHF+56FEdo7SEUutsiWEZCBcb0F4XOwqDaRUg70r3VV20+8s+dcpFCP/ruuOy3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8ZjtlkE; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ZjtlkE"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so171935a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789202355; x=1789807155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nEYSFhCFadhxBxnBccGBAOZJpAt0b+wT9YcG2VEzJP8=;
        b=g8ZjtlkE5KRWjcG8cKCMpyo09kD0y09PzB92fp04xXxdWyPB23KXUfiuAbJCCi9An3
         PUpSI3x/xXhSar+R/mveUylsxIRTyKVWKEiT/uUF9ojmAnAfRhf08j2FIuNvS2SpUo0k
         5Swkq32XSfqHecUQoYPk8UJKDAxQYDm3WC6lgDH/hrxuOzN/ImTltGUKgiN2cVdEYlOS
         nm7uIup3VLUApwtqQBdT7e8flFXM2i78xtzfo13NT+52qNIpHHyifBxrPFK+9SxvEUJw
         vUyHapS/K2LANI9c/8ub60oaQlzlGNWLwELAgYxwfCKMzUZ3wJbnuGBX1ULwtj1PdaXn
         pBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789202355; x=1789807155;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nEYSFhCFadhxBxnBccGBAOZJpAt0b+wT9YcG2VEzJP8=;
        b=TGMQ8ocxpHQy4uA0HKDMwSDw9zuQw95Zuh36Mjo4RWRHEFA0AiSlqkEFAiUzrPP1PV
         76xZAWgASTb7WJ2ZACH8v9uqwhyTz5EsDfD394OIlnImj9RAWXk5XblA4+i/YiMkOL0m
         aQLy2wvxteTHJwikhQfjufuEYraKR2jKV4NAlGn93KuIsbT85kjwru2RGEXlXDZoZuLd
         6dArOaCU2flQz7JPZmwch7jT/X7Pyx+K6uTNf6/R8A3G0VWsJA57Fldcwl4LYJWJOYV6
         dMf7quNFCogGWCA4l1WA58c7Ccq9UwhTuah+t//zbgzQNW2l1oVBmqDc7yACe8b/14eo
         nSzw==
X-Forwarded-Encrypted: i=1; AKwUvBxNP+P3bVwa4iDBB7mpGQ10a/y4YXGBQ2n8Ez2JRtlr2L1XlSTBP9EImZKmhAOTITNc8gHD6u9JOx38ZyocP8QAnWo=@vger.kernel.org
X-Gm-Message-State: AFuF++nwOH+QUmbJQ/egbS4eYlZFtnJA9dAIBuH3saORM78RbVDXH2wH
	ZSlby5lXNaM67Yvtc0hof2+osxBC3J925xSoeuYXOUF9BehzvigzGMIX
X-Gm-Gg: AYBFou3+obPr/ZznwQZa86vapuL2obQQ6QXMA4J3XZFr+Q94hEHJhBAaXYUgxnq2qR6
	8PD0QlyfvzAC0fl/6Sso+q8qdVjTLM0h8PnVPIK3K6ENz31Kfj+7+soIFLq6qvK5MoDrO3ilmvN
	LlVeGaCNFzaO2EXUU2qxO/hNZZE6Bwaz7Sgdx7xX3V3wJ3GWuFkzMpHhr3ed6DA6sG8D243wn3K
	TlSW9Newc4lGVrY1JnmDW2c+l6MBh02yyVcStYJcLvkdESDIueuFmQIOf1mx3eP95mRl6OPMwTw
	LZl4WKh3Q9+960WxamfgQ0zpzvAKMRX+PgMf5V/CfABkVkzCJqFWI9iNTVmu0NrjK76c1ll8oMo
	JRt+XPGx3vIfiI9pgjqnuWIChcduyMcmOQJikYtdBgB4+UGMUHD0p8j2TWs9YyJOtLDTbGN+wDI
	zyBOqnlQTKdfIdi4WOZPSO2cStdg4AG/62zky9bz5Kt4VApj7+9/Buq8jzLAuqA1ljKXRccOOR6
	TN1+ICHrJXOBHV9YTbIuB+r3/wXQJX2s+rZZ11i
X-Received: by 2002:a17:90b:1350:b0:398:d132:ba76 with SMTP id 98e67ed59e1d1-39dbc6e44dcmr3636835a91.21.1789202355049;
        Sat, 12 Sep 2026 01:39:15 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:16a3:d08b:6ddb:dec6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95091214sm9790583a91.3.2026.09.12.01.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:39:13 -0700 (PDT)
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
Subject: [RFC PATCH v7 04/10] trace: add stackmap binary export
Date: Sat, 12 Sep 2026 16:37:47 +0800
Message-Id: <20260912083753.3426176-5-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Add stack_map_bin, a native-endian version 1 binary export containing a
header followed by stack id, depth, reference count and IP records.
Userspace detects byte order from the magic value.

Stream records through seq_write() instead of allocating a private
payload snapshot. open() records populated slot numbers in a bitmap and
sets nr_stacks to its exact count. The bitmap uses at most 64 KiB, and
exactly those records are emitted. It fixes record membership, not
payload values, so ref_count can change before a selected record is
written.

seq_file releases reader_sem between read() calls. Track resets with a
u64 generation sampled at open and checked at the start of each later
seq pass. All runtime generation accesses are under reader_sem, so a
plain u64 is sufficient. A changed generation returns -ESTALE rather
than -EAGAIN, which seq_file reserves for internal traversal retries.
Data already buffered by the current pass can be returned first.

Once iteration has reached the end, a later read returns normal EOF even
if reset intervened because no new-generation record can be appended.
A reader that receives -ESTALE must reopen the file.

Export the trampoline sentinel unchanged and apply
trace_adjust_address() to other addresses, matching the text export.

The records contain raw kernel instruction pointers after
trace_adjust_address(). The auxiliary file has mode 0440 and open() uses
tracing_check_open_get_tr(), matching the access boundary of existing raw
tracing interfaces. This rejects LOCKDOWN_TRACEFS and pins the owning
trace array. All open failure paths and release drop that reference after
seq_file state is released. Failure to create the auxiliary file does not
disable stackmap.

Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c          |  18 +-
 kernel/trace/trace_stackmap.c | 327 ++++++++++++++++++++++++++++++++--
 kernel/trace/trace_stackmap.h |  20 +++
 3 files changed, 343 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 17df5f85da7a..68f5eb9a1e96 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4109,8 +4109,8 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 #ifdef CONFIG_FTRACE_STACKMAP
 	/*
 	 * STACKMAP is intentionally global-instance-only: the dedup map,
-	 * its tracefs files and the lifetime/reset semantics are tied
-	 * to the global trace
+	 * its tracefs files (stack_map / stack_map_stat / stack_map_bin)
+	 * and the lifetime/reset semantics are tied to the global trace
 	 * array. options/stackmap is hidden on secondary instances via
 	 * TOP_LEVEL_TRACE_FLAGS, but writes still reach set_tracer_flag()
 	 * through the aggregate trace_options file. Reject the enable on
@@ -9412,17 +9412,21 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 				smp_store_release(&global_trace.stackmap, smap);
 				WRITE_ONCE(stackmap_init_state, STACKMAP_INIT_DONE);
 				/*
-				 * stat is an auxiliary observability
-				 * surface. If it fails to be created we keep
-				 * dedup enabled -- the kernel side still
-				 * works and stack_map alone is enough to
-				 * resolve and reset; trace_create_file()
+				 * stat and bin are auxiliary observability
+				 * surfaces. If they fail to be created we
+				 * keep dedup enabled (the kernel side still
+				 * works, and stack_map alone is enough to
+				 * resolve and reset); trace_create_file()
 				 * already pr_warn()s on failure.
 				 */
 				trace_create_file("stack_map_stat",
 						  TRACE_MODE_READ, NULL,
 						  smap,
 						  &ftrace_stackmap_stat_fops);
+				trace_create_file("stack_map_bin",
+						  TRACE_MODE_READ, NULL,
+						  smap,
+						  &ftrace_stackmap_bin_fops);
 			}
 		} else {
 			pr_warn("ftrace stackmap init failed, dedup disabled\n");
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
index 2382c7459712..439d3be9e351 100644
--- a/kernel/trace/trace_stackmap.c
+++ b/kernel/trace/trace_stackmap.c
@@ -35,17 +35,19 @@
  * collision, linear probing finds the next slot and full memcmp
  * confirms the match.
  *
- * Concurrent userspace readers (cat stack_map) get a best-effort
- * snapshot. They are coherent with the hot path (smp_load_acquire on
- * entry->val); they are also serialized against reset via
- * smap->reader_sem (readers take it in shared mode, reset in
+ * Concurrent userspace readers (cat stack_map / stack_map_bin) get a
+ * best-effort snapshot. They are coherent with the hot path
+ * (smp_load_acquire on entry->val); they are also serialized against
+ * reset via smap->reader_sem (readers take it in shared mode, reset in
  * exclusive mode), so a reset cannot tear a single seq_file pass --
  * it waits for the active read() pass to drop the rwsem before clearing
- * the map. The hot path is coordinated with reset separately, via
- * acquire/release on smap->resetting.
+ * the map. Binary readers spanning multiple read() calls additionally
+ * use a generation check. The hot path is coordinated with reset
+ * separately, via acquire/release on smap->resetting.
  */
 
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <linux/slab.h>
 #include <linux/jhash.h>
 #include <linux/seq_file.h>
@@ -74,7 +76,7 @@
 /*
  * Memory ordering of entry->val: published with smp_store_release()
  * by the inserter; consumed with smp_load_acquire() by every reader
- * that dereferences the elt (get_id, seq_show). This pairs
+ * that dereferences the elt (get_id, seq_show, bin_show). This pairs
  * the writes to elt->{nr,ips,ref_count} (initialized BEFORE the
  * publish) with the reads of those fields (which happen AFTER the
  * load). seq_start / seq_next only test val for NULL and use the
@@ -119,11 +121,19 @@ struct ftrace_stackmap {
 	struct stackmap_entry	*entries;	/* hash table */
 	struct stackmap_elt	*elts;		/* flat element pool */
 	atomic_t		resetting;
+	/*
+	 * Bumped by every completed reset, inside the reader_sem write
+	 * section. A reader that spans several read() calls samples this
+	 * at open() and revalidates it on each pass, so a reset landing
+	 * between two reads is detected instead of silently splicing two
+	 * generations of the map into one output stream.
+	 */
+	u64			generation;
 	/*
 	 * Reader/reset serialization. Held in shared mode (read lock)
-	 * across seq_file iteration; held in exclusive mode (write
-	 * lock) by reset's clearing phase. The hot path (get_id) does
-	 * not take this lock — it
+	 * across each seq_file pass of the text and binary exports;
+	 * held in exclusive mode (write lock) by reset's clearing
+	 * phase. The hot path (get_id) does not take this lock — it
 	 * uses smp_load_acquire/smp_store_release on entry->val and
 	 * the resetting flag for the lock-free protocol.
 	 */
@@ -206,6 +216,7 @@ struct ftrace_stackmap *ftrace_stackmap_create(struct trace_array *tr)
 	smap->hash_seed = get_random_u32();
 	atomic_set(&smap->next_elt, 0);
 	atomic_set(&smap->resetting, 0);
+	smap->generation = 0;
 	init_rwsem(&smap->reader_sem);
 
 	return smap;
@@ -307,10 +318,10 @@ static int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
 
 	/*
 	 * Take the reader_sem in exclusive mode. This serializes the
-	 * memset against any tracefs reader (seq_file iteration) that
-	 * may currently hold the rwsem for read. The Tasks RCU grace
-	 * periods already drained the hot path; this rwsem covers
-	 * process-context export readers.
+	 * memset against any tracefs reader (a seq_file pass of the text
+	 * or binary export) that may currently hold the rwsem for read.
+	 * The Tasks RCU grace periods already drained the hot path; this
+	 * rwsem covers process-context export readers.
 	 */
 	down_write(&smap->reader_sem);
 
@@ -323,6 +334,13 @@ static int ftrace_stackmap_reset(struct ftrace_stackmap *smap)
 		atomic_long_set(per_cpu_ptr(smap->drops, cpu), 0);
 	}
 
+	/*
+	 * Bump inside the write section so a reader holding the read
+	 * side either sees the whole pre-reset generation or the whole
+	 * post-reset one, never a counter from each.
+	 */
+	smap->generation++;
+
 	up_write(&smap->reader_sem);
 
 	/* Release resetting=0 so new get_id() observes a cleared map. */
@@ -402,7 +420,7 @@ int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
 			val = stackmap_load_elt(entry);
 			/*
 			 * READ_ONCE(val->nr) keeps style consistent with
-			 * the seq_show reader. nr is write-once
+			 * the seq_show / bin_show readers. nr is write-once
 			 * (set before publish, never modified afterwards),
 			 * so the load is data-race-free, but READ_ONCE
 			 * silences any analysis tool that flags a plain
@@ -853,3 +871,282 @@ const struct file_operations ftrace_stackmap_stat_fops = {
 	.llseek		= seq_lseek,
 	.release	= stackmap_stat_release,
 };
+
+/* --- Binary export --- */
+
+/*
+ * Binary counterpart of the text export, for userspace that would
+ * rather not parse symbols out of stack_map.
+ *
+ * Between resets, the element pool only grows and populated slots are
+ * not recycled. open() records the populated slot numbers in a bitmap,
+ * then the table is streamed in index order through seq_write(). This
+ * fixes the record set and makes header.nr_stacks exact without copying
+ * stack payloads. Even at the largest supported table, the bitmap is
+ * only 64 KiB per open, rather than a roughly 135 MiB element snapshot.
+ * A reset clears and reuses both the table and pool.
+ *
+ * seq_file drops reader_sem between read() calls, so a reset landing
+ * between two reads of the same fd would otherwise splice two
+ * generations of the map into a single stream. Text output would merely
+ * look confusing, but a binary consumer would parse it as one coherent
+ * dump, so open() samples the generation counter and every pass
+ * revalidates it, failing the read with -ESTALE once it has moved. ESTALE
+ * is intentional: seq_file treats -EAGAIN as an internal traverse retry,
+ * which would make lseek() on a stale fd spin forever. A reader that loses
+ * the race must reopen the file.
+ *
+ * The records contain raw kernel instruction pointers after
+ * trace_adjust_address(). VFS mode checks provide the tracefs permission
+ * boundary, and open additionally uses tracing_check_open_get_tr() for the
+ * tracing lockdown check and to pin the owning trace array for the lifetime
+ * of the file.
+ */
+struct stackmap_bin_iter {
+	struct ftrace_stackmap	*smap;
+	u64			generation;	/* sampled at open() */
+	u32			nr_stacks;	/* selected at open() */
+	bool			locked;		/* reader_sem held by start() */
+	/*
+	 * Staging buffer for one full-depth entry, kept here rather than
+	 * on the stack: the IP array alone is 512 bytes, which has no
+	 * business in a seq_file show() frame. Emitting an entry in a
+	 * single seq_write() also keeps it from being torn across a
+	 * buffer-growth retry.
+	 */
+	char			ebuf[sizeof(struct ftrace_stackmap_bin_entry) +
+				     FTRACE_STACKMAP_MAX_DEPTH * sizeof(u64)]
+				     __aligned(8);
+	/* Populated table slots selected during the open-time scan. */
+	unsigned long		*slots;
+};
+
+/*
+ * Advance to the first populated slot at or after *idx. Sets *idx to
+ * map_size when the table is exhausted, so a later call terminates
+ * immediately.
+ */
+static struct stackmap_entry *stackmap_bin_seek(struct stackmap_bin_iter *iter,
+						loff_t *idx)
+{
+	struct ftrace_stackmap *smap = iter->smap;
+	unsigned long i;
+
+	i = find_next_bit(iter->slots, smap->map_size, *idx);
+	if (i >= smap->map_size) {
+		*idx = smap->map_size;
+		return NULL;
+	}
+
+	*idx = i;
+	return &smap->entries[i];
+}
+
+/*
+ * Stream position 0 is the file header; position idx+1 is table slot
+ * idx. Deriving it from the slot index keeps the iteration idempotent
+ * across the retries seq_file performs when its buffer has to grow.
+ */
+static void *stackmap_bin_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct stackmap_bin_iter *iter = m->private;
+	struct ftrace_stackmap *smap = iter->smap;
+	struct stackmap_entry *entry;
+	loff_t idx;
+
+	/*
+	 * Serializes against the clearing phase of ftrace_stackmap_reset().
+	 * Dropped in stackmap_bin_seq_stop(), which seq_file calls after
+	 * every pass, including the ones where start() reports an error.
+	 */
+	down_read(&smap->reader_sem);
+	iter->locked = true;
+
+	/*
+	 * The table has already been walked to the end. There is nothing
+	 * left to hand over, so a reset that happened in the meantime
+	 * cannot splice generations into this stream: report EOF rather
+	 * than an error. Otherwise a reader that had already consumed the
+	 * whole export would take a failure on its final read() and treat
+	 * the data it holds as invalid.
+	 */
+	if (*pos > smap->map_size)
+		return NULL;
+
+	if (smap->generation != iter->generation)
+		return ERR_PTR(-ESTALE);
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	idx = *pos - 1;
+	entry = stackmap_bin_seek(iter, &idx);
+	*pos = idx + 1;
+	return entry;
+}
+
+static void *stackmap_bin_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct stackmap_bin_iter *iter = m->private;
+	struct ftrace_stackmap *smap = iter->smap;
+	struct stackmap_entry *entry;
+	loff_t idx;
+
+	if (v == SEQ_START_TOKEN)
+		idx = 0;
+	else
+		idx = ((struct stackmap_entry *)v - smap->entries) + 1;
+
+	entry = stackmap_bin_seek(iter, &idx);
+	*pos = idx + 1;
+	return entry;
+}
+
+static void stackmap_bin_seq_stop(struct seq_file *m, void *v)
+{
+	struct stackmap_bin_iter *iter = m->private;
+
+	if (iter->locked) {
+		up_read(&iter->smap->reader_sem);
+		iter->locked = false;
+	}
+}
+
+static int stackmap_bin_seq_show(struct seq_file *m, void *v)
+{
+	struct stackmap_bin_iter *iter = m->private;
+	struct ftrace_stackmap_bin_entry *e;
+	struct stackmap_entry *entry;
+	struct stackmap_elt *elt;
+	u32 i, nr;
+
+	if (v == SEQ_START_TOKEN) {
+		struct ftrace_stackmap_bin_header hdr = {
+			.magic		= FTRACE_STACKMAP_BIN_MAGIC,
+			.version	= FTRACE_STACKMAP_BIN_VERSION,
+			.nr_stacks	= iter->nr_stacks,
+			.reserved	= 0,
+		};
+
+		seq_write(m, &hdr, sizeof(hdr));
+		return 0;
+	}
+
+	entry = v;
+	elt = stackmap_load_elt(entry);
+	if (!elt)
+		return 0;
+
+	nr = READ_ONCE(elt->nr);
+	if (nr > FTRACE_STACKMAP_MAX_DEPTH)
+		nr = FTRACE_STACKMAP_MAX_DEPTH;
+
+	e = (struct ftrace_stackmap_bin_entry *)iter->ebuf;
+	e->stack_id = entry - iter->smap->entries;
+	e->nr = nr;
+	e->ref_count = atomic_read(&elt->ref_count);
+	e->reserved = 0;
+
+	for (i = 0; i < nr; i++) {
+		unsigned long ip = elt->ips[i];
+
+		/*
+		 * Emit the trampoline marker verbatim so userspace can
+		 * render it as [FTRACE TRAMPOLINE]; pass everything else
+		 * through trace_adjust_address() so the binary export
+		 * follows the same address-adjustment rules as the text
+		 * export.
+		 */
+		if (ip == FTRACE_TRAMPOLINE_MARKER)
+			e->ips[i] = (u64)FTRACE_TRAMPOLINE_MARKER;
+		else
+			e->ips[i] = (u64)trace_adjust_address(iter->smap->tr, ip);
+	}
+
+	seq_write(m, e, struct_size(e, ips, nr));
+	return 0;
+}
+
+static const struct seq_operations stackmap_bin_seq_ops = {
+	.start	= stackmap_bin_seq_start,
+	.next	= stackmap_bin_seq_next,
+	.stop	= stackmap_bin_seq_stop,
+	.show	= stackmap_bin_seq_show,
+};
+
+static int stackmap_bin_open(struct inode *inode, struct file *file)
+{
+	struct ftrace_stackmap *smap = inode->i_private;
+	struct stackmap_bin_iter *iter;
+	struct seq_file *m;
+	u32 nr = 0;
+	loff_t i;
+	int ret;
+
+	if (!smap)
+		return -ENODEV;
+
+	ret = tracing_check_open_get_tr(smap->tr);
+	if (ret)
+		return ret;
+
+	ret = seq_open_private(file, &stackmap_bin_seq_ops, sizeof(*iter));
+	if (ret)
+		goto put_tr;
+
+	m = file->private_data;
+	iter = m->private;
+	iter->smap = smap;
+	iter->slots = kvcalloc(BITS_TO_LONGS(smap->map_size),
+			       sizeof(*iter->slots), GFP_KERNEL_ACCOUNT);
+	if (!iter->slots) {
+		ret = -ENOMEM;
+		goto release_seq;
+	}
+
+	/*
+	 * Select the populated slots up front so header.nr_stacks exactly
+	 * frames the records emitted by this fd. The bitmap copies only
+	 * membership, not stack payloads; at the maximum map size it uses
+	 * 64 KiB. Inserts after this scan are deliberately excluded.
+	 */
+	down_read(&smap->reader_sem);
+	iter->generation = smap->generation;
+	for (i = 0; i < smap->map_size; i++) {
+		if (READ_ONCE(smap->entries[i].key) &&
+		    stackmap_load_elt(&smap->entries[i])) {
+			__set_bit(i, iter->slots);
+			nr++;
+		}
+	}
+	up_read(&smap->reader_sem);
+
+	iter->nr_stacks = nr;
+	return 0;
+
+release_seq:
+	seq_release_private(inode, file);
+put_tr:
+	trace_array_put(smap->tr);
+	return ret;
+}
+
+static int stackmap_bin_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_bin_iter *iter = m->private;
+	struct ftrace_stackmap *smap = iter->smap;
+	int ret;
+
+	kvfree(iter->slots);
+	ret = seq_release_private(inode, file);
+	trace_array_put(smap->tr);
+	return ret;
+}
+
+const struct file_operations ftrace_stackmap_bin_fops = {
+	.open		= stackmap_bin_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= stackmap_bin_release,
+};
diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
index 7615e346dfa6..80415b985627 100644
--- a/kernel/trace/trace_stackmap.h
+++ b/kernel/trace/trace_stackmap.h
@@ -7,6 +7,25 @@
 
 #define FTRACE_STACKMAP_MAX_DEPTH	64
 
+/* Binary export format */
+#define FTRACE_STACKMAP_BIN_MAGIC	0x46534D42	/* 'FSMB' */
+#define FTRACE_STACKMAP_BIN_VERSION	1
+
+struct ftrace_stackmap_bin_header {
+	u32 magic;
+	u32 version;
+	u32 nr_stacks;
+	u32 reserved;
+};
+
+struct ftrace_stackmap_bin_entry {
+	u32 stack_id;
+	u32 nr;
+	u32 ref_count;
+	u32 reserved;
+	u64 ips[];		/* nr entries follow the header */
+};
+
 struct trace_array;
 
 #ifdef CONFIG_FTRACE_STACKMAP
@@ -20,6 +39,7 @@ int ftrace_stackmap_get_id(struct ftrace_stackmap *smap,
 
 extern const struct file_operations ftrace_stackmap_fops;
 extern const struct file_operations ftrace_stackmap_stat_fops;
+extern const struct file_operations ftrace_stackmap_bin_fops;
 
 #else
 
-- 
2.34.1

