Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C537E2FC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382416; cv=none; b=NVj7phTtm8x26fx349IYLQ0us0um9cdQtiwjN8woz/N7HRiSM0H3WwKPsS6mEOebT6wl13idEkOQj1h3NfW0RzQ8SgNeI63Rlskox38M0xYc8xc4sEHib4+jKONW/1kR/n8EYQ3AH6lFJQdwyM2hVxhYZOJpZ5v6gmK5ivxfS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382416; c=relaxed/simple;
	bh=56/zjr6xU9a2m6PNWz2cIUvRanV0VxsnnbXP2H5M1fU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pMZTOCbH+9pVwMVcqwvacLvl+pfmJEJ5Eqeut1tczyUpisEyq4+oRD0bLe8ApC5u52aMGvIs9odnnHKtcj3P7VyFoVZXj95kh4Fg/Yu7gakT+tu9HwCZCJfAPXl++pRU4lmVJBv7UTx3PmFqGYCPIg9SmbMTlxJ1IQvr2KzzxqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UNRuDLcw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNRuDLcw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0998a441so11197260a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382412; x=1773987212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSBIDB/ezQI0Wvtx4iOhvmaJE6wuN3Y0svhFaOA6jy4=;
        b=UNRuDLcwnKqG6BZ8TeS/u5mkDvOkKXUuLKgv6PJzlZSAAhK73EnVP6tBhR53saeqXu
         SFL5fw0fFS2MQ42XVTqlaUThjVMAWZgIF7jZQ480YN+Tqu00kztDBaFrmw11pnT5ayle
         lq6wPMMrrUX5EY8XpWYqMU8/bVVvnO23MKaiSO2U7j96hLT6MxTBc4qDHpx1H+Sk6zrQ
         6hYOCQ717YR60vtgEaR9yUa8Ph5xGbs8p8rT3xVChupqDO9hYN++yFSipQb5TpqkMuI2
         5yTcQefm6tNPUcZTIRSYxzo73HLLFM9M8cKs0+xMg/YaNiz7+4Do/z1uX62Ss7WBw8bh
         j2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382412; x=1773987212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSBIDB/ezQI0Wvtx4iOhvmaJE6wuN3Y0svhFaOA6jy4=;
        b=H8zyS3JM8LPI1iI/5Fg/+dQwuHnHy3EGErVZcuivlq/U/OR+hJaJO1YqAoT4Xk7hrT
         OIp9Eoq3pBb+mWJ6Rn9SCghMJ7VyVJstoPsvzzShCkfTQ1nbw07sGwraAt9VVUNWXKJJ
         h3NXIMhwUuvMyzqatd0U8cVrDDYMDDoTiQ8dR2L6bIM88ZXT3B0CJszWgRC16lAIGFVp
         23gnaSNdpiuOEMlQK+0G7w51bQhqB0P0wkZLagwV/GbA17WrXYQ+jEW6SnxTC3dWH5+K
         6joP+ZENwtvTghJebUwvl4dRaspr/YnQCS0/TbnCa9Vmdapm6P3w0mQBW8pfgO0KfKej
         LmTA==
X-Forwarded-Encrypted: i=1; AJvYcCVQCLire6ylSpMDoWy+1q6aIgtcLBPdrE+8P5+q+LZmpYnF6Z2oNIlxPbHA9Bq0SwizdkwDwEEx35T0UVsfKrv6PP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uBqSiYpEqZA6yhI8ZayyfKl89PJsaxoM16AIVaCA3UaAjm87
	CT1GFEIevkCNVJ7oxw90unMSSMSLazlQXdOWtoz0SX6TGB5CPaRW0x80YXQNCvieiCxTZUF2FA6
	Wf46FxS8TcJnfJ+QzibmINNkWUQ==
X-Received: from pjbli13.prod.google.com ([2002:a17:90b:48cd:b0:356:20f7:5344])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c8f:b0:353:e91:9b38 with SMTP id 98e67ed59e1d1-35a220b9fdcmr1978831a91.34.1773382411375;
 Thu, 12 Mar 2026 23:13:31 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:05 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1962;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=56/zjr6xU9a2m6PNWz2cIUvRanV0VxsnnbXP2H5M1fU=; b=h9jqU7xHor+02bUk347m4gpVjd5rVb7Yxm/mn+WFbkm85uDs4u9mnaWihlocy3zeYfVDrJkFW
 tW/T0KZJLkBD/zA4yrx71TTuDTl1JU5erPasZYBKgBt5Ic8lMs7D8GP
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-26-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 26/43] KVM: selftests: Test that truncation does not
 change shared/private status
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

Add a test to verify that deallocating a page in a guest memfd region via
fallocate() with FALLOC_FL_PUNCH_HOLE does not alter the shared or private
status of the corresponding memory range.

When a page backing a guest memfd mapping is deallocated, e.g., by punching
a hole or truncating the file, and then subsequently faulted back in, the
new page must inherit the correct shared/private status tracked by
guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_conversions_test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index b109f078bc6bd..89881a71902e6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 
 #include "kvm_util.h"
+#include "kvm_syscalls.h"
 #include "kselftest_harness.h"
 #include "test_util.h"
 #include "ucall_common.h"
@@ -308,6 +309,19 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
 		test_convert_to_shared(t, i, 'B', 'C', 'D');
 }
 
+/* Truncation should not affect shared/private status. */
+GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
+{
+	host_do_rmw(t->mem, 0, 0, 'A');
+	kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	host_do_rmw(t->mem, 0, 0, 'A');
+
+	test_convert_to_private(t, 0, 'A', 'B');
+
+	kvm_fallocate(t->gmem_fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page_size);
+	test_private(t, 0, 0, 'A');
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.53.0.851.ga537e3e6e9-goog

