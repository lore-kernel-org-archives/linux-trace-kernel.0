Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44D2951D8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053292; cv=none; b=hiycFSdh4NB5MymLuD/EZDBQTaIR8XSNgZ9g4ESVQD6P3SzclXg2/ZliNC3EjwSDViDtj3sDkzYY58zR8mIAKft5J6hiEZykjO9n39trguuqKk0ThDr5X4ll7Ro4UpMraIOBuEkYPMrgCfMru5jonz5ONmx1Sn1rDI4USbbw3l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053292; c=relaxed/simple;
	bh=plUyq9xd8ySzP2AAXo2oJ8d2YD2N8nsTkRb0LYdC5Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=QexP043CbGrbtVli6MYsM81qcptDABJmOHjNon0Hml9gEEotPp3q+EMPCTvS4/wGBo+IbL/ESkL7uwcB0fezsQlzIzfZeKjSoj0wySt3CVC432HixpaycqznsacHntyeu8p5zWKtn+V28eCY3X6yOxwzgxmP0NaBwk2BmXTddJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AvIaIYRr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvIaIYRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=damHjxLzdKBqIDkI5LPVSGeFU6dth6KBhucvp/6hc2Y=;
	b=AvIaIYRrbYdrmc6pPx84yLGvXjJoZjSCN2aJac7AVu/e6NZmf8Me7yeNZKJrUE0QhAz7kX
	20Iy8ooDER4T1bBAnJ/o3X8BLD+QhbMHb8VbLE++ThDBQslk/0y8NgqTSw5Xv5zoTsxo/1
	tCxnws6Q94gkQbm6SOIlrnA9dZ0bD+E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-Wl3AHldZP3adEfs2CS2epw-1; Mon, 12 May 2025 08:34:46 -0400
X-MC-Unique: Wl3AHldZP3adEfs2CS2epw-1
X-Mimecast-MFC-AGG-ID: Wl3AHldZP3adEfs2CS2epw_1747053285
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b5d18cb7so1579019f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053285; x=1747658085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=damHjxLzdKBqIDkI5LPVSGeFU6dth6KBhucvp/6hc2Y=;
        b=JWWB15jQS3BoTaX9S+3+gL8y/WR9U5qO1qhYjTvKEG9rSjMa+w6AeJNe9z76zZS7ye
         IIgXvAI2wSBD69oqka7uqBSLva9wqdr2wDUFSiXu17ShCH4sAWqmd5G5FZvq+SmPmqYc
         C5ulkW0FF0h6oKmFyB9/fex4xhsQjSiVe7l+dxh8UJSahe8URu9UEhr8iEr/QQBawxaE
         NYA66hWL7n1p0xYJUNpzEHM+ecDX9hfJ7W/vgDAt7ty/fkTaMH5L5uUDcKUTEmbZv34+
         G6I9MZzYaxdWHV4KVoMH5vEVyj4cSpi97BYa8WmfUP6LHFW7L+YLWxUdHHHFw87y0eEi
         sQFw==
X-Forwarded-Encrypted: i=1; AJvYcCVDWp1hDzhn5Fhfcwjw4hlBPFc2CEhzFE+4vRWLZxRBYd4wWJn/L0OCzKOLMrj2BLXJU1p7nbbBBNoi27P6tCHxB4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtYstfzbFdSYmntoVBRnFn2GhHKrtf51On9W8XQwh6gP/GcJc
	iIZJGinlJKz/kdm0qvjTWU7gCUAwYVRUdfg2HFyWLr/Y+KrsgPV23IRzoLY5yZBZ/nKb0AiRKmb
	C0+xRhjZfNUdSsO4WN/zm1nzo4Q/DpZv/FUTkqkDbdOh6CSuqMZZdttEsiEpd2L5Bzg22FA==
X-Gm-Gg: ASbGnct3/u7J3gpLPNpFr2DK3z5YW2kpy3BJ4DOLalP5nnynPnIiYHwZdS835o1UVDG
	SeWyGn9aOOpih3/zZhhkd2diR1wpHRyzOhyE7Rpd5wCtDXQnnqt6G3WVrkCgdlagx/LdFYB5LCJ
	BWI5AFWe5jbprzrC4J6lvAktcVj3urFl1gi4lb76Das8JKWOtwPlUM10oimGDoMZgShLbWVCvk6
	vHa05hFyvZ7DcBzKpPVhWNKjz/LK7w8nTJJJhov9niwW/jFTyIKWZjoUMziUfRLPlwkgcmraCGY
	gHb/hZY/GqJ37DsIr3tn0rJEzONpdqYfwU704iT1BRjioKeZeA57CJnmPOkMQ/De+vqhUQ8m
X-Received: by 2002:a05:6000:2011:b0:3a0:b455:a1fd with SMTP id ffacd0b85a97d-3a1f643d7f2mr9690543f8f.32.1747053285135;
        Mon, 12 May 2025 05:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnmU3EtVrQ/jxHU8AUaqqw41jpYBGCmzwmgCEh+gCBZD+u2TEH9U2eBlpYNMTeAuFBo11Jgg==
X-Received: by 2002:a05:6000:2011:b0:3a0:b455:a1fd with SMTP id ffacd0b85a97d-3a1f643d7f2mr9690506f8f.32.1747053284744;
        Mon, 12 May 2025 05:34:44 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442cd32f238sm164887305e9.11.2025.05.12.05.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:44 -0700 (PDT)
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
Subject: [PATCH v2 07/11] x86/mm/pat: remove strict_prot parameter from reserve_pfn_range()
Date: Mon, 12 May 2025 14:34:20 +0200
Message-ID: <20250512123424.637989-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1yXo0tnNcD8XFFM_XWSFOqZmmdxNVUQ99h2WYyNVqKE_1747053285
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Always set to 0, so let's remove it.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index c88d1cbdc1de1..ccc55c00b4c8b 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -858,8 +858,7 @@ int memtype_kernel_map_sync(u64 base, unsigned long size,
  * Reserved non RAM regions only and after successful memtype_reserve,
  * this func also keeps identity mapping (if any) in sync with this new prot.
  */
-static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
-				int strict_prot)
+static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot)
 {
 	int is_ram = 0;
 	int ret;
@@ -895,8 +894,7 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 		return ret;
 
 	if (pcm != want_pcm) {
-		if (strict_prot ||
-		    !is_new_memtype_allowed(paddr, size, want_pcm, pcm)) {
+		if (!is_new_memtype_allowed(paddr, size, want_pcm, pcm)) {
 			memtype_free(paddr, paddr + size);
 			pr_err("x86/PAT: %s:%d map pfn expected mapping type %s for [mem %#010Lx-%#010Lx], got %s\n",
 			       current->comm, current->pid,
@@ -906,10 +904,6 @@ static int reserve_pfn_range(u64 paddr, unsigned long size, pgprot_t *vma_prot,
 			       cattr_name(pcm));
 			return -EINVAL;
 		}
-		/*
-		 * We allow returning different type than the one requested in
-		 * non strict case.
-		 */
 		pgprot_set_cachemode(vma_prot, pcm);
 	}
 
@@ -959,7 +953,7 @@ int pfnmap_track(unsigned long pfn, unsigned long size, pgprot_t *prot)
 {
 	const resource_size_t paddr = (resource_size_t)pfn << PAGE_SHIFT;
 
-	return reserve_pfn_range(paddr, size, prot, 0);
+	return reserve_pfn_range(paddr, size, prot);
 }
 
 void pfnmap_untrack(unsigned long pfn, unsigned long size)
-- 
2.49.0

