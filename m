Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369143BFE3E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735905; cv=none; b=fh3s+mFDUP2IIvh9qo/TCc84cZ03+ybl3BUC1QHeVqluIXghlqa6tZa0IgnRYjoYGCzfQfKvJ7znSW+AP5FOUApTnPNHLzQ2oWDg4UxOvhEH43SQxozCNiAPj1Tz7drjCYgFauSECI1doj607z3LKZOrc/iTYFRcvABkeGKBhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735905; c=relaxed/simple;
	bh=VvxOQ+1qgozXGsDN24yFoiXB70BiDrOwXWGmg7dflZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Roz0uzdTvWSCR2maGg88/y6knXp1b5FT6zV1hyPtg+6LuOh103IjLzROjh1/p9g/kSuyR7aceGf2JBVtrX+cqwTWiPXnSJv9AyOkIDOE/KMiHWTX/v4bzDpOqzsSNk9WUM6dQleX7nXzP+RZN7g7KEDdfR75eajjsYLGhShfFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1QNf7tm; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1QNf7tm"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb687f82eso10912735ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735901; x=1788340701; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2wiHnbE+Ij1tQvsnQSqnQTpOXXjEOrAZMWxy0XisNw=;
        b=p1QNf7tmUOCrqFUkik4eJIL99zGu5RBI7+t4hGPAAv+/m01iB3d32sJT9Ni2ITUkE7
         5dsNxENoqstmmgKNP+87qAzH/YlSChBQEUA2MKgwnOzPHlFWLcddJ1RCUtKU0xeKMvJ5
         ob0zh+RNwe6cHRpxXLSoHjsg4WlcmJ2EYmASP9FujkKwWtEL1mblFdtXWx0zH0t161qe
         XzhfA1hz55fbIVVcRC9NOZ84q6JsSDRJUX7Hag/ZwDnLpmg9KRISxZQqIfHppdVoSWhL
         F4dMUUenkPlW45kseKgxuC+8ssyqTulIGNPsv6AHoAoN2WUZB7Fl1WkDFjQoQFwTMCRF
         LoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735901; x=1788340701;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2wiHnbE+Ij1tQvsnQSqnQTpOXXjEOrAZMWxy0XisNw=;
        b=YAKwqfTXhz5AcqiLTb7vg4W1bo9AvtgYSBcZpm18upCnrwI8WaFgMo0vw4weXr/NEm
         lYfHrcPmouPKvVxxh52gMfosGST5mmbpKI14H9Ul6OgDMT9NntsHrhmujP7QcCMoR/X8
         Si20XJXc+e2LgjBFzZyYmx8jzaPRsiTyaEk1ZdVRUfcPRs9xMLQE80bmwCXLynDwGPrt
         5th9uamLv8fhVlcaQ2v9kZXgF+FphfCukMeKe/80zNv1LLu4yRr0Bk8jQuXZGoo1wnjX
         2fFWapOHK26g4YWEIQd2G4EJDm6X1S66bDdj5bwPNQ+XixpDmjtX3oEn9ojQwWquR8Sl
         sIoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGpmTSAnCEHllP86/xC+Gt0LEYLlMAX6x6Z6KHnpFxUzK4voEnozJBpBDnbnwDySOKv7EZJJV/4+03NP79dSdSRMg=@vger.kernel.org
X-Gm-Message-State: AFuF++kuwGuQrC5kLxCMm7YYA0jTzQ1VsmsU58Sj11rQlf9Wfu/vUqxv
	Mv/R0vEtcw43t3w3mPwXFiD6n3vbMWZOnrtygm8r8sK7MoXjqNHT/gpLqXHJ/8dBIR5ak4FAlBJ
	C1SV9Gb4RzqwnsSFIP/ZqG176mA==
X-Received: from plbmz11.prod.google.com ([2002:a17:903:350b:b0:2ca:cbc9:76fd])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:38c8:b0:2d5:ccb7:12c3 with SMTP id d9443c01a7336-2d7079579a8mr85171415ad.2.1787735901060;
 Wed, 26 Aug 2026 02:18:21 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:06 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=3261;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=MYp0jcv/vyqcAp2jfObXcS1n8zbY2OhrXS0jgL07qmI=; b=OjjqRhEDO3WNi+cijL7f8lpbM+OYCuVBl/W4q/2CiXbz6fOaq/lU1MP9wqHNLxp82huANiFAg
 XO5HfFH8jJwBqR2M0mKoQUKWsQqP9fUpPRG2nMdyg4DpIjwzDgaVUTk
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-8-0a15d8a799aa@google.com>
Subject: [PATCH v11 08/46] KVM: Provide generic interface for checking memory
 private/shared status
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
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Introduce a generic kvm_is_private_gfn() interface using a static call to
determine if a GFN is private. This allows the implementation for checking
a GFN's private/shared status to be set at runtime.

In preparation for choosing implementations between a guest_memfd lookup
and the existing VM attribute lookup, rename the existing
VM-attribute-based check to kvm_vm_is_private_gfn() to emphasize that it
looks up VM attributes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 14 ++++++++++++--
 virt/kvm/kvm_main.c      | 15 +++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9b97266f61ec8..3579feb631775 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2573,16 +2573,26 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range);
 
-static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
+static inline bool kvm_vm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
+#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+
+#ifdef kvm_arch_has_private_mem
+typedef bool (kvm_is_private_gfn_t)(struct kvm *kvm, gfn_t gfn);
+DECLARE_STATIC_CALL(__kvm_is_private_gfn, kvm_is_private_gfn_t);
+
+static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	return static_call(__kvm_is_private_gfn)(kvm, gfn);
+}
 #else
 static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
-#endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+#endif /* kvm_arch_has_private_mem */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 91d5af7d60d0f..78278730b2ae4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2628,6 +2628,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+#ifdef kvm_arch_has_private_mem
+DEFINE_STATIC_CALL_RET0(__kvm_is_private_gfn, kvm_is_private_gfn_t);
+EXPORT_STATIC_CALL_GPL(__kvm_is_private_gfn);
+
+static void kvm_init_memory_attributes(void)
+{
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	static_call_update(__kvm_is_private_gfn, kvm_vm_is_private_gfn);
+#endif
+}
+#else
+static void kvm_init_memory_attributes(void) { }
+#endif
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
@@ -6541,6 +6555,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
+	kvm_init_memory_attributes();
 	kvm_init_debug();
 
 	r = kvm_vfio_ops_init();

-- 
2.55.0.887.g758fc8c411-goog

