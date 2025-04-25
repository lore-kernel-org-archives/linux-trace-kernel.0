Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37D22F16C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569046; cv=none; b=c2CGuSfuSa802ynh6AjuZobEZ67bs7DOAhWHlYL8osT4YVZuiXgaqmKbhCpVESWec2gZtZcxHusAiQCLUAb7e7E4lrsd7LEbfLmbBFLC4US1WXHKKVQlskR+sHFWd8WOiAqO39O73i/z4AAIXhpOVk31m1hbX3QkC2IouZpqF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569046; c=relaxed/simple;
	bh=tE85qPRV00GBentDFXC2Wy18HDakEU4Sf8RDpCTCZcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=vD1hzTnEYRdFf+t13R+wdTaKlXr2nom81J9U1aSujvzKuXkNtDvf480DqrSPX66VqGU2e49CzA9HmZhz03X6goyKptWEpxuOpyPhXBVTCKdvpQ5kM/o1rWnDyC0vftZLfEyTpmrNGV2omldmFvNZp+gI5fMjkgGVux3amHAIU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy2OKYeI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy2OKYeI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRatMFVJgZO6lv6AeD3PmgD6qQLhfd2cdxeF01R18V8=;
	b=dy2OKYeI1XjjVGk7YOrjyNGRDON1WocyseDH83XEDcJIIK0lXE88vTADmlW5eEyG2cN29j
	63i8soc1xmoMwt/8jZ9mIPbJcGqV3Ie9K3pVS8PcQhZMyOXXvcNTbs2AX0c6aVMNsSxuiU
	fhVLcBrRg8RpOU9V9C6F2KS0EXw3rjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-0MentUo_Nba4TIK3uGl8pQ-1; Fri, 25 Apr 2025 04:17:21 -0400
X-MC-Unique: 0MentUo_Nba4TIK3uGl8pQ-1
X-Mimecast-MFC-AGG-ID: 0MentUo_Nba4TIK3uGl8pQ_1745569041
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d01024089so13455815e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569041; x=1746173841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRatMFVJgZO6lv6AeD3PmgD6qQLhfd2cdxeF01R18V8=;
        b=MSHJRdWrTVGHqwY325HWIrk6eJmuKy3wjCsB34oHdntQJ4FlYhI+DcHY0jgRzjM40X
         ibx38yLp+KBvv9F7s16ybSZnYd+xeDEXuw1gE0+81zKvnZZjGOgikkyYKxsNoKS3A/Dp
         a2K2qe3Pns9NkMIAV3I8bAjlYlu9Mc9KC4khOU5K3hJfhDkfRAPV9mdFQWyvrpDNnsfd
         ljLtS5YvLozg3OvjiLLkArNSJdorQzliOp3ANkNNtaho3IfsoAOU74abNuYKOI4wxRsq
         qZGG/8F9XOGP1O6EMqWd8jxG6qbnC/BxFkmwy/ype4MEtNIjNUBmOW5MkUo/VCpEmfTI
         X7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWP9466Fk2UzQdYC34DB7LtSHsse6eew89Bl6TKeZr04rplkXsV7OWOE+hK4Bc/SrHVmu2EMwBeJfl2yofRlJAdJYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3pyBaVTDPQt+0ZSUVeh1vY9OSLM7CE8cBsvwTWlVhJkYgWPa
	Hx/eUNloeRIj6TnxjAg4azJeyRRdmHTF/7asTRAUEht2k84oF3IxKvToshm0IC/O2VeVjPx9eAd
	Sb78ZvSN46xEDA4q9coYsewnT5lj3N1Rgu2lI9/ErDg9ZlwHuhWZDl+qZ4dR9iC7uncBVYQ==
X-Gm-Gg: ASbGncu5oTEmaYxEQ1KLMjm/ctnBVYiG8ne6r289YmTEn3YC6HXGpH2Qr5nhwt9MbQU
	Ha3xqpPvfUb6RXP1mNdYb+RTuaWf3w/QHendFB4z0jkhbzLumZOXuJaOajEYPRwsG+M1YgJU+T8
	Dg/PPGfzxcAqf3IWfDpQf4LjZcoLUfE6894cSEQHfDLquEjXsfAJTkUplb3IpdvX/WQhhLw89hq
	Vr8vivcj0ebaZTvBhwnlwsRFa0V/k13ITTiKiE/kcu8BV4HVdDpHQG1/6jP/AE+502+ACeeos4Y
	BxvSTQGqjNoAl+dVve+4evd6Dg8XRIvJ6dkjtQu1BGRw1K3vyRqlhu9bvi362XlKYmh7iag=
X-Received: by 2002:a05:600c:a012:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-440a669d8f0mr10327245e9.21.1745569040776;
        Fri, 25 Apr 2025 01:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVinoHYuKj/8cUgxoKVvs8H4zVeT82NWUNjJq9UBXeWLT5FdTynwvFlGCuxwFT/AVFDXEE8Q==
X-Received: by 2002:a05:600c:a012:b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-440a669d8f0mr10326755e9.21.1745569040316;
        Fri, 25 Apr 2025 01:17:20 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cbedc4sm1583000f8f.47.2025.04.25.01.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:19 -0700 (PDT)
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
Subject: [PATCH v1 01/11] x86/mm/pat: factor out setting cachemode into pgprot_set_cachemode()
Date: Fri, 25 Apr 2025 10:17:05 +0200
Message-ID: <20250425081715.1341199-2-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: smXstoYSdNsBmOjon0axwCKjFSuAjDNZnEfsQbggSF8_1745569041
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's factor it out to make the code easier to grasp.

Use it also in pgprot_writecombine()/pgprot_writethrough() where
clearing the old cachemode might not be required, but given that we are
already doing a function call, no need to care about this
micro-optimization.

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

