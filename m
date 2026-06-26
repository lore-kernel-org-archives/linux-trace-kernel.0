Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68516387361;
	Fri, 26 Jun 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488039; cv=none; b=SS5jYsh7GmcIdujTkbDlTu2Qv+x0D+qP3N5Ib14Ke3aQqZo/fCW8VrYy8YBFizzglLDHS16d25DtLFS4cSLasTmfCI/kb9lnpwwKNryL/Kk+HOK/dJC9O0ItEOvamYu95IAiVm/COYDG6P3q8CV3o7w9pu8HNhjyIATEtK9DbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488039; c=relaxed/simple;
	bh=s2QW9XqvL8WjZfXefwNoMxA+bTjAbl8h4pWt6UPLNg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJg5+1wH4VGzAl93ml5u1YlTLHBHn3ymQNSPuqSweR+XWC6rg8gnTVksppzupfB5sKEPwoO0tWeI+LHgl86k8l7RcopqfvVJcEq8buoO6NMVbQXXRiPLCu15VUChXzbueewMZq+0TWsa8j36pI/kzpv3r8oAWutNSGvPajPeGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R+ElvguU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="R+ElvguU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=5cGsV/GIb69F9aFisOiw65pvcyGs/UN2j5N9RMecrnA=; b=R+ElvguUazaRsX5LZ/Iv2jENMg
	U04nTy7B1v/7/h/4v3SAz55boZ4zWs433Mwb1yP7Rq7pNT+ZQhx3N4AM8BBmx1WKmZRciHhXUaorg
	RixBzuXWhImd3MEEEI9PZnyB992D/nXxg79UvXBcODlF7XJebhjVjCDame6vvL3G2dg89rfZ2YXNH
	rBHHfiZt/JsMT2BU7a/nMgXrZQ5lPe0BikY8j2hjeejwc72YZSh426CKF4ahgmqYCyhYDWTU9w56r
	w1gp/2LIvUr+BG8acEoHYpW9YJmaClw+L+1c/LE06h92pJuEsGLm/YAsw/atAxX301T0HH8i4CdeI
	b/HK6/MQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wd8Yu-00448L-1C;
	Fri, 26 Jun 2026 15:33:48 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 26 Jun 2026 08:33:17 -0700
Subject: [PATCH v10 3/6] mm/memory-failure: report MF_MSG_KERNEL for
 unrecoverable kernel pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-ecc_panic-v10-3-6dacb8ad024d@debian.org>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
In-Reply-To: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=leitao@debian.org;
 h=from:subject:message-id; bh=s2QW9XqvL8WjZfXefwNoMxA+bTjAbl8h4pWt6UPLNg0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqPpvEksQl12A/z+cCFlT5a56cpPKQDQtLbk7w0
 4d+6v+0RMKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaj6bxAAKCRA1o5Of/Hh3
 bVNiD/9SX076q5vGZiW2lgbbjfY+ggMk1c05Mw+nXFbi34vQfYN4L7EoW3mQlkCxzJ9hkpMH2dv
 DCNd6XPue6dY11w2akyjJlOzjYZnyHIDEVPyTiGGHF6emB653b1gp9+wySSJ2G1erY5nLomjTmS
 dUzE4zvj52+venVYza+suoJzQ0O1Nn9alK4mKE71ANHiTne6EFJ+Qh69GeWPqBF8zwn/YmwPetV
 WBjZRpkoyePndEOpCo+lzWHJum0L13HyCyvDXoesiU2KLtiBI+r2t4Jqp/OfBUapm0teEZMe530
 8/KuNwiE8GfaRiWiwNuZfdSkAO7VkAvR9AUiTCozpRFTZm4UBwLQg5Cxyf5MmR7sqaXB7IEG7ND
 OB7+BvywXxhMTpVldg1nXylQKh53mqAmlF6AFssI89QI4ApwleJwYgzTxB2C30pua3BcHKpJXyE
 F3Y97D8F1hjl9DmQeXQpYF0mYhAQrsrcbk+o8Ceus4UGMtZAqJz9Nol2xf1SWFAmfgx6zVbRVC5
 WWKsxE5WFuSqHgIyNkOQtKDcpalT/gdJFKfK2OzpiTAnr6eJmQpxtE/0ZiVLrShTQVV+Wl6vIfJ
 PBlxTTYC1chaBsTz4D311WVkG53ml3azBEXdBNBOb+mjX9CKwNVssQRt6t+jb7i7qpfnXorkoMT
 NF4BubXxohc5JcQ==
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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d08fbd0d8c39f..8e2aa2fafc14e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2434,7 +2434,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	res = get_hwpoison_page(p, flags);
-	if (!res) {
+	switch (res) {
+	case 0:
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -2453,7 +2454,19 @@ int memory_failure(unsigned long pfn, int flags)
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
2.53.0-Meta

