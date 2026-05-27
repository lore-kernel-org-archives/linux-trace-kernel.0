Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2C31E84B;
	Wed, 27 May 2026 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890806; cv=none; b=C8zYOA5cnO8PAM1m1ZH4bs17qK5yh3M6oIPkMPPtspsrkB1SwlYJKT/Z3OCwICDAUcvMpSWl5iUrtVOTlUmHssJdFCtIIRtt05zeYbTNzFEOYC8AcKNE5zGm91zZgJpuOkZZQGESrma1xMiOURBLwc3g3gSw4aIxr2TvFjABA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890806; c=relaxed/simple;
	bh=ScD3PYIZI0a0zheAr9zG3EYnPdJ+1Id9YqVY4Vqhi9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riMFNSQ0wRsZCgWObB+FdtHh4Y19oQ9/nparI0iRAaR10WKvxprpmyrLIlWwNc7LbdEU2PsKNT7mh6Hzqy++F6JSFNERlUy9FBmEbxaiEUjPDhQRMSB6GnUXDH0ED8f/vaHuhD0wJKZr71Z+J+zHh7FMwPcloGFoI48W6JDquoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QEgjkc8Z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QEgjkc8Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=grLDsIqWV1YHU9+uNN+g0k8WBJT1n49B8J5hsZ/KNBM=; b=QEgjkc8ZiHM0a65uX8TFwr0ni3
	0VWPsqHr237btqTgnn0azc/epmWYgkd2lC+4KG/Lqs5Q+foW+/8BlZc7+4EBg1hvUAiEVTz11298L
	nND5hSsWnlSTzfzkPOXpYgoJZyJB2LRi/QLYf3q1ej71q2fd8mB8N49iSG9O6aq3r77nhM/vHZoW+
	DTmP4aTR4Up2viHeZawCjyt2Hy1NND+1md40acVax581K8QqtgXILaXo8bMzTaBrd+YbBsWIt/zqq
	xgG5ITpkw57emP87MzsX7XHiVcomYS/axDADRCTQHTQxnTRXoLXvSx/Fg8NYA7IbL93BRb8lX9VIB
	mhHvq0ow==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wSEuA-003DTD-2w;
	Wed, 27 May 2026 14:06:43 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 27 May 2026 07:06:16 -0700
Subject: [PATCH v8 3/6] mm/memory-failure: report MF_MSG_KERNEL for
 unrecoverable kernel pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-ecc_panic-v8-3-9ea0cfa16bb0@debian.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
In-Reply-To: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349; i=leitao@debian.org;
 h=from:subject:message-id; bh=ScD3PYIZI0a0zheAr9zG3EYnPdJ+1Id9YqVY4Vqhi9M=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqFvpbSHPg/Q3Yw/y6hVA3+yUCTI5vOf63OaaDy
 PBtuXI33n2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahb6WwAKCRA1o5Of/Hh3
 bfXJD/4243i7IKsLyoJqofCvvgKk9Dsh5l+ijiS4/qpYxUtgxCTg9AGQ7dwb6gA1j5ynY2ualvU
 hueGPfZztKfg/yhB6R0A9SzM8tXHXMRqgicNVspCzCvs7MeKkemykMLcT1oudAxIVxwyjrprib3
 SaDs2sTAL3SJA/MRvuTWOOyQiewhmH4vjtlutp9FOHWTfCiO6Zy83C+F4OeQ1827Vspm8ME4eBS
 HM4ZMPyC9+iv1mQS9djCxHdMpnzLSMg7KW2spA342HL9gP3dnFw4KOM2tVrKDA7rpfptTjnqX5K
 Idi3cZ9REl08MWzDB+IDTGEdgsO7ATX2g9iIbnfKiRb8TvIIkEcZKi+GhFyI1FvJfXIr2HDeUcD
 RPC0xxN4mZb5ejFmqdv3tKBwxwo+JUd/RI3NKgXbxoL1qFJYvwEujqb02oyHA2YG9rrvBlCED1a
 p5hjanYu66vGyfWMYAUDSSrbJGyF3wPn0R8EbB2LcXEJhNAGbaFVqQg4EBE1xVKZANHxAEUo5f5
 jqAp6CVyRnBBkn5jcOS5YGUjYoQcuLGjIMD3+fe+oWNBRbsFkbVQWNSp9p+BMLoHz3Vi72bnbIu
 1SKWwuvZVfO/swdzfQ5iF/sQiFIWYuYUWQTQAtnczGshWv1wttb0tLuq8OP+WR7cBmIuE4RQ18D
 UuD/cCh1h76EoYA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The previous patch teaches get_any_page() to return -ENOTRECOVERABLE
for stable unhandlable kernel pages (PG_reserved, slab, page tables,
large-kmalloc).  memory_failure() still folds every negative return
into MF_MSG_GET_HWPOISON, so callers that want to react to the
unrecoverable cases (a panic option, smarter logging) cannot tell
them apart from transient page-allocator races.

Turn the post-call branch into a switch over the get_hwpoison_page()
return code: map -ENOTRECOVERABLE to MF_MSG_KERNEL and any other
negative return to MF_MSG_GET_HWPOISON.  case 0 keeps the existing
free-buddy / kernel-high-order handling and case 1 falls through to
the rest of memory_failure() unchanged.

The MF_MSG_KERNEL label and tracepoint string are kept as
"reserved kernel page" to avoid breaking userspace tools that match
on those literals; the enum value still adequately tags the failure
even though it now also covers slab, page tables and large-kmalloc
pages.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 8f63bdfeff8f..14c0a958638c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2426,7 +2426,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	res = get_hwpoison_page(p, flags);
-	if (!res) {
+	switch (res) {
+	case 0:
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -2445,7 +2446,19 @@ int memory_failure(unsigned long pfn, int flags)
 			res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 		}
 		goto unlock_mutex;
-	} else if (res < 0) {
+	case 1:
+		/* Got a refcount on a handlable page. */
+		break;
+	case -ENOTRECOVERABLE:
+		/*
+		 * Stable unhandlable kernel-owned page (PG_reserved,
+		 * slab, page tables, large-kmalloc).
+		 * No recovery possible.
+		 */
+		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
+		goto unlock_mutex;
+	default:
+		/* Transient lifecycle race with the page allocator. */
 		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 		goto unlock_mutex;
 	}

-- 
2.54.0

