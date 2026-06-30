Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707583FBEC1;
	Tue, 30 Jun 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823608; cv=none; b=AWD3eylImk0tnfP/kRzPFVVjscsvPu6VyAm+3+QgcBYWDTpN7whkiqhXkWgelChYWA4V2nSDfIefhqq+P4m3C7PvgV04ijmX2IEja2MtwFS1xfv7ESu+TWOmaLVAOHGrcGm595wke8uIAnA0G5ZFFsJLjv1FnrTitdT4uS5H51o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823608; c=relaxed/simple;
	bh=JSAYCq4FrRtXIBW3O9fBpGpm6NgSi4FFUoqeHM4uUhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EoTU0fUGBqeeqnLdFbLFg5Jgy0Q/ICILeZn8u2yr2IR788gGYSDoTUJm8fs99rqIsjhqsQrts4s9/A3IwlmkUYIfZbdAun4JdVOubWY/03sOETQEMzsBF9pVMxqJx5LgvX/YQINSBu7B0O91MUPX/jAVXSom5ccqJLXoXnuLr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QLV75adW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QLV75adW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=JRc6X3siF0MV7UwOUK6r+AaS4VmaqOkmIcYSgppzMs4=; b=QLV75adWAdll+nLPDpabSITgCm
	WRfwp7heAEQXdj6pNmooyLOLz6U/Q//nyvCW9GtHxbihPr8K5PeP+uEjHolTYu7mMu14epk8OTEKV
	+T4IudRkrWwP0xdMERYflB87MXWBJhgyj2wq+S5n0ppS6JI0XV+Hs6Ek5soct/ZqPcBXlXP0mu3xT
	RwF2c3tR2aKhJgjOy+UzrZ8IoPGOtdW0tmxUcL9PLr61FjCQBOmUBoCFGdPjEmmtRZCY04GXIt5Zs
	savCNoyEHcVZ4kjBfGgkBm3lxuUlnEvedKmzmUPQDfzZue8tQt6HPe+UVKzGBx/WSsuhmo8mIEKMP
	xXvcmh3Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weXrR-0074bY-2D;
	Tue, 30 Jun 2026 12:46:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 30 Jun 2026 05:46:06 -0700
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
Message-Id: <20260630-ecc_panic-v10-3-c6ed5b62eea2@debian.org>
References: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
In-Reply-To: <20260630-ecc_panic-v10-0-c6ed5b62eea2@debian.org>
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
 h=from:subject:message-id; bh=JSAYCq4FrRtXIBW3O9fBpGpm6NgSi4FFUoqeHM4uUhU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQ7qdbrCPdmwOUYMeBX462paxufYr9tGRerbCH
 OasygASlqmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakO6nQAKCRA1o5Of/Hh3
 bVVQD/4gPbn24odiOayBajbGFGEEeV5MaoKhhXG2x1/3quOUZTcQSMVzShINOIi4z9ZAlEMRTUE
 5ed/n2fywG3+FEe4q2dBRsc0/FYG3V9ELv8zNEZAX1EeSFWBFdDA2u7wgVfT+Un65/8XZ/k5KaV
 vpCH3gAO4HgKGe/uZevaJIgnb3L4eXaGu2e7kMQO8FVejK+v7knKyS3cvuLkPjhBGGHOZqJVZnV
 i7IHaqKqbE0UrR/8vO96QzE6DnjLHZnvLC4UnHNfWaze4VlfDxRyPTep3Ft86WddFeRbjKvvH09
 WMJ0j2cKBS+39po3CGSvekV/7MNXHNM8Qv6wnrASznY9CyzS5n8I5g5zZxyz9Z/DVWwIUY00KhW
 2a0FZ+pKA6b0gbIEwe++A0mcWP9dIEPyy6ZUWpoy7LdrfwtOqJ9bgGbxdtINVO71y8iypmC5WBV
 +QHCtoLaEV2LRAXfOmalZ4o7ACJRFW2oowTyLFpk6bIWxpu5bauNW1aop28+H6qmRCsMlN5rFV+
 5beF2+9R5OcrHUx/gvtOGO6whauiYOE9h45WUa32074n+BSjTdp4hd/nZTaRCoe8MR2QF4DNVZC
 ZYGxrEF34MtnDd1xCJ9T5of+4ojgSPUpMiOahFJC/EAgQNjC7/o9a3DfPebi1dSnSehwbs6LV0y
 Yyx0yYDZy/xtuSg==
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
index 087658484e242..5fc3de474014d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2436,7 +2436,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	res = get_hwpoison_page(p, flags);
-	if (!res) {
+	switch (res) {
+	case 0:
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -2455,7 +2456,19 @@ int memory_failure(unsigned long pfn, int flags)
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

