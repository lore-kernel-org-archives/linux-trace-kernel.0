Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761F293724
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053276; cv=none; b=P6eAS9Pw5szx8inj2lwEm9ow5ezjXtSlAn0YmB2WaZR7VJiQN4uQJs2yJ0nGaqpdOk+eXHric+R3N+6uKJrSztSq5IrsbKrrJz7rQmNJ0s1yH8XbSXvNCo3KHSAwjpzU4ysKtglph6bdo0qW9NDZac/nVr2BH/x8h1CSfJHeMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053276; c=relaxed/simple;
	bh=8iSz8jBeX1KZuRVVHaPIDDcwWFktOFemhE20zzNrMbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=P2iSbepn9Q5DI8iaNs4PYv9WOw+5YLjobzw/b+0MoXOt8QMiEmWF5+0fxRM8+rSkBkdZQAWEY5oho2JzFy4WyNy5bzNxASmFG80TA+bEx7vdnwBDrxje1YrcV2JL6fA7Ot521EwoGJ2qU/F3MzPYPld6aJIqvIQBWcGENs4yP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJq+mvy0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJq+mvy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrbmXyUL7HXGUWgagRU2heQ2lgkOZ/iJWMnvv1t5buw=;
	b=ZJq+mvy0ZvefcuZmdyp5+Ui0gRr8WkpSKT50kAy38LViqzN3J1US0nIMFE5yBf7hXilS4C
	s3VP5/PK1/KEG8VtUALrm0QeJ0/fERZUzq8AQ+Pt4p8U1q4TMnjy1J1G4ni+vcMPl+6PPF
	o7O0p2Frt0qt61wBdyzUV8POw72MAJE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-bJQyPanqN3iHawNi5Cj4Sw-1; Mon, 12 May 2025 08:34:30 -0400
X-MC-Unique: bJQyPanqN3iHawNi5Cj4Sw-1
X-Mimecast-MFC-AGG-ID: bJQyPanqN3iHawNi5Cj4Sw_1747053269
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so24844735e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053269; x=1747658069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrbmXyUL7HXGUWgagRU2heQ2lgkOZ/iJWMnvv1t5buw=;
        b=Zz9Wn0a0R5sOLCbmEM/6wS0a1lwk7G+94cvgZqoOEC+vXCva6zm1vnZ9XWsjKMgNd4
         K0+tGKw2FuNZTpWZDu6o3bt/DVXjFua0WDbx4WfpYz/T4g8vn3dOH0Ng0bc/VI19hSoS
         43S+akTtFXCG08T2ZaFKjRZ4PeARBhr9tx5x0l9kBSjd8kNUPKx1TEyFiPjpZUXwRwFE
         AFttBzM88klBSpzjoHVY7YAGlbrnmVQVDmiH28j7xgVC7Ia2fzBAfXxFydPSuwvSUqOg
         zeStjsnfzZ6pgLBhUm4Rdwzd0z7HyAgPasWJETI65d7h63/lMa30wZ9q5uPXPWEUpQX+
         961w==
X-Forwarded-Encrypted: i=1; AJvYcCV8NNeePjOAGxvF/1GxYAyWT2F8DdPsNXiSvS0UZUTOZrocCrlxQeb18Hwfhc8w08RI68H8oGjElAeHQUmjD8fSEto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVNNB5gE3JQ6DYhI9r5137hHeP0j8EpSTiOnIVGIooMqp0l6aF
	8eXq7zuaPTdHaCfdfEhj0THw2hfOIXSVO9K+Dk6l9Mputcw9wDqWhnhp81Gg4WmbG3/0gu9AVl8
	A5Z8Ewjs5ZzM+3OJFeVjRSMdoNVXvXN2zyL4K1Gxg7A5nbSIiGHD+PfZauTe6CXR6ld/3Dw==
X-Gm-Gg: ASbGncvKV0br4DGp4k+Bfj+/V9CtodgPpU9NOSrSztRTKRAOvBNG2j6GkOXPXFgauLi
	YXRD6NjXwnzYDEA5GdOYRWsAlositoofMYmK1GGc4qqZ2cyrx7MuIfsvBvqT3CUqMmYb6+7TZ3y
	BkGMezZkRZuAVV2elqiwy0Tf8YTSDqZDV+vnMAbW3I9G/J+YmjnA+L7U5Xfl1F/tDWtyo/5t/1V
	pqrP/ERGc6aQROlEM5uOIii380jZR24Q3U8XibK31sTkFIn+5+77WrqDk12vyGeODfShhP8h3EJ
	yThEBwxqbJvIK2HNibA4vHSrHszljCjNyuH1Ymb0Uy8fhxBU4DHvHciVYoq0CU994oKRlMNQ
