Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB533B8D4B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281739; cv=none; b=ncQH5UgNJXo4Sl5cesaqDL0JwwSyqigiP42+rmg3OVhp2rxsNYgrwoiWM/qr9qciFlyBiRgs4ysgmzxtjPAgHNtRuqsTXbZL0Mq4Q+MSLhphh83IPOMj8ajVLj6cwvHTqSWAiTAssnP2qkOLJbV9e1G4coIL5hOq3qTiJechnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281739; c=relaxed/simple;
	bh=dMh97SpW+uW/eDiBLEvQzJEC02yLRjYzceBP5fe3b+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq2MQVauigOYziBy+PndCHFO52TARdSW/AjsLdGPwXrasFktqC+1W7qm8y8ajjo4XMZxa0SXoVQC/f+HStDM5NEqS38h4PbcaJwLie9IyaD8VNTT8NSTU0s/vyORROjn9Xh8wZFsBr2RLmoOuABJSQ4M+0B8cHxirTMIEUpy9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=ZGHNXu2J; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="ZGHNXu2J"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfc40e4158so34020285a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281737; x=1774886537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlomcdNVnDUltLo2uoCpQfabx00EAMLLoQfBL4FGNbM=;
        b=ZGHNXu2JRc3JaR3nttMjRCx/ZwakWJ6Wt7fsYuWibR7B+7Sp0sKeBjIP+pJguiYwkZ
         Rit7W02iugLXrtcrNgQkgfxKDDV9ycjbAlRd5dAK3VoQFmDGZw2/FeW/Zei81rszWTF7
         SShhrVHnRE0rSlYpdnkAmu1xi8LCDt+iuaa1yOC6AGc3RiDE1c2ljgx8I84t23ga7G/Z
         JQhewAm6vu4QwS97eBhvhPG58f/9BIhYLDC2/qA8BxCynHADG827jFnFPv93gXJ5D71/
         PF0bmJ0w6MNP0kooPlBx+dGj2EsLVyHuoPTsHdLt33TGg0uXu7B9A8UBatlJqDpixQb4
         tX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281737; x=1774886537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlomcdNVnDUltLo2uoCpQfabx00EAMLLoQfBL4FGNbM=;
        b=E4te+Ybn3If2Y9R5YwuzvZZsq2ADjyJ2/T0DihoukKQk859YcnZQK02qycfF1kvT8y
         cSV838x++QZS4Z5U+f3farKxHwJmRUY0TS17vzw0LaSLZjHkZxbfVG2J6+JVZORBlOwp
         1j/0MTU0YIUC7E2sAOayIbiLerRLef0QVj/21E0IL8gb9AzVuwHiF9BzfUv3BUOlMWIQ
         tkFEqj22/DNvENjj8HZSaKXJvyHUfRSampXosdCx23LlV5e1OIoAvQ2fdPr69HQ/otqD
         qpp5SNOW436mGVlQO4GjXfW0TuV5EjcG/jTK+niCLgs5oPSLrkdvdZfjpZXrNSMz6u3d
         gDrg==
X-Forwarded-Encrypted: i=1; AJvYcCVJw3vQlTjoBooXSpEbhIWMMqmtdOuBqmmzWLxuJxPWbgqLtu3bAAtPRaa8A9XDNPlK5v7dnAGPzzWyhYjMBX1IYBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ15cpQHy6egqWw6Z65Ne4c2PQ0iESZrRynk541EU5QKrs4xVg
	YrkwoPm/MNf8bdbr+xWbqR3n4dJ/GCXlUCkoSkMX9ehC3wAI7QSzG4cPb09J4dXED40=
X-Gm-Gg: ATEYQzw8ueR3kZNfLRka7oeHpBreHTlrloXIfo0d5Abi5bJujN6k0/gQuohURdmtNW2
	aV6JsENfyqmRiM52HfsEDlb5q2xnSXyBwL4vx+bJAe9iRx+q+TjBRBmQ3TiNBXIam8J687hllfr
	U+DPfobO0zfS3mP6MEI66/zukHVhOsp2V3MwH7PJ6uNoLtHFGWHYcLn2GzuVxNxUL+rajOJPJgo
	hellHRbkHM5pltvaFYNrpuhmVCdw+c2yZC6uhM28tMbf48uJpy2I5nrcVhNFoo6k5KmpzwWu/Qz
	B5HJJeawznIZjNbZGNy/OKGEPZDDjTFxQLm56h1OFzkS6cEICglyIsq4bLvCmnSgjJYfRFyMxCY
	keC6tiVtFT+RDAAGHPhwoa9YxwONIb22PwG9psSpRYwUgWi4sLfE2OFpHhisJE+2nghp4EIZ3SC
	SISY3VVLI15rcjVkT75icQgtIQJnI5n4FdX+PRZemTDp8cFc83iWbaCyQeOCPdA/ynew==
X-Received: by 2002:a05:620a:1a04:b0:8b2:e5da:d317 with SMTP id af79cd13be357-8cfc7f69b95mr1829148885a.54.1774281699112;
        Mon, 23 Mar 2026 09:01:39 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:38 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 18/19] mm: damon: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:37 -0400
Message-ID: <20260323160052.17528-19-vineeth@bitbyteword.org>
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

Replace trace_damos_stat_after_apply_interval() with
trace_call__damos_stat_after_apply_interval() at a site already guarded
by an early return when !trace_damos_stat_after_apply_interval_enabled(),
avoiding a redundant static_branch_unlikely() re-evaluation inside the
tracepoint.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index adfc52fee9dc2..b1cc4f44f90a2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,7 +2342,7 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 			break;
 		sidx++;
 	}
-	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
+	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
 }
 
 static void kdamond_apply_schemes(struct damon_ctx *c)
-- 
2.53.0

