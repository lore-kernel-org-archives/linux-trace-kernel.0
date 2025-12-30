Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286415667D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Dec 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081247; cv=none; b=hXMbVzkMAtMQ3WZevNghRzP4aFcCGsLjiwGcNrQ6LsUFOJd3w+KIg8ByBDfaGvW8LvhBjeR/dUGuMsPz16uElt66sBkewtOzlkbFHqdqzbRYmIsTXbD8HJRB1/Wc5vvfVbcHbzsMuzlPYHLo8yN4Nso4/1jTk6Qu2OUKd8pYpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081247; c=relaxed/simple;
	bh=5eD06zob/D9LHwNQsW0DvZpce2cZGwt69NNDj+Fj/T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlxmbU++kLdkWZPvGFRzQFzFqC5Eo8anGwGEtc0C98eIcjm+lYC9LhrlzjO5WvjjbtWp3DuYPZB25Lw4dkcjPfhUHmuQy8Q6LhGLB9vI3it9MEPfYmA1gCTej7XZI0bnemIdtOKCk5elRZdQz7amEFRCOvWvtjR+ZXxGWPpMSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEKgiEB9; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEKgiEB9"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f2676bb21so130791435ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Dec 2025 23:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767081245; x=1767686045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7os5OC55GGJzDa7FAMW/NGt0JBTgBs/c+BCSnBdv/IM=;
        b=TEKgiEB99iipdNBQ4RkYmK8EIs2HumvoBi5NrjoXZNmsp3POCoTQlQ+ZjPS9qA+6Ra
         3ktTiiT/kbCAJ0XbHJBvqtXi4/FzcamFAiIK3okhlddwuaDlFT8UzwnQczCdcKjX6a9T
         weKjbAFh8hpjCQPnxBO4mbgfak5CVRbz6mVvSbFXv+9MoewO+0dtTQ3KHFJHPw176Jop
         gwNEX7fFHJ3cVxMys1tqHBPyyR4vYgbY2nT6nucLYcpH70MOtm+Zs/ylgtcj5bYAKtqe
         3z5ElQsa8f0xSsUpFQzonMAXvf/FCAesWkjVleYVnSvarpdXjJxGwxXnjSogUSlJTSSx
         S49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767081245; x=1767686045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7os5OC55GGJzDa7FAMW/NGt0JBTgBs/c+BCSnBdv/IM=;
        b=SXrCzAzL/hkE5bYG2FApLgBXsGUqy9fJKrZoub+a+TIP4gC7eZByT6U0M9+otRijGn
         aUhfmGm1hB/vZRr6t+5u2uVJPrYpSSk4sAXDHrWelt/L2Cg7Bvr/KIIDFX/WkzPykw/E
         l908TcU+Pw66E7xt5YKvXLJ4Kplq2VIsMaEQg1XdhygDyf/2Tu3A7CdIFygjcX6ZnuFB
         s6LaUhcz5Si55R/5/5RJI/jVDBbgFUo6QEv4R++h+UB0KEMnXD0nCa4gMulrYmEgeONx
         29UQldzRw3L3wn7dEeeXybtiEXjo9sxUKzlMVRRTp45+ZK9HPxLjs6y/DJbupQXk3rfv
         ld1w==
X-Gm-Message-State: AOJu0YxBeqvHdji5buHb7BViWL6Y0/vLeEsPrfrNcYK4eUXZ0SRhF0Sl
	JWZsCK9Pu/C9o61yenBRbkIUuXN1GYxTUD/uqDRXoVSMBEEiCd8cVA9qI4z2/ea6
X-Gm-Gg: AY/fxX6RHbUNFJUfUDIArfNdX/uZCy818G4RYT0il6IU4KyrZ9TtbPjlb+1fMpBkNIq
	nrYgnXaweO4WLsitSShhHBcNZXccysDuiEy1oRHG66glsXlfzuYXns5s7HxANijisnkttBcEw9x
	U+noLKGzI5+tDQDxnN84HZrwXStUjAjDP/W4gCyb/emJSN+414ti+NhHlNoXCl3deuwBV2r8dux
	yWyWjq03jl1CtHcx+mSIQoc1+g2zkOWWw3WGo3friMnWhD0y8RhK4YYKWCOQabghPQvlTR9lmsW
	izWPKtQgsITA27aMCMRRSxIHksWoIsj7ac+hODv0gesDNnUt9/A1j9QXiERxytj6IOhtTZNV8zF
	ZSKqi1Ge6te+mah2tkguU/OgrvYzajl3OXm6PnjK0Uab4nQjSJGDDSAjcJjFl5UeUcmQzdUvUI4
	KEJia+4tey/07lqPTX0JM7oaZqRvpcjUoaY1yMfw==
X-Google-Smtp-Source: AGHT+IFtWC9WPMb+9oOxaBV0+ZKrSS304gwoqs5fatcXARisl8jyMz1sFFUkXoe/ySBZSSgHGGwhBg==
X-Received: by 2002:a17:903:1b65:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a2f2836516mr331137935ad.39.1767081245424;
        Mon, 29 Dec 2025 23:54:05 -0800 (PST)
Received: from golem.. ([223.187.107.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm31574786b3a.36.2025.12.29.23.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 23:54:05 -0800 (PST)
From: Shubham Sharma <slopixelz@gmail.com>
To: rostedt@goodmis.org,
	gmonaco@redhat.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH v2] rv: Fix documentation reference in da_monitor.h
Date: Tue, 30 Dec 2025 13:23:37 +0530
Message-ID: <20251230075337.11993-1-slopixelz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation reference to reflect the file rename.
Monitor synthesis documentation was renamed in commit f40a7c060207
("Documentation/rv: Prepare monitor synthesis document for LTL inclusion")
from da_monitor_synthesis.rst to monitor_synthesis.rst.

Signed-off-by: Shubham Sharma <slopixelz@gmail.com>
---
v2: Removed backslashes as suggested by Gabriele Monaco

 include/rv/da_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 0cef64366538..810cfb140131 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -8,7 +8,7 @@
  * The dot2k tool is available at tools/verification/dot2k/
  *
  * For further information, see:
- *   Documentation/trace/rv/da_monitor_synthesis.rst
+ *   Documentation/trace/rv/monitor_synthesis.rst
  */
 
 #include <rv/automata.h>
-- 
2.43.0

