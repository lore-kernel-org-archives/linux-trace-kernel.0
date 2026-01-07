Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91481314D13
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788582; cv=none; b=K1iyDfzH+HkUdRMJw1imcCnYlPT3zDhRerLhzoWldxslQ2XobEXZdgcQJzyq18FqpgbzmovwyRFHU+/7fN1z2jvj5l53DRSv8iRzMpUkMFHeMjfmNk711Mnh11Re+KaYXzpu3PeXop8HwsQC/lEQwmh1DemVhkk4krArj4MD9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788582; c=relaxed/simple;
	bh=ldznM2VFkJHtjo6dOdJXJZFjWo96wSvSHo0WgO2i9RU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dJ+DxxEG0KVlV2n+HXeRbmeRXy3ZCx6gqAVZK3KDY5G+lvq34N+4zb2i/gUHz82zFDJCL3koy+w131MPuPAX4V063MZHVgCTtZt/T1kmQ/qLPS5k4vmTL02JH1J8pEIbjb4qu4TmW2nejn73wjTPzJDmN+HFLp6Mz3M9EBOPYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0kGr0r4c; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kGr0r4c"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso22944215e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 04:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767788579; x=1768393379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zJouJeDS0QkHiQfTNtIoyh+wTKtfWBn+hoMdv0mRUlY=;
        b=0kGr0r4cGkg8hfq8qsKjBdhmc5pCPQy7sERYtq0MHtvgikvlHdu/QV90GNLjnobH7D
         GvsVqeAEDMcwi4w3nIXOjB23fpCiQsGHxNm4mLuD0saa/UXc6DuVLUUYIsuY/xXBvGsH
         4cgfsHhklM7yfAgMX6VBfKoYwePsBY1I/3vfhuPD9rQIoioXVJdNtEqLilPRXYHniHrR
         g+9EvUal143I/u9vtTgI0Dj4Dg6iRoglIfkKs3UW5AAOQNAKbZU5xovfNz98QsGkbcLC
         ER+cfh7ULK2b+Au9xUfOA6kWsakm9tzdI/IeFDXgedEN4xim6T0jshOv8viRxdOY8rDz
         Aj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788579; x=1768393379;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJouJeDS0QkHiQfTNtIoyh+wTKtfWBn+hoMdv0mRUlY=;
        b=qtJeAn6TeyMrKz/fiFeEB8wVXm3BlyiuoENazSdhkX+iZWqFRvyr8Dq/2lgQMv3se3
         JggsC4MKOWt+r2XO1b+3GVJqGD6cBhNDySnTsLW0gfV2Y/QhE4HX+AD+mg9WCetd17gl
         NcG+8BmMNYXZwcu3HjsxhTfqorS7SDkJaFuqyUBJtcSghj+j3t3BkpDYyAs88ZtfAAs2
         tf0R6Sq+O85dETbUwo3RSOdxTwN1PztRiF5u2+RHYPgtkogNUNgnMIqza/WMIB33pOPu
         SJXAnxEZg+EmtfpyPHKmaoxTK3CfdSrF/bVq/6+uBotAeVe+PJX4NiCkwGxrxAjNzynH
         8dmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEbA0tA4SYxhiTkSFgj4h/lfYCJ/ffQ2QBDF6nS7zPaM0vuyv+v1gDS6yqHwPVKJd3K1BQ6zp4IE+qkVqqvhBY5XM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9QWN4ylTh1Q3/Kawj4eXWIUOwTlhqTKyEvx5F1labzFCaLdA
	Alh0z3hN20FxR270smq8asM7ybG16OSS16Lbtj2fmVqMqh5Fo4jmZsDaHqPSlfA3+GrpqBScTfs
	pUbPikCCVqlYXNyHa5w==
X-Google-Smtp-Source: AGHT+IGd72TAvN52ZdOcLv5w5NFynTZ6/3FbD1p1RmwNMK1B3tXDzrlLFoNK1CQAj2A8DAY2TV7PI7tFtQAmVhU=
X-Received: from wmbh26.prod.google.com ([2002:a05:600c:a11a:b0:477:103e:8e30])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c7:b0:479:3a86:dc1c with SMTP id 5b1f17b1804b1-47d84b52e31mr25359035e9.36.1767788579088;
 Wed, 07 Jan 2026 04:22:59 -0800 (PST)
