Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266753822B3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563894; cv=none; b=sN61xD/DaybEuotN9mMD8dD0hde02RmzC10DdWAv1I16xAS1MvkeWKDRZQOQkOlZSi5mw5s/BEdon7iwWAX8RbPR/YG2H6xusRiK5t8dAOE24Q6gNnlZ+zMznUJSlx9qj/pRQbu2nLPkgPPnm5y7lQGwAMO94e1hSFlZy1NxjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563894; c=relaxed/simple;
	bh=eaxuIPrrRTVlEIpTTwJih/3FgUZ9QiOBP/yNtBEER/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dncsdAwH8ukn0rzsrHP5ncUkHFD1eKT+8Ly/64M2Ue28QVFjRIziihHZ2HFvDsfE4GJ+kjrts8D1Kypvv9qhu+Xb9aGd6nBlSTTBVlqsK4sAzxTdtZL5sFqQl9PXuwgQTvaQ6bNEgIAZ661bpvBd6ofPzO7QqOcnQDBu747MBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buJq/DAC; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buJq/DAC"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c83bd48afso628234b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563891; x=1775168691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRjeBkkI/dZyZ5QjbTq8w6K/fHOt1rR7cB2loz7QmY4=;
        b=buJq/DACEwwoS8nsqsrOxmNPMMIjskIaYfYzIpgAyf0PxXmMsiLD82c6U1Dj0u9z+R
         cvD7aD9sxuwbZ3Zu4ZWT+Au82gN+WI6DrT69Zu0MRYr7NEg4cwvGcg8qQLPYg8+RM/1g
         tdtxRrB+w0aTOlv5FRdTLUo79g5P6+ZwB+Vvx3Crs5he3lVNAZbxjVhhK2qXxD3PzP1e
         nEcPQvnvui84HaAeWr7EOZex/8I9FN7obuDp/XKAEjivOUV41cQOhIfJkHCBG5FViSV6
         IpVflg00XBU3ref69sQ/nKtKhZNPrpj5WCTqCu6RMFe6DK1UwTvR3GXx16PWcJA4/DaH
         jsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563891; x=1775168691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRjeBkkI/dZyZ5QjbTq8w6K/fHOt1rR7cB2loz7QmY4=;
        b=cDyjzNb+/caQKzC89yQANUgK5MR1adMXW/SWm/76YO4U1Wchcb5wxFrR68if1vHFdY
         5LfJEtlMRINxLjQv+i4WsSFMWZuSrTRFrYVgZ7Ld+pyBSf7Btgtq7lp0xay2C7jlZR3O
         c48EX6jPTCQPNfxriOpN/tKpKoWhCh7Wl42sivro1qDS30ZlyU/x5fLj3wfAEn3oZmaW
         P6TOEI/0XRqNVbuIekdr8NI1nN3tnZ17YohdVgQ+3ZWbrytzGdzMsI2GgfsD6BIpJU11
         S4OgzxDvxxtxOqU89zSHpv6H2LvP4RYlRAUbxkPRwl5FLmMIw6ldLa4mzqpmOpGYcPvP
         EsDw==
X-Forwarded-Encrypted: i=1; AJvYcCXCGjE4bP7p4UHtNYE4Om2bs72k5ySxIiRjzY/kfwH6n9l3y2JIQNzHFWTgIyyZ29dyhnK4Q1U5hKz/h4GKv9r9eHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuptsDAog4bB2OwD7XJ8HCg8b5VOdjYc42r5Itb3yElTa6AasF
	EU79O906rcQoyf7bm+tZfD5u9c7dU4YnCCZpQEuzEvG1JqB2p2yQNqC45q7XR4+uH20KBqmjI9f
	vWsMFxQHPVn0D9Fj2BuqP5nhqdw==
