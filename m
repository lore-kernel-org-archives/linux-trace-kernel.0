Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B362367A6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569061; cv=none; b=NIxSQ/MdTviQv40Y2+KiIlQ8bI0v0ZC6Spn1N4e5fLu7kMJu5vpYsNIQQxeZfMdQ/AvWY5GYXGRRuKV8E0wVHrXeB91R5+tB4CugK0s84QDuN06AcyXMGq7vMP/SUlNo34u60TvreCzVhmo2dayQhZPmTRTcTHlrt3sSzRIcaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569061; c=relaxed/simple;
	bh=sC9yz9dD/oKAzPcvHGkMQY89EvvA7vBfDCo6bq+VwYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HeLODgs0U/QRxOBYkELeW8G9bRFRlmUSJ8Dtx/mnrRQ66P4wTMjqLdMjp4UQtyYHkP6hqYAQCnpZ1Pv9MuFsx4reCY7g1siLxqDHizAI0qOUkXjNKk5c02ay+m+J5CfDRlHOfmmzJ8KeSMAjsl6bsoOePf4Cb8FXgPfqix5EiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sx9idAJk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx9idAJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXejfGAknVxklqhHCW/V9liutcQQAQcJcrhEqzVyY78=;
	b=Sx9idAJkS7X/zbU7Th1anbKFy41q6pn3jZ5KTYrzzYHLfqjgkIxZO9sowIRMntBejwBSsu
	wDsWjniXX4Bh0Wlwa1UpW05KkdCoWuNlCaWLjOlop3hpeWUK0gV73segrFu4BFw//UA4kQ
	ZotPHIJTvpXzMIRBo9nSXloWLgda1to=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-CaJLt24SMGqf9Ji93uZjfA-1; Fri, 25 Apr 2025 04:17:37 -0400
X-MC-Unique: CaJLt24SMGqf9Ji93uZjfA-1
X-Mimecast-MFC-AGG-ID: CaJLt24SMGqf9Ji93uZjfA_1745569056
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39d917b105bso999047f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569056; x=1746173856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXejfGAknVxklqhHCW/V9liutcQQAQcJcrhEqzVyY78=;
        b=dBFBeLki4Qc0w7pE6nk/b9QaqxPHgAEc5ZteDONzOCxAIoq+FJDQwzzPlfnl9N2stG
         2+fzSIlRU5xFMvCyg3ky7PE+Qzw0FOffaXQpib/5ed47frXl4fKpdRAzc8DzhKhG9Qu5
         suucjmlS6o9LblzOrf5NNJLT+9qe7FpGjLh+uIiAZNdIz7OU+sLG9RhkixyPywo1ycrr
         iHorF6zsnhBGyqYUtFX16I3BNMmGhA0johzhiOYsygnQXsSM4H6YxI6bB3aq3os9qQ5p
         XbULMzkQW4oFVmlrRvSvMCQCuFLU4HCa+8Op7zkJgh1ReCYGpPa2Z7S7hadExazAPdrB
         IqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCryqqxd/I6SCsx5Vhybs7wzU+fbuTzfGHqn3CCr0et8uP11W3oek+8BR87SmEfafQQ6t4QZ52+m4je0FFZZBs/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeI9DUzw5mnlHDPO7U91AUzpeI9RNot4wKCtwi2pPtNCOMq3xR
	Dg0mBHXxGw9insSN8i0YT/QFElWSXqWtWCfPpyVPipJhSQsQk6SsZbrgJ41YPuxvEj6vQhwugd/
	n210JeIQFAyFsV9TBOSVV2gVUSlR28nFejdi3ON6gO/oM+ST89cwPkQxyuBW3ZpTrsu2/sB1sKt
	tZwA==
X-Gm-Gg: ASbGncu5n1PI7SFmvZqXMwIriw6EjE/I4vEuJplPKVvo32QDvJasPg8bEtP/9QAn1kv
	JZLviiAn5u6MCi0iYdDoB0g3h/JgXbXZyOcKhxBgndK9BNskJLvdWjANeNuy8OjizazjpAZW0HS
	E27xH1epu5WGgYfMrvnUcF4zMYKPVG3bAwqn0vX4px6JyzJxF4chTEDFA091Xtzi/h3fJdFnmjP
	+muoGeI0i2Bgfv26F4xJg1TqYKSd3Wu9Zo2FcAtDAgQh5au2Lh4CpWCdMxRPxwlbhBeKllq9AdT
	SGaij8gRC+GN219MB//xVyXej7Debv9r4ViW5JKIj1Mjyk0WXipB+dBEzZazcymQkbPzGl0=
X-Received: by 2002:a05:6000:4028:b0:391:2c0c:1247 with SMTP id ffacd0b85a97d-3a074e0e4d1mr832140f8f.1.1745569056480;
        Fri, 25 Apr 2025 01:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1X+NuNfEcvtfeCEnq/l8/EdxH0+aUnwVbo8Kq4KyW0RucKtS6876psW/EjwOajf1KdVRgA==
X-Received: by 2002:a05:6000:4028:b0:391:2c0c:1247 with SMTP id ffacd0b85a97d-3a074e0e4d1mr832108f8f.1.1745569056044;
        Fri, 25 Apr 2025 01:17:36 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073ca52e5sm1657353f8f.36.2025.04.25.01.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:35 -0700 (PDT)
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
Subject: [PATCH v1 08/11] x86/mm/pat: remove strict_prot parameter from reserve_pfn_range()
Date: Fri, 25 Apr 2025 10:17:12 +0200
Message-ID: <20250425081715.1341199-9-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: W45Zr-gOjCd02fY-Dn9puQji7jrmq4xne0khqdvcusU_1745569056
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Always set to 0, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 668ebf0065157..57e3ced4c28cb 100644
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

