Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8B29551B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053296; cv=none; b=RV+q6YUcCMtdUSwdekjTVUrPLg9OJ2agz04j5YEfQCC76DBxotJ44REh/k6+RSo4N4JVmvCwUT2+ZCZLO9lUmmyQYYzEls2R3zDhdwLoeLgeHU1mL7YWBuWClR+QUxzXaiI8ptayOwqmoXonfiaxNPQ3pCO0dVidy/gnvImp+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053296; c=relaxed/simple;
	bh=pVi4R8RYxTF7t8uftAo4cDXigtBNE8xhnByzL6xMI50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sk7dwFtOlLW8+nL9HMSSZYVgWrXC/UO5YG8VqtneEqCo17/7JNmsnUu+zVwQVsYP90PfQMmp5CY2olq+XDvV1UWTys5u+9kIQf6tNPBtfUMqQBW8v30sBBp1g1DuRmY4vQKptxM+2VxEQBCSQ2g6oZOqv0WKNT783zo4GgEV9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DF345QOS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DF345QOS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7NNc3thH4gIlgL655OdyQ8soQ2dq/lJKbobAXK9pSA=;
	b=DF345QOSoEutb12HvR7TPpr6rTE9fjeSupoD+MyGhHkliOtUCLLYZmuXu0rJKR9xO3/DjT
	jRVNj5xwWopfF0pOnhzQxGpJUL8yZxQ9uN/h+ZO83MzGIvvjiN8FBybvPO83bPxC7zFUAe
	AYSWlr7l2XyaKmUzPPADzK0bD2N9+Rk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-iPp1bWa3P0ShIU2V2TpzMg-1; Mon, 12 May 2025 08:34:52 -0400
X-MC-Unique: iPp1bWa3P0ShIU2V2TpzMg-1
X-Mimecast-MFC-AGG-ID: iPp1bWa3P0ShIU2V2TpzMg_1747053291
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442d472cf84so19760795e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053291; x=1747658091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7NNc3thH4gIlgL655OdyQ8soQ2dq/lJKbobAXK9pSA=;
        b=npR7l7iREtAv9h0Ij6FpjfNBoGGSqTVfhTSNp2r7UXmF4tk0/ggJeUu3WozJRskOda
         xTqBrwU+bTVN+2XUb/hXspwZrYLz2QZSjlB2ZkAl1gmr5aC0f+5chmB2E5Jmb6FocB7s
         m+DQrzOX+QdXvr8D/W03K+nYSf1K27ALVMxoJZZwjctY2yBOWnCNa6fIHYi1mQlLcOhI
         D44ccsTgF1y8l44NalFPlNucbMJaHXioXdWeuE0+u3M28TALe8hyIV2ydGKnFm/k7OZT
         hzU3N2ZG8R0DOt8Ya7Hu66YmimrfvZzSEWoeh7luGOgNB4nzzA6y+TZVUovZM9T1ovLo
         Vk3A==
X-Forwarded-Encrypted: i=1; AJvYcCUnpr3bVZhaWZTEpol45OKLXQRhWQWa0YxdxuuCm+TFw/KurvxtE7TFGcOq5N3FbkEcyQPlwEEfhKTt7TbWnEMnyMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcRW3laCaiTQXb3mYiSFPkwM0HDO7a6uyzTrJXAQRiUO2j5yj
	3JrmHZi9idzFfgDFxgkFQrCS9+IAYkNFa91b85E/7DjkN6RUq3vHsuXFP6H0LgzK1C1i+vT/qX+
	c6bswfl2AyIi8b13FSNppVq33aIpf6AN7SU4Sj5xy8UOhB/kyXcIJTQbjQZCxz7Qwj8lQEm86Zh
	iJneNf
X-Gm-Gg: ASbGncvX3Lh2YUXS8dGUuZ4BvYEeewls9VVuyNoTxjQX9Epk60XMRktS3PgPo1GIaCH
	UYLcELGnjCHoMTyrVq6O++yEpM39knC/I8YXzVa+NfB1ZOpzc5vSktsAdVj9fx36wW9tCfpNMUi
	/BE6RYzW8LgcZAtSsEAhjqANj7NGhijIPVNtVSQMPhfO5vNilRkXOLpGnOPmPlPc7rlq61ZSfiu
	/Z7jEFrW4Drh5YKTeeUrOgPfHJtj5+Mhm6o1e8p8N4270YgMGClEiIv3otf1O0VV8qfa/Ae3/hR
	mLakZl1Wa80Z4KrqBHu3eN/QXkd6WwiDC33P3smQlt8Z6aRN6EknOCDmFN5ueoN7Hvt7/0YV
X-Received: by 2002:a05:600c:6488:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442d6d6ace2mr126162095e9.19.1747053291117;
        Mon, 12 May 2025 05:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jxWWVElGWxNHl3crVYv65IUanKXS9MQimx+SU1bSVoqMYrPVegNxma7hfxGl7cXYCgZC+g==
X-Received: by 2002:a05:600c:6488:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442d6d6ace2mr126161635e9.19.1747053290770;
        Mon, 12 May 2025 05:34:50 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd3aeb79sm167091005e9.27.2025.05.12.05.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:50 -0700 (PDT)
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
	Peter Xu <peterx@redhat.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 10/11] drm/i915: track_pfn() -> "pfnmap tracking"
Date: Mon, 12 May 2025 14:34:23 +0200
Message-ID: <20250512123424.637989-11-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512123424.637989-1-david@redhat.com>
References: <20250512123424.637989-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HXhnqLDeSbUExoZ9hcd_4ERIW8dac_nx-PnlfwbKpUQ_1747053291
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

track_pfn() does not exist, let's simply refer to it as "pfnmap
tracking".

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/gpu/drm/i915/i915_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_mm.c b/drivers/gpu/drm/i915/i915_mm.c
index 76e2801619f09..c33bd3d830699 100644
--- a/drivers/gpu/drm/i915/i915_mm.c
+++ b/drivers/gpu/drm/i915/i915_mm.c
@@ -100,7 +100,7 @@ int remap_io_mapping(struct vm_area_struct *vma,
 
 	GEM_BUG_ON((vma->vm_flags & EXPECTED_FLAGS) != EXPECTED_FLAGS);
 
-	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
+	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
 	r.mm = vma->vm_mm;
 	r.pfn = pfn;
 	r.prot = __pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
@@ -140,7 +140,7 @@ int remap_io_sg(struct vm_area_struct *vma,
 	};
 	int err;
 
-	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
+	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
 	GEM_BUG_ON((vma->vm_flags & EXPECTED_FLAGS) != EXPECTED_FLAGS);
 
 	while (offset >= r.sgt.max >> PAGE_SHIFT) {
-- 
2.49.0

