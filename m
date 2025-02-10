Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2024E4B6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216334; cv=none; b=PlfjMpg618obUy/jt30ZdfNEEaA5MzyqIDDKjLm1Pe/QMFvm57cH8Hr6/xgWX+PDEPXlui4gq6MpeNdJS1nKNtSJiHIM1l12DYZ9WOoc8x/NIpIURsVfyutiQcXK+uAjf6Ti9hcOeBaARU6CCIrgFFSegRh6ne/p0k7lA9vTMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216334; c=relaxed/simple;
	bh=cMJXMPJ9fLW/woS9dzf0yuP4P9GXVUKQkO8wkukVnbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=A5SgQms0B9SSrzfZrJnauTZyU1D9/BWXv1NtGaRQEZr6y10LeaRDQrA69qFUkL8ctiWG8lb+2Fyo44vuVtxa8McSYOkbI3a/NuBF6E5vXDB0sIbawrnNPfKYPDkXORUA21mkQmG+BlQt7T93LuTIxFwy3JHW5hyAwR+c+GRV5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nrelez0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nrelez0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTEWxPe8B8Wum8eXVDX5hUwjNBhNNdMWJNli9ItwISM=;
	b=Nrelez0Okav55ARJLkfm+qqrceoMnlR7IrL0XVbPou2/EbswXQLfATuakvOZhSx0VRfZRh
	61Wr6On1w9CqbWFhpEZdULEGO5HiRmKCbFAulzP7wCLkjOXCDPSLOmnD9s5Kg1RIYvrW3j
	brP2zX3puxzBFXtp96g+hIv4hRpxcz0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-_RYw7GRDNOKp8xzVisyYog-1; Mon, 10 Feb 2025 14:38:51 -0500
X-MC-Unique: _RYw7GRDNOKp8xzVisyYog-1
X-Mimecast-MFC-AGG-ID: _RYw7GRDNOKp8xzVisyYog
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43625ceae52so28220075e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216330; x=1739821130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTEWxPe8B8Wum8eXVDX5hUwjNBhNNdMWJNli9ItwISM=;
        b=FDl8cfnshHKZgmMXQdV0vUOkALJJejNfqXMWPqPnxx8pOIgKs6BJnnVq0FdVTPtZ/5
         M5+6PlrCaCi29K8ns+yPJz6L3s7+QzFQSXliQBNX+AwaRba3G1WpvP8gpCEU1cyy0IqO
         bVyEweXcLMobd1qHsFsjgXC3E70cWCIQE7kW09vEqGKpCIfD5iL8lgigeIX85Zy9rbqG
         qYw/TgpOCyPV9MLUW756ZPex64vRfsvmHVkbUOAJo03AEeujovp/XHU8w8/le6aitECP
         2+NUZ2LEXV31KqNj9npF+bnDOj6vyRo/nWQkbV86EdkYYj9FlFq9qYgBla4HECSYNum9
         cXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKVyVdkx8DQDfMbbnT8GrJeWJi8IOQiiZyEXGAxCeSFmdwsgNZHOsPmhrntErPLb76tX1C7e9xjj7rT38w0WQzwWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJs/xzMTLv+R7L1mAMdd6RkJ6C0eSyls6WjN8BTnEJT2QwQ/J
	PmSgfcu7ZXOTvGCTY6fWOXy/UsetDzpi7y/cHe0ZxSXD4cAlAKfK3mpY4xIiO/Ifz01div+uh9o
	830uCjEEmeOnfUdaGI4gWX5xrSvZ0Z2nnHY7ceU/mz4hlcz8iiCySsnvKLpAq9q6iHbxNRg==
X-Gm-Gg: ASbGncvc5qLSHdzRpq2A7nmgfIda6JUP5xxDnYdvpAn7sWd7421gKguRzLB3j/deuz7
	IbyM+UhIZXPSF0hJC2AsjEU1k7tRqX9/vapoK5nxSkgU/CutnpF4VMZd6SSCMXgkfQ947+KS7Xk
	Q8BGigwqTLzHB4wtlCOHwaDmE4aPL2r8ldUe4lTSFE9S+gqfEAA4DxNMkLYDHoVtjZp2o/NrKkI
	o+IiQ5dkwHDOqD+Cqznaua1Lp0j2HArI+L0/2PU2Gec+FywMkyQoWKZXQn+Uf1P/7Fcx3LzqU8t
	MsQZdxGR846tGY891q1OXS8NtZWp25dTOHR7KBuUIhyKusZjKckESmUNVkIZpgMiKQ==
X-Received: by 2002:a05:600c:4f89:b0:439:4bb0:aba0 with SMTP id 5b1f17b1804b1-4394bb0adb6mr17902675e9.8.1739216329957;
        Mon, 10 Feb 2025 11:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Un4mhmMUf8CyrAHOSxNb3M+hrifrlRxr2GMjHtCC/u6kqhVG2aMU260gZj/4uoW1cKICNg==
X-Received: by 2002:a05:600c:4f89:b0:439:4bb0:aba0 with SMTP id 5b1f17b1804b1-4394bb0adb6mr17902495e9.8.1739216329619;
        Mon, 10 Feb 2025 11:38:49 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43947bdc5c4sm26951255e9.23.2025.02.10.11.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:48 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	damon@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Xu <peterx@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 12/17] mm/rmap: handle device-exclusive entries correctly in page_vma_mkclean_one()
Date: Mon, 10 Feb 2025 20:37:54 +0100
Message-ID: <20250210193801.781278-13-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210193801.781278-1-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m1Db-5n8xGi7e2fYmcV3zCVnH-ZKN3IN7g22YQAT44I_1739216330
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

page_vma_mkclean_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not applicable
on that path, as we expect ZONE_DEVICE pages so far only in migration code
when it comes to the RMAP.

Note that we could currently only run into this case with
device-exclusive entries on THPs. We still adjust the mapcount on
conversion to device-exclusive; this makes the rmap walk
abort early for small folios, because we'll always have
!folio_mapped() with a single device-exclusive entry. We'll adjust the
mapcount logic once all page_vma_mapped_walk() users can properly
handle device-exclusive entries.

Fixes: b756a3b5e7ea ("mm: device exclusive memory access")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7c471c3ea64c4..7b737f0f68fb5 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1044,6 +1044,14 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 			pte_t *pte = pvmw->pte;
 			pte_t entry = ptep_get(pte);
 
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are clean and not writable from a
+			 * CPU perspective. The MMU notifier takes care of any
+			 * device aspects.
+			 */
+			if (!pte_present(entry))
+				continue;
 			if (!pte_dirty(entry) && !pte_write(entry))
 				continue;
 
-- 
2.48.1

