Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414737FF56
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419213; cv=none; b=a/PXKoRdgY0qMCIrBy8fj8bmBjPPsnnMds3Yp8WiTVf+PPPyZPc7xUK1eel/L3hkj5VLGN6pICTlRX4AsOUUpj8BOdvwxaJ4CMLEuf23vbLnUwFyEYih2ZDCLcxJJpeRt886Y3qbC0+J/IartICbP0425d7ahQ0+4Hc3dRu+8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419213; c=relaxed/simple;
	bh=u5jNgX3aBCZeke7gIDGCVPb6JkDwECjFRBtYrME8E6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPELmvr8+UNc8zHFe41Fb5PyXv4NH1p9Dam9pKNWdzsLx3rL4Oj+f5+NkbLS/hXaTdkZg9gqrS2uIDlqaJBQhyRsX2q+NXrIlpelbTsSpIoMivH/pxSB+DZ202kGU/sB8V/kzwKBUjHzkoLf43fEq5+PwdZ9LfeIITWu/qEZqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0EbKtvI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0EbKtvI"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso3692022a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419210; x=1778024010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JywkponAAlLbpKs0ZR4pdZDQ9JhpG3xml6Pp+KH2bc4=;
        b=f0EbKtvIggskKvEMJ2/jHZ0vIccIW2mkd6vuGeStLeJ+1zsQHufB7qstKnjKkV0+xw
         +OLMAg6bbn5xX8BMUT+Mg7hU1nvjc6O2MpJB54SjYdh0C/3R1lw0mXmHlX7jitRgSgWS
         8xtI/Y+1ur0Sb3092x3a9IOlDAIOPaG5tUCYgFvisghsDsnXpvwGi/qw5DkT6I/DGY4A
         evvwqdgrYydCD6ZIrSQ9g12pDDURzQxVZ+wRmMIXWQ/4DwWCjlinIDMaSlodaYHKPRup
         UMF+A8Gb3U+KsjpU728uXkRu6wwwEPkNLB6/tBoejX1667brP0vFTctX5JQCszw1zxM8
         Lg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419210; x=1778024010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JywkponAAlLbpKs0ZR4pdZDQ9JhpG3xml6Pp+KH2bc4=;
        b=gJKhfBrFQ8jl1MEM13n6Jp8UsUj598wAt5+fhkT7ELu/HY+TAnaGZFj0FEyq97E/rH
         wV0DhTOkoI78IZqVApyDLfb59jhs2B+mGSu6k4qGiHyNljMMFtUrXH8vae1A1GWcEYXY
         2loGv+yKP2hNSOncvOmfkSheofQzFA9otvb9FoGGDE+/+jW5QqHsowtP+phWd1vsEBZd
         RneogYb2Mu77h2gkGwkzn79jGHmAFc+d9BaX9m/D5U7rPSVHCwDvAb4Qt1A7guCiEQYJ
         +eqjSxzYxoHKNHKHKp0r2x84LR9rywlOO7MYbq7NgRhwYY2BXT1dZf7OhSlXxd+WyJWV
         d7ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9u6yXt2LtvTwfMXM9W0HjgEVrYQqjynW4direHOIKYPCG8eJiuuRLrUNDSszsNVF70mIOKOeQcKk/Q/tBF/nEO2X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZe4Se1EtRIdNIy5iinHVvjrYyNzWAmolHzPeKDW6ysgP1cCEC
	QBXV87Owq8lro2Jdg5b1P0HbPghFRGG3Su/rlS1re6JO+bmo4AIocWNdHq0puTIs9iGq1nuWdYe
	BnpuqVkV2X2j1vgCdxQaIA1Ojiw==
X-Received: from pgbcr2.prod.google.com ([2002:a05:6a02:4102:b0:c76:1d9:8c20])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a20:b0:398:8546:c3fc with SMTP id adf61e73a8af0-3a39bffeb82mr6084413637.7.1777419209934;
 Tue, 28 Apr 2026 16:33:29 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:20 -0700
In-Reply-To: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <cover.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 0/6] guest_memfd in-place conversion selftests for SNP
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

With these POC patches, I was able to test the set memory
attributes/conversion ioctls with SNP.

The content policies work, and PRESERVE can be used before the SNP VM
is finalized. SNP_LAUNCH_UPDATE can accept 0 for source address and
the SNP VM runs fine. :)

Ackerley Tng (6):
  KVM: selftests: Initialize guest_memfd with INIT_SHARED
  KVM: selftests: Use guest_memfd memory contents in-place for SNP
    launch update
  KVM: selftests: Make guest_code_xsave more friendly
  KVM: selftests: Allow specifying CoCo-privateness while mapping a page
  KVM: selftests: Test conversions for SNP
  KVM: selftests: Test content modes ZERO and PRESERVE for SNP

 .../selftests/kvm/include/x86/processor.h     |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  13 +-
 tools/testing/selftests/kvm/lib/x86/sev.c     |   9 +-
 .../selftests/kvm/x86/sev_smoke_test.c        | 255 +++++++++++++++++-
 5 files changed, 271 insertions(+), 20 deletions(-)

--
2.54.0.545.g6539524ca2-goog
