Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37E37F755
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071459; cv=none; b=ej12/IxIST8JEJ2dRDqm7dh1s3SM/qASNYBVnYvOU8/Xvx+lWeoHxJau22qScgNIkGMdh6wtz1TOat9sOIVwIf53ddnkjUREq200bDx80eq/Nd7k4MiXgaohrtsLW1BIttBk+vYhUjhNHCmQCJhZl3O6M+nzHFAvJO81pNtnbls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071459; c=relaxed/simple;
	bh=2Pig+BE6mlwz3Atq97H7ZcTJ4jMwJiYk8WbNx5KJYm4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ALW5AGFDCelVvhTPlT5aKWI3sPNpmv6dlTh0WOGaY4IK78LSWzTpSU+MDuL6gnbFVcRfj8u9DPSVyhUJgG4F+DQi0GPbfe3xbJ+u/Glw97RKISDTjveiz6mXfHJ8G+D/UC7ylVtpugej5P9HaVFk0uCj8tf9mAF0Yy8rTb0DwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpAXDRy+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpAXDRy+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545dbb7f14so1865951a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071457; x=1770676257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KnXsdQ94XcuKuzn9mP+GBRZHRqSPvjoz+jTMa8UBwEA=;
        b=tpAXDRy+MH62c8PBeVdoW7/3MYKlkUP8Uw89rf6CBHBshRelxSJOKPkqDchrwpFiTf
         12HM/4cVagjt6NT+00MaVlvW6rZy9/0Ao+D1YrBYIcM7ReGTkLrJVf2AYeDrg52iQTXm
         7LaW9Dq+M2LTx8rZp6HB8qkguOiLJ5jLHrPMH9Y6K9U4bXDcDuxFrY7lBfYFXUul1tP1
         rXLIKY5vLdxRv3QupVFHtBgY+h4ULWd5tV8CYVy3yUwxsMu9lFwnlGbqFLrPRHGr7Yzv
         pNR16ngbwrShrsBSpKZui+/cYFSNm5AdWyfcKA4dvvfOPWxukzFk+v9AT/n7VVrksr1K
         Gynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071457; x=1770676257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnXsdQ94XcuKuzn9mP+GBRZHRqSPvjoz+jTMa8UBwEA=;
        b=JWh1vfW3o2St1ZrFHEHRHs2ahj/Nk3AAHPDdnP1E+ExSmFuWRF6YUqaHszlLJNfSU8
         bkQZiegefvmHB3R43UQWdiP/XXXNJjgR0LRbMc65RMbHlI785UqcRsB6k7lEkWAwbLpz
         HHPCM8FNZmXeR56Brkw9/++HcgR06dD6ReNibeUwnk3I/f16sVp9x9UJDLghf+f/euL+
         /v9rmJCSmYSdBeqk28LMpBbfgBGSbranRdgZUTxEajh7Kx27dxcY5yQHVKABpt6AJ1vV
         477Hn/v05Qb710y+iBh+J+iyhFcWesTN3JRSQ2UiposB+vkDYZBfW56cK/ETXDY4ZPuz
         CviQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FYV7n694bK+8k3nM2kJCBKbYj+AlYppE3k+CDdwlh6crsHKJHGfTbhZswmoAEgRjOPocdolkwEQxu5v0kKsHFdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmPx5r6VnPZW6ObtThHrSRvD+OGRZffEhug7+Iw3DW1NDF7QN
	MYug1VMV45hQff02/c2+VwJaOkpRfvNd79OY3M5t6UsNlEpbWvNAQAPLSFzUQ687klnCl8PS6kx
	9e2B/d55owGMkf3tntHR1DINYaA==
X-Received: from pjkh1.prod.google.com ([2002:a17:90a:7101:b0:350:fd27:2bc8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:fc4f:b0:352:b674:2592 with SMTP id 98e67ed59e1d1-3543b30564bmr14178775a91.7.1770071456574;
 Mon, 02 Feb 2026 14:30:56 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:59 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <84cd59d887139f01a0624c214c0a43f4c0c730f8.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 21/37] KVM: selftests: Test conversion flow when INIT_SHARED
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

Add a test case to verify that conversions between private and shared
memory work correctly when the memory is initially created as shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 48265215f218..438937980f04 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -95,6 +95,12 @@ static void __gmem_conversions_##test(test_data_t *t, int nr_pages)		\
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
@@ -186,6 +192,12 @@ GMEM_CONVERSION_TEST_INIT_PRIVATE(init_private)
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
2.53.0.rc1.225.gd81095ad13-goog

