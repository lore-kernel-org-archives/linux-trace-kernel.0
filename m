Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60844749DF;
	Fri,  7 Aug 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139570; cv=none; b=NEVLmvlvthXn64ma8teOy89rTsavqeckYrbgDPlbdbEf7CoAGxOyJg5knvlTiM2p19K3NB74H8OKmzf7ZlDlGgfugbGO1uIhdXGHC97Nq1a2XGSDnlojaIMnE1nF8QUAWY4vbgYsJcO4/YdNFGKl20VFtz6C3HDAGNWWL6CzvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139570; c=relaxed/simple;
	bh=zMXMT+CDwoTrBMuFmmiwUiagBKEjr4ONLUkzSNsyvXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d28hWxA1m/qzz/BqY9lkbAUs9EgQysYLTS/7bERw2sj4KuFe2U4I7rKcLoTGgamXM0k4MTyzeJ/XyAR+pROSEpIZR6U9ejnW+Bng9sb5suyc6VRrDvqwg76aWfdH0Ym1fRD1bW64PluyIzRGnxSSqkOW6w6h6JQyypcoM2fAkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRwBCpot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRwBCpot"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC2BC2BCB8;
	Fri,  7 Aug 2026 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786139570;
	bh=zMXMT+CDwoTrBMuFmmiwUiagBKEjr4ONLUkzSNsyvXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IRwBCpotsMnRqE/t6vavV+M4sse+zzk7TBSXJwNTqlg1x94Vbeksur0htLnBjMrvM
	 1SwGLaiJ0o73mnoTwcgUEQaZQSv1y/EdT+2UWYvtm0i0D4KUR4XGYjNvTYBiJqrJaO
	 QoMoGIK3AySjaXRQL6LxeRjJM4RkCc2hyAMnq+sL9qq1lVEkSrU2S+ewYBLzUvH8YB
	 oXF1rnmjkAl9vzvwFCegc1hua66gfVuQPsSVHFIgUjN+DdorY5Dn60ffJ2vMBWkB2s
	 Yxt6yhXfo2cz/SKCdnfN3OtqMhkbIc0S593XUDwor3TSQyj4lyMSgCoFcoLw8k1x73
	 wroXB1cSBBYeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7611CC5ACD3;
	Fri,  7 Aug 2026 21:52:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 07 Aug 2026 14:53:07 -0700
Subject: [PATCH v10 28/41] KVM: selftests: Test conversion flow when
 INIT_SHARED
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gmem-inplace-conversion-v10-28-2fc18ee6d3ba@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786139565; l=1820;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=LCMkQdX+H3WVboFtkpu0Izn3eeZarl7aVfYLiu9r/3g=;
 b=Lg18aCDxNaQup8NnlNTU3r1S8o1MRkDWstNEis+KSXSyH1OUBseYjRh3CJcj4zFmpEdW+XyOJ
 IxkFnrEGoYoAIKkN6uEs1bKZAjbgT73XPsOUXQEIVLnllJdawedKU53
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add a test case to verify that conversions between private and shared
memory work correctly when the memory is initially created as shared.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_conversions_test.c        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
index 77f95d49349ce..4c20d3d8e9349 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
@@ -97,6 +97,12 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
 #define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)					\
 	__GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
 
+#define __GMEM_CONVERSION_TEST_INIT_SHARED(test, __nr_pages)			\
+	GMEM_CONVERSION_TEST(test, __nr_pages, GUEST_MEMFD_FLAG_INIT_SHARED)
+
+#define GMEM_CONVERSION_TEST_INIT_SHARED(test)					\
+	__GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
+
 struct guest_check_data {
 	void *mem;
 	char expected_val;
@@ -188,6 +194,13 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
 	test_convert_to_private(t, 0, 'C', 'E');
 }
 
+GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
+{
+	test_shared(t, 0, 0, 'A', 'B');
+	test_convert_to_private(t, 0, 'B', 'C');
+	test_convert_to_shared(t, 0, 'C', 'D', 'E');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.55.0.654.g21b8a5bc05-goog


