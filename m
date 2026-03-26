Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970633B6EA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563872; cv=none; b=nCHL2P7WsMnZyvY50cum/mIbb2DjnoGct7UUUaTi6EejGlLsZNVF2GK+9lYtA3g0oOx1C3od7dDF+gYnnyxsbihf+qkSVsvfvIQH3hr2tqasYwdANIZQrE+rx9NNrUMEgdyWi6yP94hBNO9XrYnvl/drEKsJsQd0EGK6kz+TtYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563872; c=relaxed/simple;
	bh=JHd56pbgZlSOVjn9idwqI34aZJE76SCMw1AclkyeKWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dGqLr4brAtGQTQW+nlY+N8e5VPke+Ac9DJWgsHDkC7zUhqIhevhVPGFMODHmeC4/O0n0OjwwP23u6bt/7p+a2YHPAoRtgqMGWQ1fHkeoyUFpOdQqM9kShaih+Xa+5fsF27JOb5qE2IenQ+9KGIxOGtjwS76Um6W2LBoIINAKwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcrVgQ0/; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcrVgQ0/"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c8768a633so1553021b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563870; x=1775168670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl/bsWYJpdZnQGZ2ISOX0kOe5zrNHYK/8ud0vcSuZwg=;
        b=jcrVgQ0/JCvNQ4nBIwSWlBCMo/9PWMQf6+jOeKV0DIkHr4sMedKfo/2SCWe+eViEwS
         BTqYfm2RC4NNriz8Gn0jdPUMjFsLDKNlEhq6hIrNS33zVd7PuNdX6GUlpkPAlV3JGsVJ
         rzCF4PNCkECnsWgHmRSS5jC5/ClN2qSqixV+2IZhnpLe2sujzmpN4wofPpFBx0zvWQlt
         bJImaOUnzonkq70qrK9dmL0TKuCWTPGg6PJ9ydKhxhUMITunV06VTeKElwJd6pYTJzL3
         GrYu5MloMZqnTzVmfuauH994AMwC2qukcauA6immNk7qFe8TGKCZYj4Swl/65SuyGU3T
         Gg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563870; x=1775168670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dl/bsWYJpdZnQGZ2ISOX0kOe5zrNHYK/8ud0vcSuZwg=;
        b=rLWzAmRkW0aWtAt19HcaMsEmApFDwm3o7P9QFGFTFTeBzgMAzA4jj5jTjJgzJpyiXU
         MCT94uBsxJCGVuTnZTphej2AOL6/c3HDDXppgTsiGxWVUS5gVSkxDuvtEj6AHtYzeWNf
         0Q6nvCtp46W2QvWn/23lMUVmUlpNTUyf0eF116CY9rlI6OSmjkv3Dg/NhwLUzD//ACPy
         peacWW1CdSaUFWOJbxOXnDLTyNZ/U/eottJ6DCuOUyEA+T7ZFSVeQj3qiYf7MhuqILQ+
         RLXb6U1KkaVW0eUOpC+UwdHbcF2AHb6fujynx48xD3NEXF/Xz1cUp+TO6HlmTsIM6ON0
         ltbg==
X-Forwarded-Encrypted: i=1; AJvYcCXtvGpwVB8U5/whotIZHUeRFvv385z9qzqDYpdxurkT43PHq1VemOCoffbYrv346kmYecg57Ins2mJV6dQiCAOugYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2z9C2iTR4YjLr5g1ssfycUDwLy/rb9JcbnrEEc1ZpmQaYihxN
	jLDOlrxGb+GTLXcMvqtgugwVlv9KBq4ywQNgUIu2mKOiMfNpYYIJV0o784BKtpiE27x2GrWD4iN
	XVz+V34tam3fU4LPhPexCuJIEjA==
X-Received: from pfbg26.prod.google.com ([2002:a05:6a00:ae1a:b0:82c:20b9:f6a6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ac89:b0:824:d09b:9126 with SMTP id d2e1a72fcca58-82c95d38df7mr155334b3a.14.1774563869575;
 Thu, 26 Mar 2026 15:24:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:12 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1738;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Emrp5cxolz1mmhbaFPRl70Urv1qo5yybaBiy/upVECw=; b=jNlhGG1OFNUmd0OJb2inFZ4ZpQXusBqRlpeNCh3mEZZbGhxSKlauRl1XnPma0bUG0/xPMxb/k
 pNzq1W9TKccDAK5fYnvrlY1CdXcfNoI0wfb8UynYBbRBdZFhi+ZrIzs
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-3-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 03/44] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
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

From: Sean Christopherson <seanjc@google.com>

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of decoupling
kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
guest_memfd support for memory attributes will be unconditional to avoid
yet more macros (all architectures that support guest_memfd are expected to
use per-gmem attributes at some point), at which point enumerating support
KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
supported _somewhere_ would result in KVM over-reporting support on arm64.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e75f7295af5d0..4ba42a1278d5f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,7 +721,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 301d7ddac6ba6..793a2c8476b09 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2428,8 +2428,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
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
2.53.0.1018.g2bb0e51243-goog

