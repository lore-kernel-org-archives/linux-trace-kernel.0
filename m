Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32853BA225
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563922; cv=none; b=SurjJSLVjIJniO78xVFk1YR02LyliARKinZnslg7KeOeuj1QcIpzilqa98n5jfBEYARcoyXlhiu/Fq16vQvprdheUnJbAvQJFLwUdmYUvWjJABakAQSNEJiHDoNRpgQGfVM81kh3/2+kSJMM7FfmEz6F12zsf96xBg4iwoEPpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563922; c=relaxed/simple;
	bh=wRfY1Jn+9IVOYoMa8jY758mvqEtTI8tV2HC+aaXp76s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pdyF8uWHzwVZlIb9uqmxvFlCDd1KTvHON+2vtnlqqasiWU+H2ltDW2QToPANig6+tyjkJZZR8GUjG6rSv53OaBkEjxyCsk1GbB1Xi8NWHwRPlrPBnodt3inUGgP39PKoZhyRoST5Q0/7iZteBAx4m+0xoXVBNYbArEMRDQCc/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nB1sweSw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB1sweSw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso2916500a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563920; x=1775168720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIzVYLR/FSUWm85vLUs87YDAHw4Wlol7nmVi6FxJ/b0=;
        b=nB1sweSwNzWZKd0eQAQ5szsZKjCprvX2qQFaWRTNMAkmf+6B7S+c4iE9jGpyekiui2
         Fn6guvYWjpxNoCcMSPzn9j22SQL9aRMMiv8/eMoGrOOjQhexQHsnJBu/3BLs33xprplH
         b2Cc6rg6E/Wt8abV/6Jzpn5XSGbKAMMZXj5TDbbeJSTi3uOfhnc2LhEHFv5zQLT/gzRp
         IW5oo2UTh1TpfcVrX3xl1C3msJ3uaH4Y195LFMSwAx/DzHqAO9LzbKAuxi7/JfeXq0a4
         EYS0zWTU7p9h4WwDyBh6nhr+c0zFk6M6dwSq1aQ/5BLkyxpnhjm5p2vqpPWZnAWFAowX
         6nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563920; x=1775168720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIzVYLR/FSUWm85vLUs87YDAHw4Wlol7nmVi6FxJ/b0=;
        b=OiVTvQFZwzBWZEVbbnsnDJiQt2h7vN3sYbJx1AYwULXAEpUiijyxqgN/aHV4w+ZJKr
         j4CniWZeZvdVpuCWRlnCRIB4XWvnN4DPEU746oDsM21CO4w7BXUXgmDIlFhq7i2vrf8C
         j7zImoETT0OOg9nWkDWfXTpK5c6NBzIt5xN0kMX3UTdR5shlkWkKLT0SOQYynxfi9GC4
         JUg9XdockHw1lgCAzTCpq/e6h/8nHhyvHsD/P1y1M+fBvmYHwijpTygGugF5DEikWXKI
         xu0eBr+pUekDFLpb+W7S5z34NMihyCTO6W9ZKJdBXLNo4nLx28Tf+30NRF78JrAMrDcJ
         tsLw==
X-Forwarded-Encrypted: i=1; AJvYcCUIxeUj7gYk0DzH9WUhVDNTPdwnHkI/AKSzfkdGofcOAAqUcRUCk8jkwMXHolHUJs832AuoFc4rliwHpUh1D6HP1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdT2m19RzFg5puglvxs8PtRbLTscX9vreRjBdRtrQapj8oayBC
	LLdw+3TQ/w+phB0bnd4asMreWrFG+ybu+18kqxzKFU+k36n/qcganCFocSsCHTCDiJFHVXy932C
	1RvVa+FZe+Zo1KOOnL+jMqAxkOg==
