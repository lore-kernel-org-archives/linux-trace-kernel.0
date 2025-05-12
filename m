Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EB2951D7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053291; cv=none; b=Uoq+7hOZLoK8oDqnGCvRaNaaqwQYBnQ7gCv0q5aK2At96KrYXRbdxar4e/BMHyksat2PRrt6s6CM4qWH3e2HQn/IXS34P7J1rxrd3CHbLwrOoX0Sr5TZLjAhiiJ/gp2ywjSFoH8x5evL00ler9LH2Ilc0RnpywXIMVUvOsj2gD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053291; c=relaxed/simple;
	bh=3khWjqFjWFC9CiGQiESB8aVTX3LwH0n7i9MwUmwd6T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NjgzV/zPWOyGIHdHQeLC+LKclEspyT6oMuEcv+lAGmwtx4XLEjzbg9h4Dk62jDPRBF9uwbD7cvghnLGMkvhSvg8lkUtmjkNi7sJGFCfmpeGQn3EI5HbuPZfPUNgEiI5DP/SJCh1f9YU6/0c+Xj8MBmRBDnIT4z2iW2PM3eT/qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHO+2sU/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHO+2sU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLXTuxdzeoCOS7HE06BqHxnwP6g0cDhZW8Z+d4gkxmw=;
	b=DHO+2sU/t7SO7brZHEemrXNlXAL4g6R9b6gipgl5xMCiFZBWbYfYKSocFnQlNWuYiJ6/FO
	dG63K7ZakAmrfblWCHyyaqU/vFq0LCCwhe+22rCd3oAarcROsObnHWzRZKOZ0jdv0wdEO/
	6NyF4eH5vNKCznec9V9LhsSU94Q/PLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-NPaAociNMsigzzvCyhbFYw-1; Mon, 12 May 2025 08:34:48 -0400
X-MC-Unique: NPaAociNMsigzzvCyhbFYw-1
X-Mimecast-MFC-AGG-ID: NPaAociNMsigzzvCyhbFYw_1747053287
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so18443385e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053287; x=1747658087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLXTuxdzeoCOS7HE06BqHxnwP6g0cDhZW8Z+d4gkxmw=;
        b=ieQhAptAEGSxmTVIurmvM3jZSz3f2nkYDofsuFKg7+u+ixwq/xKRjmA2m45wOU82ss
         5YSB5IgM91zgq0nLVALqxQQIVj1pNWg563Vo0WP7xj+dA4HXjJOwP3YuHsy1lYKpaV+w
         tf3l6sIzXVnnRu8lDLFeBkfVB3tB+8gRUgu0R2zGA1vvkPZyelruPa/Um2NESgxE6ziP
         ZVIv/oSiOj5UoixSsz/N7vWeh40ZhEAjNx8dFg/8YWiY25Q327gy91Wo7IiYRKl8S1kQ
         kP4kQCQ1gZbLY8TrmtZmsecNxAKcWbSl6/T6Np+9zVr0L8k6Ug9GGETDir6+Q8VT8XDz
         hrag==
X-Forwarded-Encrypted: i=1; AJvYcCVoaioJEfB43rmcBzGcknyR6pqUDlbJqAQJuOdE+pNg6WkC/5Ya0H6Kbp5Kj0hiSA8vvmiWqidXvjak7Df+ijNcpU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IwWQ1SlhjUXhOjb/9ElPeAjgBlcHzTiieswIIMVWd1TPdMXC
	ZOwwM79cnvAOzp9wrauUPHvqT7nDRrYWdvsGedxBtxPI91Ex0SGdyBpMSGM3YQn0o0vCxbpcIzl
	O8vBo6wjFgzbvEvZaOHU0sqP3yFuWTkRSihPDnnh3Ue8XO88KxORt7DSh7Ll2708K9/iqVg==
