Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEED3C13EC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735948; cv=none; b=CXLxOc9TMYijbQ1BIO74kGt7KH/JkI/GzS8a7b9llk0DFn+ZdKgl3oHC/QFe2+P8BmbGLyCN4C4d8tFbZIrMR3d8rxrLMiV0tCVYjUtfJKAiXjyurYEQ48bsLtjMZasrDB3jhB+u96p7tS2ASMj9W5BSu6W+x6oKZWjHhVczY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735948; c=relaxed/simple;
	bh=m1EnsponEK3ffE+S4viVcHUMFCcCRT7Oe+a5rZdir9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FaT7VeloS+zGc/XwORbXPYIa7FoBueJvke17hiIwh87/ATpRNFGpbdH1ENMPUtaQ4XA/3uhG2z8ivTUHMB+de7YFUV9wbqwslvxDUMMLY33ZbgzzvrafKSrx+VNyLbaxLA4+t8Ma1mh9lFFRw5RJQCNuniDHmWrz8wvN1/MYIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uaidFdF4; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uaidFdF4"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6f75c1219so17208765ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735941; x=1788340741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mryHVYsFMw5QfnvdlFWfWH3DHg2cIJI/N7Q9jVqtsNo=;
        b=uaidFdF412pgYrjdMsmMBt+QQedqUONbIfRJfLb/gBTVMFDETtaoJuumosk78GeTDw
         rIBl5oMM0QU4NRdqWcqsMTkYsspTfvVWZgv5YcmAT025ttslDbsLGLyw6MobiIjO1mdi
         6TKKzZu1LWKg+olvhzH6uxW9ELKiL4Ju+/9HI+WNk1AkjIaaYaORSlaFenv4IpqA1TS3
         gu9+oHyaFyg8fKNqjdsfenm24fSSz0Ekx5tADTlrbhXE80xe3F9Z+6bQjtQCHFFWIR8z
         BY/wSYyURhaobEwicuyvyo3v2tphAkt63kzT4KcUNWch6OMzTtsWwVLaLGLYdkVn+8iS
         wfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735941; x=1788340741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mryHVYsFMw5QfnvdlFWfWH3DHg2cIJI/N7Q9jVqtsNo=;
        b=DOm1weJGe9v1PpuIPF2l7jkegJ0hCOlfb77AV21H97arP6c91Yxj13sJqwuPw0Sa0J
         IuxkPwHeGwvzPttPaeF2pTPWos1oyeFQ8i4N/v16mmJPkTZ7uAH989i/hsvZnyAkHdiP
         lS5MCR29kwHUUZBX+h6pnuiTqiqSLNaYOmZdq+/iwAIXAfu8YyYeEt7aE+0q29puZdo4
         jFhQYPMbpDVcSlTIjsowb8IP056Xv1JjMy4xea6vz74XB/O0yb3iHI9l7LjvJwefsX3S
         9XjYWYtw0yAU3By43SX1maR+M4Rhh6rmCX5V3ZQ55SpxzeoCI0dX5dHoX9ea5ncixk5A
         HibA==
X-Forwarded-Encrypted: i=1; AHgh+RoC58pkwWfmaSmtgCdbMIq/CSAVGyq7CX70ciKtrT3gGMN4fTS3CNa+RcRgDcON1hJU++waUOYQ/uL2pdnwXGky90k=@vger.kernel.org
X-Gm-Message-State: AFuF++n77Psq5EOnmWr0OwN4vSTlXLvN7Hhj7JTktWPBKQmmTn9ySSOw
	GMRaYskvPG8U19X0yg21WFVc2jwMLFVXJ+1UxC7M5XheLYLbPVXQHAb4PdMB31NCMwd8z+4a6/C
	FojU+dlF7BU9JFoETvFrT6M2kyQ==
X-Received: from plblf11.prod.google.com ([2002:a17:902:fb4b:b0:2d6:eae9:3470])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d548:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2d707953a04mr97889795ad.3.1787735940315;
 Wed, 26 Aug 2026 02:19:00 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:29 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=1820;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=m1EnsponEK3ffE+S4viVcHUMFCcCRT7Oe+a5rZdir9o=; b=qZJHVh35jrourMTzyQzc+m35d5hPzDRKD19154Bae8Nxq+4fEcdWMhoaHFA76qJd8wJSveiTc
 yd1CymUqKYyDI830woVD48JV9E21apI2rkTcg9PPgAYBmpucJvjTMcK
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-31-0a15d8a799aa@google.com>
Subject: [PATCH v11 31/46] KVM: selftests: Test conversion flow when INIT_SHARED
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
2.55.0.887.g758fc8c411-goog

