Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F4140243A;
	Mon, 11 May 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513974; cv=none; b=l/yp7fVyvt/r1cHd37ZglZlCZD2ESykRERFtD2o0F8XazyvqHhoBj9MQz9O6jFV3z26ut0EkQN1aWhHeFtz75iedY7Ep44S5lvfjui/9DIj+V7A+51kq10ZAwO7RcqGjYlhwjUnyrcVhv8eqqk3TxyVU/5f100LNqr/7N++SPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513974; c=relaxed/simple;
	bh=Vq/TU+jCW5xnnMwVP7n64LxYlem4v78afndyW+Xnc1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbrl3ms8EXiyYZ7CjLwJcDDjfUi0Ddfftwcp8/GbJIHYL98pQ+FNDKXYWRqKtjZTLkRNZhJsnBqAhGyyO1CVN/o7pv1B4GG7+USI/Z4/yk+xgWljTwH/ifKAXuMIikRu7jjOrkAxGQXe2kYobcpudpDJH5Dcjfs0BMQyOv7P7NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Uop926+6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Uop926+6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=xOVy0wpNRxKwqT5M1fLYor5fDbb75VUs7rVqfAvjRcw=; b=Uop926+6t+4cRPk0kGxLjnHIly
	EW1OIBB+FjdoGl1BBl3D2jxybTKGedam8bMAMZLA61RPOEcUfSXeYBr35H1bBRwZ50K+t400JW0rK
	RNqMHkXhlijzEBVYQrBKLRQXfOTXNKay2MMjkutxiLs5eH5BXdwM0pfEbQB2uisIu1oUM/1rF8Y2W
	hpnY/jjUdnAXkX/T6jSPY6W155FpsAwyrhLpy0H7idnKuJUP6u3XpQnkiKfwWCpAvamrdigxlKnCd
	MlXYOuUOHMoSGYmQBDeB8jdXYdQEHU4gBqMkrd86tM0A6SHwIf4OxKsD3qoyBq9IWP5Re9UtGfHsZ
	SucZcyrg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMSjD-001hV9-08;
	Mon, 11 May 2026 15:39:31 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 08:38:36 -0700
Subject: [PATCH v6 2/4] mm/memory-failure: classify get_any_page() failures
 by reason
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-ecc_panic-v6-2-183012ba7d4b@debian.org>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
In-Reply-To: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=7619; i=leitao@debian.org;
 h=from:subject:message-id; bh=Vq/TU+jCW5xnnMwVP7n64LxYlem4v78afndyW+Xnc1E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAfgg6fw77IZp1166aCin4HRrvDxnTzOvRc/Up
 zfVMSNRv4qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagH4IAAKCRA1o5Of/Hh3
 bRIND/9EIWGy+xxLCDjs0WxrQoLiWedbaJ8Om85T1rrASsN4ehnDAgZov3L7CDhah4u3SNhhTNI
 DY/3c4CCiIQ2PjB2FTGX/OC5kkbabDBBJGzDQ49eBo2yS4AyZs8snxxho4NXjQiJ8JyvC2053Or
 jm7NtwkCG9c5GSTsoTA7IkOIpZq21grmioJfGL48HxH3ANJw8osZsH73qx4p7wVB7H8guVg3/93
 uucAL0Y6ip2nuqGW5IzRTwMt9Fzuuktcx0C7rxfIGhxJoB9H1ap+RMioX373RvFUf+kO5as8rdo
 r7BuXtpXR/U8HNXDdrxH4Yi9cFJjK5JJWJGWoHKv5lyU/V3htV/xmzr4vjTj/2UDpn7IrfhkSLg
 q5LQf8cGu9RvszihpH15WNv95DD0ERa3jw1HgnjgtvvYtsbRPhXFQpBOTlU8nwathyVCvGIyAOo
 oG2CTnrodz2V8/dW1+hQU7b/g8VyFKwnbb6uXKWXL7RBEwi2onIkjalpc4GrxGoOfeuNaMTNJkw
 KbESAvDCyMBtYjdkn5Na+84be6rxYSWGAaYA0NBJDr/jtVBX6Br9hehHoBfOAhDxnFlY8UWsoHT
 CtfWTOrVDrLTsOToTTzOElyXc9lTy8jJ+E3OJ+C/WH3h3UJNRPF3RGboIr7gHM7mUtNsIL+6eEG
 zZLBlW9DQ+gtYZw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When get_any_page() fails to grab a page reference, the *reason* it
