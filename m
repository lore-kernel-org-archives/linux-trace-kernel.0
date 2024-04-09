Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E79158871
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690753; cv=none; b=JWUN8bP4M1Q3weKF7g8EV98DZwUMVt7i0bSSAEaPUpg+e+Lw+cDYU751i6caasdB0uY+agbeqft2fs66BcErtBErH+EFpI/7CLXVv9//FvZ/qkahR4kfsbTXZu/qBOpJzYEpqSh3j+/f30cOd6jBElSI4pun1LH/TGkFkP4G/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690753; c=relaxed/simple;
	bh=Rq0Sd4YiurfGdBcBbt0nVkWNo0X3AhfDegChcctLqBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDaiiPxof4Sll8tDZ7Lwhr65Aa+BnUiKGWBpUaabakSV0hk6o4Fm9zeCq1ko0jsXvVGY4Hvhxvtl4jW6VBLM8S4656C0EV8X++ApUbqYClpelyyi5PMF+nVlh4akh6cbMjAYDpdbmmTOyWIUaKY5halvjN+bMrzbkebz1z2qS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUz3yLUq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUz3yLUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712690750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IN3zVkAYwXXWogoRwDYvxGTLC4K4Gwg+xwqZ7vjK29g=;
	b=eUz3yLUqc98OWjzB4TLOU6v3Ju1M1JIcKKpD+QBnc6vY4QRDNEw1dnUY5yiXNOjc0qtnOU
	DFSmE9pu4m2qsKr68s715ms4oRhbtc/ibLsE/zSlmhxydMbpxo8JtWqFvMcve6WDuYbu7A
	lv4ZIINxrTAlrNPRZ+V0OMUJP/1YuP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-p7aYNzngOOiEyTZuHcjUMg-1; Tue, 09 Apr 2024 15:25:44 -0400
X-MC-Unique: p7aYNzngOOiEyTZuHcjUMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0997830E7B;
	Tue,  9 Apr 2024 19:25:43 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.106])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD0CF419FA38;
	Tue,  9 Apr 2024 19:25:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yang Shi <shy828301@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Hugh Dickins <hughd@google.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Richard Chang <richardycc@google.com>
Subject: [PATCH v1 11/18] mm/migrate: use folio_likely_mapped_shared() in add_page_for_migration()
Date: Tue,  9 Apr 2024 21:22:54 +0200
Message-ID: <20240409192301.907377-12-david@redhat.com>
In-Reply-To: <20240409192301.907377-1-david@redhat.com>
References: <20240409192301.907377-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

We want to limit the use of page_mapcount() to the places where it is
absolutely necessary. In add_page_for_migration(), we actually want to
check if the folio is mapped shared, to reject such folios. So let's
use folio_likely_mapped_shared() instead.

For small folios, fully mapped THP, and hugetlb folios, there is no change.
For partially mapped, shared THP, we should now do a better job at
rejecting such folios.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 285072bca29c..d87ce32645d4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2140,7 +2140,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 		goto out_putfolio;
 
 	err = -EACCES;
-	if (page_mapcount(page) > 1 && !migrate_all)
+	if (folio_likely_mapped_shared(folio) && !migrate_all)
 		goto out_putfolio;
 
 	err = -EBUSY;
-- 
2.44.0

