Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030730;
	b=kK8h9Wl2QnV+bXzzgXfaGsuEd2bclKQjxpuJHyorPfJgpsdnijt5Zi3z4AGUD1PwW8zE
	 jWouYL9o0vSd6DXWkMqdSHrks815FwNOuHN3bL7znPkjUUKVQmwvhK96M99x3GDh3Fkjd
	 D7IodeDJPuAdSUZ8IkGokLMneMYiNzslS8r3GBDAKoy1V9XUF6bMpQsSP4BXHX4fZ5qGH
	 pM4MUY4qANtFkMisTAc5s0Zm+YNUjG12rcfY4j85O3Ybvwlz5vBZB0WEAg8pmwidP/5ze
	 pbR3EDPCb/t1RLJa86le3ySn07VQI4NGa8xtEjAt1zv6wy0EZwYQldrqg3WB+0UrWnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OFqRzNE7c/9ftDw44+RvgDz2QlrmmPPw6Nalq+0fH5U=;
	b=pqQqRMuDBlaoRKAyYiDZhO8R7PQ95bXixNyH3dMklLlJRmIP28HoPHVhg49mvdy5xtbJ
	 z336zjK4FxgAB1VLmZ2IwCgJK6yXyihxJUzRzHnCn+myJBAVd6sL/3IpIZ5OhE4TcByx8
	 xXNPBTvZVputKDdgKKX3EUax/s+7xkakVfTYglBpmh6mXrkFGnM8eyNdg7LdQ0+q8oiv1
	 0jXXZUI1cbQFWmJr4r1WXfKpnHhjsJlAR7vzIG9BYmsPlbd1dL9i+VD4CJY2/aSr3TXxT
	 HS6S0SafBiCO9nCnWcxHtJuTaO3PqPCYKDG7k9LtiFPOJIEjNOfDTb6BO0ZKt0NSjUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4WDVBng;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0962606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0962606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4WDVBng
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d7791b00so9846185ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030729; x=1794635529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OFqRzNE7c/9ftDw44+RvgDz2QlrmmPPw6Nalq+0fH5U=;
        b=j4WDVBngxZYRef12ufkeoRP/TLMECt+22kfF8Y0TjSR6f/uR3Qwe/+jJPEsVd4HI5i
         Exk6VzR0VvkCO+cfdaEggvv7sEcI51LJPq0gkbl8TL2OrWL88RMvS1ptP6ajHx133mKj
         NyMFVgD8LQt2RYQHBShK5eojEnm2Vt/hf8KBjJSjfyP6l5ia3AfrEA3K8dB4Y9vMHzak
         yKjYkCWX80WCrUgEsKu5ixT7BLjT19zD68kZq1vw4MzAwMigRdXev6dxGffC6/MsTzrj
         QIsq800rdY61w7S8YcYEnh/ZITbncTmTOhR09U3wWJIXveoj29YYDJRGUhrMaK6IzwMo
         fErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030729; x=1794635529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OFqRzNE7c/9ftDw44+RvgDz2QlrmmPPw6Nalq+0fH5U=;
        b=zzr9C6rBAn/VQYVQnWDr/KQzxzAStGRJOkQuhPKIvYo9GdxK3syVzADrqbh1D2DTYV
         CdMWAZ43j4TwELOTOfJD4/ImXpkPDXoxbPi3xOsAaXbb9CmDY0EW6iDo3TbJv8BFwQto
         0Z2f+oDEafUBkJZPizd/ONO1mtIwlSWsYS0jfnc06RGAMDcvOyLdtnQ/att1kR766FFQ
         DQHcd7WXkLV2GbBUErqWP1ImizqMJJFxyDdP2iKlUwCtV7cw2IGHad9FCBD+Tx78hete
         yKwLIijudglbdvKCMUm2j+4Ss+dtGjgKDm+zB12XgX7VreGlRXcLPI1LvLhxku487SwU
         ZzLA==
X-Forwarded-Encrypted: i=1; AL+hErHPmXUqtK3QDPLMHWojxLNgEZhkqRKtSZefRrvX3hzJt6GMmYHzSY9Tc8H8FAFzJRP+Pknpmh65kXzAQmU+eEg2cAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ueU7IpXSQHalNGpz0kUfDondWYA6qafbpZHJcDNxi3AyYd9v8
	w3G31bplhVO/+6N/JvyS4UI0uWISxSIpVmOMjyaQ+uC2trGJMX2PBfiu
