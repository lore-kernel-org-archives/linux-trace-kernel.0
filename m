Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB44238C3D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569068; cv=none; b=YqYBk+l3RYa5yXQQNtz5dFe9/Oz1Ohg9urmehagL2p+DfzpJKBQPj+370Se4GVp3HC6f2NMMfHwOJ93ZqhEPqIRdjMb3xMEkWbiN3K5CxucOmTSgdRP3vgwlewhAWccMM4UimjIVjon4pLr7YtIa7YzPj3U+6B+NvEroPbVKqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569068; c=relaxed/simple;
	bh=UTdvk4e9mPj5bjUj9xrQ9gt4nmgB758NPYuFXNV2/LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QLydMGv+ff6nkanJ3QmqjXieH7tAm4RHGrb7GAG5R6QmGBWjr7RJMMOSN9U5qdbehrMPleVWYNvxmbaHqIL008Y4Mu1HXsThpt6Xo34qXYaEWPlNU9kvnmQirEjPyLCnzw/xC7h4csoRYgGZxQi5PbhUYwNKpI/UBzm3pUlezTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjfP2hX8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjfP2hX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zl4AHm9mXbjqorzBNgFLxI0voD1/7+bTcOR/2Fa4AA=;
	b=IjfP2hX8BUjPBUsYA/CfvBpPf2pEg/bYNBPhGsUUUpebed+UYMchcafASaTHd0Pe1V4Rfg
	4GCQZk7605R10MIr7lqBpREk8/VWMkGvJAfH4hQowWE7Cv/o6nZpqOLDEnGV5F0Ry8qPAJ
	/chRNZYi+KpZrSWqj6Tz6SYvI7Kg27E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-0ZaL6JQQPDCLf-y3HhY8ZA-1; Fri, 25 Apr 2025 04:17:42 -0400
X-MC-Unique: 0ZaL6JQQPDCLf-y3HhY8ZA-1
X-Mimecast-MFC-AGG-ID: 0ZaL6JQQPDCLf-y3HhY8ZA_1745569061
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39d9243b1c2so667655f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569061; x=1746173861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zl4AHm9mXbjqorzBNgFLxI0voD1/7+bTcOR/2Fa4AA=;
        b=AGTze2LnzeEtHL7xx4yONrsD2DB6pZTnFMzczeK4KddmFEbi+Q8180ycxuwyms26Pe
         7jamiGE+Lyfdmtz0eAoazccoGJqU8X0IQwc4A2WoTU3AalG4MCA4sRU6uOrIaxNEG1Q9
         2sv6Ev38yPaSDiozCpmyYEbAYWI1h7g4l8m6ehOGwbkzh7VFx1/2jBDP2EZbYxJbAtF0
         uFgMCbII3SMvbl0KeHqNmogt2Saj1i5KF3SEl3lDaaRa/8R2gY2Sred00tVNnWQhxpux
         bAb5QQXPGHtx/QFvABeFTUpdfVROfl8biZNhY93IXaacwb4SXszYT1kyd4C81pqi1CPU
         eFPg==
X-Forwarded-Encrypted: i=1; AJvYcCUvLY3KPqvxIk0NHZmKerCb9btQ3igkS1EI7yn4MLofj1SedoQs3EB8TN6jhyNUxGs7mftnXfOyOXzHFibRuL0I8iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8imfq0cRMREwrkQrcQL0GS2Q4MEwIIOO4Jmv16fXV9RNQcXR
	9VOx+chY+r1P2brlGNp9ddgPyw8el6jEPd8acRyvvgj42NVCcSVw4DLadYcsgvZOF8ozB7LolE6
	Sb42DoRUzTrScjqr9veQFSVkGaLqFEMuPCrnybTipZPFGW3WGsaUSj0BZHmx/BVAqoCCQCA==
X-Gm-Gg: ASbGncvw2anEWuK+svIPPeoZW8Oz0ZScAG2iWbhBnKnbRAkViqPxZ31yhAaYsp/YntC
	LQ2wkMGTsp1jtUT9a4DC3jFX8GDaw5l6GbSXW0qKHszAWlYcJzIp95JEDkQFgcyUSm9n/B5IpS9
	hu2/8oT9sPNrGPdTz+zdzQzWtB6kBjN1/72bnFVhpSxiovMKjKnki3TqhWewG1BcoueXFJMxAdi
	EFHmbftl6jSueF/nO3td/4VN8Ip9dbVY+jUFcEw+lV2z17BNorMQO20fCiekaoCg4Emnr9a2yzA
	NSSU+K3uYS8UZTwrxH/7kHthuT2lMc9uBF3JOw6isr4wIXwxS9GDFPvAAbh4W9W+WED3eXw=
X-Received: by 2002:a05:6000:4028:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-3a074e0efd6mr859048f8f.1.1745569061449;
        Fri, 25 Apr 2025 01:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6cbIXolQS+v1W8kKfDd2qap93n7uHX4eGz19p8/zV2hhP2TLcyzd7t5uofpqhlq66/UdpGw==
X-Received: by 2002:a05:6000:4028:b0:391:2ab1:d4b8 with SMTP id ffacd0b85a97d-3a074e0efd6mr859013f8f.1.1745569061032;
        Fri, 25 Apr 2025 01:17:41 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cc4153sm1649210f8f.57.2025.04.25.01.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:40 -0700 (PDT)
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
Subject: [PATCH v1 10/11] drm/i915: track_pfn() -> "pfnmap tracking"
Date: Fri, 25 Apr 2025 10:17:14 +0200
Message-ID: <20250425081715.1341199-11-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: tRF1N90tVs1THVMYHQWcmoImAslMAaeIxbg-p2lfaL8_1745569061
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

track_pfn() does not exist, let's simply refer to it as "pfnmap
tracking".

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

