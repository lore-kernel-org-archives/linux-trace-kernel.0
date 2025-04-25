Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDA223771E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569064; cv=none; b=W4j8FDUcZOj0mFgszfqSHuqAEikEj3hkzQ89GMp5Mh66yW4VsZVnVa1twyL2gRWl9zkRjYv38rrepY08wGcZHI1Sfy7QQLSaiCPpQZwzGi0C6M0uaxAg2kaLgeOCvCgabZvbRHqkDZOHjDvFBY+5Beb7kSIrT+rQhBmzItN3ACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569064; c=relaxed/simple;
	bh=3pu/JRmizV3sTEFqn23N+eBiWBLA1us5qDw3DkZsmds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=mSypgTGMhMWUoYf/qCNAov6ICbcXagDDW0fSRiaR1bjm2TsYF+FUW6OaicE9VvcJ6I45u5ZCStj50E1Y6Xq6Fo+VPDJplARh+G+9oc6Nu23EStmdrP8bFXCcAoIFQiYjYIfHbRNY0L/2tREDHLMUUFeYYsfSxdJURs4A42eD0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5cuoA60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5cuoA60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqCDzyJE3N7q1dfRPTJIKewHsgjJcYj+B7llEZA1rCc=;
	b=Z5cuoA605beNDAozHz21eWFdxRW5mweoPjsl23GvtpkbxqtPe3wbynXvp4k3Rde/rH/QFv
	a3k6fxm2uD5jWcNqg42zus5VcLZ39JZ6PWKY23WtC1a8XkOEo6I9Ytb1mFgYsMcwXpxv8b
	+B/qJ6eBDNpZA8+SvMUanzgTZLCvN1E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-PbHUSDVxPTuyuVWHo66ULw-1; Fri, 25 Apr 2025 04:17:40 -0400
X-MC-Unique: PbHUSDVxPTuyuVWHo66ULw-1
X-Mimecast-MFC-AGG-ID: PbHUSDVxPTuyuVWHo66ULw_1745569059
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ac9b0cb6aso888461f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569059; x=1746173859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqCDzyJE3N7q1dfRPTJIKewHsgjJcYj+B7llEZA1rCc=;
        b=DUo0hxLQZ8zlEOHAh8AxpbTm+4LfvGm0XN54vhWRsdUzc6USfhqmdRKbZ6fqciXD7m
         DcBBS91QCjoFMXH9BMiqMIKrXd9BOKtu4DppHGBgoyILIPE2YtUDSAYuc5rUNHw8PBmL
         EgtvE9KJdk8cm3ISp7kqn2g5B3fFkV50Ny7xbi+hOkpSN3tNjBDxOECwdQh0+zMDowJx
         rb2KrERq3IXWRzCKS9Q4qN/cZom/3Olz4WD9Q9kjcVHtSI/lYR/6xY8IpXoBXD2WhNFj
         KdWsxa5cPOgkhlOPhe4OEriiodbtRj3BlZ2lCXcknIzIHcpM5NxxbyY4PBnGYqEEcxXO
         QAvA==
X-Forwarded-Encrypted: i=1; AJvYcCVxxc9SSjuPRuRftZ0OYbJu2CQcJmHyKG5+RBU6lzC5Ab2yn1O7q1BggnakME62+a8ZrJn1xu+ui6+wmvl6wklnVt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIvbrmhn9OyEAuUdkb+dfS/Ve8tdR19eEqMH9chgIBcjW0w1Bv
	fQpBTUprtXzBrfeIVWxMy6kNpgD2koNqdIuh98PyzNuIKRXIv7/KrTcJZq2+aLbe3SaBVK3ulKz
	GbifPvJi9yCqcj3q2nASTOBE34KCSWxVuNzfV6ML4peqYDk7K+mGymmrlCkAZCTWVxEhKdw==
X-Gm-Gg: ASbGnctlil9zr7gTT8bfZ07/rIwGplnysogFWwrIP1FJ0GVIeS0LCSG8zwQdETKxp8i
	lR09h8rxeBW4hpk24Li96oYCRaXLa25wQHB5n/JbTZj9DMqGapbf30kjaaH8+TUZ9jQfq/EdJIk
	UVg6HRk51iP25SvwVRbM1Rlr/ZhB2pVpC2dFdyynoHNlqwXMfHSTdnQIGQQPwr9g5GQKUNhcRbG
	7AqZ91gAgWaKvarSxZnpRtsNlrovN1liX0/GwL4qv8HU8VSKVfzO+xauIUGwaCPQRtLNS1otwhb
	+cnyD7kbUOSjGc7L45kGeq4TcZIx1lw2P77jthwuHd9sgTBG4KTIn3tfsBNLjkaWfxmMPcQ=
X-Received: by 2002:a05:6000:4026:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-3a074e1e7c1mr893896f8f.17.1745569059300;
        Fri, 25 Apr 2025 01:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeMJVro3CtNN/nAt/kzydgqpqMLMz4QDAdVYj55uYz4S+yOKx9n2ojCFKF9ThYiE7nLuy7NA==
X-Received: by 2002:a05:6000:4026:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-3a074e1e7c1mr893849f8f.17.1745569058900;
        Fri, 25 Apr 2025 01:17:38 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4408d8d191bsm78695765e9.1.2025.04.25.01.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:38 -0700 (PDT)
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
Subject: [PATCH v1 09/11] x86/mm/pat: remove MEMTYPE_*_MATCH
Date: Fri, 25 Apr 2025 10:17:13 +0200
Message-ID: <20250425081715.1341199-10-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Gw6-MgwwQcsr7GolC5zmeMz1U2g8yh8N47FGdFBUw70_1745569059
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The "memramp() shrinking" scenario no longer applies, so let's remove
that now-unnecessary handling.

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

