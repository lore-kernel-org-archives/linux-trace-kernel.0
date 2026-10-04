Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D948097E;
	Sun,  4 Oct 2026 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791143461; cv=none; b=eD6DfC6fRQtwDTWHZ/cAtc1BCyad+lCcK6j+Luht40Bqvkd3DZymiptWqJD5krVVoZi+OjGxi9Yaj7WVcBdRzk65Hw0FqCFALVRkcjp5umC7WtYlaS7AIlSlab5Q/sT9J1DzECNWfLv5MkkaX7fczGeCwtpcNdLfhtMb49bdXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791143461; c=relaxed/simple;
	bh=ER19OUCB7aVdxlSfW6hTiDY/t0kFUw0QV3PpNGlC5Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGxdQqw3H91cz5o2UD3rcNLFPjXryIlcUYYP0RmH1pLx627GPUdLI++YUOu4lEDh8Z5XV+cNsD9+o5a1QaTT7ZIdg8HqCIrjLpXXp7FAayUSTLAAewZl4Fy+Q85XsPdFlEtuAJRH+JLmLwg5u0uDLOk1AmvqzaeKrRUllH4QF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr9Bnzdi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr9Bnzdi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51206C4AF62;
	Sun,  4 Oct 2026 19:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791143461;
	bh=ER19OUCB7aVdxlSfW6hTiDY/t0kFUw0QV3PpNGlC5Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tr9Bnzdiz0NbWB2s1eCxQnq5C7YvbTzV5q2zV1+eqQ++AGPwkY1Jo81lXs+t3i1kR
	 aex1rhgDGP0peNQT/5HnvN3S2MPgm4MN43qSIgvmWFqrnV7kf0Yz2Bqkm/LI9WAee2
	 Y6KizwyW06BiBcy035ZhNns76v1nBtVxe8FzjY0N46+XgidEvi6sSiqwE5e46nL/tC
	 /XzS5MLOfaAofAQvdz9Dz8gjrYHAHH7js3CyFxyaM0luT1B/Q1WKIZ3HvcKDddPmdk
	 AFA7c+cAMo+GWthd4xid3Gn1Dg6QYW9VScORIbHER/Ul4eOLO2A5HApEtr4xaNxkgR
	 8JAHc8NMkTr8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32040CA5FFA;
	Sun,  4 Oct 2026 19:51:01 +0000 (UTC)
From: Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org>
Date: Sun, 04 Oct 2026 14:51:01 -0500
Subject: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
In-Reply-To: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
 David Laight <david.laight.linux@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Lawrence Lin <deduce@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791143460; l=5635;
 i=deduce@gmail.com; s=default; h=from:subject:message-id;
 bh=TJECsMrXSgfNhKlqcwZYwjcb8q/Qy00rtV662XesPT4=;
 b=WlldLGiv9RMmqhQBaBPmYQCx9RepjgSTLsPKpBTVAtFrwUxvcsMLtajqy6nhLW5V8OvzY1haW
 6OVzumjVAmfB08c/MHmtHQbj5ES57Mkw7mxBHZy6ctvEJ40hdiplR7W
X-Developer-Key: i=deduce@gmail.com; a=ed25519;
 pk=Ws6hmG/zoco3lMoykbeaYjo9S7a6sDddQY8EALjp9cM=
X-Endpoint-Received: by B4 Relay for deduce@gmail.com/default with
 auth_id=1106
X-Original-From: Lawrence Lin <deduce@gmail.com>
Reply-To: deduce@gmail.com

From: Lawrence Lin <deduce@gmail.com>

Since commit b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
adding weak function"), ftrace_module_enable() calls test_for_valid_rec()
for every ftrace record of a module being loaded. For a module address,
kallsyms_lookup() scans the whole symbol table of the module, so loading a
module costs O(records * symbols), all of it under ftrace_lock. amdgpu.ko
has 16821 records and about 67000 symbols, and commit 4099b98203d6
("ftrace: Fix softlockup in ftrace_module_enable") already had to add a
cond_resched() to this loop because of it.

