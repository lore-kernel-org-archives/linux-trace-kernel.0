Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CB136354;
	Mon,  7 Oct 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291418; cv=none; b=nYxpndimpTmEfVosTzIXVNqmyfd2qI8lQfryAKZivY6aKduTK8rybi+wbYMnL8IA25gPzrH107bE3/el1McdIGjML1sAvsyqBpdhZwMX0u1p+n/IC3OkuG06KhSmLkzFOPyiv59TEqarW1s4BSUN4izIL1BOGcZ5dRwJW8AK65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291418; c=relaxed/simple;
	bh=wBOhLHjKZCxDIGyWd3PjxsSWnR/C7GwweXfo6ZueQrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rugjDFyyH4NM8oN+9bKJhBnElna22/pvPzcZokJVVyrewBHQ8Kgzw8tZnNtSNUfrLcQX9p9/W1yNqblh/xxwSriqXQqEb12Le91q/vH3DT9fsn19uoSJh9ucNv1TU0v99NJxzmX/d7PtHeLHBjLxPLMKhgo6ygEe/7mpJi4PySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB84GPrh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB84GPrh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cacabd2e0so37422565e9.3;
        Mon, 07 Oct 2024 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291415; x=1728896215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3w3IqZ9EBRtYylMbnz6k+r/bjOp88RssQP77N0tIRZ8=;
        b=TB84GPrhNkpLlmmelwP0FH3rJKF44uZ12+NmJhvZl5bxP+XQPFurf7jUqYf+pViGZB
         ujfF716VHdWvs3bLtNrbOPLtIA2BatFeVV0kqFtrqobVych4gT6Oe51WinMvVts28tt6
         VmL47GBDiqh1r6/JD91MYh4hdZTzSBrHgT+iLePedtXKIAl/0DL/naTsEbVt3mSct0Gk
         DWMm8FdX+y9MQYcQwcpcguQaof1Ws6dhKFTXuSgx0dxhZLkFUGuiq4ftqCg6nw2ZVKql
         qkQuVmi5GuAY2KNUPFGNaNdMiZNAWLUaaF2eHZUAqvYLEaWa7w6TIBFY6CsT/N0pW1/8
         Jo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291415; x=1728896215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w3IqZ9EBRtYylMbnz6k+r/bjOp88RssQP77N0tIRZ8=;
        b=IDFJl+QLMoZ1hTjJ/Ll+/FgwnibomoJv7SRHYdaiK+8uxsAIn+mjJrRX8WDVaQeisL
         Ijc8i529JjsAuotNtfwI8znUNr/XL86itdSSAq0+ONRuEdese6Ax+Eudjwzv1+5SVQso
         t+V82Xa1t/D9ve8DKaZFb0hPpJIH9/LLc2IoWkjhWjtP1UfuFgto4citBA6OBa9oww6L
         XKJcdB9ndSz5kGPzz2nWwcFRZw8/T8ByMnO6iQlj6aifNsg9Wuj+FJwWZ+Ysd4yv7fS6
         5t/ivl4MvLB9LJ7blv4/j+FxTMah20SEBlbhxYq9s7DqDkxT1s510IBRt7V6U5W4cwWl
         RLTw==
X-Forwarded-Encrypted: i=1; AJvYcCXVkoyr9SC5yAB/wD2cXwBNnpOoyVCpf115ktD7qTXk/c2ZBk8PKg/lcIl+Vh2DRFWv08hRTz2pqUphCro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3rvaC7/o/72yi7p2bOoNBFLTMszXN6j5Nt9i4tL8BzNbvnj9p
	jm0yaqfTkjVzDHleN2bEiDEiedDCmr3P/JE9SnShbnrvyeO/VWv5g9ez1btuStI=
X-Google-Smtp-Source: AGHT+IHMVEbGiFyRbideG2K1Pe6IZgGrXGDnnmKS6Hdlncp27tCd8fanL96bmDKUv4dWksorTAJB5Q==
X-Received: by 2002:a05:600c:3107:b0:426:6710:223c with SMTP id 5b1f17b1804b1-42f85ab64b4mr89013015e9.9.1728291414439;
        Mon, 07 Oct 2024 01:56:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0aa6csm85436205e9.10.2024.10.07.01.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:56:54 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Use atomic64_inc_return() in trace_clock_counter()
Date: Mon,  7 Oct 2024 10:56:28 +0200
Message-ID: <20241007085651.48544-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/trace/trace_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_clock.c b/kernel/trace/trace_clock.c
index 4702efb00ff2..4cb2ebc439be 100644
--- a/kernel/trace/trace_clock.c
+++ b/kernel/trace/trace_clock.c
@@ -154,5 +154,5 @@ static atomic64_t trace_counter;
  */
 u64 notrace trace_clock_counter(void)
 {
-	return atomic64_add_return(1, &trace_counter);
+	return atomic64_inc_return(&trace_counter);
 }
-- 
2.46.2

