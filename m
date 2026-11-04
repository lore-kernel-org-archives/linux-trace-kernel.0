Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819026;
	b=2blTOHHTHoVdyI1IQuQ+HHKrzTYiJcPQG/VDshgfJ1BgMxIQeUETAIOV8Cw8EdMqX8Nx
	 l4SljcSqfNl/Dv60B73tOsFWR/7iDyB66V0wcHIO/0869pGYTOB+Dhgjgv62HGI5Pq+V+
	 3uYGSMHNHxDVvztOPKSs5zB50EHe6H4nhSWBeUBrQgMuXBZ6a7Tj7Pkncpgi21o/HY9Df
	 T3gNqIcyxXHCtUdqN7oyVB66btEJk8VSv2+fP3uqEsKrF8pwgk4qjGYoTMHEp6JYkpyHF
	 C+m4TMhiAUkRaexwZyNcC5FdHJwUcZgKhh2WhaX4ivjDqiLy0acYFtD87uSJu3k08Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hJyeXduiQM+4dzc6a9GLkCFM1A1rcEOgjiBv2Ui60dQ=;
	b=v8GHAKT0wRG49e4AVz3TuC8onLsFCVnPUrOtJ2mrAE48/TxzMDbNODw5MFmgAKExSI7B
	 ds8Hd5sg5Unw3H9WSTC7NcvQdRKUU7TIDtNGa/3s7tUF4/gnF9ouDonfFLiRylZpg/zuO
	 94Ur1Ucd95jCj9CpTraznkSBgidGJcFs3Ht+w05JgpoFmoG///XuJmaTp7KgRgBP/PolX
	 GYEVMZj72c6w6+OcwblzSDa0wqoFKrLasjN1aidz40eHOUG06IWemjo2l7e/xAFDsTKEX
	 DGWDc7IglhcOMAzxPSGd9acdfkeMfacj55lLbMdRLkQm9DSfENqEjYKqnUF1dSSI0cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="l/HIgS3Z";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14525606A329
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 19:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14525606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekbapat.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l/HIgS3Z
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1842119eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793819025; x=1794423825; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hJyeXduiQM+4dzc6a9GLkCFM1A1rcEOgjiBv2Ui60dQ=;
        b=l/HIgS3Z+uIRcUd/FqendbfH7hhoZtumkqc+N+2lApkgpNVPnU2WCzSzfd+tF89ZPH
         vwdPp8DaVIdalJUUNayHWI4x/Z/KAOxxRB3yW573AEhZL7JmfydCjbVeuXlu9uVBt40k
         znr50R8aMAzP+cUwpV9U1U/TRfRDWqtoPKe1c/0sHcO9hjbOIWK+lBfpTWLFSvdoUHOf
         U08meelmaN9uXmU2biKAm1vNP8ZTV48PBOTq1MsKau37/QJ16QiKQWuE7ihRNZz0HhDo
         lNPyiXsJhdzOS7sx6d6g464fc/Md06D09Y2m5riN2D+1g//ncy0DVjRDw9qydXK1XnO6
         KEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819025; x=1794423825;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJyeXduiQM+4dzc6a9GLkCFM1A1rcEOgjiBv2Ui60dQ=;
        b=ChzRkgleNqUhtRthBLFqIO1QqyPcACj8Tqo+C74I6q3PMzc3tlyoWNmumMFZR5YwP/
         U0gpZIid+h1FAFWecK6ZDep4fFZmmC4cDu+2D5gQjQ8HKBaHQIt5wUjCD75ay6epqQ6l
         8dkkPZl9Obpmp6NAQHZkcLQEDH5r9no0f8LHov9JVOFFxojIExp/OdBSlUcO/TwRaTr+
         0zZUTRd5xtqRPj01DijAfGyzuYv4be4ZLvZm10Crew788KVuJWc9WQ4zrU8/QyFXBeB+
         4xEVJfRVzFNfkkISOmu22El4i6Tpcfga9pvgwlXgjTyEgRL1TsnkBxj47OF3avOI6d84
         +uCg==
