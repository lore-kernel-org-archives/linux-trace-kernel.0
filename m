Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87E38D692
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563899; cv=none; b=OpkwkMUg0O9xym6Z8tN93Ls/cBDjj6HykQw2PSPL1GZ07F7kEmTt03lJv/dSN3pmpNkpopIk+mB+g49iAiYolO5klDFn//7cvoOMZvkwiPZZp8mGkB85L+quUMA7eWPdclAtBYLaJmCksgwdQj9PyLbbh84BdHlKS58aMiosf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563899; c=relaxed/simple;
	bh=ZNSJzwaW770z2O3jcaJypKgW8TksjMRyicAzfFzxMB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RN1mXWZGnK7n4iuQ0X2XTMl1A0H6j+Xccdhz4yWBlUhJE65Z7KgXvbYmbT3MeXSpNqXpap2rUrKDhEBjOuIaS3/LXGcMXTrptgCmcYkxHPQDO8jb0wbVwwhB9S0ftLOPuLGXIezOIP+/gXGaRaMpXA/OvyDgD31vG7Ox7YDidT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7K7MvmK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7K7MvmK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3568090851aso4602086a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563898; x=1775168698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP0m4OKRUtxmtY99mVH8PUf9pC8qTzihU9Otk33F2IE=;
        b=K7K7MvmK2+/B8lyJiMTc0BSwsm+IeoSkQVj2FReN9EfdL3DwT8l6jBpwJnRocBo/TQ
         8P2WANdwhYwA+jjkneGkdgsypLiC83sOz8YOswQd4x8K5VWQ0ZH6ZtdZ4eF6tVhXkUXl
         bpoUKB7O6u67WFMl0+rhJmUVGv1/GYSR4X2ubRsAeSJhkOQepeohO3who2c8olUS/l4a
         UJavsvseTl73RF5R8WjZv408xhVTBtFbbHfnti8MRl7CvVyowLTwvhcd+R29+VXKz9DJ
         ojULGMrefW5FSiF/EzbGF+xOFYdKdajQ6s0xz0LVQgR8rGVV//D0VtatDu7WyGWLxET7
         hnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563898; x=1775168698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP0m4OKRUtxmtY99mVH8PUf9pC8qTzihU9Otk33F2IE=;
        b=NnrAsUOhRRnwCKKG68d3YECP667YbH6ZHsgxJMwFnrK+ceUx0IJjIQKtfjEQcFXkO7
         MFBsuFF9GnzAyO3yC7aRFSGUNYAQppHHg4Jb06f+F27P5Jc306YCE3SFsE8x0HjKsuPM
         j18+QY3+oYeIYQpWjhe0Sw4uGNES5Q3FONau0A7SeeCBNl+uoG0VOk94WpU8fMbiE3Lm
         sUEXiVy108kIuHUwS9Wm9rTqcEB+iq+NYEYK/pzl0p4DyxKeK72+ik2Jk4/5HRgtyOJO
         lwmvhljOBS7U/tGqDKW/xlDDt1xlINcRaF0Vj9Zwx1GkOeTbmjSpJwAFcWnv+GRJUfPc
         P90A==
X-Forwarded-Encrypted: i=1; AJvYcCWDBbbvkuz7RFIdJckrGqWzepDvRDQZ7Qy70Ja20KqXjSZYSWuQzFlZ8vV2QFSOtg7ysgd7IpUMaCVNWqVWjAT1R1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzmyn8L1nbzMV393wn9rqU7+UVscQR0kbQctFSFm8hdAEgyqF
	vIogmV1OYnwlLqM/PxczJG7tCObasZlWwyI7wZuKus/uB5PFTPLht7VKoKR5Qx3I4dMQKafaG9g
	VPRa+jQN5tdSlaikopMvyW298RQ==
X-Received: from pga10.prod.google.com ([2002:a05:6a02:4f8a:b0:c6e:1954:345])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ad0:b0:35b:e594:5038 with SMTP id 98e67ed59e1d1-35c300b7e5amr211045a91.17.1774563897304;
 Thu, 26 Mar 2026 15:24:57 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:25 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1752;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=eWTeX+992GeYO26dNFWGC344Wuak8bbQzmW7qdSnDKw=; b=SL6pYdxlhvPJikdSi+mQfL/6DG+UDH5L2C4BN1AeU1jYKBkDwTYhcD1AK0H3INZXB0ml7c0AA
 j3kIXGoRZuyCSKk9sI3NBJpxVzzQomxNO1Xr6/eqMY1cnRkZkNjdzmW
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-16-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 16/44] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
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

Bury KVM_VM_MEMORY_ATTRIBUTES in x86 to discourage other architectures
from adding support for per-VM memory attributes, because tracking private
vs. shared memory on a per-VM basis is now deprecated in favor of tracking
on a per-guest_memfd basis, and no other memory attributes are on the
horizon.

This will also allow modifying KVM_VM_MEMORY_ATTRIBUTES to be
user-selectable (in x86) without creating weirdness in KVM's Kconfigs.
Now that guest_memfd support memory attributes, it's entirely possible to
run x86 CoCo VMs without support for KVM_VM_MEMORY_ATTRIBUTES.

Leave the code itself in common KVM so that it's trivial to undo this
change if new per-VM attributes do come along.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig | 4 ++++
 virt/kvm/Kconfig     | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 26f6afd51bbdc..b6d65ee664d0f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -80,6 +80,10 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
+config KVM_VM_MEMORY_ATTRIBUTES
+	select KVM_MEMORY_ATTRIBUTES
+	bool
+
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index e371e079e2c50..663de6421eda2 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -103,10 +103,6 @@ config KVM_MMU_LOCKLESS_AGING
 config KVM_MEMORY_ATTRIBUTES
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
-       select KVM_MEMORY_ATTRIBUTES
-       bool
-
 config KVM_GUEST_MEMFD
        select XARRAY_MULTI
        select KVM_MEMORY_ATTRIBUTES

-- 
2.53.0.1018.g2bb0e51243-goog