X-Received: from pfbif3.prod.google.com ([2002:a05:6a00:8b03:b0:82c:2477:2e24])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:c82:b0:827:2ed6:888f with SMTP id d2e1a72fcca58-82c96035be6mr118926b3a.54.1774563890837;
 Thu, 26 Mar 2026 15:24:50 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:22 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=8571;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=eaxuIPrrRTVlEIpTTwJih/3FgUZ9QiOBP/yNtBEER/o=; b=K13+dJQF86Un8WqHDlu2mJRGc8cKb+wpv2mI96f+F2KmJrbn1NkIqQIwXR4TQX2NsGMI5IGiJ
 7CZ1Zrr9V8EDdHQVj3N94MUmpF4t1bK7IW1kpMbQXoeLH/p6zBbG6ha
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-13-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 13/44] KVM: guest_memfd: Apply content modes while
 setting memory attributes
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

Provide defined memory content modes so that KVM can make guarantees about
memory content after setting memory attributes, according to userspace
requests.

Suggested-by: Sean Christoperson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  4 +++
 virt/kvm/guest_memfd.c         | 56 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 119 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 15148c80cfdb6..90587a9c09d3f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6571,6 +6571,8 @@ Errors:
   EAGAIN     Some page within requested range had unexpected refcounts. The
              offset of the page will be returned in `error_offset`.
   ENOMEM     Ran out of memory trying to track private/shared state
+  EOPNOTSUPP There is no way for KVM to guarantee in-memory contents as
+             requested.
   ========== ===============================================================
 
 KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
@@ -6619,6 +6621,65 @@ on the shared pages, such as refcounts taken by get_user_pages(), and
 try the ioctl again. A possible source of these long term refcounts is
 if the guest_memfd memory was pinned in IOMMU page tables.
 
+By default, KVM makes no guarantees about the in-memory values after
+memory is convert to/from shared/private.  Optionally, userspace may
+instruct KVM to ensure the contents of memory are zeroed or preserved,
+e.g. to enable in-place sharing of data, or as an optimization to
+avoid having to re-zero memory when userspace could have relied on the
+trusted entity to guarantee the memory will be zeroed as part of the
+entire conversion process.
+
+The content modes available are as follows:
+
+``KVM_SET_MEMORY_ATTRIBUTES2_ZERO``
+
+  On conversion, KVM guarantees all entities that have "allowed"
+  access to the memory will read zeros.  E.g. on private to shared
+  conversion, both trusted and untrusted code will read zeros.
+
+  Zeroing is currently only supported for private-to-shared
+  conversions, as KVM in general is untrusted and thus cannot
+  guarantee the guest (or any trusted entity) will read zeros after
+  conversion.  Note, some CoCo implementations do zero memory contents
+  such that the guest reads zeros after conversion, and the guest may
+  choose to rely on that behavior.  However, that's a contract between
+  the trusted CoCo entity and the guest, not between KVM and the
+  guest.
+
+``KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE``
+
+  On conversion, KVM guarantees memory contents will be preserved with
+  respect to the last written unencrypted value.  As a concrete
+  example, if the host writes ``0xbeef`` to shared memory and converts
+  the memory to private, the guest will also read ``0xbeef``, even if
+  the in-memory data is encrypted as part of the conversion.  And vice
+  versa, if the guest writes ``0xbeef`` to private memory and then
+  converts the memory to shared, the host (and guest) will read
+  ``0xbeef`` (if the memory is accessible).
+
+Note: These content modes apply to the entire requested range, not
+just the parts of the range that underwent conversion. For example, if
+this was the initial state:
+
+  * [0x0000, 0x1000): shared
+  * [0x1000, 0x2000): private
+  * [0x2000, 0x3000): shared
+
+and range [0x0000, 0x3000) was set to shared, the content mode would
+apply to all memory in [0x0000, 0x3000), not just the range that
+underwent conversion [0x1000, 0x2000).
+
+Note: These content modes apply only to allocated memory. No
+guarantees are made on offset ranges that do not have memory allocated
+(yet). For example, if this was the initial state:
+
+  * [0x0000, 0x1000): shared
+  * [0x1000, 0x2000): not allocated
+  * [0x2000, 0x3000): shared
+
+and range [0x0000, 0x3000) was set to shared, the content mode would
+apply to only to offset ranges [0x0000, 0x1000) and [0x2000, 0x3000).
+
 See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
 
 .. _kvm_run:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 29baaa60de35a..0fc9ad4ea0d93 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1642,6 +1642,10 @@ struct kvm_memory_attributes {
 /* Available with KVM_CAP_MEMORY_ATTRIBUTES2 */
 #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
 
+#define KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED	0
+#define KVM_SET_MEMORY_ATTRIBUTES2_ZERO		(1ULL << 0)
+#define KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE	(1ULL << 1)
+
 struct kvm_memory_attributes2 {
 	union {
 		__u64 address;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index e270e54e030f0..eeac7678fcf4e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -677,6 +677,19 @@ u64 __weak kvm_arch_gmem_supported_content_modes(struct kvm *kvm)
 	return 0;
 }
 
+static bool kvm_gmem_content_mode_is_supported(struct kvm *kvm,
+					       u64 content_mode,
+					       bool to_private)
+{
+	if (content_mode == KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED)
+		return true;
+
+	if (content_mode == KVM_SET_MEMORY_ATTRIBUTES2_ZERO && to_private)
+		return false;
+
+	return kvm_arch_gmem_supported_content_modes(kvm) & content_mode;
+}
+
 int kvm_gmem_apply_content_mode_zero(struct inode *inode, pgoff_t start,
 				     pgoff_t end)
 {
@@ -736,8 +749,26 @@ int __weak kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
 	return -EOPNOTSUPP;
 }
 
+static int kvm_gmem_apply_content_mode(struct kvm *kvm, uint64_t content_mode,
+				       struct inode *inode, pgoff_t start,
+				       pgoff_t end)
+{
+	switch (content_mode) {
+	case KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED:
+		return kvm_arch_gmem_apply_content_mode_unspecified(kvm, inode, start, end);
+	case KVM_SET_MEMORY_ATTRIBUTES2_ZERO:
+		return kvm_arch_gmem_apply_content_mode_zero(kvm, inode, start, end);
+	case KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE:
+		return kvm_arch_gmem_apply_content_mode_preserve(kvm, inode, start, end);
+	default:
+		WARN_ONCE(1, "Unexpected policy requested.");
+		return -EOPNOTSUPP;
+	}
+}
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 				     size_t nr_pages, uint64_t attrs,
+				     struct kvm *kvm, uint64_t content_mode,
 				     pgoff_t *err_index)
 {
 	bool to_private = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
@@ -752,9 +783,23 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	filemap_invalidate_lock(mapping);
 
+	if (!kvm_gmem_content_mode_is_supported(kvm, content_mode,
+						to_private)) {
+		r = -EOPNOTSUPP;
+		*err_index = start;
+		goto out;
+	}
+
 	mas_init(&mas, mt, start);
 
 	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs)) {
+		/*
+		 * Even if no update is required to attributes, the
+		 * requested content mode is applied.
+		 */
+		WARN_ON(kvm_gmem_apply_content_mode(kvm, content_mode,
+						    inode, start, end));
+
 		r = 0;
 		goto out;
 	}
