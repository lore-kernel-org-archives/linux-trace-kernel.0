Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5953BCD28
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735910; cv=none; b=PP++puNiz6lea0hX9yO2nsH05g+cZGItddpEFY6AzEKC7/KXRlMeLR2kl0vd5gn0/gMord6/0i42U+10BoLlTpkX1S3xlYFwXLGXgnPyGqQKYNtMFmnc7eIAUvWLwuFIrYhDoFm0c8/7AH0/67qVYgHnw17u5pRwbdEnhw2GZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735910; c=relaxed/simple;
	bh=n/D+CzWXtwjWicmG4cHiWBsmxeUa/gdAF4ktY4FQ6mA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rMxA9RUEjWGopl/SVygmzVvdfkXKWMU0MtJinh1CHkddvNW2I6bXN9tH27bBkPCkRTsWDoyzG+fR88DTj9OQn8aOyCbH3IUJRr/p+IIa1NYGO+kzUXyqIJYIGu16k4pT0FCmaInsnxahR67lRq/doxAQKO6f2LnpvxSWa88bjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnZYaDyk; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnZYaDyk"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d52734fc41so17659845ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735907; x=1788340707; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTE6Asm+7RXlDcDxfjIUoFgKCyFEbiLPZQMuOphEUv0=;
        b=RnZYaDyk07MhJtixe9rv4JU3w6Mm1FnpxIqACMKsg5wXGa8YD/KqiuieuTmnYoxlPD
         hPL087Pt8n1u7TZZgl+XX72WENL1V3JSTgBMDR80cQqVndbajVpoiZa4BSboWq3mM1n3
         I6WdgTA9CSJtl69V7TdUbU3VYnz31lKmXKj1EEM3tSEJi2TqlaMgCUs4HqLI0V53D4dY
         StFd2NZjUdoZzk590CsRWggc/ix9EFuKG+kcFLdTdPBEmwRBZAun0VwjsqA1zjLo06U8
         OazUED21zaj8Ft8kLKQkO5KXyWQFDmQ2fxWblNxCKQCovz6imkgWVOSpmiVep5kb3Bj3
         8WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735907; x=1788340707;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTE6Asm+7RXlDcDxfjIUoFgKCyFEbiLPZQMuOphEUv0=;
        b=F8GvFjvE9eYFYq6sIGAH33kISIaTx6VmQ1Q/P4EndCczTFVsQuCVHcRBU9d1i0b9Ly
         cLVFMkFTjGZ6FSE5gNYSnxLCHRZKRzO4iXHDBAlNerMW5paPmq7/EDQ9VnH0S/CGCDpS
         eT31iJFtfUfQBFEBmQNCedVJRisjk3Zj16g4QHYWO3jGUedvTnkYDKog4NmqT2+6yP0c
         rAA9aUu8ry0YWkq8L94eInw1NuxQRO2cvcDtc4SKsddnzLJaG43f9iSg8HgqsNd1nAFw
         uD1j0FhxtNelPa1hDDF2QQv1tcEtX90KS13VVkZqqWMPCRNQlxXc2V5YN9V/afjxInH4
         HFoA==
X-Forwarded-Encrypted: i=1; AHgh+RrK5XDrD00/Qa+72jNns3vZnmXe84RN6VYB9Ph7RdavioEGcZ8I4f4Fh6gep/xUvvuRZNKE4u/3WS0tfuoaQiNn7WE=@vger.kernel.org
X-Gm-Message-State: AFuF++nKU7XPjkqmK3beh06DLhCo9gzpkCjhrrDscgimDSiGKVXkW9L0
	7r5okd1pGRhXa7YeDvj8A/Vn906YC1Q6nPiBeAKl9x05ngckh9jEq11U3AHsvSKYpXwW9ACwN+T
	3v9dLzIzqP7xAHHjg+aXr4o/FCA==
X-Received: from plcx11.prod.google.com ([2002:a17:903:cb:b0:2d6:e968:e012])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e549:b0:2d6:fec3:bd51 with SMTP id d9443c01a7336-2d707a069c4mr76735725ad.5.1787735906226;
 Wed, 26 Aug 2026 02:18:26 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:09 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=3177;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=YUnwhC+mh4fTP4jvnneQXyA3asq1d/voGqOiDIo7t1o=; b=Wjc/Pos7KfwzIVN8Ns8lzU7jxfHIdmvfrZOOpjQ6O4nJ/C7BmszK2LLtQ7rlqfZLTDl01NH3d
 k6lZKdmqN+mCdTG+AcXcUlLBxQxLmTU7lbl3u9elGj0Dg7z285TAHtw
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-11-0a15d8a799aa@google.com>
Subject: [PATCH v11 11/46] KVM: guest_memfd: Invalidate both SHARED and
 PRIVATE mappings for in-place conversions
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
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

When removing one or more folios from a guest_memfd instance, invalidate
both SHARED and PRIVATE mappings if in-place conversion is enabled, because
stating the obvious, KVM needs to ensure that all mappings to the folio(s)
are dropped.

Opportunistically rename the helper to capture that it returns a filter for
all gfns in anticipation of zapping only the previous mapping types on
conversion.  I.e. when doing in-place conversion to PRIVATE, only SHARED
mappings need to be zapped (ignoring that KVM would ideally not invalidate
ranges whose attributes aren't changing in the first place).

Note, precisely zapping only the possible mapping types when in-place
conversion is disabled is important for functional correctness, not just
for performance.  Specifically, if KVM zaps both when SHARED vs. PRIVATE is
tracked per-VM, then a PUNCH_HOLE operation on a PRIVATE guest_memfd will
incorrectly zap SHARED mappings that have nothing to do with that gmem
instance (because they're mapped via a VMA, not a gmem fd).  And vice versa,
a PUNCH_HOLE on a SHARED gmem (if userspace is using an INIT_SHARED gmem
for the shared branch of a memslot) could invalidate the PRIVATE mappings
of a different gmem instance.  The latter case in particular would be a
functional bug, as spuriously zapping PRIVATE SPTEs is fatal to TDX, as
doing so destroys the contents of the memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5399ae4aae0e7..d4a9877b29ab0 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -139,8 +139,11 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	return folio;
 }
 
-static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
+static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inode)
 {
+	if (gmem_in_place_conversion)
+		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
+
 	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
 		return KVM_FILTER_SHARED;
 
@@ -191,11 +194,9 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 				      pgoff_t end)
 {
-	enum kvm_gfn_range_filter attr_filter;
+	enum kvm_gfn_range_filter attr_filter = kvm_gmem_get_all_gfns_filter(inode);
 	struct gmem_file *f;
 
-	attr_filter = kvm_gmem_get_invalidate_filter(inode);
-
 	kvm_gmem_for_each_file(f, inode)
 		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
 }
@@ -347,7 +348,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
 	__kvm_gmem_invalidate_start(f, 0, -1ul,
-				    kvm_gmem_get_invalidate_filter(inode));
+				    kvm_gmem_get_all_gfns_filter(inode));
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
 	list_del(&f->entry);

-- 
2.55.0.887.g758fc8c411-goog