X-Gm-Gg: AYBFou399cMHsqKtajAVZhlqKEO+lDGO/DvfPrI59FejHg0sIpoQu2cEU118QPywG/O
	KbthiVr1/SiZv2QgFgrQGOjDru164klhNJ5SChH4Ox4/awAKjZKQS9/ajf6JgiIbQpUhjXkpDye
	nUP5+6pwNI12Pd15BL+a6K+uFsiLBLH0kScKzq2tUf4S8q7+76Ggi68EPFeAEQFI9b+000iTNnB
	WaQXvDrB0u2T3CsVEgNnWTZ6lArlgkImtbC1Fu1EDcmJrrItHiAG1oix17BT8mK4nWks8NOr8Hp
	L8E3JvXWbhQVi6xgHbJCYAgNSZqplK2+rkFc582aPZri4B4fxBbpuxz017g/UPgSFDQJa8JC8Va
	+G3kMlsk6gUQPtmib5UhmtyV9tQnauHO+o4NNvMdvXUmkuqr8WInCkiK+WV6UZyy95zZUv1IwlN
	/tDAKvkXbRUCRZ3hrmI1W/Lrymbmd8FZ7cygbNbnrFpsuVYriJj1ei9LXIitJb0TeQFfauMQIwP
	GXf/9e/T49Ne0pXmGwq8ITpsgBkkw1BtPjWGksYXXPclbyJ5hMFidwy94eKB0mEqfQ3nK7+0sbp
	K63iEtO+fjNMSG8TCVvNnylG+qa3aPjSuTGXIwkuAklKqEk1H2h9CVJjZ+xqJnLOh1SBmQ==
X-Received: by 2002:a17:902:ecd0:b0:2e3:1ed7:d5d3 with SMTP id d9443c01a7336-2ed40dfb879mr52441465ad.67.1794030729173;
        Fri, 06 Nov 2026 21:52:09 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d8949fsm11189465ad.62.2026.11.06.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:52:08 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: [PATCH v8 1/5] tracing: Add lock-free stackmap for stack trace deduplication
Date: Sat,  7 Nov 2026 13:51:35 +0800
Message-Id: <20261107055139.3138633-2-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
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

From: Pengfei Li <lipengfei28@xiaomi.com>

A kernel stack costs 80-160 bytes per ftrace event, and the same stacks
recur. Add a preallocated hash map that stores each distinct stack once
and returns a 64-bit cookie, made of the map generation and the table
slot, that the stack recording path can record instead of the stack.

Lookup and insert are lock-free and may run in NMI context, so the map
depends on ARCH_HAVE_NMI_SAFE_CMPXCHG like tracing_map. Reset clears the
map in place and bumps the generation so that old cookies stop matching.
The stack_map file that resolves cookies is created by the next patch.

Assisted-by: LLM
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/Kconfig          |  13 ++
 kernel/trace/Makefile         |   1 +
 kernel/trace/trace.h          |   3 +
 kernel/trace/trace_stackmap.c | 382 ++++++++++++++++++++++++++++++++++
 kernel/trace/trace_stackmap.h |  22 ++
 5 files changed, 421 insertions(+)
 create mode 100644 kernel/trace/trace_stackmap.c
 create mode 100644 kernel/trace/trace_stackmap.h

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 084f34dc6c9f..a83c53c02eea 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -412,6 +412,19 @@ config STACK_TRACER
 
 	  Say N if unsure.
 
+config FTRACE_STACKMAP
+	bool "Ftrace stack map deduplication"
+	depends on TRACING
+	depends on STACKTRACE
+	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
+	help
+	  Store each distinct kernel stack recorded by ftrace once, in a
+	  table allocated when options/stackmap is enabled, and record a
+	  64-bit cookie in the ring buffer instead of the full stack.
+	  See Documentation/trace/ftrace-stackmap.rst.
+
+	  If unsure, say N.
+
 config TRACE_PREEMPT_TOGGLE
 	bool
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index f934ff586bd4..7710ec2659e9 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_HWLAT_TRACER) += trace_hwlat.o
 obj-$(CONFIG_OSNOISE_TRACER) += trace_osnoise.o
 obj-$(CONFIG_NOP_TRACER) += trace_nop.o
 obj-$(CONFIG_STACK_TRACER) += trace_stack.o
