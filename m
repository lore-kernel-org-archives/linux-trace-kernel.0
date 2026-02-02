Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDBB387572
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071442; cv=none; b=VxAPYl76yXnNRmwl7haR8NbupU1OA2QwrJCo6AisI3ERpacKokMQ3XnrZ5db19qbNx3FhB4fbvYQGsNoCVRAc09GR+qTfV18LZpN+0WQw4fIAnIZQZhV/2suPlfcTQkUnd6l2Hf8cO6WslR2w0ew3DaC1TbeiSYCmVj8q/R7luY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071442; c=relaxed/simple;
	bh=wjFLG9ZoUawzWzbxQEYs3yXL7HheO+oB6lVml9w7xBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fo+JkrPcZ8A/dUiXE2LxHA/x3b2vBrZ4Y3YGvWrZOq4fDkFZRsvkKhiNIMdm/17m45upr9BzaIKRS1YPserx22ZW100VslzAE/rUUlpo5i0sDt7ojvd0Hjxe56n8nykhxrl3maOUrGY7qbySeanUJGAdIEqgTwcxXsbl42ODzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1CuXaYG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1CuXaYG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso2647831a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071441; x=1770676241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEns3OzC0DhCSE4NhBXD+eHGA3wBWzKtR7XwA//JjDU=;
        b=M1CuXaYGlfBWbuvwpsNIgKdY/TZ8umzuZ6rdYJKpZl+DPxhe3lZ3rZS+V22IkZqW3t
         VdCX7MeWLcZqvtChj9ONIC9q/KsVbWQLmvAOddDTDbMcNlpWAPKqyIGFZtATNP2As5wO
         HyaYNHKmjO9a9ksog17d/eXcKxYf1lUKZI57eg/QvIJN0s502sEY46d17pz+4ORHqUnV
         d+eucYTGa1RtovK42Ts0FhMoH7cIIm/lRso7llTe/pOKNPE9Joe2x95ATM7UtzaEhMDU
         WheOdMfrv8S4rY2vpC2VqJ+SjZFs/eNt8WTznml0gQB9wVCthgZRcNzTkV30kTNciRii
         Q8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071441; x=1770676241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEns3OzC0DhCSE4NhBXD+eHGA3wBWzKtR7XwA//JjDU=;
        b=P5dlLLvhgCQ+dPKLs1863Fyr0QoZyhIaFDy8irvBUzru8Qf2DkRQV5hy8AlbV6SgPB
         s1PxsT2nz4//2F3far5jV5C1ZopJBJPFNcAHlA4K1DnUJo5doGOQwj89p2TFHpmhpV8r
         rswFfcFro8aLIYECMkcNsgDkkQOF4nW9GgL7WpeIakNUCLAyOZOfaPowV3eku0EXi7bO
         ArVAVT54IZwFNdzUl9oKqQPOX6RXhZFaNHDtwv/zeTWtfkKpSfhMOwr9Hvch7toI71c7
         GGhAq24OI3lQBNMoxYjWm2NOPy0P2dTC7dOc7VMZbYtUD1S0DxzZRgjRc/PQfNWPalOS
         2UQA==
X-Forwarded-Encrypted: i=1; AJvYcCXwPLlK2AHHzAmpOe1C4SL28ktWlHEMHtYw91d5sTH8ZNv5ETnWtfQmFIS07x+nXqn9kj+gTa4kJexbHGRh9Rm8tTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQzv5/GNe5KS9TrUGIF7vdl2TmGFSWXDshscN++1ZTF0c1Mxe
	7qWVp0SlVIm0j6WS08LfpFXiDhjwNNFkKLkvR/cbFsAxBK7SiXLjJqh45ChXxPDqSuh/PtNczWZ
	tKKgmkhLw7Pr2+t25hoHcGW9I0w==
X-Received: from pjbmv23.prod.google.com ([2002:a17:90b:1997:b0:352:f162:7d9f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3dce:b0:341:2141:df76 with SMTP id 98e67ed59e1d1-3543b30d84bmr11975440a91.13.1770071440682;
 Mon, 02 Feb 2026 14:30:40 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:49 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <f8d18a4fd16a2eb595c29b23ba54bb7f7ee238af.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 11/37] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
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
	yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

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
index 1683dbab870e..385f26da48ae 100644
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
index f42bc6e7de44..6f6e7da895e3 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -109,10 +109,6 @@ config KVM_MEMORY_ATTRIBUTES
        depends on KVM_GENERIC_MMU_NOTIFIER
        bool
 
-config KVM_VM_MEMORY_ATTRIBUTES
-       select KVM_MEMORY_ATTRIBUTES
-       bool
-
 config KVM_GUEST_MEMFD
        select KVM_MEMORY_ATTRIBUTES
        select XARRAY_MULTI
-- 
2.53.0.rc1.225.gd81095ad13-goog

