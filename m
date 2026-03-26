Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2434F257
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563931; cv=none; b=bRudMsVtSwz9ITMX6RVhQRQlSwEfSaxfFY1tMvGtjCTvcao70/u5lDJQlj1+4BE8gAl1ax52qfDMndsJwj8pPAffVqdWpPqkb+ANxRD05qOTozTL1Is2fu38gS4xp2eWprApj+ZT72rMR+iVT4bncXrBMvbPuSh1pijSCrLAkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563931; c=relaxed/simple;
	bh=49y6ENDTk+sGjQthlPC0PI5YjXBfXeC7oiHabUVd5+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kkAM/lIZM4j0sVwnVzHPGNRfVKE/A6Grxc2zCV7Z7twuA+hloIUfiGK9wIqDB5ylRLsz8eNEK2GDnieBI08tYo5I5iTvkGr5Yit+y+uyn4y0b+5M7OVSpwzK6PXkaW8yt12NQOj0z2EfmIbYEk+fro0PZ5h888dRldYMv6t/40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFYxi+OZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFYxi+OZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a782029b7so1139725b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563930; x=1775168730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FDVrh5pBAWxA/8NukVOzbt4j2jYZyIOrjhQG/FDGfA=;
        b=PFYxi+OZI7E39KcF7SwuJM6KlnAtjVcLnzJrrY3ivJMkF5vKIaAs/RdQS92OU2sprk
         5ygz2YS6MEAgjnsRIgpXHJiY1AH7wsDTZSUT8sIn+r0anmFwdTyuMJVjQKEv872OS6Yr
         kEUIRLFEkPETycsa+ww5BzUfmv6AlOKgFResu4AAdcjBKpzKUSuqwjXdlYwsc8OtP/W4
         6HFXPHDnMDQ0EzQNNYPxmxM56jsJmklIe7fWsBZFMW1ri6ay7N/CvQNS+GMbjnKZ6zt9
         aFVZ7OD9Dbiv8+YBZI1QDIpBMKKwbyOH+Z4taXowbQ6D/5NwYOoiOKJNm43KC3EAKoHQ
         WQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563930; x=1775168730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FDVrh5pBAWxA/8NukVOzbt4j2jYZyIOrjhQG/FDGfA=;
        b=Lmh0pZ32yT5m+r81DM0gk1/xYjmR3V+FP8mPTJRJRWY6y5qiSTcDEDdETYUTpI8EqL
         GknDygblwopf5ecme3ZdFZBHn9v7FP+FLzbMhDE9hv8VY2WtZ5sMq8Tmps0Anegw2i26
         CPFLo8mfW314EiLFsIBJJDQvi1umpUznOoBV7RC8D1N83TbL6DnYauV4hRDwxMRdWh+c
         d37iAvmIuzkWYXWWR5JbQ144lbNCinIWUS73pPqcD00jcOGMgGXDRlbtvEE5T09XjCz/
         vc9Fenc5kSdOHiPoj5rmZsM/AX/dTDHtkyKXn9rPF2W+8u5WW3lsWjksCRoLvGeAR+cG
         rfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJuzQbwFSKS+7Lkp17OT71baVRIvBYmHZeQ/s/eTGLnb15ZT5bVUqMDhmtcSYEUmfxm+RmMsLeteZL+L/713TDlSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bcgfpEgO5oR+4K1Ek1k7oeMkK7eJKlOeyUI0dwNplBgraKRS
	znphF1etyZ4meTzX9tKxtTSj5nJSvLmDGKrTJITXmxc6LSkejVWBuCRSMMMmBmWXTs4a+3EJ6Fb
	HSV7pfxxV31Lw45ADBypZXvtySQ==
