Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96736493F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382377; cv=none; b=ePBx0pg8FsYDGgM7cSYf7xoY+MSrbKBmOaaLbGVn9WwSVkCidP4t89h6UI0+fUqrvHC0PH1bN2AeUS9AWYLcQT1NR1TayDYwgBZsG2iYV20QkC4SSst4BxiyJL+xzheX/ckrrIMz1n1kk2o48YpC9hVo+I20DHQSGzcnSfoU8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382377; c=relaxed/simple;
	bh=f/u8MBDxButqty3WBnBpsVNFR5HY5T58VePQCl+a2Lw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FuNNdi1LWMyFQqW8+Ee7MQIW5KJ0Y/DYL/z8BBriaeuJELXyDCXwoETtUd0AVU8A5ygZ9L2MEPXC05zm5jrHBigCpVHniNdxyBUqTTqpVYcmnGqYAip2CvdP2rHdTz8Yuu9wPBl3G5lXeFkYg3E2AewrDbY1kANlk/zegd8yWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gGe3MWls; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGe3MWls"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so1716923a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382376; x=1773987176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfqXPeUWEOK3mFRzlMp1M77AHWf7AiKbvJ1Jssn8XG8=;
        b=gGe3MWlst+E76gu0Wm64XvugJfBBivj4PwIb4nIhCjorAlbxL0dagNrpjQoie4n+rj
         EiaHivT7CWZKc/38OabkxKtbb+rGWFyluntlbPanL3XZa8ZcZG8MKE9ClBQKxTiJfEWi
         UKQzXqpWjdEFKimTwNMSmCuRTmLHIG171cAFo2rZjVI+9MpURU8yCSWSco7/1KNC6gK9
         cK/axBpX7MQcIZuEJOTrEpj+Nb/E5WD3aZ1jY0YLF83hjZm7ndcQJSp83Qi6HX3t9X7a
         80SgXzpV4GapTNf/GjZt7hdoJd6BNr7SFImfvTiR2sWIutoMDJ8Cldn/o2koevQ9aTW2
         tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382376; x=1773987176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfqXPeUWEOK3mFRzlMp1M77AHWf7AiKbvJ1Jssn8XG8=;
        b=Yht9/zQHjwNJ1rYCYpRWOhBk2vQ5KpS9spnMxJMjBUVc8i3U7sUZ1T1Q9BipmKwhDg
         jjO/aSS3MJ2CVvrhXMdOkic5dckL56K7c4QyZyuBb0v9tXta9dr8vPTOrkCx+M19Uvyv
         +9zG9c1zav7qjNpZ5T+u1+UMHWGNeHJGQnYIPE72XYMySu8lKseCprjtUBO2G/Enph8f
         FyveJH84WZsHTZKUghpLChSmJ3Zra6uiw0h858+LdBiG6heUs+ttPJbDgmqHPuyp/mSR
         TSfHcLtPBztkHXnA2v1LJA9IT4m9hjr7c2n97l1+wLS/7U11Cd3adJv2KQstvI9ExOxc
         2I9A==
X-Forwarded-Encrypted: i=1; AJvYcCWsOys2sXGMys0aWFC3lW5aDZ41ldw06oV6vtHXfmTulkrSkUhz741KMxG15i1AzefCOBizFbW4aPhEUuqCm/CaMjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH11Ki9RZMqcADMKXW6BjRI4vzPMZVozavV7KZRNRc9c2yT5z3
	+hC46CPG/abgWfKWwQus6IIXpshlDn+dCGr5k9DPT5+hT8Va8HUiWLI+8sM3U71B71dIGmawNTd
	xHPzKM7hoa58BTXsv6UsQdU4hqQ==
X-Received: from pjbgt17.prod.google.com ([2002:a17:90a:f2d1:b0:359:f0e8:29f8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a8f:b0:359:8a78:569c with SMTP id 98e67ed59e1d1-35a2205566amr1686742a91.25.1773382375196;
 Thu, 12 Mar 2026 23:12:55 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:44 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3888;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=TbzwfWzIJZ9f4hVjCD6QuFLHmDIdFCBsbyhlDASSybw=; b=ApPMO0tHVQBB8+8qRb0igQBkr6D2uQauHnOpA7Zcvx7wKgW4Q/Fjw5jbyvH3RR+9K+UcWadd3
 mQyNl7uH72fAx5ORxla9nJeQT3viD7Tu7q9V1tW8vyFuNe3NybDhkU6
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-5-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
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

Implement kvm_gmem_get_memory_attributes() for guest_memfd to allow the KVM
core and architecture code to query per-GFN memory attributes.

kvm_gmem_get_memory_attributes() finds the memory slot for a given GFN and
queries the guest_memfd file's to determine if the page is marked as
private.

If vm_memory_attributes is not enabled, there is no shared/private tracking
at the VM level. Install the guest_memfd implementation as long as
guest_memfd is enabled to give guest_memfd a chance to respond on
attributes.

guest_memfd should look up attributes regardless of whether this memslot is
gmem-only since attributes are now tracked by gmem regardless of whether
mmap() is enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/guest_memfd.c   | 37 +++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      |  3 +++
 3 files changed, 42 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5393854ca5966..0f84421b3f49e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2542,6 +2542,8 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 67709af03f39d..e93e95940ec74 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -510,6 +510,43 @@ static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	struct inode *inode;
+	unsigned long attrs;
+
+	/*
+	 * If this gfn has no associated memslot, there's no chance of the gfn
+	 * being backed by private memory, since guest_memfd must be used for
+	 * private memory, and guest_memfd must be associated with some memslot.
+	 */
+	if (!slot)
+		return 0;
+
+	CLASS(gmem_get_file, file)(slot);
+	if (!file)
+		return 0;
+
+	inode = file_inode(file);
+
+	/*
+	 * Acquire the filemap lock to ensure the mtree lookup gets a
+	 * stable result.  The caller _must_ still protect consumption
+	 * of private vs. shared by checking
+	 * mmu_invalidate_retry_gfn() under mmu_lock to serialize
+	 * against ongoing attribute updates.  Acquiring the filemap
+	 * lock only ensures a stable _lookup_, the result can become
+	 * stale as soon as the lock is dropped.
+	 */
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	attrs = kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
+	return attrs;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_memory_attributes);
+
 static struct file_operations kvm_gmem_fops = {
 	.mmap		= kvm_gmem_mmap,
 	.open		= generic_file_open,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dbdcef90a4950..7bb59679c9316 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2660,6 +2660,9 @@ static void kvm_init_memory_attributes(void)
 	if (vm_memory_attributes)
 		static_call_update(__kvm_get_memory_attributes,
 				   kvm_get_vm_memory_attributes);
+	else if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		static_call_update(__kvm_get_memory_attributes,
+				   kvm_gmem_get_memory_attributes);
 	else
 		static_call_update(__kvm_get_memory_attributes,
 				   (void *)__static_call_return0);

-- 
2.53.0.851.ga537e3e6e9-goog

