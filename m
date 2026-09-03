Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A464A64F8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441647; cv=none; b=kV2fmbzUOCaZPVjaKFr+/hLakghHQmGu8faOXRidKnGtjGfR+bLPeZ/pueJ+/NLgxjoD4heHStZSrSIG0riLIEWTxFYloGkCNlPNpo5fCK4RTapB3wpoJQEYKNngXhXlt/3OXoS7exyA9/ii7J/bSeyp9SRM248cZ3eCI1r/Ydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441647; c=relaxed/simple;
	bh=QsXLGCKPGHsqeuuksVi+d85aa1e7GXd7VarnEp1TSdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzL7jtENn0jI0Ft1XuOTAEWm1+bwA5XniavlmI/UVbryHgFIfS9EWrQVTN+CXPZgluvIL8rxGlqxC67crRoywBnIAUC45n0RRNlaLY/aUkWTn9dJFP4JeSsOKCLEVqmo4d8WdzQmfAL5EN8TjX9lykxvRLQWs3YpaEBmXevIDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ2CIFbh; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ2CIFbh"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39927410578so4116094a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441625; x=1789046425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QsXLGCKPGHsqeuuksVi+d85aa1e7GXd7VarnEp1TSdk=;
        b=CZ2CIFbhR50yg6dwaPIuUAQjIhs04P1O3IOQKqgIFjKXHmt0JBPZWwqvXoPONtlYcC
         YlM4R83ZJ1/m+itGIG++82I2cXUaXI+OekmPXXTdQnSLBWg+GztVzPqMWx/NqecsvfEg
         Q1cep53BqWnQJTYf15wU9rf3PhHstVivCK0QwV2X2UeCXMl0K4v6hREGsr3jSjJtmlPJ
         fxZM0sDCC8dPvFtoPxHysgEDWV9jOEwzIr/1Sus18AXki58MUuT1mc9KS7S+PqLpanhD
         gN+RDQDjuNZlUn/fvxTwnBYdD6T1QyZCZTKNk95OrL3eVHkxdsSbDUae3ZEJ5GfixP2V
         y4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441625; x=1789046425;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsXLGCKPGHsqeuuksVi+d85aa1e7GXd7VarnEp1TSdk=;
        b=XFUyQhBQ1rCwn+Mpg2yxa5lg/MeS8N1p5A0YyUgn06ewvBg1WBvcVGgRc27hlQHtB6
         mltWMufUuw4+C3rR3ScDYTEDZm5YdtzXo/vDIyv0jsZLrBN084k2Brd7W5YGso6FkF2W
         NRqAEnsx5zb0/9aCDHNqR3xmqkoToGxZPjUNmMW98mPqFfVlWlonWU6crYUdld/mAJGa
         9g7yvaGukSijpJpNvSqvPMlNtpdk7XB6zD6UwBUsoq/sBgHUecYJ7vDXIPOL6bRCOZa1
         sGMOlp34RvfAi3Jwi/jB6zqrhP5LVNFQuRizj9GsHvXel6CeofBx5nFOHx/jE90DTZLI
         Db5Q==
X-Forwarded-Encrypted: i=1; AKwUvByS5C1iCnG0RHdLazl+kB7emnvc15dEPc3y2Q7UQqgZKXB5sjyOWc0Tg7011KB8XrVu4puRphneOUQ7vkQ5cfamaMg=@vger.kernel.org
X-Gm-Message-State: AFuF++lSr4JZiYqqZHouqQykKXwc+lqhI9n/r6OMHOLXLgr6Jim1cobz
	eJz3OIhZg6m7Msfo6EOnYKFQMQ3SmtdRg2KW67LxhiD3EOSAarWpR84y
X-Gm-Gg: AYBFou03kr8FioW+ZEE8BWUj3tSKAhmPGoZ0r9RcFYXvzBFi2uW/EZQ258KmKKAjiUC
	sKOMt5jvIc1L0P9bRqQswcka/Qll3qWunAb71iY6QpxFSaXjD7cAj77dFWi8tlRyx8PLZ8K/jzg
	d2PrPjPRPbU6R8DSH04Xm2pDIrKOGTEoZHub2rr3smbSMvFeJT0D7iAxe1ZAlxT0s17NYGmbzDU
	q1oR01Ee60qpU43KzkYU51CYR0kn5LbmAAMmoaJWLlUMQX1Rt/6M/k0+70HU+dP1nzMQTpypdfw
	GELYmheGAbwRWBWmW+roiFUAPiNIPtpeo1wOIJ7bVa5crW5Z0jJcQS5XI/YmNRwi4RcGlrMT/B0
	LxfhZmHegm94jPUHmuwiPllziAHX0HIDqzG/EF5JjMmSCNNGHVQ3QZ50kmrKGIyIv/avmQCEgXp
	SV4Ql2ELk/5aX7TZLAIPI0Esk8oRapkQkSrqesRJS8VYsqxq5ZIISHagDWzCQFUHChG1VprpAtu
	pffy2ou6scxuxY=
X-Received: by 2002:a17:90b:4407:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39aee219427mr17916381a91.18.1788441624461;
        Thu, 03 Sep 2026 06:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae902354asm2702545a91.2.2026.09.03.06.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:20:23 -0700 (PDT)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Thu,  3 Sep 2026 21:19:46 +0800
Message-Id: <20260903131946.239190-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902065744.DFA1E1F000E9@smtp.kernel.org>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com> <20260902064242.28606-2-lipengfei28@xiaomi.com> <20260902065744.DFA1E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 06:57:44 +0000 sashiko-bot@kernel.org wrote:
> Is there a missing check here? It looks like ftrace_stackmap_reset() omits
> the tracing state verification entirely

> Should tracing_reset_all_cpus() be called before this memset?

Both observations are correct about the mismatch, but the code is the
side that is right. The stale part is the commit message.

The intended semantics, following Steven's feedback on the v4 thread
(https://lore.kernel.org/all/20260821235129.078dd489@fedora/), is
map-only reset: reset may run while tracing is active, and it does not
clear the ring buffer. So neither the tracer_tracing_is_on() check nor
the tracing_reset_all_cpus() call belongs in ftrace_stackmap_reset()
anymore. The v5 commit message still described the older, stricter
design that had already been dropped from the code.

On the resolution question: a trace can indeed still contain
<stack_id N> records after a reset. Such an id either no longer
resolves, or resolves to an unrelated stack once the slot is reused.
That is misleading userspace output rather than kernel corruption -
reset frees nothing and only clears storage the map still owns. The
guidance is to read the trace out before resetting if existing ids
must stay meaningful.

Fixed in v6: the commit message now describes map-only reset, and both
the kernel-doc and Documentation/trace/ftrace-stackmap.rst spell out
the id-reuse consequence.

Pengfei
