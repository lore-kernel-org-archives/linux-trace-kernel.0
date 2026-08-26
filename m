Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330A3DAABF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735929; cv=none; b=idLElb3/pM7VLOeZjfLWbZ9+7XhCCHmB4OaWmqdKpM7tZ0uiXbbMeWHZBTaxf56YrdqboYKvTRwC29OG7V4KhbDFIt30SArll/za2RVTH1hYFfQskvxLu9l8rYjh7bKFZwrr4UwYT8aGX0YlAHF6PkSterl1y5wywHiyOT8wDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735929; c=relaxed/simple;
	bh=dy0yCBXrZoOYao0bizb+pCfviB0m67TSA6YqDM4S6vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YgWC9A6iBkihQyo5ndyPDuNQCKb5KqcWxN01mCRXzRvG9e8bhvj7kv5y17ZebBrH9oHuGnKLDHbASZWiXEGK3rdn7GZjw6ogRwNPJfRoe4uxXYcMTRPSTn4q4RGXJfzBF2ezq0q4U81OJLmdmF2Uqb6VisegaQFA59NK1GQlNUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TB8Ld8Fn; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TB8Ld8Fn"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso608960a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735922; x=1788340722; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EKp8H31vpndC0T7+bBVQC7oQPgnms4md5owa5X2MPn8=;
        b=TB8Ld8Fnq1x2joS1MUsEipBynLBPuDVQefIGCDV6Q/r7vZdiJEvGFDg2aGjrI9oFgN
         EQdY9UT1ryNO24/+skIgKoG19I1MYzIp5Gxam/ynFzUf7DXaqPFee9OMHV5mr3zTuHdz
         l/GZ94lkPostpPUmtXDoPOZdFjmRHzxBzVHShr5SJmF/lfuIx+kYhUnS/qXMVc9n5B1H
         BxqyPI8AqBy4EbGKPUomwJWIs2ZrKvrqdoe1PYQGldwTkxATuU4uNdKxEYYE/mbsMX0o
         yxZ+0p5ewTT7TVAO8MvQKZMGympfB05W+8xnHf88mVAbLIJboRXFRGtNi2sjUeQgUdlE
         a89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735922; x=1788340722;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EKp8H31vpndC0T7+bBVQC7oQPgnms4md5owa5X2MPn8=;
        b=FkroULfA1c+yT/gFRPLcfvXVSI19IaB1Giz6c1L7prX3kUhbqF05MQ0TfSx6FA+oZh
         UBPgAUpgAIdZREQQ/tZ8io/zC+cr7z0LpylDTViCoXRFhlb2711+mbNyIik9YKzSGNyL
         ABcvfmUzNrWv8qa3xgRhgOTzfqeQGA5NhRzC+fBqxxi7J0m3zEayHvU+tqKYBNVjB3ND
         I1tgiCZjRvhgLz76oHDHNGu1Skx72Q1fmWHJwL7TVcvMcGJsfHHzvPi7JZ1KDW0yXRqY
         56UdbWIrX7b2/hEl1PZ7q1pcR32TwlgfyOylsee6h526PcNQzo8QhTTgLa/VjkbCKpxG
         ir5A==
X-Forwarded-Encrypted: i=1; AHgh+RrGEtJIpD7uBIGNoGMUQ+JNT3rHsYaoSBh5bN7st1oAw07z/tjHBIg2RfaHBxjIOu1RaryQMe8aRVaf73dVlDdJL6k=@vger.kernel.org
X-Gm-Message-State: AFuF++m0XRSrGe+UGcLFd0pOBoCOlnpt8ubBnID9iIn4lKgkw9x37ESB
	WHLHXc/gOVAUPKcFnu2iFM1aAsVsWvloAIueHJBRaqUhrArahjFAMZKQ9FV4oZPjbvJAP4kjqJO
	8ZRxF8t1KpT6jWFScn/6D3U5wzA==
X-Received: from pgbbo19.prod.google.com ([2002:a05:6a02:393:b0:cc1:4e93:a711])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a03:b0:3c3:9c4e:de3a with SMTP id adf61e73a8af0-3cf82a348a3mr11724369637.6.1787735921564;
 Wed, 26 Aug 2026 02:18:41 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:18 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5596;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=NFa90siDaW2AryA30Q8bJ5Qh7q7W2DqG2XaPe8+kXyo=; b=v0d5C4wkWWesFaHM60cN7REFurl8Oyg0VII9TPxllUT2UaIYDsS6Nac84jjl3ihI71jCYcDgl
 xbEFlslA2w6C5IahaWJaj2wX/VE9nKjbCz3wuE3sGID9S2vKNO9OT1k
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-20-0a15d8a799aa@google.com>
Subject: [PATCH v11 20/46] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Michael Roth <michael.roth@amd.com>

