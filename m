Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0FE3845B9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382443; cv=none; b=YSUD52iiB0WoJF+aMzLNyte147jCAQ63pvi53JI78ZZYalyz/Fv3++gRF+vJtHsWeEAR3L+HuouqWLXImC6yz7OEXm+1ShnktFnc4TPK9fGEeHx/BnloOL+EhW4Buds5CIM9Sg3phPuk8DZ5oKjyRlTg2/C+iAJNswFIN8V0rGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382443; c=relaxed/simple;
	bh=PsXVR6/m97u9rpLVI044KHOk18BufZ3/bkmeJAuyM80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ofh/0TeNT5kx2mBf5C/M5IEXfyi0NaXoPiU02j47gFWBigj7wrAEQbTEbC0j59t5nJJRldSuDA/Qq6IbHcCfXuyTRW6SCaOOJifd8AdvpQd6k1UWluWzc5GwWBlEau9Qy5xmUbjzJLoMf1xpIqq7i5d1YsCaSTl1e/ax29z54KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eACnccFO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eACnccFO"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829942cf9deso1459896b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382433; x=1773987233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru4SOG48X5hnADT0eQPIQy13r0oyv8ixWqwkXqYhyy0=;
        b=eACnccFO/T6kJNzvM6HCM3qj08M2q65ZmvYnhWxX6ZeaqFb90Q9WQ/hlgFG0T6I+zp
         ic60R5rR+BFkVkk0Md4g8YTlKIEf5SSEiKAmU39CTp9gbyVniVIVa74rTasGPS/3iFXu
         Uz3AkDK2UqXOBENZt5uCEDPzwzHOJ63Yslc0/41DB9zDmcmMY3N02u6hQwLezEvjhGyR
         PXTy0u5m7Fxmu4ErUMmkk74qqk9eT3KCzqHHl5mx/s0ZmBkcJHvp2ff7mfsXsVtkg7wp
         qEkAIVhWdVAz3S0PLK4NaX6saC9IK6mp0Ea18cPF/gaqXFKFU92XIh21SU1Nd7ppb4IZ
         kiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382433; x=1773987233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru4SOG48X5hnADT0eQPIQy13r0oyv8ixWqwkXqYhyy0=;
        b=TXQU5LamPyx4tDiyeZgAFVf8boJwsjYlKMoPz6S+lUqpBG6P8j6tRcnh29qW1TK4N4
         +CH/WT1yJ+zgarEomDD2iKbIPDtX5tPHGdeACphhkL7qaAU1x5umN9SXzJAZiazXgqUZ
         PK3uJ5Wlft6OhqhGOQhKC6wiuc3cSONANcqgVUowWiV2qM3LVa/pnVP9kn9Tpara0Hc/
         9DfoT9H/Fxz4U/rqjHU+Jv6vgTEkVKWzdF7RI7Z1YfMfrfafDlVUE4e8fNT3R+rryM98
         23Z/Jt5UIEIAbih6yPUkVNlfYjeTZWQVnG7Hco1JfAJNmSi9vLh6gGMq76hguoLlWHOs
         DdOA==
X-Forwarded-Encrypted: i=1; AJvYcCVyL7Snf9redkPOUgbHfKwXxQheo03Wjea/voMVlbRsMMCEJpxYSiGYXZEm4fb0asNlVfOfsUDyeMCLV4EWxcyMz6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HfIYvB43VeFCQvk00WhUemVz74maTJbZVBtJFFGGkKTa87Gi
	YqOOBe2lsmSAwA0UE1E4Cr88Csc3UvWkgf4dmVnFTE+tcEkTDHGrxScp+2Mji25Bq+3g2lyMmQl
	W2JiVILrtc1c0pA5U7oKY1gXoHw==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:824:a502:8fea])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a113:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82a198ad1bcmr1863557b3a.43.1773382432573;
 Thu, 12 Mar 2026 23:13:52 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:18 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=7369;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=PsXVR6/m97u9rpLVI044KHOk18BufZ3/bkmeJAuyM80=; b=owLHrJvPH+l1S7PSWEo0c0posSa5NI9r+gR/dXJ1kxWlqXVcWCE3yqX5Fz/J11W0Cplhquj3O
 WVU750zLuu/BG4RBzBcDZY3JbDsFeKGGQXkwf3B0FdWOS3B1Id6bQKC
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-39-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 39/43] KVM: guest_memfd: Apply content modes while
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Provide defined memory content modes so that KVM can make guarantees about
memory content after setting memory attributes, according to userspace
requests.

