Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F134D4F1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563924; cv=none; b=UKb/bn8897c+9UiKhF+IJ4BN0Ww8RP8XaiR9rup+4hHa5rIP/gARAcl2qVeNlizCpEYgLyih5lVNRFgKHe7oCi3WD50zSEeeeAYQFswCZRaQ4Jk7jUd5f302mt8jO+NqioWSVjq5kB7/AjkSsFTHvxuGxj8PPY0L2mYHOMM1paY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563924; c=relaxed/simple;
	bh=6GHfy5Gjl/zAQ6e2mdyS+8IkN1+t3F2076IrLeNAKh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FryzQ+CsowWyMPQYUm8d5l88ZHjTbxzMyGiA5DbD+olM6XqCeOOd2oasw9+uIdixiacjL8yoUsxlgTtr1lSfa5eHezc6vfarxHJku5J90kutx9gpXrg30vqbb77r70TmhENUREoSUNhkgUxk+Vq+gtdUI+igB3vDLJIq0Lp6TWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1MffO8R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1MffO8R"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so2741843a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563922; x=1775168722; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMzauqzu1N0T+RdZOJts60YeEjJTRcPELOzUqUrSMzA=;
        b=v1MffO8RiaH90mFYckLFZ5gdhTd7BAqhQkOdkqcqxHjPr7jMIIkx+hKeZgPCd2PJlQ
         8SsA79u9Orau9gbFa5xPteH5pIbl+Y/cKWJquegq0hPtQnBYn6mrOpDxMGz8OqduPrNx
         SZw+RfbTkp2NbBxQIDwjjHD0TrBUlB3mJfS4HcbrUZcV0eIpYwmQHVnnC0twVvNtpSDJ
         E1P2ShJpNrPcUSqG8C9RbSM+nSHghXTer+GZndTp4z6lY7iKoNLeE4+g3OsMpRQFz8oG
         xtJghtG7iiAIK5YMuHhuK0uMR0eNmiipdnkcuvoNPpcrGwznhjsp8Lnh/FoYH87aBJ2a
         00gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563922; x=1775168722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMzauqzu1N0T+RdZOJts60YeEjJTRcPELOzUqUrSMzA=;
        b=g6Wzml+fCbZ7tXGq4vPQUuzlHJ4wDrq6qgmLjSDmcjuQMQDK+EhKtRXlXn2w5XbI+W
         AUD2ov249i5bakGKBMuCttcZ2r/jlGT5QGQAkwskDHZq6JzJDAvXu58K+CfJMXDcGDyW
         XyLThVGDpdlGGEGF+oC9xvbYkxrK6zfb8E71IuznmtK8EFzu+YDOC4DeI/UV6wXV6GXN
         n5dsDIlU3+/cAETtVJtKd2TfInhXbkDs5BzYSo5rRNcg3NewV7Tg/883MOsXyggF8d/0
         x66M0dmPPhdsZb6SBZYC/BlcC+Fjg5Po9hkfeJQn7Mxs6dbXHbkZWsG4N69PMlTfY2DR
         07BA==
X-Forwarded-Encrypted: i=1; AJvYcCX2G27w32Y05JfqV2RGeZrcbGqNNMCad406kIxZ90uiTzUsnfHYeq39vUYgdIyB4xO8cdFmsbxXqXHDmzAjkYKVUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8Z6cvsOZHTOFRcBUtpp5bB0+eODUJDIArm4FbGFI5W4COFJi
	e6JpFzMqe4rLX1VHZxTujRDgZXSrHkSwFhdM2nFo0NKRqZgPqHabX3mNEXgzCA6fHfDiUBbKsOd
	tW1Krpjs4Iw8gIdr4GVTjlKYfKw==
X-Received: from pfjf18.prod.google.com ([2002:a05:6a00:22d2:b0:82c:8530:819b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c8:b0:82a:805a:7cc with SMTP id d2e1a72fcca58-82c959d4be3mr154865b3a.4.1774563921606;
 Thu, 26 Mar 2026 15:25:21 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:37 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1702;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6GHfy5Gjl/zAQ6e2mdyS+8IkN1+t3F2076IrLeNAKh4=; b=c0+/tVHHCj0rRhXtP95bZmzyVS99cg5m742QeRGaOCMuqdCrbTR5SGdXnoc6pcKSp6OoBARjg
 dKSpjzbhP3OC/hursTJC8G2V8dCdYgi2xvh0GxAAJepAlmCgB5i/jZU
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-28-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 28/44] KVM: selftests: Test conversion before allocation
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

Add two test cases to the guest_memfd conversions selftest to cover
the scenario where a conversion is requested before any memory has been
allocated in the guest_memfd region.

The KVM_SET_MEMORY_ATTRIBUTES2 ioctl can be called on a memory region at
any time. If the guest had not yet faulted in any pages for that region,
the kernel must record the conversion request and apply the requested state
when the pages are eventually allocated.

The new tests cover both conversion directions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_conversions_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 3388f06bc51db..1198c9c914318 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -275,6 +275,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 #undef f
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
2.53.0.1018.g2bb0e51243-goog