X-Received: from pfjt19.prod.google.com ([2002:a05:6a00:21d3:b0:82c:6ae6:e5b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9a6:b0:82c:6d88:2a8e with SMTP id d2e1a72fcca58-82c95c1133emr168762b3a.20.1774563919656;
 Thu, 26 Mar 2026 15:25:19 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:36 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=4465;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wRfY1Jn+9IVOYoMa8jY758mvqEtTI8tV2HC+aaXp76s=; b=Iwk4pQNeckXclXoEM1Aas23TToytRGIPodJHXlnaUzRgEA3ZxoElFgD1mmgzcEoO9mzC7z3Sa
 MbCRq7O0sgoB82kC/gB6bsmiYm1TnEJqhIm2wTtU37WXhw2ymIQgiGS
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-27-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 27/44] KVM: selftests: Test conversion precision in guest_memfd
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

The existing guest_memfd conversion tests only use single-page memory
regions. This provides no coverage for multi-page guest_memfd objects,
specifically whether KVM correctly handles the page index for conversion
operations. An incorrect implementation could, for example, always operate
on the first page regardless of the index provided.

Add a new test case to verify that conversions between private and shared
memory correctly target the specified page within a multi-page guest_memfd.

This test also verifies the precision of memory conversions by converting a
single page an then iterating through all other pages ensure they remain in
their original state.

To support this test, add a new GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED
macro that handles setting up and tearing down the VM for each page
iteration. The teardown logic is adjusted to prevent a double-free in this
new scenario.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 81cbdb5def565..3388f06bc51db 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -65,8 +65,13 @@ static void gmem_conversions_do_setup(test_data_t *t, int nr_pages,
 
 static void gmem_conversions_do_teardown(test_data_t *t)
 {
+	/* Use NULL to avoid second free in FIXTURE_TEARDOWN (multipage tests). */
+	if (!t->vcpu)
+		return;
+
 	/* No need to close gmem_fd, it's owned by the VM structure. */
 	kvm_vm_free(t->vcpu->vm);
+	t->vcpu = NULL;
 }
 
 FIXTURE_TEARDOWN(gmem_conversions)
@@ -105,6 +110,29 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
 #define GMEM_CONVERSION_TEST_INIT_SHARED(test)					\
 	__GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
 
+/*
+ * Repeats test over nr_pages in a guest_memfd of size nr_pages, providing each
+ * test iteration with test_page, the index of the page under test in
+ * guest_memfd. test_page takes values 0..(nr_pages - 1) inclusive.
+ */
+#define GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(test, __nr_pages)		\
+static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,	\
+						const int test_page);		\
+										\
+TEST_F(gmem_conversions, test)							\
+{										\
+	const uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED; \
+	int i;									\
+										\
+	for (i = 0; i < __nr_pages; ++i) {					\
+		gmem_conversions_do_setup(self, __nr_pages, flags);		\
+		__gmem_conversions_multipage_##test(self, __nr_pages, i);	\
+		gmem_conversions_do_teardown(self);				\
+	}									\
+}										\
+static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,	\
+						const int test_page)
+
 struct guest_check_data {
 	void *mem;
 	char expected_val;
@@ -205,6 +233,48 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 	test_convert_to_shared(t, 0, 'C', 'D', 'E');
 }
 
+/*
+ * Test indexing of pages within guest_memfd, using test data that is a multiple
+ * of page index.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
+{
+	int i;
+
+	/* Get a char that varies with both i and v. */
+#define f(x, v) ((x << 4) + (v))
+#define r(v) (f(i, v))
+#define c(v) (f(test_page, v))
+
+	/*
+	 * Start with the highest index, to catch any errors when, perhaps, the
+	 * first page is returned even for the last index.
+	 */
+	for (i = nr_pages - 1; i >= 0; --i)
+		test_shared(t, i, 0, r(0), r(2));
+
+	test_convert_to_private(t, test_page, c(2), c(3));
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_private(t, i, r(3), r(4));
+		else
+			test_shared(t, i, r(2), r(3), r(4));
+	}
+
+	test_convert_to_shared(t, test_page, c(4), c(5), c(6));
+
+	for (i = 0; i < nr_pages; ++i) {
+		char expected = i == test_page ? r(6) : r(4);
+
+		test_shared(t, i, expected, r(7), r(8));
+	}
+
+#undef c
+#undef r
+#undef f
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.1018.g2bb0e51243-goog

