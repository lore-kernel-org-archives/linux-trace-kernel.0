Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AA51F4629
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Apr 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668485; cv=none; b=pOrdxXIenShlES3QkwF0xNyBh0xaftPE/SZ8mkzdeufkUadgC18GLWk+SFoaq8+wiy7WRm2ekdQW5qTWp3h6zXe2/UZUYnhu35WAp0rlpjZeMNZ0imeBIWosuZtONls3D/f3DAFws6Ksi3hkAheM3QPOwQ3wPJZsj9BG6YF7gx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668485; c=relaxed/simple;
	bh=y9tkopVlYYrgq0L9k6gT+6SkhL2M4+erB+aHqUmSUCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoqpM9sLPf9kuv7BVp038U9svgDJV69WJlcF9ct8C1lvmJ/BCL+eJZBAwjSd1AjXq0f/WkVqso/P0TBjYumj1qxfrCRkm6rbGv0SI6vmozzuezNleHvgSjKQaAI3Qhd6BrNcWqLBlywB27tlAfptY0PBE/55dIwoVi1X+1exwQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUNINORH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUNINORH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744668482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcJZphRyHLZo+N8WDQs50obgYAPQYa0/jjuYLyo1WUI=;
	b=EUNINORHLfXolzR0Yxw8cZlERETLT/9HjzKGY4T6Z8++HopnSCYtbV5HlyaFrspbMf7MC5
	gOWEOAUD4O9YAwrgy3+2XAU+fllC+AQz18U2RU9WDJSwZXoeP1tpEigH7Kvs6B7/XdNzAB
	M0Ba73Khwz/eSyreOUPoUcFiH/Z2kks=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-UG3tPO-1Oq2w4uzgC6Xx-w-1; Mon,
 14 Apr 2025 18:07:59 -0400
X-MC-Unique: UG3tPO-1Oq2w4uzgC6Xx-w-1
X-Mimecast-MFC-AGG-ID: UG3tPO-1Oq2w4uzgC6Xx-w_1744668468
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23D5F1801A07;
	Mon, 14 Apr 2025 22:07:48 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.91])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1A701956094;
	Mon, 14 Apr 2025 22:07:40 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
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
	mhocko@suse.com
Subject: [PATCH v3 09/12] khugepaged: avoid unnecessary mTHP collapse attempts
Date: Mon, 14 Apr 2025 16:05:54 -0600
Message-ID: <20250414220557.35388-10-npache@redhat.com>
In-Reply-To: <20250414220557.35388-1-npache@redhat.com>
References: <20250414220557.35388-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

There are cases where, if an attempted collapse fails, all subsequent
orders are guaranteed to also fail. Avoid these collapse attempts by
bailing out early.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 mm/khugepaged.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 114056276003..86e4c5100181 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1366,6 +1366,23 @@ static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
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
2.48.1

