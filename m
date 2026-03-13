Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593B379ED2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382407; cv=none; b=JpBDwZm028tphb/FdbqAwANmgKlcQ69/jMvQYzpdr5bsVimEKZaecTsL8Pk5tEELy9z+VNwmI6e44vTISQVaEV6kvWDsEmewLUmIg43S2i2arc+RIixEa4vtLwSUH5p2xufDnkEfcdTbuerPaUkOuKsJFEgoDENYwkB6hzEl2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382407; c=relaxed/simple;
	bh=itkY9wgPiMgf9oi7V9RAZ6UqNoaBLUThcOQtF4d2iTA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUoQT9yVhdC76pRUogzSU/Tne+18ybh5HnWtm7irXnQbCQdcXIDJ/TldbpLDGd+Jn3WBVRKZN0X5Cp/+NC4i0mq7M06OJLOhFBf0DU6BrMlK5/2fLF4/rKeJeTSQnti1taCOg1JxgsGFltpeTqn8dNvDVIjKeHD84OGe7ULKEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE4p9toq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE4p9toq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3595485abbbso1930154a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382405; x=1773987205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WRMPslSzXA9N46XX4OSjlA+u99x3cUsFKsLZGeZjw4=;
        b=gE4p9toqn3RNS8BKy3jlPzk97Li1nW87h/fuseZwANAw9Gd0Hz1WWyLAyt5dkCACcx
         y1mEgkaqYNLGr7TgB4ozXRm7eT4bTAuuyqLPTwgjr6ndTAO6brqtnhGmxUeIxX4sCQtr
         MWkzO3hgg8DAwAdWwrckkM4gnFo0RddyLeH1ORq064eUAh94cf6SPm0RwgJV6uRdIJ7T
         5t9MGygaqwS5+x3pVlYHrOVPDVb/pIkq2tdV5suqnkHrZg7vvtLLQVsZlCu/5KCTlol0
         yDN/qqsfLqY8/zCrcnr+e14RUTb9xfbbrRd5Vom8PEBi+GyvZAtUH5M3Gwra8ECixyra
         WB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382405; x=1773987205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WRMPslSzXA9N46XX4OSjlA+u99x3cUsFKsLZGeZjw4=;
        b=HJvEl0u2+W7j8VO2mALMnxQUD8GYejdPdVJsjpHrbobHM4hOq1BS+Qu2gIHctFiakq
         doff1FVlO+o/6wBTjZT8tPvtTEWFphsSFUkChNzGsKvsqVpgmJyw8mr8VaqOhXm8FLz2
         vuQNxwTD2I9WHx/qR2xF75q3UEODShpZmTs2B1PHAYs/SX9+/7NA6mOqvZEtRrsFma2+
         abn17QAQh5sheihtNhHTogwAhlDLnwQFtR5DAVepEGDvygWkFIzxH88YqoHhTuYm+LUM
         8Yh3qP2mEzuEO/Qz80TSVHfM/y4gK8JKgObcyM8dk6WdS3DqWd8/UVV9WtqoCc+yhw57
         3O6g==
X-Forwarded-Encrypted: i=1; AJvYcCVuIwSliqooMpo7mafDsbcG2iDUvr9NfWnYiiT7B4+a/S25QhI1jVgGhtGa6bwnTBTqVsUzAxfsPW0nHntE9R3DQpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSRzeVyWv4o6HahgJ8McA+mpWKNid1QPDHDQ9v0bjDyU4Tt6F
	H9P5l+j3Sl4GrmJF7URGKlRdIjkjP3qD0+UKivc7nxzDfAWXnwWyyPVfXqekycpPe2ZTQyU9fdK
	dzVEyVg8MZVRxxAdHegWiYOPrOg==
X-Received: from pjbfy24.prod.google.com ([2002:a17:90b:218:b0:359:7aaf:b9c5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ace:b0:34c:2db6:57a7 with SMTP id 98e67ed59e1d1-35a21ea872dmr1961832a91.8.1773382404906;
 Thu, 12 Mar 2026 23:13:24 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:01 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3937;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=itkY9wgPiMgf9oi7V9RAZ6UqNoaBLUThcOQtF4d2iTA=; b=a61kaj/rPon3ZHqkvB5ewKQB3WhoxC2KDqXTPh9Vz7jb6nUr43CAK79qoIkP89ijHOEjvgDaA
 jw+nqCnk8rCB7YD8RMwPsSJWfp68nTUEJXuCVlD1+jq9IrfsDyMZ9t8
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-22-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 22/43] KVM: selftests: Test indexing in guest_memfd
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

The existing guest_memfd conversion tests only use single-page memory
regions. This provides no coverage for multi-page guest_memfd objects,
specifically whether KVM correctly handles the page index for conversion
operations. An incorrect implementation could, for example, always operate
on the first page regardless of the index provided.

Add a new test case to verify that conversions between private and shared
memory correctly target the specified page within a multi-page guest_memfd.

To support this test, add a new GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED
macro that handles setting up and tearing down the VM for each page
iteration. The teardown logic is adjusted to prevent a double-free in this
new scenario.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 438937980f040..8044581d5e5e6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -63,6 +63,9 @@ static void gmem_conversions_do_teardown(test_data_t *t)
 {
 	/* No need to close gmem_fd, it's owned by the VM structure. */
 	kvm_vm_free(t->vcpu->vm);
+
+	/* NULL this out to avoid second free on full teardown in multipage tests. */
+	t->vcpu->vm = NULL;
 }
 
 FIXTURE_TEARDOWN(gmem_conversions)
@@ -101,6 +104,29 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
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
@@ -199,6 +225,36 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
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
+	/*
+	 * Start with the highest index, to catch any errors when, perhaps, the
+	 * first page is returned even for the last index.
+	 */
+	for (i = nr_pages - 1; i >= 0; --i)
+		test_shared(t, i, 0, i, i * 2);
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_private(t, i, i * 2, i * 4);
+		else
+			test_shared(t, i, i * 2, i * 3, i * 4);
+	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_shared(t, i, i * 4, i * 5, i * 6);
+		else
+			test_shared(t, i, i * 4, i * 5, i * 6);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.851.ga537e3e6e9-goog

