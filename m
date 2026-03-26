Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6A34D911
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563881; cv=none; b=qu14oyCuRWDsnH0U62XKPN6WIMhuHm/uflbHfW2Dv2ff5tgmtFwMuI+fUUfRJiG8K/gDeiqiul+bApW/x4PLvYyuQuv/RKB9Kk3NGTI6PElyGScUrxYzUreVs1obYO2VQEcdmRzwg2yWsL3IgKdXTS4H3hBEr3fhG447fdqd14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563881; c=relaxed/simple;
	bh=Bkrh8dbtdInO5wZHJbP237TumUuE8eZL80zRafq4z5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y3fK2Z0VBfzZM0SQtTgAiSTLqqkeXYZO6kexPHuY61tazto0BZlU4oSSqGukYeHy71fB3zCr7TRV2n9RkVaT5wjGJz6CAEFkiiCx+RTRkBfqyKv0hnOd9RYSpOD8Vt6vm3nnSX3ap/77Mr7/PAFQ7m52rhRnsDApqXlh1EWyJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9jtKfwX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9jtKfwX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1251891a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563879; x=1775168679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsJB8DUiPUozVAwHEUqka6GAzAJgxzJ+NiuNM0UTPFA=;
        b=W9jtKfwXT6LDzVvXXsaDpOIRThQrulrcXC/NAc4NplFY7CbuQAtwqUYWh5dJgQgVsQ
         O9gXfeI7kuWwH3YzUAo03N9nDXkI6oWVsba9dYCKzx9ydvwa5ZmXpEXqDPe1w3fr/vSN
         iiVxaH7AAVlWJkhqqVrkP+qEUiLVgC5i+mnSwI0aYoFLRq9NRmnoSRvzB9t2qLZ3Txtj
         6pmhfJHEEY2aC/GjGFMhPwEussjVMW9GfLbM0BbswX15ROD5U6XpwAB92MpaNRss7pes
         bW0O0m6gWLaH2EbkRIo4gcKqpM44Xd9DoicL9JPitSgVbJEzTCSzprMzDKusvZSDuf2n
         Nr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563879; x=1775168679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsJB8DUiPUozVAwHEUqka6GAzAJgxzJ+NiuNM0UTPFA=;
        b=D8BcSh9REsHrCF7+Dt1Ot8nwXTuhwZpvT/Lg79+5O/x2KyplznhgCDkZM2J/UxfOIq
         LvXRIHpBj4Rz8SZ6H6TsFVNfA+8Jassb+imB8HWczG1uVddWmULzKsL2hY5EAHKo08NS
         DdUWYxeiOlCPdB1kvNLNP/wIxi/eUx2PeMOpugGo/DM7RjrCZlO853o6+cA87J6dW1H0
         +laqSQwaPVUU7Tbf2eX3Lkd3RHLAe9NcFxoEhwxdAp0EO6bovlcjyg5Mq4vlKemVQszL
         ipjXFbhT1CBMXnfekc+WRwRRLb96tL8z79uZACDZYp3iC5GTOluQN30p2dr/fwyi0lOW
         Zv9g==
X-Forwarded-Encrypted: i=1; AJvYcCWPdaihUzCJHblbDZAJkWiMNhPx9kUuESmOYEyvnLYuhSVeAIsp60cWlvu88SzgEvp9J/Mq0rJiK8GU846jhhqshjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rZgON03q559oC0Kp+GuH52/VgrjkAtQ/uOcgn92V1xZZHQjw
	kwxvp20xkSkRL7IYt9/WEe5lL1grm/PMFg2EXreCtUrutO1XgOXaPzW51XZCegaAISyJDuC6FNZ
	KK1VdFDNzLs1BA8lQWSC7NNGpsQ==
X-Received: from pjtf15.prod.google.com ([2002:a17:90a:c28f:b0:359:8bb2:c98d])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3e81:b0:35b:a8cf:7969 with SMTP id 98e67ed59e1d1-35c30000104mr272692a91.11.1774563878752;
 Thu, 26 Mar 2026 15:24:38 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:16 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2199;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Bkrh8dbtdInO5wZHJbP237TumUuE8eZL80zRafq4z5c=; b=r+Ksvf5Tzi9wrZK3RvQc1ByJZ1ZJxVo8VxXv/mzOeG32ukrA+EzJbetR3GTGB2X4avA5pYEIw
 2Sc+4DsfnYHB5FEh+yTsFYKnnRlz4kYJ7QAOuJpchSQEInd/x8o+zGI
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 07/44] KVM: guest_memfd: Only prepare folios for
 private pages
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

All-shared guest_memfd used to be only supported for non-CoCo VMs where
preparation doesn't apply. INIT_SHARED is about to be supported for
non-CoCo VMs in a later patch in this series.

In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
guest_memfd in a later patch in this series.

This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
shared folio for a CoCo VM where preparation applies.

Add a check to make sure that preparation is only performed for private
folios.

Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
conversion to shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b6ffa8734175d..d414ebfcb4c19 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -900,6 +900,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     int *max_order)
 {
 	pgoff_t index = kvm_gmem_get_index(slot, gfn);
+	struct inode *inode;
 	struct folio *folio;
 	int r = 0;
 
@@ -907,7 +908,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!file)
 		return -EFAULT;
 
-	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
+	inode = file_inode(file);
+	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
 	if (IS_ERR(folio)) {
@@ -920,7 +922,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_mark_uptodate(folio);
 	}
 
-	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
+	if (kvm_gmem_is_private_mem(inode, index))
+		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
 
 	folio_unlock(folio);
 
@@ -930,7 +933,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		folio_put(folio);
 
 out:
-	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 	return r;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);

-- 
2.53.0.1018.g2bb0e51243-goog

