Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164815383B;
	Wed, 11 Sep 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055044; cv=none; b=Ckpod/Fzrl5dwjYQI+FAFppN0klrYo2gTvLkBUG1nR/nBuRozara19RuGijMhL8vKL7lFpSbAAHiybkbXS9lB5G/tsSFEO9bJwBK4bIFGuKjdLEeGqEAxIyQ+bMqifKRnEr+XhtExThHC1XNgOF2EUxBiR8AhEC6JKGlZ413Qu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055044; c=relaxed/simple;
	bh=7M7mYWiGFN926Z34bF/OjYDWBSDfeYbG2CdcI8roNfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7v746lVRZyssQYE2eqPzvtWH9eeLIC1Ci2VyxNiyjI598SP/cXpwW1fEhr7Jr0G19FrozIq6t8lq75yLCv6/7KFS9a9+JsJ/26vmFROOjYxg+x3lc6lCtyGDcPCASed5S3Z26lzQ3xNX1EFfGDXRzu+1uhFYs5t2nuyOyOQQcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5tBM9NH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5tBM9NH"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374d29ad870so4139419f8f.3;
        Wed, 11 Sep 2024 04:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726055041; x=1726659841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSGLwJEd8UNrFUVwhp66iDC67a7nQy5YCYZpUJIy5bE=;
        b=T5tBM9NHV5jZrcFYepKJN947qQRFsYKbqw6VBo7p0AV+528PTe+oktwGGYgaFS3ja5
         EPk+UqYhKVIth2oxyBcVldvFA0xDHqMV1/J1xKYuLVfmbnHLKITmDciY/nfwNfWoStcG
         9cA2+2/oU4XsmSJHYb0Wf5x28/z7fyinLfen3gDOOyu2coM4Ptqf13+ire4x/S8/E3uB
         jSr2XNT2hDmTGkxd48aVt3JPNlE40TQmBkp2ilPRC06RFYbAlOC4jLuBUm4zAIbsaIH3
         r0yAOL7wWdRlOaYPj+VVv6rXnrNWaRMACpqUhZ98UR6OYizZS+XThZCndEEmLzi3h6dI
         08sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055041; x=1726659841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSGLwJEd8UNrFUVwhp66iDC67a7nQy5YCYZpUJIy5bE=;
        b=MFG4iro/pWx2jZS0WtvKY13b/gOqMufS9GXqygxJ86m5tbo0shb/ZoyVZHCgmZ8UCE
         8tjod9U75YOpsFfHT4JAm6ph0HWJZJp8Q6QdlSH0jCfWa0C4+Y0PMNygN00LD9cJpH1y
         ZGyP4qEzg1YZXsanwJuoG+6e9PQfe14Vb6/s9ymnjwBrPbGInn+XSvfFLIm55S6YdmQI
         S6v81O/kkosztbWofDyjPmyAezMYShQPk0sjkQulg9go+jP6Ejam1LKqHfNxdXDaTnIa
         IVQmmvZGem1CJsWypcAe404ZwB7cDpEnz/f2X9bvvgDllutRL70ZJLw9i9GouGsqSvwN
         2NKw==
X-Forwarded-Encrypted: i=1; AJvYcCVbM+ccVkyIrjQPl+khYd5NvwSdds5K2dUgOqBt4va7CEDclSsqh0BzC+mrNYKvpEgbOWzOQ8KPrLIGjXeTfCc=@vger.kernel.org, AJvYcCWMhkKAdeQE4ixdKl+yXN+4hx6jT0ScF1a65b/k/2eTdStVFqaZlYtWee/5yquobfVtcmdMNXT833yofRCb@vger.kernel.org
X-Gm-Message-State: AOJu0YznFVd5LS2yNZRX95iNdAutpAn7+qGAyjt8YNqGKJv1/ClRnPZy
	i5tKZc6iwrPBh7n+Dgdn9RSLbIbNpAxuAT9GcMlA1ZDtBW2Vtgqe
X-Google-Smtp-Source: AGHT+IFcX9w0A3XRz5vCjxSnjChRLuaD27tW13dUPTJL1T7nfkezHAVfoNQvZ3Jg/n02w0vh4Xh+WA==
X-Received: by 2002:a5d:688f:0:b0:360:791c:aff2 with SMTP id ffacd0b85a97d-378896a3f79mr11769671f8f.47.1726055039987;
        Wed, 11 Sep 2024 04:43:59 -0700 (PDT)
Received: from void.void ([141.226.10.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564aea0sm11332929f8f.20.2024.09.11.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:43:59 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] rv: Fix a typo
Date: Wed, 11 Sep 2024 14:43:38 +0300
Message-ID: <20240911114349.20449-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index df0745a42a3f..9d6de2d9e62c 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -41,7 +41,7 @@
  * per-task monitor, and so on), and the helper functions that glue the
  * monitor to the system via trace. Generally, a monitor includes some form
  * of trace output as a reaction for event parsing and exceptions,
- * as depicted bellow:
+ * as depicted below:
  *
  * Linux  +----- RV Monitor ----------------------------------+ Formal
  *  Realm |                                                   |  Realm
-- 
2.46.0

