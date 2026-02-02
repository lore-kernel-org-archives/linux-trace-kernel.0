Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E238885A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071436; cv=none; b=n7/jyMwrdhP8+YnO7nFes1g3I7Qo8BIZgkpIOC3beh6V3ojS6N1GGJdQ0RMvTyBneoYZSsYNYl3LuymO/VpxjZyXO7swWVu1ZmJuBixNbR3Nbeq9WuGcjjXvZCbT/ibCqFH5uczNWq4ynarBF9EtdpAgFHq8Ne9cuS2VO9wOrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071436; c=relaxed/simple;
	bh=5fxQLiAxXehoVzk2vsYENIQ+Gcklv32UoCLNfortnys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHo0JfgMYiykG7UgZWFnvdK7a4/EE4Z01z3x/ehJu5AoN4ZjhjvKAmo+8bRSNfKNAfcd3e4yT8JhjjlOHwBeqCcA+XKVSNESX/PwiSfdGlQ159y138mVr1KwYNksOEhvTCN6up82R7t1o5Tft95kzK/bmw+/hq5LAWJXkDSd6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXlOIDZ2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXlOIDZ2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0e952f153so146411055ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071434; x=1770676234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/25HTgooNaA8eLCAbY1xnDq3KFtAhk+rw0tWe4+wCg=;
        b=XXlOIDZ23h5t8ACrW072IeSZg3Rv1cYf6l8N4xVHtUCk5wHHuJ7Jg7Y8oyH5K4IMJU
         5nFKLcH7Sh2wTZ6BHJZU2DsceNVdceUa4VjGcqM9Qe0yzv+MrEv5JwwnBtgeH2M8T2hJ
         NOAFe5dNN4bUX1DA0G6qfnsarvgcZFcSOTqcPx4JjIJlahXuUDxOqG+nbukoQRpGK9qc
         Dl7Qm9gC9UamlxyysB6hkDMcK4ZK/N3o7y38HoC2AW1ZNz5paiGv8ZpZnpdJu00SOHGb
         thzlxfmLLxbVx3DVYEvcwpVvvdzymtaV9J1XKyUlF3xp8BEB60r0DFckVB2OeoUWtPNk
         37ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071434; x=1770676234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/25HTgooNaA8eLCAbY1xnDq3KFtAhk+rw0tWe4+wCg=;
        b=YuK2uK00HXd69WNpjrTiXbNSBHs+xb2898LAxhzkdmSGzuKGYNwob4dW2kIuCp7Z8E
         2GubjyAK4mACgUi6lQ8845vvafbwj24FeQXzupn+pfl5+Rk086VN1tMl8oqrDVHRgQoo
         OIcgc6vUG0UlyHptXxjRRR5WsZXacq2+Zi8QKSGgzxdOHr/Gp4OuEctgvmpOnFgS4MuF
         aS1krKIMkpn80YdpZ+OXmGEnjG0GoRnZuo+Cvnahz6nJ+P6ZjyyVW+aLfjBOJhsPcN6+
         WYzQRC0QZf15BG7VxXQgN7KDaQ6ciNo7KmJLnHDza/QPHkckhxMBFpFyF8Q9kswsHyeY
         Ix3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWf23VJIGkBnn8koRW+uMiZicLE5mbFRzsHQGWwIk8v9nSF9TgA+nMcavImT+melpITD3B/1MQfccx9yEKTda86C/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPvMHKzxPdKhD+S2/G0U2B3m8uD8C0+2P7mMbtrLk6Py7JdmS
	AcZFSbsBWKRSVBSlu30pe1pPCCFl7COJI9a5h1U+0YuQHhDNs400qJvcvn2wxGJOqvzEcSMPrUR
	L+hVA/X8lRonkUJe/w5h8++IHrQ==
