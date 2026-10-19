Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443238;
	b=l7Ha/Q2dA02UaLq7uJDHuL9O0dHTcVZe825w+jZ0+wDbHzfOnN1M6cpgQhFbHNgaUrEY
	 b4E6jtQXEDv0RvbFxm61DaIPrJWCFqXlI0TGhzlZ+stvtM1ACyj+11Zin0i1O62ghPkCi
	 p7PVpiloVdeZ0eoroKnIkUHTQgqTfDO/QSJmmHEyQPu97OSgIK2QJeCVTh5kT+EO87J/p
	 tbGxOlADjBB67OsM9pAi2Sw5tdU//DaFprLyzXLOektTD0ilbwx6x+hj/H/wIajxa5jAU
	 Ix6rtu6aAvCnOwD7c+cFN1SYpx2bHlpPvFMorVIuKNjvOjlekTfnyxNQZOLjz4CFsUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3UMhWt/QgHcRUjdVi8h4jSpXWub0rW3/KKBGP3rs/38=;
	b=iHau2ND4LcZq+P+3nUGhhkXbtd8qS0RbKEWgbCsAv+nFlZYgPu00gMD4MZ28MMnCoLvq
	 0CXHdccn7jkbwmD/V80y3FZcUoj6rzuNgMGmXFmEZkucj4IMJoOl/6kcp4jJGynqVP7Ec
	 rPckqRRJw0hLPBzbnHO1ZvZ89Yggh25oxW4mR8/PDvt4ZX4jL6JxiclAzuzcNDFudpZzp
	 xE4apimdvWlI5MMaHiF/GNZJTXsMaDE2fpeO72jv5YTEl2uAN2foQaODRAvmCQB/v8wA3
	 GYHCO5J6qTB5QPv06Q31K1wvqgOv57OaUvZhlhRjvTc+hbM9MrbNDDfycUYgarMFzxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j5SOb35K;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B54606A319
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B54606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j5SOb35K
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so11305675e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792443237; x=1793048037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UMhWt/QgHcRUjdVi8h4jSpXWub0rW3/KKBGP3rs/38=;
        b=j5SOb35KARZVJSFGINw9xaj3iZQ8pT6spC7uG30JyP8l0DG6nUVnB+YaPOdfNwIy25
         fX8WkuTQGswi5uSTok68RdXwSjGdVlgnhSKMkihiLHgYCKPSN8i312E+NYxEHV9NgX+W
         ynsIF/bRR2HP7XEdnX+M69QhdRVffcZoihOFrpVZol5rMY6rlBnaw3zUUvNrUYwzIeiy
         SNgZS+qKPRLME13PklrZ/MDBusy25ZKdxDQkYYfbzhS1yV3vc9G20y1x/AYuq5tmrmLX
         Nw02FmmmP4N2thWZqS0WWdhI4xRAzsMEd5a5CSNfcLb7AQ/SkKC3vvlKl47bnhH0CQtM
         p7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443237; x=1793048037;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3UMhWt/QgHcRUjdVi8h4jSpXWub0rW3/KKBGP3rs/38=;
        b=K9E2HwF327dqJ6NeSFiGilX7BOSVfyTGgzj2dDIAIDOay+0P0VVHzicnBzJ6ILfrp4
         tvWghWvyRroWrRdkDHLlmRdo0aYXaj0nTdEIDiwN15MhoHO7Kr20Pa0NUe/wjP3vLgBH
         /axQGMQ3O8HIdmGLH+7OWwKKBW+TUitjxBWNoMI9Xu8pKU3IvwBSW79BLPZQ6KQnHhSE
         q3HRF1y3urKI3+EaDFKjdfVnro9ZMU0Y9uTCeDx+ec4j3yuz7qQ9K7Tl5AjaGOnwCIqB
         IavbxKfoH8UX4srve+jtXB2RpbdAADcSTBH9L9cDABn+t0ZHSJvyGRW/HaRLhBaUbql2
         P29w==
X-Forwarded-Encrypted: i=1; AKwUvBxIYtJKh3cdLDeSdcgNxXbDClHoTTQ06VQpBk0EbOvP/3OBZQOStyHgzf3KqqJH45BAtNfUnfWeFe7draR71gxbcBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOLJuigvdKPkb8wNL0legvhk8b9RFVIZOC9jrgk+b90ne3jqGv
	ewSEeDppMY4UjVh7p6eIYMKqvrdHHs46ORLJdw/hXlArEL+Ced4b9O6o
X-Gm-Gg: AYBFou0EYSyl86Hr0rUAPjnR/xtxDKNdidWCXjH922wL205M3rqrC/gHmTtBAIFY0MV
	PCBB34CPHDiQQ4Rg2GQSf9ehJ8HmPcE4L7nWZEM3QwCfk367wtQKtAo4b1nMSVE2gyS9CG6l39N
	twVP1dFOGCwAxj/1vvj8FjK2GQXwpjRLq/0ywF9Gz+0sRB2S/LKNT72qc0B39OO2vDQf92YyoJE
	DpN5tX+TlBwiFD1ZZY436c8AYGDfANk/eIXnjecrNB2OmjV531rmPjXh441j3xnl65KiV7Tfx/F
	X/MuZkw3SUmAEbVgWEul5A5wK7xbDtRICMJsIDCmD/KY0KCg0uIHXkMBJRhAnhdT72MsYYDMXt4
	LwYPmyC54JLjYoAM32CxgQ51WoXJXvcJCeIePOnEuwmohQO3faEKgIUe26Yuh/kRM5ygOLfRCwC
	5YSHe+mStC6aaXVzIWrLTSqXCd5XojZoK+w9CAbAAPwGRifif5emT9X41JDqvD/maPEDCv4n2I8
	+Q7+uhfKu8=
X-Received: by 2002:a05:600c:870f:b0:4a1:f57c:381d with SMTP id 5b1f17b1804b1-4a1f57c3996mr3875215e9.5.1792443236710;
        Mon, 19 Oct 2026 13:53:56 -0700 (PDT)
Received: from ADRIAN-PC.lan ([171.22.87.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f3833f93sm6406175e9.3.2026.10.19.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:53:55 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH] tracing/osnoise: Add __printf attribute to osnoise_print()
Date: Mon, 19 Oct 2026 22:53:44 +0200
Message-Id: <20261019205344.190022-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building kernel/trace/trace_osnoise.o with W=1 triggers the following
compiler warning:

  kernel/trace/trace_osnoise.c:96:17: warning: function 'osnoise_print'
  might be a candidate for 'gnu_printf' format attribute
  [-Wsuggest-attribute=format]

osnoise_print() forwards its format string and va_list arguments to
trace_array_vprintk(), which is annotated with __printf(3, 0).

Add the __printf(1, 2) attribute to osnoise_print() to silence the W=1
warning and enable compile-time format string checking for its callers.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 kernel/trace/trace_osnoise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 0e1265acd1..995da9e0b5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -83,6 +83,7 @@ struct osnoise_instance {
 
 static struct list_head osnoise_instances;
 
+__printf(1, 2)
 static void osnoise_print(const char *fmt, ...)
 {
 	struct osnoise_instance *inst;
-- 
2.39.5

