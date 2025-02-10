Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9182505A8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216342; cv=none; b=EQxdPWqoo1C3zKSoCcIWaIjC42oJpPmYQDuc8B95QhV/AmbfPmynqAXmiivHiiUWU/YzZTbWu9/DH7TGwxH8F4n30Zrd857lwGhcak/sZtOd59yy3pNXxLaVKH/LCrpSkIbOCf0BQB6VOiLx0XUNU/L7xhCEJNS6ycvwMJvWwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216342; c=relaxed/simple;
	bh=xdb/Bd8nabay5U0SQXbchR0hBzNIzuX4jtY3vE4Olv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=iHMudYlmvh/Hi79pnnaB9TvAxfZzNiIOKyPBOyQTvQyTUtxBejgMcYqgT/WqGJ9k8B+QBk7i1G+QNXNW4Cwh3mFY8xqBRM2Vqgw/3qZ92s2BS2lFgbFzKFpQYtw0ZLHS0CA74aIX2vR7jBF5cBFsHha9mmyCzK09baZCjg6gW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HENOEqYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HENOEqYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739216340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oE9Ja/aC61CHup4qeT96Odiagg40Q7TPEFXRUvHwXRo=;
	b=HENOEqYW23FVkl2qDgOt1R9Yb2YQsPWKLOM7RE3Lz48FdX4WK6IjmMjQ3pPwnpSTyXYDuf
	w7jBnPIHOaeceoQaNQSfuxT7dsFlYfyy3jzEx0zmDHeAk5kH6M+hYBFq0RurpIBcTjw23V
	EHg3DsgrXoTX+ZQ2e/tGel8oyacktDM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-9bPCQyu_NMyZHg0ZssKrWQ-1; Mon, 10 Feb 2025 14:38:59 -0500
X-MC-Unique: 9bPCQyu_NMyZHg0ZssKrWQ-1
X-Mimecast-MFC-AGG-ID: 9bPCQyu_NMyZHg0ZssKrWQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38dc709f938so1785941f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 11:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739216338; x=1739821138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE9Ja/aC61CHup4qeT96Odiagg40Q7TPEFXRUvHwXRo=;
        b=BQszKyd170cZYcJf83ZYziBJOXs0sd2eXykzsdRcPihNQSTXf3s70Vihjx3jk5Lbrh
         6WKbruh98OOtiV+X1J+zQK1Pm6NAk+MS2IKRvfOFsHQlQ/HgPft8CbjkSBXG2zWssKNV
         Xws+iEYKAF2DY2A/jml3+c1UlinPjx6XZAhKPytSsXnll5801xWKt/5nRj7erHomkQa+
         BP02fgaqIYxUYsmqvGhmAc4JunSzYld4UioTMTRAlAza+zn9GbEuHNvabocrTPtG4zUD
         SAI/DDnmLWtZEqywzX5k3XlPKn+bO5Byhq4hveIm1xhlZi8GFp5bzW5kDgL0NAj5vWy/
         GY4w==
X-Forwarded-Encrypted: i=1; AJvYcCV6eDn7OevGkGIoIjPqlzmf3uPPjAfCEznYtjgBKNojpYLbMxyrN+Z0CaV2bmk3QGPvNO3qP1PUjNoYXCUVgi757FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzubdRyYlkFvJ09bBGLgUcclIzBYViN5/wflvO5LGRHwm+lgwk9
	8V/jxZgqRJt+AuaAqwl0YP63QjKYMPPktO7SR7ggJWsKpOdJk1YxqIUFLubjlhLv66n3T9QxBkx
	4N2956DCI3WO3NLnTb3gPg3BtRka/uOYGZEBDEZhatJtQFD2OKgZGxvysPtSby041hJJQhQ==
X-Gm-Gg: ASbGncsQJNQcw9cBjrb+Z0RrsSVE0BEnRFr6RD/aZzK0dUwCw9vK9MxWqGR8OOC+3Z3
	8/XAJa5VoLhf/dvbNEcdiazOpfgN6PQxHvWYJnECPBMTL8bDOpt0/OfT46G7hUc7AhWXAhfy0CH
	ynAp7UHY4YqetXpIhIcthhPR66TFLXJNlJ89PVeUqiHeSsGtqrcnRMakoyXtd+/wExVkc1IxP8p
	nbvjcxpBLH7a5LfDmTsEz6BjrDCeYm8j1+XTsh55QLqkz0+YLZ9DCLZbLKvCfB3658i7610b67n
	JnpZzGhYEirTxzyZi/cW7q26roKiYY84iMZvxcQGv1H22R5hTvBU3OvRBGHYw3qK3A==
X-Received: by 2002:a05:6000:1887:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38de439b7e5mr512530f8f.5.1739216337879;
        Mon, 10 Feb 2025 11:38:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/uzgNmJSm7r4vj5m1RC+0Hk4d4M8qsuHzJI2p/6gaMOev6b/snbfbww+U3ctbsFbws8/HTA==
X-Received: by 2002:a05:6000:1887:b0:38b:f4e6:21aa with SMTP id ffacd0b85a97d-38de439b7e5mr512516f8f.5.1739216337518;
        Mon, 10 Feb 2025 11:38:57 -0800 (PST)
Received: from localhost (p200300cbc734b80012c465cd348aaee6.dip0.t-ipconnect.de. [2003:cb:c734:b800:12c4:65cd:348a:aee6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dcc9bd251sm9816921f8f.9.2025.02.10.11.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 11:38:56 -0800 (PST)
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
Subject: [PATCH v2 14/17] mm/damon: handle device-exclusive entries correctly in damon_folio_young_one()
Date: Mon, 10 Feb 2025 20:37:56 +0100
Message-ID: <20250210193801.781278-15-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YJUsLkHCGBoG1cNoqx75xO6AVxqxZ3j6POs9H-dnZV0_1739216338
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit b756a3b5e7ea ("mm: device exclusive memory access")
we can return with a device-exclusive entry from page_vma_mapped_walk().

damon_folio_young_one() is not prepared for that, so teach it about these
PFN swap PTEs. Note that device-private entries are so far not applicable
on that path, as we expect ZONE_DEVICE pages so far only in migration code
when it comes to the RMAP.

The impact is rather small: we'd be calling pte_young() on a
non-present PTE, which is not really defined to have semantic.

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
 mm/damon/paddr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0f9ae14f884dd..10d75f9ceeafb 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -92,12 +92,20 @@ static bool damon_folio_young_one(struct folio *folio,
 {
 	bool *accessed = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
+	pte_t pte;
 
 	*accessed = false;
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
-			*accessed = pte_young(ptep_get(pvmw.pte)) ||
+			pte = ptep_get(pvmw.pte);
+
+			/*
+			 * PFN swap PTEs, such as device-exclusive ones, that
+			 * actually map pages are "old" from a CPU perspective.
+			 * The MMU notifier takes care of any device aspects.
+			 */
+			*accessed = (pte_present(pte) && pte_young(pte)) ||
 				!folio_test_idle(folio) ||
 				mmu_notifier_test_young(vma->vm_mm, addr);
 		} else {
-- 
2.48.1

