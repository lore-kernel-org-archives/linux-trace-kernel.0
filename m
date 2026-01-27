Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D8929BDA2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502626; cv=none; b=MILo/mWCDYsxXfThLqQM/td4pNCGR+D1f+SYTBGkNC4kIXvARZT1dSFBvxZKJZpE7eQ0T8AxRuv5CKXZnIAgTs9ytVqZo4QHtt47ZxPwN63A+JtH6Yh+v7FhzVSb2tL1xaC6TmVqvM286JLO625VDP3eBmgoBz5u1G3nAjEaMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502626; c=relaxed/simple;
	bh=hwBaBoD9OSacw4NnzL4jIYitbGlgLVKwETo1gtKVJMY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M4TPbbQ4RetIx/IHzRFKhG+8yFDVRUbZLOoA3acbziuBmOk7UFfPg7ZTasT+hz8ooGprYSU/61y5Y6fU56dabNgQx48BSs/RmTlfE62efPruW4mMqXwOoj6t/1+XXHK4EgqJuFy10sKSCtrtuurJRyATPrntsruIPLN5xZww+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0sa3Y7m3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0sa3Y7m3"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47edc79ff28so33670355e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 00:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769502623; x=1770107423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/QInygNzsk4saCgmIsdJYB7YPnJtRMIU+9UtY5fzvQw=;
        b=0sa3Y7m3HNGsr7fkVSDpnkJNBj4lh52Ggl2RpEHmdnL/RWRjiLD34qNxbzfCdUPc1f
         jnRs0FfB6QvBsztXJWZT0oFjfctCJQYF/Qq8/Gs53lE0oWRq4DTuqHNVZx2uFapqOVuo
         DSoPVlGWPZYBFcEmLpHqqT8Ogr7FmVcqicxDKGtr2FKQ3rq53t92ZnIR8jGQSIaPrKmt
         4BECzhox9+Vrwb0VcadUGTCpRnl05LTp6bFoICe+0TPUAiSwFEgxXW8OYeK8j5JgDfIh
         hbUO4jqCDr+bCs4HEm+yMQqwGHfw/Sw+R3IYjUq7DkMGXOjVVFoM445HcprCYIOMYGYj
         dW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502623; x=1770107423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QInygNzsk4saCgmIsdJYB7YPnJtRMIU+9UtY5fzvQw=;
        b=rfDTyXJAR05ezmDEgoZCVmbBnkkQqwfeAWqqAquhAiV9BEZwx9J6EMS45fxcdB46gk
         4fipeQzDlxAqodTcQAIjSDF1jG4t7iI33XkNoTlDKJlh3azN+PYzD2+E1ztYt4+x+8V9
         /blzUlisl50YJe9tuj2wYuk+qlg9Xfi99hlpa0Xx4KSmYxcf5G8Ifv2Xx/R32rWPtHJf
         xiL2Ou9JzdLqjHXTxndzt2hzjJ2L+eyTe1zP3+HwLjKcHXBQioDlrKXZGGiJqnPPBYiO
         PUWgEul0QImgxDmfr1LGqKUbdEH7EY3eMTtMonihnhvpM0WwBshhrTg6zLti5A4O9Dnj
         LbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUEqpQSf9dE5xGJsJLGdHj3oVjebm2rlCZpmOHQExCbMelDqOWHlFdqfXKDwyP5Zz6eMchTMGqMs9tmUa7N5+t5TIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPc9qcPv8hjhSmmXuBIp6XxGfnbmsu2DprkLWr9rQkKoHcJuV
	5M8ueb/isy4kg7DODbsM8PJOxPvVyIDVOa6ddzFIMvfleH0qp4sQwmfWEiUB0w79qQPXUjyNbHa
	AV/hWZu3bVC6SCcri1Q==
