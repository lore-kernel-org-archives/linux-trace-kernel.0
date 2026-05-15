Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BC481FB4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853562; cv=none; b=DRVPPCvPu5b5PB937faSSugzb1FAgMkOk79pQjiKmSkPEEPB+7FjJkWx1jZWzHjnwRA6f3A32aKeXE6W9qraQzDxZcf5otaRXcQkxWymbElQ0X69ZeJLsTlicHDj5IVzFn946KjZ68FgZAkq31kjk9lgHGaSkPmw2X8sxN6X/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853562; c=relaxed/simple;
	bh=xWK/jT4i7tilK1HiNm6jxhQoONQW7EuWv1hcUjc+weM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6EL8VQQZaqg/79KKWmbspVH98TYR/AYLPfELobG3AxgB7ARn4PxLFiU9VhecZYtPNUSbNZ8sVC5EMX9PEaR+YTA4+Cm6FjDSZXiMl6a6SxKmpgn4fqcm3qRq+yQ0MUjZ4XJVi2Nd0YzSUN+Wr6EMAaqAwbduKE2HeGp1pGapck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=rurFb2uj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="rurFb2uj"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-911dfc86903so115024685a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853560; x=1779458360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp4Zt+WRyNVWYkPTWbK1zyHgPgu0+OlgZHWnBbbboaY=;
        b=rurFb2ujeq/y+HDXOo6BrvzpWXfFD95aj3XGxd71tcin9F99wp7PtuCXr/CNMmegtb
         lnQwPj3lpkfQaJAxpRt5OAUEhkhCoP5dHP4dGVwKd7wwnCgZtoCh/WRaDV/E803ENcmJ
         CFACUPxpeKIY5KKViBrQ9pM4Iz/vO4E+j4XnTzbfJrEwgINtNj57CXQJVMwRMgcl4TwR
         R5akcrhgNFGeG94+eutvu0/M/4kS6fCGkzSocu116DCtCb2Ymy37V4hdOb1vh1GlRWad
         pOVSeE069NiXUFFEDqqdaVG2sE/pJx7Xv3WP1s69ZDFNJ0jS3URi4Oelgf2nE4mUBkAQ
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853560; x=1779458360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp4Zt+WRyNVWYkPTWbK1zyHgPgu0+OlgZHWnBbbboaY=;
        b=YV+ILyOd7jYBEtHPxqey2qQC5/mphc7O0BQVxSwsCHG5sy203mdl6OUacIxJcCt3N/
         CHgramxBZkkZm+6jR4DcQN8Hqpzxxlf7df6Ru7ZPlN6A8wM6BRotADpUSRGSyZRy179X
         V1V76EPXrcfjb2IAL8lcu3OFZ85trj9y/AT3S7Cr8n13QQLzPJs1Mz0hfzS3xWgKEGXt
         bvjwniynfncPcd/CBT/sPzB8a5n2oNhrfv/rsWlmnQJxl9oXrD0dDxnrq6FvxQvrjdYf
         lMs4QW1r4suxJ6wL79jnHfZFvG+XOrXTZkEI063qIlTFu2MA9ZPI+a+W6kEmMBy3FJAz
         CDOw==
X-Forwarded-Encrypted: i=1; AFNElJ8a5mjL3VI1m82ub/KnOfRzueX4lXYdHzDFT7QoUeTFChLXBFP1jlG64HIdbTklo839oqshvFLUdmJ+qdEhl4xCWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxea6tDM8OrrlvxAWxny6+27IZRF34gKUfr8ZAJGbDKMDVoahhB
	dNP1XjvpgiXzIkxKUwWlWdpWB1hboLqMK5B8yvPLenLO5GUeQY+aQQeKONzRg0/K9BE=
X-Gm-Gg: Acq92OFJqOAsF30UMmp/abIAlYXJBv8Lz86lbLsktv6trbyebESG4u+UL1jXmb9EbBw
	bP50rBLfW+dUz9BgIqNV7BbKH8lLeHyRga2LUlfJiCfdhxaj1uxXm2CYYeUW+U0fYGvDtAz9qgG
	cBYBYnw5W+I7iqgZrTPwxZS9vF993hIngqRTZoDZbbHK+SNCLbo10dZrrL1+diyQ9OQ1MbQWKED
	LpAiWYt+aE3FHFz9I3oVipkhYrh82DTyHCF07hY9LJcSQB0enYC6KiJe+s2fk6G+ZeAZ6wAS3f2
	mARHBJk7gmnSMWbYi5sbG3IAFOLn68DuzRmXBxWONTPf37/QMpKo5YU2n+qZsPB5hrXcE/SLHOZ
	yB0VQBHaLj47g8GOukzGmbRlyi8TODK35Klpv731uExDdHrKSWBDwqiUGa10iIpY8idetTeCyC6
	eC6ljEGL5b7y1djDwQpJyQ3+Yo5CWY
X-Received: by 2002:a05:620a:4105:b0:90a:708c:e6e1 with SMTP id af79cd13be357-911cfdd1709mr639152785a.44.1778853560255;
        Fri, 15 May 2026 06:59:20 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba9454basm555644885a.12.2026.05.15.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:19 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 03/11] accel/habanalabs: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:14 -0400
Message-ID: <20260515135914.2238789-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/accel/habanalabs/common/device.c  | 9 +++++----
 drivers/accel/habanalabs/common/mmu/mmu.c | 3 ++-
 drivers/accel/habanalabs/common/pci/pci.c | 6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31..68c6f973d53f 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -132,8 +132,9 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
-						size, caller);
+		trace_call__habanalabs_dma_alloc(&(hdev)->pdev->dev,
+						 (u64) (uintptr_t) ptr,
+						 *dma_handle, size, caller);
 
 	return ptr;
 }
@@ -2656,7 +2657,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2674,7 +2675,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a9..dd8b6fb3aa1f 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -263,7 +263,8 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_call__habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0,
+						 page_size, flush_pte);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 81cbd8697d4c..12663e8e12e0 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,8 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_read(&hdev->pdev->dev,
+							 (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +187,8 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_write(&hdev->pdev->dev,
+							  (u32) addr, val);
 		return 0;
 	}
 
-- 
2.54.0

