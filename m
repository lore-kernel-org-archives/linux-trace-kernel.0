Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E3391519
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563903; cv=none; b=eWb77zb3bxPvQRqzvqH2keO0hSER71Hqmoq9VTeg81gtvYlxkgh8jUc37SY/NdG2LdxbkJhO/UOCxOG/C7XkYvnRI/56fk3X+nqwV7BIzBAh6OdZePpFiLNr4qeT/zni3aXwjO/VQS6Hwz41HFn5/VL5nKZ2jel+2XnkNxu99N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563903; c=relaxed/simple;
	bh=0jjB+L00bmlKsXNHZVQZg/Gbh9xkSf09ciqRSU44Jrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tFqe1Vgaf7gjZQvR+rnbLeXCpAcN9grd6YB1niyDaeAXFzI+0k/EjRMGoZ1VuNZJkxF0Bcz2EijJdbxJlAVzJEyhDeV5Bs+fOpuKKdZd4D6//v90Vmi2QDu0hNNHWTRXBz5va9hWsR1FH2Zq8iWuXtIz19xIy/o01J6inc5DFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6zuOQhT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6zuOQhT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1051422a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563902; x=1775168702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=afYjOzvP16h/SfxvhTKPo6PFaH7oiLN+m8p/p0wfDgE=;
        b=M6zuOQhT3GQqMMaQ6XOdKNGfLUAYoeeIkpTBzkCGG2xbA/AT3PjIHrrnw1fyFXCi9Z
         9e3Yx7viyaV+PsDJ5xqB458/FqVErp79qZvcXwLGZ3s8lZAF9A0TomoTrc6+VZN+h+o/
         SWHSaM2wSup2VSQNjgjgFI3Wx209cYN0EDPpnUw8eT1fUZUrANDPhGBhC+ziSFP5/p+7
         ujVzQJVywLhuA2F6R4Lx2NX2gxnkaRcIXOD3lmzCJmDhLTsX5dKgedP9ioylpXzavrQe
         5vWWovsHQ0vlJp6SASLlkpEfKwpY5xN4CI7dg8yVXXa7RYgOegh0OHM12srg09wF+TYj
         ApZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563902; x=1775168702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afYjOzvP16h/SfxvhTKPo6PFaH7oiLN+m8p/p0wfDgE=;
        b=OAvPVPDgKzh0rBFHTCbxpQIeo4aoWbObkDmwW60GnmWn/0N8drdqYG8EP1mQzwGFys
         gcE7spLSCKtxHfAEt0xe1frJlEi3R5/egwn8YssW87NDCZGm1j3pLkXFUVE3/EORD9MB
         agb5cXURUo6TM+RNVx7q2PvMQhBKsvwkaL6dAN5KQTYNZlD22HXxvOxvMzo0wqlQ6mRy
         omwgh/hXW6AuAJzN8CWCJHNnQxqjixf0RIHgc+ZEdgQRdCvKVaxmG9h44r+owydGKIz+
         6Bq7feeJMnRBpG0xMfVqEOFX6qiJVOKrqIokZ/G2aO5oN/wrLpfCkbjrWDJi2D9j4ZO6
         ztMA==
X-Forwarded-Encrypted: i=1; AJvYcCUDHNFoC9Qs0caTzoFbCbuDNRw8W8GfzgZvFCKaLHFMU0Xzz1yNPYJl/omU6uRx+oDPG97NspBKa/QqzZ1XRZnmZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pXVhbj2DAdUJ+5nn5O1h8w6EerdmEXBKPm+mRkn8ckwNVxEP
	LF4ueyQWSv4vBvME8bHr7LSIs7wlQ3gQka9nNhIVlYskL7mxmte/HbnXIccFbxI9Zq0/1VxwcT3
	eOLKJASMw7Jl9idm3sTnUok8ZXA==
X-Received: from pgli25.prod.google.com ([2002:a63:1319:0:b0:c6e:1869:6f24])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9992:b0:398:a5c7:3dc9 with SMTP id adf61e73a8af0-39c87b6affdmr315892637.49.1774563901450;
 Thu, 26 Mar 2026 15:25:01 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:27 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2780;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7TZkUYE885M/wXgOBZe37BZPynsdjK5T8U6+o9woLC4=; b=314JAxzEs6WcJiM6YyGFVmcscyTLi7cuvImPq+mUF9Ii+v6RmtfL08R7F3Q+0ERv7vn2+MJyY
 FZVNih8negYDvxZ4BfDeQXb+WPayqddg+asn8A0sbOoVY9TrZpWfcM2
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-18-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 18/44] KVM: selftests: Create gmem fd before "regular"
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
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
2.53.0.1018.g2bb0e51243-goog

