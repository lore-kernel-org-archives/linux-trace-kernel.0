Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FE37475B;
	Mon, 11 May 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513969; cv=none; b=u1C/NzN8cpdYYXcnWXph7+J0jbiP7XXcGhcRdC1Ap3sfXpnjjI5QHjrQ6S3WtkuVmgqGMEr63qG0KPeEYNJSWDcGkxbKEPGRBS41kEaKUYoOqAeJS0GQLBYFtUvUQfLSwj5453sHWu9+Pjx6VZ3/LncB5pHmwa5+bJWEXJ34Vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513969; c=relaxed/simple;
	bh=QI/LnjFxb7VYKP9kMjSn/xHKUbboDh93Ly768NA/Sh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3B3qLlBFREhS7hqZv9wFrVMYimrvjllP4ZnMFMyZe4YoZyjiO61L8yzfIB5HMK2qQY8So0FVX1oAA3u9vScrcavDHA95Avx+cE9fKW/TSO/B1mgHWovdGk/BNzDaUZGlojpdgNN0Xper0P3C5hk2tGoUpApRDJprDbHEy68EIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pHF4q8JM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pHF4q8JM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=b69sgv2dXzpZgJDqciacSImGKfghtkSEKpreyIG4ANY=; b=pHF4q8JMOvrjEpRpwvdcA/Y0AJ
	bmSwsdg9aFx2wApYypxub3xgo7pX1pwsntjBMS+3qBBDL4jcJlUirPrArj1scXnVrYnhBDrVV/4nb
	qSoIA8e02BXn1wB3VwCB+Xop+/dS2GDOjlSUezrzHYlfluEkb5JTaURHKTEL1zrCihS+FuLYSLwNl
	Z9oJrgzH/+GsyWuKIImkgvIpbN1ZLRnMNQt54EO1ukZSM3MmUPAcq4IATUW9NJGMKhTORPWzZ3Uiv
	uU3jDYbqiIOePo8Bs7o5aZTb8aqRRjo9yoO7Q0qyKB4sFh1CoZrAveaReS95ZkRFwGExkpn8FJlH6
	NWCrLkgA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMSj7-001hV4-0s;
	Mon, 11 May 2026 15:39:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 08:38:35 -0700
Subject: [PATCH v6 1/4] mm/memory-failure: report MF_MSG_KERNEL for
 reserved pages
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-ecc_panic-v6-1-183012ba7d4b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=leitao@debian.org;
 h=from:subject:message-id; bh=QI/LnjFxb7VYKP9kMjSn/xHKUbboDh93Ly768NA/Sh0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAfggio+Z39e2w7EmkUhdYSq8j8L3EAJysjNpB
 FODq8lSTPSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagH4IAAKCRA1o5Of/Hh3
 bWOQEACiBsHHaTmf6qkAQgpaa6psj5wgPRGrykdRJebZdVweBu/5FladzS3IRVJ1nn8r4sIv237
 /Kn8R5feYMah7QSWj4s5mmO5v2efGVHq3yxkl9Zomn5uK533a5eGM9EfvCA2ENMpBUgYQcb65Qz
 E3zpItx14T5EcEMPhQec4ga2godHp86qBhe3fY1jp7mSOsjFvDsBbdbP+o4dmgPUTXrfqmz7O5x
 Qt3nk/3aBCGUW4CdNyviQy/YwaRWkcNslxlXyX26EAsxAalB7r88pShp21mNej+Arduktkk4OfO
 UMMnI+R6IlJwBGZfqAdWpCjNfknHSZ0O4BvEWLZo/Kq0IENtGmuL2taWPNcybeHd0GuTKch49Sv
 qtLwyVy/yDbgFgCy3/cLYOtrFQCiT9PkjFjV+gTHdwLBRpwTuSF45L4OTBZbxhvub687mIpZ/06
 paXT5WGuj27VbrH97RZR+HS1WBqI0WZdXlOo8wxxZvHW0llRpYW4TY7NLqnf3IYk1qFcwQ8CpUb
 lAPUyne3lUEXvO/fZb3qvhDbR3nZPrqHBp9mgz3CqI1RUlbSd7ah7nSviK16/itInpmYTEBi/PJ
 q3964OeR4em/5dSp15ZPmkR1Sx5OzLGPc4DFB0VEH68E86W4IddkvWgTFXu99qc9gPL2DketpkK
 XSmhf4aCOTJPoew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

When get_hwpoison_page() returns a negative value, distinguish
reserved pages from other failure cases by reporting MF_MSG_KERNEL
instead of MF_MSG_GET_HWPOISON. Reserved pages belong to the kernel
and should be classified accordingly for proper handling.

Sample PG_reserved before the get_hwpoison_page() call. In the
MF_COUNT_INCREASED path get_any_page() can drop the caller's
reference before returning -EIO, after which the underlying page may
have been freed and reallocated with page->flags reset; reading
PageReserved(p) at that point would observe stale or unrelated state.
The pre-call snapshot reflects what the page actually was at the
time of the failure event.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 866c4428ac7ef..f112fb27a8ff6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2348,6 +2348,7 @@ int memory_failure(unsigned long pfn, int flags)
 	unsigned long page_flags;
 	bool retry = true;
 	int hugetlb = 0;
+	bool is_reserved;
 
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
@@ -2411,6 +2412,18 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
+	/*
+	 * Pages with PG_reserved set are not currently managed by the
+	 * page allocator (memblock-reserved memory, driver reservations,
+	 * etc.), so classify them as kernel-owned for reporting.
+	 *
+	 * Sample the flag before get_hwpoison_page(): in the
+	 * MF_COUNT_INCREASED path, get_any_page() can drop the caller's
+	 * reference before returning -EIO, after which page->flags may
+	 * have been reset by the allocator.
+	 */
+	is_reserved = PageReserved(p);
+
 	res = get_hwpoison_page(p, flags);
 	if (!res) {
 		if (is_free_buddy_page(p)) {
@@ -2432,7 +2445,11 @@ int memory_failure(unsigned long pfn, int flags)
 		}
 		goto unlock_mutex;
 	} else if (res < 0) {
-		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
+		if (is_reserved)
+			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
+		else
+			res = action_result(pfn, MF_MSG_GET_HWPOISON,
+					    MF_IGNORED);
 		goto unlock_mutex;
 	}
 

-- 
2.53.0-Meta

