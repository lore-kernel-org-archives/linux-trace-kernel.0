Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09181381EBD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410538; cv=none; b=KzAUM4FLdbVZszg5RZE/9CouMdGX2u51bIsdqagzNfO2VH8Hu+kXWYnTcPXfc3qK3MpbZkxx+/NmrX5tRB7cK5KRZq3xOBBt5kH2RBKFpzwPeaJMMagxMJ/S9ZZweubMokwGdusd3V4gjdSrXACyvybjssGpgNueBXbLmqjyboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410538; c=relaxed/simple;
	bh=Pwu/0Cot70c9cl/FQ0qDdWdGr0VR3q3j9hvKe2dSMUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIaqX9qcp8/Jd1UCi8tggMvCrOK+98Z3LNpqg3JOYaRh0BSjclhqtPbqa8A9/xNKenPK6biWlyg09idqH/m5+j0d2rTdpDWfFt7bAeX6t6jlw6012rtVuMcScTmSKUJZncN1QOui2bKSXZis6l6Ee2C3gQQJUj2dn+dFVrPAN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tIfOgnJy; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIfOgnJy"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so399320966b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789410535; x=1790015335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzAQVlxc3SiItgqPCAg4pRFm0RhGbGZG5JH2sIt5XL4=;
        b=tIfOgnJyAl/VbEUJeidi5elXy9sxivmH9fqWsr9PJtIClxDujdC6IYllYnY8dPG+3u
         NJ2U5ONAAcD+UFOMvbBlQMFCpTIwYxZ9/WKXlcCwoJGNssKfGmLCb7TJFv8gbFYx0uJ3
         8lH0jVe87JkzHmxvUTWPAfBr6ryLvBi+6QsSgfWY9K6a3O1wAJXNE/NgJf+ZHoeD7/Pn
         E8ef59hAGUTDGF+v3XgbeudtLM+dVPsnDnz8pjR1OQvyiPWek7l9bDtoRsVaQ1NUuEFH
         Vwdyw14+1i3gfyVuOZRU6nPPDcpoFHh0FKgdTjegktLhCZrXlWkY3N5uibhR61CeI/tU
         gVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789410535; x=1790015335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzAQVlxc3SiItgqPCAg4pRFm0RhGbGZG5JH2sIt5XL4=;
        b=tahCs6aTKm4kOJinXgya3OC5apHARc6BIsJQk0pTFl2SP+TOAxxb51rhdkXSQWG077
         Sy4485UGb5AEF5xpH/8l5o2TS+wq59mG3H8qMgBm5aUgOoT4oTwHdyFM2YFQygkm+dZ9
         m+aKAYIHDn/XpiaAnlH/2FSnxfY8574wJKJD1b+64Mr0gNhdGVT74pjbDJ3d5TNxT9Ez
         EiVLVzWoodiBCoInRoJ8v1KH/iqG4O4qIlfsGG2XmmPWRxS7hJ6AkaF8i2eFLPgeBwhj
         yVn8cDYxwkX7Omaatw3qVIEWQJ+T29/+FnmzF52UGtweB1FyLGNwaHQkFT5gAHUiPph0
         K1HA==
X-Forwarded-Encrypted: i=1; AKwUvBxay+thNfWaKOrlLfwLNAxcZeoYhOKmzxzjBkiZjSXkT+Rcd/AeF9dqBkk/4NQzyJxa8aiktoiueYjtATRATjJvDWU=@vger.kernel.org
X-Gm-Message-State: AFuF++nEA5v8uug9D0wCjY9cBktT8c2ojEHmEgrtRAUNsIlP5wPRvXtE
	tlYevlPLnYC1rRku50rwGP2ruIZ9qeGfiDsVtJwnY4Q/6SQ6NJWFwbq6
X-Gm-Gg: AYBFou10AFTa5z3BHhkGv7czXHb3tHiah48My6poM+UeKPmq/kyJp9/bqWa8TLXvHjC
	Y9YsF01t2/TzuaREsPcrQdNlzN2i/vSKgzoaahmpi0n60QZXZ4V8hFYOGhezfrgEXeD2LAt8WSU
	x/lH7bsM7B0l9StB0yssmYX45fCiSe1K0bw5ZkO7dqulhyN5Uz7Ivjuvi2ceq7Dbohxe/Q8NgOL
	2cTUuf770WhYbdhTARuXF75IRse5kNP+nMnJy5Bb1YqPzVtn3QJZGxTCykxDpiIu+geXjLnGo1V
	tiNznHzH0W7vxq7jjarTS1soxz3txRYF5YphEwOhfqyoUdCIfaygbvHEyQNmjH8QqDp15eK2kmh
	kFv34J3QJyTxQcN2OH0g/ZCq4tZmDR9lCfPgx4c4Ezcf7N5wIqxonqBWTDE09An4fNm1bppVgXc
	EipGjmZVUESMNRLBOW4X1DBAbD5SLwZy5DVZqSXd7I2vdrgkoJlApHSDvd6JaKAvQ5LjAYXlsAy
	2iN62bQHMXNofe2wZuqA4cPlFMk23A9vrntPskwbl/ko3kffGD3CoJCvJE=
X-Received: by 2002:a17:907:c13:b0:c26:1648:a06c with SMTP id a640c23a62f3a-c29b8770a38mr275145766b.39.1789410534761;
        Mon, 14 Sep 2026 11:28:54 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c296614b29bsm467316666b.62.2026.09.14.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 11:28:54 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ring-buffer: Take cpus_read_lock() when changing the subbuf order
Date: Mon, 14 Sep 2026 19:28:43 +0100
Message-ID: <20260914182850.21449-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU coming online during ring_buffer_subbuf_order_set() can be added
to buffer->cpumask after the allocation loop, and the install loop then
uses its empty new_pages list, corrupting the buffer.

Take cpus_read_lock() as ring_buffer_resize() does.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/ring_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 04bb94c29f58..445931bc9ae0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7464,6 +7464,12 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
+	/*
+	 * Keep CPUs from coming online while changing the order to
+	 * synchronize with new per CPU buffers being created.
+	 */
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
-- 
2.55.0

