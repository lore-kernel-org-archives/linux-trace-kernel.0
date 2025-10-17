Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7533FE27
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731993; cv=none; b=Bmr++3syBjhocCCcBXnwIYm6ZtkOLDDwHIaxckDSNt4Q05scbiZiV+oOrVrSD1Vw6Py8rtDh3VXoxIsBZxh0n6sZsP92jvxmicD7cvNGRgNsNd+bjJq4NIMojJytAP39/BtpyoHIWOu94KpVx01zdokz5yeCkf74+cBZM9jPmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731993; c=relaxed/simple;
	bh=EVAkBrWYKSktzVzX4VzdkAz/5vr0/zLtk66b8tSjWR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDIdfukfVA7NNpOyAR/QlJo5vWuAwOLUInze6dYVHTYNHqVxVpfJxYzbojRnfjMT4b4p4Qo5rrw/6toCMOQEqdgONGsx78ZCiUuAh4xtYlR92JhbkRdkNIDpQ3qJ0pHzTQandmtw6H1Y/sXMu4TuazDeiMVeHJYAJoDpgJdiWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaDmE1Ui; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaDmE1Ui"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso2023797b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731987; x=1761336787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zq46JIno/oLWpmCm/slZY48TlgDXZ3V4yLa6+9x6pNY=;
        b=xaDmE1UiXMtux7WVhVyo8NCkfTZIJbNTvJ4GjEDaMgl6yBznVZFKB9wkmFXcjEfIWa
         xllnf9c/fYL+bX/TiLNNp7QHtZu3kKOfg4atu+WCcTr35Yu0lzRZq1IFRz/EES978JQu
         LJz7hpSKtmw5uM8OJ6WaPTa8L0b42VuAU8hXisnZ3xJvTwPZrAVmaEKeBpaslSquUYap
         hslSMP2VRr650w4JY5/YSD60B1VzJOf3rpjfhKG5FgcvJYjQuMdNQmjPeMImmV3z8SBK
         40HEn8ULqOy7zykRHs7EMlsl2HPeDhNvb9dF0DacJbOhmth7nGz1iqIaregj3MUZ4XFG
         5uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731987; x=1761336787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zq46JIno/oLWpmCm/slZY48TlgDXZ3V4yLa6+9x6pNY=;
        b=xLaNeQAj5GBSdbSoEt2OdZXoWCINGQS3y6x/qIv1v0KatNFr+fejQ+OB2xvwG760By
         OA6OGKL+ak8BPm3UFSlgvxVPScriqWleMxkMZTZGqKEd4un5HjqxqBXK+5mKp6WQJ2hv
         T9RX4BgY9ekfEq4StCTq5jiKDv8UEEvERj6hAHGvIM/yWbDi2tSu92iaasL63m8zpApF
         p0NnO4DtZ+wTFWfTfZOsvp2xsipH34V8g001NLgvXuSXW48oLifkpDPyq1RHeyWGz3kS
         ZljzLEcMXHFteWR0VPC9ycfVjQMfsGHozwD4U9QN8uOL/e7CV64IIBVBGi1fBV+HDvRX
         KfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnfBA8SEmcXJgdSuqdmrfNHtJaqPGQnUVJ1IZ8VYAZ49HnmPvgjg7S62tjkajaaR7SAwKDRALWdVzrcm4Fm80qcPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfyhzXV+d+NeDM010vjD9o8KvzsLM1AAGEzsRHeFmuOJze71b
	6Jp2toQA+Hkh3yzxsJVc0XX0GweWzcv4uukOuYpNWNgwrUNTnOm1F3Wt7FeSOlRC701jYaNWOKN
	fJc+8f+DKwDeQYCo9ippK4SrENQ==
X-Google-Smtp-Source: AGHT+IEZvVijCkEAJRKnUy7ymqg6G12dNVURbl0z8Gf3KQzAlruU3kdFR92+1c9LGnwkKpRrDoTHA28pQbr5qtGv5A==
X-Received: from pjbds19.prod.google.com ([2002:a17:90b:8d3:b0:33b:51fe:1a84])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158a:b0:2ff:3752:8388 with SMTP id adf61e73a8af0-334a86108f0mr6621028637.32.1760731986801;
 Fri, 17 Oct 2025 13:13:06 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:04 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <2b96afca4f21b82fdce307d6385a6978b78b31f7.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 23/37] KVM: selftests: guest_memfd: Convert with
 allocated folios in different layouts
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 3b222009227c3..b42b1b27cb727 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -277,6 +277,36 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
 	test_convert_to_shared(t, 0, 0, 'A', 'B');
 }
 
+/*
+ * Test that when some of the folios in the conversion range are allocated,
+ * conversion requests are handled correctly in guest_memfd.  Vary the ranges
+ * allocated before conversion, using test_page, to cover various layouts of
+ * contiguous allocated and unallocated regions.
+ */
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
+{
+	const int second_page_to_fault = 4;
+	int i;
+
+	/*
+	 * Fault 2 of the pages to test filemap range operations except when
+	 * test_page == second_page_to_fault.
+	 */
+	host_do_rmw(t->mem, test_page, 0, 'A');
+	if (test_page != second_page_to_fault)
+		host_do_rmw(t->mem, second_page_to_fault, 0, 'A');
+
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+	for (i = 0; i < nr_pages; ++i) {
+		char expected = (i == test_page || i == second_page_to_fault) ? 'A' : 0;
+
+		test_private(t, i, expected, 'B');
+	}
+
+	for (i = 0; i < nr_pages; ++i)
+		test_convert_to_shared(t, i, 'B', 'C', 'D');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog

