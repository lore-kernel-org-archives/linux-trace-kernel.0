Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430214921BE;
	Wed, 13 May 2026 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686806; cv=none; b=c1rnz+KbEQxbocEhLifVzEsneZwdxRG7w4jCEFAvrmfE4sN2IMCdnet6XSZjHajBsrU83tJw4q2TJJNvRhfPP+T1+NDJDuSDrWzCkXvETX8cN5ThhQ8+3APgsyvTef93kDZSm92m/9XK0o6RzwsSu5qAV0taCQzpUHWlGxuWSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686806; c=relaxed/simple;
	bh=aUpEGreCiiwo7XiCDP3nHwzdk2ozZEEtKzqxsRLQzJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8d/NCwm83ujquy4+pTXjIiC0zBo+ufKFkz0r+HstjnkbetWioJQx8/wXzBmxSg+FYVVCCieh3gZ6FJtY6/ILPRSPprLI2PjdQfWJ0WlNL+r18VvH9m5eUxWs5myS13idNk6xiGD9eb2UOUR7kfP9lwXXBARIR1mXip2WFWwU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cWvoBNcC; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cWvoBNcC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/6+k4U3CigWMPa6eRngECurunw+EDs/D/cMRSqJBO8A=; b=cWvoBNcCwzDa9aLv5h70R/mcbs
	PIWp5U14kA+Xrw+I4if9aIU6wpGyKgfEhW5Y8Z7W/D5YckhnxvCaaQShK/YvNegvCluvX6yQLR/I7
	/PCeMjL+eIqsrTyTCpunIZzfvQtNLT50jVVytGljcbyenKQRWoOA6ARdWKsCtWR7EsNikscFT1oT8
	Q31u/fP8EP3hLxhQCYHXWAmhAO3eL+gVi2aXdqB5Xx5LDLsT3nRNcZEJwbs7ClJEu+tlMSUpvft9g
	JwNERdRpSxbdaRYyLwJ2BLhoxkooUqmwnulAufiPZuJYLkL6Jbm2hBYUKd4Gb2wTf6HyGICLxQRt9
	d3wcpdlg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBgo-003GU6-26;
	Wed, 13 May 2026 15:40:02 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 08:39:34 -0700
Subject: [PATCH v7 3/6] mm/memory-failure: report MF_MSG_KERNEL for
 unrecoverable kernel pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-ecc_panic-v7-3-be2e578e61da@debian.org>
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
In-Reply-To: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=leitao@debian.org;
 h=from:subject:message-id; bh=aUpEGreCiiwo7XiCDP3nHwzdk2ozZEEtKzqxsRLQzJQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBJs7vngK9RETyLDF63o1EnEfYGgE9nv+9reDZ
 QJAssZ8oZqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagSbOwAKCRA1o5Of/Hh3
 bVBOD/42fbJ1SIKiXMo7f8f99fs30cZrVejZGjSwvrCi8ZkL5L+6m3DTmQ9ebEeTvLyJl4tugs9
 nlyHwMuz2XZTExQHD/s96rlCtCq1qZuOTdiwBJMFxuWzXLcjFsIV1Pk5p7Ug0gZazN5eDuxRMxG
 4shDiaETS5V3LOP6yuIBje+R60oa0u4UZ7BpFNswvrtQ06gQr+iiH8mH/FoqCJcauhUfCg44MEU
 3aVobIQLqrcxhagv+UPkqlQ0y/pjxnq8MKzwg0lLdhJ5asf1Zy0f67ryt79v1O+NtZtV7RVdA8z
 pOkfJGHV/nD1WCSuy0iZHfgBsanH2szAR1791eyvG4czAd3bMen/vUDb00M/wmz2ppZu6fFqsVP
 TrP35jSeXKDgHqw41fkSddZ9V3MGXLcRpzrh+58jy6izLx1oFURAV6J7Ff2n20bMyTiIKcbP3kC
 uDmTAz9qcMgUzEKJe5YzkbvDwmtcw3B9hYbMKO/mdY49Bx62MuQTppPW+vo0IYHfaJElcvhvZ3H
 BLsLQSX03QA+kZyrb7NTYUctOHoTx3s3vRugPznfFbGM/74kjm1SfEBY9QNyAUJtckjPOvp6JLS
 dGe30VDx4YhSX7UDwzSpVH2eNfHaDpHe5Jsfsv5Szg2+g/v4X6bkY7lShw0liPepWBqZEAuKP3d
 MNdScg4izAJjT8w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The previous patch teaches get_any_page() to return -ENOTRECOVERABLE
for stable unhandlable kernel pages (PG_reserved, slab, vmalloc, page
tables, kernel stacks, ...).  memory_failure() still folds every
negative return into MF_MSG_GET_HWPOISON, so callers that want to
react to the unrecoverable cases (a panic option, smarter logging)
cannot tell them apart from transient page-allocator races.

Turn the post-call branch into a switch over the get_hwpoison_page()
return code: map -ENOTRECOVERABLE to MF_MSG_KERNEL and any other
negative return to MF_MSG_GET_HWPOISON.  case 0 keeps the existing
free-buddy / kernel-high-order handling and case 1 falls through to
the rest of memory_failure() unchanged.

The MF_MSG_KERNEL label and tracepoint string are kept as
"reserved kernel page" to avoid breaking userspace tools that match
on those literals; the enum value still adequately tags the failure
even though it now also covers slab, vmalloc, page tables and kernel
stack pages.

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bae883df3ccb2..4b3a5d4190a07 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2410,7 +2410,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	res = get_hwpoison_page(p, flags);
-	if (!res) {
+	switch (res) {
+	case 0:
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -2429,7 +2430,19 @@ int memory_failure(unsigned long pfn, int flags)
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
+		 * slab, vmalloc, page tables, kernel stacks, ...).
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