X-Received: by 2002:a05:600c:444c:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-442d6d3dcc8mr126249895e9.10.1747053269214;
        Mon, 12 May 2025 05:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7YFyagUZ9y+fevUV3BzP4ffMO+2lnku0MMlhrkvHNYDdbfZ5KLiwSKLyxUHWcSulKlrGmcw==
X-Received: by 2002:a05:600c:444c:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-442d6d3dcc8mr126249585e9.10.1747053268821;
        Mon, 12 May 2025 05:34:28 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442d687adc0sm123327975e9.35.2025.05.12.05.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:28 -0700 (PDT)
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
Subject: [PATCH v2 01/11] x86/mm/pat: factor out setting cachemode into pgprot_set_cachemode()
Date: Mon, 12 May 2025 14:34:14 +0200
Message-ID: <20250512123424.637989-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: MM-GyR5BLsw8jmnrsgOBNQu2iV-_GaIDLogRyo6Fyyc_1747053269
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out to make the code easier to grasp. Drop one comment
where it is now rather obvious what is happening.

Use it also in pgprot_writecombine()/pgprot_writethrough() where
clearing the old cachemode might not be required, but given that we are
already doing a function call, no need to care about this
micro-optimization.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 72d8cbc611583..edec5859651d6 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -800,6 +800,12 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 }
 #endif /* CONFIG_STRICT_DEVMEM */
 
+static inline void pgprot_set_cachemode(pgprot_t *prot, enum page_cache_mode pcm)
+{
+	*prot = __pgprot((pgprot_val(*prot) & ~_PAGE_CACHE_MASK) |
+			 cachemode2protval(pcm));
+}
+
 int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 				unsigned long size, pgprot_t *vma_prot)
 {
@@ -811,8 +817,7 @@ int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 	if (file->f_flags & O_DSYNC)
 		pcm = _PAGE_CACHE_MODE_UC_MINUS;
 
-	*vma_prot = __pgprot((pgprot_val(*vma_prot) & ~_PAGE_CACHE_MASK) |
-			     cachemode2protval(pcm));
+	pgprot_set_cachemode(vma_prot, pcm);
 	return 1;
 }
 
@@ -880,9 +885,7 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 				(unsigned long long)paddr,
 				(unsigned long long)(paddr + size - 1),
 				cattr_name(pcm));
-			*vma_prot = __pgprot((pgprot_val(*vma_prot) &
-					     (~_PAGE_CACHE_MASK)) |
-					     cachemode2protval(pcm));
+			pgprot_set_cachemode(vma_prot, pcm);
 		}
 		return 0;
 	}
@@ -907,9 +910,7 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 		 * We allow returning different type than the one requested in
 		 * non strict case.
 		 */
-		*vma_prot = __pgprot((pgprot_val(*vma_prot) &
-				      (~_PAGE_CACHE_MASK)) |
-				     cachemode2protval(pcm));
+		pgprot_set_cachemode(vma_prot, pcm);
 	}
 
 	if (memtype_kernel_map_sync(paddr, size, pcm) < 0) {
@@ -1060,9 +1061,7 @@ int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
 			return -EINVAL;
 	}
 
-	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
-			 cachemode2protval(pcm));
-
+	pgprot_set_cachemode(prot, pcm);
 	return 0;
 }
 
@@ -1073,10 +1072,8 @@ void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot, pfn_t pfn)
 	if (!pat_enabled())
 		return;
 
-	/* Set prot based on lookup */
 	pcm = lookup_memtype(pfn_t_to_phys(pfn));
-	*prot = __pgprot((pgprot_val(*prot) & (~_PAGE_CACHE_MASK)) |
-			 cachemode2protval(pcm));
+	pgprot_set_cachemode(prot, pcm);
 }
 
 /*
@@ -1115,15 +1112,15 @@ void untrack_pfn_clear(struct vm_area_struct *vma)
 
 pgprot_t pgprot_writecombine(pgprot_t prot)
 {
-	return __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WC));
+	pgprot_set_cachemode(&prot, _PAGE_CACHE_MODE_WC);
+	return prot;
 }
 EXPORT_SYMBOL_GPL(pgprot_writecombine);
 
 pgprot_t pgprot_writethrough(pgprot_t prot)
 {
-	return __pgprot(pgprot_val(prot) |
-				cachemode2protval(_PAGE_CACHE_MODE_WT));
+	pgprot_set_cachemode(&prot, _PAGE_CACHE_MODE_WT);
+	return prot;
 }
 EXPORT_SYMBOL_GPL(pgprot_writethrough);
 
-- 
2.49.0

