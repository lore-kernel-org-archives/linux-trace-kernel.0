Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1930749E;
	Fri,  4 Jul 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637009; cv=none; b=q5foNlV5jVFNDkRxgSeMDeeP4z8ACqhaNMfBxJf3NjUkRRHhFWZgyV4DfeIZBrje6d7Op9CJ4uDOoVLaAURTrKC94ZFfautTrgI3IJTnd/98wZepBLsqaRbxPLjkYCUQh1XeLHHToTL9bfdSuS54U1NhnDjq/NgmlpvE6Ixb0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637009; c=relaxed/simple;
	bh=ZNEJRJfWjPqcxgGqudYL+ToTxSRDO6h8hesaJrQI5DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKn3CBKN1C2f5z8HNb4ZH3AHj6oCvo+IF65U3SQYZlFWpZctcj4AHiShDLPgnfbXWh3M3zp5gTsPXkPRQIwnTWzf/sBjNv62TBZXkeSy+LcbkiDnD/M2r6LluoRBcOmqwMKk3ERqn+mhZvBrbja/OjME3+Go0xmT0//54uDxRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkADYyEV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkADYyEV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10628C4CEE3;
	Fri,  4 Jul 2025 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637009;
	bh=ZNEJRJfWjPqcxgGqudYL+ToTxSRDO6h8hesaJrQI5DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkADYyEVBsAD4xvYJYsQt0aFOqjZU0QQRSfnrXMVtaXTRlEr14ZKnEmIcyLYlQ9B7
	 T87qoQKOZoW+Fe35J6xQLShFllVVa37D2ooami7C5m/C+aoAQ8+cc/jYlPv45TT/N9
	 z+R3Y/dVyudtJtrK7qldz0PWCkIOp4lnwLxn/8uEt9ZRYsTbhpKkpgemL9SNR0Ay7n
	 xRdwk4w65l3IoBGi6GHxh/seT0aEir6Q7bNZqm+g0SLgbmDVkzx/3wwClFJLvvKE6Z
	 2zLubvsO9TcXOosj/LslipVCKSELNYMhMgoCpS4d/H11Fz5E1NFO+IVCCa4jZSBwBn
	 Tvjd42nCrNiXQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 3/8] execmem: rework execmem_cache_free()
Date: Fri,  4 Jul 2025 16:49:38 +0300
Message-ID: <20250704134943.3524829-4-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704134943.3524829-1-rppt@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
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
 mm/execmem.c | 120 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 97 insertions(+), 23 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 6b040fbc5f4f..1cc781244593 100644
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
 
@@ -307,33 +313,101 @@ static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
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
+		pending_free_clear(area);
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
-
-	mas_store_gfp(&mas, NULL, GFP_KERNEL);
-	mutex_unlock(mutex);
-
-	execmem_fill_trapping_insns(ptr, size, /* writable = */ false);
 
-	execmem_cache_add(ptr, size);
+	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
+	if (err)
+		goto err_slowpath;
 
 	schedule_work(&execmem_cache_clean_work);
 
 	return true;
+
+err_slowpath:
+	mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
+	execmem_cache.pending_free_cnt++;
+	schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
+	return true;
 }
 
 static int execmem_force_rw(void *ptr, size_t size)
-- 
2.47.2

