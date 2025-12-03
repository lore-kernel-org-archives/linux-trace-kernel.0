Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63433A6FA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783751; cv=none; b=MXJW62BnR94sI50iQNrC/uwsMK7PaJ6Qb/5q1wJsA0Kq+K1i6MH4CNKnilBF2BZEL9NnTGon0X2Y2PiuzlGV+dTZ/f5+BdBcq4+kydnJQcFzuaI/EJcf+cAVsMj0vSoy/OReEDrFyb1uW2t6Bdns/nIby0i/9sjp+MbCfqUX+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783751; c=relaxed/simple;
	bh=zf27bKXVRn0YFfmYbxhnrXsspQ2CJPFQ3uw7zvsKqUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4iEU/9OjV94XQXYpki/o+lTYb6wMdxlZrN8ztxaSUaIWgDpHPtc9W46h2uyQPDb87b0D2EyZYaQzNWudNrEtQmW1KB4TfF3yua8GOgeAM86zXdobKs7ZIzFPj7vnrI/pMEJ/gpaBpSYCKZKeKWg3AugW59vTFwxvGSAx1hTm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ0vTWhq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ0vTWhq"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29555b384acso352845ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764783749; x=1765388549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XeAhmehvdhvlBdc02jry8jySSCOQI2N6rqZ8L6A7FUg=;
        b=KZ0vTWhqS2yY8jLI8dBTjhrp3RGPf4SSsQwgvCNo6xFXnNGbA910ksAc7R94+bhfZj
         eYnblUY1+7sC4yHNcs01XWov/R05lnUQgtG8F7xsS8TwXwVYhZN778l5Fd/tMLijfRBl
         wmniBggyTV2g2d3ouiYhQW9c5hMdyTUxG0P40Mv/+QwBrNlehgbm5X3gMaxuDatn9Dmn
         +V/gCZFpDfUReTaCZE8I8GYCb1ZpmPMQSQVVsCicWUOulyqdqaYQwthwDtL1hTaCnCUo
         PIfTaXV7QiUJTHd17HKvRLBkdEipahugFAfSVuwjEABwVU3/zHffht64sbO2cyioFSU7
         z4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764783749; x=1765388549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeAhmehvdhvlBdc02jry8jySSCOQI2N6rqZ8L6A7FUg=;
        b=JJG1qs2CYckTCUdhKbTkVNdG6JmNMMVRkvPBuXHTgNGRaRsvmZua6TrHxF2DKRjdr0
         U7xg2F7pX2tumeIS0FQOicP33VSX4zt9utWtmvXuhQgoeNOnUWESFTVXUmV5MHbo8B+H
         MbzIs/KJ/XFfYPHDYRoT5ui58/CCozr6m4nDvrjLewylSQVG/RIdeB4ivyphUBYdscKI
         UyxL0SArq+Ns6LgqdySKyYuNoMAYv/r35zKlVTrpy86+b/y6SJZfBnJXWIYZRc6Kv1ha
         LGofJP8yf5rsANoYcosMSe96GR+OY/+vt9AvXBRV/3oFIJqSSznpKUfvK2gnqCz1Aej7
         59TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgqbxteHJFJ+s7bbsf/3CaGXVV36QL/TJzrouDMU525zFgcUFvsskJ/GDthRGaN06ImbLnQ1CjQbvWcQ6RTEBEZPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGaAVZhGImGrvTWGBDlum+JcG7V/6kqLScE/U4lb1HIuA+IBM
	ywTOVCyf5pbuUZTXZDzsjDKgXEPNcd70GOk8l2fh+e9aEhJAxVppiIQ1
X-Gm-Gg: ASbGncttotTHCmw2tzVD7tpxBQpOmkp3eK2EjuL/tdJIlDD9VkrMWXJ93delKMxSB0X
	7Y7m7mOqboyYDeXpWxDIbq6pp99GgaW8KZ6lcLNgFuKD1BIiDE7UdozqFY/kauWmaKk5LNJEgEv
	nJX+DS684TNV/i99oUG2knQZfjQIuFRFKclkgNH0oqR03IxyloTgJUWwdzupghzLi3O0fmSoh5+
	OL2iPbcaKjJBi7pu/Kmr/ylZz2fts+/t7lWCFXRBNIujDCu68d9OP466p435UVl8La2kn/08hsK
	1b7iyeOkbeajBTI4lAMX6H+9lUg9CbiaVFL+V3EedCDit57VjM4Wt6An6tHndBVAA5qfl4Gse5y
	Ox/h7GITcfMgMBGTjRzht0GX3nc3MnD49GDM+yIBxPG0SNF0Umleqh6mQoxN2rhONNiPZlDhFgL
	pbwcc/S5HF8PjJ6rD1dQM=
X-Google-Smtp-Source: AGHT+IFCJ/6FMxi6z/HzwPq4FUAbIfVntMHygrl0Bj9u5XG7QZet9gEnE0ujTtKKnt9ZqcGVnY0AAw==
X-Received: by 2002:a17:902:cccd:b0:295:96bc:868c with SMTP id d9443c01a7336-29d682bf2d6mr41038255ad.5.1764783749129;
        Wed, 03 Dec 2025 09:42:29 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb275a3sm192469735ad.66.2025.12.03.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 09:42:28 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Soham Metha <sohammetha01@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: rv: fix deadlink
Date: Wed,  3 Dec 2025 23:11:54 +0530
Message-Id: <20251203174155.48751-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file 'da_monitor_synthesis.rst' has been renamed to 'monitor_synthesis.rst'.

This change was made in https://lore.kernel.org/all/20250725203425.275466334@kernel.org/
and merged in commit 'f40a7c060207090f41998025fcd1cfad06ea2780'

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---
 Documentation/trace/rv/da_monitor_instrumentation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst b/Documentation/trace/rv/da_monitor_instrumentation.rst
index 6c67c7b57811..b847c58a96b6 100644
--- a/Documentation/trace/rv/da_monitor_instrumentation.rst
+++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
@@ -168,4 +168,4 @@ The probes then need to be detached at the disable phase.
 
 The wip monitor is presented in::
 
-  Documentation/trace/rv/da_monitor_synthesis.rst
+  Documentation/trace/rv/monitor_synthesis.rst
-- 
2.34.1