X-Forwarded-Encrypted: i=1; AKwUvBxYY6LPq+ja6tDzdpu8MDcBO2gznj4DwvA3CW4oKi2+PFRGgNAmSSvtCsankQzTOQVDs10vPAZII3rqP1PpTjWzPuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ov5AXrDrNV46lngFTs/CK4381SJShfuGHeQS2E8lnYeobU9Xh
	8BbcifgX+wX/pKMIKx0ihl0+nesXEyHkTncOUYeG8zxNTRAFH9aukM1tqFMz71jZXuR02jkDVnb
	WAoDZ5HWPYVu3f8J8DMfDWtcl5IWNZndUoA==
X-Received: from dlbts16.prod.google.com ([2002:a05:7022:b050:b0:1a3:1342:a32d])
 (user=abhishekbapat job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:464d:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b2349759cfmr12065722c88.36.1793819024797;
 Wed, 04 Nov 2026 11:03:44 -0800 (PST)
Date: Wed,  4 Nov 2026 19:03:37 +0000
In-Reply-To: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1793818636.git.abhishekbapat@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <37ae7dca766994d3872fcc65b623a80d5d506369.1793818636.git.abhishekbapat@google.com>
Subject: [PATCH v5 2/5] alloc_tag: Introduce IOCTLs to toggle allocation tracepoints
From: Abhishek Bapat <abhishekbapat@google.com>
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new IOCTL (`ALLOCINFO_IOC_TOGGLE_TRACE`) to selectively
toggle tracing on allocation call sites. Userspace tools can use the
existing filtering mechanism to specify the set of tags to toggle
tracing for.

To facilitate low overhead execution for non-targeted call sites, add a
new `CODETAG_FLAG_TRACE_ON` flag to `struct codetag` to track per-site
activation. Protect these conditional branch evaluations using the global
`alloc_tag_trace_key` static branch and an inline static key check
pattern in the allocator hooks (`alloc_tag_add`, `alloc_tag_sub`, etc).
This ensures that the trace events are entirely skipped when no
allocation call sites are being actively traced, leaving only a NOP on
the allocation fast path.

Signed-off-by: Abhishek Bapat <abhishekbapat@google.com>
Acked-by: Hao Ge <hao.ge@linux.dev>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 Documentation/mm/allocation-profiling.rst |  20 ++++
 include/linux/alloc_tag.h                 |  47 +++++---
 include/linux/codetag.h                   |   5 +-
 include/uapi/linux/alloc_tag.h            |  13 +++
 mm/alloc_tag.c                            | 127 ++++++++++++++++++++--
 5 files changed, 186 insertions(+), 26 deletions(-)

diff --git a/Documentation/mm/allocation-profiling.rst b/Documentation/mm/allocation-profiling.rst
index b241450394df..b855f8ac87fd 100644
--- a/Documentation/mm/allocation-profiling.rst
+++ b/Documentation/mm/allocation-profiling.rst
@@ -149,6 +149,26 @@ expose the full call stack and the lifetime of individual allocations:
 - slab and percpu: the address of the object's `codetag_ref`
 - page allocator: the `struct page` pointer of the head page
 
+Events are only emitted for tags that have tracing turned on and while profiling
+is enabled. When no tag is traced, the hooks are behind a static branch.
+
+Enabling Tracing
+----------------
+
+Tracing is toggled on and off per tag with the `ALLOCINFO_IOC_TOGGLE_TRACE`
+ioctl on `/proc/allocinfo` (requires `CAP_SYS_ADMIN`, returns `-EPERM`
+otherwise). It takes the same filter as used by `ALLOCINFO_IOC_GET_AT`; an
+empty mask selects all tags. Size limits in the filter are checked once,
+against the tag's size at the time of the call. Tags already in the requested
+state are skipped and a -ENOENT is returned if no tag matched.
+
+Tracing is turned off for a module's tags when the module is unloaded.
+
+Memory allocated before a tag was enabled has no alloc event but will still
+produce a free event. Likewise, memory alive when tag is disabled will not
+produce a free event. Tools should expect unmatched frees after enabling and
+missing frees after disabling.
+
 Correlating the events
 ----------------------
 
diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index cf8a29d463aa..00eca9bf8190 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -136,9 +136,36 @@ static inline bool mem_alloc_profiling_enabled(void)
 				   &mem_alloc_profiling_key);
 }
 
