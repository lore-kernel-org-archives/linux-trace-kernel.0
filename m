Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0652BEC3F;
	Tue,  9 Jun 2026 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002651; cv=none; b=pHpJWsVOvvnJZuGiZ/sIZHOdcKZZt/3JlV4ScCiAwc/INKax2UaElfMtFT2spcFr/KxaXE/c5L1eseAJ0AD8Ma7KK8iGxSrqBMDNextzS+n6ylkkkZ0XwzNq72/eqFrWjPz6JXSiRSxWFywWwEPR1bs7tUmVf4AOLqKkqukvblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002651; c=relaxed/simple;
	bh=Oc/n/XwBBXtwbj6X9XE1i3pEwNRXj+wVbkUgEoDgdsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJRDQVxxXEG0LjMRMui0DF3IY1XY24C5ftMswLJA0u2Wd63BJ+pDh32fSdBeBeQvV8uobsDFtNZDsNdBfPhi4xLt3NteHVLKxLB6F2kJVRgPv1cylPdWIyOdVIrBLNb/8woFyPpvtLi8CPVKaoqziVogP2eUCvNl7F4UYbJh3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Lpx7hj9G; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Lpx7hj9G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=+nohVdFqLh53p7CXnhNyUtPR5DDNhEHlR6gaOs/wF1M=; b=Lpx7hj9G3s2TQTtB/xam5NsxlC
	y+WwN0BvnZBo543Eh7xDClDaakrH+ZmRXr2aiv7yjHHbwJclE6ePbiAc2H5WdRwT/SHi21ZbErK5g
	MJxu++r1QV0RILCD5OruTlkld+JYAp28rUdrXlv7r2ptbUB5XKmOsnhvAT9epcRyjb5+PlIWEXnho
	c+AyhQDWoetpWJA67YIMl96bVfDOkaH/e8Cn+EYS8K/ta9Mt5ACfoA7z1NvqxyymRovS4C2MOTcPM
	TGN2GDM+JrfhaZoaLqBFdTqhqCONTdSACimyc7w7wlYrGCJeCFOvQpZV+kgE8lu2PL8l5BzbFZfdP
	VdtDaaqQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWu98-008LtT-1n;
	Tue, 09 Jun 2026 10:57:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 09 Jun 2026 03:56:57 -0700
Subject: [PATCH v9 3/6] mm/memory-failure: report MF_MSG_KERNEL for
 unrecoverable kernel pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ecc_panic-v9-3-432a74002e74@debian.org>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
In-Reply-To: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; i=leitao@debian.org;
 h=from:subject:message-id; bh=Oc/n/XwBBXtwbj6X9XE1i3pEwNRXj+wVbkUgEoDgdsE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqJ/F/kF2/XCBiL5ksWydZps0h/w0J3/rHD35aY
 2p6eZM0TB6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaifxfwAKCRA1o5Of/Hh3
 bUotD/4kz5OLP+m2jSn6O6pSdolh2/muiWL7jwAJoIvQHPL9hMW15HTEPNeOJgT5BGvvsGw5tMH
 c6I4yqQuN7qu/HIlsjn7r+eIRt8e3RUi3FseWx0v4zAD8W7t4/gy32ASUAZDh2HQostVe6jODsI
 nHxByOIw8FvQmcG1EryDDz/zVlXGeU96DB/1gEdrEEKmLZc4LzDtz59Q6/UZVVwfk6Wb8S6v5y2
 XFJPV8ZtuA0ARqrghH8HfJHtErdgKvEDjOWAwgUKfoM5+7Xb+cd83pai3fY9Jel840DP1DX6Qj8
 vCdCONy8NtQrqEC5w8rMQlpxSpWcvYax9eBaXZM1v1NoMiKhAOgJ82VZFQCEsGP8Ce6HoDDN7/5
 4cAN7QqGpLi0ntBoxiAqwO1kMirrciC+I918RJH4hS/VaFSM3krN1rplSDRktJtZWwoubTYrHgG
 47EkJbJecMzwO6GiBlyV3+8MRCLugLAM5iWWUM5QAaZerKVrMfpoO3te5Gd0C7oqVDzoii2h7Tz
 c4qDqWrMImt0aCAfar6u2IaLjLnELIaoZS4CyOWUSoXIo7mIDuNXv/yvxy4mRVM/Q+6hKd/Pm+3
 lwp1lVmZ7Y+rok9jWEi2fEy4FO/4U/EU7Dp7X2K+4r3fdOQoHhIm56F05PzJlFO7tkXuy5uvy3G
 SJpfI1qHxJBB3+Q==
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
index eed9de387694..35f2b5d89fbe 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2444,7 +2444,8 @@ int memory_failure(unsigned long pfn, int flags)
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
 	res = get_hwpoison_page(p, flags);
-	if (!res) {
+	switch (res) {
+	case 0:
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -2463,7 +2464,19 @@ int memory_failure(unsigned long pfn, int flags)
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

