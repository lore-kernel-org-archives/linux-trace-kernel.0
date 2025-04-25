Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D712356A4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569052; cv=none; b=m/1sX3qnzb+omUd8SfgrBe++L5xCZtyDkswZusbC5etkZkcNBjPuwX1hpBtRDzscwDJ5Uq/2kQZYBOccgumT0mQxEY7wa1ld2cu5txh3L6RpvM7AuW9iNKJV8bxTCW13G0Rnz7EYjEtGAaCIxRx4KSjj/Jj54ESFoAsdpcy9ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569052; c=relaxed/simple;
	bh=eykL+iUZBmhrQjrl63IlsUE+hE0bFmZCe3pannV5u/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Hs4lnm2p4AJ+6UxwOSMbHaBDT7CFmJxdN6NCo7BDyoFkn/sfazqakCRNFhsJ90ROgMPswGZnN2B1eoOIvxauqMGs92IAeKfgrjKlux9+fEmjI5VqdLryLTgyjxBofDkFSoz98Z4gz3HdELzaakZT04BaxxKBo4a09LXuc3sIu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gaTPr6u9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gaTPr6u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KCYBdpwfjCOhXvT2DzVINMJSRWNfDi2B6w/Q4Y3NEy8=;
	b=gaTPr6u93hTPOdilhUwA8IRG+rBHnk2WkHpg9FIUNk1KqK2eUClCrTzx8Lw+ugK0imrKbp
	qeeLQkkTKxL4lXPWlzwM9MpXbOED34GSEevSbbLZ9TNmowwII8pMl6clCPLAsXjRwc3j6K
	gLNKR3YwoJSaiKamPpfpgCJod78jXnA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-9nw9-ezSPWCKBSwYpaFGgQ-1; Fri, 25 Apr 2025 04:17:27 -0400
X-MC-Unique: 9nw9-ezSPWCKBSwYpaFGgQ-1
X-Mimecast-MFC-AGG-ID: 9nw9-ezSPWCKBSwYpaFGgQ_1745569046
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c2da64df9so989375f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569046; x=1746173846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCYBdpwfjCOhXvT2DzVINMJSRWNfDi2B6w/Q4Y3NEy8=;
        b=Gd5PxO01P7yIRQAkdwM9RtXR0K3TC4DJFgpQVBUMgtHWQ/Qz0MAmmYntw5VokUS2Pk
         VrNjU7s+RuALt5NG+obZ47C32Z3r8LEZ0bxmKFkxPUXdn3MPpr2E7KcDuDkaAjyD+vO9
         +JxqK30kZ8Qc/BeEJSz5Q4Iz/furXrVOYpQA7Xqh2AGo9KP5ry9oyEXqmMQ14VhMlhYe
         BLW3jF7HfweVmfWKMMQ9fNk7YjzbfpJeaKFrdIpmBOhckVyk+FQzS5ChJHdgTFDTKWpe
         JEKe7sBpmhayrMnSFIortmaN4b57eaU/0dKR5xC99pqlEPZYR0Gm70+N8AbbD4ScMrxG
         y6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsZ1/UFb0G07kf21RdiojuUWQoFCItE+ckpXCtdDaxofI3oQ7FYOW3WSPvSclgr6fAoavWG4nibRYVj1ZnGRxJDr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCmF371tmsHM73YL6e5/Csnf9C17OUYuLhQJeEMgZ8Jh3nlVL
	4ih7BUtB3ucScaaSu/y+lLcqzYp/869H3m+x2bDEeMwUBhqw2pf36AL9WasehTvPd2Kmb3DXd4n
	GW82debpx++selz/kVNfWRoSJHZa2iTd7KxocWk5kDYNRYMkLq8PubRkqQtcsTwu7gcIwag==
