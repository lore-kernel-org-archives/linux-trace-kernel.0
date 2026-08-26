Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB4C3C1414
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735915; cv=none; b=M3QLhXyqgxpXB61saneAj4T5ZOH7Lo+Fkz0wtX2KigEMwHGVqRJDUSir6nk815p25rgfX21glX4NNOwAnbJh4mf/6cWKEDJpks5zHAO01L3XMyzfCRxSjqH8/Dw9MdZ2xSvASJPF7r/NAVRC8z0w4oRTE7n/9PDhrUyCVFmBFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735915; c=relaxed/simple;
	bh=+ysynpwUlV0mE4GyFNOI2YE86y5cHwtUdkUTLphgh10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7FK9P932BUJPi6CuRODCOv0K03jRBuCv5J46/M09EqvEXDNYaxd6htNHRNXOxTLYXkZFkX70SLzdptXqwxv1Uwro2AoViLEzvBxAwzDg7HscJhrB4tVhPNZngjsQa6iuQLbTF6eORvk83hLSYMKSai8dpeSr954gine9QxlRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUcgvBy5; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUcgvBy5"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc73f47bdcso10161185ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735912; x=1788340712; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJVghZcwIpdjw9VQGaPwDVy8Initc7amwnDZFFILhVg=;
        b=lUcgvBy5N9s9Svq9h+bw86bu/6lC1COr8CB8TnKWp+suYcqeeKPmnnjt4J3/z+oH4U
         31Ph+Wetm2rba/0yjGNefAQphZOxcMhrhIaR9iEoI9DTXOpEwh3EFxTaMfdWx87OdtGO
         +forQshUt8/KCvmVHW5wTjJWpIV4tMVqOyynNpycIpefPc+Faa7jpNFZw5oYUtnfiH0x
         hehoHyT7ovzTYbWMHCRXLQ9TEaK7LOS9M/JAAxExkZGN+w0mqG8/+OKmSFxAD91zA+5X
         1nJu3e/NWAVb4DvObBiIhq6HZe2oo+uyvtkA9PTiAZ0MawV0vYzQhvdAJpml3MM9Ce+E
         bM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735912; x=1788340712;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJVghZcwIpdjw9VQGaPwDVy8Initc7amwnDZFFILhVg=;
        b=ePnV9KyqrEYcS3HcT89xhaw2HHCVvCabLpx87MHEHmrJji24bjgR1jrM1VYn0Jdl91
         CGDvwdA3Kdkl31dvcyPDZ0h5Qvh9x5XGg8vAH6/VvmPMRf4I25DoQNnWuUTvO+TC0hUp
         iv66kRSR8kiAu6o7KDA5oXRoWJAjaCAUsAXlfJX3ctFqZK3sr7lclJTKtJ4ZrCqUjp82
         QaTDuO8YGT9jBOtw7DLCA0JwvoDnGrH916XtXh/Oo2roQ07ar4e9lNf8bFUHwwUenzdj
         9keMEs3hRtZjjp21Tk72CS1RmqvwXWejEaQAO2NZJLMfHJKvpCLna6wW6j12VrLPHd+W
         h/ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFyUSoZQUKS36T9FHfvtgymf3LJTTusWZ7DDTvO/g3PMR6o0ydXtgnyZDbaXEXR4ITjisPfvxx1kXm8jveVkK2t/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++miMEm3VkrZKnVo1tI5o6KSdLrSiHf/+sCGjfCvMFK05POL6lTU
	Wa+o6TwZBKiSvTNNORv9lY25mELtcUAfLt4KXGheDe73N5IAEBHA3KyO1/qIOq2A5RHWyq3Xb0y
	qLOC18ags0e3ei9zjD2Q0oXjIhQ==
