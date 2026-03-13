Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FB37EFFE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382419; cv=none; b=OZUHsqvw+MlHFklbxt3a0odpKkiGgxEZ0d9wYnkgy4ngwIMJw4nKxMO6xiEAHneYDczPxRicM5wI3WpwENaUYneX/4TTRMHH+UnPXrw+xu3mAZlVTFjHTTF/DMocYG+6jt0z0bQ9VI/JWHqe+fO19uou8dzzO/Atiko6CIMmUn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382419; c=relaxed/simple;
	bh=xRKb3bVMcx/uVRBFcKELGtm1TsNEsqcmghIMICAO0wI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eE5JYuFrOBsekVpEjQ+UvtqqyNzsNiOXwi9hhnmGJAh+i8PSC9oBUjHIiGPdKIyFAZI7irGYJJ55eOE+slhtoxk587jKom3JhTI3cB/BKjNCiXonUqSuWDEikvXuFZbx83Zcl6Ju4v1KD7fqQ/6b14SvlOVC6RLvKHs2terT7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qyHt+hsb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qyHt+hsb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae59e057f1so24892505ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382415; x=1773987215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MtLKd6/akGAIni+0N8+cFKVyOqbU6nOkVaBf+x9Xbcg=;
        b=qyHt+hsbM3whvSZ0YKRIpGAY1vPC2QssEZuVuYsbYzZTi6ynLVyrx/S9RB9SefRlQY
         7jA3sFN1JpDEpTufAC/sw4f3FrnfAsM9c2puKaHeeAqw8f39I96sK0SptIq5afKcj6Rl
         M+fU0f7QzmSspMUx6FUFz3gr0/sEUlJXmspk+4S6pgQCJqeYlIVAFG/BntMMWKP4iGkr
         XJCA8aOC2OvNkUjmqkf2rHr21tT/BJR3y+Dy0DoJCZXc8r9uI5vtPoWdUw4Ub+9mTdm8
         YsW/jZHqujMRBX2Eb5Ejig68DrcjOcNx3RzKdi4r6q7HhlFd5cWiwMDGtXgKw89VoWzZ
         JM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382415; x=1773987215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtLKd6/akGAIni+0N8+cFKVyOqbU6nOkVaBf+x9Xbcg=;
        b=QiV8y3/9XL81HMgMLBH8dHqxcpyeCPb6ilbfPme0wO9L05jlyHscBpgdCioZuAD3Bu
         1FRZOzsDJVrydmN8BQLBM6rbCpOAguCRZ65CuXRcOHLTmLwD77e//618X0aUaspctL2C
         I/F39Ec28UWdzYoCYPjeb5BmdetbbLFx7yzAS+Hpgo+2Eo2DDXm3Gyyn28DzAci6j3e/
         8iA2ADbeiTzsLk9n6Im+/LhyR81TgXPWuPD49p3jH0qRgSomtnSfFBJqClvpj+Ugll8P
         MUX1rgvgUlg2/1m4FwX3SBhgjzFm9Jx5Xt4c7YwZTx4Xq8I0fDQOpUrSkqy87oyuR6SB
         cP6g==
X-Forwarded-Encrypted: i=1; AJvYcCVZyzluB6wWNHWuHoJ9rlW6I2ylYXsmr10WobyjfdLtt6/I1MWLLwRYRl41Drz74sDW3mis9uRC/aDVa0wWhNqpU+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmONc+Jb2UZyV059vp+CPb7WDpLtAFgCfuY3WmoJSFyZ6xgtQ
	yl5OdAdKfCfw3vl+Q56MERE8VlVyV+I75LT4GFA4Tec7WSzzbFRMSNNI9SzjSWUWbPCU8Dn13Rk
	9l4muJwiTcy8skzZzo7qQ4Y5J1Q==
X-Received: from pjtz21.prod.google.com ([2002:a17:90a:cb15:b0:359:f37c:e0a5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:540d:b0:359:2d1c:9206 with SMTP id 98e67ed59e1d1-35a220bacbdmr1758060a91.33.1773382414557;
 Thu, 12 Mar 2026 23:13:34 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:07 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3729;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xRKb3bVMcx/uVRBFcKELGtm1TsNEsqcmghIMICAO0wI=; b=4UlIoexpGM586Ep9gpcgcpdjTd+BgERPWiazIPux/Pti//AcvAjinkDe07IGBccFkXXhQyT3l
 2SDQznJ0i3JAz7Lsp03hMRKGOS/RwR/HlpbrT0AR6Z1kG7mJvjjbsx5
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-28-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 28/43] KVM: selftests: Test conversion with elevated
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
 .../selftests/kvm/guest_memfd_conversions_test.c   | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index c1a9cc7c9fae6..8727474325451 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -396,6 +396,84 @@ GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
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
+					 nr_pages * page_size, &error_offset);
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
+	gmem_set_private(t->gmem_fd, 0, nr_pages * page_size);
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
2.53.0.851.ga537e3e6e9-goog

