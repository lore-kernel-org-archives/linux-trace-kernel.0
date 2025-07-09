Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BFA923;
	Wed,  9 Jul 2025 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069001; cv=none; b=t3fsjSkEqWtvTyQnbjcg1hXcB7DYpu0fubIUa5tcCNO+vcoipY0ehavHXieclasi73Vn0Bkb+nWZRoo2yIyiOEBQ2NLbsxcdi/W8zrpXXlX5fxK4AE7x0EiR9LhZ/GTCm/0mbnB6KoCXC5+qhhesgDnlV7lAtvTywYRUAujMSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069001; c=relaxed/simple;
	bh=2EJZ9+aB/E5JNkmaeT8QY2pqIApZJVO2kuQHP+iIbQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSoW3LWX0+6Mrxokkkf1WCqc4lW5ZqWdM0qC0yLZnGUidHFdq+Fubvk28P14dP4Qh2oCqjVpLLWP6HGWHnX/5Zg7MVB1hOfwZrGhjVnTf/o0Q2KpSmiNqedpf5IGrdZJfcmbDgvuM7eDRfVDl8hq9AU7GxMxFN3hPRClBoED6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv0TVJVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv0TVJVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5B6C4CEEF;
	Wed,  9 Jul 2025 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069001;
	bh=2EJZ9+aB/E5JNkmaeT8QY2pqIApZJVO2kuQHP+iIbQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qv0TVJVVFILyhiJ07rmM2QkXyhZw3eWuUqSiiJFuqIKYREmQJdbXlo1ydYetRUV/Q
	 6pq7HnIV70A+FY4Yyg9S8PSunITrE7M+rpWbrZbZH0Cth1MXBjHR83573BR3awXc2k
	 VL3WTsF2m+B1ZLDW0AbK4aFS2IkzcjjCnu1+VpV8WtA1AfQITIvf7Vh14y5CpS2JWi
	 3IdMPfvL3K9WlefR9X1eLsdYUUgQUSU61PP/FpVqEeWgnYVARIGgy5xHJc3Cuuz0By
	 214qqcDhO1GoOQZ5CxWgbFk3UwmBkndOBXsHJyb1lppDMeLGVJGQAY3p19cHgzASj1
	 iYdenymGUPpdQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yann Ylavic <ylavic.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 3/8] execmem: rework execmem_cache_free()
Date: Wed,  9 Jul 2025 16:49:28 +0300
Message-ID: <20250709134933.3848895-4-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709134933.3848895-1-rppt@kernel.org>
References: <20250709134933.3848895-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Currently execmem_cache_free() ignores potential allocation failures that
may happen in execmem_cache_add(). Besides, it uses text poking to fill the
memory with trapping instructions before returning it to cache although it
would be more efficient to make that memory writable, update it using
memcpy and then restore ROX protection.

Rework execmem_cache_free() so that in case of an error it will defer
freeing of the memory to a delayed work.

With this the happy fast path will now change permissions to RW, fill the
memory with trapping instructions using memcpy, restore ROX permissions,
add the memory back to the free cache and clear the relevant entry in
busy_areas.

If any step in the fast path fails, the entry in busy_areas will be marked
as pending_free. These entries will be handled by a delayed work and freed
asynchronously.

To make the fast path faster, use __GFP_NORETRY for memory allocations and
let asynchronous handler try harder with GFP_KERNEL.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/execmem.c | 125 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 23 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 6b040fbc5f4f..4670e97f8e4e 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -93,8 +93,15 @@ struct execmem_cache {
 	struct mutex mutex;
 	struct maple_tree busy_areas;
 	struct maple_tree free_areas;
+	unsigned int pending_free_cnt;	/* protected by mutex */
 };
 