X-Received: from plqu1.prod.google.com ([2002:a17:902:a601:b0:2a0:86e1:5be6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebd2:b0:29f:f91:35ee with SMTP id d9443c01a7336-2a8d9a5f1bcmr132785965ad.43.1770071434221;
 Mon, 02 Feb 2026 14:30:34 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:45 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <2b16d30fc0606046574e4df0e0a93afdd4bad836.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a "version 2" of KVM_SET_MEMORY_ATTRIBUTES to support returning
information back to userspace.

This new ioctl and structure will, in a later patch, be shared as a
guest_memfd ioctl, where the padding in the new kvm_memory_attributes2
structure will be for writing the response from the guest_memfd ioctl to
userspace.

A new ioctl is necessary for these reasons:

1. KVM_SET_MEMORY_ATTRIBUTES is currently a write-only ioctl and does not
   allow userspace to read fields. There's nothing in code (yet?) that
   validates this, but using _IOWR for consistency would be prudent.

2. KVM_SET_MEMORY_ATTRIBUTES, when used as a guest_memfd ioctl, will need
   an additional field to provide userspace with more error details.

Alternatively, a completely new ioctl could be defined, unrelated to
KVM_SET_MEMORY_ATTRIBUTES, but using the same ioctl number and struct for
the vm and guest_memfd ioctls streamlines the interface for userspace. In
addition, any memory attributes, implemented on the vm or guest_memfd
ioctl, can be easily shared with the other.

Add KVM_CAP_MEMORY_ATTRIBUTES2 to indicate that struct
kvm_memory_attributes2 exists and can be used either with
KVM_SET_MEMORY_ATTRIBUTES2 via the vm or guest_memfd ioctl.

Since KVM_SET_MEMORY_ATTRIBUTES2 is not limited to be used only with the vm
ioctl, return 1 for KVM_CAP_MEMORY_ATTRIBUTES2 as long as struct
kvm_memory_attributes2 and KVM_SET_MEMORY_ATTRIBUTES2 can be
used. KVM_CAP_MEMORY_ATTRIBUTES must still be used to actually get valid
attributes.

Handle KVM_CAP_MEMORY_ATTRIBUTES2 and return 1 regardless of
CONFIG_KVM_VM_MEMORY_ATTRIBUTES, since KVM_SET_MEMORY_ATTRIBUTES2 is not
limited to a vm ioctl and can also be used with the guest_memfd ioctl.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 32 +++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       | 12 ++++++++++++
 virt/kvm/kvm_main.c            | 35 +++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 01a3abef8abb..23ec0b0c3e22 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6360,6 +6360,8 @@ S390:
 Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
 Returns -EINVAL if called on a protected VM.
 
+.. _KVM_SET_MEMORY_ATTRIBUTES:
+
 4.141 KVM_SET_MEMORY_ATTRIBUTES
 -------------------------------
 
@@ -6517,6 +6519,36 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_SET_MEMORY_ATTRIBUTES2
+---------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES2
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_attributes2 (in/out)
+:Returns: 0 on success, <0 on error
+
+KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
+KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
+userspace.  The original (pre-extension) fields are shared with
+KVM_SET_MEMORY_ATTRIBUTES identically.
+
+Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
+
+::
+
+  struct kvm_memory_attributes2 {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 reserved[12];
+  };
+
+  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
+
 
 .. _kvm_run:
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index dddb781b0507..7f8dac4f4fd3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -974,6 +974,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
+#define KVM_CAP_MEMORY_ATTRIBUTES2 247
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1607,6 +1608,17 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES2 */
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 reserved[12];
+};
+
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 666d1f7fbf07..ad70101c2e3f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2637,7 +2637,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return r;
 }
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
-					   struct kvm_memory_attributes *attrs)
+					   struct kvm_memory_attributes2 *attrs)
 {
 	gfn_t start, end;
 
@@ -4981,6 +4981,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_DEVICE_CTRL:
 		return 1;
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES2:
 	case KVM_CAP_MEMORY_ATTRIBUTES:
 		if (!vm_memory_attributes)
 			return 0;
@@ -5206,6 +5207,14 @@ do {										\
 		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
 } while (0)
 
+#define SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(field)				\
+do {										\
+	BUILD_BUG_ON(offsetof(struct kvm_memory_attributes, field) !=		\
+		     offsetof(struct kvm_memory_attributes2, field));		\
+	BUILD_BUG_ON(sizeof_field(struct kvm_memory_attributes, field) !=	\
+		     sizeof_field(struct kvm_memory_attributes2, field));	\
+} while (0)
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -5388,15 +5397,35 @@ static long kvm_vm_ioctl(struct file *filp,
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	case KVM_SET_MEMORY_ATTRIBUTES2:
 	case KVM_SET_MEMORY_ATTRIBUTES: {
-		struct kvm_memory_attributes attrs;
+		struct kvm_memory_attributes2 attrs;
+		unsigned long size;
+
+		if (ioctl == KVM_SET_MEMORY_ATTRIBUTES) {
+			/*
+			 * Fields beyond struct kvm_memory_attributes shouldn't
+			 * be accessed, but avoid leaking kernel memory in case
+			 * of a bug.
+			 */
+			memset(&attrs, 0, sizeof(attrs));
+			size = sizeof(struct kvm_memory_attributes);
+		} else {
+			size = sizeof(struct kvm_memory_attributes2);
+		}
+
+		/* Ensure the common parts of the two structs are identical. */
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(address);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(size);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(attributes);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(flags);
 
 		r = -ENOTTY;
 		if (!vm_memory_attributes)
 			goto out;
 
 		r = -EFAULT;
-		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+		if (copy_from_user(&attrs, argp, size))
 			goto out;
 
 		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
-- 
2.53.0.rc1.225.gd81095ad13-goog

