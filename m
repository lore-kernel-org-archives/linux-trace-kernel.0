Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4D311C38
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 03:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076414; cv=none; b=hqr10wAUo5UCr7GYONguUKQrG7f2M0fl97gcoojjZNvQWx9jVOZk7isvQVYl0o9ow9y9npQi0oZEudelIBbg+vu7+lX2UUPhkcz9LbEKGFRFL2/smCBIy4BTn0fi4P8DasGd9qkDA84kG/SMZWxPUHjh1/PTuLphV2e1ZirEgsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076414; c=relaxed/simple;
	bh=O+UxDEKvPm0NaMkbhKh8skt8CNIA45l/AoWbByoFLJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UTLa8dQJLp+zSF90D8ABVh430kWNcWUz/Xfeg1J3Uu+Y47zDXPnLgvkmwhQj+NB8WVF3CzLvT2k9Nnj9zfc4/NkKR6PQRo6jA5ofqd7DUArnR3jTBuiGlXkd6mAPX55Qy740LFow+4f7e2c5LN1ZXCBeBcJ0NZUcyQ662gjY3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2AXLfNP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2AXLfNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772076412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRNhIj3khK8Eq5Pf2FybxlrtWBkMrkCw8A4IePI94rs=;
	b=J2AXLfNPPxEEHY6JxpKnFC2OufIyWy6Hhx4+iNmXTr/6HOBZPW4DefPpP23mF5Ck6Tvc3L
	lfMX/ELuypZOuJtVPN6tCX9izTOyoR9exOI9E0P+bWD3ekEyRGaVdFaLA4tlRo+JyEdRB7
	ojo/T5PczqyG8hqDvUBij3u2djD655g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-qH71VLJkPS2KROF-uc1C8w-1; Wed,
 25 Feb 2026 22:26:45 -0500
X-MC-Unique: qH71VLJkPS2KROF-uc1C8w-1
X-Mimecast-MFC-AGG-ID: qH71VLJkPS2KROF-uc1C8w_1772076404
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E231918005B7;
	Thu, 26 Feb 2026 03:26:43 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.173])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8105B19560B6;
	Thu, 26 Feb 2026 03:26:34 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	byungchul@sk.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jack@suse.cz,
	jackmanb@google.com,
	jannh@google.com,
	jglisse@google.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	npache@redhat.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	rakie.kim@sk.com,
	raquini@redhat.com,
	rdunlap@infradead.org,
	richard.weiyang@gmail.com,
	rientjes@google.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shivankg@amd.com,
	sunnanyong@huawei.com,
	surenb@google.com,
	thomas.hellstrom@linux.intel.com,
	tiwai@suse.de,
	usamaarif642@gmail.com,
	vbabka@suse.cz,
	vishal.moola@gmail.com,
	wangkefeng.wang@huawei.com,
	will@kernel.org,
	willy@infradead.org,
	yang@os.amperecomputing.com,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	zokeefe@google.com
Subject: [PATCH mm-unstable v15 11/13] mm/khugepaged: avoid unnecessary mTHP collapse attempts
Date: Wed, 25 Feb 2026 20:26:31 -0700
Message-ID: <20260226032631.234234-1-npache@redhat.com>
In-Reply-To: <20260226031741.230674-1-npache@redhat.com>
References: <20260226031741.230674-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: cS6s6IP0BEuMVulERBZJE1MaS63Di2fFlQI2gaVwjyM_1772076404
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1c3711ed4513..388d3f2537e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1492,9 +1492,42 @@ static int mthp_collapse(struct mm_struct *mm, unsigned long address,
 			ret = collapse_huge_page(mm, collapse_address, referenced,
 						 unmapped, cc, mmap_locked,
 						 order);
-			if (ret == SCAN_SUCCEED) {
+
+			switch (ret) {
+			/* Cases were we continue to next collapse candidate */
+			case SCAN_SUCCEED:
 				collapsed += nr_pte_entries;
+				fallthrough;
+			case SCAN_PTE_MAPPED_HUGEPAGE:
 				continue;
+			/* Cases were lower orders might still succeed */
+			case SCAN_LACK_REFERENCED_PAGE:
+			case SCAN_EXCEED_NONE_PTE:
+			case SCAN_EXCEED_SWAP_PTE:
+			case SCAN_EXCEED_SHARED_PTE:
+			case SCAN_PAGE_LOCK:
+			case SCAN_PAGE_COUNT:
+			case SCAN_PAGE_LRU:
+			case SCAN_PAGE_NULL:
+			case SCAN_DEL_PAGE_LRU:
+			case SCAN_PTE_NON_PRESENT:
+			case SCAN_PTE_UFFD_WP:
+			case SCAN_ALLOC_HUGE_PAGE_FAIL:
+				goto next_order;
+			/* Cases were no further collapse is possible */
+			case SCAN_CGROUP_CHARGE_FAIL:
+			case SCAN_COPY_MC:
+			case SCAN_ADDRESS_RANGE:
+			case SCAN_NO_PTE_TABLE:
+			case SCAN_ANY_PROCESS:
+			case SCAN_VMA_NULL:
+			case SCAN_VMA_CHECK:
+			case SCAN_SCAN_ABORT:
+			case SCAN_PAGE_ANON:
+			case SCAN_PMD_MAPPED:
+			case SCAN_FAIL:
+			default:
+				return collapsed;
 			}
 		}
 
-- 
2.53.0

