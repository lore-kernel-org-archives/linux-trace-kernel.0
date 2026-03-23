Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22853B8958
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281676; cv=none; b=Fvnp8ues85reUCUzO8ftJWMZxfzpjI5fBwA9nOEwUfJ/st+86R3EUqKAZqyCZqTk9khvRh/lLVYq0dThzkovJKiFJLS3Fvk6iZu6xLPs0WaJpu9kyuj5d1sCX5Eo3g40JqnMjsunPFhzl1F4Shhf3jHhFHcM9id+61lYi/3RwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281676; c=relaxed/simple;
	bh=vDOl4iabfdtMZLOMkSkTWP+zmegQufgvmmN5uFolZIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEiItgIo7/gBrOhGwa97f+zwKtp43VPJ5YmXabCcXmNBYMajOMcm0UVX3VFBKejhsp19vtUbG+fvPVH3GLbXyESahNGFNguy5FvrNhRk+LuHwWW/I6OKvILF/p6PQsv3NA5A6qisMyBr1LFYGpPgFkXPnh4Mwy7YE4dCLVN7fOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MEEnZFHV; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MEEnZFHV"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67bbea1e090so2455002eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281674; x=1774886474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/13OoieOh2R3fJi1V1DS4OOCrO67vE76aOedsLQcjW8=;
        b=MEEnZFHVo6/NFhIPCNbOD3OI2UczkRU55k/Z2YPylmqYZOxMzW6JpTp81sN/7UoIjn
         LOFxIdtlPW31w0lbWggo1CSbOj6kxfUsHOIwtKWPYOTzKn9lTYzwoJyM/2RYeLvhqfz8
         ZFhNU4S1Vjaylc0GfWt8a2O/TcoMjmvPgV60ooYB9Aw+KBO5UBhs54+EEL/nJAsULXDh
         myj4sDlLcJdPEYwpCTtM4iO2SIxAQzBJ0KIV8hr00r99pj7h5ckoTHtWSkMVOQQiv3+i
         wOImBJgxTUbA29weiUG7UOqn+XFx7v//wb8s3KYV7au1rBhYaS6WhToYikCeFhlmVcGy
         2Z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281674; x=1774886474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/13OoieOh2R3fJi1V1DS4OOCrO67vE76aOedsLQcjW8=;
        b=r47ugGT2N4zRdPbWmP7NOtL/oEEpsu3WFCMvf4P5Xbgh/WVmKNmD+FeK24GogwjUz/
         JTlInqSweUqbjfnBnxIhT7FV7+m0T6zZ1iOGLHPMcIcH1a8icsC4cCtjS58buvVhX8kS
         Wwy8cl31LkTYlAEpNPo6trM26DlSdJgGI8EfQLSLk+DSIoL+lVZynI0k6pFuVmZ08Gx3
         gjJ5CGyKLzXx+2M/1/1vozPeleb3EbgS/8v9NKs3liHL0AYTSHhYcSWcsVx1/QYwibNv
         MUL0g01YzJ5OJwMVMvqLMTIVEiBAZc6YcYX7tnh4Y0ef5acVYYtNPe916WQ8uAr3NHrY
         kRRA==
X-Forwarded-Encrypted: i=1; AJvYcCV632BBlqnYtOwHBWEBrZfyxAlL/I3J2eDUQGo2iSexF1iaenmKYfQdawDTvTkXeygdRY9VJxDMs8U6d0U46qWjouo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JU1WFtiNw6ihfCmH+Boli7qLv64vH71aw8R9/KCf7NDlLPjV
	kBBvA42z095NX/y1t2nadHU7F9i+TGFdR+dSnB+CkoRaCZ6XzsZT6+rOWIaeVN/PJNOS3BMPHhT
	FRDBXDMg=
X-Gm-Gg: ATEYQzxmU9g7oT1ddMI3gjGErc4A8yjYRWLVDcyGmrXfCfE0s8Kn1Uf71k8rd8F+qGJ
	pKOssIQ+kdxj0tXwZEvwp/GxmpyQj144jTwlAqv7EPEt/rGBzzhHQXxlNz9Vjm7i0nVn0QVRbm2
	Ia671lZjD1zsjYvUWr0XnpRuOTzO98OmkYCd7DbUQ5hW/PpwaY5Nkt9NNC4LUKUix5MhK3zoRqw
	SwFA4ChRTqy4aoUYzzzdAICvqPpTn4+74sNkFnbY7ABUGMlpxg3Tvs+A2jRYwcZvZOdpT5U8a4c
	sarUWp2XHBOHURIc8OEOjuq8PaFHOnwOPz/8MeOF2lrv/zrPDLVb0Z7sP8Q1bdzq9trmxmRv6E3
	p8q8bbY5rocUPThOGUTU4DCOQ3SruFll32uB9Qx834WVEW26PflNsrAL8tV2rF48tCWZ8jpLXEP
	HXOR9SaHFtvMBV3jpZ9YbflA4WF+baPnKu9ecKp1Ml78M0+YejuxnKm1D0hw70DDMtHA==
X-Received: by 2002:a05:6820:180e:b0:67b:bcd6:94c5 with SMTP id 006d021491bc7-67c22fbd289mr8856150eaf.35.1774281673547;
        Mon, 23 Mar 2026 09:01:13 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:12 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 05/19] accel/habanalabs: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:24 -0400
Message-ID: <20260323160052.17528-6-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
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
index 09b27bac3a31d..a9ad1edd0bf41 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -132,8 +132,8 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
-						size, caller);
+		trace_call__habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr,
+						  *dma_handle, size, caller);
 
 	return ptr;
 }
@@ -206,7 +206,7 @@ int hl_dma_map_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 		return 0;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		trace_habanalabs_dma_map_page(&(hdev)->pdev->dev,
+		trace_call__habanalabs_dma_map_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -249,7 +249,7 @@ void hl_dma_unmap_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 
 	if (trace_habanalabs_dma_unmap_page_enabled()) {
 		for_each_sgtable_dma_sg(sgt, sg, i)
-			trace_habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
+			trace_call__habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
 					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
@@ -2656,7 +2656,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2674,7 +2674,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
+		trace_call__habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index 6c7c4ff8a8a95..fdeca1fe5fc78 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -263,7 +263,8 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_call__habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr,
+						  0, page_size, flush_pte);
 
 	return rc;
 }
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 81cbd8697d4cd..bffbde3c399be 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,7 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +186,7 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
+			trace_call__habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
 		return 0;
 	}
 
-- 
2.53.0

