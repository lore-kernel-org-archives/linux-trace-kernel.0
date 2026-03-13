Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC736655F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382381; cv=none; b=lER7hDexMqEdkffiOiqHGb9ofYLXnUpfuhVJl7m5mW5Y5Uoayo6/ddmQU2PWLpxa9AHrFp7WLHfYN0FouaISj9jmp097E5NwpxIJWqfgJprgY2LRqMV3ExY+XX9QtLIOPjuMxh1w51U3JLogtbOG0tYMiWOsyeWSvcWzypwbUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382381; c=relaxed/simple;
	bh=lZywDt32gEFzsmecEA4QgNgSbK+hdPuFQzg/RmbbgZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zs7lUPMGbKBaPuM9yImBeJSY4caX8zboev3P3lGjctNdY2vUe34VuRhb/qCe4WwLIagXuoIVm3MUK0BK7scr584KZTInUTUJOCpOB9ioAcxCOO4p6rtg0tk7sbdxBIfOzdC4kQMMPZsvvd+LD2BLl67p+SAGNvU06i8NgnKTjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCe4tYIv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCe4tYIv"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a21d5246fso695306a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382379; x=1773987179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmoXXIRdkxEQ9ndfTXjPolg/SPgAKKLMCCKfdI00E1E=;
        b=HCe4tYIvsKI/yGdpGeBOfNws6kl1z5HuUnJKPm2BfQJfJX9xVX3bGoOkLfY9Hhi+PA
         MMRAlf0wp8rC9pykiDDUyTD77rx7RFuLukFmJfUjGc5VDI9ccgKbcZAvW2tdM8GB9dle
         ocWiSJg5eJF3Z5YYqF9vRQY/1dcbj/L3M7IeKZJRg1QcVVKIA7AdhdXWpEBel2GzXaDQ
         QrnCrrwuERW7DUYhxC9WpKWTH6uu2NdKKHDaifc1vb+c34NFunXnnozpn0ISm3lwz145
         ka/DfSz498e3TTLZOFMntciDQaJDBmor7y8ftTWNJOM3RTOR2dipe4F1eQ00tuGNEIwi
         Ifig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382379; x=1773987179;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmoXXIRdkxEQ9ndfTXjPolg/SPgAKKLMCCKfdI00E1E=;
        b=g0r3yp3PbkNIxC9DuMAfM1WH2ImNdh7QT6TEGAUUPwVFcsfmRjynY/dFKcG6+FFqxR
         1/OLdABrSplsQDr3k71MqIdtkdnRKt7sJImqIZroiXpK7B2OvoxIXPReOaIYxX6CtLjC
         NNz/58IwqDMd/gULAvntMGTg+uN9OE84kozS6C350qHfja9IujFt47Ad5KUDoX7Fzlk0
         ZeOk3hxyP65EaEEhuqibyIjsvBR1TUWx782/DKLwPSk/n7zrFUh05tQO2fd4HzcwSmGX
         8LkKdhYZihKmYf/7jVRLOjz/0ZFs73IeW9XJgw3qcdk8Ur9dtoXMhUDvHsdiSFQ7rHsm
         fXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXqDg4+RJY7eULd42YJvA+ETrm6GjMUsszseyX82peQ83FjljuRU8NyVAGuphXwI+lCzW/kUEDL2tps5Xnw+Md221M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7g1xQ9yzmOWzE6W7AHwU40j1Nkt9FLETvyVEcgFapSJLQAMzq
	tb3swYDyXHtzu/7sb4zTmkPiOXfx5507IntKQliaXSW3UychxpHfoJE2XqLVqSKwxZ6DP/1OJ0l
	3l4aQKaqHBCgRDeDFgTIvpcMNUw==
X-Received: from pjbil4.prod.google.com ([2002:a17:90b:1644:b0:359:92db:6c34])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c11:b0:35a:18b1:c248 with SMTP id 98e67ed59e1d1-35a21f67a61mr1921776a91.12.1773382378546;
 Thu, 12 Mar 2026 23:12:58 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:46 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=7171;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=lZywDt32gEFzsmecEA4QgNgSbK+hdPuFQzg/RmbbgZo=; b=wXOKwBAcrs4+sjPZdmmjkofJZaHvV9KlzWtq8KOyStQozujFVMUo/V5NxHcke98fiezOI/hU1
 6mNboGooVYaD/MFoDyivkU6ez5Z94jAZoYTsbxmrpYamUtgHQtZ455u
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-7-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 07/43] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
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
 Documentation/virt/kvm/api.rst | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       | 12 ++++++++++++
 virt/kvm/kvm_main.c            | 35 ++++++++++++++++++++++++++++++++---
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 032516783e962..0b61e2579e1d8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6359,6 +6359,8 @@ S390:
 Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
 Returns -EINVAL if called on a protected VM.
 
+.. _KVM_SET_MEMORY_ATTRIBUTES:
+
 4.141 KVM_SET_MEMORY_ATTRIBUTES
 -------------------------------
 
@@ -6551,6 +6553,36 @@ KVM_S390_KEYOP_SSKE
   Sets the storage key for the guest address ``guest_addr`` to the key
   specified in ``key``, returning the previous value in ``key``.
 
+4.145 KVM_SET_MEMORY_ATTRIBUTES2
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
 
 5. The kvm_run structure
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 80364d4dbebb0..16567d4a769e5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -989,6 +989,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_MEMORY_ATTRIBUTES2 248
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1637,6 +1638,17 @@ struct kvm_memory_attributes {
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
index 70b594dafc5cc..89c31eb71a1ca 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2621,7 +2621,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return r;
 }
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
-					   struct kvm_memory_attributes *attrs)
+					   struct kvm_memory_attributes2 *attrs)
 {
 	gfn_t start, end;
 
@@ -4966,6 +4966,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_DEVICE_CTRL:
 		return 1;
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES2:
 	case KVM_CAP_MEMORY_ATTRIBUTES:
 		if (!vm_memory_attributes)
 			return 0;
@@ -5191,6 +5192,14 @@ do {										\
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
@@ -5373,15 +5382,35 @@ static long kvm_vm_ioctl(struct file *filp,
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
2.53.0.851.ga537e3e6e9-goog

