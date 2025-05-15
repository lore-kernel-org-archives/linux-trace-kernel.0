Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3A91C3C1F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 May 2025 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279528; cv=none; b=srSaOTeByheYwGv+vFM7pJo0aF63c6+yL9w953FzfNNBH/yi780kSge3jPlUKnzHbI1ok33xM9kOdt243ilCXzJbEjTh4QIzQEpnAOyC+MzS+eq/Ip8uA4pC8478aJRn/VsqgDR5/w8hKfivtMNn40yaatU4wyWgjvXehLGZue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279528; c=relaxed/simple;
	bh=G+QcOqk5eQ2Mh+/IoSew/qatN5ZxlvOHmno9Jr3xu5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0ylKLvl4BP8WLdqhqCZIF2tRluWmfF18Wi+y2A2qEr6m6FC3ddnZUUf2U6TU57e3Wx7Bd2e0J0WCvHY04/QEWFBkerwrg6t0JEAAvSCmZAq1N+fNqP0XF3aharqKO3esOJM5JF1juQPaHvKskv0q4fuOpWKWWIGjB/SqHi0rnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/qVeGxj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/qVeGxj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747279525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsIdjyB9iz2XKbIQ5ACDKzPgfNIwiEtNslHlyIUHdNI=;
	b=B/qVeGxj+7Um+pPIsJ0Whic6MxKLe9qA4gbr2t+YutqZFJ/EzK70zpQfMVrOGT82dnviFL
	vgb8FByy0YhonuYUS/Mf1wcSZcDmn5cVy3BcCJjenno01b+Sh2J9DJrm3TZK8/Lb1Zpabv
	vS6kUWmXWxilLPQ82Xpa6HMqV8Qu/2k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-CeT42sd3MQyHetS6sP2rdA-1; Wed,
 14 May 2025 23:25:19 -0400
X-MC-Unique: CeT42sd3MQyHetS6sP2rdA-1
X-Mimecast-MFC-AGG-ID: CeT42sd3MQyHetS6sP2rdA_1747279508
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57D7D1956095;
	Thu, 15 May 2025 03:25:08 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99E2180087A;
	Thu, 15 May 2025 03:24:53 +0000 (UTC)
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
	rdunlap@infradead.org
Subject: [PATCH v7 09/12] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Wed, 14 May 2025 21:22:23 -0600
Message-ID: <20250515032226.128900-10-npache@redhat.com>
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

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5920d4715a11..517cf2b271d7 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1371,6 +1371,23 @@ static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
 				collapsed += (1 << order);
 				continue;
 			}
+			/*
+			 * Some ret values indicate all lower order will also
+			 * fail, dont trying to collapse smaller orders
+			 */
+			if (ret == SCAN_EXCEED_NONE_PTE ||
+				ret == SCAN_EXCEED_SWAP_PTE ||
+				ret == SCAN_EXCEED_SHARED_PTE ||
+				ret == SCAN_PTE_NON_PRESENT ||
+				ret == SCAN_PTE_UFFD_WP ||
+				ret == SCAN_ALLOC_HUGE_PAGE_FAIL ||
+				ret == SCAN_CGROUP_CHARGE_FAIL ||
+				ret == SCAN_COPY_MC ||
+				ret == SCAN_PAGE_LOCK ||
+				ret == SCAN_PAGE_COUNT)
+				goto next;
+			else
+				break;
 		}
 
 next:
-- 
2.49.0