@@ -786,6 +831,9 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	if (!to_private)
 		kvm_gmem_invalidate(inode, start, end);
 
+	WARN_ON(kvm_gmem_apply_content_mode(kvm, content_mode, inode,
+					    start, end));
+
 	mas_store_prealloc(&mas, xa_mk_value(attrs));
 
 	kvm_gmem_invalidate_end(inode, start, end);
@@ -807,7 +855,11 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
 	if (copy_from_user(&attrs, argp, sizeof(attrs)))
 		return -EFAULT;
 
-	if (attrs.flags)
+	if (attrs.flags & ~(KVM_SET_MEMORY_ATTRIBUTES2_ZERO |
+			    KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE))
+		return -EINVAL;
+	if ((attrs.flags & KVM_SET_MEMORY_ATTRIBUTES2_ZERO) &&
+	    (attrs.flags & KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE))
 		return -EINVAL;
 	if (attrs.error_offset)
 		return -EINVAL;
@@ -829,7 +881,7 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
 	nr_pages = attrs.size >> PAGE_SHIFT;
 	index = attrs.offset >> PAGE_SHIFT;
 	r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
-				      &err_index);
+				      f->kvm, attrs.flags, &err_index);
 	if (r) {
 		attrs.error_offset = ((uint64_t)err_index) << PAGE_SHIFT;
 

-- 
2.53.0.1018.g2bb0e51243-goog

