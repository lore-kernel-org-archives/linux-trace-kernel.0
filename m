Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578825B1CE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279565; cv=none; b=C0jDoOzyPiJjc6u8t4N7f5lSboHJsp2eWfu/oE+BQ8pOBUJFz4NTgQX0PHuSZpTjsWzj0oEkOEK5Qk5kD0hZk+s7+G7eLmrSnhZCka4EocDzrNoJqlgR2v5T/mHYMcInIwZlvn5n0HnTWj1GccvahP06RUiU3JJKYsge7XNocxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279565; c=relaxed/simple;
	bh=WOupC6E4HpO8mX5nlK6W7ryVaOhAjAR0LIPnaWVxKwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfgsGT0ImbyLRgoTMoR4OAqbYAjYH9k5LoLsPclSgWzfai6sL1CnlA+MWq9JmpgK1/5Vn/UWAvmPIj3qyauB0vdj8dG047fc34diDS03GczW4KOAXo7sU+BDnoYDJokNfjZ/LqsPmcYwmoOJf7dEg2JpSiYDVp342YiSvh9Qalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AZjZ5s86; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZjZ5s86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747279563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahT4btz576S69wvUnfwsCRHjbpr8W2QT0Gxup0BuO2U=;
	b=AZjZ5s86zHp+UrLqjWKmgi6C77hguf2z8TpVibBTKoAMe33PqmayJHLUQCH93FJRDNUqzG
	2Pi5PCx0UvsM93H7bl0mO65MR9qwEu6ubixbQqugHZ17UGKy4lEqXacg0tDW0ZEvfPR/tA
	PH0iqJMKYlB3FCZns5pZs37NWUihYTA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-KOhIuteWMa2BBXwiIcLjhg-1; Wed,
 14 May 2025 23:25:59 -0400
X-MC-Unique: KOhIuteWMa2BBXwiIcLjhg-1
X-Mimecast-MFC-AGG-ID: KOhIuteWMa2BBXwiIcLjhg_1747279555
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB38619560B0;
	Thu, 15 May 2025 03:25:54 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C2ED18008F4;
	Thu, 15 May 2025 03:25:39 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	willy@infradead.org,
	peterx@redhat.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v7 12/12] Documentation: mm: update the admin guide for mTHP collapse
Date: Wed, 14 May 2025 21:22:26 -0600
Message-ID: <20250515032226.128900-13-npache@redhat.com>
In-Reply-To: <20250515032226.128900-1-npache@redhat.com>
References: <20250515032226.128900-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now that we can collapse to mTHPs lets update the admin guide to
reflect these changes and provide proper guidence on how to utilize it.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index dff8d5985f0f..5c63fe51b3ad 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -63,7 +63,7 @@ often.
 THP can be enabled system wide or restricted to certain tasks or even
 memory ranges inside task's address space. Unless THP is completely
 disabled, there is ``khugepaged`` daemon that scans memory and
-collapses sequences of basic pages into PMD-sized huge pages.
+collapses sequences of basic pages into huge pages.
 
 The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
 interface and using madvise(2) and prctl(2) system calls.
@@ -144,6 +144,18 @@ hugepage sizes have enabled="never". If enabling multiple hugepage
 sizes, the kernel will select the most appropriate enabled size for a
 given allocation.
 
+khugepaged uses max_ptes_none scaled to the order of the enabled mTHP size
+to determine collapses. When using mTHPs it's recommended to set
+max_ptes_none low-- ideally less than HPAGE_PMD_NR / 2 (255 on 4k page
+size). This will prevent undesired "creep" behavior that leads to
+continuously collapsing to a larger mTHP size; When we collapse, we are
+bringing in new non-zero pages that will, on a subsequent scan, cause the
+max_ptes_none check of the +1 order to always be satisfied. By limiting
+this to less than half the current order, we make sure we don't cause this
+feedback loop. max_ptes_shared and max_ptes_swap have no effect when
+collapsing to a mTHP, and mTHP collapse will fail on shared or swapped out
+pages.
+
 It's also possible to limit defrag efforts in the VM to generate
 anonymous hugepages in case they're not immediately free to madvise
 regions or to never try to defrag memory and simply fallback to regular
-- 
2.49.0

