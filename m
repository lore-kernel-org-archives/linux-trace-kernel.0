Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F893446DE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731996; cv=none; b=M3QT2KqjyFrO5893rmgIT/mUJLCC0apCN15Mbh9WS5m4CbNVreX2KtOOfwSNQzyRL32GkXb6H/14dkwv7cR04zJMvsUUx9Yq65NOnaZlOm5Ohq4blzsLnn8DfzpjO2snKsmVRkFv4rl+e5B0IP4HWptqqCYq5tM9PEic7BVUJUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731996; c=relaxed/simple;
	bh=i0JjKVivSfUtEJKMtg8Zh0aQ6cl6o1OLhPEiIgjuNsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g4w51deb7cNjWfkzvBAlv896SK0dp6xp+m1yWjTOsR9rRY5lAYJ+J15xJOHl2lJ+lx46cPy4rmtFf664j7KOPQUnXZTOHdKnusEMmQmQXt1oVuRt7Hs10HjY3DK246krkKIqTp2acafTiOOMrv1LTFcpMqFR90Q9GsLePIp534Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nd9fH3AF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nd9fH3AF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb779733so1622555a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731988; x=1761336788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpPPOYob1QZnV0MVjnp55PhCGroJIJiVg+QyoFgvrb4=;
        b=Nd9fH3AFP8sW/QWuZh681RFQw31g3laz2+LPTG53+GbkQhDnzK75qYQgMGSU4aDrVd
         C4F++mtNvQZq8gLgCEnXUu7ZadHnZTqZB4sKMf8gWPjUVwf4q0yRv3qRDZb0kQmcw0wZ
         wQYfR+IbYuvr51xUilB52IUxGuZpHT3LvKlxNUf7kQvtnY2YxGdIaQEZbOomtgYaQTib
         zBKLejGCUcc7Sf5zmdtYvbw5ZXaTEfwZQN+WKGCzBSbzGn1W6wNp6ZDJ52QF3ibpLdHg
         df//9+JzvGJGRuqvgVzIYedA1yDRs6+vnXxDi/vO2yAE2SLw8N/cbvKWcnMrCT/1LTUU
         G/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731988; x=1761336788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpPPOYob1QZnV0MVjnp55PhCGroJIJiVg+QyoFgvrb4=;
        b=uSBIzcH06lcw73/Sfiiztj+KjyLCESdnB+I9X6GZold2Xg/ZxmOCX0rsk7FPmSRd3y
         oTNZ63AXvWUPqT2H+d6T276zfGrc7LyfymrcUkuVaXoPZ4tZ8hd+OmDcTyqjKjN4wdqc
         1b6m5ppLyxP/QtdSBY0Enp6dfUjmH4Go7Hjt/qHKT/TojagycvHuB1mb+eruw44w/B8e
         WLSFiuDh6wUDpa88UZ5Gr7d3NUoMGkPajycWbAWMNi8iBOmZ6ZmCUOAnik4BhpkMdbO9
         r5pCYFKswuXhgW/Z2ma72Qt4kzlKz0LKtyCMAHhlWjJJ7U4xbMPt3BxGDi+XrkWJX2Nw
         u2+w==
X-Forwarded-Encrypted: i=1; AJvYcCWmHomu9bT/MUHSTi5tDFxzi+NHcIxXPQzdkNfsJtNjxD9umf3cAPa9tJgE32HIL/lpSgEXQmw5ILXCRu2/rkH1ZNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRa1nJv30of0z7+npWSnVA792170PhpJ31gLpG6V+lzu7G4Kx
	YDCFpKxtRwhgewHWQGXVzQv9VD3bRcDEA9uZmYZv+WvR/UtwfEhcwjETbDKN02FuUWHb89IdLBU
	MJtErDcrmF2K89bpdxcDV0UxexQ==
X-Google-Smtp-Source: AGHT+IFaVh5FLKaAG/q3ccs7S5CZUmyME95ySy5g2wu/pIuJKr9rpIYkO/d4uo4694WlqOqMAyATNgjBKMjQAO8boA==
X-Received: from pjbnl2.prod.google.com ([2002:a17:90b:3842:b0:33b:51fe:1a73])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33bcf8f7280mr5551444a91.25.1760731988400;
 Fri, 17 Oct 2025 13:13:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:05 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <1869a0b8eaf867052c11a04fe1efb1442ba1897d.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 24/37] KVM: selftests: guest_memfd: Test precision of conversion
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

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
 .../selftests/kvm/guest_memfd_conversions_test.c    | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index b42b1b27cb727..43efe4af1403c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -235,7 +235,8 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 
 /*
  * Test indexing of pages within guest_memfd, using test data that is a multiple
- * of page index.
+ * of page index.  Also test the precision of conversion, that it does not
+ * affect surrounding pages.
  */
 GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 {
@@ -255,12 +256,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
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
2.51.0.858.gf9c4a03a3a-goog

