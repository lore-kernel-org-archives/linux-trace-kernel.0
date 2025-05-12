Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DB294A17
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053287; cv=none; b=mq68HeToL3/xUwTNMUP/geC5pG1w1KeINSYc599JwQMXKxfGjxFSeb5mV3fUiYe23bQ1XbZt13CRzyOW5DuuqXRMAxjQI8x4SAxfFjEx1scOFRyP3YZeQpl8yjBWvdrhdqaJiAeh47IoWMXB/9BhyvLY0LQWd6uYW3T64cP3rNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053287; c=relaxed/simple;
	bh=MUI/AxEhqRJImsU/nUpWQjiOz2C1jw4sB7/CH9k9y0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UOLxIKlqY6RLPhmffwAwSG1o47vqiNLUBowl5fFDDWyuG7tH3GlwiaabB17y6eVh1Vnp85H1tcryptpD0a18E6ZltbHLPjbEOin/X7s16b2aQe6wWDLeKllhsEu9xm2Etx2PQ7xEyhr4do7lynPWLTaOIY/A2jbIxJwGkTtz+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgKa0kFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgKa0kFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/UT1PJepYZyksnYsraxL/8N12b3Ge+B9agKxkMscSY=;
	b=GgKa0kFYOg+l9jLxluxnhRuTLZA3S+nicgO2wjSyOkt1ZR3C3R+ry4n0MMbLUZu6b0tAUE
	HgrkozKvj7OuiWHq0UB4rZ22IOWjTpuHvI1UOcq0Glv06EsKVzhDFk18B2VetC7LAp3nCJ
	e+8uS7KBOLySAD3Va3wqfSDBlyDcOtI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-zNrMI8kLN1mGLZAis5wKsg-1; Mon, 12 May 2025 08:34:43 -0400
X-MC-Unique: zNrMI8kLN1mGLZAis5wKsg-1
X-Mimecast-MFC-AGG-ID: zNrMI8kLN1mGLZAis5wKsg_1747053282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-442e0e6eb84so10348635e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053282; x=1747658082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/UT1PJepYZyksnYsraxL/8N12b3Ge+B9agKxkMscSY=;
        b=xDz8qGgOjI1BY/2Q8R2rtT04Q7aVNDVsC4UhLWlveC4Vk+N2exYrir4ZPVm+um4gg6
         ExGVQ8GlKiZzIIGIYyn6DKrsngUGnmiS2ZfBgq9eHKC7YXzLbL9ITbM3+4HWOuI/S1BD
         WP5XjQpe82uQinXSxBXP9I/00DTQh0hgie05WWAaZKCxNkXxdAHjdjxKM2FZGtREo3R2
         VF90JIcBFSYNjoA6/f49FaBfzkPDnCLngKahKADWwZZuU0rpaZP+hlRg+vKQobLIJ/fP
         CAV8E0tP1DrZyTg3JHCv0K+q4Z5+rWoy9Jg4U46GvmN7NQ27EQEOmC/J8KqFgNMkkbw5
         mzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWMMu6WFST30rbzqvNGfskm59ui8/dEYo4Id0n1ZMcOVrKMpN+w4uaO9J50UlGIrC5CuMrrIt579+EODbxiAHBeGXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywg0VlUNMDIyZAcdjIZOYelQeUxKZthxZ1EKs6Ft2LBVZ+vZNC
	5xCG3XO+9ugdx2KAZKBk9vZpZDJ7b9uPVJf2D3eftMXaD436xpUJZTLpvK2AmJTAIfu6U6IHsfz
	HnbFKwIkthTcYijdfHy5OzPEpxn4NsvRwCtQBomcRcO4W78q+Ce15hqVgqj1fWsHGtWe4UA==
X-Gm-Gg: ASbGnctNN03qJO6MauOB51+RLobEbk5GlIpmduzWqWAhrPKuI/1p1vdHNOA4DKPAgRL
	5stmfVXNvMzMq5f4sxF+PCx7F1qeK3xOw9YElt7GfgvGQuNHurdJVEg+vJDC6TJpfQdoToI20BA
	LNA8zwdTRxAIbXSuAf5Y2lTO/1gwEY2KvEaM7+6WXQIwq1DovR1dAc3NOCq+6rOk4A40capVz/J
	agjl3xGxVk7CsOWWAR6uI4LjRTRwgUTqHeo3Y6I3iq6o7YozoiIp5MSD5z9H9OsShbPoqGMao+u
	3nsxaNcM31kM0BD3qbaVuHxnIjer3172Pw9NfJG0K/uKTfOLDS0xwMiSNZ3UieAkS9/KYoUZ
X-Received: by 2002:a05:600c:5297:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-442d6d0a9dfmr115315365e9.3.1747053282331;
        Mon, 12 May 2025 05:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFywN6624bTf4LyaE2Qvs6JUb4DihepKIjEJxodQ9QeZ2Wkqkhy5X7PHmdPSSD8j6qE1uzKzw==
X-Received: by 2002:a05:600c:5297:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-442d6d0a9dfmr115314985e9.3.1747053281990;
        Mon, 12 May 2025 05:34:41 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442d773f794sm82894295e9.0.2025.05.12.05.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:41 -0700 (PDT)
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
Subject: [PATCH v2 06/11] mm: remove VM_PAT
Date: Mon, 12 May 2025 14:34:19 +0200
Message-ID: <20250512123424.637989-7-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ioAJ1py3gWy_7CaL0xXnN0TXEM5dQAs0IB20XXidlnI_1747053282
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unused, so let's remove it.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h             | 4 +---
 include/trace/events/mmflags.h | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 38e16c984b9a6..c4efa9b17655e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -357,9 +357,7 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
-#if defined(CONFIG_X86)
-# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
-#elif defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC64)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
 # define VM_GROWSUP	VM_ARCH_1
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 15aae955a10bf..aa441f593e9a6 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -172,9 +172,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	__def_pageflag_names						\
 	) : "none"
 
-#if defined(CONFIG_X86)
-#define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
-#elif defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC64)
 #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
 #elif defined(CONFIG_PARISC)
 #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
-- 
2.49.0

