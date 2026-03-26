Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B178375F8E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563889; cv=none; b=qmD2LByyn5ZwNc8oHLmNctrUGz7895dowDGy9k5HQAxrN+k9WNG7QHeRRwKGS1bSDpnsZEgXQYD3LWnbjDyN7Ba4/Yj+BVKUjgcIaJRN6rUPWNzAy42orFEs1esEbGlClOFfXiROae4E0+nKP14lW/sfwJksmzUa5I3SIllLI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563889; c=relaxed/simple;
	bh=9ixsRIaeC9vea9dnhRR9Gp60vmsiq3UD4+TPS2FFgGw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDmna30UNOXUPBw7BBZqWYwa4oCXkqUR0Y/9JxTdywj8lXgckJN7GMSa+JiLUEP/tOrctmCC4aQqTHW7jAj16GkBBMkJav2OjwT2IcSkRRJpE1j6u3uUuMEu2anqDXxuosTqis3wXB1309AR2sYt+w4j2/RT/DdeIrlqM4hlERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvJ9bdsx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvJ9bdsx"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c737b6686ddso1030776a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563885; x=1775168685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNz7dKp3qod8Iu2OS/CY/d/eVhoCNMajDkSF7493OBc=;
        b=JvJ9bdsxiEQkfS3B3SZSCu+xoWgtaHmROqulYQUxvi25StC1MUJUbaM5w3t35JekK1
         yTvi8iLrAMT5cn11sYG6dgefjHwxPRcrPGnARc09sPk5kFRtEWsX2dk9QZ65sVIllNgs
         ybB1n8Lu6T+BW//GyA6K84mRbDUANhjKWZ0OObfsnNmADkby1Pk0qKaAyNNYH1tRp8Vq
         Pb6PopqU1MxF+KKRO+xQTy57JdwtHNdAcBBeT4y1Ir7604vZ19Pr9s9czjbCMySJ6UiX
         SaPXPqTWsI64dK1q1F8OuycyqA9zhDTAROxdtx1RCLn6/V+Rc4/s+bJ7fY8LC+HLDtLf
         XR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563885; x=1775168685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNz7dKp3qod8Iu2OS/CY/d/eVhoCNMajDkSF7493OBc=;
        b=OM5vjKgvUwC0tWiC5qHMmR8SOZXB2mPPoe2mBzTh3hk8WZX+rQsXDZ6ptkXNIKhyCa
         GwAfl7BEsMjlOpdTbbuW5OCexFCejMzW4Kqef7mHwXOhXATVvznOzlLZcx8Jo96VukEp
         O9ZUu3gIO6rFhIfge36vspt+7Lqj3y6CM4vDq1FW9e8yM74DNDTjf8MxeNvV9XjSXyn0
         Qrtk2tU7qsWlypwiLheMXLr7fTJww2P/3+gCQ+WxCv/N/IFrUic/zsD+x5fwj9ywe1b7
         M1WbyUUqDiKbT8ZSJ7/rYYjqWOgsMe2OmWUWiWA76gqYq6VTbhk6Fxy7i021rp0S6MN4
         E03Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGSJnozR+yVxYr1DURZbtEbAt7IhByRwtWjvBU5mkqAdNJNKgp63g2lRZh68pQ/1o007S20ba1NBCb+dLupkYs6so=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXA1goWrvvsqOPHoSj7sofIhh2KEC6/lAHlUFsLus7+vYa8Biq
	tPwHEiZ7vnGMH24pNIv3XKVqWaXxJykOzzcf0VOlIWn94N6B7uLTMv1njkle44PPaDuWcxbcJDG
	wa49Z7487geb7KiSUeQ3PN2zF1w==
