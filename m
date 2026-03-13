Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64B37CD4B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382414; cv=none; b=Xmy3Go00Xzj9pV8cpl42c6Q4bb8EieV7Yr5gfF4p/DizQBVjEAtsN9y8YSam2m32fzzcC0t+z9a+ecjnX5mY2cPwOTtGaP3C/9JkMoAZBobiwaSd+jHW7Q0Z36qFaRgzvhvjtiwGjamoJCLp4ADRAGlE64NoqLxP6fuc5gWL8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382414; c=relaxed/simple;
	bh=6YBdYnXlnh2ASr+fdMWCeSskWVJ/R8KPH/FCsiDXM2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lVfPCgysJcN/rhjVwJ2Vl9SI/dGKyskPFKWLB8TYbju2WiQzgp9ODBLUhnExdjOTGTSfHziWbtIFjQqE0lql/FkhVqDvFJgoYGWVhfM8bt2mT5hTYmekklg5zBox7uVieFx+39+accbo2R0JntkZHw4DFRs1CCE4p1Ywgvlh8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhQNIhGq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhQNIhGq"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0337930eso1292362a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382410; x=1773987210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SD49el3nXHpiu7TuqLWU43zl6qsgos40VISsm5tNJ20=;
        b=DhQNIhGqTEkcMv6e23g3ZIp2K+YHbqXzQh0L69fiN+jTZVYIYWO1YDOpIv3J24irGv
         Ie/p6UdESuoYo5yKQkR4P8Xn2ktk0rvIkX26fMD/Iyc7ZjYh8K/B1M8Pu+IIGCETVOcE
         l1sUArBrtjclWoaBXdCRvPLRlF0SBfn/B4KlYxRbbvtk0UE8Mnn1f1ZJYRo5X/bnWm/u
         zVavM8+Mgm1/rDHqD/lsDoOe+QHrKWPBJG/OtQLcu+j1tC2L7+kSBmERwOOm+rqHBM3T
         HErpcsQVLE+7gOi75P++zdf2NO/OpMe7tWPt2wPcjgnxC0aC+abUJQnBvB1p1kGbxHVn
         2ewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382410; x=1773987210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD49el3nXHpiu7TuqLWU43zl6qsgos40VISsm5tNJ20=;
        b=hpHzDJK5UmqZObYh2WX3nh+Crqz+YhXfqtfkoILTgWQqI8k97QnHsjh0yrMrCLfRmX
         AMWzDLvf5S868oaEHukHxH24kIcL7tDlmhgm2wBb7sVzNVZuoPUuUWOXtBKPZ01rNU3Q
         12eS3NWgXJOtyC3QMbL/mZLxKbK1AlGvFoOIq/LVIEih1A7I0xl7HBJpO1i+Ub+hZWLO
         KmVF34ZP1/Sf/bvSim2f/mD5+BKvyH6J3hb6/VPNN+VD8P62ATssci4txZZcP91VKPGj
         zVE8JB7d3syv5zb+IftFCqPg5aRMZi5fYYH2rnE2/+u+oY28vqpWKDLtcVmZj4sMS08D
         lVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyZURXhII8FZLvwB2lgffKwkNPZ1pXuovE8PxJ96xdCrhIZJus8OTdig08G3rlWYlXJomShO53Ik7GLx7qzHbsczc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfG8hHnLFGaVyJZc3jkjS/3fHHsqyFNQ9OcdX3z287FddBz40
	EPI9aXKLho2Ghm/clmR2UGI/NvCv9Lgn1MmWK//8uQMzXO61U9SvxiFbaq0McVCRGOllpOWr+yB
	obRJhIhwWcb9e2aXtzylHO9Tx/Q==
X-Received: from pjboh7.prod.google.com ([2002:a17:90b:3a47:b0:35a:1f1c:b57])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4d:b0:359:f4de:8084 with SMTP id 98e67ed59e1d1-35a22055496mr1715311a91.23.1773382409773;
 Thu, 12 Mar 2026 23:13:29 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:04 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2091;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6YBdYnXlnh2ASr+fdMWCeSskWVJ/R8KPH/FCsiDXM2A=; b=PNTHQTPEfvhJt4KUJLTiC0sl1nGoyiRCq6pFiPQ3jfgkc13AGfEITB7bzmxWmbXGiusnqhK6F
 AmOrgyjI5khA8B6UdYdsA47sTUdRja2AJF9DD2ZITHM2l2nUZTSuFdF
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-25-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 25/43] KVM: selftests: Test precision of conversion
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

Enhance the guest_memfd indexing selftest to also verify the precision of
memory conversions between private and shared.

The existing test converted a single page within a multi-page mapping but
did not explicitly check the state of the surrounding pages after the
conversion loop.

Add checks to confirm that converting a single page from shared to private
only affects the target page. Iterate through all other pages in the
guest_memfd region to ensure they remain in their original shared state,
thus verifying that the conversion operation is precise and does not have
unintended side effects.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_conversions_test.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 9dc47316112fa..b109f078bc6bd 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -227,7 +227,8 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 
 /*
  * Test indexing of pages within guest_memfd, using test data that is a multiple
- * of page index.
+ * of page index.  Also test the precision of conversion, that it does not
+ * affect surrounding pages.
  */
 GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 {
@@ -247,12 +248,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 			test_shared(t, i, i * 2, i * 3, i * 4);
 	}
 
+	/* Confirm that only one page was converted */
 	for (i = 0; i < nr_pages; ++i) {
 		if (i == test_page)
-			test_convert_to_shared(t, i, i * 4, i * 5, i * 6);
+			test_private(t, i, i * 4, i * 6);
 		else
 			test_shared(t, i, i * 4, i * 5, i * 6);
 	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_shared(t, i, i * 6, i * 7, i * 8);
+		else
+			test_shared(t, i, i * 6, i * 7, i * 8);
+	}
 }
 
 /*

-- 
2.53.0.851.ga537e3e6e9-goog

