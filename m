Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804B31E828
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771201; cv=none; b=hfXhSvhYyFRtgAO8HwKzvkMbS8ad+oPyPeuhl+fZLNXOmfsP78nXz+5+qW+P/qO/ExVwloEDtjn63BubEJjt9EAj2Uzvd0+sUpDn6RZAeVst6Z/v4Ob9MEFk6SU7aBTqnR387cPL0D/RgAP7AMDQM0aG08Plw4QSrM8f5BNLjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771201; c=relaxed/simple;
	bh=C/XKI47pVb+/uzP4EF5dInlZPLt+EXLYsPrxDNx6SJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W+HSv/BM4cTEe3wnKCpRYIa10PM9fbC8qrv0bhIrguF68TCTnSkbQQYEq/rfIBO4W+OccTV8G1QahGKvzutCF+jZfOYz76/nn4ZRSDo+eJPoLyqTemxhnana3CGcH6xTZScqk8TxBT2aVamA2nVz9G9iDYSZZ8aqHUjH7arhqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUlEvZhK; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUlEvZhK"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e375d9736so5356631b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Aug 2026 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785771196; x=1786375996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtEGWO1V/3oKubYEJFYO8Yg77TA8PdsLMD6iXufqvFE=;
        b=OUlEvZhK0wxaPbr/ci7nJY7xUSwtInD/Wm6f1WlpDCfY58SLOmRmdku0eybpR4ihAC
         HvGNBZoBp3oZOSNRmRpOqcknfDq4+QmnXE33/+u2tIEy/pJnPVjAQSbmDQMmrdu+Vt61
         zfNh21rhFsKMnH4d3vkluue7Mh3a4sQx/Jqe7TXkMyJzRqzQIkqNYZYiePvViSEltZ0Z
         50VKQCY/6W4tpo67NCXnU0xdvxZ1KtP4JqWZNJjq4Eiay2puCTE85zh22i7IYkuedd8r
         G0SFWC2KMEWBoB4Np/hKWNHsLf9sGdj/Zf7DB1vWBUNus388fOsL5muS1aGil7sxnjvr
         mSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785771196; x=1786375996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtEGWO1V/3oKubYEJFYO8Yg77TA8PdsLMD6iXufqvFE=;
        b=NWG8t7WtahmmSW7SEAKmBr50Hq/hqM1Mi0zCUjWKbmaV5Cu36MyoAE0KSjIz5X2Kck
         EtStz07br1m9MIHmGZTjgqo8Hw5Ek7QrbVXWW4vZh0zCzmnmKxnrQntG656CYcsCUY6V
         i4sQBXb2W9rBQU9PFSMy37wSsjig3xyyKDiPdRg/ZlO4wddVONrGEkB2YnX5h1nJEc9f
         jCo5mTEwn7v9oZ3F4DB9lp6WyXl0sycywjhcHXa9oFZmSyIIm4eYQNIHhll/s3WuMusU
         DGBvBBcEylG0OyFQ+C9bzF+1Y4K1uk0B0CDXFbe8a+A2RPVH/AS8W6Pw/9Af/PyiZjzI
         J4Bw==
X-Forwarded-Encrypted: i=1; AHgh+Rqz7Wx1YOaWjVCzRY7plOLpUKv5VYcu8pxduSMq1ErM3Gs7Hf/ScaCTgxR3jSlDLdAg2mELIAlF+u8bpQ+UvB1DB0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgAIs6dVsoc6YUUrar8MxELn/+r8KmeN5a0vlFFaUSEQBbZYO
	QcWhOZ0+MAlwieU20ZnX43o9IIkxUc8H7c/yMYCEBiECv9GqEKdQwhVmeDew0Am0EUvlSV8hhtC
	AsYWzpg==