-static inline bool alloc_tag_trace_enabled(void)
+static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
 {
-	return static_branch_unlikely(&alloc_tag_trace_key);
+	atomic_or(CODETAG_FLAG_INACCURATE, &tag->ct.flags);
+}
+
+static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
+{
+	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_INACCURATE);
+}
+
+static inline void alloc_tag_set_traced(struct alloc_tag *tag)
+{
+	atomic_or(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
+}
+
+static inline void alloc_tag_clear_traced(struct alloc_tag *tag)
+{
+	atomic_andnot(CODETAG_FLAG_TRACE_ON, &tag->ct.flags);
+}
+
+static inline bool alloc_tag_is_traced(const struct alloc_tag *tag)
+{
+	return !!(atomic_read(&tag->ct.flags) & CODETAG_FLAG_TRACE_ON);
+}
+
+static inline bool alloc_tag_trace_enabled(const struct alloc_tag *tag)
+{
+	if (static_branch_unlikely(&alloc_tag_trace_key))
+		return tag && alloc_tag_is_traced(tag);
+	return false;
 }
 
 void alloc_tag_trace_mem_alloc(const void *ptr, struct alloc_tag *tag,
@@ -151,7 +178,7 @@ void __alloc_tag_trace_hit(struct alloc_tag *tag);
 
 static __always_inline void alloc_tag_trace_hit(struct alloc_tag *tag)
 {
-	if (alloc_tag_trace_enabled())
+	if (alloc_tag_trace_enabled(tag))
 		__alloc_tag_trace_hit(tag);
 }
 
@@ -225,7 +252,7 @@ static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag,
 	if (likely(alloc_tag_ref_set(ref, tag))) {
 		this_cpu_add(tag->counters->bytes, bytes);
 
-		if (alloc_tag_trace_enabled())
+		if (alloc_tag_trace_enabled(tag))
 			/* Trace successful allocs with their unique ptr */
 			alloc_tag_trace_mem_alloc(ptr, tag, bytes);
 	}
@@ -249,23 +276,13 @@ static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes, const voi
 	this_cpu_sub(tag->counters->bytes, bytes);
 	this_cpu_dec(tag->counters->calls);
 
-	if (alloc_tag_trace_enabled())
+	if (alloc_tag_trace_enabled(tag))
 		/* Trace frees with their unique ptr */
 		alloc_tag_trace_mem_free(ptr, tag, bytes);
 
 	ref->ct = NULL;
 }
 
-static inline void alloc_tag_set_inaccurate(struct alloc_tag *tag)
-{
-	tag->ct.flags |= CODETAG_FLAG_INACCURATE;
-}
-
-static inline bool alloc_tag_is_inaccurate(struct alloc_tag *tag)
-{
-	return !!(tag->ct.flags & CODETAG_FLAG_INACCURATE);
-}
-
 #define alloc_tag_record(p)	((p) = current->alloc_tag)
 
 #else /* CONFIG_MEM_ALLOC_PROFILING */
diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index a25a085c2df1..f728295d50c0 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -18,6 +18,7 @@ struct module;
 
 /* codetag flags */
 #define CODETAG_FLAG_INACCURATE	(1 << 0)
+#define CODETAG_FLAG_TRACE_ON	(1 << 1)
 
 /*
  * An instance of this structure is created in a special ELF section at every
@@ -25,7 +26,7 @@ struct module;
  * an array of these.
  */
 struct codetag {
-	unsigned int flags;
+	atomic_t flags;
 	unsigned int lineno;
 	const char *modname;
 	const char *function;
@@ -71,7 +72,7 @@ struct codetag_iterator {
 	.function	= __func__,			\
 	.filename	= __FILE__,			\
 	.lineno		= __LINE__,			\
-	.flags		= 0,				\
+	.flags		= ATOMIC_INIT(0),		\
 }
 
 void codetag_lock_module_list(struct codetag_type *cttype);
diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_tag.h
index 7d4618bea043..dafcba2f7e2c 100644
--- a/include/uapi/linux/alloc_tag.h
+++ b/include/uapi/linux/alloc_tag.h
@@ -85,9 +85,20 @@ struct allocinfo_get_at {
 	struct allocinfo_tag_data data;
 };
 
+struct allocinfo_toggle_traces {
+	/* inputs */
+	/*
+	 * Tags matching the filter are toggled; an empty mask selects all tags.
+	 * Size criteria are checked once, against the tag's size at call time.
+	 */
+	struct allocinfo_filter filter;
+	__u64 enable;
+};
+
 #define _ALLOCINFO_IOC_CONTENT_ID	0
 #define _ALLOCINFO_IOC_GET_AT		1
 #define _ALLOCINFO_IOC_GET_NEXT		2
+#define _ALLOCINFO_IOC_TOGGLE_TRACE	3
 
 #define ALLOCINFO_IOC_BASE		0xA6
 #define ALLOCINFO_IOC_CONTENT_ID	_IOR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_CONTENT_ID,	\
@@ -96,5 +107,7 @@ struct allocinfo_get_at {
 					      struct allocinfo_get_at)
 #define ALLOCINFO_IOC_GET_NEXT		_IOR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_GET_NEXT,	\
 					     struct allocinfo_tag_data)
+#define ALLOCINFO_IOC_TOGGLE_TRACE	_IOW(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_TOGGLE_TRACE,	\
+					    struct allocinfo_toggle_traces)
 
 #endif /* _UAPI_ALLOC_TAG_H */
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index ca2412a67312..9ff9dd04d692 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -60,6 +60,15 @@ DEFINE_STATIC_KEY_FALSE(mem_profiling_compressed);
 DEFINE_STATIC_KEY_FALSE(alloc_tag_trace_key);
 EXPORT_SYMBOL(alloc_tag_trace_key);
 
