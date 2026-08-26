Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB83BFAED
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735900; cv=none; b=m6YgFfXYPGE0CEYAnRJ2VSI9kkZmdnd6QrPb9Sk1cCI9aJj2lTgzVwG6cT2nsD2JNDw6LKj2GlJhB+Fj9nSbc+dCLirL/5J0jZ+DVDQEY9+pRs16sphvttr2srfzMD8kX0RLbL+dv5Yv49VBAAbbnjj39lMIPL6dYfyG9enhCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735900; c=relaxed/simple;
	bh=mIzudRH3R8PElJ60G9cbne5ej0VMWxfhUV90F9mivPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aF86yXdeWJ/J53FexRCa8DwcqXs2Soltfu1Z5RR8i0SWhjWj7aTWRDoSnuiIQfcBLsVYCWAn3AjjVTgUvdkapn/bQnXlzIwhS8sQ3pvgxVOB8jYnzUD8qB4NUH8mcSUsbclS81t33klvtQot/bRxOcpPx94OfHUgLWhi30KiVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qszCAr1G; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qszCAr1G"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce8a76df2dso16620785ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735897; x=1788340697; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TC3Eeg8HHmJGsEMhcB9JAjXxd+Sjyj6Ja2pFhCLMeNM=;
        b=qszCAr1GWb/i3x8LorGEDGjJazvNrDRmaXPTomdN1q3wjVxe4BelSnKUGgagXImXzw
         NutT9Yf/Ga9gjyw1pES00iH4W+nRQ+86jOMuALkZ2DlOPzLl6RK0KbKwpCfT3Mn9CFjE
         bK9ptaZMzb1V3FFqLfm0xgMgArfK6Xfv1YmEz/lCZsrGG9KLQ3QKk1kRLTynEtQ1PKzU
         F7o5vjiZSOEEcYcSz1VayREd3pcyoujWlrWuuHppiCW8wuZ1TfYrIodrVoJ0sxJzyAfN
         KiaMgy8n2e1zuAZCZ3AkoynSU9bShugff3rKrJiMVnjBQ+Gohx54kxE1JAWji179rNXZ
         hWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735897; x=1788340697;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TC3Eeg8HHmJGsEMhcB9JAjXxd+Sjyj6Ja2pFhCLMeNM=;
        b=SV1cvcgFBqBu77JzAfo6aIrzHjm6TVatUceQMKoJ76DuBHFWMyKNraquh3+QPC/I/7
         hh1tVz8eatfuLVHxN6rIdgJ7nimeUPlnc79WDkLWvsbsCubUvfE/XiMRg7MKRmW4G3cT
         EkIGl4JuG7U/zf/EldGT719oaoqR4RkX3o+NR04P5rEP7fmXL2eFnMeG1b94wtcYZL+t
         qCoIFE1a1uRW5D/kBIETKylOd8TOHuSM2SNwPYxa4Cwuwer8nJjvd0zJRwPAZjxxk3ih
         UBr4O9KApxfvOQWj/ciHQUTE+m3saNGRnqTH1EaLasZaFsaZgQ7EM8WkQhsSvtIVAzGL
         F0dQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl5eOxMY17cQ90pW7L2XZOZpgRoY+TGb4VxGbw/ZI6wu6lu0+4qpcfHBHg2lnwO6jk3AmV0AqN7WYqCKCAGuLi+Sw=@vger.kernel.org
X-Gm-Message-State: AFuF++nb20vF1P4aQJHxvMzBWaEhVpGVLcmgSd1yZWhrqXQrQJB1q3XT
	1yzpea8onenQBHOMWU9h+qu3x2z/fEV3lNtNErT/SZ0bCYZXg44JZ/7p3bpkTv4f70YY1zLiO6v
	B0ewfeI/oKdZMSWSpNcM+qIZ5bw==
X-Received: from plgd8.prod.google.com ([2002:a17:902:cec8:b0:2cc:c554:a93e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f549:b0:2ca:481:de45 with SMTP id d9443c01a7336-2d707a501e5mr66214505ad.6.1787735895566;
 Wed, 26 Aug 2026 02:18:15 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:03 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2388;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ogSExkBJJQ0shJgqMiTFGyZ7TdxK9ZVCrr3NofP4mmE=; b=1VX8N8uXNhbB64TEP35V6sDoTKXKwmyT3n8b5as3eYzSda3HxQRMrx3iH9t7mWRMGk60IOhnx
 3126PLKu+/IAhStJ/lCMVD5ke3zv0gqVMqqbPje0NlXfe+BE1kamZ5b
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-5-0a15d8a799aa@google.com>
Subject: [PATCH v11 05/46] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of tracking
PRIVATE vs. SHARED state per-guest_memfd, not per-VM (to allow in-place
conversion).

guest_memfd support for memory attributes is expected to be unconditional
to avoid yet more macros (all architectures that support guest_memfd are
expected to use per-gmem attributes at some point), at which point
enumerating support KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory
attributes being supported by KVM at-large would result in a system-scope
check (NULL @kvm) over-reporting support on arm64.

Give architectures full control over overriding the default definition of
kvm_arch_has_private_mem() by removing the coupling with
CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

In a later patch, kvm_arch_has_private_mem() will be defined based on
whether architectural features are compiled in, and made orthogonal to
CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cffa16647f2ab..b45fb80b0aca0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7d5325e3cb44b..050757544a1cb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2422,8 +2422,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+#ifdef kvm_arch_has_private_mem
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
 
 	return 0;
 }

-- 
2.55.0.887.g758fc8c411-goog