X-Gm-Gg: ASbGncutN9mHIw0T8kXljTQvWqPuxsobJr6Cd9jA5rMf11YxL7Z7+7k9mvoVroamp7P
	TvG5r8m89XWJaxcwD9IqTnyX+R7ruckbVY57JDX1fRjSPtp1LRLIEx3w5CRgmxfulQXX1JEHf8K
	CkIqvXJt/0g3sjTbWiuXDiyrvwBxR52g/uithq6zTX0ZqKSSCz4oaJFDob13cfwE+0e1sywSpOW
	7IRS2MYA6VvBLDn/36OJKCS4Gia8LtFMWp518KR3+KV0mN/8a5kXTVXjYrgW/tP3yIQNA8XJ4hW
	jimhYxWn7T2mjPrqmdxD8beaeL+KEfmuQAdTWsaT62nyW3731dXarANDXSymjxVyrOKJeaaP
X-Received: by 2002:a5d:5f56:0:b0:39e:dce8:1c07 with SMTP id ffacd0b85a97d-3a1f64a43a5mr11025584f8f.46.1747053287233;
        Mon, 12 May 2025 05:34:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXC2JTlHqMNEkDQGwHpsMemWHOSr9CrtHgYnjEcClwN7Gy0FNgR8cW6E5jpqWqORj+so6DMQ==
X-Received: by 2002:a5d:5f56:0:b0:39e:dce8:1c07 with SMTP id ffacd0b85a97d-3a1f64a43a5mr11025549f8f.46.1747053286815;
        Mon, 12 May 2025 05:34:46 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f58ebd43sm12647639f8f.37.2025.05.12.05.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:46 -0700 (PDT)
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
Subject: [PATCH v2 08/11] x86/mm/pat: remove MEMTYPE_*_MATCH
Date: Mon, 12 May 2025 14:34:21 +0200
Message-ID: <20250512123424.637989-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 55Gq4zURIlBlETGqhalkF4iXbxsmJhPYJpDOnSFltAA_1747053287
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The "memramp() shrinking" scenario no longer applies, so let's remove
that now-unnecessary handling.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype_interval.c | 44 ++++--------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
index 645613d59942a..9d03f0dbc4715 100644
--- a/arch/x86/mm/pat/memtype_interval.c
+++ b/arch/x86/mm/pat/memtype_interval.c
@@ -49,26 +49,15 @@ INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
 
 static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
 
-enum {
-	MEMTYPE_EXACT_MATCH	= 0,
-	MEMTYPE_END_MATCH	= 1
-};
-
-static struct memtype *memtype_match(u64 start, u64 end, int match_type)
+static struct memtype *memtype_match(u64 start, u64 end)
 {
 	struct memtype *entry_match;
 
 	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
 
 	while (entry_match != NULL && entry_match->start < end) {
-		if ((match_type == MEMTYPE_EXACT_MATCH) &&
-		    (entry_match->start == start) && (entry_match->end == end))
-			return entry_match;
-
-		if ((match_type == MEMTYPE_END_MATCH) &&
-		    (entry_match->start < start) && (entry_match->end == end))
+		if (entry_match->start == start && entry_match->end == end)
 			return entry_match;
-
 		entry_match = interval_iter_next(entry_match, start, end-1);
 	}
 
@@ -132,32 +121,11 @@ struct memtype *memtype_erase(u64 start, u64 end)
 {
 	struct memtype *entry_old;
 
-	/*
-	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
-	 * a whole node for the munmap case.  If no such entry is found,
-	 * it then checks with END_MATCH, i.e. shrink the size of a node
-	 * from the end for the mremap case.
-	 */
-	entry_old = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
-	if (!entry_old) {
-		entry_old = memtype_match(start, end, MEMTYPE_END_MATCH);
-		if (!entry_old)
-			return ERR_PTR(-EINVAL);
-	}
-
-	if (entry_old->start == start) {
-		/* munmap: erase this node */
-		interval_remove(entry_old, &memtype_rbroot);
-	} else {
-		/* mremap: update the end value of this node */
-		interval_remove(entry_old, &memtype_rbroot);
-		entry_old->end = start;
-		interval_insert(entry_old, &memtype_rbroot);
-
-		return NULL;
-	}
+	entry_old = memtype_match(start, end);
+	if (!entry_old)
+		return ERR_PTR(-EINVAL);
 
+	interval_remove(entry_old, &memtype_rbroot);
 	return entry_old;
 }
 
-- 
2.49.0

