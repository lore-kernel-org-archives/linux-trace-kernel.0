Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B038736C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Apr 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850508; cv=none; b=rzvez5U6HPp2oJj7agI3IWB9VjHp+Zj8GToCpzyucWCcp+/LMdfrYrGGtGXUHaEW0jeliLyJwhefqQaE6eBVdxuuMEGlGM2eg7zVh6DLS5sWcw+UrSrM5pD4COQVCpigTiv9HzoBBLOJyMKjbcVdnU8ebESoQFHrJ3GSuiX88/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850508; c=relaxed/simple;
	bh=vD+bzDL5thBXrYj6RX770FQ4nsZjOb9AcSlK6Aevzrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L73I11z/1tpsXaXdA+6woM3JwLg8fzI+pzBzwJGlxUChZIB+hVUEXrxCYfEq5kvpm7VaCr+nLXXuBe8znSzovDyRi1WyM/VM5rF4miT/zTQ2LmT0trjE/Uu1+me+hwvxlwzfp2elNVLvtuBBMsQNisVrnyW3qASgqy8c2/JE+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hs2VijwD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs2VijwD"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35fbca04006so2717690a91.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Apr 2026 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776850506; x=1777455306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhUGTQJctBxrcwOUBJfPq6qhB+QvbYH+/tpOfPXwO+c=;
        b=hs2VijwDo6SrOKy0WuttVs8NdkunDn2SZJUXjglfcI2QS5FWLR4PJfyNRRyrM1zvXu
         IdwLOWKzBk37cUaD4iMFOjqmWYpxT5aqIaTYZzwKnRvVdLUv3FuddDjqAt4RYFcI6/qf
         4b+uoNZZG1B59uzgDoglmepkNtVV3c/L0GNU0+QBYrgAaiT0pKWvKUdgIay1RpRljr4G
         LEVJMrfvfxjQTnlKlltLHR4GTQRGL6s8XN3pkseV4RGVzbABCWeofMkZLBMZU8jjc5hz
         6HKNBkYEs4WBfb1/Rv3aSgItD6zapDYDHeyYOuDS6qVbk/ZivC8ZUKHshqmQ3eiBUk2V
         0Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776850506; x=1777455306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UhUGTQJctBxrcwOUBJfPq6qhB+QvbYH+/tpOfPXwO+c=;
        b=gdMfyn3JsOsz4Un1uwTt8JbPUXrZN9hxGxqYPAc19lvdY9w+IA09/Fk9JeYs/RmIrx
         XRWRJ9CUyplLVIg7fw8Lom2zKCNgHb5WkAfaGfH7FO5h2oMH1NF1PeGOf61c7kI7FzqN
         LVb2sR+qywOvJfYPx3MDDNyMlNiJk30XuURXa0YPFetnvuM7sQs/yy+je7fBlO5Dh2S4
         BZ5jD7BgGtNgBwddt7zRsP4HVNT63A3TG59U6t8fOoQQ6QfyhFM6NcaVsC6WX/ofH8mT
         hg/tvzRUzLh7HuFG1BlqSYTkRuE3DaHvFPZ59BoP8algL1o6ueiXmdJsXyoUxEM6+o50
         VQ6w==
X-Forwarded-Encrypted: i=1; AFNElJ/Sma5zmhPrg76eueBI4VgcmfXlL/+yCTmTmxE5plB59h7V7P23qYKq8vss7wBrLIG0F83vjpBpoImpHXWnT6MIN4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2jMIBWHPXt/sCeVZUh1uQDM+S4qff4ZPLr/JtGpJuhkPWtN4X
	sxESUWJfnOd8nWU5F4bK013aaoV9kucQxtjiY+ZPvhCNl6ZJTbxr7l/5
X-Gm-Gg: AeBDievz7jV7ar6XhESYlDT6955CQGk9bvv2gfooiGe0gyg3x6msA7PhRwCgpTYXl5O
	JtIaBTkMMZ7RRTUmawlVHf1StqBm+bFjTD6m5FNV+1lPcO0Tag4dsqKkEEGJbHHhiMzVwNEfXI4
	YLcoKt30zc58gsODLPYNbW66lL2h5EkrXYfQ0AhCR3fgo+D0tXdhaFHDgtohPDD9/uCBj8ygtIe
	os5xiqhb9L4a2R3fzSUq/zw2CvS/diPaMnMkO+pudAso53tM7K8xUInCzn9TjftdQPICiSRS0PZ
	0Qnpl4GYyxsfq3xVZ/lyr+vC4Nnt/kI2hoBgA/PUpz2kmKWeBUjwEcxmeYHM6t6uyaYbHFUNS9s
	k08JD6c+MiNcdVv/zlyBFqFphszZnEN1OGbRFYmEV396TfoPO6LRLcAU5Mu/yavEJsGKjVRhpv8
	8OU/GdAZkcQlXGaN29GMBY4JXRB2aUWCfDGuohZ6Agr1A=
X-Received: by 2002:a17:90a:f94f:b0:35f:d61a:fe08 with SMTP id 98e67ed59e1d1-3614049c959mr23265454a91.24.1776850506294;
        Wed, 22 Apr 2026 02:35:06 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-362bc4f9360sm3143731a91.1.2026.04.22.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:35:05 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17@xiaomi.com,
	Xiang Gao <gxxa03070307@gmail.com>
Subject: Re: [PATCH] ftrace: fix use-after-free of mod->name in function_stat_show()
Date: Wed, 22 Apr 2026 17:35:00 +0800
Message-Id: <20260422093500.435318-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417101814.22d5c21b@fedora>
References: <20260416083335.920555-1-gxxa03070307@gmail.com> <20260417101814.22d5c21b@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 17 Apr 2026 10:18:14 -0400, Steven Rostedt wrote:
> Was AI used for any part of this patch? Including finding the bug? If
> so, it must be disclosed.

Yes, AI was used. Claude (claude-opus-4-7) assisted in both finding
the bug and drafting the fix. I reviewed the analysis and took
responsibility for the submission, but I should have disclosed this
up front per Documentation/process/coding-assistants.rst. I
apologize for the oversight, and I will add an
Assisted-by: Claude:claude-opus-4-7 tag in the follow-up.

> Just move guard(rcu) out of this if statement to include the below
> reference. No need to make the code worse. This really looks like
> AI slop :-(

You are right. Hoisting guard(rcu)() to the top of the

  if (tr->trace_flags & TRACE_ITER(PROF_TEXT_OFFSET)) {

block so its scope covers the single snprintf() after the if/else is
the correct fix -- +1/-1, net zero, instead of duplicating snprintf()
into both branches as I did. I should have recognized this instead of
submitting the first plausible-looking approach.

I will send a follow-up patch that restores the single snprintf()
after the if/else and hoists guard(rcu)() to cover it, with the
Subject capitalized ("ftrace: Fix ...") and
Assisted-by: Claude:claude-opus-4-7 added.

Thanks for the review and for pushing back on the approach.

Xiang