failed is known at the call site but is not surfaced to callers: the
HWPoisonHandlable() rejection path (a stable kernel page hwpoison cannot
handle — slab, vmalloc, page tables, kernel stacks, ...) and the
page_count() / put_page race paths (a transient page-allocator lifecycle
race) all collapse to a single negative errno by the time
memory_failure() sees them. memory_failure() can only observe the
conflated result and reports both as MF_MSG_GET_HWPOISON.

Surface the diagnosis explicitly. Add an mf_get_page_status enum,
plumbed out through get_any_page() and get_hwpoison_page() (NULL is
accepted by callers that do not care — unpoison_memory() and
soft_offline_page() pass NULL). get_any_page() sets the status at the
moment it gives up:

  MF_GET_PAGE_UNHANDLABLE — HWPoisonHandlable() rejected the page
                            after retries.
  MF_GET_PAGE_RACE        — exhausted retries on a refcount /
                            lifecycle race with the allocator.

memory_failure() then promotes the unhandlable case to MF_MSG_KERNEL
alongside the existing PageReserved branch, and leaves the
transient-race case as MF_MSG_GET_HWPOISON. This forms the foundation
a later patch will rely on to decide whether an unrecoverable failure
should panic.

Drop the "reserved" qualifier from action_page_types[MF_MSG_KERNEL]
and the matching tracepoint string in MF_PAGE_TYPE: the enum value
now covers both PageReserved pages and unhandlable kernel pages
(slab, vmalloc, page tables, kernel stacks, ...), so "kernel page"
is the accurate label for both populations.

Suggested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/trace/events/memory-failure.h |  2 +-
 mm/memory-failure.c                   | 46 +++++++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/memory-failure.h b/include/trace/events/memory-failure.h
index aa57cc8f896be..8a860e6fcb4e9 100644
--- a/include/trace/events/memory-failure.h
+++ b/include/trace/events/memory-failure.h
@@ -24,7 +24,7 @@
 	EMe ( MF_RECOVERED, "Recovered" )
 
 #define MF_PAGE_TYPE		\
-	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
+	EM ( MF_MSG_KERNEL, "kernel page" )				\
 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
 	EM ( MF_MSG_HUGE, "huge page" )					\
 	EM ( MF_MSG_FREE_HUGE, "free huge page" )			\
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f112fb27a8ff6..4210173060aac 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -878,7 +878,7 @@ static const char *action_name[] = {
 };
 
 static const char * const action_page_types[] = {
-	[MF_MSG_KERNEL]			= "reserved kernel page",
+	[MF_MSG_KERNEL]			= "kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
@@ -1389,11 +1389,29 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
 
 #define GET_PAGE_MAX_RETRY_NUM 3
 
-static int get_any_page(struct page *p, unsigned long flags)
+enum mf_get_page_status {
+	MF_GET_PAGE_OK = 0,
+	MF_GET_PAGE_RACE,
+	MF_GET_PAGE_UNHANDLABLE,
+};
+
+static void set_mf_get_page_status(enum mf_get_page_status *gp_status,
+				   enum mf_get_page_status value)
+{
+	if (!gp_status)
+		return;
+
+	*gp_status = value;
+}
+
+static int get_any_page(struct page *p, unsigned long flags,
+			enum mf_get_page_status *gp_status)
 {
 	int ret = 0, pass = 0;
 	bool count_increased = false;
 
+	set_mf_get_page_status(gp_status, MF_GET_PAGE_OK);
+
 	if (flags & MF_COUNT_INCREASED)
 		count_increased = true;
 
@@ -1406,11 +1424,13 @@ static int get_any_page(struct page *p, unsigned long flags)
 				if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 					goto try_again;
 				ret = -EBUSY;
+				set_mf_get_page_status(gp_status, MF_GET_PAGE_RACE);
 			} else if (!PageHuge(p) && !is_free_buddy_page(p)) {
 				/* We raced with put_page, retry. */
 				if (pass++ < GET_PAGE_MAX_RETRY_NUM)
 					goto try_again;
 				ret = -EIO;
+				set_mf_get_page_status(gp_status, MF_GET_PAGE_RACE);
 			}
 			goto out;
 		} else if (ret == -EBUSY) {
@@ -1423,6 +1443,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 				goto try_again;
 			}
 			ret = -EIO;
