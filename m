Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F427A907;
	Mon, 31 Aug 2026 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135920; cv=none; b=PCut52w2dw3UiY6xX3jTqwbkmUJ83WkdTmXpK6RRGYrHAkM41hIQWSnbvRJTMERLR2EhdqIEzncBKbD7KLkCKH6W+LJdQTvrV2DNggR+fLdb/0AcW+0jB1KUQdvgFY0rKpL6ADpRBScvQhnafLkpcnjiUDgKnILGN2mbLs8oW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135920; c=relaxed/simple;
	bh=yiocxA49550KUCzo+T/5GJg/8zdJWfhnYG1cFdaaNSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OO8WBvGnhUrx73Jh8bInnr5bimPxzQQpOphOKDAlccrGoEs+aBGf/Y+A89mJUWdvkmo20wmwGECdsfxTCSmlqKEn/8ocNRWGaSnWI/RAs+PcEQCid6UDLodDuqa6DGEh4Kwt7wJX+rGNu/IIBdbjB6JOdM6OEcDOpE+M1gQ4UTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcwrx3xV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcwrx3xV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6194C4AF17;
	Mon, 31 Aug 2026 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788135919;
	bh=yiocxA49550KUCzo+T/5GJg/8zdJWfhnYG1cFdaaNSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mcwrx3xVKrw7T1MSZ2sW1ftA1mFi8bY/BSWRzLgPsqEPrbTFpHguRcFKPiZJdqLh3
	 +uMrgEzTGPEViQTFLuXMKyEJB9fdZoO5+0xGd9BGKNa4KI1gWRcAv6bFweeCqyFSrS
	 bSvXhYUPEAWJu51b1eSpkQCMt8i3sgt0d//1XhxYni6GyF9dBWQwumlE2lNbvJVAeo
	 CVDqOKpdsolJOeE+bunKAJYHgWIkKk9CmbiyQDvSUWYLXMjBfOcFhoAcbZKzmIiw+D
	 KyzKr4IZ3IG+301E/VYad8pZz+LWpn4IvRJhVnG3/0bVHCvoOQM4mudvUpHPtEBzFb
	 eATcDh+aftF7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F9AC61DF1;
	Mon, 31 Aug 2026 00:25:19 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Sun, 30 Aug 2026 17:25:03 -0700
Subject: [PATCH v12 02/45] KVM: guest_memfd: Use kvm_mem_is_private() when
 populating guest_memfd memory
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gmem-inplace-conversion-v12-2-85e5fd25252a@google.com>
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
 suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
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
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788135915; l=1236;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=J603Sitd2IbIuBFVZAUo4Wjqwpu3VfTvCGGSI7vmMZw=;
 b=z1YCMYJwV4u7T1sNVHAC3h7gI3Q7k56jpxSLyvJRX3D5GfhJNIFP05gy8Y0FpE9NEMLL/4MSl
 1WCUEPt1h8tAH7mYqnxVUByUNSnEvOicaThuXDmg0bin61FAkF+2Srv
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

Use kvm_mem_is_private() when populating guest_memfd instead of using an
open coded equivalent.  In addition to simplifying the populate code *now*,
this avoids the need to provide a range-based gmem lookup API in the future
as well.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2190e4d6b6bea..69612bf146be1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -805,9 +805,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	folio_unlock(folio);
 
-	if (!kvm_range_has_memory_attributes(kvm, gfn, gfn + 1,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE,
-					     KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+	if (!kvm_mem_is_private(kvm, gfn)) {
 		ret = -EINVAL;
 		goto out_put_folio;
 	}

-- 
2.55.0.897.gb25b4bd76c-goog


