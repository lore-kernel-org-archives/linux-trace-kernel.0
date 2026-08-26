Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E97A3F5BE3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735951; cv=none; b=TMAihWoJ6dmCfxpCPUxmYqpvN5IIuhJJWgDNuP9+AMwD35H+sYolrhjvoQw/glgJWEDhrxmXo/PvWvAxWXYjC7EgB0yRRLah1MFeQJ5bwKWAHMBxgCOns0soKbMXGjDZk+grt8mHY1Q7OZ1j4Q8zFHaCNRCH3yQQuQpPaMn54Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735951; c=relaxed/simple;
	bh=7hWrOiBCNLWR4WmaZsIQ/WiJTqMaoqs3GPpOPxdsIrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8DHJRLPevxKB1rcgu/Z88RFCtRp5ecRiKfSttLL+oSN+v6gy6dJTHLD0642nvsQtuKqhhkKQ+c097hc3sSnO43PqGsAaizVEL3z1Ee5AOFZ0g0ffxAZ6MyK6dBb0BQP4L52fEHIDUmY6Ckdi4dEi78CWzys+UcmiycO2Xajx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fI+o62L+; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fI+o62L+"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc6dd43737so9657935ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735946; x=1788340746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QanNPXruSQXVrF67aaQcoGfZbE9UbCtKaKkFHYTWC+U=;
        b=fI+o62L+xHzAyC5TxcOaA6RF4funXw5jug7vx0XmXD/igz8J++j+YQunJuREuXVsH/
         n7JkKNNvab8IcvBPMIzwuJI1/t6HAvs0Rkhk5Bo+MxGXLyfl7TYlUQj62z/IPw/sXkhL
         HQhkHGO3vjUsSubdo+/32WNj6kLSP+xgO4DB89TF/NamBqZp9khGzXbEV6dH+g0JgwwE
         RRWxzkaI5La5INCay9YVQWnLz0x/C18niClVMJ3p8pvb9F7Nu/RIMhqAez7tnex6onIQ
         2mKZqTMRnTR+7eXrkK+pudM9iWcrokbx073GohBo5/pPqqfbvMczrv1zdFBOF3huuPpX
         f4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735946; x=1788340746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QanNPXruSQXVrF67aaQcoGfZbE9UbCtKaKkFHYTWC+U=;
        b=Eev6+0rLfxKRATWX9AupjKFblbIxnlFz1aAN6sakXKPw5A+uIv2PuYSW3pyLv+0Hj+
         MYVOlRQiOEJxmCawv1GWADoKp2vT3uI+AH4dg1lT2zkQo/2sbfd+AmzCr2SeIPOLzGHG
         aCH9dIzlfXv1vPEmrk0m37xo5hahcoyR4rllJW7QePU+7XfksUJKp9VxytIvHrcnX73s
         ajEJ5UFnTQOrN8bh2kiQDCjK0iKsN3UQliU+Jttr19oVdN6TmqPG9rfkD8GfBTSvvUsC
         R+258A1p6MgPtpevgFAhfK9paLIJlPhYjTuttZ1ejxJ9X+BZO/WnAH9J3Pdd/WypeU/m
         1RxA==
X-Forwarded-Encrypted: i=1; AHgh+RoHJdjF5bFyvzThceT/xyE3t4rIVTq11Gh0ikLkZWZ0IEfHD/VDh8rudsLdFp8a/gaMQkIG00woimXjMi8BCTMR3R0=@vger.kernel.org
X-Gm-Message-State: AFuF++lHlkPhi99F5MSyRQw85qnQFmYplFEBKHDZG0nNfnlVH20DsKBY
	w9F0SES4cXp9obHkOFhoPXRhA1FQnboHcxvI74Pi5raie9F+ecx0pyPusN65Wn6uhYum0y8rYoD
	2KeNWRKd2lXVuwe1+joSW+VwVPQ==
X-Received: from plyw15.prod.google.com ([2002:a17:902:d70f:b0:2cc:6206:58ad])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f541:b0:2d3:716e:e2ae with SMTP id d9443c01a7336-2d707ab1407mr81866255ad.6.1787735945585;
 Wed, 26 Aug 2026 02:19:05 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:32 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2317;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=7hWrOiBCNLWR4WmaZsIQ/WiJTqMaoqs3GPpOPxdsIrA=; b=H4rkK1YLN75/OUClRsyrNGZ+v8Y0cZ9iPfybDQNGwCS1Lp8udQXVRcUWRxH/i7jKh5B1xjwbI
 /6yH7SDOMn/C3e0QrzREPxPxypHEsDepGeNaD2wcV8oKFQzOKNmrTyz
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-34-0a15d8a799aa@google.com>
Subject: [PATCH v11 34/46] KVM: selftests: Convert with allocated folios in
 different layouts
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

Add a guest_memfd selftest to verify that memory conversions work
correctly with allocated folios in different layouts.

By iterating through which pages are initially faulted, the test covers
various layouts of contiguous allocated and unallocated regions, exercising
conversion with different range layouts.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/guest_memfd_conversions_test.c         | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
index f46f1530a94b9..acdff2d154046 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
@@ -282,6 +282,36 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
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
2.55.0.887.g758fc8c411-goog