X-Received: from pfbmy24-n1.prod.google.com ([2002:a05:6a00:6d58:10b0:82c:85db:66f1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a118:b0:824:188b:c173 with SMTP id d2e1a72fcca58-82c95d35fa3mr154180b3a.5.1774563929625;
 Thu, 26 Mar 2026 15:25:29 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:41 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3818;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=49y6ENDTk+sGjQthlPC0PI5YjXBfXeC7oiHabUVd5+c=; b=65aFdTZaaBhbx01UOD21wSDI5gmFYvI5UY4Oon4kj35EozZ/PT0v5jtWiriWeTssIZ8LZ5iDi
 nW+/95/cI0ZBsoUfv6UZ6e3zDpiwjAXZks4pArcDWAYh9DVJGtT36bz
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-32-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 32/44] KVM: selftests: Test conversion with elevated
 page refcount
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

Add a selftest to verify that converting a shared guest_memfd page to a
private page fails if the page has an elevated reference count.

When KVM converts a shared page to a private one, it expects the page to
have a reference count equal to the reference counts taken by the
filemap. If another kernel subsystem holds a reference to the page, for
example via pin_user_pages(), the conversion must be aborted.

This test uses vmsplice to increment the refcount of a specific page. The
reference is kept on the page by not reading data out from vmsplice's
destination pipe. It then attempts to convert a range of pages, including
the page with elevated refcount, from shared to private.

The test asserts that both bulk and single-page conversion attempts
correctly fail with EAGAIN for the pinned page. After the page is unpinned,
the test verifies that subsequent conversions succeed.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index ed310f26d88a1..4ccd3d515bb26 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -408,6 +408,86 @@ GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
 	kvm_munmap(test_state, sizeof(*test_state));
 }
 
+static int pin_pipe[2] = { -1, -1 };
+
+static void pin_pages(void *vaddr, uint64_t size)
+{
+	struct iovec iov = {
+		.iov_base = vaddr,
+		.iov_len = size,
+	};
+
+	if (pin_pipe[1] < 0)
+		TEST_ASSERT_EQ(pipe(pin_pipe), 0);
+
+	TEST_ASSERT_EQ(vmsplice(pin_pipe[1], &iov, 1, 0), size);
+}
+
+static void unpin_pages(void)
+{
+	close(pin_pipe[1]);
+	pin_pipe[1] = -1;
+	close(pin_pipe[0]);
+	pin_pipe[0] = -1;
+}
+
+static void test_convert_to_private_fails(test_data_t *t, loff_t pgoff,
+					  size_t nr_pages,
+					  loff_t expected_error_offset)
+{
+	loff_t offset = pgoff * page_size;
+	loff_t error_offset = -1ul;
+	int ret;
+
+	do {
+		ret = __gmem_set_private(t->gmem_fd, offset,
+					 nr_pages * page_size, &error_offset,
+					 KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
+	} while (ret == -1 && errno == EINTR);
+	TEST_ASSERT(ret == -1 && errno == EAGAIN,
+		    "Wanted EAGAIN on page %lu, got %d (ret = %d)", pgoff,
+		    errno, ret);
+	TEST_ASSERT_EQ(error_offset, expected_error_offset);
+}
+
+GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(elevated_refcount, 4)
+{
+	int i;
+
+	pin_pages(t->mem + test_page * page_size, page_size);
+
+	for (i = 0; i < nr_pages; i++)
+		test_shared(t, i, 0, 'A', 'B');
+
+	/*
+	 * Converting in bulk should fail as long any page in the range has
+	 * unexpected refcounts.
+	 */
+	test_convert_to_private_fails(t, 0, nr_pages, test_page * page_size);
+
+	for (i = 0; i < nr_pages; i++) {
+		/*
+		 * Converting page-wise should also fail as long any page in the
+		 * range has unexpected refcounts.
+		 */
+		if (i == test_page)
+			test_convert_to_private_fails(t, i, 1, test_page * page_size);
+		else
+			test_convert_to_private(t, i, 'B', 'C');
+	}
+
+	unpin_pages();
+
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size,
+			 KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE);
+
+	for (i = 0; i < nr_pages; i++) {
+		char expected = i == test_page ? 'B' : 'C';
+
+		test_private(t, i, expected, 'D');
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.1018.g2bb0e51243-goog