+obj-$(CONFIG_FTRACE_STACKMAP) += trace_stackmap.o
 obj-$(CONFIG_MMIOTRACE) += trace_mmiotrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..7b2cdc0dc253 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -453,6 +453,9 @@ struct trace_array {
 	struct cond_snapshot	*cond_snapshot;
 #endif
 	struct trace_func_repeats	__percpu *last_func_repeats;
+#ifdef CONFIG_FTRACE_STACKMAP
+	struct ftrace_stackmap __rcu	*stackmap;
+#endif
 	/*
 	 * On boot up, the ring buffer is set to the minimum size, so that
 	 * we do not waste memory on systems that are not using tracing.
diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
new file mode 100644
index 000000000000..e5ffd1850ebf
--- /dev/null
+++ b/kernel/trace/trace_stackmap.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Stack trace deduplication for ftrace: each distinct stack is stored once,
+ * and the ring buffer records a cookie (map generation << 32 | slot).
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/atomic.h>
+#include <linux/random.h>
+#include <linux/rcupdate.h>
+#include <linux/refcount.h>
+
+#include "trace.h"
+#include "trace_stackmap.h"
+
+#define FTRACE_STACKMAP_BITS		14
+#define FTRACE_STACKMAP_MAX_PROBE	64
+
+struct stackmap_elt {
+	u32		nr;
+	atomic_t	ref_count;
+	unsigned long	ips[FTRACE_STACKMAP_MAX_DEPTH];
+};
+
+struct stackmap_entry {
+	u32			key;
+	struct stackmap_elt	*val;
+};
+
+struct ftrace_stackmap {
+	unsigned int		map_bits;
+	unsigned int		map_size;
+	unsigned int		max_elts;
+	u32			hash_seed;
+	atomic_t		next_elt;
+	struct stackmap_entry	*entries;
+	struct stackmap_elt	*elts;
+	atomic_t		resetting;
+	u32			generation;
+	refcount_t		ref;
+};
+
+/* Serializes tracefs readers against reset. */
+static DEFINE_MUTEX(stackmap_lock);
+
+static u32 stackmap_next_gen = 1;
+
+static struct ftrace_stackmap *stackmap_locked(struct trace_array *tr)
+{
+	return rcu_dereference_protected(tr->stackmap,
+					 lockdep_is_held(&trace_types_lock));
+}
+
+static struct stackmap_elt *stackmap_load_elt(struct stackmap_entry *entry)
+{
+	/* Pairs with smp_store_release() in ftrace_stackmap_get_cookie(). */
+	return smp_load_acquire(&entry->val);
+}
+
+static struct stackmap_elt *stackmap_get_elt(struct ftrace_stackmap *smap)
+{
+	int idx;
+
+	idx = atomic_fetch_add_unless(&smap->next_elt, 1, smap->max_elts);
+	return idx < smap->max_elts ? &smap->elts[idx] : NULL;
+}
+
+static void ftrace_stackmap_destroy(struct ftrace_stackmap *smap)
+{
+	vfree(smap->elts);
+	vfree(smap->entries);
+	kfree(smap);
+}
+
+static struct ftrace_stackmap *ftrace_stackmap_create(void)
+{
+	struct ftrace_stackmap *smap;
+
+	smap = kzalloc_obj(*smap, GFP_KERNEL);
+	if (!smap)
+		return ERR_PTR(-ENOMEM);
+
+	smap->map_bits = FTRACE_STACKMAP_BITS;
+	smap->max_elts = 1U << FTRACE_STACKMAP_BITS;
+	smap->map_size = 1U << (FTRACE_STACKMAP_BITS + 1);
+
+	smap->entries = __vcalloc(smap->map_size, sizeof(*smap->entries),
+				  GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+	if (!smap->entries)
+		goto fail;
+
+	smap->elts = __vcalloc(smap->max_elts, sizeof(*smap->elts),
+			       GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+	if (!smap->elts)
+		goto fail;
+
+	smap->hash_seed = get_random_u32();
+	smap->generation = stackmap_next_gen;
+	refcount_set(&smap->ref, 1);
+	return smap;
+
+fail:
+	ftrace_stackmap_destroy(smap);
+	return ERR_PTR(-ENOMEM);
+}
+
+int ftrace_stackmap_alloc(struct trace_array *tr)
+{
+	struct ftrace_stackmap *smap;
+
+	if (stackmap_locked(tr))
+		return 0;
+
+	smap = ftrace_stackmap_create();
+	if (IS_ERR(smap))
+		return PTR_ERR(smap);
+
+	rcu_assign_pointer(tr->stackmap, smap);
+	return 0;
+}
+
+static struct ftrace_stackmap *stackmap_get(struct trace_array *tr)
+{
+	struct ftrace_stackmap *smap;
+
+	guard(mutex)(&trace_types_lock);
+	smap = stackmap_locked(tr);
+	if (smap)
+		refcount_inc(&smap->ref);
+	return smap;
+}
+
+static void stackmap_put(struct ftrace_stackmap *smap)
+{
+	if (!smap)
+		return;
+	if (refcount_dec_and_test(&smap->ref))
+		ftrace_stackmap_destroy(smap);
+}
+
+static void stackmap_reset(struct trace_array *tr)
+{
+	struct ftrace_stackmap *smap = stackmap_locked(tr);
+
+	if (!smap)
+		return;
+
+	/* Keep new callers out, then wait for the ones already inside. */
+	atomic_set(&smap->resetting, 1);
+	synchronize_rcu();
+
+	scoped_guard(mutex, &stackmap_lock) {
+		memset(smap->entries, 0, sizeof(*smap->entries) * smap->map_size);
+		memset(smap->elts, 0, sizeof(*smap->elts) * smap->max_elts);
+		atomic_set(&smap->next_elt, 0);
+		smap->generation++;
+	}
+
+	/* Pairs with atomic_read_acquire() in ftrace_stackmap_get_cookie(). */
+	atomic_set_release(&smap->resetting, 0);
+}
+
+bool ftrace_stackmap_get_cookie(struct ftrace_stackmap *smap,
+				unsigned long *ips, unsigned int nr_entries,
+				u64 *cookie)
+{
+	u32 key_hash, idx, test_key, trace_len;
+	struct stackmap_entry *entry;
+	struct stackmap_elt *val;
+	int probes = 0;
+
+	/* Pairs with atomic_set_release() in stackmap_reset(). */
+	if (atomic_read_acquire(&smap->resetting))
+		return false;
+
+	trace_len = nr_entries * sizeof(unsigned long);
+	key_hash = jhash2((const u32 *)ips, trace_len / sizeof(u32),
+			  smap->hash_seed);
+	/* Zero marks a free slot. */
+	if (key_hash == 0)
+		key_hash = 1;
+
+	idx = key_hash >> (32 - (smap->map_bits + 1));
+
+	while (probes < FTRACE_STACKMAP_MAX_PROBE) {
+		idx &= smap->map_size - 1;
+		entry = &smap->entries[idx];
+		test_key = READ_ONCE(entry->key);
+
+		if (test_key == key_hash) {
+			val = stackmap_load_elt(entry);
+			/* Insert in progress; from NMI it may be the interrupted one. */
+			if (!val)
+				return false;
+			if (READ_ONCE(val->nr) == nr_entries &&
+			    memcmp(val->ips, ips, trace_len) == 0) {
+				atomic_add_unless(&val->ref_count, 1, INT_MAX);
+				goto found;
+			}
+		} else if (!test_key) {
+			if (atomic_read(&smap->next_elt) >= smap->max_elts)
+				break;
+			/* Lost the race; the slot may now hold this stack. */
+			if (cmpxchg(&entry->key, 0, key_hash) != 0)
+				continue;
+
+			val = stackmap_get_elt(smap);
+			if (!val)
+				break;
+
+			val->nr = nr_entries;
+			atomic_set(&val->ref_count, 1);
+			memcpy(val->ips, ips, trace_len);
+			/* Pairs with stackmap_load_elt(). */
+			smp_store_release(&entry->val, val);
+			goto found;
+		}
+
+		idx++;
+		probes++;
+	}
+
+	return false;
+found:
+	*cookie = ((u64)smap->generation << FTRACE_STACKMAP_COOKIE_GEN_SHIFT) | idx;
+	return true;
+}
+
+struct stackmap_seq_private {
+	struct trace_array	*tr;
+	struct ftrace_stackmap	*smap;
+};
+
+static struct stackmap_entry *stackmap_seq_seek(struct ftrace_stackmap *smap,
+						loff_t *pos)
+{
+	loff_t i;
+
+	for (i = *pos; i < smap->map_size; i++) {
+		if (READ_ONCE(smap->entries[i].key) &&
+		    stackmap_load_elt(&smap->entries[i])) {
+			*pos = i;
+			return &smap->entries[i];
+		}
+	}
+	/* Advance past the end or seq_read() repeats the last entry. */
+	*pos = smap->map_size;
+	return NULL;
+}
+
+static void *stackmap_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct stackmap_seq_private *priv = m->private;
+
+	mutex_lock(&stackmap_lock);
+	if (!priv->smap)
+		return NULL;
+	return stackmap_seq_seek(priv->smap, pos);
+}
+
+static void *stackmap_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct stackmap_seq_private *priv = m->private;
+
+	(*pos)++;
+	return stackmap_seq_seek(priv->smap, pos);
+}
+
+static void stackmap_seq_stop(struct seq_file *m, void *v)
+{
+	/* seq_file calls stop() even when start() returned NULL. */
+	mutex_unlock(&stackmap_lock);
+}
+
+static int stackmap_seq_show(struct seq_file *m, void *v)
+{
+	struct stackmap_entry *entry = v;
+	struct stackmap_seq_private *priv = m->private;
+	struct stackmap_elt *elt;
+	u32 idx = entry - priv->smap->entries;
+	u32 i, nr;
+
+	elt = stackmap_load_elt(entry);
+	if (!elt)
+		return 0;
+
+	nr = READ_ONCE(elt->nr);
+	if (nr > FTRACE_STACKMAP_MAX_DEPTH)
+		nr = FTRACE_STACKMAP_MAX_DEPTH;
+
+	seq_printf(m, "stack_id %u gen %u ref %u depth %u\n",
+		   idx, priv->smap->generation, atomic_read(&elt->ref_count), nr);
+	for (i = 0; i < nr; i++) {
+		unsigned long ip = elt->ips[i];
+
+		if (ip == FTRACE_TRAMPOLINE_MARKER)
+			seq_puts(m, " => [FTRACE TRAMPOLINE]\n");
+		else
+			seq_printf(m, " => %pS\n", (void *)ip);
+	}
+	return 0;
+}
+
+static const struct seq_operations stackmap_seq_ops = {
+	.start	= stackmap_seq_start,
+	.next	= stackmap_seq_next,
+	.stop	= stackmap_seq_stop,
+	.show	= stackmap_seq_show,
+};
+
+static int stackmap_open(struct inode *inode, struct file *file)
+{
+	struct trace_array *tr = inode->i_private;
+	struct stackmap_seq_private *priv;
+	struct seq_file *m;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = seq_open_private(file, &stackmap_seq_ops,
+			       sizeof(struct stackmap_seq_private));
+	if (ret) {
+		trace_array_put(tr);
+		return ret;
+	}
+
+	m = file->private_data;
+	priv = m->private;
+	priv->tr = tr;
+	if (file->f_mode & FMODE_READ)
+		priv->smap = stackmap_get(tr);
+	return 0;
+}
+
+static int stackmap_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_seq_private *priv = m->private;
+	struct ftrace_stackmap *smap = priv->smap;
+	struct trace_array *tr = priv->tr;
+	int ret;
+
+	ret = seq_release_private(inode, file);
+	stackmap_put(smap);
+	trace_array_put(tr);
+	return ret;
+}
+
+static ssize_t stackmap_write(struct file *file, const char __user *ubuf,
+			      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct stackmap_seq_private *priv = m->private;
+	char buf[8];
+
+	if (count >= sizeof(buf))
+		return -EINVAL;
+	if (copy_from_user(buf, ubuf, count))
+		return -EFAULT;
+	buf[count] = '\0';
+
+	if (sysfs_streq(buf, "0")) {
+		guard(mutex)(&trace_types_lock);
+		stackmap_reset(priv->tr);
+		return count;
+	}
+	return -EINVAL;
+}
+
+const struct file_operations ftrace_stackmap_fops = {
+	.open		= stackmap_open,
+	.read		= seq_read,
+	.write		= stackmap_write,
+	.llseek		= seq_lseek,
+	.release	= stackmap_release,
+};
diff --git a/kernel/trace/trace_stackmap.h b/kernel/trace/trace_stackmap.h
new file mode 100644
index 000000000000..6699988da390
--- /dev/null
+++ b/kernel/trace/trace_stackmap.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TRACE_STACKMAP_H
+#define _TRACE_STACKMAP_H
+
+#include <linux/types.h>
+
+#define FTRACE_STACKMAP_MAX_DEPTH	64
+
+/* A cookie holds the generation in its high half and the slot below. */
+#define FTRACE_STACKMAP_COOKIE_GEN_SHIFT	32
+
+struct trace_array;
+struct ftrace_stackmap;
+
+int ftrace_stackmap_alloc(struct trace_array *tr);
+bool ftrace_stackmap_get_cookie(struct ftrace_stackmap *smap,
+				unsigned long *ips, unsigned int nr_entries,
+				u64 *cookie);
+
+extern const struct file_operations ftrace_stackmap_fops;
+
+#endif /* _TRACE_STACKMAP_H */
-- 
2.34.1

