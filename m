Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F344378D7D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382405; cv=none; b=X1H0jXpOJUvhR2hwoD0mPGXAq3OcyOYNDV44uVEIus4ZGDqX+Lk9GwvZFzpy4rJMpePE1xfA+znnNmINbu8NfrDipGxxvgLQP4eP25uEilvHpoiIhDtd9EGP/1571yX0BzOhWMFjWknhclZxNHuLBYxO0CkFwkieWEcytNaBVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382405; c=relaxed/simple;
	bh=q/hUjyayyxIUGAve3+Vu0unD6ouS2wqBVjqcFYH1mcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d6tLe8mZ45a8drDOi5Z81rqlF6EwmpAU76llYjzCvI/+PPETs+sjmucFGAAL/y/cH/O9qFN7RFiiuiUZQeRM6OcoZqh/vKLhKbwKzl7Aelo2PfMMtXtXeu6J/Q8ZJBHTfmuIWxS0oNOtXVgXMHuKGJBtMN08ZYfq+E3VMD9sMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0RmnLD/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0RmnLD/"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8813449a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382403; x=1773987203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqFbSwro/vziukGQDmOP6ESDyzxqHCPDGmwxuCwTFaw=;
        b=J0RmnLD/3eTGT6w+x4G5sERgE9MO+AOwgomJZ+1nAzpGpn9ixkF0sSuZ3dJQp2zj0b
         DMnc+CLj7iN1b0xksFyqBAKOjIto/O5tn3u41EtfIY/SKOaudZqtAVG4RleMsy9wOJAg
         pPVQ43qXHLQryoCUEZTWtipgNssT9aN0GEF695hph5/0qBjGMfLKoI8RTwxnMGDlh9l0
         AA8ZzZOCVqxAhEbzwCWU7nKmo6gscvktfTONbbuGzYhSYPG8DZ8lzIdnunMElAmudFyA
         hcBr2+JRqlvFnNLiw+dFPvmvB/jv52czrubN5VhhNJkajlsO1+Vr21JNGz1VZykGmHiK
         UW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382403; x=1773987203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqFbSwro/vziukGQDmOP6ESDyzxqHCPDGmwxuCwTFaw=;
        b=o1y+65VSYxo7F4DALeaXk3JopRPmvOkcsTT06Ozd1bO0ne1EAWfA/3hjdOtqX35Z+C
         1zos9ksc6vVJEvYAOURQb/11LVd23Rry+R3FigHBcToCQcvQLHN8YnUn7rk1QGZ3Z93o
         DAQjjYLBlSHFRq4/WCswSCV75pSjhC5b1XNFyfKC4AzY4fm9We9vY8f53HLFgYwjyw5x
         qrWUjlOYbXt1h08pOOianjlOTHWy27+jNeV1kHi+FlP9cuB+Cijns1gyIsofAiXfwxBO
         jm5Qt7NL6O10X7W2HaTE+hqBmQI9bIvfaw3wWne4hyZVLD6wJjkVvmKk6m15OpNZaGkN
         Er9w==
X-Forwarded-Encrypted: i=1; AJvYcCV9Jl/PbEpVYWD0plar7C2T8fX6oPo/eJH3LKGVsClziA7s6evhb3rfmzU5m8D5rILbdhM7V9rkifrQ2lhrqICpsTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ybl0YQZrynlwyLOz2D0qF0ZJKwCItN/aRx0MFzqi3BREtKeX
	/KznQ6ChreANDy9LUt5iwn3HmYwxBdeB9CSgIUoO1JB/VttIx4VD8IrLCcT1sJkgfVIPK9YU9Uc
	C8EpcqfwmRup4Sa5CNgda0jRtnA==
X-Received: from pgaq65.prod.google.com ([2002:a63:4344:0:b0:c73:782a:efb7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:48f:b0:398:7eb4:8aa4 with SMTP id adf61e73a8af0-398ecb06ee9mr1431398637.31.1773382403294;
 Thu, 12 Mar 2026 23:13:23 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:00 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1633;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=q/hUjyayyxIUGAve3+Vu0unD6ouS2wqBVjqcFYH1mcY=; b=KFALu0XqU0kUJRGPpaQ6XHmJJBfjiFhtEtx+3eZJ7J8OPNlvzxV5bAOANVDRnUrzOqL1+MumN
 MZf3kMjOT6GBk4TMFhbOmbJtjrpSiF8aaYqitNajbyCMlhj0wXREzD3
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-21-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 21/43] KVM: selftests: Test conversion flow when INIT_SHARED
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

Add a test case to verify that conversions between private and shared
memory work correctly when the memory is initially created as shared.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_conversions_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 48265215f218e..438937980f040 100644
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
2.53.0.851.ga537e3e6e9-goog

