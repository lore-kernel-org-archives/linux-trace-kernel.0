Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFC351C04
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563938; cv=none; b=ihL5HgFRaG8zHitl+DHZVwsgJQtTeBwI+x5d79e9uej7O6GIwAPC/H8I8pwwCiySWtKxxbTASfsxh8Bwxn5r6WADza79SVz2iyB3Dm2AQg0SD1OOrSbS3twFp0dFDYJAWDtVMAauA8zR95Q+9ptRZ/ztad9GmdeMB/8taL0eT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563938; c=relaxed/simple;
	bh=mbmnyh+Paq6B3nFHJjVqfDuPSLNxTEBywi3jrm5yLoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IC/eui/EDxU5pkDqCbWwjyt1M7OU690Eu2cgdnJ3UT1GHsiYGZMi06lwNKJTrjWmsosav8zb4NS0uDNHCSi2uwgXONen3mswhAzQWmTOT3E+x9fNfWLyRW/KmgZi6CDmuQV1cEMs7uEUM4kr95n1eQsZ8Kf1mJBzi8xmrv9ZRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dX0Ig1BC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dX0Ig1BC"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7385a1476aso1124589a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563934; x=1775168734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQv/c3jRIYhBhzt6KigDfrqgdsyHsqIxf08hCghwjGs=;
        b=dX0Ig1BC9f6wcZaVnloMFz091FKUqAa+Ppua+0yjFzpjZAE8ii5eDY0znaAEO6jcre
         yAsEraf9sEOmsm+9F7w63jJf1kjJ6/fJssqp1JZAJo0HPbrVixupIDZfCTsJzr271jyX
         Ex3VIjIvxbXFMFVFgbJSs0AQ8CwqKQeYp1pQKJAWBWmQNJ4SF80lEJIUCNQlN0LqsTEb
         BaS074t2mmTZn8BEEP3eND//nrPn6FguamVh7DQGfEERdh6HzSAGyBRBotQIx6Crn7+n
         ihjAjaeIZtUYjfjTNS2sFVA3PB4fq5FhQs3e1gh+kZsaW5swLjZnDzuxIhaoSgw9BupC
         sDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563934; x=1775168734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQv/c3jRIYhBhzt6KigDfrqgdsyHsqIxf08hCghwjGs=;
        b=cDiUHyt9ORBOju8aMF1CgRrFYfh9oEKRm4uR2y0yJgQXOV5E5C6FrmYHUyNHXiHLQr
         7Kth6DIpK/Vxa+FJZPCKsWsug9hZeYhSkbN5feaMsD7Q6aZoqSOS/XxZGuVbfIp5d4sk
         aky/oikS6WR5OhEscYBg7Ui5f+bLmo4JhgT3Fhei9ENioIhgo9n840J9uvjMOXnmcFPq
         xk/GXrFSdZKn8ZdMSP2+/RAxrLN6GZmlfnhvGPFys99yGgjoqQjUmWpSo8NbtbL2XsLN
         O0kSSQm4m4dJeDvRWq7GPnqMaHTu13q3W8DBEZ5xJKx3O2er4C6jDyeRMSGVZoKRwDhI
         cMwg==
X-Forwarded-Encrypted: i=1; AJvYcCVfcrMSG9kr8XeUO3pGH1gUDZpQo1o7dlmnFDKS+bQV3wDnFUnexs6SXxKhZiORJrQM6IRbHrd7nLJdiQ1qRJbFEfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ckvmMgAWgMErkKFLXAEN980tHAw2ijEFS5NDCRMApYdzeETc
	PIHGsMA6Ka4qs84yvlS5RZU0LBr9x6Ak1HekmxzBeHIGft5YMSjEaV/IU0sZ6DuqkmRCvcKi4kw
	q/L7aOZZG2/j65UKIdZau7r4gVw==
X-Received: from pfbfb41.prod.google.com ([2002:a05:6a00:2da9:b0:829:7d34:ff99])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13a9:b0:824:36f8:346f with SMTP id d2e1a72fcca58-82c95e7986bmr157171b3a.25.1774563933827;
 Thu, 26 Mar 2026 15:25:33 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:43 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2836;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mbmnyh+Paq6B3nFHJjVqfDuPSLNxTEBywi3jrm5yLoM=; b=ayjE20AS++xWp9N9WMziD80Oj2fnaF8+fEzlR1NValnRS6nVfyJUGa/eCX/UeeAKeN4u7/8Jy
 xLD/R+OSUjsBKl4tO0uelwfjOm2q3N6Bn3lz/wkKJsC7TbYULR2LjZv
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-34-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 34/44] KVM: selftests: Support checking that data not
 equal expected
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

Expand run_guest_do_rmw() to support checking that data at given pgoff is
not equal to expected_val. This will be used in a later patch that tests
that memory contents are scrambled.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c        | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index c0abc69f15332..277b122ec294c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -137,6 +137,7 @@ static void __gmem_conversions_multipage_##test(test_data_t *t, int nr_pages,	\
 struct guest_check_data {
 	void *mem;
 	char expected_val;
+	bool assert_not_equal;
 	char write_val;
 };
 static struct guest_check_data guest_data;
@@ -146,7 +147,13 @@ static void guest_do_rmw(void)
 	for (;;) {
 		char *mem = READ_ONCE(guest_data.mem);
 
-		GUEST_ASSERT_EQ(READ_ONCE(*mem), READ_ONCE(guest_data.expected_val));
+		if (READ_ONCE(guest_data.assert_not_equal)) {
+			GUEST_ASSERT_NE(READ_ONCE(*mem),
+					READ_ONCE(guest_data.expected_val));
+		} else {
+			GUEST_ASSERT_EQ(READ_ONCE(*mem),
+					READ_ONCE(guest_data.expected_val));
+		}
 		WRITE_ONCE(*mem, READ_ONCE(guest_data.write_val));
 
 		GUEST_SYNC(0);
@@ -154,13 +161,15 @@ static void guest_do_rmw(void)
 }
 
 static void run_guest_do_rmw(struct kvm_vcpu *vcpu, loff_t pgoff,
-			     char expected_val, char write_val)
+			     char expected_val, char write_val,
+			     bool assert_not_equal)
 {
 	struct ucall uc;
 	int r;
 
 	guest_data.mem = (void *)GUEST_MEMFD_SHARING_TEST_GVA + pgoff * page_size;
 	guest_data.expected_val = expected_val;
+	guest_data.assert_not_equal = assert_not_equal;
 	guest_data.write_val = write_val;
 	sync_global_to_guest(vcpu->vm, guest_data);
 
@@ -191,7 +200,7 @@ static void test_private(test_data_t *t, loff_t pgoff, char starting_val,
 			 char write_val)
 {
 	TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[pgoff * page_size], write_val));
-	run_guest_do_rmw(t->vcpu, pgoff, starting_val, write_val);
+	run_guest_do_rmw(t->vcpu, pgoff, starting_val, write_val, false);
 	TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[pgoff * page_size]));
 }
 
@@ -207,7 +216,7 @@ static void test_shared(test_data_t *t, loff_t pgoff, char starting_val,
 			char host_write_val, char write_val)
 {
 	host_do_rmw(t->mem, pgoff, starting_val, host_write_val);
-	run_guest_do_rmw(t->vcpu, pgoff, host_write_val, write_val);
+	run_guest_do_rmw(t->vcpu, pgoff, host_write_val, write_val, false);
 	TEST_ASSERT_EQ(READ_ONCE(t->mem[pgoff * page_size]), write_val);
 }
 

-- 
2.53.0.1018.g2bb0e51243-goog

