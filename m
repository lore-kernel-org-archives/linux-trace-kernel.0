Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4394949FF;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185370; cv=none; b=rFxD+tTi8CXHLay58ltMGO4koxuk1RJVbEasFFx/c2zENem74UuboWqZwvMQMsLbrkyBM2netAAytnjJQPSTk0UnfRqBd8CU+iQlJgDM5zVGVE/ovUtTVId3oPbJ49Qj2mF9O3yvfJnMvlgvhqIGKBO2LYjMoQN+cLDYQbRgzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185370; c=relaxed/simple;
	bh=mYQUiOVAFcdMn9F7AdXy5VHfulr7TgaYhY2jwKbtsXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sETWmHrI6iNH+zW0N+gzSBXnUMbsKTePGqMB9JzV1V+IHLSAR94srm2RXs5lnqGtpzY39is00JhA6ROKY4kb2JMbsbTDmDMOUxq7jc6gzneNWOy3hr/sRjWJ5hl7ygm4jhrS05euSh/0tqbrX/9us7NUqxeQO+6Tat0utXk+dcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH1O/g8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH1O/g8A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDF3BC2BCC7;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185370;
	bh=mYQUiOVAFcdMn9F7AdXy5VHfulr7TgaYhY2jwKbtsXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FH1O/g8AuwXw+t3/EVlOrla+AQE3pzeR2LqC3lh/kQxltW5ozIBT0s+ETxRneT29D
	 Qhol/bKjqc5loxPvppPBcAe9n8Bvw8zZDU9YcgLKftoJsNL0sPyCjyDocTB7qQqSit
	 jTt0tb2cUY6eHqk/VbVSCwXD3pApKAp6Lue7ojtr0PA4VmaJXNiVTyLudDPXew4vhv
	 5AGJPbQcYmnL+Fl4iPwaspzhoDz6pJFahpLF7dSuC8M2z7LT7qUPD/s35eLLk0cNxc
	 f4yYd7jiOPmjVpkLmYWJeIl+cCXO1o8xzMnejMBRv/ThSHtOc+jVKbVeProWkg/jF3
	 o0+GkNfExKYHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B098FCD3447;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:37 -0700
Subject: [PATCH v6 18/43] KVM: Move KVM_VM_MEMORY_ATTRIBUTES config
 definition to x86
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-18-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=1805;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=sJS3/lDGth1Rw6pd4XUSGVYiXYontCIVaCOzoTR3u2g=;
 b=JGShSJ98Rti7ZbiCYYkxz+p3V5w7W/pjltb7+fRSUMAdgBSmn3fLjYUvzZvwtWuLIY4dN5Drm
 Pgkb6tca6IGAM0h+YRw3FdKTyT0Ncl0F9tC1y/H4LEWSk+VwYnKlGCL
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

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
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
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
2.54.0.563.g4f69b47b94-goog


