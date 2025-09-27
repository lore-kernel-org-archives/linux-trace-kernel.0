Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8D25E47D
	for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953543; cv=none; b=g1P8PJ4gm9R/oWPUcVG/iLNV96ZS+A/nwWcu0TZt5NWPTHmtrmeygyyY2O0aWUvNFpNKeIrqGuBOLlhfPtExip1J49xgeusH5LD8xa/bm4p9zF/1YlmFNlt66rwmfZ6GE/dPjuTI2AercLNYoNX2bgLzyL63koI8TwFzMsyC1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953543; c=relaxed/simple;
	bh=1mzduihlymOwOuUzpa230b/9HplV9BYgnGrs5Bj/ugc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur/BpoFJM19pA6GtTLt1nqTOFH+gp7hOSTKnOmuZEtKTMmMF+iciTSx+rscwVxQsoBggFHRTdWqCqES4riASfkTNlGUqI0ehQuT3xqsxdaS1HEPsmEQ3+4Fto91XcGsa6TUhZ40Oy+WrH95SWgSeUrY/byWdibVThvt8hbDYJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPCzd3pL; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPCzd3pL"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-78100be28easo2167283b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953542; x=1759558342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=ZPCzd3pLkhaqWECEhiuJ/tHnvpXSN7WfsfCYyrZbRDiOndC8xU06LPbAV83YWmW9Q/
         /66kbK1WhfawpSW4coriAfWq39rj0zgrSRSlxY7YKZk0V/tf5Pp0MBMBZpc1iq6jsMB0
         t8ofOtirSd3RgvvPjoXFmZoY9fJKxEseSzffEdyqOPO1emwl8RKGRveSJpFrU5jVGCCM
         f2vYuzdrM2J95x/2hNSLcJyKSxwGddxnkhDkNgARTkBEp/pkAU2WgbWX3yl+tzIcwb3G
         aCU5qqzKOkN/F00EXfQCCjBoWmoS8WE2swQqXyambMjztI60vc0/XNJlI5woJAOTC9ga
         QtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953542; x=1759558342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8sAn5hC327aMiooFzuB7A3KTTq87gTWKySZ/wTATxc=;
        b=lau5lHCNWXQC/Tw03UfH47++MzpPIkFxB9IiNS23Bta2uodpAlo/sUx69CbcfVJYdb
         B3awnlPdf7pzs39TFHbPLZ2CueEPAAo01IFuC8YS1FZ7sUlXad/b7SivYNCp61Stn/bP
         dESMMV65FmXAMROTjIDWg+e4if9VgIF3OAbhmxMQcgxWqfJIYoA7RlEVg9x5lN8/MkJ5
         aLtuL3vb+6T3TPQe7HMT1gJ82dDloSawZtUC9pW5Yrly6XWMl3Rptijx5T1JnPNMxJ0U
         0MRlMn3XlRzbZ9Zv7gO35pNj4zF1X60yi4eA8hdu48rtqQA9HAnaOX5+YM4eNousHak7
         sEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUkfq1hjroT9Rqj7UREIqFVawEnqBUlo5YoyIKCXiv7wOuQLFjJGi8Cjau/7ZsmsLuuABZ77Bz9wt5YiXS+lt68e7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0M8keyOR6k84yNG9ZfDqeuiWR7zlVtjn3LhdwepXwCqdpzZL
	GzSL8osJbTjzIUZfupPLzVQZ9gIDUnDFPdIFvje4fjHHEKwVSGHOG+ny
X-Gm-Gg: ASbGnctSovrimBF5iBChGvaITEJRGoGa8byWKA+t39R76NV9b4YdRIMl2mpB5gmqMvC
	zI52GguHVzbyLGHekj1+GWo/tBtOHsU89BbJMPKRGDFwthU0DbACTW09Cxh3y2LE8jiAUcVTyde
	OAmxYp0yQZEXeeWYn2E4rwCpnhAYoPPXTNh5z/myzncKhAhXkVcRPUyFKuxQkbhGGPsmaWFJsGl
	EpvKIjZs55LlOpVHhYSXYp4ftgzYUQbo7rZvpl//tQEYHShnwfzfrIKnxF8Pgw8Hhzw1KIFfbp5
	bwrjUzI0224jHYrTJ8C1IEp4miY5E2wMS+5FEFUi/j0QwlD3IpWkwpH7dZ4nos3nF3HJm5jbYlh
	ASf7kV/FcRjN2Tl4xuVr44IJZpSrfzA==
X-Google-Smtp-Source: AGHT+IE6mkLCpiGbrwrJeQJpeI8hUbeD8pN++q6vBROWRxM+SfOiGWJswZDLpzroKY3f/4THyxpj9Q==
X-Received: by 2002:a05:6a21:32a0:b0:24a:c995:e145 with SMTP id adf61e73a8af0-2e7c1bc5581mr11500386637.19.1758953541864;
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 2/3] x86,bpf: use bpf_prog_report_probe_violation for x86
Date: Sat, 27 Sep 2025 14:12:09 +0800
Message-ID: <20250927061210.194502-3-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bpf_prog_report_probe_violation() to report the memory probe fault
in ex_handler_bpf().

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fc13306af15f..03d4d8385f4c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1470,6 +1470,8 @@ bool ex_handler_bpf(const struct exception_table_entry *x, struct pt_regs *regs)
 		off = FIELD_GET(DATA_ARENA_OFFSET_MASK, x->data);
 		addr = *(unsigned long *)((void *)regs + arena_reg) + off;
 		bpf_prog_report_arena_violation(is_write, addr, regs->ip);
+	} else {
+		bpf_prog_report_probe_violation(is_write, regs->ip);
 	}
 
 	/* jump over faulting load and clear dest register */
-- 
2.51.0

