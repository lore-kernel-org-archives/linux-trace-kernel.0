Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D532DE70D;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285309; cv=none; b=tDA5c8vSeULN9bMnwBjXKk7HK3mTqkCRnMGTdU/lxA3ckwk73U+NNfnYhgLeBoEEqLkKNwE7FATiejraWEvElw6RrYHKqBJxAi030RYqr+hAE/t7sfFxd/+Y2Twa34tNfaHHAbtO0LI/okAOztoeJsyminQZRk6rKGODopNnQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285309; c=relaxed/simple;
	bh=tLm2sExVUSHllXBvt40VdvuFXPpT1kf/TFtQbm5kn1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jtrUqIErEYCThNR+pdR9XJLaVA2ZTcQsbYIFBVk/nkrrJ91XZdkM+NnCtL+WDWe7Poy2ZKZ4XgNkBzn51EeWhTEMuocYl2aOMmJVB6mTVm45k35gapxzrxMGTmwIwMjClO1QhiBNKNeKNi2gp026BguA9ZAIlQwRrCk9sbMgYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn9xtmoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn9xtmoa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28100C4AF0E;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785285309;
	bh=tLm2sExVUSHllXBvt40VdvuFXPpT1kf/TFtQbm5kn1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Cn9xtmoaz38gK0Gsv/+vV+vvKnmTsjzhJDGYsIOaYyMPziTPwFq9DCQECJlnHSqXr
	 MrZaXhSRW1FygiRxlCsszE9BkV64yTuHjy1B1JOsAT4RV90pC7LZrwNTPhVqc75BZT
	 5TIHW0J0wuLxxlkElMxAkjipqxM+KMB8PH8E0Rl6Ss0PTQJz8ov+eJFCCVCuNB2vJG
	 7zSRQB+VfvY1baAXOhdY095ScrQsi0t9/vndtqs0wBoRGvWwZYuz8CDShc3FSch4rp
	 YniiSjv0nnO9COWGAgELOZGBmBnut9VxzOlEgbQc3mqASdvZxlXXSCIepm0sG/wW6S
	 GTFU8KKS4w3Pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0805AC54F57;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Jul 2026 17:35:15 -0700
Subject: [PATCH v9 16/41] KVM: guest_memfd: Zero page while getting pfn
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-gmem-inplace-conversion-v9-16-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785285305; l=2515;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=DnfgdOILwJaXU85D1SeMtvWbci6InAPagvN5EQKjyoc=;
 b=5QNKwwgi+Uzc6y0HVwMEajeW/iXXi/Id2T0nEnh8Gqp8MociKfCV8TPimFMrQ037jMYqJdw0f
 5CAGysKM1R5Bqf0l51NuoBE9tO2EEQ5+z2zgB4+bfVerbepvHMNlpEE
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Move the folio initialization logic from kvm_gmem_get_pfn() into
__kvm_gmem_get_pfn() to also zero pages if the page is to be used in
kvm_gmem_populate().

With in-place conversion, the existing data in a guest_memfd page can be
populated into guest memory through platform-specific ioctls.

Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
might contain uninitialized host memory, which would leak to the guest if
the populate completes.

guest_memfd pages are zeroed at most once in the page's entire lifetime
with guest_memfd, and that is tracked using the uptodate flag.

Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
kvm_gmem_get_folio() since other flows, such as a future write() syscall,
can get a page, write to the page and then set page uptodate without
zeroing.

This aligns with the concept of zeroing before first use - the other place
where zeroing happens is in kvm_gmem_fault_user_mapping().

Don't mark the page uptodate again after populating, since the page would
already be marked uptodate before the post_populate() call.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 505bb6747620b..ea2752989f8bd 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1078,6 +1078,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 		return ERR_PTR(-EHWPOISON);
 	}
 
+	if (!folio_test_uptodate(folio)) {
+		clear_highpage(folio_page(folio, 0));
+		folio_mark_uptodate(folio);
+	}
+
 	*pfn = folio_file_pfn(folio, index);
 	if (max_order)
 		*max_order = 0;
@@ -1107,11 +1112,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto out;
 	}
 
-	if (!folio_test_uptodate(folio)) {
-		clear_highpage(folio_page(folio, 0));
-		folio_mark_uptodate(folio);
-	}
-
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 	if (kvm_gmem_is_private_mem(file_inode(file), index))
 		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
@@ -1171,8 +1171,6 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 	}
 
 	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
-	if (!ret)
-		folio_mark_uptodate(folio);
 
 out_put_folio:
 	folio_put(folio);

-- 
2.55.0.508.g3f0d502094-goog


