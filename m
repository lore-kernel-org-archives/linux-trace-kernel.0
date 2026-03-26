Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32953350297
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563938; cv=none; b=UYNPmw+OOjnZZlOm5cqXwxi9sujrz/+3FnsoyTBQgzrKkX06mDPf1KtkySg1WKThT9Eg6DN/jKQfah5+EG3p/TEG21bt9i/434qwhUAWgElt713Q/ImzPrAqY3R2b9sTcbAXS345QJnLZYzR1Mbo76tMoJdHzqdCc/gJ/jqxXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563938; c=relaxed/simple;
	bh=TKwIneM09cvvLCUdRFakE58DgmH+kzGWLG04CD3qLX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExHOBRyArit8WwNJP3oALVecMFNat35XpsrKjPC7vYs0fGvMsOu8VJI0WwScTQOVJrEWNOR+8snhHdqm3vWaH17Eedk8aTzp3qMqjQ3xo0Tw4JyAN8FEvVKCHMHRrfRX58uBZMmizAp2fEn4NdwexTUbHQ0Nab5a5jiU4ysdodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMHy8Lvz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMHy8Lvz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c629a3276e9so2784612a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563936; x=1775168736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZhopEmz9QupHvhORYz2gLUFM61nCO/Ej/TdDgxiHZM=;
        b=fMHy8Lvz3jUIQdIlEMB6pA6wX5cFOE4BwfJTG5hhaXoFjpReg177BOhQDUAP84niO+
         W2p3pFp8MATWetgIxVuQIjssLKXwayoWVixuN7LSW36XafEZorJGQ4Kv0pQzOaq8hLy0
         wLekFTWAM/FI3emeKMUay4qVdpFrSdU6CTx7QDI6bXq7o9yRL0s2RVWPPioiQhyDGpQ5
         TPjN1jrBoLyiKjAcwk37/Gq7p/sw+K9gPio6ryTJZ9UIJSDjsaBbgSV5I38neoNX5TXh
         5By2N9VYwFG1MPcXSOOBmhUiSj4Xa4B4JOcTNhYp/D59xRm80Fvl2O0NUmMEo9XTrwsr
         FStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563936; x=1775168736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZhopEmz9QupHvhORYz2gLUFM61nCO/Ej/TdDgxiHZM=;
        b=kqeuHYsr2k0pSitxZ+r7OnCdDDDA8Ghnrz1AAUE1LmTT/+I1DWM0wn0c+gvJGYEZGf
         RojYTLmLv0TO8qOIAoWYQ/R9f9S1yDOKSu4MQBTchzzC7Tl1WWdPk5vcYwOYCbLlckeT
         7wRoc+p5/heW4yccp15phXW6Zjwi0QlQH3UF+QPyrMZbYDuZt55NghCzz/4hdSKEQXco
         irGt5oLASYimfxcHqo0rONe6GqgialliheSnGMja7r1taaqxsFbhSvNxrAjQ8c25t+ad
         KZs40TM40z4L+jCJUfk2s+cxan4ibamrPSISurVxdT55Vfb/6OJ5htkmyXYW17RBiD66
         nkhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGrzjHltyzzmjRYVo0bhr6jzx0BacBYJORSEqQwn3NiEefPSUDh/+ol6jWf5eTiBAHlV3vntjSAGQsDFVt54Vi/G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFeQ8hIi1Y9Mx751oZ0V2FW6zsC3RUB7wnhdQ9+ze5o1bpmLX
	7WTMshi+RuqT8LiW+c4mlNImN8uYxiCi85lI+mqmlvqSxWBvAAiS0Z6gxCSalHQTpUeunnp5bIB
	h+Ds3sLMxxMa3ltlc7bbXgmmDpg==
X-Received: from pfbji4.prod.google.com ([2002:a05:6a00:8f04:b0:829:a298:e5f2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b60c:b0:82a:780f:a18a with SMTP id d2e1a72fcca58-82c95ee9102mr155260b3a.44.1774563936260;
 Thu, 26 Mar 2026 15:25:36 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:44 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2085;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=TKwIneM09cvvLCUdRFakE58DgmH+kzGWLG04CD3qLX8=; b=oVFtCvMAE6x+EWDc+ry+cyq4SuvkUPW14QkvvxiXdSdeccBpOGoDim0sAaLqVyLTdu9yvnNDz
 56H+dt+vbO1ARLNr5kGJLYZ6iZL2rOnEZG0XxMIEmctPUz2XJRmzJZV
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-35-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 35/44] KVM: selftests: Test that not specifying a
 conversion flag scrambles memory contents
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

When using KVM_SET_MEMORY_ATTRIBUTES2, not specifying flags for the ioctl
implies no guarantees on memory contents.

For KVM_X86_SW_PROTECTED_VM, this mode is implemented by scrambling
contents of converted memory ranges. Add a test to check that the
unspecified conversion mode was handled in KVM by checking the expected
behavior, that existing memory contents are scrambled.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 277b122ec294c..4b2f00afda01c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -512,6 +512,34 @@ GMEM_CONVERSION_TEST_INIT_SHARED(convert_to_private_does_not_support_zero)
 	TEST_ASSERT_EQ(error_offset, start_offset);
 }
 
+GMEM_CONVERSION_TEST_INIT_SHARED(convert_mode_unspecified_scrambles)
+{
+	loff_t error_offset = -1ul;
+	int ret;
+
+	test_shared(t, 0, 0, 'A', 'B');
+	ret = __gmem_set_private(t->gmem_fd, 0, nr_pages * page_size,
+				 &error_offset, 0);
+	TEST_ASSERT_EQ(ret, 0);
+	TEST_ASSERT_EQ(error_offset, -1ul);
+
+	/*
+	 * Since the content mode 0 scrambles data in memory, there is
+	 * a small chance that this test will falsely fail when the
+	 * scrambled value matches the initial value.
+	 */
+	run_guest_do_rmw(t->vcpu, 0, 'B', 'C', true);
+
+	ret = __gmem_set_shared(t->gmem_fd, 0, nr_pages * page_size,
+				&error_offset, 0);
+	TEST_ASSERT_EQ(ret, 0);
+	TEST_ASSERT_EQ(error_offset, -1ul);
+
+	/* Same small chance of falsely failing test applies here. */
+	TEST_ASSERT(READ_ONCE(t->mem[0]) != 'C',
+		    "Conversion without specifying mode should scramble memory.");
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.1018.g2bb0e51243-goog