+			set_mf_get_page_status(gp_status, MF_GET_PAGE_UNHANDLABLE);
 			goto out;
 		}
 	}
@@ -1442,6 +1463,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		}
 		put_page(p);
 		ret = -EIO;
+		set_mf_get_page_status(gp_status, MF_GET_PAGE_UNHANDLABLE);
 	}
 out:
 	if (ret == -EIO)
@@ -1480,6 +1502,7 @@ static int __get_unpoison_page(struct page *page)
  * get_hwpoison_page() - Get refcount for memory error handling
  * @p:		Raw error page (hit by memory error)
  * @flags:	Flags controlling behavior of error handling
+ * @gp_status:	Optional output for the reason get_any_page() failed
  *
  * get_hwpoison_page() takes a page refcount of an error page to handle memory
  * error on it, after checking that the error page is in a well-defined state
@@ -1503,7 +1526,8 @@ static int __get_unpoison_page(struct page *page)
  *         operations like allocation and free,
  *         -EHWPOISON when the page is hwpoisoned and taken off from buddy.
  */
-static int get_hwpoison_page(struct page *p, unsigned long flags)
+static int get_hwpoison_page(struct page *p, unsigned long flags,
+			     enum mf_get_page_status *gp_status)
 {
 	int ret;
 
@@ -1511,7 +1535,7 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	if (flags & MF_UNPOISON)
 		ret = __get_unpoison_page(p);
 	else
-		ret = get_any_page(p, flags);
+		ret = get_any_page(p, flags, gp_status);
 	zone_pcp_enable(page_zone(p));
 
 	return ret;
@@ -2349,6 +2373,7 @@ int memory_failure(unsigned long pfn, int flags)
 	bool retry = true;
 	int hugetlb = 0;
 	bool is_reserved;
+	enum mf_get_page_status gp_status = MF_GET_PAGE_OK;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -2424,7 +2449,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	is_reserved = PageReserved(p);
 
-	res = get_hwpoison_page(p, flags);
+	res = get_hwpoison_page(p, flags, &gp_status);
 	if (!res) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
@@ -2445,7 +2470,12 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 		goto unlock_mutex;
 	} else if (res < 0) {
-		if (is_reserved)
+		/*
+		 * Promote a stable unhandlable kernel page diagnosed by
+		 * get_hwpoison_page() to MF_MSG_KERNEL alongside reserved
+		 * pages; transient lifecycle races stay as MF_MSG_GET_HWPOISON.
+		 */
+		if (is_reserved || gp_status == MF_GET_PAGE_UNHANDLABLE)
 			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
 		else
 			res = action_result(pfn, MF_MSG_GET_HWPOISON,
@@ -2750,7 +2780,7 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
-	ghp = get_hwpoison_page(p, MF_UNPOISON);
+	ghp = get_hwpoison_page(p, MF_UNPOISON, NULL);
 	if (!ghp) {
 		if (folio_test_hugetlb(folio)) {
 			huge = true;
@@ -2957,7 +2987,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
+	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE, NULL);
 	put_online_mems();
 
 	if (hwpoison_filter(page)) {

-- 
2.53.0-Meta

