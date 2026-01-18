Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA94A33
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741375; cv=none; b=kbznYLh6DqPJgVGynRL0fHGNYIbQGU/duPXyPwJVY/DHpnJ/A1Q4Q32Gzg96GzPldlbjEDYE6dtLJFoGLmiLElOa6gHDG8OuuMYQczFYUZgfO+P/iN4R5vlclkqFjMAc+nsJDlVAkV9TCdtJb2U+xTmhzfZdRP8FNN4Ua9mCjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741375; c=relaxed/simple;
	bh=vSrSo5xCPlFRjSaQuKEODqf7Gh2GSvzTadP0Y1G+o9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KI5aUQTc2pJ3JgraCFlTo99VdO6GSdWHK5BH3DHI5pDhuJDXdVyiTIuOgtuugy4c5R7t0/jZ4MSOtMVm3DqU4s9CZmQLrBJMrn36uDK1i5t5llrulMGDtKUr+HkVzHvXNL3U+CslWJiMUTbKqyNTsYIXq4L6+3NgdlqQEwEhRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsOkq7EV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsOkq7EV"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-350fd09fdd0so2316041a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768741374; x=1769346174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A7fmXMkUfzcNTiki9Zm6WuYpb2ND7j8d01F35TgTng=;
        b=QsOkq7EVH+7Wu3C159o4r4dkL4p44rdJkZtxIsOQe/LZuA2QpzxAH6A0j6FUsjHb5H
         NQMYk455VJgooPWQ3I/TTy1HxWC52RifZsh0TE5aXDtfGREfpWXDchyxQHQl93UeWeLL
         /9cYFwVenWsLSuutE8J8553TiY1bnB+SI/O9xo6e9nnL6oFxRDi56MyWC2fqgZy0zSHZ
         yBPFdK6xMNBY59VRAP4y9mjDPT1zLBGWn9YumNG9TR5L/4zmsdhkLojr2fFJem55/ViQ
         ArPIrpo/mTnk5qw9LGjDEXhyq1WWB8jac+BHH+rag0GVrjs1aJ0Ukx78R7P7CZ6pdBze
         26ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768741374; x=1769346174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A7fmXMkUfzcNTiki9Zm6WuYpb2ND7j8d01F35TgTng=;
        b=v1O4NQkBzfKCHfR0VdGwz3vozgD3BRh5V40Is/BWWBCJmMWZBNccqrCPPemrsyeWPj
         zAya67A73lK/MGOvWhVFVG3oMfqTs4xvBVWYLDztj7qxSHeb8hP++fJVRRW+dDSK8a3O
         vwTB805JXZQQvJhjZjSfy71USqaneixZnHkFl/0t0tALSBicyBUny8xiXCsLmxzYg1Yb
         ODpvYw5Fdr+xtnSTCgbKdVJOKeI4vRzJC1Ek9d5r17ImjDosG6pljuuelSLB/D7y74v/
         Fx3eovjJ+DGo1uRf7PxZRq/6KwAB0oeBOsKjLf9t+d3ZrpJue4bNf/CjZWTn0pgNH4PA
         EzXg==
X-Forwarded-Encrypted: i=1; AJvYcCU55cKKYKgG2AzQSnuNU09dr2A38yR3D6BZjDPKCxjXfgsCN8oTbcs9NpcxAtq2n9rqXZ88JwJHzxAA/+29LFCPjdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLgZ8FrGpGyvgrg1r4vDFjJwnCVCR3lLosvG+VTn7JyVCEV+9
	SIApNWVjF1DgfBFYDqH9S9pZ2XokluQsP4/CkpQJopBwgbjWXJDYBw8l
X-Gm-Gg: AY/fxX4v9U1up2PgHMyaOUYsihvykfPbz+6Q9c1AxN3mAYZGQcotdh45Wrd1aXTen3E
	DSr/EsnHqeSw+1ddZDbwFq+NCf5CFkD4+ozAjDtSrCRf4T3pKpq/S2NA357d8qHL6X/niV7uSg2
	EBVKoWG65vLwWC1D4hK5Vc7W0WvWbd8QefVuiZMgPML32KOP+a237YiUxXaxRLSPJ/G0zn3Jk9e
	OHK9OSJx/jeUVighkewhzqqoWl5S34rPqTV9H0utUK1Qjm9aEdU/ozKgbdWpdMTu3KGTenjNnOR
	RdLAb50c4VzBXn+VX51L3f4z/AKRNRDrZRCWJ8fGiPxnQw/4Hlc1JAPv8XRwl30Qrc2CknaR1a+
	2WuUn0EMrQ32iXYCcZSJhXZIumLTIR6suhYzxPdeYUzTB4DfCcxCRqUEaghLHeL/l7d1+rZryM9
	7aUzQp1t+7cbfaFykD1vDfmUfJOMv9wPnqOjkns0dC2f0hagHtIuWMPsSO1kqXSXbI3VaOnVSUi
	vzf2hyXKkgt4n9i/IIhIAD5sVR/oNxWnr+BhR5PM/2wlRU=
X-Received: by 2002:a17:90b:4f49:b0:34a:be93:72ee with SMTP id 98e67ed59e1d1-35272bf2628mr7224945a91.8.1768741373993;
        Sun, 18 Jan 2026 05:02:53 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm6639459a91.15.2026.01.18.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 05:02:53 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] scripts/tracepoint-update: fix memory leak in make_trace_array()
Date: Sun, 18 Jan 2026 13:02:47 +0000
Message-Id: <20260118130247.1003369-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In make_trace_array(), if add_string() fails after some successful
iterations, the function returns without freeing the 'vals' array that
was allocated by previous add_string() calls.

The add_string() function uses realloc() internally with a local
temporary variable, which means the original pointer is preserved on
allocation failure. When make_trace_array() returns early on error,
the previously allocated memory is leaked.

Fix this by freeing 'vals' before returning on the error path.

This bug is found by my static analysis tool and my code review.

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 scripts/tracepoint-update.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 90046aedc97b9..7bc9d66229ddf 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -93,8 +93,10 @@ static void make_trace_array(struct elf_tracepoint *etrace)
 	for_each_shdr_str(len, ehdr, check_data_sec) {
 		if (!len)
 			continue;
-		if (add_string(str, &vals, &count) < 0)
+		if (add_string(str, &vals, &count) < 0) {
+			free(vals);
 			return;
+		}
 	}
 
 	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */
-- 
2.34.1

