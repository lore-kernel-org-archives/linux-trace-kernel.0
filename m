Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7A3B9DA4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327953; cv=none; b=ZozHDdN5MTwwFs2jEdJeBGQ1Vh9LprD4R0qNG7FOeewteSDXLoY5cemKiVz9mJTwe6wyo5oVtTJQNhkdVmQM8cNBLBCjWh4yPxQ8LLBEMazNsSyxfskxZ1tj2UcTAuih6wRlui8KKqReDTFMSvQmFOXNOd6sINAG4VADK0nbXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327953; c=relaxed/simple;
	bh=twypMF12zumjvWpfk2PM0t4awiNPL2Qg3O2dBjGLN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I97gmengPV81et2HyAOkNkYhOLyDdyob41NaktO2e3EEVpuF07klMOuao9ZQfjvFQ+d78erfwQkn1Wy/1j1seqkPeq2DBWiwr2mHuiMJo3atywbwV5fTqOn4a69nQUXqZyxb71/K87nveYbvJg3zbA8GmUHIlwLmLneUCw0Mudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=FYjbNcE6; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="FYjbNcE6"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7653db148so821497a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327951; x=1773932751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYEV1IZi65arMtRDq7eHdk/s/1eZwkkGUhZ8AENKDgw=;
        b=FYjbNcE6lHoF2ShGKF3Mu0MdtseqqFI4CxOA9p+8N4URxaEVhMozjD1VX7JfrHINcz
         Wb5VQGKU817CykMbVvNl+ti6FmtQ0bQjD6jYFL8EliMhIHZRV2SboxRABWpf75xMz6hd
         mQeu8zVLbY5qgK01tl+pbHAn7TXx58cs1/Azz3rZBWsWsK0vOEj4rst5555mIafYL0Zs
         J2iGHiEw8rZNfWq5nXzCy+UXFzetabg8qY8ZKwd4CC5EF0DAO5oVQkLGgZdxUrIya+cO
         K7ax1f07pEPv5P0sIT/pcDSeECW/PGkxR/NGgKGXWHNLNhhxk1LE9KLNBEl+y6gvWkj7
         8fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327951; x=1773932751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYEV1IZi65arMtRDq7eHdk/s/1eZwkkGUhZ8AENKDgw=;
        b=QBRlk2UWfbuSfv0HPYElm9Fhz4uTWGpk+aQq/janQcp8wWHsUtfqXXgNQh+dVUmVuj
         KnaysmjP8V1+hyOvgrT1UQhp6BWQQqVk5fyXpQ1L+JSj49Wd/joS2Aa80SDCcT5u8Hbh
         M6nZb11sMMnaMNe1mjNCojlFpGfHDnJ/w5n2Yo7tWw3Paf12eFu/hgcqx2VX8slAORer
         qjjxVrYIF7cAxCrgRC3dVrLCEPoQBHLKr314xENvqJBUKVi47B21ORtWYBOkTkYT3Qvm
         H4F8ZHDzJKB4fPyST4sJo7cB519pNZxa5uxTK4EXvA6w1meKjUmWmGsbDZPEWoyAW50u
         uZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvZnbLkLwdqKaY2r4pNqWD3Vnf6jvR8c8X+GkteK20zgd+tNFaYjwT7joaKgW/FJBLiSMxcgRL40+ym4liBfjSbRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0I7lD6a8sRSqMGdPAhNwxHVsZo1721YdQLypLFU/yUUnwuH/
	ace1kyP8vM4k+APNvaAHmg7qCgMkYB0dK434HaH+Igo2im4q2h03UCA7OlHaUasJ56k=
X-Gm-Gg: ATEYQzzC4BxR+pCnSqalA+tKfa8rziqLEQxl2RZ6cuIc/8Ctn32rZekTfUFezCTCYS0
	5RfJdBKagQgTqQuxmrMLEixhl7eH9bcLV0yaC6djsMZlHrtSbcwmYHqTKo9fnAaZRnY1L1yleMT
	NGoNPrrHsXpFF2ucypDHlaA8XHyoWcENcUOPz/I9VXgzk5l0bZ5rYxgEnvzN+cxiSWxMeHAdG7B
	WIFyV1r8MhIgDwme1Soh0lIs6vZafR7NXghyJjhANJdBVIlP++zbKIEewEsdpgh9jZMjaba9gTf
	THUtD/58vP/9zmVdbMoj9j6b+vMEUNyyE6hN1lshigKVcWLucuotyjx2NJ+JadNr8efLgGQJU1A
	bYPefgVvTpDhk+mjiIgfcod8VR+MKLOGu/1DVVLYuYoUErqGv8ik71BC184X3uO/trZaYrBqjM7
	Y1FqmUQ5Wv0nhmSHsr484+1CmkUdZEJefrzcu9dd/E/Q5OGtsQbT1Dtv5or0baVVfWTBcDuufad
	fKB
X-Received: by 2002:a05:6830:3888:b0:7ce:2b34:deca with SMTP id 46e09a7af769-7d76a811b11mr4066142a34.28.1773327950878;
        Thu, 12 Mar 2026 08:05:50 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:50 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 05/15] accel/habanalabs: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:00 -0400
Message-ID: <20260312150523.2054552-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/accel/habanalabs/common/device.c  | 12 ++++++------
 drivers/accel/habanalabs/common/mmu/mmu.c |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31d..d38cdb5c6c32a 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -132,8 +132,8 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
-						size, caller);
+		trace_invoke_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr,
+						  *dma_handle, size, caller);
 
 	return ptr;
 }
@@ -206,7 +206,7 @@ int hl_dma_map_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 		return 0;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		trace_habanalabs_dma_map_page(&(hdev)->pdev->dev,
+		trace_invoke_habanalabs_dma_map_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -249,7 +249,7 @@ void hl_dma_unmap_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 
 	if (trace_habanalabs_dma_unmap_page_enabled()) {
 		for_each_sgtable_dma_sg(sgt, sg, i)
-			trace_habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
+			trace_invoke_habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -2656,7 +2656,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
+		trace_invoke_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2674,7 +2674,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
+		trace_invoke_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a95..4541146727028 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -263,7 +263,8 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_invoke_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr,
+						  0, page_size, flush_pte);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 81cbd8697d4cd..a867ad694e38c 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,7 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
+			trace_invoke_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +186,7 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
+			trace_invoke_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
 		return 0;
 	}
 
-- 
2.53.0