+static atomic_t alloc_tag_trace_cnt = ATOMIC_INIT(0);
+
+/*
+ * As `codetag_lock_module_list` is a read lock, we need an additional mutex
+ * to protect against the race conditions involved in the alloc tag trace
+ * toggle path.
+ */
+static DEFINE_MUTEX(alloc_tag_trace_mutex);
+
 struct alloc_tag_kernel_section kernel_tags = { NULL, 0 };
 unsigned long alloc_tag_ref_mask;
 int alloc_tag_ref_offs;
@@ -296,7 +305,7 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
 		return false;
 
 	if (filter->mask & ALLOCINFO_FILTER_MASK_INACCURATE) {
-		inaccurate = !!(ct->flags & CODETAG_FLAG_INACCURATE);
+		inaccurate = alloc_tag_is_inaccurate(ct_to_alloc_tag(ct));
 		if (inaccurate != !!(filter->inaccurate))
 			return false;
 	}
@@ -317,6 +326,23 @@ static bool matches_filter(struct codetag *ct, struct allocinfo_filter *filter,
 	return true;
 }
 
+/*
+ * Checks that a user supplied filter only uses known fields and that its size
+ * range, if any, is not inverted.
+ */
+static bool allocinfo_filter_valid(const struct allocinfo_filter *filter)
+{
+	if (filter->mask & ~ALLOCINFO_FILTER_MASKS)
+		return false;
+
+	if ((filter->mask & ALLOCINFO_FILTER_MASK_MIN_SIZE) &&
+	    (filter->mask & ALLOCINFO_FILTER_MASK_MAX_SIZE) &&
+	    filter->min_size > filter->max_size)
+		return false;
+
+	return true;
+}
+
 /*
  * Seeks the ioctl iterator to the specified 0-indexed tag position, reads its
  * profiling data and returns it to userspace.
@@ -333,12 +359,7 @@ static int allocinfo_ioctl_get_at(struct seq_file *m, void __user *arg)
 	if (copy_from_user(&params, arg, sizeof(params)))
 		return -EFAULT;
 
-	if (params.filter.mask & ~ALLOCINFO_FILTER_MASKS)
-		return -EINVAL;
-
-	if ((params.filter.mask & ALLOCINFO_FILTER_MASK_MIN_SIZE) &&
-	    (params.filter.mask & ALLOCINFO_FILTER_MASK_MAX_SIZE) &&
-	    params.filter.min_size > params.filter.max_size)
+	if (!allocinfo_filter_valid(&params.filter))
 		return -EINVAL;
 
 	priv = m->private;
@@ -443,6 +464,74 @@ static int allocinfo_ioctl_get_next(struct seq_file *m, void __user *arg)
 	return ret;
 }
 
+static void alloc_tag_trace_toggle(struct alloc_tag *tag, bool enable)
+{
+	if (enable) {
+		if (alloc_tag_is_traced(tag))
+			return;
+
+		alloc_tag_set_traced(tag);
+		if (atomic_fetch_inc(&alloc_tag_trace_cnt) == 0)
+			static_branch_enable(&alloc_tag_trace_key);
+	} else {
+		if (!alloc_tag_is_traced(tag))
+			return;
+
+		alloc_tag_clear_traced(tag);
+		if (atomic_dec_and_test(&alloc_tag_trace_cnt))
+			static_branch_disable(&alloc_tag_trace_key);
+	}
+}
+
+/*
+ * Toggles tracing on every allocation tag that matches the user supplied
+ * filter. An empty filter mask selects all tags, same as for
+ * ALLOCINFO_IOC_GET_AT. Tags already in the requested state are not an error.
+ * Requires CAP_SYS_ADMIN.
+ */
+static int allocinfo_ioctl_toggle_trace(struct seq_file *m, void __user *arg)
+{
+	struct allocinfo_toggle_traces params;
+	struct codetag_iterator iter;
+	struct codetag *ct;
+	struct alloc_tag_counters counters;
+	bool fetched_counters;
+	int ret = 0;
+	int matches = 0;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	if (!allocinfo_filter_valid(&params.filter))
+		return -EINVAL;
+
+	codetag_lock_module_list(alloc_tag_cttype);
+
+	iter = codetag_get_ct_iter(alloc_tag_cttype);
+
+	mutex_lock(&alloc_tag_trace_mutex);
+	/* Toggle tracing on all codetags that match */
+	while ((ct = codetag_next_ct(&iter))) {
+		fetched_counters = false;
+		if (matches_filter(ct, &params.filter, &counters, &fetched_counters)) {
+			matches++;
+			alloc_tag_trace_toggle(ct_to_alloc_tag(ct), !!params.enable);
+		}
+	}
+	mutex_unlock(&alloc_tag_trace_mutex);
+
+	if (matches == 0)
+		/* Nothing matched the filter */
+		ret = -ENOENT;
+
+	codetag_unlock_module_list(alloc_tag_cttype);
+
+	return ret;
+}
+
 /*
  * Entry point ioctl function for /proc/allocinfo routing requests to fetch the
  * layout content ID, seek to a specific tag, or read sequential tags.
@@ -463,6 +552,9 @@ static long allocinfo_ioctl(struct file *file, unsigned int cmd,
 	case ALLOCINFO_IOC_GET_NEXT:
 		ret = allocinfo_ioctl_get_next(file->private_data, arg);
 		break;
+	case ALLOCINFO_IOC_TOGGLE_TRACE:
+		ret = allocinfo_ioctl_toggle_trace(file->private_data, arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
@@ -492,8 +584,6 @@ static const struct proc_ops allocinfo_proc_ops = {
 
 void __alloc_tag_trace_hit(struct alloc_tag *tag)
 {
-	if (unlikely(!tag))
-		return;
 	trace_alloc_tag_hit(tag);
 }
 EXPORT_SYMBOL(__alloc_tag_trace_hit);
@@ -1031,6 +1121,24 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 	return 0;
 }
 
+static void unload_module(struct module *mod, struct codetag *start, struct codetag *stop)
+{
+	struct alloc_tag *start_tag = ct_to_alloc_tag(start);
+	struct alloc_tag *stop_tag = ct_to_alloc_tag(stop);
+	struct alloc_tag *tag;
+
+	/*
+	 * Turn tracing off for the tags of the module being unloaded. Without
+	 * this, `alloc_tag_trace_cnt` would never reach zero and tracing would
+	 * stay enabled forever.
+	 *
+	 * `alloc_tag_trace_mutex` is not needed here as this code path is
+	 * protected by a `down_write(&cttype->mod_lock)`.
+	 */
+	for (tag = start_tag; tag < stop_tag; tag++)
+		alloc_tag_trace_toggle(tag, false);
+}
+
 static void replace_module(struct module *mod, struct module *new_mod)
 {
 	MA_STATE(mas, &mod_area_mt, 0, module_tags.size);
@@ -1357,6 +1465,7 @@ static int __init alloc_tag_init(void)
 		.alloc_section_mem	= reserve_module_tags,
 		.free_section_mem	= release_module_tags,
 		.module_load		= load_module,
+		.module_unload		= unload_module,
 		.module_replaced	= replace_module,
 #endif
 	};
-- 
2.56.0.506.g506a7eabc5-goog

