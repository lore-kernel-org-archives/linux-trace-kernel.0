Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F33921ED
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131405; cv=none; b=gCausBhf1JlglzIYovdChewcHLEQtY1vSJmfvijrOVqwV+j/A9JjCjD5cc2daDnKUxZ3VX2TjscDpOPmQPT3YQKCGFLXbYJEUoYsYLc8xlI+xMlxFrpKBBRcfEclF3LSQfNKTQv9NmsorRM2E0WFMthqo0Vls0ggq2zoVGx4coQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131405; c=relaxed/simple;
	bh=sRH0ha2EZ153ajq54eM0Yi85dNlM+hFCBKuV5K/D0/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5Cae5aEopfMs/kBXrWBH+thGwP1GJJYDJYsy8e5gFzMToIfABxcNzHo8xBlPyAc46XOafBAl7jSP2J1FI8hiNgnephBhq1jNG7g+vyTEkOqXCAmJPtemoADBg18qx8LQ2jKcMWDHROp1Jn/FjkgSITCAKBsi4aqJSyBtixQ8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj/TK+CH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj/TK+CH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so48062845e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131402; x=1792736202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=haJU0ShvAO1LQDIvBwK5BiMB17AU7LxjM0Mr3FtXsAw=;
        b=cj/TK+CHWG6KFcmymsS6BeXkwJ2UsIkY1V/npmXtcHN+DQVISft2xO2Gwwu0m9kikL
         NptuJtZIkc7eLt3FaylMwDc0DxFgc1QQqsiaU8H9mO918fKDSLkx8JGhi6QqfDeVDQR2
         gHSJRW3EWz0hIYsI4wT+D8RCPQG2aq0W2FwJHhhZeNPB+gwM0307TdsOpYQHeE1/byDh
         k9yWu8X3wD3aw9oQL1sVSeS7lTPohobIu2sRVY6ZVjf/8KXAhRUAeR7YTmYf4QKb12AK
         qMTcP8sghXXmNEjv6AIXxVSbSr5Ap3ocxdG+QHwPRmpuMowzqqa5ibGCAP2iespk8/Dn
         Y1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131402; x=1792736202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=haJU0ShvAO1LQDIvBwK5BiMB17AU7LxjM0Mr3FtXsAw=;
        b=g5th+/mkSgO+OWGHkEjAhJEkFmXl2sLsHjkwClj8BxkSzNyumtus97k9a1NAXesFeZ
         NR/r+1BkF0fZ2+8Jl2kyeImuXYm8Gv24HzOwAwsny7BQAqCFg1u8wpEOPmVsS8CUEK6l
         uH7jYz4qryUf6E76+1QI4FoQRnIlbW4eM+U7TC0S5RDjUfALz7v3Qve9d6BlYCNweSlB
         1RmwmP7I+DMgGe7RL95P9iIVRqDpBaEo0gMnM1opS55Vebh+f8dU3pKn3OgunzxdbAdS
         5CAkBKZGXGQqLQDLk5LvoRJVUPFmIV6aA6WMNmwWO08hNQMc7IaVfSXFSn73om4Wh2St
         sQWw==
X-Forwarded-Encrypted: i=1; AKwUvBxD1ZnjetkImFOVtLALWs9CBVuVRofPkRGEjw3KWGAUb+MY6pE2D5BlF2ws0+FblKndG0EhqrajVNOop3V7lMSLdN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWCJ7h5uLQh2HvS20YNinZ+Gt24cURnoDYcgYDoCNF/iD7M+20
	1Kg7p/cgXi+kly7hzQGQx6y4GKSltznhVmmeeAW5eO23aqHKNYvbxWOq
X-Gm-Gg: AYBFou2iH8VgNyUzaesbEM1J7rm3yN5WgMf4iyneg972L4alSTrOxa5VEoDDIEQNDn+
	8l/ygkzOpe+bG9Qm8BDBexcUvzn7iiaKNVFRgnSZimL7x9XhoqLl+20i8kN4bT8Er1rOBQieB/J
	Ri0Ukjcm368U8hUJ3Yi8kXINxfOCujzHlWHahVWl5OFKiIn3W7D8UgQOBYgEJ92kYmbtZw0DxRn
	jPS/GSswPeSt5P5wgYQfPvAZOhURFWb7KorKqHVb9tpWY15JGlpPtYzOlmHJ+igdZEClZvtuj30
	bKyHYpd2MQC8d39D2iZxfHDh7tu8/oyu8WU7dhKczHq8IL08/74osg7wplVgEjWVwNP1uOz/9Hx
	CET28pyr87yiY0LqTiS1Ul5PSOdHIo75nIZZLC7GtRfqjeS2Yi3Ny5mS+/fEAwVsWU/yk3D/0mO
	65jaZWgOE10/s73/flxQpkQHx4jHe871anworih6q8AUBSEJAwgsF5jNs1rb5zfPQZoJ3aV9+52
	CO/f3qeShqRI6fJLBesN4VW9Q5pKsmyANudl5s470I3qjntyX4g/tldpnM=
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr454717125e9.16.1792131401674;
        Thu, 15 Oct 2026 23:16:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8abfae7sm14985945e9.0.2026.10.15.23.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:41 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] tracing: Hold trace_types_lock when updating modules in persistent instances
Date: Fri, 16 Oct 2026 07:16:34 +0100
Message-ID: <20261016061638.214847-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_module_record() walks ftrace_trace_arrays from the module notifier
without trace_types_lock. A concurrent rmdir of an instance removes it
from the list and frees it under that lock, so a module load or unload
can walk into a freed trace_array.

Fixes: 5f3719f697c3 ("tracing: Update modules to persistent instances when loaded")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..d3ffbed9c44b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9247,6 +9247,8 @@ static void trace_module_record(struct module *mod, bool add)
 	struct trace_array *tr;
 	unsigned long flags;
 
+	guard(mutex)(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-- 
2.55.0

