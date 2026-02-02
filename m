Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117A355045
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071444; cv=none; b=bezEoEsMw6Fybgse1cip1xCx91aNYj4jiEAKkqHTt2SB70eevoY8UhM1js4EG6mcYKxGB6VeBGBBLDQQgKtq23xN9+/+1oNy8Hc5KfOEAkPrdv6bLjdI5XQ16SyKIbPAx0mr2TQOou92yKnkb02m8F1/jVrbuLAYuU7MQgjebVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071444; c=relaxed/simple;
	bh=CnMvc8PFIvzj6OX6g2J7JMmAZbEcoz5apL7easkxe4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=METBxrFvGE6fpseOEqVC5B1xHnrFM7Jev12W7uk6hVy1FjZLuY9I9t0Z0mWtF8Vx+MMjkQYrNtNZh2aTZ+l/NH2+Z0k6Va8zZp9Z9EzJPLtMmVhF6Zy6S91UWZjD3h41gRqndUBtqWC5SrKZ+zyTV50ITDJ/VbeT+QbTCgRw82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNVaKBND; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNVaKBND"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a784b2234dso137628855ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071442; x=1770676242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=njArHVHLCANBQYObbdX1NH6ZuPlMHP4JPxHwVmZR5sU=;
        b=VNVaKBNDu4xPBGed+Rqi83Bv3ToQLyp8oGa1KScyy2ui4E6cjtMh+lxxVjtzs4yVUo
         jaMuo15AodZKn9S6EhYjJd5hy2l4xWu11+Jbp5bE3Nia/iSmU4UCXzi4uacKXtS9fMss
         VGtKbjgW58u8spCGSbPBrZfvDNGhqyDgb3g1fT6dcr1OdaQ89QkGeJht+tGJ+xBRq722
         IbtRd8OlFOPm31Yv4AH3w/2JJRc/ddspzK8qQf8n7lWO2sFu88PaVs8oArnctLcDrpHs
         sOmR6wnUdXYMlH04LYYm7OoAfVAsWH9NZzhhKVCQFdWrPCi1/dDZ9Tcotvs76ke9/53s
         Ss7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071442; x=1770676242;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=njArHVHLCANBQYObbdX1NH6ZuPlMHP4JPxHwVmZR5sU=;
        b=RcmbNsd++z36O2mh5QkvYYsPa9Pprg610veZd5z6KWydpx/vC5tnPHIXYGIntOxf5B
         rGPfsmW++rLjvoJm6GAjAHv+290rcwLUtN3KqEJJ3WCotNQcNjOQLRVAk2eAt2UPW6EA
         0Hk6duLh8gnYFDWKzV6xeL/GEJDDfs5lc+n3RKrIK2DX9WK4fOU8W7YG1A4K40FHxWNa
         3ptt6OjePr3dogxZ/Bu7iQMq7xBW2Hfr9EYJYXlEAswc3bDxhvdnUgHfAMhwS8D8bnDh
         1oKaw6syzT4Ko4OHBjgAUtSN2d+WNb8Fx36NruuQsW7TrVXuVto4CWd5Zapfojsk4ozF
         hDDw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ3j/vURwE03ZDM06rfUWqUt/IfoakekmPrueaLEpT/tqJxHm5IasfLaWWwOWcxycivItKehbk0bPc7UJCCjfKi+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/zL64y+O1Bbpiou4bVEmqRdviEhnNVfzMykay7qnK8RrJa05
	ZD8bFGiRDKPzdtd0Gb/Id1af6xQr3tvyBSSbSXFHaBr+sq/LHq8lekw79wkCgACWf7w91XZc9Wd
	nMU8wisx8T99uRdNj4F+9EUIzNQ==
X-Received: from pjst4.prod.google.com ([2002:a17:90b:184:b0:33b:51fe:1a73])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d8b:b0:34f:1623:2354 with SMTP id adf61e73a8af0-392e0115be3mr10998345637.42.1770071442154;
 Mon, 02 Feb 2026 14:30:42 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:50 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <7fee0231e3afa7b41cf4f71d2c462718b5cb9b34.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 12/37] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
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

From: Sean Christopherson <seanjc@google.com>

Make vm_memory_attributes a module parameter so that userspace can disable
the use of memory attributes on the VM level.

To avoid inconsistencies in the way memory attributes are tracked in KVM
and guest_memfd, the vm_memory_attributes module_param is made
read-only (0444).

Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
that might use vm_memory_attributes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/Kconfig | 13 +++++++++----
 virt/kvm/kvm_main.c  |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 385f26da48ae..fea786906599 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -82,13 +82,20 @@ config KVM_WERROR
 
 config KVM_VM_MEMORY_ATTRIBUTES
 	select KVM_MEMORY_ATTRIBUTES
-	bool
+	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
+	bool "Enable per-VM memory attributes (for CoCo VMs)"
+	help
+	  Enable support for per-VM memory attributes, which are deprecated in
+	  favor of tracking memory attributes in guest_memfd.  Select this if
+	  you need to run CoCo VMs using a VMM that doesn't support guest_memfd
+	  memory attributes.
+
+	  If unsure, say N.
 
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
 	depends on KVM_X86 && X86_64
-	select KVM_VM_MEMORY_ATTRIBUTES
 	help
 	  Enable support for KVM software-protected VMs.  Currently, software-
 	  protected VMs are purely a development and testing vehicle for
@@ -139,7 +146,6 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
@@ -163,7 +169,6 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_PREPARE
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf56cc892e7c..2226b4061bad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -105,6 +105,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 bool vm_memory_attributes = true;
+module_param(vm_memory_attributes, bool, 0444);
 #endif
 DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
-- 
2.53.0.rc1.225.gd81095ad13-goog

