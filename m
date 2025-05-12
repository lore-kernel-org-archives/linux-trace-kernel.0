Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D7A29551B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053294; cv=none; b=BQULZMoufizuD5EpX8YNx0VOQ1k94e5YlzLaBEKjsYu9hbOuBu67IqZSUIRkkAxLx0p3QNPV4NVBARk/LujWH26ADChxalA6OSeSI1EE6QqeAEYnU9wzwC8L1CSBkIuCd9LxJo732BrnnZQFVKCOVFweCTstt3XLNLH9/Q6xW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053294; c=relaxed/simple;
	bh=SqVDOXGgAvnPE5z9oU92cnmrU7MjwVFUodqWnzatDc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DrPUDBX7N+H7h2jOjqAt2BEqbRo3/k67GaO/4PVuehAKNI5lOGLxJaaycDQl6A9ZzA01rlhipSA6zlA/LBruEol+JDPt92X6ygXUjB3Z9oFm0xyoyDrEsYxzpEnSG24BZI1pfG3sRvPZO3VnS3xwUgTrLzDEoGv0YMWYxF/SwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djUkDbye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djUkDbye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DrqxmiOL3McpG/dCHwH1I+FCiwsh4PlvLiMszfDdMo=;
	b=djUkDbyeDBBo9lu9zGXyjmFhhdvkytJChR+kZAG+dopSGwWeSEvt6Qu6lGmX8m7IQR67g3
	OEdAMF46zMfXJkyGfD2r6WePSQbC+8UHS0RcG1XfXSfKKMSx1XATtf9B4R0smVsLN+aSIy
	R077AtUrZIrekL5u/XQLluN26NLsPfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-8v53SjhxNEC_gO4k9XpzIQ-1; Mon, 12 May 2025 08:34:50 -0400
X-MC-Unique: 8v53SjhxNEC_gO4k9XpzIQ-1
X-Mimecast-MFC-AGG-ID: 8v53SjhxNEC_gO4k9XpzIQ_1747053289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a0b7124b5fso2810945f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053289; x=1747658089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DrqxmiOL3McpG/dCHwH1I+FCiwsh4PlvLiMszfDdMo=;
        b=mu/l9JXAhyl8YDiClei2b0tcholvMGBLmk6FZwMH/u8/4qTx6+jRnMV0cE/bg1UiBg
         cW/Jm1097RJ685/26FpzavAXYBykFQoosmSf3sKoZxS7nx0j27mpZ3pNo5p4MDT2kcZ3
         VGPJdXTXBWYVary3xXmWbeljd4LTOVQmOr/mC/7PVIw91Ac2A9IXUjmQX0tzxcJv0uUH
         4FyU4aOHXV7jABJS7fvzxuSDZWeK9OwAOHd0B9gc+6onoH9BKQTqwGONxv4MS/F6xC07
         LXkiX9Fn4ux7UwiDLhjnnCFx00oGRJD5DGf43pYes8DUsJ3LPQ/jRLm1P5phPbNb3xUJ
         pbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlrfPZ7bYcIcd7hikjuQdqZRvCvPolqrgZtFcQ6C4CePendpt14iVoWdToR9FjPQMRcTpuUjTR2/Cv2fDI8p4EbYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWDFOO47qmqS8tJHNPaWgegEaqdfRJySmEvEty6H3WxaSPa0m
	yh94ZDXnqUpAokjCRg9NC9DpN8HutZaS4axJd7sO7AaAhVnYcNAiYoMQsCCuLqi3xit6AMEDt0r
	8lMk0yBoDqXmbO6i8jLrEzZZaWffkPNL/SGFh1yMYasvKhD23kwPWbwSlljUfRyl9dexutA==
