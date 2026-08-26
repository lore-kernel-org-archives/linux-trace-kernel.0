Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3613C8737
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735911; cv=none; b=EfADR/vZRrPcE9LsomOTkBHD0zpb6RpCXgAu2Ggn08OLqzTep0gDcWnCH1YtXBtq1fxc1UUMYtu//6SUv+5F22X9tX8yGSzfYb9Ke4dVrlWmIHYw1dHyMJNJN0qyQgiNaZH0d0541pyzREJ6qtjgzw/56QlhfSfayMinczKhlyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735911; c=relaxed/simple;
	bh=d74irKAD/WY1oRS6lvT6VEWWDqrQZv2skOByz9ZePX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rzRFWZw2Rka1pUjGaM6PHUk8M4Tq62+D2V0JrK6E0vY3sFzATFTHGDcdItxzYnouE3lmUrKVU2HFLK/T+pWMjXjmn8Ujv1nK0vYUlLQhjr8jln1oDqxGC8ClUAmRwxcl/tDuU7KgEmDjLKHuBzR/gfTfwnfVlamLrpoK4aYGnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PetAwkgt; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PetAwkgt"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cee1ec30f2so12270645ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735908; x=1788340708; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uXPej6/aazY/Zy0bqnNH6AiLcBSkzXva7x44ZsPvDyg=;
        b=PetAwkgthqKu2cbtHYj49YohAr3nWYcj57CBdheZ6clRKQX0X7NJ4lAf7bf76ME6VN
         be6dEAke4UT8oFo+vHkYP+2diM7S1QYUkMeMaOyLvV9qPlOs87hXYd/Bx0BnV72zqJDI
         QYdNF7CKk6nceylj5csQIko4PcXTrl7zk3frTblwPVVH1MbqE8XgqtQrtyN8b4HMBxW0
         Hlq/T4oHHJXsLEpfqu4MGsp92BtcIq2xdSBPwn6ZNjrikjUKwYfx3W0yFwOLnFmPqVru
         jJVcGhcv+DECvAT8+uoJzQe8cXnEIoxNxQ5xcDzb4aY5HcfzRLfqGmB48bFf9EdEAYXW
         UzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735908; x=1788340708;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXPej6/aazY/Zy0bqnNH6AiLcBSkzXva7x44ZsPvDyg=;
        b=Jn18McmNU6yL0bN9xFG0Ex5jCIfReqwHIJozDnTN6dswI6k94qMwOe/+6rkpq6MbcE
         +tny6v17B0DWxTz/F70UpQfqjHplnM9Yq5jxzA7rKL47rUCuZly4FAkhFWGqAH5gPuBD
         XTlaVf+VleaVVYsuRq0s2YQaqgGxyIVXZ+UDH7ssYzgvWcF0ENkZOjECqNoFTcGNNcMk
         d0VZkrpCUQb0P5u3IZZemyMBBnmQnRQEHc6P/V2KAFDTggzW75Xbfd99ohN1uwMWoSqK
         i3Y+dsCg7ezk/3gBvDpzSRfnDh+zXz/1cCGOcqk86WlA4BCKNHKfT3v/4M/xjiMORnCy
         K8jQ==
X-Forwarded-Encrypted: i=1; AHgh+RomI8UHxzy0wmaJ99IjUHmG2ZGNMGuh+xKP6gydJBy6OY9YOzI1d0BXaodzVfKQxhqcujmjxv/pnOyfku9GRPwyvro=@vger.kernel.org
X-Gm-Message-State: AFuF++mMVBO5Pvk7oBEuGpJsvKYN/4etOGrYjWjoGOzbgqUc9s6UuWl3
	VQqfMgrEt8dQjGoJdHYTPW00KdxX6vobuJr5pc+ojHCXFR/JupTs4r/cYx/o2oZiTDIfWGGs50i
	PY1+m9ocSQdWHL5nGYTWCkhlrhg==
X-Received: from plblh3.prod.google.com ([2002:a17:903:2903:b0:2d3:1b72:ff0a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1a0f:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2d707a8eb75mr93292455ad.5.1787735907954;
 Wed, 26 Aug 2026 02:18:27 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:10 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2917;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=d74irKAD/WY1oRS6lvT6VEWWDqrQZv2skOByz9ZePX0=; b=fCUn+TX3iBXyhcxdFfxYrHVsFqPrFalVdBOqXAzPzLfL/WoqEtNajpCcqHmxHZNjEuZgf7onY
 ak56oI3jLtlBkiH5CIOlWLg71rSuHsLBV/sKh/x4ig+QvPQxWgiJpVH
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-12-0a15d8a799aa@google.com>
Subject: [PATCH v11 12/46] KVM: guest_memfd: Pass mapping type filter to
 invalidation helper
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

Accept the mapping type filter as a parameter in the invalidation start
helper instead of querying it internally. This allows callers to specify
which mappings (shared, private, or both) should be invalidated.

In the next patch, the conversion process will use this new parameter to
invalidate mappings only when they're different from the target state of
the conversion, i.e. invalidate only shared mappings on a shared to private
conversion and not both.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d4a9877b29ab0..ab29e7f555787 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -192,13 +192,13 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 }
 
 static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
-				      pgoff_t end)
+				      pgoff_t end,
+				      enum kvm_gfn_range_filter filter)
 {
-	enum kvm_gfn_range_filter attr_filter = kvm_gmem_get_all_gfns_filter(inode);
 	struct gmem_file *f;
 
 	kvm_gmem_for_each_file(f, inode)
-		__kvm_gmem_invalidate_start(f, start, end, attr_filter);
+		__kvm_gmem_invalidate_start(f, start, end, filter);
 }
 
 static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
@@ -224,6 +224,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
+	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
 	pgoff_t start = offset >> PAGE_SHIFT;
 	pgoff_t end = (offset + len) >> PAGE_SHIFT;
 
@@ -233,7 +234,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	 */
 	filemap_invalidate_lock(inode->i_mapping);
 
-	kvm_gmem_invalidate_start(inode, start, end);
+	kvm_gmem_invalidate_start(inode, start, end, filter);
 
 	truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
 
@@ -522,6 +523,8 @@ static int kvm_gmem_migrate_folio(struct address_space *mapping,
 
 static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *folio)
 {
+	struct inode *inode = mapping->host;
+	enum kvm_gfn_range_filter filter;
 	pgoff_t start, end;
 
 	filemap_invalidate_lock_shared(mapping);
@@ -529,7 +532,8 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	start = folio->index;
 	end = start + folio_nr_pages(folio);
 
-	kvm_gmem_invalidate_start(mapping->host, start, end);
+	filter = kvm_gmem_get_all_gfns_filter(inode);
+	kvm_gmem_invalidate_start(inode, start, end, filter);
 
 	/*
 	 * Do not truncate the range, what action is taken in response to the

-- 
2.55.0.887.g758fc8c411-goog

