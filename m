Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFB481A97
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782494; cv=none; b=DabdUuHVJI9XwE7XlHIRW2MsU/0eLRRkUefCf0nYBJXSwlTa89rgNwwpewcATaw2OSctprMEPVNM79e0K594u9y/zVacGH61gfbeSQjPTTO76sz3EfI8PhFvIDhQBmDcGJAdGCnr1ipPf/Tikeb4F8B3kEgk6yCcBfobpOg3BNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782494; c=relaxed/simple;
	bh=CrlhUJHxSyS7QTCXqZCtb5+kT27E/1q8+f1+oITtvvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2pFCR8M0hSZpbTUlzSrSA5x6eazuqoGZb6tncWwb1OZUGkQLVpkk1mM93WEBfv9Tygqd2D9hwfEkfQfELL1lETQJyUeUuzOfiBa/JsfTaxdZ303pFGGayaWddDXwuvSpYYxPOlTsJL1yZi74nm+z16zFbIloJGCFeiC/zT0Ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrFcZrD8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrFcZrD8"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487214ad2bso3652442b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782492; x=1789387292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fGYY8R1XstP8r1J3lVI69+hhzGANnc2NV65GGslrhcI=;
        b=RrFcZrD8xsDPiRD6TavQjh34WzIa/Z4o3TI0KLV7iaPIIf98yFxHA2WOKCypkQ9Ivq
         E5P2cd2TgqpfOFPvalE0a/OGTZLIiG2QPh5ESCTs1+oZYwDIavZ2zau0m+vRlVL5uZqT
         UKjcomTy1b2FkPLqg49cyJo9QeDZBeMFsMdgP9q7LsB9NDrCIo3EbsMaqZkrW+8ZyqdC
         QnxJJDuCK1hbUhUqsVh/OyJC+evGDSw+BSWYddyIOzvhKBSvMCLYZpDm4d0ejbSAxy5/
         y2YR5KlQC0UOC30kugsrgUOEwUfkjx9jw6f+JoeZb9baQpYjfBqj2OYmAbQZSLEli6dB
         O3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782492; x=1789387292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fGYY8R1XstP8r1J3lVI69+hhzGANnc2NV65GGslrhcI=;
        b=FflGNCRnvwTqS6WznAtLJt5IZh4PlMJhXi8HP094oPw1cwhj19MjGlDhKclWp5YFLg
         yOlGW66xGKP5RwKPPssG0vm19hDJcQwdMxGBfB+wl+nPf7kTXNqHKpIiS0tA9rp5Ku//
         t07fqOo8m062sRUZJv8fBftpUUfB3MEwt8Np9w7eZnR43NEWv1Ku9kLcItBWMe3Npdem
         jpxjP+m+VRNNYkDjtOZMz2xVWHXbcQRkytackhi8Crtk7uSDZoibitRjX+rgXNu1j2NZ
         BmxBHnnI6QR4WggmO1mtFxD8M0Tv7HVf386gs4mWcNORHgF77v2wDpKcfZJUFohPns0B
         T9qQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoQ+hSUpeYFF6SQIf2Wdws4ri95mSt/HIE0rvKYXm947jPIV2PykXHbZraeWAZFuIDbZt76WU+PZzC1OEunyDZ0ws=@vger.kernel.org
X-Gm-Message-State: AFuF++lvFSQVNXYBzEXEpzC19TtJUUGfcSp7/ZgnU51oftCEEJAq0hky
	he66wC6aMbZNKOrWDVDyCoo1nHHp26GQLq8pkrkNgYwYBx8jWM3KogI=
