Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A5514A62B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836423; cv=none; b=VNWQeszTJ8QY93NH47ezxC10QHtAF+CcsYeDnv89FgO5BSWssTFG2CuvMQ8Wb+KKyhOfn8dlNvhkCm4DGZAYePS2oPtz/Y/RDU2blSJrfSaq6cH8v8PAyWbU+TIptHauqtqko4YKEW9PzSnfL4sBrMGisFVNQCRijK9exzMjrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836423; c=relaxed/simple;
	bh=8XZb8+FCV0CLht6+XWW+dP+aITDhaFT0okOzd6JUXkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctY6e8SLRk7+UogFE+g8pO1SVcELk1Pp1qspzITH+6C3iU8Vy51M3ZbNjO4BSBHRiOt6QA8a8ikQp2O91HlR5Kj+JQ2IX1eDrsoBEg+MdbzVBHG2o2FAH3a6QrWXa77JV07YdGnQeS7YVS2akJYqeApN/rNbL2Ypfv0VE0iakzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m49QRmgn; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m49QRmgn"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c868b197eso2522234a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 17:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836421; x=1768441221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8b9aAof999ugndOjzkeZa155skCNKc6c2TFi3UeFMM8=;
        b=m49QRmgno3zSKf/vOzQLumFIdlR38AayVjGrFhFC6CqWMLihBP7TR0F6p3xozjTnVI
         ITL+BZjHo6zGn5MxyCKFIJlqWBW5mEa1SZZvdKiwnGUwL852jRmPAn3L3eqWJ9d8Ws8z
         60uOMQutB9QkgRNVPyqhiMEqG9RBJCa0+jFlD8lq0uxbbCVyARxMowuQIMX/hX9r/EKO
         nFD6ml2PAT307+SuKKq/FkDHaBUSW+DDF4vjjFOR593SXEum41Pf+/TpTxUuMMwWBCzU
         TXclCfNPdWnlbRtWg3gTmI5q1xdZZimAKdcG1eWCidPXqTBObHUKBHgnuXDixOot1XDE
         NXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836421; x=1768441221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8b9aAof999ugndOjzkeZa155skCNKc6c2TFi3UeFMM8=;
        b=QWyFripsz3rXX54SkfWxP38yL1GMHeLs0torCcpcArSXDOWHwVguob3LOCUADMQgeJ
         mqxxMcSAUgSWc8mFrYuFGyIy0W8MyVKl2N3At5FEAbvXCwNYtbmYkACdRd6V6Rmt6skW
         BcBeIo7KBMNowo2xlmGmKDf7mAq2eoW+Evj8vNcEiuYBK4F+ckMREMMccZvgxteF1Ms1
         ImfGTDQm8l1JWoQSZ8ziDI7x5k6MaLQnZXpWi2Be2BVRHAQd+KMLvpzzkdhk+jDJR86R
         CQ8Z48uUkRCliLI+XtHhdpJASi0d9DDDFU/PweNCCofzu1czHibk9Q47iZIDpm49QfAI
         yLQA==
X-Forwarded-Encrypted: i=1; AJvYcCWH/xyobt59MSzeCgDT1vZCJe14emKS/3M67pKJTRwYJMMTl+KwYX9tll6pIbS8/FFGYZXWmK5QFf82PKiPRlc7ZCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOO33zzaETcoPM2MiKG9ZvKT4N2peH6pazi7upyNfa9GRf15oF
	nuYREY2HYKOcYuIfxqh3jFlTl4oCj3UAtT0rUFw17hrDWMjSBNrQpzJlNL9jHXwe/zE=
X-Gm-Gg: AY/fxX6Wa7fkrzcCsaIJIinNsJnJ7gG8eLsGULU2jK/3Dw9RJXk9s46v6+H/9zWYuJY
	j9cVpuF1azUggYBYjv9CThl4VQrFwZ2MzJ36nSXkiNGG8xC8gywiJsTUIkiaAccT+OmritR8XA4
	eVtt8hbZxTXl/ZbGFRLz0Z7vQvbrJbjKaeMJluQ0JSuVfdifgieskQOGhXCUBrnQBINK4Q0hZsv
	r+UG+/ZmIfULQHELT0Fto49ZCiZZ3CR9lPZq8bP8ql8Cq72a2Xkuy4DqIBVkBUPMjUy5uYWm/3t
	KjsechZ2464VUC5lc+Y5pxJdtpiKYYOy0AA4dXrrDPV4JGG2s/8jJLuCafgNFYlwfFpPVnXF1t1
	5EEq9Mc950Ctf4al0rLCjq3wzWruUE0h5AAbUOpO5WclTUomlPfHIvFUv4sfSwR8MX7NhGwd/lS
	86lEeyKGYf17w=
X-Google-Smtp-Source: AGHT+IHYmhgeDUl9GrF+3dcPYhxi46eYlH7ZXTMLgsZsmxbCTqH6jCsme74eIUdlyp+06gCdljSWoQ==
X-Received: by 2002:a17:90b:3905:b0:340:776d:f4ca with SMTP id 98e67ed59e1d1-34f68c621c8mr4482242a91.26.1767836421034;
        Wed, 07 Jan 2026 17:40:21 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6af4e14asm1398806a91.1.2026.01.07.17.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:40:13 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id BAC8642DC3C2; Thu, 08 Jan 2026 08:40:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] Documentation: tracing: Add toctree entry for PCI tracepoint
Date: Thu,  8 Jan 2026 08:39:55 +0700
Message-ID: <20260108013956.14351-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108013956.14351-1-bagasdotme@gmail.com>
References: <20260108013956.14351-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=8XZb8+FCV0CLht6+XWW+dP+aITDhaFT0okOzd6JUXkY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnxnHvNgozu7irRi9x3l9NaXJTZluP3AfOHEZq3OYPEw w8Wf1DuKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwESqvzAyPHaN0J53pqm9WilD 0GeVuW+3UsyGb7KBBkEGxdGRZa+WM/xT01gfWrO1NKH1emmBy5L8flbxL+fFF9yr/9m40aK2qoU RAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports missing toctree entry htmldocs warning:

Documentation/trace/events-pci.rst: WARNING: document isn't included in any toctree [toc.not_included]

Fix it by adding the entry for PCI tracepoint documentation.

Fixes: d0eb853678a21b ("Documentation: tracing: Add PCI tracepoint documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index b4a429dc4f7ad6..0a40bfabcf19bf 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -54,6 +54,7 @@ applications.
    events-power
    events-nmi
    events-msr
+   events-pci
    boottime-trace
    histogram
    histogram-design
-- 
An old man doll... just what I always wanted! - Clara

