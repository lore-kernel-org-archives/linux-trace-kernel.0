Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6739383C80
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382447; cv=none; b=oY3Qoba1wIjU4tQPUmxyAmWcnxVfrYmn7o53P4JWNF3c/2PPnvut9Sfa8dvH0MDrtYSxWKCGiMSitr6EYLx25bqnlAYkNpu8kFOg0E7ZhjtdjRrPwYrIgzof7PNhyTyKBrWcwrUdOLKjLTKRhQzbHdmdSIeGtR1Nj2tocEygkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382447; c=relaxed/simple;
	bh=9Nmx5HAs+7DRtlj9EWQELGCrvyUoFEJQW/16VzmDbeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+Y7vZYQS00SxtMj7jj0zxTBfeuQvWW10dtFIk1Y8N3D4mqEDMJ8Rp/PIF9dkuidlQgOOKxU3b3G/ob62vPdOMBH6q4Xn0o3NGc6kFrlqSXyioCey9bG+6z+cxCEQ5Uev5DL1qldxcUyW/AkAf1vMWVjwOvxV8/axdvika9+X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JqQmIwwA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JqQmIwwA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354490889b6so7918035a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382439; x=1773987239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkSCz6rjDBChxZIrEywkjbjk8auemBVpkQ44aK+RFnM=;
        b=JqQmIwwARJAMX4oM4CkS45Q83CEQfRQAn9v/+iMrb4xFW99/DZKWMU1/6Zs4KnMCSL
         PVATJLyRJi2lXZ5iLD+38xHTWln/gIzZvvcYOz/4E0CO4USi+Qg66F7rPhMbBZf0h47A
         aBbGRR1/rlf1C1KPZDh8AGmwm0dBuyvxUoL4AkthMTOJJjnXgjn3hRicF8C209yE9/O+
         nNzDvoa8AtgTrQsaXwmzKPalV0X7WzCA4BFGGMY2YLUUBsMR0/CS6ajhJx/HbeQHpqiA
         DE2nxz0bCUqJOz+4/QfKjnUKCK+W1i/k89JqVJHQhPqz+wnAI4I/Gc/4F4a/cVhKw1MO
         ptsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382439; x=1773987239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkSCz6rjDBChxZIrEywkjbjk8auemBVpkQ44aK+RFnM=;
        b=bHjmWSq17bI2pEqLgZqW/AfQT2eCBRIv9eI83hcLCtgzuHjnY25qBvYt/ljL7JOkYd
         kv/n5ItchMwABEqKNsd2x142judJ5Mtn3i5S1FvEnWk8IQds6dSireZ/Q08GxJIreYUj
         lEjvsMwFQC+Kgm0U0Qmla0MhNUOhAMvG++LGY17SWoIb73nlVgD7aHZpd03zGTDKPpjC
         4fBVQgcn55lEUkUgaUkFib6ghz5IsR2mKcNXEtjfz/wak0K9aWAzCYkiMfBHytvk0IMW
         u24NA70Cn3IxfmPJwJB7p7tZteYbxWmn1R5knIyCIvwHwwE/zJ+7CiBBJl4U4HB0RFCy
         kf9g==
X-Forwarded-Encrypted: i=1; AJvYcCV+A3Z1v43Az9jUlY4Rdsn4r9t+IjmGOY7v3llxykrvZw06wTgh773z2pSkCZLECr79WVWXFp88XtnMs6GHJFuyr4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYz+sm3K9euW0fKKnadEG1NByPRlqbwaCc7rjN2j4LoIYntsy
	1oQ8W89vLMCA/wmtQkWif5jD/ghlCq/uPyK7sa9RqaEOJeuU21UgwqVQbauLPe0CSzHxEZIAiyJ
	7YnkRZ1VD+9xC4BQEiN9+ElILsw==
X-Received: from pjbin22.prod.google.com ([2002:a17:90b:4396:b0:35a:5f:8f72])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2784:b0:352:ba0f:fb28 with SMTP id 98e67ed59e1d1-35a21e4ee53mr2119101a91.1.1773382438985;
 Thu, 12 Mar 2026 23:13:58 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:22 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=4578;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=9Nmx5HAs+7DRtlj9EWQELGCrvyUoFEJQW/16VzmDbeo=; b=DC8qeXu7SmMxXtijO6A9hehP0079wJhd+/Ee0WJofb9dO8LXR93tj+fDRl0UuiAZE+leNa+Qb
 nuEvk/7QGtbD81QpOVmb7HRi0PKdPhIGZa0guKDbYWzcbQKlcpmTgdP
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-43-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 43/43] KVM: selftests: Update tests to use flag-enabled
 library functions
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

