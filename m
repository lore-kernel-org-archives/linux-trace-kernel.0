Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928E547053
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084773; cv=none; b=I3OB4WMCjJ5UOMOJAFlFWU02gt4rW3YRYVC+7TSwTbcb/lq8DTupnei9U9j8G4pAunyObwR4huZoK5elCnliosdOolTB3id//8xz0epjey9oM2dV6kkIHWaXh8pphBEDw9OEw+oZgmAIdKBuiIK9VrD37a80HtlCEOCXkv9tVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084773; c=relaxed/simple;
	bh=+53W1BjteP9N2kT0WM7yRIHxwIk1ni40/JtDOj4EmZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2lciXm0j96/dZVb3EVmALAlHXDUhKPYGvbs6AKM203U4smW+3Irtr4YwlR7OIoPfH6xaOI0SBte90J5F2N8LGK9DCXDBAf1Qy9PraaFZgf/15TYvjMKliJ3pz7qkJbeUf89U0CHWH63jDIljeN8aCZD8DN9hQDeCghBjIii3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.b=Gq+UYM8p; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theori.io header.i=@theori.io header.b="Gq+UYM8p"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89ee6f66566so319704b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google2026; t=1792084760; x=1792689560; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pO2SAyErFzIof4dDqItrb/7b5H0BZm3KDfJwYmvr2wE=;
        b=Gq+UYM8pqGxf8L3IUkkMd23gm8znzJICY5nWXQ2JwEbv+ZRTTLUAAwTqIgnB0/+izx
         /4OTfOdMRtTLNybrrTQ5VV5ZinUOdcTFhF5EFd/K0EhwjSjKtmh7MfCsLBQEyRrQdR2H
         TZA+qENu7JWA8iS5xSHtvzPyY6Q3GD9IE4KnCrB6KU3P22+xsI6yluK1Q+oH+d6kDlSm
         ierqht+7nihuYYTtbOisF3+PK8TiM/LAAhzXu7xz8GfOy2Ydad4cK8cQX51fsa6U4rYy
         sVnMcLVLnAJbg231D215u+wqoyWoibkKBizZjNpHKYIRZs/MpklephKErFVD7KUnDW3O
         XqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084760; x=1792689560;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pO2SAyErFzIof4dDqItrb/7b5H0BZm3KDfJwYmvr2wE=;
        b=YYtMywpubfptsuKi3nqtvQMYrAXYSbNOXbxKFdKQpnEsRhk4YpsG4wbE8tvB+MFF4Z
         y6vUSCfIxh6ahHQH6u2QWku9MpWQzLMOliPEy8lLOQKOyrtewPdahOcsPQg3SHqQTfOn
         oJvhTfU3Sksw1aWpODDIQH/6mGsYx+83R/AQDDmJdQqiMEFIF4opD2AoTLYnJvrjdwHu
         aKxh7ejoiVyeKBJ3qtAAtGtRH1rl+6Ff4dUfCLy+RKtx3MsmKBOjbwVECNOrHMLhtY4b
         5IhB/BiC/yK9g3qiv4VrE+vdMUZgFs9TRTC57CIEyrCHZhjC6RQAgGM9wMGowLby3Dbu
         7J9g==
X-Gm-Message-State: AFq9FYLBlfbua7fXhf5pYz+KVpHobqVlQMba8MIfQg5YmrHq/Nt2wWax
	sPCypWXWNxZq8PP8GjZWER5+VnfAeFYIEcafs7E2YHb15KRsssXZhRs5YRsRmcytHXTa5KOvkyp
	edeo1
X-Gm-Gg: AYBFou2h4Y9m6XXsBN4YJYYB8G4SZv4/qwN1AnZYeTNzNJODuj+v8yQ9VEXYqickKpG
	YJp3fnma47iv6PuzFowOQhK8VMhXu9tp+jQBnd4zNYuAfDMUww8Wlay55JPquLnEaGubCnfxP6x
	3YjXUP7DDHgrfTUtRno2rpwdR9JobKvGcYzI5+efmaFm7vHm4Wpl2E3yfRGQ2PaKoAOCl24gmkw
	6MkMK/N2OV8w1kAtVGSkJnmntWX11d8gNAnag2PdvKfD9jZksLWw5n4ZiKufpigDoJhh/zSQYFd
	/Iwwn9MLghy0uLSRYkKkDkPBLDPPGsB84oGLdsTJledEDW4w0+zrpmj5XoQuUSdJTexqXCNdpEF
	q10aq6+U0Mceu5zLmyB2TBqvZG1cwelzFmgIqLEkpi01YVv290YB8HM8EOo3l0fd+oJsF+c/fyj
	PNGYO8SmIljxee4CSsFJhrVVUlCo0+/xi3jWi2Hfv+vDli1zwY9tVxPjWfj13dZadcdWTrJngvm
	6FG6pRhsCxktIhC8C5OmFrDDkQA/wXCfNJh+FEITQXgbmR5wiwGtNN6DwbDVRFB
X-Received: by 2002:a05:6300:2287:b0:3dd:a195:dd56 with SMTP id adf61e73a8af0-3e16bfc2d17mr17967548637.56.1792084760474;
        Thu, 15 Oct 2026 10:19:20 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635c58d91sm1651529a12.14.2026.10.15.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:19:11 -0700 (PDT)
Date: Fri, 16 Oct 2026 02:19:05 +0900
From: Taeyang Lee <0wn@theori.io>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH 1/2] tracing: Keep the predicate limit separate from program
 capacity
Message-ID: <atELCd1XjKVhrkFL@Taeyangs-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

predicate_parse() adds two to nr_preds to reserve the terminal TRUE
and FALSE entries. It also uses that increased value as the limit for
parsed predicates. If the initial count is smaller than the number
actually parsed, the program can fill the allocation and subsequent
accesses can go past its end.

Keep nr_preds as the predicate limit and use a separate value for the
allocation size. This leaves space for both terminal entries and a
zeroed entry when parsing stops at the limit.

Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Cc: stable@vger.kernel.org
Signed-off-by: Taeyang Lee <0wn@theori.io>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536..781416ba6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_objs(*op_stack, nr_parens);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kzalloc_objs(*prog_stack, nr_preds);
+	prog_stack = kzalloc_objs(*prog_stack, nr_preds_alloc);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
-- 
2.51.0

