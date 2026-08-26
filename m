Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092763EB0F3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735950; cv=none; b=hlyrnHwl+6XPCyrwV3sbjQw/Wz1z8ezCOU1nOSSszrY6eE4tp0q8paioAe2FbrjVXaAU0mPAkwRkkjz8PY4WmfykKo8TzsRfCFRC9WLQqO5DUXE1jZX1mWWkb47SLG5MjuGoDt+XF4JT8qgsWhAejHSOE7IPamqsd4TJGuovgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735950; c=relaxed/simple;
	bh=Z2UFei2SRBY3/wzto9IlHBrYtnnFhcb6Xe3JALubj7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkYELqRDyrS0tdKGnvXSxUmrFN/5D+FZeDpI0TV8kAkbch6rxYxJp46FC5TOkK1X8zfC7fE8LplRlompbjluTQwEff8k1/rc9NsS7ukEc1DXahQvE6YHStJs59k6H6mnA8jLujVMklQSpv6TsbeEGZknPyRNoMVJGC1ozpTDuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKSvIGw4; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKSvIGw4"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so12879965ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735944; x=1788340744; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+QIStebluGuNMlcnL56N5FeU5gomqFB4kLU+1RXvFs=;
        b=pKSvIGw4gHzl277z2O9++u8ArJO7/iN+6GosdgORq6KqRqN3i8IQiNP+ayOReQ7A2b
         U2PBUNQO6GMcv0ZnyL7+wTEhOCmrjufb3sSvf/aM7+8hvNI0NzKaP8gaxqz3nlMOSenY
         yt6EYNUw1XCVP+RPGeYxakgo3h2OX/MJusHgSXY0GMLANeWsEd9Kmt//D2Bg8LyeNSjQ
         qlWsAJ2xTAFr9m2DtJccGyaDwauOI2CNEzN0UbI6jbGqG/GuR+fEIYks0k2xY1Y90zgo
         c7qads9jyIem1l+LaBns1sturFDi1YGCdH/okxckmVhd19e0vwEM7xs0a2J6SlhUvIvk
         R3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735944; x=1788340744;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+QIStebluGuNMlcnL56N5FeU5gomqFB4kLU+1RXvFs=;
        b=diezrjvhSr3NSOWkKNLLluf62ZuB209SVy6bj0c431GHXeKMsdqZdEG9imkFpoj9kX
         YF4T3OddcdXQGU+BfAUHl+upEPxYRQn609vybxo1RVZ1+sIQKVZT/QfqInsGno4aEJYn
         XY3N/IsPlonLU2VGzo3FJr38p/tNZQEDhs7yM1sznkwXqwk3///iRMYEKFCggs2XPxQU
         vtfqtH7Xe/x6FChBvL+CSrGdeY27HmPx930dgZ9nXo/xVkfP8nwHO/Vk8+CY1k/jH7V1
         O8GdFULzpr5wojCIPqTP/o8dC1GrpczeMpSW3skqEjzYddbN147yoN3iboo8dZtIWzmG
         FT2w==
X-Forwarded-Encrypted: i=1; AHgh+Rokm94i0sDef59UMn9XbyxR2Pdv2aAnxWLbUp/VJnBB9UniDWXI9aEk+M92cf7Eg/YSHUuCiL3wSTd4fTgJ8zeuN/s=@vger.kernel.org
X-Gm-Message-State: AFuF++mqzp1o3SkvY8CTmYNg5i/gnOdXHsThuHRmvbsJnu4X8ORJy+Cu
	EnoRcKhZ7Ar6XxBn9nxhdxpGeumFuF0ULbs8Cy0X89CELNavhig6TX3ZBrTOzXdckk+yUv+l2Gv
	4/42uVcKUPZ2rjLinv2znCCgLDg==
X-Received: from plblb3.prod.google.com ([2002:a17:902:fa43:b0:2cf:75c1:ab87])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2283:b0:2d6:7409:7145 with SMTP id d9443c01a7336-2d707a2edd0mr90992585ad.1.1787735943792;
 Wed, 26 Aug 2026 02:19:03 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:31 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=1811;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Z2UFei2SRBY3/wzto9IlHBrYtnnFhcb6Xe3JALubj7U=; b=iF9oclctKMAmtq8/BXAmeziLVob0gwQiMxab9AP4cOna1dViC2KVb0DXsHietLlhMm4MmiLFx
 NG5IyiRqrCFAgls8o8R4aRa0shTBIbhH28LRiR+I6Ogpy3OSwNF8ZVo
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-33-0a15d8a799aa@google.com>
Subject: [PATCH v11 33/46] KVM: selftests: Test conversion before allocation
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

Add two test cases to the guest_memfd conversions selftest to cover
the scenario where a conversion is requested before any memory has been
allocated in the guest_memfd region.

The KVM_SET_MEMORY_ATTRIBUTES2 ioctl can be called on a memory region at
any time. If the guest had not yet faulted in any pages for that region,
the kernel must record the conversion request and apply the requested state
when the pages are eventually allocated.

The new tests cover both conversion directions.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_conversions_test.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
index a8d89df53e46d..f46f1530a94b9 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
@@ -268,6 +268,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 #undef combine
 }
 
+/*
+ * Test that even if there are no folios yet, conversion requests are recorded
+ * in guest_memfd.
+ */
+GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
+{
+	test_convert_to_private(t, 0, 0, 'A');
+}
+
+GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
+{
+	test_convert_to_shared(t, 0, 0, 'A', 'B');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.55.0.887.g758fc8c411-goog