+/* delay to schedule asynchronous free if fast path free fails */
+#define FREE_DELAY	(msecs_to_jiffies(10))
+
+/* mark entries in busy_areas that should be freed asynchronously */
+#define PENDING_FREE_MASK	(1 << (PAGE_SHIFT - 1))
+
 static struct execmem_cache execmem_cache = {
 	.mutex = __MUTEX_INITIALIZER(execmem_cache.mutex),
 	.busy_areas = MTREE_INIT_EXT(busy_areas, MT_FLAGS_LOCK_EXTERN,
@@ -155,20 +162,17 @@ static void execmem_cache_clean(struct work_struct *work)
 
 static DECLARE_WORK(execmem_cache_clean_work, execmem_cache_clean);
 
-static int execmem_cache_add(void *ptr, size_t size)
+static int execmem_cache_add_locked(void *ptr, size_t size, gfp_t gfp_mask)
 {
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
-	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr = (unsigned long)ptr;
 	MA_STATE(mas, free_areas, addr - 1, addr + 1);
 	unsigned long lower, upper;
 	void *area = NULL;
-	int err;
 
 	lower = addr;
 	upper = addr + size - 1;
 
-	mutex_lock(mutex);
 	area = mas_walk(&mas);
 	if (area && mas.last == addr - 1)
 		lower = mas.index;
@@ -178,12 +182,14 @@ static int execmem_cache_add(void *ptr, size_t size)
 		upper = mas.last;
 
 	mas_set_range(&mas, lower, upper);
-	err = mas_store_gfp(&mas, (void *)lower, GFP_KERNEL);
-	mutex_unlock(mutex);
-	if (err)
-		return err;
+	return mas_store_gfp(&mas, (void *)lower, gfp_mask);
+}
 
-	return 0;
+static int execmem_cache_add(void *ptr, size_t size, gfp_t gfp_mask)
+{
+	guard(mutex)(&execmem_cache.mutex);
+
+	return execmem_cache_add_locked(ptr, size, gfp_mask);
 }
 
 static bool within_range(struct execmem_range *range, struct ma_state *mas,
@@ -278,7 +284,7 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	if (err)
 		goto err_free_mem;
 
-	err = execmem_cache_add(p, alloc_size);
+	err = execmem_cache_add(p, alloc_size, GFP_KERNEL);
 	if (err)
 		goto err_reset_direct_map;
 
@@ -307,29 +313,102 @@ static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 	return __execmem_cache_alloc(range, size);
 }
 
+static inline bool is_pending_free(void *ptr)
+{
+	return ((unsigned long)ptr & PENDING_FREE_MASK);
+}
+
+static inline void *pending_free_set(void *ptr)
+{
+	return (void *)((unsigned long)ptr | PENDING_FREE_MASK);
+}
+
+static inline void *pending_free_clear(void *ptr)
+{
+	return (void *)((unsigned long)ptr & ~PENDING_FREE_MASK);
+}
+
+static int execmem_force_rw(void *ptr, size_t size);
+
+static int __execmem_cache_free(struct ma_state *mas, void *ptr, gfp_t gfp_mask)
+{
+	size_t size = mas_range_len(mas);
+	int err;
+
+	err = execmem_force_rw(ptr, size);
+	if (err)
+		return err;
+
+	execmem_fill_trapping_insns(ptr, size, /* writable = */ true);
+	execmem_restore_rox(ptr, size);
+
+	err = execmem_cache_add_locked(ptr, size, gfp_mask);
+	if (err)
+		return err;
+
+	mas_store_gfp(mas, NULL, gfp_mask);
+	return 0;
+}
+
+static void execmem_cache_free_slow(struct work_struct *work);
+static DECLARE_DELAYED_WORK(execmem_cache_free_work, execmem_cache_free_slow);
+
+static void execmem_cache_free_slow(struct work_struct *work)
+{
+	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
+	MA_STATE(mas, busy_areas, 0, ULONG_MAX);
+	void *area;
+
+	guard(mutex)(&execmem_cache.mutex);
+
+	if (!execmem_cache.pending_free_cnt)
+		return;
+
+	mas_for_each(&mas, area, ULONG_MAX) {
+		if (!is_pending_free(area))
+			continue;
+
+		area = pending_free_clear(area);
+		if (__execmem_cache_free(&mas, area, GFP_KERNEL))
+			continue;
+
+		execmem_cache.pending_free_cnt--;
+	}
+
+	if (execmem_cache.pending_free_cnt)
+		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
+	else
+		schedule_work(&execmem_cache_clean_work);
+}
+
 static bool execmem_cache_free(void *ptr)
 {
 	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
-	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr = (unsigned long)ptr;
 	MA_STATE(mas, busy_areas, addr, addr);
-	size_t size;
 	void *area;
+	int err;
+
+	guard(mutex)(&execmem_cache.mutex);
 
-	mutex_lock(mutex);
 	area = mas_walk(&mas);
-	if (!area) {
-		mutex_unlock(mutex);
+	if (!area)
 		return false;
-	}
-	size = mas_range_len(&mas);
 
-	mas_store_gfp(&mas, NULL, GFP_KERNEL);
-	mutex_unlock(mutex);
-
-	execmem_fill_trapping_insns(ptr, size, /* writable = */ false);
-
-	execmem_cache_add(ptr, size);
+	err = __execmem_cache_free(&mas, area, GFP_KERNEL | __GFP_NORETRY);
+	if (err) {
+		/*
+		 * mas points to exact slot we've got the area from, nothing
+		 * else can modify the tree because of the mutex, so there
+		 * won't be any allocations in mas_store_gfp() and it will just
+		 * change the pointer.
+		 */
+		area = pending_free_set(area);
+		mas_store_gfp(&mas, area, GFP_KERNEL);
+		execmem_cache.pending_free_cnt++;
+		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
+		return true;
+	}
 
 	schedule_work(&execmem_cache_clean_work);
 
-- 
2.47.2

