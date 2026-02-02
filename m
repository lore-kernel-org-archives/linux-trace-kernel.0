Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022E387357
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071461; cv=none; b=s435ArBKPpzd2nZKWb+ruS2h185sWt5v3yt599oBFYNpyTH74YnWvqmIqy7LXYNqZrt7yiG2RIZ0Uzr1jqmMKtNR0yez8X8CexOeyQLiGRAn5+jKeFkyejjP6wLwzA48+VPWi8U+AR2Qy4+2ju9FuQuuD77ClQjt+/Vob8xtw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071461; c=relaxed/simple;
	bh=gQoVKJ/MXjshP6WlZwkjatf0oU9CaCzLX3p+TMTGhTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYKsjHfMVhvkiI44BV5/g76sHO/F4/AQ27+YkQxMYge4Lp9Wo/2+S4uoIHUl8tCYumZdnNdLylkAinCrP+ocKToJ/P6ZMpcBEPwYE5eYOpw4sAyOprgpBavCIV3IHupx6/qa5esE94Flk3mRsV3LIFg1jEnOXooDTqX2UFvmi4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PErSnl9X; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PErSnl9X"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c551e6fe4b4so3136243a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071460; x=1770676260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QpJpjNtiQqUFaZF1GHJzrZ8wOPh8GbrrWjKTVRiEHc=;
        b=PErSnl9XM9V7+Pz/pSRBK+D22+69iQNN74AwmW3ns+PgTp56VbZ4U3jnqECYPIWtPh
         8WFYMna02mrI/0RRmiK+r0sxG7gYemjtj9SnR9+2wLk3HwEvAe8FhJHqUed6O1Fef+jt
         g1WfUmuisZDyNzIfx7boa7x1xGAwE1LSrKIXtbPDLc7d3CHMRejRMKP+kaqm3AnyeUEs
         1qOaeC5KM1UgBLv6bwsI/mcggdcTmnSuLSKcdpRmjziM8K6vmh/SIsriJrBwR7YiWfnU
         rloZqZ4Grmk3+QEuBu5g+QZQF1ZGYZ2SoEQA+dYY4quMOmSC3XyYoVnPdyKLAjvLSU3k
         jCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071460; x=1770676260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QpJpjNtiQqUFaZF1GHJzrZ8wOPh8GbrrWjKTVRiEHc=;
        b=ZbdgqT34ecLb8DULBP8MiqOnTDi20ccNxX6+JOscpZqWEE0Jq9p2PtDcMfdGkQWVjj
         VAyGGntQ7Y0RVvjjS3rMJiq7oAeI/eWH7/0EGE00FY5J4PCnfcjOx7FVEIn1YLOzJLc6
         xh3vo64G9IPXn5f6ixeGUCmIS/XvTfekRjng4GiazgtHVahPD1iAg8jykfRfkqAaR02d
         k8c4nJIxk6lDWZQOkBBMtDnjpyGsQPmWPARELnatXGPpkj2dq6zHMuBXAqQW0/1Gf1fO
         KvuGgw7rJr0clMRJMDMKqqRSf0HXdsA1erG2PQ4u23rsqhJSAGODOoovkAmGQ8+5wZKy
         +Rcw==
X-Forwarded-Encrypted: i=1; AJvYcCV2SPjcZh0gfmrCKvnw/RSMiyI4NJq0L5qobCcLiFNueMeQ4WrnI6twdfM7kbJCMmlAVcA3Ppt2fTQFLGcg3h2EamY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypMnvGFsyX0gYN7WW0+dfpWGqW55vDoVQPfQRQvMC7InWWWzNl
	+euP3W03HA6FOWsfTD1J6VKvH2at/I0AdnPsWsEWkL9MYsOyMViZum1OB2gl2LnK5hSbN1lkXAO
	twOA/S9Fzrp84tGrHY2U486whMA==
X-Received: from pjzh18.prod.google.com ([2002:a17:90a:ea92:b0:352:ba50:2819])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4b:b0:343:e461:9022 with SMTP id 98e67ed59e1d1-3543b3d6577mr13985758a91.24.1770071459728;
 Mon, 02 Feb 2026 14:30:59 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:01 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <8d37226a3827787d685315dfe730f099ec8b18dd.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 23/37] KVM: selftests: Test conversion before allocation
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two test cases to the guest_memfd conversions selftest to cover
the scenario where a conversion is requested before any memory has been
allocated in the guest_memfd region.

The KVM_MEMORY_CONVERT_GUEST ioctl can be called on a memory region at any
time. If the guest has not yet faulted in any pages for that region, the
kernel must record the conversion request and apply the requested state
when the pages are eventually allocated.

The new tests cover both conversion directions.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 8044581d5e5e..b48aa5d9f8cd 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -255,6 +255,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 	}
 }
 
+/*
+ * Test that even if there are no folios yet, conversion requests are recorded
+ * in guest_memfd.
+ */
+GMEM_CONVERSION_TEST_INIT_SHARED(before_allocation_shared)
+{
+	test_convert_to_private(t, 0, 0, 'A');
+}
+
+GMEM_CONVERSION_TEST_INIT_PRIVATE(before_allocation_private)
+{
+	test_convert_to_shared(t, 0, 0, 'A', 'B');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.53.0.rc1.225.gd81095ad13-goog

