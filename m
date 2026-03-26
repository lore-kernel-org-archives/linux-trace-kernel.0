Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597DC34CFDA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563920; cv=none; b=YnPpObjlZkz96SMEtlqhn7RyxTs8fz1MO7wuPVYB/8IfVPMQ23zd6W8T5VhHLRM2JjkQmgHJaMVESB6wt8Zn+aNTf15wfVoUZ9y21Y6/XbQ2WqzGgHZfK/TLmTvlbblGsI7m8jT/bLPzbKqTiu0nGW3IA8V3dkhpTlrcvPMOCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563920; c=relaxed/simple;
	bh=ArwNEKwwbHDIAB+t8VvlCTKnXSiAkRboJv5hBzhssb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GVLNO/NKtptan3n/ghFlMf+xwEAws27IWq2zURegAsvvRPiKYLQsl63nqojom/g/pOS9ic1EzZVBYk+RFu9fkGw4xxPHisIdBQqMoPjBGoEP5hnOsD+x48XBqtey0+BMlbKuuP3G29JjMeQfIo+QUmyrgrccQY8tsOhxN1QzJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cF6tadEA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cF6tadEA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c4664f75fso1143740b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563918; x=1775168718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CxbETzKCXSc1z/DONft2GKvio3jGrUYSbzzgOX+Xf7Y=;
        b=cF6tadEA+t53w5s4sFp5v60oMpCRU76cxW/4pMUAEyn4sdz1chqlc2RJtUdo/9E941
         u/w3FajvzaX56npIArgVxdDviYqb+a3rLX39fHgwxO0iRB7nduNZ0N9aQBGARxjOVxLl
         822y0QCjqxzoP64znEoMT2JZR+geChwZz0Puw+FJYHFSQtxybcosHlSRGbazx5GStPgN
         Xnbi6wKFza1y8mcIyxaAu4YgpxIrEiAjjHVIfZU94XRPDVJF3/B2QFz57xrpd9bFftV4
         YWHKtkt7BCOIXQSvEg8/pNEZzEhTxT5fOQngB8IpH5WRTmPyG5azPsgQL7oYHPx6IkOo
         TqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563918; x=1775168718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxbETzKCXSc1z/DONft2GKvio3jGrUYSbzzgOX+Xf7Y=;
        b=agmODOjD+KwvzBxA8LlYnzKOoT3dBIV8QYGjsR+o64FVhOw5wYZXDsVE7Jso3RYJqu
         rYmRAhnzW/XEgpECKa/gSr2xZzZizQML1Pj5PSVmFldwa2rJ7ITGpYakJ0s8+sxVyu4S
         l1BBm6cxYnkYRRlHqvxj78nt7if/XITQtI9nipaiCw44OlfPc6Oc3EOUvbD0taIJpZp8
         SvErGCxXUKG6VJxY09UNYLwere4Dl9xDZWFTxBlJOo1v6JQYYvipiZn2XZO7K1JHLlkG
         cG9vDUZyXq4tFjLQnaHj5QDfyc6y7JR0p4JavNJO8I9RJp0ZXoDv0yJ4VVbmRLIiH0/M
         zlsA==
X-Forwarded-Encrypted: i=1; AJvYcCXoVzXcDT9htHDdlu5I//wUP0iSMmDrFZ6icxkggS2ALgeHFgGpkYXVi26JEObGNhQ7X+4Bo2YlEuiUD7Uflph7Pfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdCp82DsOn7cLSdmBNbTodwPNiXui8AKB83vQM7RTeJ0AFJUq
	zJbhw70cqq+O6eSWRVBc5UOfTCK26/u9Ctfs8wkZLx37kci6sC+bue6QnM6lCxo3eyppProDVOd
	xP8tvQPbv7rjEi5n9Bl5Q4DWBfQ==
X-Received: from pfjt19.prod.google.com ([2002:a05:6a00:21d3:b0:829:7eec:794])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d9c:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82c95d45917mr156048b3a.9.1774563917419;
 Thu, 26 Mar 2026 15:25:17 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:35 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1634;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ArwNEKwwbHDIAB+t8VvlCTKnXSiAkRboJv5hBzhssb8=; b=HuNUrwsYNrR2xPk/81EPYUE2OyqfcxrfmGxVWyTqFZ8vv4BhYbVtUf37zL0SDyT8xifQZ2GBO
 GDQbPyxFFKxB4OFuan+Lw5MWnRIWkraFqN+uu8w7p8oOz9swRrVK2Bi
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-26-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 26/44] KVM: selftests: Test conversion flow when INIT_SHARED
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

Add a test case to verify that conversions between private and shared
memory work correctly when the memory is initially created as shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_conversions_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 841b2824ae996..81cbdb5def565 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -99,6 +99,12 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
 #define GMEM_CONVERSION_TEST_INIT_PRIVATE(test)					\
 	__GMEM_CONVERSION_TEST_INIT_PRIVATE(test, 1)
 
+#define __GMEM_CONVERSION_TEST_INIT_SHARED(test, __nr_pages)			\
+	GMEM_CONVERSION_TEST(test, __nr_pages, GUEST_MEMFD_FLAG_INIT_SHARED)
+
+#define GMEM_CONVERSION_TEST_INIT_SHARED(test)					\
+	__GMEM_CONVERSION_TEST_INIT_SHARED(test, 1)
+
 struct guest_check_data {
 	void *mem;
 	char expected_val;
@@ -192,6 +198,12 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
 	test_convert_to_private(t, 0, 'C', 'E');
 }
 
+GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
+{
+	test_shared(t, 0, 0, 'A', 'B');
+	test_convert_to_private(t, 0, 'B', 'C');
+	test_convert_to_shared(t, 0, 'C', 'D', 'E');
+}
 
 int main(int argc, char *argv[])
 {

-- 
2.53.0.1018.g2bb0e51243-goog

