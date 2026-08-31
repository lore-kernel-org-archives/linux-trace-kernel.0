Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625B317173;
	Mon, 31 Aug 2026 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135921; cv=none; b=ASQ8HXZp9IKdOT8Qh/3S6f7Po27ty0b7MmBrVYeu+kHfPtRVU/5y9FYDAH7zEWbrHDPCwa4PngH6JuFVGg/fDbMZW2FoMIWkOsPdUnURJnL2slaWVRF0NcMEG5NuvE/XQXHu2BDOegpiqZUE8jlZhauEIx1sj8JrYa+1dOP531c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135921; c=relaxed/simple;
	bh=I+b7lGuVoGz+swvsL7rzFlWNT2yN4ZfPLfGq8P0JE3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgZeq5IrSN3XG/jA32rqhuRiQvF7Vn8EwN+v+fGB1NEkV8ygACdj0wBn9MN8lLIfp1tcsVt/Lu47/+pInPlfsyfDBEtRl1bahr29sYOZpAAFzzXnHSrb7EHWvyqX4CNWrnZgiUTJrTLdedbrQjYel/Yhy8+DP0iIOfVzW9V718g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj9sQJoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj9sQJoq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C30DC32781;
	Mon, 31 Aug 2026 00:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788135921;
	bh=I+b7lGuVoGz+swvsL7rzFlWNT2yN4ZfPLfGq8P0JE3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Nj9sQJoqAPH0H2Yl/kBKSHC4wJEQbhF/k/eQKR8YVNhkLabYa8ZbV7iEGoFE4zoAy
	 mivPWY0LAI6h+61PLFMjO3hyDhkF6xb54oD3u/Yh3YEibteGkUS9GHGUSfFkcnvl5u
	 /YbILdp9/gVWOtixolSLpfk60LouFI0p5WsxIJFj+iTfpa1nMTwVRU5wl84CpFAmxR
	 iwafjSxSt4kPOUff8JIYs2G8ILnrN8cWbEr2bwvF2HnuLjqBwccZ5fLR3W543iUo5O
	 eaZhWAgZNoF7drPA90u5RZT+blPY7SUXSbS9TaH6K9qN/dtg6Klh1h5pl+iWKsZd4t
	 nsbCz+BxfSuuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86861C61DF1;
	Mon, 31 Aug 2026 00:25:21 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Sun, 30 Aug 2026 17:25:21 -0700
Subject: [PATCH v12 20/45] KVM: SEV: Make 'uaddr' parameter optional for
 KVM_SEV_SNP_LAUNCH_UPDATE
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gmem-inplace-conversion-v12-20-85e5fd25252a@google.com>
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
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788135915; l=5596;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wPi3PLQGrKXDeuAU5z9J7AGBTrQFd9B/lpdUMyrGDEE=;
 b=9k/bLEF3An1XBhsojLn0UeoSCr6PDB828IGyADWhdI3CcerN0zYcgRaFKrrd+pDMI6fEmwe7e
 Jh0JJIyXJ9DDWGXI4dES9EK0noyDEDN1Lyspx/TT+yisOfiYEXsItsu
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

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
2.55.0.897.gb25b4bd76c-goog


