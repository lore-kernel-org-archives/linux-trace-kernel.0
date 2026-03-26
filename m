Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F334EEE6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563940; cv=none; b=WST5r7zmRZYA08uzUNYMQ79uL8k3fBUspYY0RD8OOz+JxqrIIaorQ7ocJHPzCa4eM8eiTkzOLVhZkgMicT2/wKzW7F+G8TmFIKwRHKUA47+GbhckWwLN4MIfXUQcLARVq+c8gx7JK21hQO3jmUaV0/LWxYDmmugwV8UVssrqoAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563940; c=relaxed/simple;
	bh=rWCcSWsmhbugoQ/CrLBaDfQJULRa6k6zO+0SZDZQZEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BkJNp2+W5L9edY5DLB0AheCs1lN/XmMlO/kSLxdaYq6f5ImayAvBYZrAlaN9KdTQPUIw8r7yxDMv32BkNqRtMqjbzvGi5IuY58llt/GOgQdpKzbnnhBkCaHOD151Phj/87U6xk26SAFfNSQ5Jze50to6/zuqVcXs0BFfZDJpV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TzVoMkUN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzVoMkUN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aecbb78e44so30261435ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563938; x=1775168738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d2+twVU5Kq9cuyYv1c7sUjk5voAbaDSz+rxqzaEeBxI=;
        b=TzVoMkUN1hAIZgQVWWLj9seZWk/IYD4fpc/TK6YbNhNUnYGOr0J5euoNjHP677hIn6
         KggK2BSgySldQLrW3yaIegokNsIJ4PU3wXc7w0WhfMnL0YgADyfmm9wYfGUp3Ip+12dG
         Xf5slyWMwjaRLojlubEqXpPRxTAuJk/nzcAZxGFNtq1V3IO4LsriLlqOKtfDhzAE4Ojc
         fkZfpFh98VJ7MV36SE5YV0diy8A2bS/wutI8jhlCrxvp9mkflKTbGWCQ8CAKi5w3Z+23
         AcbDHDonuS4X1fcJUIW0aMRrhlfq0ztEldvWrxTYorLrIBl5naIiOAEfqpL2WVXp0MQa
         8uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563938; x=1775168738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2+twVU5Kq9cuyYv1c7sUjk5voAbaDSz+rxqzaEeBxI=;
        b=qcZzvUr6taj/V8YmRjQA5I8Hs4zPUElroP43u8kv74IrcgczCpsGGU7w09u/k8UdVf
         uVDemUPrIRHk62wn6V6b6hxeD8yVVXZ2DadBRlgyFYS3r0NNbKL1NmSQ3tpPjdULYlc7
         9QQ0HoIXeqm/vTWvPr0gs8hmfs9gZ1ljnjQe5/63fAY376odcVlZMpdkpwvZ+5hKc91a
         yf7CJAQHqimEgs3h5+8FwUfRw8sT1So+BPs1axHDhsTRTkBQWA/bYkMXnDFnSMFQ53xj
         Fq955QwkTxbG0NWHf9nShRFI3lUFZyWVSv6sVOq2QifL7qgX9NOshPN6wsqRtwwy75wY
         YmSw==
X-Forwarded-Encrypted: i=1; AJvYcCWGYD6otp89zrEuDC8tbASS8B9Tri7XxJQ0FupMVFqn6FAX4xB2Sh3asg93G2TiYNA80dfon1g6Z2xyBJw1AmFUXFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtSt7My4/e3LPOAfeS6bIdkSk/FSC7rg3fRXHdYqLkuIb23N+
	il+/hcQfadpNRlyqWWICAy3ZgVS1rvpwDiy1ZYWKqG38pPYvQld0PULos4wGPRqBLJUpBF09HLj
	hk2SIRaw5MXyLm5uNh1F/WQMFrg==
X-Received: from ploh10.prod.google.com ([2002:a17:902:f70a:b0:2ae:cc99:f449])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fd44:b0:2b0:c106:a402 with SMTP id d9443c01a7336-2b0cdc041cfmr1807345ad.3.1774563937933;
 Thu, 26 Mar 2026 15:25:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:45 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2497;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=rWCcSWsmhbugoQ/CrLBaDfQJULRa6k6zO+0SZDZQZEw=; b=pUQCq5SrWuGgz06BeAocUDvHqxQeLoxpdNN2qf+xv5H6xfMk48K1Oz6M3gJfWh5qm4+iuM/cB
 3ipj4RgmEYVCD2ax7x9bK4do0PRj5QXuzR0HkNjDUyGsG3ewhZB4IbG
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-36-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 36/44] KVM: selftests: Reset shared memory after hole-punching
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
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/x86/private_mem_conversions_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 41f6b38f04071..47f1eb9212591 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -202,15 +202,18 @@ static void guest_test_explicit_conversion(uint64_t base_gpa, bool do_fallocate)
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
2.53.0.1018.g2bb0e51243-goog

