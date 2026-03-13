Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D637105A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382393; cv=none; b=NiX4o6EeM/BxDe8mhYZKoirO1uPvIiJINuHmKfprqxYWo551A5kUQ77GAQzT7ycJ3rwfvQQOeZdZUzXtWMHKw4pda25kORc35uveLOUy0U5nIrsEaD7X84MC5BFyYBgQ7KSSHVzCx69GeGpfXI4Kgx8iKtIPkyxZemQsuuH9rjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382393; c=relaxed/simple;
	bh=ZcXSegqXtJz+HuVqaKPnc6MToB5+TO4fJ8GJ419WYts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPlKO7wRsSAtJWMI/3YsqlZOmKMiCCwkl7YVtSic55G13+nn5+zmzADYwmgdwies7Yfio8IUwoSf7tK70VIkHA/CtIT6UjS1x1s36FLDxMs51pisiBj1f3diraNjgS+y7UJdvM7nWcfiLTb6llwGTWL183Tw+Fk0rJ19Gh1p78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A//1RUV1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A//1RUV1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aed1beaa73so1152615ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382389; x=1773987189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WVpdQpvFLdCQp08tqM1IF+MQMy3lD0i845Y7ArLQP5k=;
        b=A//1RUV1LP7F/1CNF+cHamVeGgShEyq5To0RXvYvaKdhJbyo8DfSmWgtckVp0Sw2rI
         zwRKTWV/MSufzBVLbBufgfvUhU0gPO9KM4LJEUqCf0Hzf2fXCUn3g8OALDvfKo0h1Lba
         4+cQCpGk4ypQovWDAm3itSYfFHKpfTuUEH0RiMGGDbmBWIgUKxBPbKeBgQG7MwhaMbjW
         14TMPZQwlJyPCLm7xWpKdU31e/rCSKknxuIozN7EbRhMfbg7aa04BrQNqeCnlp5Ts4vt
         3M0MJjDvOIIN9vepRN4eV4hDHEc9VsN/6MtGDv/oP5h1n144Lr0hC5NYkxH3RZnRY9GX
         kucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382389; x=1773987189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WVpdQpvFLdCQp08tqM1IF+MQMy3lD0i845Y7ArLQP5k=;
        b=aIyX01j4gK/KKJuhF8Z1t0YxSX+087sRE26JtiJm995KolSygUtmmbMIz1JCWm8nem
         MmdlbB9Nl7a7uOqY7XBQoss+szQMkgCOw9TCNjPRyZLd3L/y0AGJCXeBQotjvftsvyY3
         qQGcJzH0mDiBVcezporXdMOHmald8QU65Gbrh+/X34dTpswO+ZxnfzmOttAdh/4Traf1
         6IIcxgloFNAq5OtYC7oPJ3bWMosishaAgmZt8NYCf8sOgk3vNBin6rznF3Rg8WRGCmDa
         NZBLvSk5wrh+93pEs8PdY+J69RuwUP51f1wUaCClhyzRUzHfGH4Fn9p0wNIjdQj44riM
         yXOg==
X-Forwarded-Encrypted: i=1; AJvYcCXYHEK6fL1FegVbtkvXI6eKaJmJG41r284qreLhfLYrglzCumUo101hC0mz7cP0Ep70swYZIGVi/bZ1xJtQ2fM9+8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gk/c1erB38OkF4LtxO+B0mH6gWkvKnLSXweiPyUd/HTC1aME
	t/RJvot939d5oJPtsye1re5y5Vwgvw8jqov404usz3UXJWZ7/nCEdunu7ZaosYHju8H+ehoa/GB
	tpOk/Rkrp8q9pNrL8617nOXYpZA==
X-Received: from plbjz16.prod.google.com ([2002:a17:903:4310:b0:2ae:caac:985e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce08:b0:2ae:69d3:5b9f with SMTP id d9443c01a7336-2aecac3d018mr20770965ad.52.1773382389302;
 Thu, 12 Mar 2026 23:13:09 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:52 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2779;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=QMqLBWfipRQk2humW1I5jERFAazkEA548/OzFfNNg9I=; b=ZpxqH6lsLfyqCPHMBj39EaT5Wr/G0YsQVfYA2dBpQ+Jh+l1wbMHQyFZdFvAc9VJwqQog0+kd3
 01n2EBWt0LfBavEqyn/JEadsWWfbY187i7sB+gpT1ZPHGtcMzsug/Vd
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-13-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 13/43] KVM: selftests: Create gmem fd before "regular"
 fd when adding memslot
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

When adding a memslot associated a guest_memfd instance, create/dup the
guest_memfd before creating the "normal" backing file.  This will allow
dup'ing the gmem fd as the normal fd when guest_memfd supports mmap(),
i.e. to make guest_memfd the _only_ backing source for the memslot.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 45 +++++++++++++++---------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1959bf556e88e..610cb32ff207e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1061,6 +1061,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
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
@@ -1090,28 +1113,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
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
2.53.0.851.ga537e3e6e9-goog