X-Received: from pfbhw1.prod.google.com ([2002:a05:6a00:8901:b0:848:46e6:1aac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4613:b0:848:3fe2:c88b
 with SMTP id d2e1a72fcca58-84ee477539amr8885723b3a.6.1785771194900; Mon, 03
 Aug 2026 08:33:14 -0700 (PDT)
Date: Mon, 3 Aug 2026 08:33:14 -0700
In-Reply-To: <25ab36cf-888a-4547-b3f7-5bd4e057c1d0@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-7-35f9aec2aed2@google.com>
 <60d19013-d6d7-4eec-827a-2622e22cec98@intel.com> <CAEvNRgF0SxmoMtqq69tUih54A9K7j_wcMFRrq=r9w6TnAGAUQQ@mail.gmail.com>
 <dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com> <amzMtg4K6qEEsudx@google.com>
 <25ab36cf-888a-4547-b3f7-5bd4e057c1d0@intel.com>
Message-ID: <anC0uuZIrbxlGubN@google.com>
Subject: Re: [PATCH v9 07/41] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: multipart/mixed; charset="UTF-8"; boundary="t+KByEqIRolqunqf"


--t+KByEqIRolqunqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026, Xiaoyao Li wrote:
> On 8/1/2026 12:26 AM, Sean Christopherson wrote:
> > On Fri, Jul 31, 2026, Xiaoyao Li wrote:
> > > On 7/31/2026 4:42 AM, Ackerley Tng wrote:
> > > If kvm_range_is_private() is useful/required by huge page support, then let
> > > the huge page series to introduce it. It has nothing to do with the in-place
> > > conversion series.
> > 
> > If it weren't for the fact that the range-based search is used later in this
> > series, I would 100% agree with Xiaoyao.
> > But since the core logic is used and needed elsewhere,
> 
> I don't see it a problem. Without introducing kvm_range_is_private() in this
> patch, the core logic of range-based search on gmem can still be introduced
> as kvm_gmem_range_has_attributes() directly in patch 10 or in a separate
> patch.
> 
> > and because kvm_range_has_vm_memory_attributes() takes a range, my vote is
> > to provide the plumbing now, even though a small portion of it isn't
> > strictly necessary.
> 
> So my initial feedback was "we can just use kvm_mem_is_private(kvm, gfn)".
> It makes code simpler.

My apologies, I hadn't actually applied v9 to look at the full context.  I agree,
providing kvm_range_is_private() is completely unnecessary.  It's not even really
a problem with this patch, it's a pre-existing issue that can and should be
addressed with a prep patch.

> And as a bonus, the logic to choose between gmem-based attribute query and
> vm-based attribute query is hidden from the static call.

I don't follow.  What do you mean by "hidden from the static call?"  The whole
point of using a static call is to select between gmem-based and vm-based private
memory.  Or are you saying the populate() flow doesn't need to manually check
gmem_in_place_conversion?

> The second bonus of dropping kvm_range_is_private() is that we can eliminate
> one more chunk in patch 20.

Ya.

Untested, but unless I'm missing something, patches 6 and 7 of this series can
be replaced with the attached patches (6 and 7 should be squashed together no
matter what).

--t+KByEqIRolqunqf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-KVM-guest_memfd-Use-kvm_mem_is_private-when-populati.patch

From 77bd0524535d65d7c6beb4a0cc70a65fbacc9f81 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 3 Aug 2026 08:10:09 -0700
Subject: [PATCH 1/2] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory

Using kvm_mem_is_private() when populating guest_memfd instead of using an
open coded equivalent.  In addition to simplifying the populate code *now*,
this avoids the need to provide a range-based gmem lookup API in the future
as well.

No functional change intended.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_memfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 8c7709a352cc..48c13d18af15 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -881,9 +881,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	folio_unlock(folio);
 
-	if (!kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + 1,
-						KVM_MEMORY_ATTRIBUTE_PRIVATE,
-						KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+	if (!kvm_mem_is_private(kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
 	}

base-commit: 17548ee538ef4f476e16fb5dd3ca8adfd8a852ed
-- 
2.55.0.508.g3f0d502094-goog


--t+KByEqIRolqunqf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename=0002-KVM-guest_memfd-Stub-in-ability-to-enable-in-place-s.patch

From 02db86dc193d969085bbc0c98c6117e59d469cb5 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 3 Aug 2026 08:17:34 -0700
Subject: [PATCH 2/2] KVM: guest_memfd: Stub in ability to enable in-place
 shared<=>private conversion

Stub in global variable to enable in-place guest_memfd private<=>shared
memory conversion, which will eventually be exposed to userspace via a
module param, and wire up the __kvm_mem_is_private() static call to the
guest_memfd version when in-place conversion is enabled, i.e. when gmem is
the sole authority on private vs. shared memory.

Cc: Fuad Tabba <tabba@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  6 ++++++
 virt/kvm/guest_memfd.c   | 26 ++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      | 12 +++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 65fbce46b63f..9477ecebbbce 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2580,6 +2580,8 @@ static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef kvm_arch_has_private_mem
+extern bool gmem_in_place_conversion;
+
 typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
 
@@ -2588,6 +2590,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 	return static_call(__kvm_mem_is_private)(kvm, gfn);
 }
 #else
+#define gmem_in_place_conversion false
+
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
@@ -2595,6 +2599,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif /* kvm_arch_has_private_mem */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
+bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
+
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
 		     int *max_order);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 48c13d18af15..e21c7122539a 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -474,6 +474,32 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	struct inode *inode;
+
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	/*
+	 * Rely on the maple tree's internal RCU lock to ensure a stable result.
+	 * This result can become stale as soon as the lock is dropped, so the
+	 * caller _must_ protect consumption of private vs. shared either by
+	 * holding guest_memfd's invalidate lock for the entire duration, or by
+	 * checking mmu_invalidate_retry_gfn() under mmu_lock to serialize
+	 * against concurrent attribute updates.
+	 */
+	return kvm_gmem_is_private_mem(inode, kvm_gmem_get_index(slot, gfn));
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 081e3309359d..e5654baa8895 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -101,6 +101,10 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+#ifdef kvm_arch_has_private_mem
+bool __ro_after_init gmem_in_place_conversion = false;
+#endif
+
 /*
  * Ordering of locks:
  *
@@ -2422,6 +2426,9 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 static u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
 #ifdef kvm_arch_has_private_mem
+	if (gmem_in_place_conversion)
+		return 0;
+
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
 #endif
@@ -2633,8 +2640,11 @@ EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
 
 static void kvm_init_memory_attributes(void)
 {
+	if (gmem_in_place_conversion)
+		static_call_update(__kvm_mem_is_private, kvm_gmem_is_private);
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-	static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
+	else
+		static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
 #endif
 }
 #else
-- 
2.55.0.508.g3f0d502094-goog


--t+KByEqIRolqunqf--
