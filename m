Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF923D9545
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735921; cv=none; b=Eo45b9FSs2Q0REbJktr9syDYUKWwluViP7r/JoMmrZmp8nmXph1tPj4sGeHXO5SamhEXK3hcbRSArIl8lP65k7bsU9aIkBEAJqE1pmRDPZ4+XNy4zgzIHSjRalFf6u2vPmnPVx7moyAsDd8Hylsi99ge3bC3o3FlOBkBQmMojn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735921; c=relaxed/simple;
	bh=5Zy0wgRHoYXULlg01g6F2vvkEu14R8QvWTtrIAn8XBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fpMPvXctAJJz/9vH5hlwLCmZKIPDFOeD9IXSZlTFbUbP/G8m/ym3aesX+sv9KFDnxq21ApkGT0Y/RCzFzRLKxsMWpy2I+GPrYZR9ARez6NeoEWtO5VlznYDYF3JZANEd4SSw3K/8gwW/a51VvlfiYgvoXPl113z3sdrkrEMhN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vD2s2keY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vD2s2keY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6df0a1e18so9979985ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735915; x=1788340715; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9viyxfvYsSlaAuG4kZ9V8QlGv88Bbdqdj5aKht9VSg=;
        b=vD2s2keYcKLUg9jv8wtF/cuyEqMfESMHDCmA3GIvTHX2qSwIe2H0S7roM2hANWMn74
         xuSHBElwhOxn0GtDxY+d65hbstwOt5+EsHlKSfSJGz4fLrxDBFvtb7t25WB59JY2bZo7
         pJ3WM5dFpWykYwpmHc64f0bBTGZyFQ+kQ2APZs6lOwIktzWV2IM4KMiAgGzf2udDlw8+
         daY1s3E2jc+K8zbiwysBli0mAcknRMcg2aoenSYnWuLTtItrPTTspDewvbHYGNoyaUzW
         Yfb+H10gO8YBXzhAUesKWS8/iMt3FsbjrdRaQrjHPjEidRKlAT8LzjPJ4tL3YQKsWj97
         Aphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735915; x=1788340715;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9viyxfvYsSlaAuG4kZ9V8QlGv88Bbdqdj5aKht9VSg=;
        b=nkP+4oGH/XKaRSbjEQ2GMUOWBM6UryvURx4+eQ39XLs+Su5TQXti+C1TXa6lMVdsGL
         gODmflCQXjH3/TgSLw892Z03QaQugZMzzVYdqudINJeGwkgv2rZ4G1vJ4q/I2qdkaL5c
         VI5i3raxG9NjBsulU4K0P4b7w/UxAxySd8Q3tL18mDP7VAkn/VCB1VO2O0kavxmKwiP8
         CXYTRaQFDQzNi5Za/Bbn5V0uc4Q0U+yN7T0ru4EmqEn2DUoUUT20k4IDT4mDhxcedNz2
         3GcpEU0qCBABOcBu3vPVNf48Hnrdwr+XkhoPPREL4ba7GyigGlTB664ix8xzuHGKJDRP
         L5Ow==
X-Forwarded-Encrypted: i=1; AHgh+RpC0GsvGSUxYwxgqabzZsjFEHwF/5LNAFTFhc+sdzHdjilF8MFxQleXKBBGo9iv7OTmEEHNW/LLGbpsNYG4AHbjpHk=@vger.kernel.org
X-Gm-Message-State: AFuF++lUTqHIhFs7/NFiAUsvYzJxt4vHLj9zdcF7cYZ5dKMSbkBaWtBL
	DmYUi4YFk5T1GhXIblGDCvzgz3iRU+KWY/Cphz7ORpmQxIzsAD97gmL4e/7iloiChuyjqr49K1I
	xQZRuAPbwK1eLFmleMFZe0chtsg==
X-Received: from plmt11.prod.google.com ([2002:a17:903:3d4b:b0:2d0:34d:e973])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id d9443c01a7336-2d707a55a21mr87392135ad.3.1787735914764;
 Wed, 26 Aug 2026 02:18:34 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:14 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=1963;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=5Zy0wgRHoYXULlg01g6F2vvkEu14R8QvWTtrIAn8XBM=; b=hJwcYJYD3aQhvV9hZ30dJZ8oFevxPiomh64e9F++PWR61XHxRgbkXw3b9UE+Q/itDtGXtMPp4
 zJhf3vH1eeDAA7nHPjekSt0TG32A8zYAxjhuYb571OlL26p5daTs2K6
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-16-0a15d8a799aa@google.com>
Subject: [PATCH v11 16/46] KVM: guest_memfd: Return early if range already has
 requested attributes
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

Provide a function to check that a range has given attributes.

Optimize setting memory attributes by returning early if all pages in the
requested range already have the requested attributes.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d1134b23576e4..6dc199be0eb87 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -98,6 +98,24 @@ static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
 	return !kvm_gmem_is_private_mem(inode, index);
 }
 
+static bool kvm_gmem_range_has_attributes(struct inode *inode,
+					  pgoff_t index, size_t nr_pages,
+					  u64 attributes)
+{
+	struct maple_tree *mt = &GMEM_I(inode)->attributes;
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	lockdep_assert(mt_lock_is_held(mt));
+
+	mt_for_each(mt, entry, index, end) {
+		if (kvm_gmem_get_attributes(inode, entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Returns a locked folio on success.  The caller is responsible for
  * setting the up-to-date flag before the memory is mapped into the guest.
@@ -623,12 +641,15 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	pgoff_t end = start + nr_pages;
 	struct maple_tree *mt;
 	struct ma_state mas;
-	int r;
+	int r = 0;
 
 	mt = &gi->attributes;
 
 	filemap_invalidate_lock(mapping);
 
+	if (kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs))
+		goto out;
+
 	mas_init(&mas, mt, start);
 	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
 	if (r) {

-- 
2.55.0.887.g758fc8c411-goog

