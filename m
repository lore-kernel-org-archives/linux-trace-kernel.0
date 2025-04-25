Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130323909C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569069; cv=none; b=EhjarVNXx1LZssedt5gMtyPFO2NO6oV1TgAM6SxFQe39EqHsN0eVCXMlBMvi1nCC0uGOfwrf+OmdVdL1tm7zfoFganlWK60lcommWJu2WVs9W0MtAsCHlBW5zI5QICFMOaCPVF4GCZcA53fGTGkJ2c7EzU5gDUnD1a/Jun9NEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569069; c=relaxed/simple;
	bh=P7aLK3l8yeYUwMXGvA+hIFjujX8ye0jfjOGlf8dWspU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fV0xR0qJpfPC8hmxOz8Ds5LePEH5oqWeSLW5ViPmgWYFyLnxtddqP2OE+mrhudiQFhiXnTlTOmHwrBWIHqn9O24d5UHR5qOEZvsKqZh6eTfsOrFzvagcXWy1BLN9oBEYUYur4URztievtRpNgsxUz0Z/Z8BBzE1op1Ha7rgzS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RaPYGuoi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaPYGuoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6VKic5wKMEIAlcOpats+61qo+m5NRwuI82rD38neOc=;
	b=RaPYGuoilnrg0DH8gYai3gtNwaZrHvHjoRBR6S8/LzKWN6izZTxakVGzWnP0jBn52xt6pC
	X9/iUWzHfgRIlXRMbBKI+PE5uuhOB5GsTvCTJjQ5cx0VTaunyJ1aU/Sj3de1Tcm2aeI4Q+
	vWhHuOWEmEXXuYi2ThbGSmnUQXHoLp0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Cus3hmkOOAuSK_T6q2oCag-1; Fri, 25 Apr 2025 04:17:44 -0400
X-MC-Unique: Cus3hmkOOAuSK_T6q2oCag-1
X-Mimecast-MFC-AGG-ID: Cus3hmkOOAuSK_T6q2oCag_1745569063
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so14332295e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569063; x=1746173863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6VKic5wKMEIAlcOpats+61qo+m5NRwuI82rD38neOc=;
        b=iJZluTuLhpJdSjJte8VWru3KjUA/M30f4tyONl0RmODM7tNKJ0jTcGANVfoy9kHNS0
         ruY+nhygcumshmFPDdt/3la4knxckxpwuBb5yQezQ4499oKH7lHT/zWdemCn/UTn+/4e
         9Ffln81ox2kQglGzjLxlxsTHAW90Wti8+02jdn0WSPdWYZ5XxkYWmqY59iRVLYjByRGG
         es3NksDeAr4guC/aCWrLLUFIRJB24QvrkQeFSPnZUUvlfz7VEJ4nzkizuO6qLluTmCK/
         FYPMdgpclRRovIFQVZ7qYKTmuBcoJ2WQJKgd3T12gBlaLd+o8q252Hrn8GuebWhLce9f
         G4VA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0HitIvDvhZQAltJYDY3/YIvj2JzM5mp0i3wdbWCNdhVugyYgqMWtGzHQd/WLMZvX4pFkG/E8fy1EEz249h9EIVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQkRF3hMQ1HHH3ZCQqMjDMvSWzSeMJUh3NAT5sq1fNEUj14t5q
	TS/RSqzpfI4xfkWLRircdOhon9aYt9rWiS+tbkkLHaEpktAuH/dd2styXngxwUZD3lJuiivtRyR
	F8EPJaY25602cMgt+1DfnamzUKlzHY4ChfgJGxXrfIa82fdMM90/Gi3D9zlMYu27PDgOnhQ==
X-Gm-Gg: ASbGncuYI/VL95974tAk0e0gokHyQjNGjYV42+O6RXh/+k24e9ws20duHIT3BDTYW/n
	ERvpztIodM+HSU0SdMcIOpR5OygqAYbrSLLZZOkrNiZDJUAwDr7hdyE/N2AfAZSyNYneloeANoU
	Dka5ATw3xsJpg9mO1mNlT+4nnToIfNPbY4vHBIFOXn6N/HUKarAKB2b5FVtp9ZTk/wC7yYm2lJF
	cgW0CNKs9bWdviHFaT4WIPItA7FG44rozMKxEF6wkuNf9mg0MOm05TR+EIxa7ysiE86wWq3H1Dr
	51z1LpXyy2H4JO/0/FGDUl+39ZtpVVKxI+/G0XPyKlrW4qQ8TtNPm2v0SuaPvLtK4Ppcke8=
X-Received: by 2002:a05:600c:a418:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-440a66d91cbmr9335295e9.24.1745569063558;
        Fri, 25 Apr 2025 01:17:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBsLQHuNB03USKo+AemF2nPVLejdezBsqoRXAvjTmH+TtvceXr84oTyLSWQmeHt1CNvX3vA==
X-Received: by 2002:a05:600c:a418:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-440a66d91cbmr9334915e9.24.1745569063186;
        Fri, 25 Apr 2025 01:17:43 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073ca5467sm1591850f8f.28.2025.04.25.01.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:42 -0700 (PDT)
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
Subject: [PATCH v1 11/11] mm/io-mapping: track_pfn() -> "pfnmap tracking"
Date: Fri, 25 Apr 2025 10:17:15 +0200
Message-ID: <20250425081715.1341199-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: pS9mrWgayKKKnv26RlASqd8IdovYwWB1-SAy84tWRyw_1745569063
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

track_pfn() does not exist, let's simply refer to it as "pfnmap
tracking".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/io-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/io-mapping.c b/mm/io-mapping.c
index 01b3627999304..7266441ad0834 100644
--- a/mm/io-mapping.c
+++ b/mm/io-mapping.c
@@ -21,7 +21,7 @@ int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
 	if (WARN_ON_ONCE((vma->vm_flags & expected_flags) != expected_flags))
 		return -EINVAL;
 
-	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
+	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
 	return remap_pfn_range_notrack(vma, addr, pfn, size,
 		__pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
 			 (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK)));
-- 
2.49.0