X-Gm-Gg: AYBFou1cJlhj3b/vP+QZEq5WcMvSUWKQURWhBmyG5rqcId5UIbfeog/g74qilCKHWC4
	Qb8u+f5VLs8eq11Q31C6r9OhuqBSjvjvLfRmPsAgyQQEDjuIsjE3AsB7aOLJKmNVopgdPuntDfQ
	b0z3ixWiBDe1W4t6vb2VUZZDmdNIhGD+JMGNkWbtz1rR9APGhLYXENdjc8HQ7LKt5frSIQuVnBb
	uBlIc9PNIzvFrpgZLdBBOULuyZr/s5ygSfK3DGOBTAE3mNVkmptODmNpI0Wqe9N9aYaEbR0kX0b
	1jOPsdXhbZeurFTCde5wS13d1hfns/QPekw4IvDzpLlKuMVg9scCQTw8cMDGqHzcRzW96ISX12r
	5lfc82JVEV26cI036lUQMTrRVf4+5p6p8clGNtrRPn9nbncp0bm11JEmNpQhXIIJcHlXsk20UNl
	7CrHas6AvXHM0RZnaWJaB1NdV4EGcXhRM+snpEnqtgMu+BQVVibAojg8uQVwqs/CmiOI50+gwmn
	RBibDxMp/azsTpN
X-Received: by 2002:a05:6a00:ac8b:b0:85f:2f32:7a53 with SMTP id d2e1a72fcca58-8616c546f9dmr33820834b3a.17.1788782491666;
        Mon, 07 Sep 2026 05:01:31 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153f417f2sm4148847b3a.58.2026.09.07.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:31 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	iommu@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v2] dma-mapping: don't trace the DMA address when the allocation fails
Date: Mon,  7 Sep 2026 21:01:24 +0900
Message-ID: <20260907120124.603373-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() without
checking whether the allocation succeeded. No backend writes it on
failure: dma_direct_alloc(), iommu_dma_alloc() and the dma_map_ops
instances assign it only on the path that returns a buffer. Callers
usually pass an uninitialized automatic variable, so a failed allocation
records whatever the stack held, next to the virt_addr=(null) that marks
the record as an error:

 dma_alloc: dmatrace dir=BIDIRECTIONAL dma_addr=deadbeefdeadbeef
 size=1099511627776 virt_addr=0000000000000000

The device coherent pool path reaches the same call: a non-zero return
from dma_alloc_from_dev_coherent() means the request was handled, not
that it succeeded, so cpu_addr is NULL and dma_handle is untouched once
the pool runs out.

For an allocation event a NULL virt_addr already means the request
failed, so the address field carries nothing. Report 0 for it in the
event class rather than at each call site, which covers dma_alloc_pages()
and dma_alloc_sgt_err() as well.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
v2:
- report 0 in the event class instead of splitting the two call sites,
  as suggested by Marek. kernel/dma/mapping.c is untouched now, so
  debug_dma_alloc_coherent() keeps being called for a failed allocation
  and decides for itself what to do with it.
- tested on x86_64 rather than compile-tested only.
v1: https://lore.kernel.org/linux-iommu/20260905071919.30784-1-donggeunyoo.kernel@gmail.com/

Tested with a module that puts a known value in the caller's handle and
then asks for 1 TiB from a 32-bit capable device, with the dma_alloc
event enabled. Before, the record carries the caller's stale value; after,
it carries 0:

 -dma_addr=deadbeefdeadbeef size=1099511627776 virt_addr=0000000000000000
 +dma_addr=0 size=1099511627776 virt_addr=0000000000000000

A PAGE_SIZE request from the same device, as a control, reports its real
address on both kernels, matching the handle the caller got back.

This changes what the record contains, not what the caller does:
*dma_handle is still read to build the tracepoint arguments, since those
are evaluated before the static branch.

 include/trace/events/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 9df02c1511de..b06d8f99922d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 	TP_fast_assign(
 		__assign_str(device);
 		__entry->virt_addr = virt_addr;
-		__entry->dma_addr = dma_addr;
+		__entry->dma_addr = virt_addr ? dma_addr : 0;
 		__entry->size = size;
 		__entry->flags = flags;
 		__entry->dir = dir;

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