Suggested-by: Sean Christoperson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 40 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       |  4 +++
 virt/kvm/guest_memfd.c         | 58 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 15148c80cfdb6..3ec92f8606099 100644
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
@@ -6619,6 +6621,44 @@ on the shared pages, such as refcounts taken by get_user_pages(), and
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
+  Zeroing is currently only guaranteed for private-to-shared
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
+TODO: Document CAP after CAP discussion.
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
index f23acbca28e54..6bfcb2ed12c61 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -674,8 +674,50 @@ int __weak kvm_arch_gmem_apply_content_mode_preserve(struct kvm *kvm,
 	return -EOPNOTSUPP;
 }
 
+static int kvm_gmem_apply_content_mode_folio(struct kvm *kvm,
+					     struct folio *folio,
+					     uint64_t content_mode)
+{
+	switch (content_mode) {
+	case KVM_SET_MEMORY_ATTRIBUTES2_MODE_UNSPECIFIED:
+		return kvm_arch_gmem_apply_content_mode_unspecified(kvm, folio);
+	case KVM_SET_MEMORY_ATTRIBUTES2_ZERO:
+		return kvm_arch_gmem_apply_content_mode_zero(kvm, folio);
+	case KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE:
+		return kvm_arch_gmem_apply_content_mode_preserve(kvm, folio);
+	default:
+		WARN_ONCE(1, "Unexpected policy requested.");
+		return -EOPNOTSUPP;
+	}
+}
+
+static void kvm_gmem_apply_content_mode(struct inode *inode, pgoff_t start,
+					pgoff_t end, struct kvm *kvm,
+					uint64_t content_mode)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct folio_batch fbatch;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(mapping, &start, end - 1, &fbatch)) {
+
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+			int ret;
+
+			ret = kvm_gmem_apply_content_mode_folio(kvm, folio,
+								content_mode);
+			WARN_ON_ONCE(ret);
+		}
+
+		folio_batch_release(&fbatch);
+	}
+}
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 				     size_t nr_pages, uint64_t attrs,
+				     struct kvm *kvm, uint64_t content_mode,
 				     pgoff_t *err_index)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -689,6 +731,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	filemap_invalidate_lock(mapping);
 
+	if (content_mode &&
+	    !(kvm_gmem_supported_content_modes(kvm) & content_mode)) {
+		r = -EOPNOTSUPP;
+		goto out;
+	}
+
 	mas_init(&mas, mt, start);
 
 	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs)) {
@@ -715,6 +763,8 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	kvm_gmem_invalidate_begin(inode, start, end);
 
+	kvm_gmem_apply_content_mode(inode, start, end, kvm, content_mode);
+
 	mas_store_prealloc(&mas, xa_mk_value(attrs));
 
 	kvm_gmem_invalidate_end(inode, start, end);
@@ -736,7 +786,11 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
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
@@ -758,7 +812,7 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
 	nr_pages = attrs.size >> PAGE_SHIFT;
 	index = attrs.offset >> PAGE_SHIFT;
 	r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
-				      &err_index);
+				      f->kvm, attrs.flags, &err_index);
 	if (r) {
 		attrs.error_offset = err_index << PAGE_SHIFT;
 

-- 
2.53.0.851.ga537e3e6e9-goog