X-Gm-Gg: ASbGncvHqzLRuQwbaCoEG6+bFRLAYF5BtuKPF/LqM+hkiKoYxDHvphVWiWylfNCjgxG
	L9FW4AodaWxXLioxP/jj1FTeOL0BbXXyzvE/5Hvi2kOyjlWTxtV2l8QftBLjmOOb4BCSg5UmJ3M
	AmnawApO/zjDRr1NOSMkuCgfHFnizJ1EvuhKnRb7AxjtrWgwMyWZHt9Mf+r7aBn4WmYkhvJGin6
	oz5gYQl/kTD6FkNq8e1OYQs5ufk4EgkZ9waZlNyMoxkibcATSzjBucfjkfBJEfzO6TvqDS84XXI
	VLKFuZ2N+JYipk1bKGzCWhGvwZBFfZYi6gu9AOXiZe5VbkfqhHkYesSn9/45sgueZb/6KoKk
X-Received: by 2002:a05:6000:186e:b0:3a0:830d:ec58 with SMTP id ffacd0b85a97d-3a1f6446e78mr9882924f8f.28.1747053289260;
        Mon, 12 May 2025 05:34:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0s3h7inHrYSooQ8NhTVln7D4g+9j4TOqzMH9jwIQneuWGNhcfmrI3NwJv0snFOVP2u3wuBw==
X-Received: by 2002:a05:6000:186e:b0:3a0:830d:ec58 with SMTP id ffacd0b85a97d-3a1f6446e78mr9882884f8f.28.1747053288844;
        Mon, 12 May 2025 05:34:48 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a1f5a4c583sm12120673f8f.84.2025.05.12.05.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:48 -0700 (PDT)
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
Subject: [PATCH v2 09/11] x86/mm/pat: inline memtype_match() into memtype_erase()
Date: Mon, 12 May 2025 14:34:22 +0200
Message-ID: <20250512123424.637989-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6soBDq8cTFk3nGz--2s1NRkG6XWLXr8xTaiAn2GHABI_1747053289
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's just have it in a single function. The resulting function is
certainly small enough and readable.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype_interval.c | 33 +++++++++---------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/arch/x86/mm/pat/memtype_interval.c b/arch/x86/mm/pat/memtype_interval.c
index 9d03f0dbc4715..e5844ed1311ed 100644
--- a/arch/x86/mm/pat/memtype_interval.c
+++ b/arch/x86/mm/pat/memtype_interval.c
@@ -49,21 +49,6 @@ INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
 
 static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
 
-static struct memtype *memtype_match(u64 start, u64 end)
-{
-	struct memtype *entry_match;
-
-	entry_match = interval_iter_first(&memtype_rbroot, start, end-1);
-
-	while (entry_match != NULL && entry_match->start < end) {
-		if (entry_match->start == start && entry_match->end == end)
-			return entry_match;
-		entry_match = interval_iter_next(entry_match, start, end-1);
-	}
-
-	return NULL; /* Returns NULL if there is no match */
-}
-
 static int memtype_check_conflict(u64 start, u64 end,
 				  enum page_cache_mode reqtype,
 				  enum page_cache_mode *newtype)
@@ -119,14 +104,16 @@ int memtype_check_insert(struct memtype *entry_new, enum page_cache_mode *ret_ty
 
 struct memtype *memtype_erase(u64 start, u64 end)
 {
-	struct memtype *entry_old;
-
-	entry_old = memtype_match(start, end);
-	if (!entry_old)
-		return ERR_PTR(-EINVAL);
-
-	interval_remove(entry_old, &memtype_rbroot);
-	return entry_old;
+	struct memtype *entry = interval_iter_first(&memtype_rbroot, start, end - 1);
+
+	while (entry && entry->start < end) {
+		if (entry->start == start && entry->end == end) {
+			interval_remove(entry, &memtype_rbroot);
+			return entry;
+		}
+		entry = interval_iter_next(entry, start, end - 1);
+	}
+	return ERR_PTR(-EINVAL);
 }
 
 struct memtype *memtype_lookup(u64 addr)
-- 
2.49.0