X-Received: from pfbig17.prod.google.com ([2002:a05:6a00:8b91:b0:7b0:bc2e:959b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4b12:b0:82a:8030:f574 with SMTP id d2e1a72fcca58-82c9605623dmr135288b3a.33.1774563884826;
 Thu, 26 Mar 2026 15:24:44 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:19 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=15781;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=9ixsRIaeC9vea9dnhRR9Gp60vmsiq3UD4+TPS2FFgGw=; b=sPWuy+R3a1t7m79dAJ8Gjh7qEWTks+CQpdvcIIbeFS6JR5Nko6LhtlHnopauaj4S6vicH4i/+
 BNzZoot3Wo3DVChCt4R5+ygp4SnrF1R73nQKNf30EpJff3nUhKr+FCA
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
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

For shared to private conversions, if refcounts on any of the folios
within the range are elevated, fail the conversion with -EAGAIN.

At the point of shared to private conversion, all folios in range are
also unmapped. The filemap_invalidate_lock() is held, so no faulting
can occur. Hence, from that point on, only transient refcounts can be
taken on the folios associated with that guest_memfd.

Hence, it is safe to do the conversion from shared to private.

After conversion is complete, refcounts may become elevated, but that
is fine since users of transient refcounts don't actually access
memory.

For private to shared conversions, there are no refcount checks, since
the guest is the only user of private pages, and guest_memfd will be the
only holder of refcounts on private pages.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst |  48 +++++++-
 include/linux/kvm_host.h       |  10 ++
 include/uapi/linux/kvm.h       |   9 +-
 virt/kvm/Kconfig               |   1 +
 virt/kvm/guest_memfd.c         | 245 ++++++++++++++++++++++++++++++++++++++---
 virt/kvm/kvm_main.c            |  17 ++-
 6 files changed, 300 insertions(+), 30 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 0b61e2579e1d8..15148c80cfdb6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -117,7 +117,7 @@ description:
       x86 includes both i386 and x86_64.
 
   Type:
-      system, vm, or vcpu.
+      system, vm, vcpu or guest_memfd.
 
   Parameters:
       what parameters are accepted by the ioctl.
@@ -6557,11 +6557,22 @@ KVM_S390_KEYOP_SSKE
 ---------------------------------
 
 :Capability: KVM_CAP_MEMORY_ATTRIBUTES2
-:Architectures: x86
-:Type: vm ioctl
+:Architectures: all
+:Type: vm, guest_memfd ioctl
 :Parameters: struct kvm_memory_attributes2 (in/out)
 :Returns: 0 on success, <0 on error
 
+Errors:
+
+  ========== ===============================================================
+  EINVAL     The specified `offset` or `size` were invalid (e.g. not
+             page aligned, causes an overflow, or size is zero).
+  EFAULT     The parameter address was invalid.
+  EAGAIN     Some page within requested range had unexpected refcounts. The
+             offset of the page will be returned in `error_offset`.
+  ENOMEM     Ran out of memory trying to track private/shared state
+  ========== ===============================================================
+
 KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
 KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
 userspace.  The original (pre-extension) fields are shared with
@@ -6572,15 +6583,42 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
 ::
 
   struct kvm_memory_attributes2 {
-	__u64 address;
+	/* in */
+	union {
+		__u64 address;
+		__u64 offset;
+	};
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[12];
+	/* out */
+	__u64 error_offset;
+	__u64 reserved[11];
   };
 
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
+Set attributes for a range of offsets within a guest_memfd to
+KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
+memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
+supported, after a successful call to set
+KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
+into host userspace and will only be mappable by the guest.
+
+To allow the range to be mappable into host userspace again, call
+KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
+KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
+
+If this ioctl returns -EAGAIN, the offset of the page with unexpected
+refcounts will be returned in `error_offset`. This can occur if there
+are transient refcounts on the pages, taken by other parts of the
+kernel.
+
+Userspace is expected to figure out how to remove all known refcounts
+on the shared pages, such as refcounts taken by get_user_pages(), and
+try the ioctl again. A possible source of these long term refcounts is
+if the guest_memfd memory was pinned in IOMMU page tables.
+
 See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
 
 .. _kvm_run:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 19f026f8de390..1ea14c66fc82e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2514,6 +2514,16 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 }
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+#ifdef kvm_arch_has_private_mem
+	if (!kvm || kvm_arch_has_private_mem(kvm))
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
+
+	return 0;
+}
+
 typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 16567d4a769e5..29baaa60de35a 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -990,6 +990,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_MEMORY_ATTRIBUTES2 248
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1642,11 +1643,15 @@ struct kvm_memory_attributes {
 #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
 
 struct kvm_memory_attributes2 {
-	__u64 address;
+	union {
+		__u64 address;
+		__u64 offset;
+	};
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[12];
+	__u64 error_offset;
+	__u64 reserved[11];
 };
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 3fea89c45cfb4..e371e079e2c50 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -109,6 +109,7 @@ config KVM_VM_MEMORY_ATTRIBUTES
 
 config KVM_GUEST_MEMFD
        select XARRAY_MULTI
+       select KVM_MEMORY_ATTRIBUTES
        bool
 
 config HAVE_KVM_ARCH_GMEM_PREPARE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d414ebfcb4c19..0cff9a85a4c53 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -183,10 +183,12 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 static enum kvm_gfn_range_filter kvm_gmem_get_invalidate_filter(struct inode *inode)
 {
-	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
-		return KVM_FILTER_SHARED;
-
-	return KVM_FILTER_PRIVATE;
+	/*
+	 * TODO: Limit invalidations based on the to-be-invalidated range, i.e.
+	 *       invalidate shared/private if and only if there can possibly be
+	 *       such mappings.
+	 */
+	return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
 }
 
 static void __kvm_gmem_invalidate_begin(struct gmem_file *f, pgoff_t start,
@@ -552,11 +554,235 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_memory_attributes);
 
+static bool kvm_gmem_range_has_attributes(struct maple_tree *mt,
+					  pgoff_t index, size_t nr_pages,
+					  u64 attributes)
+{
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	lockdep_assert(mt_lock_is_held(mt));
+
+	mt_for_each(mt, entry, index, end) {
+		if (xa_to_value(entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
+static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
+					    size_t nr_pages, pgoff_t *err_index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	const int filemap_get_folios_refcount = 1;
+	pgoff_t last = start + nr_pages - 1;
+	struct folio_batch fbatch;
+	bool safe = true;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (safe && filemap_get_folios(mapping, &start, last, &fbatch)) {
+
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+
+			if (folio_ref_count(folio) !=
+			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
+				safe = false;
+				*err_index = folio->index;
+				break;
+			}
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return safe;
+}
+
+/*
+ * Preallocate memory for attributes to be stored on a maple tree, pointed to
+ * by mas.  Adjacent ranges with attributes identical to the new attributes
+ * will be merged.  Also sets mas's bounds up for storing attributes.
+ *
+ * This maintains the invariant that ranges with the same attributes will
+ * always be merged.
+ */
+static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
+				    pgoff_t start, size_t nr_pages)
+{
+	pgoff_t end = start + nr_pages;
+	pgoff_t last = end - 1;
+	void *entry;
+
+	/* Try extending range. entry is NULL on overflow/wrap-around. */
+	mas_set_range(mas, end, end);
+	entry = mas_find(mas, end);
+	if (entry && xa_to_value(entry) == attributes)
+		last = mas->last;
+
+	if (start > 0) {
+		mas_set_range(mas, start - 1, start - 1);
+		entry = mas_find(mas, start - 1);
+		if (entry && xa_to_value(entry) == attributes)
+			start = mas->index;
+	}
+
+	mas_set_range(mas, start, last);
+	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
+}
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct folio_batch fbatch;
+	pgoff_t next = start;
+	int i;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+			unsigned long pfn = folio_pfn(folio);
+
+			kvm_arch_gmem_invalidate(pfn, pfn + folio_nr_pages(folio));
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+}
+#else
+static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
+#endif
+
+static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
+				     size_t nr_pages, uint64_t attrs,
+				     pgoff_t *err_index)
+{
+	bool to_private = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	struct address_space *mapping = inode->i_mapping;
+	struct gmem_inode *gi = GMEM_I(inode);
+	pgoff_t end = start + nr_pages;
+	struct maple_tree *mt;
+	struct ma_state mas;
+	int r;
+
+	mt = &gi->attributes;
+
+	filemap_invalidate_lock(mapping);
+
+	mas_init(&mas, mt, start);
+
+	if (kvm_gmem_range_has_attributes(mt, start, nr_pages, attrs)) {
+		r = 0;
+		goto out;
+	}
+
+	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
+	if (r) {
+		*err_index = start;
+		goto out;
+	}
+
+	if (to_private) {
+		unmap_mapping_pages(mapping, start, nr_pages, false);
+
+		if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
+						     err_index)) {
+			mas_destroy(&mas);
+			r = -EAGAIN;
+			goto out;
+		}
+	}
+
+	/*
+	 * From this point on guest_memfd has performed necessary
+	 * checks and can proceed to do guest-breaking changes.
+	 */
+
+	kvm_gmem_invalidate_begin(inode, start, end);
+
+	if (!to_private)
+		kvm_gmem_invalidate(inode, start, end);
+
+	mas_store_prealloc(&mas, xa_mk_value(attrs));
+
+	kvm_gmem_invalidate_end(inode, start, end);
+out:
+	filemap_invalidate_unlock(mapping);
+	return r;
+}
+
+static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
+{
+	struct gmem_file *f = file->private_data;
+	struct inode *inode = file_inode(file);
+	struct kvm_memory_attributes2 attrs;
+	pgoff_t err_index;
+	size_t nr_pages;
+	pgoff_t index;
+	int i, r;
+
+	if (copy_from_user(&attrs, argp, sizeof(attrs)))
+		return -EFAULT;
+
+	if (attrs.flags)
+		return -EINVAL;
+	if (attrs.error_offset)
+		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(attrs.reserved); i++) {
+		if (attrs.reserved[i])
+			return -EINVAL;
+	}
+	if (attrs.attributes & ~kvm_supported_mem_attributes(f->kvm))
+		return -EINVAL;
+	if (attrs.size == 0 || attrs.offset + attrs.size < attrs.offset)
+		return -EINVAL;
+	if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.size))
+		return -EINVAL;
+
+	if (attrs.offset >= inode->i_size ||
+	    attrs.offset + attrs.size > inode->i_size)
+		return -EINVAL;
+
+	nr_pages = attrs.size >> PAGE_SHIFT;
+	index = attrs.offset >> PAGE_SHIFT;
+	r = __kvm_gmem_set_attributes(inode, index, nr_pages, attrs.attributes,
+				      &err_index);
+	if (r) {
+		attrs.error_offset = ((uint64_t)err_index) << PAGE_SHIFT;
+
+		if (copy_to_user(argp, &attrs, sizeof(attrs)))
+			return -EFAULT;
+	}
+
+	return r;
+}
+
+static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
+			   unsigned long arg)
+{
+	switch (ioctl) {
+	case KVM_SET_MEMORY_ATTRIBUTES2:
+		if (vm_memory_attributes)
+			return -ENOTTY;
+
+		return kvm_gmem_set_attributes(file, (void __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
+	.unlocked_ioctl	= kvm_gmem_ioctl,
 };
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -942,20 +1168,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
 				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
 {
-	pgoff_t end = index + nr_pages - 1;
-	void *entry;
-
 	if (vm_memory_attributes)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
 						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
-	mt_for_each(&gi->attributes, entry, index, end) {
-		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
-			return false;
-	}
-
-	return true;
+	return kvm_gmem_range_has_attributes(&gi->attributes, index, nr_pages,
+					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
 
 static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3c261904322f0..85c14197587d4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2435,16 +2435,6 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
-static u64 kvm_supported_mem_attributes(struct kvm *kvm)
-{
-#ifdef kvm_arch_has_private_mem
-	if (!kvm || kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
-#endif
-
-	return 0;
-}
-
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
@@ -2635,6 +2625,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 		return -EINVAL;
 	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
 		return -EINVAL;
+	if (attrs->error_offset)
+		return -EINVAL;
 	for (i = 0; i < ARRAY_SIZE(attrs->reserved); i++) {
 		if (attrs->reserved[i])
 			return -EINVAL;
@@ -4983,6 +4975,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		return 1;
 	case KVM_CAP_GUEST_MEMFD_FLAGS:
 		return kvm_gmem_get_supported_flags(kvm);
+	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
+		if (vm_memory_attributes)
+			return 0;
+
+		return kvm_supported_mem_attributes(kvm);
 #endif
 	default:
 		break;

-- 
2.53.0.1018.g2bb0e51243-goog