X-Received: from wmo16.prod.google.com ([2002:a05:600c:2310:b0:477:9654:b44c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b24:b0:480:4c20:6a06 with SMTP id 5b1f17b1804b1-48069c486a7mr11321405e9.17.1769502622747;
 Tue, 27 Jan 2026 00:30:22 -0800 (PST)
Date: Tue, 27 Jan 2026 08:30:01 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIh3eGkC/42NSw6CQBAFr0J6bZueljjiynsYFnwaaAMMmQGiI
 dzdkRO4eIt6i6oNgniVAPdkAy+rBnVjBD4lUHXF2ApqHRmY+EqGLL6WYcK+KKVHv4QZh0LHOU5
 8QGMppSxjsXUJ0TB5afR92J955E7D7PzniK3m9/7nXQ0atMQlXdIbNyyP1rm2l3PlBsj3ff8CB qg0OscAAAA=
X-Change-Id: 20260107-jump-label-rust-maintainers-17040992e7db
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hwBaBoD9OSacw4NnzL4jIYitbGlgLVKwETo1gtKVJMY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpeHeWER77Zri73/W6N/5KgdP27HFRlfQCAO16s
 zvIVuK/Gj+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaXh3lgAKCRAEWL7uWMY5
 RmNfEACK/KILBMeokBf3bUhZoyAQxazhasStI0fs4LHhWp87r++jsgfqmVhaQmrs3rR9wjz4ZNV
 kn3Ww2ivOrm+i7sHtgRVgsNqALiVrQ+XX/Zqbo5ftGFsvBhYKHDaHuVAn+hva8mD3dvnVl4u8p4
 gXX36HcKmbxYoRqZsM3Y9+yFDQMaCElJ8vQPmW+CTD/6QDMn6gMJ2Vo3uwmeLtg91kGC2UfjucG
 3o4U+YfUIZmds4701Cs43jb+ccqcuFhYq4+UHJfI8rOgJ4WuGDSxD+9kfaWp4lD1rvZy1L4adlj
 PNm5OPg1pcPsOzuW1YZCkmRqUQ+1MVVXUGSjziNBryyAbHoU3w5F+oKrFkQ3Ik4u5929Nxlfyuo
 gAHV7KFkWucVU+ku7Cnww7QM01tuC2Wxeq11yntS6w7of6jaugCHxEXKSXK8k1KCdYeov7rtmo0
 OqeV8B9COkcglj28oHd60djn0qI8MH7mCopVBTobsFdWrvpg6RQC9SeeSuWy8TPfr7TXOAifvpP
 m3uDU1LFNIMM2atvSbFX4Nu1UXFOjighhGJ9MrURq5/ANeOo6bOkLGtKmuVlIEHrMrkpz4Sp7lC
 umC7jQMgcGMYR0P8PLalR5EE50hG2FdEzW9xZlPnuJWm7loTkKiiOaRb2RYtBIEelG7gfXkfciy AzAKVkEy1dCxWgQ==
X-Mailer: b4 0.14.2
Message-ID: <20260127-jump-label-rust-maintainers-v2-1-11b7c30b11d9@google.com>
Subject: [PATCH v2] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

I realized that these files were never listed in MAINTAINERS when they
were added in commit ad37bcd965fd ("rust: add tracepoint support").

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Based on v6.19-rc1.
---
Changes in v2:
- Adjust MAINTAINERS entries as per discussion on v1.
- Link to v1: https://lore.kernel.org/r/20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..d1bc1bd7584896c78e517f80194d5de6828298cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25006,6 +25006,7 @@ STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Jason Baron <jbaron@akamai.com>
+M:	Alice Ryhl <aliceryhl@google.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
 S:	Supported
@@ -25017,6 +25018,9 @@ F:	include/linux/jump_label*.h
 F:	include/linux/static_call*.h
 F:	kernel/jump_label.c
 F:	kernel/static_call*.c
+F:	rust/helpers/jump_label.c
+F:	rust/kernel/generated_arch_static_branch_asm.rs.S
+F:	rust/kernel/jump_label.rs
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
@@ -26474,6 +26478,17 @@ F:	scripts/tracing/
 F:	scripts/tracepoint-update.c
 F:	tools/testing/selftests/ftrace/
 
+TRACING [RUST]
+M:	Alice Ryhl <aliceryhl@google.com>
+M:	Steven Rostedt <rostedt@goodmis.org>
+R:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+L:	linux-trace-kernel@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	rust/kernel/tracepoint.rs
+
 TRACING MMIO ACCESSES (MMIOTRACE)
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260107-jump-label-rust-maintainers-17040992e7db

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