Date: Wed, 07 Jan 2026 12:22:50 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABpQXmkC/x3MwQqDMAyA4VeRnBdIi1j0VcYOVbMtop0kVgTx3
 S07/Ifv8p9grMIGXXWC8i4mv1TgHhUM35g+jDIWgyffkKOAU15WnGPPM2q2DZcoaSuxGrpANbW t5zD2UA6r8luO//35uq4bqAWVmG0AAAA=
X-Change-Id: 20260107-jump-label-rust-maintainers-17040992e7db
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ldznM2VFkJHtjo6dOdJXJZFjWo96wSvSHo0WgO2i9RU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpXlAd25HnrIno8iw6ydeeNq7fNAf/kHfCp7llW
 fa7bTYj5JKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaV5QHQAKCRAEWL7uWMY5
 RqplD/0S3XKDvD8RMX/E5ztwpVoFj9YV7M33OhWMIoUQ5IeMDP7kIslAN75YnLnvRVdNZ/e44bD
 DVk/1wpVh8DMr1b/YAqqiK9lbOHMCEU4egBa/1OAmr1eX51kbVsDB1Z8VUz3zqaiHvXiRC9iu7m
 zkdprMm+RLdFT+bt8r9i9tnYvzfVUo/g7pe+5g0lzdVXLMqG2ahzjKBuwtTLTC815AfUP7Y2Vpf
 CkNiETbOJBaMajeiCjZ+7IJBAb4XRpp5C6nQzk1sW28IAJXZHv8IMCbpxcF5tE4u47ssYQKj680
 I4B56RYmA8Y078/WA9Y3vt6lTDg+xQGX5BmGzJA5BN5iCag2Nz9P/7jWVUilZuAPpI/azLoSV4d
 vZECin7DI1Y6n4AUBCod5rLBDPH/8FL4r8xl6q4VXJajzlpfiSXoniDMq0rmrVmRNJv0vR51C6N
 P4ZD275d/LJ65k2ppNwc96kXrAoqRNKyboNno2s6oob0w4a2hxAfyqflPHBDHzPb0qGVpFm2fik
 R+rnFZ+Zi5nkRt/jHzzdQ8HGcuowhCYuR1xtWemxgHcQNVtJzywJAPaiWk0+hC9H2x6wTO0cj0A
 wcCXrgzbtTkq0StYW0AFfQ3O4wZ3X171gFu7tNZtoi7pvUHXCyiP2/cQ23SHkc3nuLKSN+5zToB 6W8SjamGR02mnGA==
X-Mailer: b4 0.14.2
Message-ID: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
Subject: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I realized that these files were never listed in MAINTAINERS when they
were added in commit ad37bcd965fd ("rust: add tracepoint support").

I'm proposing to include them under the existing entries, as that seems
like the most obvious place to include them. However, there are multiple
ways to do this. If you prefer to have them elsewhere, I would also be
happy to create a new entry with me as maintaining them, or I'm also
willing to be listed as R: under the entry. Regardless of how we list
them in MAINTAINERS, I will be around if anything comes up. Let me know
what you all prefer.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Based on v6.19-rc1.

I noticed it due to this patch:
https://patch.msgid.link/20260105-define-rust-helper-v2-9-51da5f454a67@google.com
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..14eafd3fb428483cfd3f0a86f52d0c62ba7436e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25017,6 +25017,9 @@ F:	include/linux/jump_label*.h
 F:	include/linux/static_call*.h
 F:	kernel/jump_label.c
 F:	kernel/static_call*.c
+F:	rust/helpers/jump_label.c
+F:	rust/kernel/generated_arch_static_branch_asm.rs.S
+F:	rust/kernel/jump_label.rs
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
@@ -26470,6 +26473,7 @@ F:	include/linux/trace*.h
 F:	include/trace/
 F:	kernel/trace/
 F:	kernel/tracepoint.c
+F:	rust/kernel/tracepoint.rs
 F:	scripts/tracing/
 F:	scripts/tracepoint-update.c
 F:	tools/testing/selftests/ftrace/

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260107-jump-label-rust-maintainers-17040992e7db

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

