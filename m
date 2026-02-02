Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A686395D9D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071472; cv=none; b=BYfU3t82Tw6ADsH+X+wgCr0mOBPH72n7QZUwBjIUP2jWGxl+0v+dShFZdW2QnwLgDMgTa0udloW6YQeruKm7fU6+R0me8szYWo43OmCjblFNAbJ+3EoHOk1fUeRulS3xpoZl0FSDdyo3qaO9qx8t6FQR83JfVl7BxvSJHy1AGdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071472; c=relaxed/simple;
	bh=cfeYn+ph1QmXzph0DE0e3d0vb1A7aFUT1EKwnV83LHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DtW003nLgfUlB8VZSuKx0zFTfgaKulCwxBtSw2xq3T5UwOG0Fmf9SNeBFBwY026Rk5UAPLEFLgQ1METTApZyWx7nUR/3JGUbROHfk8OA/rfA6OFz0mjg9UP0UhDhnES0Qs1uabgyfuIqrTZRBKPoZImrWdB++LDA7yBEaD3tp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJCZA0VJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJCZA0VJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c68b97b7316so1281000a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071470; x=1770676270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xBqk07gLXMPTCUPkyTUv7blX3LuJtOypATdaCXTgsr4=;
        b=HJCZA0VJnGe6YVW3Hz3QVHvuZmm+81YLw3i+0ah61ADf/X02m4GOSpjyd62sapjoMT
         uKIpA6GsREnGruVMwwQRK09ZH+4N8sBglO0ao9s/P3GZ+kS5LORtqbLzGN5hVVHwUVXY
         7Saafq9YTND2Ajw0ksx8OTK4U1ZQ49iKYGg2YZ2yOtpPniQT4sB1CVk6huBxAlMuANM7
         9+cMgWRYM7DoIoS87JhKvKCRpT6Nj+VYq5dbeQbX4V8pGYz0rTbuYjIa7EsVjKVC7ugI
         ikg1XS/L8jTGXcTTGp5cwCPRgrc790MHRdX98lyb9htwIwUvpJPOVixRiWBQI7IxOjyw
         K0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071470; x=1770676270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBqk07gLXMPTCUPkyTUv7blX3LuJtOypATdaCXTgsr4=;
        b=iFJ8d+9Wvq3AQlkDH9rkT1Xw/fd6JzhSi9pIQPyynWscaikMo6bPDH6kRSOewM40iY
         LM81F+ZfWhqu5Zvb46zjxGQpe0Obz/xuDd4QUqQAJgeHvOUjHae8OKZrTnQgnyT2hIg0
         1yUZ/quOK6hFXTu9r4ZmapV71WwL1P2S10GOZOchWuyZHBR/LAuu+v6DZKui9g6IWoGq
         8SUdes0XTp1+xuhIeCfkLR8N8Qe5Y2DxuGVE+ijB6j5uOtwaVMEVOxLUgYr04AOkwEgX
         uODWV3V5G/B91GY0uiqHGpMbooC184dE/w4SdeJ9ro5aSdOPD2Me6H/9r+gu+EMAdqKv
         GuTw==
X-Forwarded-Encrypted: i=1; AJvYcCVmZp7ztzC1UZlegRvxTDuy0N0opCwaywOoyAOaOJJxFgbiqZ/zra9d876wkGxDXUroqaG8pJKbzIyJzCgfSSfLpnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeZwZRB9jr7ellNwHacpSGG2QadKsIbTJuDK6usIdHbKC7FN5D
	7yreDp4YFCRS8fTeQWZnfB1uYsPFr04yJQpabagRbHNjw/dQOc5X0hfD4bRCy+XXOTPfYIlEiuE
	gdgWkuoor6pK96u/YwUSZ/JLdeg==
X-Received: from pldy4.prod.google.com ([2002:a17:902:cac4:b0:2a0:c92e:a37a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f690:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a8d81818c8mr111686285ad.50.1770071469623;
 Mon, 02 Feb 2026 14:31:09 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:07 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <63782240092be326aec3ad8428f2d3d2cf969fdd.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 29/37] KVM: selftests: Reset shared memory after hole-punching
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
 .../selftests/kvm/x86/private_mem_conversions_test.c     | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 41f6b38f0407..47f1eb921259 100644
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
2.53.0.rc1.225.gd81095ad13-goog

