Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AAA1AB91C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873404; cv=none; b=tShwI4YlQGvbuRTI0G3DleMjpml4wmG0NeC3to65MstIX8mip6+yBBGDQT6S+VbyMP4ELMNq84N92znnQ8X8Py1bcz2HDKUJE2Vr1oBgE/NdZFdymBr6S0tHQJcojeqnjehOEkEcPGkCxNRZMtXpqJR7cGdf+2W3+cRtmcuhHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873404; c=relaxed/simple;
	bh=E/xlmU084aOXXwFw807wZImjGPqm1ANMchdMOU8QUug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r7+oKMZJaXU9WX0HHYo057Gf9BkGVXe2MA2rR9opdJHKgldgzyBVxPMBzsjMw2FwjG54uyulgtnHnaxniTShu9xdKvRnCpVdQG8iTMVf//1Yl9WDvbpvB0Zkq6aK0rKEiN002kpo691NIfSDtxPr052t/5a8ojPVc7/XkeFj8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7VeeHkV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7VeeHkV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f177b78dcso60527666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718873401; x=1719478201; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPUY4GnBpPiQcbABkIr/cid7Dg+9bQhVw0p/ZhNJByA=;
        b=X7VeeHkVNnoM4c/vIDPSHLEFNAAE4h9jolRxuo4ZEwsFzcqN+IX6rwhyn8CUVcnBIK
         Ljoq08b58s8IVqjm/YIRJqY6l/ZxLVNhufoUil9vwHs2po8Rtn7Y8FaxVL6OeAt7/0ZI
         AcVuC9RjRbP4YPbT96GAyM3SlWQmbK6ilbUTPX9M2x6p79SJJ700XoHAigMkqt698fWF
         CE2HNrthqHlMWLDNqMDYvVBjEVnZpYCFvhqvoKxYM4phuyg0YwnIBEU7SrlQEX8HwgT4
         /NH0kKw1qGodIboCMVqbdaoecvAIafSn6rOgr96Fj5BQc/Dtn8eQEOCo0MtZXW//9izk
         fICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873401; x=1719478201;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPUY4GnBpPiQcbABkIr/cid7Dg+9bQhVw0p/ZhNJByA=;
        b=WWSwp5N1Ik1jNVssYfLG5U19G67WgLXLSg6HqB6GR1FUXNdA1ChOejILWL4LTpslIP
         rPFLpqdiZ3WEL/kqmCylc2nmdWSejtCDQK3MiS5Puu8wDajnC5jg95mA/fxOZRJ5rLob
         v9r3FkRy682fhY4LmApUMmSjg3GhB8Pb3LWnBUkTCs08X7PBbXceTxkr57a48OVlf/jw
         vUEZw3mjzgJ85uFTXXYSOlNDHG2Hcj/n6Qnr0fyjOGg2g8gZT8zS9hhf10GgNEI6tj2u
         q9X0RZEayAIMEbgDq7AWE/qgzdEpDmgzl4gUwhLQekm+EuEKV6FHcbo945FMYrQ8oR9e
         yPpw==
X-Forwarded-Encrypted: i=1; AJvYcCXisJYgm0x9KeckLrByg6dPaB5bMDxrrKm2A7LGXomf6N5+aohZ1AxbDb0V75wxiIurmGynidmxZ9Kbj6B0JRbDHrDTHdXy8R6vp6Fl2nU2iNF2
X-Gm-Message-State: AOJu0Yy/AHiWGch9vG/xccQ7E42DYrc+YFSFzUxcVdplXHSaNAHP/GKj
	9sevr83v3ZuyFK1dsZuTXgLCRPfyJNG/f+jEjbwWViRY2qXpYYH1lg62/4smo1c=
X-Google-Smtp-Source: AGHT+IGeRQpttQkvdYS0dTEFzVkziwzBfpxbBi4M6n3CVQkw5KiESUy5y3Tp6fSmCv99sCUYOBBX3g==
X-Received: by 2002:a17:907:c70d:b0:a6f:1045:d5e2 with SMTP id a640c23a62f3a-a6fab60b27amr291477766b.4.1718873401051;
        Thu, 20 Jun 2024 01:50:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5f377dd8sm694535966b.146.2024.06.20.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:50:00 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:49:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] tracing: Fix NULL vs IS_ERR() check in enable_instances()
Message-ID: <9b23ea03-d709-435f-a309-461c3d747457@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The trace_array_create_systems() function returns error pointers, not
NULL.  Fix the check to match.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 71cca10581d6..5462fb10ff64 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10507,7 +10507,7 @@ __init static void enable_instances(void)
 		}
 
 		tr = trace_array_create_systems(name, NULL, addr, size);
-		if (!tr) {
+		if (IS_ERR(tr)) {
 			pr_warn("Tracing: Failed to create instance buffer %s\n", curr_str);
 			continue;
 		}
-- 
2.43.0

