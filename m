Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11853B8BCB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281669; cv=none; b=pC/SVRDkNe3xP08JL52eh6I48pq68eZ9BnUgV5qy5XNTcnxSS6rT/QJd+N1YoCEXDXXWOCsy5oW1bMkBNpK02Wp9iscUSG+oUQJPJBaHy7izuZyT0EnNVleVYnMhimxwoGxUsv1ybax5ZDHOwdtesJqBJMSLSR0pkg5PkWkBR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281669; c=relaxed/simple;
	bh=Hj2JhMI5b6Lafwdjdamwe1jMGPYt17fp5OkHh3BHS7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdFM339zmDMbHpc2yOtfG3VMXACs4dMPMEB4n336doFNPbTDsOEau0vAvFNvD6/dtSY/lAr5Vn5atzpKqakmiNQE1YqpOJ+E5I2spQEMOtOXBg5nOeDfXuOMIemqGcSyVB+m3c27pYSTa7nfm0AGsDBj6re2oAKt53ebNmDdRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Q8oFKUkK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Q8oFKUkK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfdac74050so233119085a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281667; x=1774886467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4j4tflgND4Uiq9FcYinLLfKMNOFlVvGkpZDXfO0Vpc=;
        b=Q8oFKUkKk31RX4VSpufeeZR/L2ttmdhrNRS/xpusWMuJ3uT77h9XdawdBslPDqAxfS
         QA4JJVHgbpliXhKVMF7XPf1vNWGvVwhLg7FTYKqqCmhLT8bmjFGXuFVuhbDld2OB4Pp8
         UFe/LC2eQIueylGEa3HPqAVjfzBCSfMM8yfY0kPltCYPQG/zsfa71kGewEvtUK6B3nqQ
         pT+sysiqFrsDyA0gA8tea8VFyJ+gIpuiVDN5vxxcJRCxzQVgg7FsiPc154vdyUeBXeGH
         jYvnXi9eNUGijd+xknI9mShD+y8aK3H2hcGpVW89OGqRzcDbZ9TTb+e2hEFnTvBylti1
         srOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281667; x=1774886467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a4j4tflgND4Uiq9FcYinLLfKMNOFlVvGkpZDXfO0Vpc=;
        b=CZ2XovUSDAHek3wxOONdl3gb86i3W29fwwRyhu4l4kC23hmAYdLq2pnPHAcdb245bV
         lXBc8BsDHYDGNM5Kr6rBN87sh3Se9QavBMtIOzcAoFr2ff5kOjPVU9Ol8IqgB27cDYhA
         4wWRgrf/RFk/o3shumHOODZLq5jBio0C8r/YUtQeYxv9HdotrUyzLKnmP5KmFhO4Kxrv
         e9FzWdOxWD25AVnqyLOeEQX5HPXXKR0u+ESAh/5swD5SdmFj1eMyvKuAWbKqrwVq9ifT
         HMnQRAJ9uARZrg6v3eu0DTIitkEwrLso2ZaVFZUZPPj0QjpaMIbl0TipcHTCMXcyMlKj
         Al8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZJENGPxRZxBe0vTDHkDrFquJwTZgQ9mSiWtBXxuZXbeMIyGKWgp2Az+oAoTlgOncQ+aJ9s0uq/cx7dTsYKKBnDGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUqEW+ItCWALdyadWVa4y2cUt1XR9rsohVOfa2JtrcFle3M//
	eicdB6zePtxvE2x1E65gCvJkQlWfpRB2vYLXhVR4kPWHWvhubDGLW+OolTxGqBbSWNw=
X-Gm-Gg: ATEYQzyJP/Zuicn+gx6Js48lLwc0x9P7rZmSL35UArUs3fKPy94vYnGxa4s3ALt+ZXP
	xA3pbckUKreNR4uafeMPrXXCbB90X9tJez4S6yJfjJ3HWwJuw/o3JtTMUizs/tEgK5SxZ5K69TK
	NGfYQ6Q5trOW1wfng0GdJCGuAflh6IcZVKoGKTTQ3n1a0UC+iuJUuf7jaMXu4Mtj1jr89v8B48Z
	ZwnzwevKT02cN6DJUTyHMJ/MJp5Mf45uR4g9NjR5tBqRnQsHxWn+MzZBd/YigN+4CNh5j4oAt0X
	ZHsfmKwwOFibV40yimYsCfNJGRSBrks5ZLX8BEuwxCCLr2XnIAdu6VG4G7GKOjY1B2gPdeLjSk6
	zcDB5sTK+tXBGrviLtmSUESQVlJdfkRN3uzNWEe1n67uiV4hXISvNdD4iMVoacvwsQ1/merYJeN
	Ni3TtVh9Fs8pUvPrebO0H1uSQMV0NhmXG3PdM55rcB54yKDRJjMe5Y95Z7OdDqwYmq3sXMdwZlj
	oP7
X-Received: by 2002:a05:620a:2845:b0:8cd:9033:1724 with SMTP id af79cd13be357-8cfc7b65cb3mr1863344685a.9.1774281666365;
        Mon, 23 Mar 2026 09:01:06 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:05 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 03/19] io_uring: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:22 -0400
Message-ID: <20260323160052.17528-4-vineeth@bitbyteword.org>
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

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 io_uring/io_uring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0fa844faf2871..e99975ffdda12 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -299,7 +299,7 @@ static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 	}
 
 	if (trace_io_uring_complete_enabled())
-		trace_io_uring_complete(req->ctx, req, cqe);
+		trace_call__io_uring_complete(req->ctx, req, cqe);
 	return true;
 }
 
-- 
2.53.0