Update tests to use the set_memory_attributes-related library functions
that now allow specification of flags.

This was manually tested by updating content_mode in main() and
recompiling/running.

TODOs:

+ If we introduce self-reporting of supported content modes, test based on
  reported content modes. If supported content modes are relatively static,
  accept a command line argument for this test to test different content
  modes.
+ Fold this patch into the earlier patches after getting through RFC.
---
 .../selftests/kvm/guest_memfd_conversions_test.c     | 20 +++++++++++++++-----
 .../selftests/kvm/x86/private_mem_conversions_test.c | 10 +++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 8727474325451..42f3ea950c192 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -27,6 +27,7 @@ typedef FIXTURE_DATA(gmem_conversions) test_data_t;
 FIXTURE_SETUP(gmem_conversions) { }
 
 static uint64_t page_size;
+static u64 content_mode;
 
 static void guest_do_rmw(void);
 #define GUEST_MEMFD_SHARING_TEST_GVA 0x90000000ULL
@@ -192,7 +193,9 @@ static void test_private(test_data_t *t, loff_t pgoff, char starting_val,
 static void test_convert_to_private(test_data_t *t, loff_t pgoff,
 				    char starting_val, char write_val)
 {
-	gmem_set_private(t->gmem_fd, pgoff * page_size, page_size);
+	gmem_set_memory_attributes(t->gmem_fd, pgoff * page_size, page_size,
+				   KVM_MEMORY_ATTRIBUTE_PRIVATE,
+				   content_mode);
 	test_private(t, pgoff, starting_val, write_val);
 }
 
@@ -208,7 +211,8 @@ static void test_convert_to_shared(test_data_t *t, loff_t pgoff,
 				   char starting_val, char host_write_val,
 				   char write_val)
 {
-	gmem_set_shared(t->gmem_fd, pgoff * page_size, page_size);
+	gmem_set_memory_attributes(t->gmem_fd, pgoff * page_size, page_size,
+				   0, content_mode);
 	test_shared(t, pgoff, starting_val, host_write_val, write_val);
 }
 
@@ -298,7 +302,9 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
 	if (test_page != second_page_to_fault)
 		host_do_rmw(t->mem, second_page_to_fault, 0, 'A');
 
-	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+	gmem_set_memory_attributes(t->gmem_fd, 0, nr_pages * page_size,
+				   KVM_MEMORY_ATTRIBUTE_PRIVATE,
+				   content_mode);
 	for (i = 0; i < nr_pages; ++i) {
 		char expected = (i == test_page || i == second_page_to_fault) ? 'A' : 0;
 
@@ -429,7 +435,8 @@ static void test_convert_to_private_fails(test_data_t *t, loff_t pgoff,
 
 	do {
 		ret = __gmem_set_private(t->gmem_fd, offset,
-					 nr_pages * page_size, &error_offset);
+					 nr_pages * page_size, &error_offset,
+					 content_mode);
 	} while (ret == -1 && errno == EINTR);
 	TEST_ASSERT(ret == -1 && errno == EAGAIN,
 		    "Wanted EAGAIN on page %lu, got %d (ret = %d)", pgoff,
@@ -465,7 +472,9 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(elevated_refcount, 4)
 
 	unpin_pages();
 
-	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
+	gmem_set_memory_attributes(t->gmem_fd, 0, nr_pages * page_size,
+				   KVM_MEMORY_ATTRIBUTE_PRIVATE,
+				   content_mode);
 
 	for (i = 0; i < nr_pages; i++) {
 		char expected = i == test_page ? 'B' : 'C';
@@ -481,6 +490,7 @@ int main(int argc, char *argv[])
 		     KVM_MEMORY_ATTRIBUTE_PRIVATE);
 
 	page_size = getpagesize();
+	content_mode = KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE;
 
 	return test_harness_run(argc, argv);
 }
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index f85717662a73b..7d72c36d102c9 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -306,9 +306,13 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
-		vm_mem_set_memory_attributes(vm, gpa, size,
-					     map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes) {
+		u64 attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+		vm_mem_set_memory_attributes(vm, gpa, size, attrs,
+					     KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
+	}
+
 	run->hypercall.ret = 0;
 }
 

-- 
2.53.0.851.ga537e3e6e9-goog

