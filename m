Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F682356BA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569053; cv=none; b=AvPWyh7MTleLsGBTSZ6MUiyrZowbl9gffjbvNdJYoV4U7eaDuTKubwOI3xakLzcS8mo6PVcXagdISTupTKbjZPFNd7ES52/5ZuQzPeZRSUiAcFkIlHPyUOeFzG2A4ezPr/IBtfjCaxqBzCIHstDd02losEYfHdqp4HcXbkIT+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569053; c=relaxed/simple;
	bh=aaP6QqhYpZD4s+rCaOs9ONDddbsXPil+JXi88ox7lvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SOW9ueNOji7n3CmkzgqUmvMbigkiVJ0JeV/zQ04KO8vZ/t0VSmpzR30dbBVHzPVxrstfWt6j4SoGGZ3TgZeRzM9uytb7ka5JLjgJJNlwsFkZ4X2s2XoLxflzREHJ4uJfJZoi2d7d7d48+LtVNdK7Bv/is4cSZnxX3TXfutY+No8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7VO0FoX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7VO0FoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu4FlIS5Nl76bZjUZyw21YomTVSJoQk7KVvTvA60Mww=;
	b=c7VO0FoXPy57I2ZewzJdjkj4O+Jwmo5m81f6YaomEbdzHXfudnuaXnf5NAzs2jbxmvsB/Q
	UHKqHcQ06gMEzjnaRwJKkR8p0QstVSNMMwObrqagk6X7utHnUh2361BEgbcsNQjT9HHof6
	afQrjsQAdC+HuroMt0JC7Me17kCDvCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-KoAEBEvdO5CnaQ11qmQVuA-1; Fri, 25 Apr 2025 04:17:29 -0400
X-MC-Unique: KoAEBEvdO5CnaQ11qmQVuA-1
X-Mimecast-MFC-AGG-ID: KoAEBEvdO5CnaQ11qmQVuA_1745569048
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eed325461so9370315e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569048; x=1746173848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uu4FlIS5Nl76bZjUZyw21YomTVSJoQk7KVvTvA60Mww=;
        b=cCEP8MRwCE8c8+r01HSnCHWA1C6Qceg1jyCrvq9gWSkJoiUACn3Gg6Ps9y8BMQiynL
         WX07R6oNSQJ1hqGv4zv8/qgJH6IYByeYZ7lIcRxhzzToNLxGAnI3KBQt5/+AgB6pekGY
         7GTMj1OUV5TDM53xpOZjZxprr3K6YRNMxQBuzM8qXpBdt4xti6L46jAV7LgcX4lbfn3c
         Amv1NUuJbW0twz28+LnrXv9MLd9dEZKbOEenvn5OosRutyuHNbJY/gRlGXCQiTkbLkKe
         Zujod0cziegsgOkcBzz1zsm6/4aHAl4MX8kTh/nSYjNbxCdhY1lBgoo5Zg8FSvpWN8BS
         4swQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqnJBOYd5BoM5WiHUjYgX7xW+E4nlGxiNPxsUDYhLn3DhY8ev7JrLJdc36Sp26DFZXnaFpiioJY9UmvGdvsq2k97o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+hNGW1v5O2hXmOTfWdcSjpPTMFXHyjbkXgYVTaSg1ZMgRd5b
	10tzt2ypgKx1eWqS3yRaFktdDQACL48qni1K6JXgPCiYx4Fly3v9S17bXzw7ojD/2NiyjTtF8tl
	TaUp1G+6QXecxptYJv0ISXHU7TdOv9QZsxAW8EJPFZv5hsZwSyX3FoiTla2IEdeQxICLuWw==
X-Gm-Gg: ASbGncvX7EWUg4ThRNH2+SmB9E09JfgX/C8VSQxGWwHakeDoaLsUzW6W/eqpiX+d1+d
	1FJ69tQWqdaFd0Oi1qJCHATIwoqjka2tz0C8WOajanorNo2KLKw32v1kM+nUXX2ZL/81bk1YzJf
	p+wlOemkDzKFDqZxaQry0vv7yFQmbnWIxTmKDpK6Bh8RHA2hfG3iyCtTncdYQ+V2G+aavnqPD2e
	DgqReH6yJDwEqE3wn13VDTU9YxrSWnr5kKM52f4yXu66XI2sPEoDxWWbaefAUmZJSnXFMNMYu2N
	4I+KVXABsA4HgA6q4SN1/2qc7ZHZAer72rBrP7PI2BJtfMH1jc4ZDYwA5HnF7VmQhJnGPoQ=
X-Received: by 2002:a05:600c:1387:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-440a65d8120mr8181535e9.11.1745569048270;
        Fri, 25 Apr 2025 01:17:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6bx4rw9BX60sw1RHVhWJrGaS8iH8UMCeEA8nv3vLsrOwHOvFftOe6l4h5umdYWufDrsURA==
X-Received: by 2002:a05:600c:1387:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-440a65d8120mr8181055e9.11.1745569047938;
        Fri, 25 Apr 2025 01:17:27 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4409d2a1dc3sm47748735e9.13.2025.04.25.01.17.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:27 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 04/11] mm/memremap: convert to pfnmap_track() + pfnmap_untrack()
Date: Fri, 25 Apr 2025 10:17:08 +0200
Message-ID: <20250425081715.1341199-5-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081715.1341199-1-david@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QlCAkGfMocff5kVDpCJ9ySpj7WOk1PhRBb8V2uNlpu8_1745569048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's use the new, cleaner interface.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 2aebc1b192da9..c417c843e9b1f 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -130,7 +130,7 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 	}
 	mem_hotplug_done();
 
-	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
+	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));
 	pgmap_array_delete(range);
 }
 
@@ -211,8 +211,8 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (nid < 0)
 		nid = numa_mem_id();
 
-	error = track_pfn_remap(NULL, &params->pgprot, PHYS_PFN(range->start), 0,
-			range_len(range));
+	error = pfnmap_track(PHYS_PFN(range->start), range_len(range),
+			     &params->pgprot);
 	if (error)
 		goto err_pfn_remap;
 
@@ -277,7 +277,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (!is_private)
 		kasan_remove_zero_shadow(__va(range->start), range_len(range));
 err_kasan:
-	untrack_pfn(NULL, PHYS_PFN(range->start), range_len(range), true);
+	pfnmap_untrack(PHYS_PFN(range->start), range_len(range));
 err_pfn_remap:
 	pgmap_array_delete(range);
 	return error;
-- 
2.49.0