Make the source page for populating an SNP guest_memfd instance optional
if in-place conversion/population is enabled.  If KVM can convert the page
in-place, then it's possible for guest memory to be initialized directly
from userspace by mmap()'ing the guest_memfd and writing to it while the
corresponding GPA ranges are in a 'shared' state, before converting them
to the 'private' state expected by KVM_SEV_SNP_LAUNCH_UPDATE.

Update the handling/documentation for KVM_SEV_SNP_LAUNCH_UPDATE to allow
for 'uaddr' to be set to NULL when in-place conversion is enabled, which
SNP_LAUNCH_UPDATE will then use to determine when it should/shouldn't
copy in data from a separate memory location. Continue to enforce
non-NULL when PRIVATE is tracked per-VM, not per-guest_memfd.

Signed-off-by: Michael Roth <michael.roth@amd.com>
[Moved condition to snp_launch_update]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/x86/amd-memory-encryption.rst | 14 ++++++++++----
 arch/x86/kvm/svm/sev.c                               | 11 ++++++-----
 virt/kvm/kvm_main.c                                  |  1 +
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index bd04a908a8dbd..5977fbe33b98c 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -503,7 +503,8 @@ secrets.
 
 It is required that the GPA ranges initialized by this command have had the
 KVM_MEMORY_ATTRIBUTE_PRIVATE attribute set in advance. See the documentation
-for KVM_SET_MEMORY_ATTRIBUTES for more details on this aspect.
+for KVM_SET_MEMORY_ATTRIBUTES/KVM_SET_MEMORY_ATTRIBUTES2 for more details on
+this aspect.
 
 Upon success, this command is not guaranteed to have processed the entire
 range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
@@ -511,9 +512,14 @@ range requested. Instead, the ``gfn_start``, ``uaddr``, and ``len`` fields of
 remaining range that has yet to be processed. The caller should continue
 calling this command until those fields indicate the entire range has been
 processed, e.g. ``len`` is 0, ``gfn_start`` is equal to the last GFN in the
-range plus 1, and ``uaddr`` is the last byte of the userspace-provided source
-buffer address plus 1. In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO,
-``uaddr`` will be ignored completely.
+range plus 1, and ``uaddr`` (if specified) is the last byte of the
+userspace-provided source buffer address plus 1.
+
+In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
+ignored completely. For all other page types, ``uaddr`` is optional if in-place
+conversion is enabled (i.e. when the data had been written directly to
+guest_memfd while the page was in the shared state) and is required if in-place
+conversion is disabled.
 
 Parameters (in): struct  kvm_sev_snp_launch_update
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dff684b88f153..63e8cfa9bf559 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2400,7 +2400,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	 */
 	if (ret && !snp_page_reclaim(kvm, pfn) &&
 	    sev_populate_args->type == KVM_SEV_SNP_PAGE_TYPE_CPUID &&
-	    sev_populate_args->fw_error == SEV_RET_INVALID_PARAM) {
+	    sev_populate_args->fw_error == SEV_RET_INVALID_PARAM && src_page) {
 		void *src_vaddr = kmap_local_page(src_page);
 		void *dst_vaddr = kmap_local_pfn(pfn);
 
@@ -2433,8 +2433,8 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
 		return -EFAULT;
 
-	pr_debug("%s: GFN start 0x%llx length 0x%llx type %d flags %d\n", __func__,
-		 params.gfn_start, params.len, params.type, params.flags);
+	pr_debug("%s: GFN start 0x%llx length 0x%llx type %d flags %d src %llx\n", __func__,
+		 params.gfn_start, params.len, params.type, params.flags, params.uaddr);
 
 	if (!params.len || !PAGE_ALIGNED(params.len) || params.flags ||
 	    (params.type != KVM_SEV_SNP_PAGE_TYPE_NORMAL &&
@@ -2446,7 +2446,8 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	if (params.type == KVM_SEV_SNP_PAGE_TYPE_ZERO)
 		src = NULL;
-	else if (!params.uaddr || !PAGE_ALIGNED(params.uaddr))
+	else if ((!gmem_in_place_conversion && !params.uaddr) ||
+		 !PAGE_ALIGNED(params.uaddr))
 		return -EINVAL;
 	else
 		src = u64_to_user_ptr(params.uaddr);
@@ -2493,7 +2494,7 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	params.gfn_start += count;
 	params.len -= count * PAGE_SIZE;
-	if (params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
+	if (src && params.type != KVM_SEV_SNP_PAGE_TYPE_ZERO)
 		params.uaddr += count * PAGE_SIZE;
 
 	if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params)))
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1ea8198821917..05c518c9b8078 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,6 +104,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef kvm_arch_has_private_mem
 bool __ro_after_init gmem_in_place_conversion = false;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
 #endif
 
 /*

-- 
2.55.0.887.g758fc8c411-goog

