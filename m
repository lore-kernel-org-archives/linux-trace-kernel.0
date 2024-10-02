Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C071D12E7;
	Wed,  2 Oct 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899238; cv=none; b=rt6PXCQOHe/KKEAzYCiioC5deVlPaNmnPRANL6CtUNigvoEr/xwVLc8n00OnqXgYDVVK7q4J2bWmrbkAHuLSxDIJ4OrIMzzE4WUZNIgI6eoxs0KgL0MdGUX86ZNDwPQiNlZYM6bJ2kMY2Q7kudjbwvowuqLODdC40ipLxp7/V1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899238; c=relaxed/simple;
	bh=TL8JnfwPUQ8WRZpZr7+PS23HEBZyTwgf2lnXw70bbwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHcXfVf/S5t5DqorxtQA6EHOZgOu53UpRQ0dD3QcFEbT8RPVi9VxOxrpvS0ZKapQEAVkL+pVifSF5C5wyuQsxVdtiFhVdktb2rR3Se8vuaSiKVv6lW8mHcRiintyf2pZ2cs/CAtGfx658IA+0bQw/NDoxb7taPxIA6vcC61LD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBDQS1iO; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBDQS1iO"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a0cbc08b38so888515ab.0;
        Wed, 02 Oct 2024 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727899235; x=1728504035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb7kgvTMdzNhdqdvzPOm1XkyLwX6NXIz7vCaN4jF5ys=;
        b=EBDQS1iOzoRzphXDdcHv+9k6DG+U+K8KVav39WF7Z5L6SC4PshaVJdC3nyQlz/gSQn
         DbdCYGbVzUZTdFrUht4XuSWfjyjaiayM7QAobV4cRAjWCqQD05V8jQZ64ImAzVy2pOoG
         50tOmkFF3l3bnvDmgoJZFVsfy1ZkDjQVTruF94Tup1yT3oM22wy5IleoFbDRRvitPRuk
         OtkNhbCKTfu+5ApMKTXfsHfI+o48MAP7S7g48OgdYy9Te4XLGAPWq40gQjpW/VIb+Vbj
         9h4R+kdjPPAktWLe9k6DZPAw2wklT1dTIMDfJEysF6snTKSPmFM62xp910K9+Wor2bdu
         pbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899235; x=1728504035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb7kgvTMdzNhdqdvzPOm1XkyLwX6NXIz7vCaN4jF5ys=;
        b=Ids7+F41AL94w9EtgYl0K5qx8xeDtXerGtSwCA+HKWhSuG22ZjoI8l8tdo9jDrH66H
         95wVEspgLuTl0dBsIeZ8lOvvrPVMj+7YMfUPCDnetf01NmiPp/n0cT5YneBJAvnkNz2f
         O8gQ8m+xbi69DD1tmjeQsQpgRs3mrbU2k1yQIFL1RK+PJ+WT7Mtz6gYV/4jY3l1k6R6v
         80IwViZWL06RC3XILt6NmSqH2zKdZtu67ADhPlBj3PN1OYXAMoFqpHsJlcd7OXYm/rk/
         a5fUlBDItYCaZZNOy29Lbzd4jUKyrcGwVzekO3kX/qAomlCQtiWXshMQ8vAqJxzwSF2m
         S1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUzOuRZhnAldPe6uJJNp+0S2CxqS12U5TPkl5y8Jz2KCtctleZQqe0HOfBkCUD8mvP3xaqd+dRab9A=@vger.kernel.org, AJvYcCVCh1GiSQwkeko7kugdRNk11GhMF5k4VT8FsSI4Ss+ZH0MHmEx3F/dPXEv1sTA4ppDnEqW3Vsou5229wyyk@vger.kernel.org, AJvYcCVG/kYscQcja1dsQKNXJEpNV6yRyn3YQuQiASwiPhplP1QJF2xwDxt08G6VPA1A2+nbmjughg5RcJ/+AI8Q9O/axdCS@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLRgvySobYryflxIhJNP1ia3d1Ynic3jlAGm52MNOshLPT8EX
	W0ivUzykL7q01jWkCrYtO/qyw0Rf2hVfceLi4pTRwpuC/loHdLQ1
X-Google-Smtp-Source: AGHT+IH7h6hfKo8fFP+fecS81iWds5wLSLDM61c5SUaZN5CwFJyFDdJZOYl3Lo4Pw8ZOYYwK9WC5PA==
X-Received: by 2002:a05:6e02:138b:b0:3a0:8c5f:90c0 with SMTP id e9e14a558f8ab-3a3659290d7mr49807145ab.10.1727899235333;
        Wed, 02 Oct 2024 13:00:35 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23f:2448:63c1:2214:5f25:9d20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db610eabsm10502030a12.88.2024.10.02.13.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 13:00:34 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: [PATCH] docs: fix WARNING document not included in any toctree
Date: Thu,  3 Oct 2024 01:28:17 +0530
Message-Id: <20241002195817.22972-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add debugging.rst to the relevant toctree to fix warning
about missing documentation inclusion in toctree.

Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
---
 Documentation/trace/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 0b300901f..2c991dc96 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -24,6 +24,7 @@ Linux Tracing Technologies
    histogram
    histogram-design
    boottime-trace
+   debugging
    hwlat_detector
    osnoise-tracer
    timerlat-tracer
-- 
2.34.1