Commit ef378c3b8233 ("scripts/sorttable: Zero out weak functions in
mcount_loc table") fixed vmlinux at build time, noting that the real
solution is to not add a weak function into the ftrace table in the first
place. Modules are not covered by it, and still have such locations: a
weak function in virt/kvm that arch/x86 overrides inside the same kvm.ko
keeps its mcount location but has no symbol. In an x86_64 distribution
build of v7.2.5, kvm.ko has 18 of them; none of the other 6483 modules has
any.

Do the same for modules when they are loaded. In ftrace_process_locs(),
after the locations are sorted, find for each symbol of the module, by
binary search, the locations at most FTRACE_MCOUNT_MAX_OFFSET after it,
and zero the locations no symbol marked. ftrace_process_locs() already
skips zeroed locations, so no record is created for them, and
ftrace_module_enable() no longer has to test every record. This costs one
bit per location, about 2 KB for amdgpu, and O(symbols * log(records))
time.

On a Ryzen 3 3200U (x86_64, v7.2.5, amdgpu loaded from the initramfs,
three boots each), amdgpu finishes initializing 6.19 s into boot without
this patch and 2.00 s with it, and the kernel part of boot reported by
systemd-analyze drops from 6.65 s to 2.46 s. Loading radeon and nouveau,
which have no hardware on that machine, goes from 137 ms to 64 ms and from
457 ms to 118 ms. available_filter_functions loses the 18
__ftrace_invalid_address___ entries of kvm; its module entries are
otherwise unchanged.

Fixes: b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Lawrence Lin <deduce@gmail.com>
---
 kernel/trace/ftrace.c | 82 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 673a54fdf392..2e1a237ce901 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4445,11 +4445,6 @@ static int print_rec(struct seq_file *m, unsigned long ip)
 	return ret == NULL ? -1 : 0;
 }
 #else
-static inline int test_for_valid_rec(struct dyn_ftrace *rec)
-{
-	return 1;
-}
-
 static inline int print_rec(struct seq_file *m, unsigned long ip)
 {
 	seq_printf(m, "%ps", (void *)ip);
@@ -7611,6 +7606,73 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+#ifdef FTRACE_MCOUNT_MAX_OFFSET
+struct ftrace_mod_locs {
+	unsigned long *start;
+	unsigned long count;
+	unsigned long *valid;
+};
+
+/* Mark the locations that lie at most FTRACE_MCOUNT_MAX_OFFSET after @addr. */
+static void ftrace_mark_valid_locs(void *data, unsigned long addr)
+{
+	struct ftrace_mod_locs *locs = data;
+	unsigned long lo = 0, hi = locs->count, mid, ip;
+
+	/*
+	 * ftrace_call_adjust() moves a location forward by at most
+	 * FTRACE_MCOUNT_MAX_OFFSET, so start looking that far before @addr.
+	 */
+	while (lo < hi) {
+		mid = lo + (hi - lo) / 2;
+		if (locs->start[mid] + FTRACE_MCOUNT_MAX_OFFSET < addr)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+
+	for (; lo < locs->count; lo++) {
+		if (locs->start[lo] > addr + FTRACE_MCOUNT_MAX_OFFSET)
+			break;
+		ip = ftrace_call_adjust(locs->start[lo]);
+		if (ip >= addr && ip - addr <= FTRACE_MCOUNT_MAX_OFFSET)
+			__set_bit(lo, locs->valid);
+	}
+}
+
+/*
+ * A weak function overridden within its module keeps its mcount location but
+ * has no symbol. Zero such locations before they become records, as sorttable
+ * does for vmlinux: keep only those with a symbol at most
+ * FTRACE_MCOUNT_MAX_OFFSET before them.
+ */
+static int ftrace_zero_weak_locs(struct module *mod, unsigned long *start,
+				 unsigned long count)
+{
+	struct ftrace_mod_locs locs = { .start = start, .count = count };
+	unsigned long i;
+
+	locs.valid = bitmap_zalloc(count, GFP_KERNEL);
+	if (!locs.valid)
+		return -ENOMEM;
+
+	module_kallsyms_on_each_addr(mod, ftrace_mark_valid_locs, &locs);
+
+	for_each_clear_bit(i, locs.valid, count)
+		start[i] = 0;
+
+	bitmap_free(locs.valid);
+	return 0;
+}
+#else
+static inline int ftrace_zero_weak_locs(struct module *mod,
+					unsigned long *start,
+					unsigned long count)
+{
+	return 0;
+}
+#endif
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -7644,6 +7706,9 @@ static int ftrace_process_locs(struct module *mod,
 		test_is_sorted(start, count);
 	}
 
+	if (mod && ftrace_zero_weak_locs(mod, start, count))
+		return -ENOMEM;
+
 	start_pg = ftrace_allocate_pages(count, &pages);
 	if (!start_pg)
 		return -ENOMEM;
@@ -8049,13 +8114,6 @@ void ftrace_module_enable(struct module *mod)
 
 		cond_resched();
 
-		/* Weak functions should still be ignored */
-		if (!test_for_valid_rec(rec)) {
-			/* Clear all other flags. Should not be enabled anyway */
-			rec->flags = FTRACE_FL_DISABLED;
-			continue;
-		}
-
 		cnt = 0;
 
 		/*

-- 
2.55.0


