Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC713BD625
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563928; cv=none; b=BFV4cKNupgm12GZbcEUxMEO4WBj50HhtnA7WHuPbZnd8NSRnuPnBdywv+e4Ibq6mBLf75AgXoudHKUy4e5NUxHWutC2GElxH8P1GRO5PFj3gPmBEw12g04GDpEtuObO4WcS2ibOwsQbOuXJqgqvnS29aIkCEJF6tyfGgJu6jijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563928; c=relaxed/simple;
	bh=+wZOcpFDmRXwMUiTSKOEYcZYo2gBc+x0kj6bHpNQCtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhttJqXDomrhd1NJgXifwadqPOeCH8HU+JcZLkjKkgNVvjIGTh9S+ccVBro0TXxRi7Y9pnN9cABSTVfUVWFkIES5KNjzN4l2HrZqf4/57XOKewZySBcJn3W+RcvyNXpilndT8AHUZk+20+lGcrSTQsWmYyvA0Ptz5ZWgU8QM/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1U96V5F; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1U96V5F"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso1827310a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563926; x=1775168726; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwC7doJg1Gvj03U54dEFf5nEFPJBiFxpbSbYLz91w9E=;
        b=p1U96V5FkPT9aZkY9J9/6oDrjCdifVVczmlTAobsOWoZXfMrtN9j9mXTlCBTejasMd
         /r67t5VSnnBTQJnb0qZxBdvq0d5HQM6TDP1MyW1rZZZBknxGbz7ElOWN0etJdidWR3I8
         H1zP3HSuxzavy52MO9w4sPt4zjaufw4f9c6inximDk85oWDDRPRvozwmfTuAlgYMIRLj
         QCP69CKWG+ZeQehbXkKOVbXwcDU729c/s/tvJY9RmmBUQe2AUG3V4MyzF4l/zHMiGO8Z
         NPYfLNeZTLYoLiwWqQgQj8hSMa6M4B4u+R+UrfzxRBAU1jrjH6H9pPyQunxXaft+aHS+
         veag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563926; x=1775168726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwC7doJg1Gvj03U54dEFf5nEFPJBiFxpbSbYLz91w9E=;
        b=Q9BxmUQBRXelkDQejE6YFmo7QSWVnW76dLcsEQwzvIlbbljwx/tlq/QT2F+9Hl+4sS
         2rFCazoIqjty009RqvI7ALEcxzqG5CE7H6VEGIWyS+2rnH9rn+6mgjvb5EjhCwMyfIw7
         5uaeMAT/Ex2ElgDg+Uda+aSaRoOXpIq+b3XlGwOLO33zLb/9ngwzEJ0NXfNsmrr2EIiW
         +DMVb1slhUS5BcxoNkJgj28qqZAhY5gzFHUtHFOwj38PGPimPW4mB+F35XX4ZYJtuK+Q
         6psVS/KX0aDioo/EmTFDj5VtRVu9WyMUepi80plQhj4IYvdqatJWGbm7gkh5/rSBDexX
         f6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4wNrQnmMpZb7al6yfOIig9mSuUEvVo3+1sDNnilAL3bwzhmeCLALZ1GP/tpyQpw65dKREbne4jK07WT43drNrJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mdg1fSefFtc3vcT/TgdkVS7zX7GewoONTnmKHTJrKsnKaZyb
	9ETfldZV86dV2g+Z1ZxnjGBxCAhAYJVVg5FgIQaBbl2yECNBOsp6y/PtDdS0r+A3ILhkerU+n9S
	TMlJ4pv3iIYyMXGs0bUaESgC9Gw==
X-Received: from pjqx4.prod.google.com ([2002:a17:90a:b004:b0:35c:2df3:c081])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b06:b0:35b:e52a:7d23 with SMTP id 98e67ed59e1d1-35c30117e64mr191331a91.28.1774563925502;
 Thu, 26 Mar 2026 15:25:25 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:39 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=1963;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=+wZOcpFDmRXwMUiTSKOEYcZYo2gBc+x0kj6bHpNQCtY=; b=aIMdopLnLwO2DBw/+/pPTRO0PTRtL85NVIpPoFXjBwUu+m8reLPqJ0xX4iIa55xeC6M1az4Vh
 4yReKUF3iOvDQCxU+P/EwvSTm1mCOOA+k1k+K+iQe1qoaGLasqt7PbD
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-30-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 30/44] KVM: selftests: Test that truncation does not
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
index 8f09671505b32..f195a202b3785 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -10,6 +10,7 @@
 #include <linux/sizes.h>
 
 #include "kvm_util.h"
+#include "kvm_syscalls.h"
 #include "kselftest_harness.h"
 #include "test_util.h"
 #include "ucall_common.h"
@@ -320,6 +321,19 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(unallocated_folios, 8)
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
2.53.0.1018.g2bb0e51243-goog