X-Gm-Gg: ASbGncv+9QLHOWSv4JVSQ8i2BOFxEEL5usGhFXkMoZK+8PK+o4PWS/0iue7NVw6T+6u
	Wy9uqEPub2JOPQr+i9Ecu9+k0kOvaTrke8Rc+sAtMr5d17WGwKD+Ehj2vD5MG6Si94qjb3J9RW+
	IpEJyoCC6AaY82UNKjcmyruYOybyqkkcytGz1cBpSp+lvPSyfhLpCI9PspcJYEyJ/48a1wHs3wh
	dv8vNR8mo1hG7x2kEp5Q6b7nPEFvmJq6fCm8Nyoh8azIu06Llf1ewCWXWXfpbhcssEKbG47KVtk
	rUcEZPP4T1JA0FFiR9jqJit73mg9MW0cgs5rvtXDrvqMMpjRxB2W1nnPBj6m2OcXRr0EWlE=
X-Received: by 2002:a05:6000:2903:b0:39e:cbc7:ad33 with SMTP id ffacd0b85a97d-3a074e1eb67mr881016f8f.21.1745569045875;
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrgRXf9wKgkj7MYbnIuzIHmMlVWh7AZlbAu3PZR/ooKrImfXiUSMtbZSGOay0ZI4PJDGOvtg==
X-Received: by 2002:a05:6000:2903:b0:39e:cbc7:ad33 with SMTP id ffacd0b85a97d-3a074e1eb67mr880983f8f.21.1745569045483;
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073c8ca72sm1597057f8f.4.2025.04.25.01.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:25 -0700 (PDT)
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
Subject: [PATCH v1 03/11] x86/mm/pat: introduce pfnmap_track() and pfnmap_untrack()
Date: Fri, 25 Apr 2025 10:17:07 +0200
Message-ID: <20250425081715.1341199-4-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: JtOceqf_K0UK1VSdh5PeXwuF707hRAPy7VnwOxQuGro_1745569046
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's provide variants of track_pfn_remap() and untrack_pfn() that won't
mess with VMAs, to replace the existing interface step-by-step.

Add some documentation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 14 ++++++++++++++
 include/linux/pgtable.h   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 193e33251b18f..c011d8dd8f441 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1068,6 +1068,20 @@ int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size, pgprot_t *prot
 	return 0;
 }
 
+int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot)
+{
+	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+
+	return reserve_pfn_range(paddr, size, prot, 0);
+}
+
+void pfnmap_untrack(unsigned long pfn, unsigned long size)
+{
+	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
+
+	free_pfn_range(paddr, size);
+}
+
 /*
  * untrack_pfn is called while unmapping a pfnmap for a region.
  * untrack can be called for a specific region indicated by pfn and size or
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 91aadfe2515a5..898a3ab195578 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1506,6 +1506,16 @@ static inline int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
 	return 0;
 }
 
+static inline int pfnmap_track(unsigned long pfn, unsigned long size,
+		pgprot_t *prot)
+{
+	return 0;
+}
+
+static inline void pfnmap_untrack(unsigned long pfn, unsigned long size)
+{
+}
+
 /*
  * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
  * tables copied during copy_page_range(). Will store the pfn to be
@@ -1570,6 +1580,29 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  */
 int pfnmap_sanitize_pgprot(unsigned long pfn, unsigned long size,
 		pgprot_t *prot);
+
+/**
+ * pfnmap_track - track a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range
+ * @prot: the pgprot to track
+ *
+ * Tracking a pfnmap range involves conditionally reserving a pfn range and
+ * sanitizing the pgprot -- see pfnmap_sanitize_pgprot().
+ *
+ * Returns 0 on success and -EINVAL on error.
+ */
+int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot);
+
+/**
+ * pfnmap_untrack - untrack a pfn range
+ * @pfn: the start of the pfn range
+ * @size: the size of the pfn range
+ *
+ * Untrack a pfn range previously tracked through pfnmap_track(), for example,
+ * un-doing any reservation.
+ */
+void pfnmap_untrack(unsigned long pfn, unsigned long size);
 extern int track_pfn_copy(struct vm_area_struct *dst_vma,
 		struct vm_area_struct *src_vma, unsigned long *pfn);
 extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
-- 
2.49.0

