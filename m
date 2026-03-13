Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFE367F59
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382382; cv=none; b=tpd2DLn7qgyTm3Oog4uSLC3UpxFC9daKC2SlwFxq4bl8umLvbPKXF6ln7AgrpgS4dibLDUn36uYS7bQRn6qtbMppo0CWLd3JRvxeDhCxD/3+r1fOM14a2YdKueerccqRZPZV+NRSPcQZ8kWFGewPTftsOJof/XqvzAghDEEwmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382382; c=relaxed/simple;
	bh=fH+LSf/23FxM9lMSz/vi70SjQxxQNSNxmhV0HLx1ah0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dI2cH9kaPV6U2HWoyTtdF2ce/gZFoNOw6h9wzpLrZSRcgNTlBduMCelup9d1wVYjifKn5w62Z/QzYF/OstHPTY5NGJP4wB6lYGAvQMCL1za0N9Ngcr7kKQZzaVHOKqZuihiraY6Cm6QWqXOiOS7I0oquxNsPSYrSJzvUbUPSVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebN8UdAq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebN8UdAq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so1717061a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382380; x=1773987180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYyaw5i8MlJ/nWMerV4znKSGD3kzvn0fRy3QYPpJsM0=;
        b=ebN8UdAqTNuwkyUrV7h2efMz0MWwf4XP6HwsGBw2tjr+jggQaH0qGRQAQGzn8pe8Lv
         Akqww6JFcE/IeimE3vb5DDl2kieEKD/8y9vtETj/zBh9mZ4nq5WRpdklMCpqtSeo/faE
         oYmfiDbBQeJeQ/PrqTUQcWv+aPQzdEl26mRUC1H8VjhkdPTjerAJvg5RGKFIgycPGgsE
         44RS6Loxwq60VYRdTTSHks5hFBtNJOuekPqX2KJ6DktCsp3BiqtLgkHGhmOVkFcfyoaJ
         RRGx5Yatc5CJmXAI4obnKz73XSuMt35qMu6Ts4U2Hv5jCWcjFTVT7v3dvoDzNEbu1buH
         YP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382380; x=1773987180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYyaw5i8MlJ/nWMerV4znKSGD3kzvn0fRy3QYPpJsM0=;
        b=FmixsBrNXR/O2uzPnyB7w1m4avKylK5zNKK4K4FP17k6E8a/NrB/JLAOeT6xd47bSC
         da+hzd5u2r+22Uumrl9j22avNADEuy3eQZIBF7kwOZgFrZ4ArM3AF2HJt72euUy81phH
         eeT2hEAnb5DHH+YQjp5JHc7dc6EpT6R8cUsdXu7vrnq6SKjcvROvdOKQ4i3xaFAG5+JN
         K89ictgIx8TkMsEzCaNl56ufxtRyT99ZWptBn4r4KxP1j8h6awcnpKmpDcP8FYKfcjKG
         FAWgQj3x+sTX074xE5MYyrvPY+l9tjEfhRNnEiX/1Bn+n6CKd+cu6PQRBYA8jq6s8L6p
         ph+g==
X-Forwarded-Encrypted: i=1; AJvYcCVS5TCeY20yKbzMUnRvGsqS5qPGq5GiMtcGr3UG4WUhvOGQMM0XTEmPE/8Fgqbm7ilWgIhNsIMXqC9w7blvkABnWL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/VnMihla44OBnyRzaFkhyu8SsRuqix+BSzRRWbtWMz6jfUnp
	/Bi2m9O/OwtfjfAg4jPlYt0xeOtuaTOblmpfGh4Ftu4Y1vt01UeP/DeB7XuFTDe3jGGIAPGuT8F
	52I6v38fIJmGz7prFQQUHVhSHrw==
X-Received: from pjbgt17.prod.google.com ([2002:a17:90a:f2d1:b0:359:f0e8:29f8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:394f:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-35a220aae41mr1691496a91.33.1773382380145;
 Thu, 12 Mar 2026 23:13:00 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:47 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1336;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=1AZUV8HVIE/b1+LKkBMNxVm/VNTc/d2us9MbDw7Vwa4=; b=Et0cAwEV3IQ/8isSspCH/jVwwIUU9y5cDrWGWHgQMY4mZV5OisfESJD5AG8EgWNvSuLXcdMpw
 QnNWKTfg15WDankXnf+RjdpGbRJ7cfwJ+RfuHWUOQhBiYM/qJ9OwAt3
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-8-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 08/43] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
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

From: Sean Christopherson <seanjc@google.com>

Now that guest_memfd supports tracking private vs. shared within gmem
itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
for x86 Confidential Computing (CoCo) VMs, so long as per-VM attributes
are disabled, i.e. when it's actually possible for a guest_memfd instance
to contain shared memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e133a9da11f0..9c29407712580 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14056,14 +14056,13 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
-/*
- * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
- * with private memory (the private vs. shared tracking needs to be moved into
- * guest_memfd).
- */
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 {
-	return !kvm_arch_has_private_mem(kvm);
+	/*
+	 * INIT_SHARED isn't supported if the memory attributes are per-VM,
+	 * in which case guest_memfd can _only_ be used for private memory.
+	 */
+	return !vm_memory_attributes || !kvm_arch_has_private_mem(kvm);
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE

-- 
2.53.0.851.ga537e3e6e9-goog

