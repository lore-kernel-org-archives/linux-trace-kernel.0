Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A448A2CE;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185369; cv=none; b=i9oqzMLIb1xhxRNDF6IJ0hwoPhS58FPmXlZil5JfkDbv2XwvXXo5yp7OETfPwkP30H1eqT2X8zRtl76FqQNtCPl0/W6rxTJuuiwQvfIzNRsdqlkf4y2EfumiREb+KZaJV2Ur5ES1k3rNyPQxtEe9nDj0Al4C3PKpQNrarG0FBcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185369; c=relaxed/simple;
	bh=f/bcYJTwgbDAuI7jR9WhLCEu5qS031PBn4FsUGZXOXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=se6nkVhvfybWETqWEKode0fvs7KVax2WRe+6GKzDfmAEK5+WciI7SRrm0yctPXzNyTeHZxVwoR+DgeWdyAOGTiApVvw48LHIkyKPX0gqR/zhVsbvaKKb/Q21GZGGFBzpoFuVoLKRj1n2crkjXECSkf6O7BwXvDTpsZW6ubnmK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX9G8dOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX9G8dOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F787C2BCF5;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185369;
	bh=f/bcYJTwgbDAuI7jR9WhLCEu5qS031PBn4FsUGZXOXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OX9G8dOZ8Jbjtr3MoMpuacsrJAPYKP4pv26wV5kzv5l9ZwYN2eJqv8WcGdouo+U1M
	 YG2WU+N8z7Z44W0xAxZVTrMYOO5cdRgSU94ooE2y3EOtIk00aqtjeEFG2RBN+HOcYU
	 OV9H/raQkJfs65By5YfEmwHVa479gYXbF/1vAG3UUc3tuVF2fvg5ZlQn+KvgeXgTCz
	 Sct++CIwp9i2x/6BN8ULHK7efSJd6eW9K+rimSTpysNVasseV0JpuS71PR2eQkl97p
	 qO61jc9YQep3xrCzT9v4AxiGDqKpIhoKbtA1CbuOPwOpfA7bHV8Bx+vntd+ggYwHrF
	 kF0zgJNR2Ch0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246DCD3446;
	Thu,  7 May 2026 20:22:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:29 -0700
Subject: [PATCH v6 10/43] KVM: guest_memfd: Add base support for
 KVM_SET_MEMORY_ATTRIBUTES2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-10-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, liam@infradead.org, 
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
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=7239;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=yy4WBFuoMngm7gvjvRx1ghfxP+yQbXxM2S4jDyo+4yI=;
 b=pSvJpt+Vxx/8iHDDd5qJ9SSDM1e0f/APvMZcbNULWtaJtMA7BA3lbJnaBeWpXl0oGltkE4uo6
 5OS9oUp2HhYCu5QimYBo7GQOSRQKjqwR+1S1VteuMXFeBYdGSplXpmG
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
just updates attributes tracked by guest_memfd.

Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
by making sure requested attributes are supported for this instance of kvm.

A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
details to userspace. This will be used in a later patch.

The two ioctls use their corresponding structs with no overlap, but
backward compatibility is baked in for future support of
KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
ioctl.

The process of setting memory attributes is set up such that the later half
will not fail due to allocation. Any necessary checks are performed before
the point of no return.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Co-developed-by: Sean Christoperson <seanjc@google.com>
Signed-off-by: Sean Christoperson <seanjc@google.com>
---
 include/uapi/linux/kvm.h |  13 ++++++
 virt/kvm/Kconfig         |   1 +
 virt/kvm/guest_memfd.c   | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  12 +++++
 4 files changed, 140 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf3..e6bbf68a83813 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1648,6 +1648,19 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	union {
+		__u64 address;
+		__u64 offset;
+	};
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 reserved[12];
+};
+
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
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
index 4f7c4824c3a45..91e89b188f583 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -540,11 +540,125 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_memory_attributes);
 
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
+	mas_set(mas, end);
+	entry = mas_find(mas, end);
+	if (entry && xa_to_value(entry) == attributes)
+		last = mas->last;
+
+	if (start > 0) {
+		mas_set(mas, start - 1);
+		entry = mas_find(mas, start - 1);
+		if (entry && xa_to_value(entry) == attributes)
+			start = mas->index;
+	}
+
+	mas_set_range(mas, start, last);
+	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
+}
+
+static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
+				     size_t nr_pages, uint64_t attrs)
+{
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
+	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
+	if (r)
+		goto out;
+
+	/*
+	 * From this point on guest_memfd has performed necessary
+	 * checks and can proceed to do guest-breaking changes.
+	 */
+
+	kvm_gmem_invalidate_begin(inode, start, end);
+	mas_store_prealloc(&mas, xa_mk_value(attrs));
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
+	size_t nr_pages;
+	pgoff_t index;
+	int i;
+
+	if (copy_from_user(&attrs, argp, sizeof(attrs)))
+		return -EFAULT;
+
+	if (attrs.flags)
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
+	if (attrs.offset >= i_size_read(inode) ||
+	    attrs.offset + attrs.size > i_size_read(inode))
+		return -EINVAL;
+
+	nr_pages = attrs.size >> PAGE_SHIFT;
+	index = attrs.offset >> PAGE_SHIFT;
+	return __kvm_gmem_set_attributes(inode, index, nr_pages,
+					 attrs.attributes);
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
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
 	.release	= kvm_gmem_release,
 	.fallocate	= kvm_gmem_fallocate,
+	.unlocked_ioctl	= kvm_gmem_ioctl,
 };
 
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ff20e63143642..4d7bf52b7b717 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -110,6 +110,18 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_TRAMP(__kvm_get_memory_attributes));
 #endif
 
+#define MEMORY_ATTRIBUTES_MATCH(one, two)				\
+	static_assert(offsetof(struct kvm_memory_attributes, one) ==	\
+		      offsetof(struct kvm_memory_attributes2, two));	\
+	static_assert(sizeof_field(struct kvm_memory_attributes, one) ==\
+		      sizeof_field(struct kvm_memory_attributes2, two))
+
+/* Ensure the common parts of the two structs are identical. */
+MEMORY_ATTRIBUTES_MATCH(address, address);
+MEMORY_ATTRIBUTES_MATCH(size, size);
+MEMORY_ATTRIBUTES_MATCH(attributes, attributes);
+MEMORY_ATTRIBUTES_MATCH(flags, flags);
+
 /*
  * Ordering of locks:
  *

-- 
2.54.0.563.g4f69b47b94-goog


