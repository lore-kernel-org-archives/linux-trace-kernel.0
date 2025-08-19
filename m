Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432925F984;
	Tue, 19 Aug 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593451; cv=none; b=rbFuVq/uWXOjRkMgg8T/+TgPKjg/3atse604jUPHd8vcjpNsYR9oS/TIxoHkfds9Sl3m3ipwU2azWVRVDtYJu+ChbCy3VPv9vsRrGA3+r6KZxA0GfI2qHm5IRfzF6RoDxr9LJ0EY6WOblPOUXd0tCDVYXuKVIC0BvvlfEhAopfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593451; c=relaxed/simple;
	bh=DmkDwkjEVAiC0sDkPJg0pXkSVSJZJEeVV+GgiVYdIbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Szjti7i5PdMK/10JyzB2xR0VGwzAE8KJM0dHtzhvfkpuoORBLJtAcnx2mznYGvzNZ6HIGDrxLDTqgWdsFo6a4tUiR34SA70k2qT/fwg/YI+30zS/yOQxuLN2mti7IiOjHQHaRt1lPc1ZTABORAgRLx8P+K3Qx2z2IXDSzep6OKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhYwlSJp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhYwlSJp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9d41c3a44so832123f8f.0;
        Tue, 19 Aug 2025 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755593448; x=1756198248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppSRiVRqts44ynE+tjD/tC5x7x1c70mZiRK8wzwb5ZI=;
        b=LhYwlSJp+qoRvwlzwNlfvqCskLjNDC/WraisArVBWecNS3lhkCrUfTSSAqSHthDV7+
         MO4l2IuAQoBoseLiOobmSoXDn7i2kma0KLA+uFSxvK3c6QhsctRpnu9dEav7lVCOoUfh
         Qg/dhjM2Lmc49MFGlvMJ1zw7JnaX9qJREdAIguI3DpEujpB01FmhwKATlFzBGzrpxVx3
         uGS8qARbV9r8uSqo7i6T2S0UX1E9UEeXjW6Zpwgqmx6Y6Z1eOjteXnlT5uXSUmR0B7Ra
         d3VgMiRaBzFYTkYSsh3wAaw3bIrk2QYYhMDeprlptl+zXUhmzYf8O3Jt7VItU3ET8KOL
         /V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593448; x=1756198248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppSRiVRqts44ynE+tjD/tC5x7x1c70mZiRK8wzwb5ZI=;
        b=vF+68SnDn6HvSVgxGkNmEqyAPH67W7ZB12FgupXa/sVLvrEbyGbrKe9sNlfv9ru5n2
         tLxTtJvK8y1+rP3IjubZYoLLU4AJJgZmtA9PWe7X0OvkLOPcw6UiA1S03w4YXleGnw2b
         rjW77OcieBoOU6+tj+LztPWKNn1GV1nD9o/bVvC4YUYzqnjDsjaxcLCta7GVFUkTQ5QW
         tA8AuRnfC9UyunC2Hwi0iQYX6y9t3LssZvZXkxyBGgfJE6DUIJNFYlMJviU0xKcMuURz
         5OUr/nPyvfWL/o97N/Cbt9GvJb7Qqh99ycHbm5X+RFA8WO/3etagUwbQr512wrzy1jN7
         0cbg==
X-Forwarded-Encrypted: i=1; AJvYcCXM2DsWZoTHmRxST5cuSXJwiibHw0THSPdNz4YpGo+pdXhnQpzoLajqcDxF5wG9AMeWg+i4SffpWxpgYnUJ9+wLcqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZbjFeeA9bx4izOpTrpFnW361oGaI92B4KBnJtfGSTXynM9OvK
	D16gZGuRlNg33Ms1uIApf9aOresJWT9H0fv1nGULu39yQKbAtt3Fr4DL8tUe/XET
X-Gm-Gg: ASbGnctqyHn3SXKoZF1i3fJJDi/8pzeiXGqv5Zt7x0sdIHZfTcaiaVApvi4vlhxi21V
	B+8n+VFVt19dAHOVHIVd3mzTq2vn+0/d4doZSMocoBnuuIa5HpJhwp6C/LuKOf9ezY7i8y6Mxmq
	Em38DyT5Ndo8LASKKSVFYKXLdgqniO1/DGfxw1Q9BkCuDiDxI/IqBo6BX/hQH0RAJmPfzCUmpef
	q1ptnBPHgUMuZuOA1TrL+XEdtuFITs0SX3vxWlt6skgOByJe4lMs7C+JOyM3Y79hHWvcUHFs+7b
	oL9AfuoMzgdPRvBRisZO8FYR0rm522Dp0H3i3fgJE12L8J4SOHs+a/oUiQusTxciTB225/3Up3h
	d3zDSOJA4eLCwlwZVGD0wlDtK3w==
X-Google-Smtp-Source: AGHT+IENAMM40Jw4dEcSYO2Fhf9hmnZy96HLWA+f1XfiP1n2rwpiM7hAlE/XZF/W177VE+ht2KtknA==
X-Received: by 2002:a05:600c:821b:b0:458:a753:f3a1 with SMTP id 5b1f17b1804b1-45b4425f28bmr5609455e9.3.1755593447660;
        Tue, 19 Aug 2025 01:50:47 -0700 (PDT)
Received: from bhk ([41.231.66.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a983f7sm33587315e9.24.2025.08.19.01.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:50:47 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] docs: Corrected typo in trace/events
Date: Tue, 19 Aug 2025 09:49:00 +0100
Message-ID: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Changed 'Dyamically' to 'Dynamically' in trace/events.rst

under sections 7.1 and 7.3

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 Documentation/trace/events.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 2d88a2acacc0..18d112963dec 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -629,8 +629,8 @@ following:
   - tracing synthetic events from in-kernel code
   - the low-level "dynevent_cmd" API
 
-7.1 Dyamically creating synthetic event definitions
----------------------------------------------------
+7.1 Dynamically creating synthetic event definitions
+----------------------------------------------------
 
 There are a couple ways to create a new synthetic event from a kernel
 module or other kernel code.
@@ -944,8 +944,8 @@ Note that synth_event_trace_end() must be called at the end regardless
 of whether any of the add calls failed (say due to a bad field name
 being passed in).
 
-7.3 Dyamically creating kprobe and kretprobe event definitions
---------------------------------------------------------------
+7.3 Dynamically creating kprobe and kretprobe event definitions
+---------------------------------------------------------------
 
 To create a kprobe or kretprobe trace event from kernel code, the
 kprobe_event_gen_cmd_start() or kretprobe_event_gen_cmd_start()
-- 
2.50.1

