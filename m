Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585A4963C0;
	Wed, 13 May 2026 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686811; cv=none; b=SQ7YmmvcnFCi0IBlMqRiZ8hCRLLANRY//B4cgb0xzIe9O1EQ899e0/IhZ2yRxa9QlnmDpJTnJTLlVjqSdL9hnFF3NLW5xmK1B1QvreTjpWlyve96fPRuW9+P+7zVv2EGAafMZ3VwEF5FeYQFvfycbAchk8OJeisZbc8DthEQw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686811; c=relaxed/simple;
	bh=0MzegEQa6mNO2V3I1Z6SLe0wht+O4Co94Tkz7tlZ2NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1y76ZhMipeJtW1uzurPzls9W9yJfzPgSdUANrDe5b94L42uteLlhAFjN0gjZN4o8jcuUVXjoXuGes6dAN1u6JwT5iVkDsRu1dkGRnj50X55l4fNl57WZGejm8Uk3QuvEbRAOwSnVKE55Y/LEhGtbgYnNruECdC50yYPoI8Y1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aQ4Cvp/Y; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aQ4Cvp/Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/Vsk6nSS0BOaYjUJQEKvY7BmM0q9+NfGVkftVEcz+BE=; b=aQ4Cvp/YxlgHKNRQHETVoEJvhL
	BMOkYClOlNIXJJRjlJ/F694viN0dxD3UgGvcP/rUjQjRRAGEFx7f6WEJFClSwHGZQWr3tB64zZSIi
	+3wpLPwhupyY+By42bkZlqEmH21ZW6Q6G0kbyhMIFWEVCcBmHMpPw5VEVQfC9IAx6CcyGz2iNDcBz
	pWW63czKtD8eGFLVdo+q3o7QTEMfxBvt8K/awG7Ng+fNmLcFVHFfWAprYZLSe44nmIMShQFgUAbXD
	0RoOaTSddktyYl+t6txa+T3AMLC2fKhJGWLK5ZSD5EKdiL804qR3JnM0EDBOWKu41PQO66J9dvmUt
	mAjMaP4Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNBgu-003GUf-0L;
	Wed, 13 May 2026 15:40:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 08:39:35 -0700
Subject: [PATCH v7 4/6] mm/memory-failure: short-circuit PG_reserved before
 get_hwpoison_page()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-ecc_panic-v7-4-be2e578e61da@debian.org>
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
 kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=leitao@debian.org;
 h=from:subject:message-id; bh=0MzegEQa6mNO2V3I1Z6SLe0wht+O4Co94Tkz7tlZ2NE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBJs7KSP0K2Cs2gg9fb0ISbMpl7DyiUxMygPBA
 KXOdR++hVmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagSbOwAKCRA1o5Of/Hh3
 bc9DD/4nNbluygUYNKOBrciOIa+JY5x3LkUt0UJqRQmgFYINakvCeFSRKWudJYoU8Zj2LDinbwL
 CIDqZeXUALFdVp7mQ9RJyXFKw02qJK2xZM2ZHLvUkoapQwDs2tcY39eXOUgkYSlo5a5S7t5MrQI
 pbSmGUTZLICxbUc0tMXa4Jp+XPL6shtQ8cNJTZLtH57HZ7p/mrJHXCiFem3GB6KcvYxCGDESgxM
 Socfz7gkdIavesqzPQGxaYcPSllviC1KznNMf/yTK6BsKqFES1SN9riGEtwEvLrjnfi3kHcZvvp
 l/5p+ZahKyv6Hp2KoQsmEggQTcHSzDLQlOHvk2W+RkST7IUND1kgaCsbOjAZcblJsT9aoc5VYaK
 HXMwfaQrDTXYc8uxKpU94CteM5W3jD1dWG8fUIb4NNSX3m+q35IpAcy6V2KDef+aoJgk9nXCQjU
 rkWvD9Ls9D9soYjUJKDI08lhzIJQxegyZpysuHli9Whygy5mOfUFGMNMiPNF+Kejry7c68XtvQz
 31fpDl2XC65FlyUA/lWBc8hhyX8T3SzlbgImHhRd3n5yTj+XsiX4uvb6yQaLbEiEr/BX4tttEDx
 I3rHgjFk6P7FskMuBEaNMof/si/JbrmpAG9Jt6BaxgMvEui3KCUpsVAc2N2IIqAECL7Ixo6wOMl
 hsX4XCagr7RsqNg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The previous patch already classifies PG_reserved pages as
MF_MSG_KERNEL through the long path: get_hwpoison_page() calls
__get_hwpoison_page() which fails HWPoisonHandlable(), get_any_page()
exhausts its shake_page() retry budget, and the resulting
-ENOTRECOVERABLE is mapped to MF_MSG_KERNEL by the switch.  The
outcome is correct but the work in between is wasted: shake_page()
cannot turn a reserved page into a handlable one.

Detect PG_reserved up front in memory_failure() and report
MF_MSG_KERNEL directly.  put_ref_page() releases the caller's
reference when MF_COUNT_INCREASED is set, which is important on the
MADV_HWPOISON path where get_user_pages_fast() holds a reference
across the call.

Suggested-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/memory-failure.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4b3a5d4190a07..8ba3df21d1270 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2398,6 +2398,19 @@ int memory_failure(unsigned long pfn, int flags)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * PG_reserved pages are kernel-owned (memblock reservations,
+	 * driver reservations, ...) and cannot be recovered.  Skip the
+	 * get_hwpoison_page() lifecycle dance and report MF_MSG_KERNEL
+	 * straight away; HWPoisonHandlable() would just keep rejecting
+	 * the page through the retry budget anyway.
+	 */
+	if (PageReserved(p)) {
+		put_ref_page(pfn, flags);
+		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
+		goto unlock_mutex;
+	}
+
 	/*
 	 * We need/can do nothing about count=0 pages.
 	 * 1) it's a free page, and therefore in safe hand:

-- 
2.53.0-Meta

