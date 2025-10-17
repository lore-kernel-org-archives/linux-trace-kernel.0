Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753B2F6930
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731978; cv=none; b=gR1VMOPJvwfehOrKOhaQxSEQX4WvrtVeznOPD6s4dvChCBExR5eqbZTqv0EWo8GdlCCLNPwCASe5OxwY13VdHadl7PHnuK8h/WMrRS1s1+VcWCmVBXDXWibvNaRZXwAOeLE01rRb0Xa8tWgQy81Pv7j0XM/iSeETV+JNiCFAmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731978; c=relaxed/simple;
	bh=+Don/negV5WGXQ9NEPnCDOzWjOy8hg7DjqQOkMqbtFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4jsvW2Gl/tJ+X6OcofNlLN5A3BpxshmWqHJpFoR45QTxsqILpQiquxO4A473Ioj3VefzUHszBsYnG5Ke8JIPwvK+baX5U17n2PF+M7NhESnnvchd/za+Juo59b2D4zt6g7qo1u+V/YkYvegUixIonulo6WuvHFcNbBuWZOFlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bwBHbHAS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwBHbHAS"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b522037281bso1564717a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731972; x=1761336772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao2Kri++l8bJKnFCz6AaoQPgwufHNu91Ime+tmGl4cI=;
        b=bwBHbHASc4r0648toGCqnzB69SHm8SaThQiEPLNqV/oeTkhJtSKCqfB1hk5J0pkkMP
         9lPKR9Otzlwoqh+HxSaCsYHLAxkCXykkajeC5Fg+AIJZdTx0vwzfz0pRE9jkUluicXRP
         /C1YK+uoaVP8PqKLf53T/evvnmSiv6SG0fWeWZf2T+iHChQFvi2MxQxNYdgDDVhXyujv
         C1tvzDs7QpbnH/skJSAz87NNjOpo4k8zWrSJWxEgppMb9nxjZ67BFqvCCTAjIPVBoVFo
         pfIp+EwUsjyEkzlYIHPLQUQekycArAO+tVM/TVF5PJgemDoRje8/+/MH3AvlvUVDSRvI
         /HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731972; x=1761336772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao2Kri++l8bJKnFCz6AaoQPgwufHNu91Ime+tmGl4cI=;
        b=nKH78c2RkLFqlzVXT2aI7p67C40/UmlJkbDsoehHya+7bRgGnEBAn3k9GNZsZ0Fsx3
         opk4XHBn6dYbukwAuJkNs/REHviz2EEf1LA/qbY24/x3uMzTPik+LkYYBD0rrl5oTnlb
         QZWCQmz08bCQRa62uv2zgYWjxCCupzkZ2fghLGSaiA7tBbywGbUQA/p9dbbbT53eKE3u
         eJ+8rkOtLfTAflvF1N0+i+M0J7nbl8x1ua4lDKLd7yeiDievvcNoyzvGeeHZeMeTIVKW
         tJeCK28FZmpeKpQndct2MGPwtgh1D1mKapuvKhGsox2COXISGm2GfNG07mq/OsxqtVur
         4M5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlf4pLI70bDyN+ILt7UZne5HnLokfbR7AQh8AZMn8y4Njor1XCHAxIxGIljeogQaU+flU+J7TPTuQhwqKlUZqtZxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8p+e8wWvngUEKZNbmIbCEKkHNKK8Yu2SRAdr/++orsL8eUhg1
	7mAUQWY7ux7YP4nS3iLWeGUqy7vVV019LhvQ5n6ElJnQPCEtIzHzfYvHWDnJo1AVsG1JArCHq/I
	nGRFxD+S1R9nP9x6GYR8Ggo4eAA==
X-Google-Smtp-Source: AGHT+IFKI0OPxPHpIm/VduWDdNt5Az35Cg66pdGdSmypT2yzUK++BzgJqMs1A6JN527BCeH9t7suOJAHUyZ4cW0VZQ==
X-Received: from pjbfa18.prod.google.com ([2002:a17:90a:f0d2:b0:33b:51fe:1a94])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c48:b0:32e:d9db:7a86 with SMTP id 98e67ed59e1d1-33bcf85313bmr6308556a91.7.1760731972070;
 Fri, 17 Oct 2025 13:12:52 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:55 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <5ee20908e7a67204215ed17c502a466a516d0ae6.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 14/37] KVM: selftests: Create gmem fd before "regular"
 fd when adding memslot
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

When adding a memslot associated a guest_memfd instance, create/dup the
guest_memfd before creating the "normal" backing file.  This will allow
dup'ing the gmem fd as the normal fd when guest_memfd supports mmap(),
i.e. to make guest_memfd the _only_ backing source for the memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 45 +++++++++++-----------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index eef6de9a7f4b1..e35c65a173606 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1026,6 +1026,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	if (alignment > 1)
 		region->mmap_size += alignment;
 
+	if (flags & KVM_MEM_GUEST_MEMFD) {
+		if (guest_memfd < 0) {
+			uint32_t guest_memfd_flags = 0;
+
+			TEST_ASSERT(!guest_memfd_offset,
+				    "Offset must be zero when creating new guest_memfd");
+			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
+		} else {
+			/*
+			 * Install a unique fd for each memslot so that the fd
+			 * can be closed when the region is deleted without
+			 * needing to track if the fd is owned by the framework
+			 * or by the caller.
+			 */
+			guest_memfd = kvm_dup(guest_memfd);
+		}
+
+		region->region.guest_memfd = guest_memfd;
+		region->region.guest_memfd_offset = guest_memfd_offset;
+	} else {
+		region->region.guest_memfd = -1;
+	}
+
 	region->fd = -1;
 	if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
@@ -1055,28 +1078,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	region->backing_src_type = src_type;
 
-	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			uint32_t guest_memfd_flags = 0;
-			TEST_ASSERT(!guest_memfd_offset,
-				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
-		} else {
-			/*
-			 * Install a unique fd for each memslot so that the fd
-			 * can be closed when the region is deleted without
-			 * needing to track if the fd is owned by the framework
-			 * or by the caller.
-			 */
-			guest_memfd = kvm_dup(guest_memfd);
-		}
-
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
-	} else {
-		region->region.guest_memfd = -1;
-	}
-
 	region->unused_phy_pages = sparsebit_alloc();
 	if (vm_arch_has_protected_memory(vm))
 		region->protected_phy_pages = sparsebit_alloc();
-- 
2.51.0.858.gf9c4a03a3a-goog

