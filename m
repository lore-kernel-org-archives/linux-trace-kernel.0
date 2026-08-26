Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64139DBF4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735963; cv=none; b=jS9Zeo6H7UjzePffmm39k8tXAiU+OEIqr+Ay4ESDrJTpfLGKzOv//6XJvdrvpWysTLbnpq8YDqfZRolTLKoUMp08UcQ961+iz74V+sJXwXo0tsrLj2X0tHxxu5RbYDk6oROj0UqKAbvE4li+N5ykarghNHMTV7Mw79BEZBFi5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735963; c=relaxed/simple;
	bh=Z2tr8qvCMQ6vCwWclEIKVEn4lsWDwgpi8MEvWzFtaCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ug2XTp4uw0FX95uUJkdlA4AYTEpgHaqf4KMghgJ1bT3uPLi2sl0r44HEGpAo4JnfqDOcO3thBN1rk2gD0+OAqIm34udDFdp4EcYnM6QINtwylVSX8MF8qWcHBVXtzCshsCGLOtBxo1adsPiHrhVLzIN6zbjaIBYyjvpNsq9B2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7nQPZRN; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7nQPZRN"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1a439db36so897057a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735954; x=1788340754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLTz+QoAp4yNZ1r8wY9Xq6qZeJQ57AOaVsGWHTn9ANY=;
        b=v7nQPZRN+1YjQYNRmycYV+5Nt+CAjnglvT0mEIlR2rXs1pxsUKOki2cudUSEXgvsiq
         CufN/FlOk4ngaAuZXWn0QpfhNvp2Q+GtM3YqIUyjfyAAB2L8dOGWPqmGWWJo2K1kG0bd
         4J6r2OHV5H/sBQBqz67W4A/6/qo34PGWHnw2a+syp0ogZ0VUO58DwQMVepD/l1Vsk7CX
         R/huU3LRpxGmLLPhh7oUQuR2Smlu4A8JA9oFO7Tyj60ZOOJjKQ6DxZzQjhZ3Z1Tk6nIm
         3jUOBKK3CLJZWphOkg14Qcfix1kVdBUD3MBd6hGO5oN9ZQnOGkGJa+WHHopfgi+mPoM5
         rJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735954; x=1788340754;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bLTz+QoAp4yNZ1r8wY9Xq6qZeJQ57AOaVsGWHTn9ANY=;
        b=CNRxLat1sMFIbnu/m/xNnDQPC1StnHy1bqNxUR2PcwYaDvWuFwTT62Y1ME0UnHzP5a
         60m1DsRXX9dHGlmilK49d0bxQvf/EAnH1FRgV0mJHupIttTWioeS2YP0JidJCIv7mY6C
         CU2rG4Rt2b/HLJarX9P0G7W07d75Bx2VEau79fGKHz0m+Vid2x5TRgQ/WNwp27XpXjBs
         zCxuoT2Ea9/CHpbPHGOyHA0bYSwIjLTZSW6TOdE4hqBG3Z1+jpyCcMrHQGqAzTrSpRWe
         eYc+QB/NgnDgUIdmU5NhOu8EI3Uby1RsLLX/5k8I+vN9nAbnXaXg7C0TPVjVdrIMxc4K
         WKgw==
X-Forwarded-Encrypted: i=1; AHgh+RrekyU4aC8fJ9HOBjKcsiJBCmbpkGjXL/AGO7K88loi7v3TrhLR+JrX2suIfroN0NCaRKBD4HuihjawzltF3vs6bTw=@vger.kernel.org
X-Gm-Message-State: AFuF++lMs7D5dMzePAukTgTY6NhNACSgOKhE1MhzYixxZ945p5/W5xyk
	PbCD6RD0iB0BTEFUS1vDgMVdmsMDDncL33swc3SLgievOeL5cznMwi35Fml5ZBICdnQNkz4JIje
	QUCNb+ln97djI+JdoLTELCMEuOA==
X-Received: from pgcq30.prod.google.com ([2002:a63:751e:0:b0:c9b:2759:d240])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6681:b0:3cc:9288:99aa with SMTP id adf61e73a8af0-3cf6673e199mr11680996637.0.1787735954249;
 Wed, 26 Aug 2026 02:19:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:37 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2579;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Z2tr8qvCMQ6vCwWclEIKVEn4lsWDwgpi8MEvWzFtaCI=; b=uYPyckNcYtbmNIce6USQWE2ZQN3yzQ5s9PRlHn/kQiqauAVRj01fYWLdGSn4JUn4Y8ICRU4i5
 SrOFy7IMtVFANbmMI9ps1KJiTpkrRcJ6bBbcMXjogb2zUhXxCkElfSO
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-39-0a15d8a799aa@google.com>
Subject: [PATCH v11 39/46] KVM: selftests: Reset shared memory after hole-punching
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

private_mem_conversions_test used to reset the shared memory that was used
for the test to an initial pattern at the end of each test iteration. Then,
it would punch out the pages, which would zero memory.

Without in-place conversion, the resetting would write shared memory, and
hole-punching will zero private memory, hence resetting the test to the
state at the beginning of the for loop.

With in-place conversion, resetting writes memory as shared, and
hole-punching zeroes the same physical memory, hence undoing the reset
done before the hole punch.

Move the resetting after the hole-punching, and reset the entire
PER_CPU_DATA_SIZE instead of just the tested range.

With in-place conversion, this zeroes and then resets the same physical
memory. Without in-place conversion, the private memory is zeroed, and the
shared memory is reset to init_p.

This is sufficient since at each test stage, the memory is assumed to start
as shared, and private memory is always assumed to start zeroed. Conversion
zeroes memory, so the future test stages will work as expected.

Fixes: 43f623f350ce1 ("KVM: selftests: Add x86-only selftest for private memory conversions")
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index f3de2a4ab0551..cf50e9a332c5b 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -202,15 +202,18 @@ static void guest_test_explicit_conversion(u64 base_gpa, bool do_fallocate)
 		guest_sync_shared(gpa, size, p3, p4);
 		memcmp_g(gpa, p4, size);
 
-		/* Reset the shared memory back to the initial pattern. */
-		memset((void *)gpa, init_p, size);
-
 		/*
 		 * Free (via PUNCH_HOLE) *all* private memory so that the next
 		 * iteration starts from a clean slate, e.g. with respect to
 		 * whether or not there are pages/folios in guest_mem.
 		 */
 		guest_map_shared(base_gpa, PER_CPU_DATA_SIZE, true);
+
+		/*
+		 * Hole-punching above zeroed private memory. Reset shared
+		 * memory in preparation for the next GUEST_STAGE.
+		 */
+		memset((void *)base_gpa, init_p, PER_CPU_DATA_SIZE);
 	}
 }
 

-- 
2.55.0.887.g758fc8c411-goog

