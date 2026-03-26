Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3B3BD65D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563926; cv=none; b=pbh6sUWEuZ2NpJF5zFtiVdQBhoDScCOUzM1eU2togrmNBgyokGF5/MNvV0mvo1OhMkNMf3wNYPfnsdaM7y4sIw8sY2jmo/7solxtKSrLjCtZML3ofiACs02QohrKaWpu+866BLrnhT09vW78n004eunbzhYiG4ZM5gIQ3wpNIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563926; c=relaxed/simple;
	bh=oHklOacZgiD0w5i2dlS6G3/6wCT4tptcmpz8kawfH5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a6Ucr+DtPn98HsIlO9EA2TSf7VoIq8Zt2mDxneJivL7QgLKY1JOkEU2rhqATXyHprscFfiXL7JN20tSKNcLY/ciuFMQkN3e/O9NWXG1Yxa8P9XNHVnJc61ubrTIi/tEkzMhzcQsAYi9/kU1//NIkxq2+r6F61b1wsn0myf2xJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dfcgBgh3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dfcgBgh3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c675116f1so2910801b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563924; x=1775168724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1xYMD/ygmI2J6L6yZT+C265xiVpI/P15LX3jXqm3Xk=;
        b=dfcgBgh3QsUyTetXaxxZILIH4NOqD2AjY/TzHEz05JFk4PU8q/RwhBwi0wmEbqlYJB
         9tuGeDdUZgL8eHkL2KgwGcjpXe8S5xZPO4Wg0QlDD3/vmbHFveSztKIB0CLtull6fPtI
         ijonnS9FnRa/HMfshoSUXbhTaDmlz7HrNYAD/lK0iPp4RKcHuL+5BOKQFS/936vTQsr/
         F2VBd+U6tZtsE3O5QF94qntZwQepEZPZ2DyPFwh0IlBF4FVcjwJeH8tU317ZWtPADqOk
         9iQslmkSOM8R4XqWNPgFd5TuvXkRzreTy8K/4rXX3ytCNSq3VB7GCiarTMPj8bv3lIyD
         QKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563924; x=1775168724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1xYMD/ygmI2J6L6yZT+C265xiVpI/P15LX3jXqm3Xk=;
        b=ZvCg8BK3MUPN6V507mPjps8TVAKbDwZEAll6SGV1XkHQo82mX9BL9RrW7keO2zbXhg
         Epl3hYDgxIdfvs4Cb6tJiuxc58zBR/y3msK2vG7UKbzAlo0bGoOe+J9/iLZss4acUs52
         Ot8b09MiVpWsJZizUIKPhUvJJ5kvwlqyqL5HnPsyGndZwkS3BHzIQPDCQl2LR/aruM0a
         1vR1rU/p762wNLDBU9wyp3/SvRfMXImcPP7yiFPcZfMchRqEUqUiTElSIoW/lN/c+Kr7
         BldcNt6D/aFH0ITKuCWOdNzrImEiDODcTfh31uYcx/OLJzDBnOJNHGGTllZWMjt47iND
         PbOw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6wl4xekSwJzKBja72rjj50qAVm6mf87QYIe7ZsOGJnP7u9/yvz7jtfCEYXnQESCekTAtioNvGtKukXKRD/g2rXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqmHdhQPTajnwIz/UDhXDQEr1PdzzgiJO35Og+sKeeWywBmkcX
	MC0EEzsEtaJCe2gM2YkcAkOOqXPk/E8ewey6xaX9WRsEazCCbvApTc9Jz6ow6B/l362uD2lDcQn
	gGckI5GjTK1ECLyz9TUnoc3TzXQ==
X-Received: from pfbfo22.prod.google.com ([2002:a05:6a00:6016:b0:82c:6863:427a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:348b:b0:829:6f37:158a with SMTP id d2e1a72fcca58-82c95c036cdmr167633b3a.18.1774563923362;
 Thu, 26 Mar 2026 15:25:23 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:38 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2257;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=oHklOacZgiD0w5i2dlS6G3/6wCT4tptcmpz8kawfH5k=; b=t7NZE6MbqQDRWbQsWbc0txg2U4p4153wpJM1gp3EaoANwnq92WnqbVCOltBJBXIrWcw+W5+GI
 jF48qJjsPNLBWBTO1mypfrEwWyywX8S14Vetlu9iUQQtlDVpnf415F4
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-29-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 29/44] KVM: selftests: Convert with allocated folios in
 different layouts
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

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 1198c9c914318..8f09671505b32 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -289,6 +289,37 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
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
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size,
+			 KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
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
2.53.0.1018.g2bb0e51243-goog

