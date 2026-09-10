Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB913B27C6;
	Thu, 10 Sep 2026 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084538; cv=none; b=IyFexYozZ6NsWNJyxxN1O/Mw4UvxNMXHkNh0tOP/7dfz2pBc0IQFB+W42/O2G8lFRFqHWqW9uOlBDStPinNPK1nGxaosYz4r3Bktv+EGRLkfD/Sh4+3bPzG38qOMYvKZ+TrHzMRGuzHdnGmByKqT75PaETQIZZS7eCGY4I2S3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084538; c=relaxed/simple;
	bh=hbL6e23MivHLBA3qI7N5pZhF/az0b2+KjLphjqv8C2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uu4wvhhv0iEHd4Pf/IbwBnXe4p8b1q5/9GIdXjqyrQMCsnNTUhfIvmaOksK4HpL1OcoT8Qxzoh29ncdUUaPK5awsJHNFth1Rv6qq9+sW1indRjPFI17CELVD/4PnTR6e4YecA43mh7UO3XZYOKRVUEeu4ziVeeBWk1sn+gM0adY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3WFyrqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3WFyrqF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42F1C4AF10;
	Thu, 10 Sep 2026 23:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789084537;
	bh=hbL6e23MivHLBA3qI7N5pZhF/az0b2+KjLphjqv8C2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R3WFyrqFl2ZYfuq+yD55mnCIeB8PXqRnHUgHh5wdk7BIr6jGaOSuM23rociOxQ7nZ
	 jtkTbvfFMrthxJylX9JYiTk5QMqaGBMUQ/DZEUCDprOYLeE5YG0X8ajj+GiGazWr7J
	 oVzq7YHAZ8YYjyWwKj21luUw8NYjqVS7LcOM+bMUhh0r68QZ6eiOYLD39vdZquKd6C
	 7cbnQOOamqrQOIXAIh7LwsOuNnTtyTqXFu2yjrLONY2idBvMkgViWT2QyoTncjS4vi
	 Tfp+rHwn3KPr3BuDJJtYZ0HqszOkmIxwfvmOUOmX5OxyVkHOXOSS0SIqXFjc+4FHhI
	 pDMX/DEWavswQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA185C88E41;
	Thu, 10 Sep 2026 23:55:37 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 10 Sep 2026 16:55:38 -0700
Subject: [PATCH v13 12/44] KVM: guest_memfd: Always fault from guest_memfd
 if in-place conversion is enabled
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-gmem-inplace-conversion-v13-12-dd6fbf94f4e1@google.com>
References: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com>
In-Reply-To: <20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789084533; l=4606;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+WBdIWJC64hu8Hv2GEhpz7fsUgnbUjGHHH+Q9r+ACN4=;
 b=usjQGlypHSjCPwZTCoDIDlRGkN0v482L+z0wWA2+6lIPU5dTk9O03KS69230OC8njTRx9lUiY
 SH18HCX0W2IBGpCWM1wMQF93AhSh1p1qfzD7ctVmGfFjWTIhYMsV8lK
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

If a guest_memfd memslot is created but the guest_memfd does not have the
GUEST_MEMFD_FLAG_MMAP set, KVM still fulfils guest faults by looking up the
memslot's userspace_addr.

Set KVM_MEMSLOT_GMEM_ONLY if in-place conversion is enabled so that the
guest_memfd's memory will be used for both shared and private memory. With
in-place conversion, guest_memfd will be the only backing memory for the
memslot.

No validation is performed to require userspace_addr to be a mapping from
the associated guest_memfd because even after validation, userspace is free
to remap something else at the provided userspace_addr.

userspace_addr will still be used by functions like kvm_read_guest(), and
if userspace_addr does not match up with the corresponding memory in the
memslot's guest_memfd (whether userspace_addr points to the wrong offset or
some non-guest_memfd memory, etc), that is a user error.

Requiring both shared and private memory to come from the only associated
guest_memfd simplifies invalidation in stage 2 page tables. On a PUNCH_HOLE
operation on a guest_memfd, the invalidation is now guaranteed to be
invalidating only memory mapped from the given guest_memfd.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
---
 Documentation/virt/kvm/api.rst | 22 ++++++++++++++--------
 virt/kvm/guest_memfd.c         |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 09967e0308031..35d94c51cc56a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6381,10 +6381,16 @@ mapping for userspace_addr is not required to be valid/populated at the time of
 KVM_SET_USER_MEMORY_REGION2, e.g. shared memory can be lazily mapped/allocated
 on-demand.
 
-When mapping a gfn into the guest, KVM selects shared vs. private, i.e. consumes
-userspace_addr vs. guest_memfd, based on the state in guest_memfd, which is the
-sole authority on private vs. shared memory.  See :ref:`KVM_CREATE_GUEST_MEMFD`
-to find out more about the creation-time shared/private status.
+When mapping a gfn into the guest, guest faults are always serviced from
+guest_memfd regardless of whether memory is shared or private.  KVM determines
+shared vs. private based on the state in guest_memfd, which is the sole
+authority on private vs. shared memory.  See :ref:`KVM_CREATE_GUEST_MEMFD` to
+find out more about the creation-time shared/private status.
+
+userspace_addr is expected to be the mmap()-ed address corresponding to the
+right offset within the guest_memfd. Any mismatch between userspace_addr and
+guest_memfd is not validated and is a user error. userspace_addr is only used
+for host-side guest accesses such as kvm_read_guest().
 
 If in-place conversion is disabled, KVM selects shared vs. private based on the
 gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE state.  At VM creation time, all memory is
@@ -6490,10 +6496,10 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
                                page tables. Private memory cannot.
   ============================ ================================================
 
-When the KVM MMU performs a PFN lookup to service a guest fault and the backing
-guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always be
-consumed from guest_memfd, regardless of whether it is a shared or a private
-fault.
+When the KVM MMU performs a PFN lookup to service a guest fault, the fault will
+always be consumed from guest_memfd, regardless of whether it is a shared or a
+private fault (unless in-place conversion is disabled and the backing
+guest_memfd does not have the GUEST_MEMFD_FLAG_MMAP flag set).
 
 See KVM_SET_USER_MEMORY_REGION2 for additional details.
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 0afe1468d2d9d..e41802944756b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -746,7 +746,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
-	if (kvm_gmem_supports_mmap(inode))
+	if (gmem_in_place_conversion || kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
 	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);

-- 
2.55.0.1007.g17ff1f9808-goog


