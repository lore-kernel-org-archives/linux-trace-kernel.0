Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BC2EAB85
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863373; cv=none; b=UnNnmFcC1xN5BbCWVvNWudDIrU2MteYuco2Jfri/WKL38L3a4wp4KIYzGXeC2rz+ngzWWDVbeYcfGxfZUbHiV9OPSVmZTflC4rW6QSeynJCfTxCxrVPUKMVJTjAFJmadZ4Nvt8SerSI8svarZjp3vkMnyeg1IxZzWjeg/A6jaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863373; c=relaxed/simple;
	bh=PjvGj/6WIMKxEW1Znvw9l4eMpfWYkHUzapNNIm/1GK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtCsDzMpn4fbvN5qxLYJyOTZyarnj04N/y+Ano0gc8QV+TdyONCeAuTV0n5xNmgM5ZMfYFvk7mFAxhkro9HORj6WDlRu1jdqSxhKnvh1ZLMZw91BhjGCLp23qwG/ZBAqDnjUJ9WuIlCxBvnUZN39gfhrJaSIiGK21rTkBbo/ejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL7u0k8M; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL7u0k8M"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-279e2554b6fso44084045ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863370; x=1760468170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUZ9lhN//CkO8fifdX7p4qPCDwEbbiKFsiRCmbfFYRY=;
        b=VL7u0k8MY/miTHsAuDoBQIlUZ5G9Ua0t+W1qosCwOkITpvfJaNQev+CqomIImReXC4
         p1S/E92bQC0g0mhOY3a+D/ydFfq8HkrSx5mm2qtQdEh7MWRZNNSS0e39jX9hnNGr5SVp
         zdPTc/kNQ7TGdxLMYEQiKw2Wu3/WVF1PHhjwttsUt93jOeOUgzI0Gi1BtczmAv7Bjf3g
         IK8/V7wm4o4TrgpqxFpQK6dOH3vbDMHOy9yulq0z9gR54OMnQfZ6ThokGyGXgbtvwdH5
         QYts2ltpPg1h3UukK9FfmQYdC6qacHKOAvv1CIUIhQmMpB+AINUqF+fc/Db5T6tp2rYs
         YL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863370; x=1760468170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUZ9lhN//CkO8fifdX7p4qPCDwEbbiKFsiRCmbfFYRY=;
        b=hgsIbXqRSurO41STqCk+ohzzh9hjOD6KWzx0kvg2h3CgQbsmB8/zLCMK6WJfEiOB8H
         4vtmB0ya6IP+f4OqkHdCopHCksndTnjEVWBnaTZCkQReB3wvVdW+is3DH6iTOVYt/L99
         dHAJ3WLvPsNYGZagolV90WY7G3gQvWcW1JVZUZg78enwoMsAhiGnEuOnyrsqrqYu+vIk
         c1FUxjuEH5WNKG9x9/oHe+KWEY/rTVCwNthHqeMwSYD02iSOXfXEijBtCf/C4yYgNc66
         IfZcaiw6d6F7Lym3UXybnk70GL7Ultp8ZCUyk3ZD/NPIb/ry1HIa0V07fqQH/7BPDRgf
         e+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWIpOM0RQrOcYkezT5LJNGW3hNTx2xoImsBN84zT91qbUI2LDMfrCdj1VSMPJscO4OKBneVfA7r9sBPa6DpKKheO2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iFlMxKKTWXH8NqeDew+IXZ4qa2B7wjrdC1SIIWoQPPuymQYh
	iiHUTDRofAUHRLuQw0WxuxG6RxNp/sQMC1QK4hSZIkn1l/agj+tyT20+
X-Gm-Gg: ASbGnctgFLUDU7F1xB4g9GqUFJ3hP94Z3Pp0jEymSx5kEezsGpIM4aRX+edIiM5GabB
	ATXeKaiggH4mBmYZ73DnDNyW3HcLgXlyMa3NpYQTd1mVQlgMxMQKQmwVgfHCCfCfnMXlk/PXOR3
	/eCFgStlXuMykeq2oU5WFuJXOjnBHTt8jXfYWAT3b16+1BtuPvW8uGNe5a1wK2oyMauzL4UiDiR
	jMxs76Sp7X1klQmR4J4m/CddjVcZvA0yiTuLL/5fEkbhtFhvGNaFfmZkjVmUAAwHiQAa/ilzPyL
	DkvtFJBpNEOFOXiOrusl20las7JGmGrc4eGZeVj8WnF+mMkuWqKou2Q0jTLa0utUB9rFW+3o1OJ
	Q85DNzTpNcL1QXBIWnkGpJN5thQ+BJisdMnVx2n7Sr1WCszrxPk1XUGsAFYSPzIW98337JWRozf
	ER
X-Google-Smtp-Source: AGHT+IEnYwwHsTgb8eOLfuclxtTGN0ot15Hmrmno3ONRkkOazFE85QNijokyUfk/dnUFfALD7cwZbw==
X-Received: by 2002:a17:902:f64a:b0:277:9193:f2da with SMTP id d9443c01a7336-29027356c8emr9333545ad.5.1759863370227;
        Tue, 07 Oct 2025 11:56:10 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:09 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 7/8] Documentation/rtla: rename common_top_options.rst
Date: Wed,  8 Oct 2025 00:24:56 +0530
Message-ID: <20251007185508.40908-8-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_top_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_top_options.rst to common_top_options.txt to maintain
consistency with other common_*.txt files and prevent Sphinx from
building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../rtla/{common_top_options.rst => common_top_options.txt}     | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_top_options.rst => common_top_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_top_options.rst b/Documentation/tools/rtla/common_top_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_top_options.rst
rename to Documentation/tools/rtla/common_top_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 102654cc0c78..60a237de1e2d 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -31,7 +31,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index ea0e9f5a5c0a..8a852949df21 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -28,7 +28,7 @@ OPTIONS
 =======
 .. include:: common_osnoise_options.rst
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 32d33c792dcb..7dbe625d0c42 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -28,7 +28,7 @@ OPTIONS
 
 .. include:: common_timerlat_options.txt
 
-.. include:: common_top_options.rst
+.. include:: common_top_options.txt
 
 .. include:: common_options.txt
 
-- 
2.43.0