X-Received: from plbkt4.prod.google.com ([2002:a17:903:884:b0:2d5:e7d8:3c3b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce89:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2d707a5389bmr84223195ad.7.1787735911419;
 Wed, 26 Aug 2026 02:18:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:12 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=7723;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+ysynpwUlV0mE4GyFNOI2YE86y5cHwtUdkUTLphgh10=; b=iXQ98hLva2UqjB/f4knyONW86m4iuJ3Abi6gsqTTafU6aPgfFIfHAOwoBTVMp4Ow6urwELNC9
 5xa4bXhDH4bDKYAAom2V/fChZaiI/Jpko29q7zx1pnUbJXrCUv9ZgO5
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-14-0a15d8a799aa@google.com>
Subject: [PATCH v11 14/46] KVM: guest_memfd: Ensure pages are not in use
 before conversion
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

When converting memory to private in guest_memfd, it is necessary to ensure
that the pages are not currently being accessed by any other part of the
kernel or userspace to avoid any current user writing to guest private
memory.

guest_memfd checks for any outstanding references to determine whether a
page is still in use. The only expected references after unmapping the
range requested for conversion are those that are held by guest_memfd
itself.

Update the kvm_memory_attributes2 structure to include an error_offset
field. This allows KVM to report the exact offset where a conversion
failed. If the safety check fails, return -EAGAIN and copy the error_offset
back to userspace so that it can potentially retry the operation or handle
the failure gracefully.

Update documentation to document the error_offset field and the possible
-EAGAIN error.

Suggested-by: David Hildenbrand <david@kernel.org>
Co-developed-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 19 +++++++++--
 include/uapi/linux/kvm.h       |  3 +-
 virt/kvm/guest_memfd.c         | 77 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 91 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 7aad097ffd392..f88d65b78c504 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6594,7 +6594,7 @@ KVM_S390_KEYOP_SSKE
 :Capability: KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
 :Architectures: all
 :Type: guest_memfd ioctl
-:Parameters: struct kvm_memory_attributes2 (in)
+:Parameters: struct kvm_memory_attributes2 (in/out)
 :Returns: 0 on success, <0 on error
 
 Errors:
@@ -6603,6 +6603,8 @@ Errors:
   EINVAL     The specified `offset` or `size` was invalid (e.g. not
              page aligned, causes an overflow, or size is zero).
   EFAULT     The parameter address was invalid.
+  EAGAIN     Some page within requested range had unexpected refcounts. The
+             offset of the page will be returned in `error_offset`.
   ENOMEM     Ran out of memory trying to track private/shared state
   ========== ===============================================================
 
@@ -6616,6 +6618,7 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
 ::
 
   struct kvm_memory_attributes2 {
+	/* in */
 	union {
 		__u64 address;
 		__u64 offset;
@@ -6623,7 +6626,9 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[12];
+	/* out */
+	__u64 error_offset;
+	__u64 reserved[11];
   };
 
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
@@ -6645,6 +6650,16 @@ which includes operations such as unmapping pages from the host or
 stage-2 page tables, may result in side effects on memory contents
 that vary across different trusted firmware implementations.
 
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
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index ccbf7c475ec29..0ac9e6a790111 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1662,7 +1662,8 @@ struct kvm_memory_attributes2 {
 	__u64 size;
 	__u64 attributes;
 	__u64 flags;
-	__u64 reserved[12];
+	__u64 error_offset;
+	__u64 reserved[11];
 };
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2987611587b18..e4722eb6405b6 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -538,8 +538,46 @@ static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
 	return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
 }
 
+static bool kvm_gmem_has_outstanding_references(struct inode *inode,
+						pgoff_t start, size_t nr_pages,
+						pgoff_t *err_index)
+{
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t last = start + nr_pages - 1;
+	bool has_outstanding = false;
+	struct folio_batch fbatch;
+	pgoff_t next;
+	int i;
+
+	folio_batch_init(&fbatch);
+
+	next = start;
+	while (has_outstanding && filemap_get_folios(mapping, &next, last, &fbatch)) {
+		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
+			struct folio *folio = fbatch.folios[i];
+
+			/*
+			 * Outstanding references are anything other than those
+			 * from the page cache, plus 1 temporary reference held
+			 * by filemap_get_folios() in the folio batch.
+			 */
+			if (folio_ref_count(folio) != folio_nr_pages(folio) + 1) {
+				has_outstanding = true;
+				*err_index = max(start, folio->index);
+				break;
+			}
+		}
+
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return has_outstanding;
+}
+
 static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
-				     size_t nr_pages, uint64_t attrs)
+				     size_t nr_pages, uint64_t attrs,
+				     pgoff_t *err_index)
 {
 	bool to_private = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 	struct address_space *mapping = inode->i_mapping;
@@ -556,8 +594,28 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	mas_init(&mas, mt, start);
 	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
-	if (r)
+	if (r) {
+		*err_index = start;
 		goto out;
+	}
+
+	if (to_private) {
+		/*
+		 * Forcefully unmap the pages from all userspace page tables,
+		 * and then verify there are no outstanding references, e.g.
+		 * acquired via GUP or similar.  Tell userspace to try again if
+		 * there are outstanding references and hope that whatever has
+		 * pinned the page will put its reference "soon".
+		 */
+		unmap_mapping_pages(mapping, start, nr_pages, false);
+
+		if (kvm_gmem_has_outstanding_references(inode, start, nr_pages,
+							err_index)) {
+			mas_destroy(&mas);
+			r = -EAGAIN;
+			goto out;
+		}
+	}
 
 	/*
 	 * From this point on guest_memfd has performed necessary
@@ -578,9 +636,10 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
 	struct gmem_file *f = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct kvm_memory_attributes2 attrs;
+	pgoff_t err_index;
 	size_t nr_pages;
 	pgoff_t index;
-	int i;
+	int i, r;
 
 	if (copy_from_user(&attrs, argp, sizeof(attrs)))
 		return -EFAULT;
@@ -606,8 +665,16 @@ static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
 
 	nr_pages = attrs.size >> PAGE_SHIFT;
 	index = attrs.offset >> PAGE_SHIFT;
-	return __kvm_gmem_set_attributes(inode, index, nr_pages,
-					 attrs.attributes);
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
 }
 
 static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,

-- 
2.55.0.887.g758fc8c411-goog

