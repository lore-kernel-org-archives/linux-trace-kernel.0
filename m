Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C943E0222
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735935; cv=none; b=CTbU3IIL5jTfmNK4OiVRNTd5Ook2z6GYFj7fwk6PLLGngJHLCCk+btTMoPtSQDIEylKMccmNMWG0J4w7cnKsXbwZAqrMs5jv6CX836/N+3kD3ZotHlOKUJrytpmMp/3zPwXWpfqf8ilc25NeLjuWqgM1H5avkVLtz/tRG4lGQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735935; c=relaxed/simple;
	bh=muKduSh1b24ScYepPCMs+OGpq6B9+q/ZPxcpNHD7eQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PBeCHrQRFbhQHerl32DNLLn/uJsV31IS+KPtu9E0cZqCAGLHbm3DOBPltFFpvxr2bPL8WNBkDRQQDTB7nf87Arh8sXHa4Vin38WurKacw+U42+GgSJpx8Ov644gL0jLBjWiH+pZvxwiMtZA728QHdXoTf1W8M6cYC6AFF8KVVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXgmL+lW; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXgmL+lW"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7151120d6so5788435ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735930; x=1788340730; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TeMJJdODrGJdlu806vqL84QXzoIcKrTnV6sfhdG6lEs=;
        b=MXgmL+lW14LyZbpun8Rw2/USWuRYtP3w6VlMQqkJ9FYCoBEN7SFqWsV+iaDCBkutqN
         F5Ry5Lue6kJZvW2k+Erd+A6PNA3FFFPhDIvz77wLe58t7BQx91FyWLEDQfHc0eCq0Fyc
         kmr0IEECQ1gPRVm6wbZSyqmQOtEpUmb/i9A/grolfGtog2TDn3D3eUb+OiIC5XcwDxKA
         /F05E96bRtjyvGNr3VtNQl7uvkmfEjPkOUoRrdw6D7rf4eAKk8uTJeIKtXPS41+/NhlN
         UJW6pFvTkJkqYbonx2oK0fUM49aq4cQui92Iqu3CPIGhN4udOEK+/W3OyQ5/5buFFIdJ
         LaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735930; x=1788340730;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeMJJdODrGJdlu806vqL84QXzoIcKrTnV6sfhdG6lEs=;
        b=a7c2xjtUssRCI6coumwfcp302yH+z0/+39d1vKssY9EMIcBVvGfzv/IsIyMWBYyfmp
         3vkjiFSMvDpSv4v8ZE8fIWgD+D2nzMvkvNyRghT7Mkk8ULxayHX30U7GTq0uMAqXeY1t
         RP5F2Nt95DRhlUjP3ZQHuXSmhAibzH6eBuuF0DWCGlh19q5ndPyhatZuFTz8pYV/Jp7p
         YyqcykrAwt8ldeNWKpv6n1S/tag5JbnklFKk8wiW2wJ0EXr8ApulBQNnzUzZrQGNE0IA
         UwRSUSPREaqXbm/d5Mm7cHUwua4quh3VP7wYgHVIcnQLkUsJSfiBlbI+RncqdaXEOjq5
         JelQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYSmg2M8XbsBVqaI8loPm86si484SMi0j5j16kwGu3nKP7td0WhCvoDYpuaCf4ZCRc2F5nw94ckx8uMYxdxqB/9mo=@vger.kernel.org
X-Gm-Message-State: AFuF++m0qsGOLN06orMyU4tOvvgqlebr4LUw6oHInFC/UR4EPvPaWDHr
	NLoKWXCLwtDrjmeOCmXsKAyksIhVxOQfN35/dFlQGRDXwOsPKamnyrWX+HS28RvKweP+Slmet5I
	GpdhR/v3tEDzqmm1pQxWPG7lr5g==
X-Received: from plco20.prod.google.com ([2002:a17:902:e294:b0:2c9:b703:3bfb])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2341:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d707b4639cmr87037965ad.10.1787735930069;
 Wed, 26 Aug 2026 02:18:50 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:23 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2916;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7deP7h7QgDnwN6/9QKin5Nm8lfgB+57/3gsjOj+zwyw=; b=CZvlPH/OyUE2cOwFZHq3gx+or4V4GkEfPVHtR5IRBhyoJc09nGOpZZvAf2iumEeelzHT+XQgZ
 fFOTyta6nJOBd5QLNDNMDklfHWbkIyZvfWZ5tyanGQIZCv0kpN5zCS2
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-25-0a15d8a799aa@google.com>
Subject: [PATCH v11 25/46] KVM: selftests: Create gmem fd before "regular" fd
 when adding memslot
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

When adding a memslot associated with a guest_memfd instance, create/dup
the guest_memfd before creating the "normal" backing file.  This will allow
dup'ing the gmem fd as the normal fd when guest_memfd supports mmap(),
i.e. to make guest_memfd the _only_ backing source for the memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 45 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9ddc047d5c275..3413d45e34faf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1077,6 +1077,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	if (alignment > 1)
 		region->mmap_size += alignment;
 
+	if (flags & KVM_MEM_GUEST_MEMFD) {
+		if (guest_memfd < 0) {
+			u32 guest_memfd_flags = 0;
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
@@ -1106,28 +1129,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	region->backing_src_type = src_type;
 
-	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			u32 guest_memfd_flags = 0;
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
2.55.0.887.g758fc8c411-goog

