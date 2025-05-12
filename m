Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9662957CD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053299; cv=none; b=GKAkCviMImIeOuxO/8Cl9Uz4yCROXsBk/X2CSauoX8uGDUHq9MxmyZGDM//YTkwVK2DbpXOt6S8QLU5bE32EsoCJk/syzv4o8c0xW0HscSj8MfMghuBxsZC/RSiT5PSDAn68TZ/Nc9n4eMSbuSdC/Efm2KioAvlGJrVbOeVjWDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053299; c=relaxed/simple;
	bh=QxylKRP8NbNllb6QGFTI6Ghh7iVl6iJ+RfT2+Ev9jeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Siy4TwnfRYOoD0hfeYBE1SaeDFc8JWaX6dB0kfpYopiUWhHEudihp33yXw7SQT9H6DY4ep/l2EoiHO7bXwQVeOibtrD2UkpzyaNsXC86Dx3ShjUPWOpcUZlc9a/rOuyYK8bCxcuQYu02mp90j1uYzihcfd1BDhEBkpQAxpImZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLSiIoOO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLSiIoOO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747053297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bC3rmCqfA5icmQmv1eGXLPySmScZgaTKRTiPQFcrNeg=;
	b=WLSiIoOOed/OynTTfZK6nTGNk7Pvu/j+5c545frQwf9fT58gOf6yUZ1lCU4xByh5pzCNmV
	4eaJjfAJi1HV2Dj16WaJSTA5kSHZ/wmEgriMfYj7X3zZjO5o2D0auMR9MfO/DeUoSbdJtR
	xWpFsytErIMC/E0v6tYd7lQnGK1OycI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-WJGVwVNlM_qHAT893zXykg-1; Mon, 12 May 2025 08:34:54 -0400
X-MC-Unique: WJGVwVNlM_qHAT893zXykg-1
X-Mimecast-MFC-AGG-ID: WJGVwVNlM_qHAT893zXykg_1747053293
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso21505975e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 May 2025 05:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053293; x=1747658093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bC3rmCqfA5icmQmv1eGXLPySmScZgaTKRTiPQFcrNeg=;
        b=QymmyqVRjTWxPzggTHQK6gb7FvY7IkIOOEjU0JUERorAs3uQ/bhjIYtJEk5kXyvKyp
         DOVcXhEldurZtnRGbAg4arJQ+DerGip98kAjGC9Z0X4pdQYI91seDB19dJlGrs1+5AhZ
         xCt9+FMtkDgvNt0hzOtP3iisSx+WYYEroV/fugVZtwtooUqA/JL1VcHNJz7vADhXaprJ
         vcwB6tnIyXC5mBivPXoVdvfQpkjwsnxOmtBK9/tMxrune4mQTZs0CZKPe4uSNO03BHP3
         DmSniBrLXBAUqwU8mTXLt4ST4zrou1x/J4Xu9tld+MsUrS0dtqJqlTDNstLVDwksiOdO
         yOdA==
X-Forwarded-Encrypted: i=1; AJvYcCWKtq1nbMMzzXsYwmKefc/+j94vuyXwmKyNc1eiKzQbk+duYbm11b6rnRjM05u1bvX8WPfoTTOGIh/kE9P092n5+74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxBZOMjGLi3YX8HkujUUgLdHv+/hei8V98d/S3Ba6+QkInvRd
	staoqJYP3YjN+3YddHyywZgEOfDKEYn89ap1tx4UoR1Sri2heh1mO3FF3Y8bPT/6zUYYGXMRQLY
	mXL54EtQT+e3/slauQDNM5e3jxlT/GImEsSK2FCqO3Nfq6P95rO4e2hM84snJ79XHwDA0UA==
X-Gm-Gg: ASbGncuMmIPakXh4xnJTbBlkfm69z2QZYveCXJdWkBpIwQMY6keTGK0g20bYdUbzPds
	P7pb9w+Aoe72KAtv8yAKx2jO/emaeQv3eBRamwsFjZL4Jv9lRvVTFITd2eZyMFuXOWiVscvrgtD
	oV/wRpj5rxoRd2pA048dm2n2KNwN2U0Ov6HB6sbxrrQEbidizrObZ94msRjt9lEp1eRB/KtOOYi
	O7qs2pL4YPzoQ/S/RMn+C6VW8gDBr0mI+qqh5eDsT/vxAKNQMMG0H/u53fnpTddDK6CrgjHNVAv
	jW7Fcdxgf50P0GoHtaQHVwDbCqzWGHGs42nTmxW7z/+1ihzF5TQbXzcMJ+n/A8ftoSFOmC6h
X-Received: by 2002:a05:600c:c0c3:10b0:439:8878:5029 with SMTP id 5b1f17b1804b1-442d6d71e58mr72191685e9.2.1747053293024;
        Mon, 12 May 2025 05:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGmemaQ8osM6LIu2Hwsj+bFw5CfMQg914aObUDJRDyOqNqUwk6qAxyXq65jxeriv3mY00DEQ==
X-Received: by 2002:a05:600c:c0c3:10b0:439:8878:5029 with SMTP id 5b1f17b1804b1-442d6d71e58mr72191505e9.2.1747053292674;
        Mon, 12 May 2025 05:34:52 -0700 (PDT)
Received: from localhost (p200300d82f4a5800f1ae8e20d7f451b0.dip0.t-ipconnect.de. [2003:d8:2f4a:5800:f1ae:8e20:d7f4:51b0])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442d67d74b5sm125447555e9.2.2025.05.12.05.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 05:34:52 -0700 (PDT)
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
Subject: [PATCH v2 11/11] mm/io-mapping: track_pfn() -> "pfnmap tracking"
Date: Mon, 12 May 2025 14:34:24 +0200
Message-ID: <20250512123424.637989-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: j8jJ0_js4CqwcvpWTdWMqV77-bxFe1kvFStwTcfXY_s_1747053293
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

track_pfn() does not exist, let's simply refer to it as "pfnmap
tracking".

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org> # x86 bits
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/io-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/io-mapping.c b/mm/io-mapping.c
index f44a6a1347123..d3586e95c12c5 100644
--- a/mm/io-mapping.c
+++ b/mm/io-mapping.c
@@ -24,7 +24,7 @@ int io_mapping_map_user(struct io_mapping *iomap, struct vm_area_struct *vma,
 	pgprot_t remap_prot = __pgprot((pgprot_val(iomap->prot) & _PAGE_CACHE_MASK) |
 				       (pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK));
 
-	/* We rely on prevalidation of the io-mapping to skip track_pfn(). */
+	/* We rely on prevalidation of the io-mapping to skip pfnmap tracking. */
 	return remap_pfn_range_notrack(vma, addr, pfn, size, remap_prot);
 }
 EXPORT_SYMBOL_GPL(io_mapping_map_user);
-- 
2.49.0

