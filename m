Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6C2D8796
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Jan 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769650800; cv=none; b=uG1sCel1l+sFwkj8JaYwGnqki5FU7Q6x16c8t1Dm9iSHPe2qFIwZgR83me19M2L3GbqQunWFylZBR97O0U/4dMjFLysRVXSLDVe7SZs4Ho+ei2vxCSX2G+GHgisH5KWRnjZnx9c0FsC9Odq2mD2uANDW23nO8kNuOdrW0oiXxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769650800; c=relaxed/simple;
	bh=PIY2zPHq0fleeRuh9/qEGhr8gKEt4uj/ZM9Yu37ZEqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avIp0UQyMRzCfnG95fvkKkfgQMIIUnvmoMrBxWNEd4DFPFO9nYum7Zc3tv1Rhq/nE0cvnJzmKKUkLlXbetjlPtDVVJ3se5P2VRe2gG/i/iLrHlOkWtp3mOGPVgVk1qWEEUWEZt5sMPk6PPU4v8E59UP5LXWPHAWNicpWmkibb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LB/jIbgY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB/jIbgY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81dab89f286so205021b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Jan 2026 17:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769650799; x=1770255599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnF83VZVrWn5nKxVe8Zbs5dye1QD59WU965BQVkcA4c=;
        b=LB/jIbgYdm15ro267nXGqzp+TJ/DLBk2S39O4dKYVGalzUIeobTgURg4MO+nXi4+LP
         C2QMc1CNYi3v9Vd9K+5NV9zrp9TriyTavn99Vbbo9I7Q9+l/Za06UwqXsfVNnZC1xHmy
         cCP2S4Ra6oZuj7nMSEZ/dxXLpoBOMw2bT2CrU/vGNo9Xx5HZ2ZFbbz6jY+J2rBo74s6H
         8uKTiPbfEiIQiyWUjmh1pk8HooLq54S1sfk8mvLv4BiR9QIF2si7c4MoD8i9tBLRiv6b
         l7b2sxy4cLQrYhY76R07yKeYrT7/h1jUrLRq+Mq4tldT82otyvU07b2suRMh9ogcUjgh
         Qbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769650799; x=1770255599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnF83VZVrWn5nKxVe8Zbs5dye1QD59WU965BQVkcA4c=;
        b=uFFqsyqQLPKWz3t3gDbSvAVP5vFy1RU10IDdyIXEkDuxAL2idUWj8AkV9JACMPMB8x
         DoBWZFRwxXC+QEs1sH6ox8ipcV+OaNipydzHgZl4LvJYVJN8BBG+OVGp8AS3C+zB4Yr8
         m8X3L6Qew8tlCojA1bPT/Oiy0kBkoosQIYFNJZ9sxpK4j13SAztYGqR5jJbykiePkj+K
         Tlj5hchEIi0KNiIRRZbBq3s2NA5fRPKoQHTcUr2/U6GKXKaZqvvypkhNIViRQ9IQz/Cl
         Eg2VYAYPMTK+r/rtycbzsmlnokvFCEU7KFIXPTseSXHSlbPzR6o7MIJtq4gGi92EnFzT
         MIjA==
X-Forwarded-Encrypted: i=1; AJvYcCXX5ayRqg/K+F62e3Nji/XGncWUupvT4QEyDbzhvGOgjpEIK8b2p4xA80AkU9T/m27Ix8RQUJt163wlVu+gsNfSEKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwklmjLZdRSgn+SsYW6sga1yHnb8ifx04G3zFzABu8LvdZ8Wuvb
	sJvbbHpLxRLgdJFkO/yVE5NUpWY4UappYRfOWoPwokhG50UKddnk0Ull
X-Gm-Gg: AZuq6aKnYkI1P7WTzx1sakEHXyU489DxanAXacfk7Dv2iFTxzv8zfiLEfKHXQiZt26i
	b7Y4Qg4Oqwkv7AVpf8d3w8hR3Hs3oKN78U+PO+FSoMa610DQgu6KzLHwHxqEtJ1H8v7aHS5L4aJ
	Nj8zoKRw84njZk/fKSS8GyRefbLJ33dijy5S6UweabcYyfpmdxGKy5rUQS4hKbN7m+91klipXzr
	3oBRNG5aA4Bk5TN2+Dex7Ru50a7i/HhRwmKAp/Bn+E8FQ5ORntzvUZXe3mCpXzunA+YwTN4ZCSo
	Kom3shzJWlR5ZFQz2zYN7uvd1EVd2ayU+mQaWWCymq1+fQvVwcXr6EgJktGaSO8c0eiqyL/9CvW
	FKehple6E5QxFLDGcR1Uxju0p5uUGgtiNcgffcO8B1qr29QJ8C58K/X8EbPwILng+v6leinSQPq
	Y6d9+Hty+v+f0Yee3fysuPbQB+WglzIAeypxMLXp8=
X-Received: by 2002:a05:6a21:398e:b0:38d:ebdc:353f with SMTP id adf61e73a8af0-38ec658053fmr6637861637.68.1769650798585;
        Wed, 28 Jan 2026 17:39:58 -0800 (PST)
Received: from russ.ust.hk (wf121-083.ust.hk. [175.159.121.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d92a9sm33280595ad.69.2026.01.28.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:39:58 -0800 (PST)
From: Haoyang LIU <tttturtleruss@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: tttturtleruss@gmail.com,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing: Fix indentation of return statement in print_trace_fmt()
Date: Thu, 29 Jan 2026 09:39:54 +0800
Message-Id: <20260129013954.5325-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return statement inside the nested if block in print_trace_fmt()
is not properly indented, making the code structure unclear. This was
flagged by smatch as a warning.

Add proper indentation to the return statement to match the kernel
coding style and improve readability.

Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..bf0ce2aac177 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4286,7 +4286,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 			/* ftrace and system call events are still OK */
 			if ((event->type > __TRACE_LAST_TYPE) &&
 			    !is_syscall_event(event))
-			return print_event_fields(iter, event);
+				return print_event_fields(iter, event);
 		}
 		return event->funcs->trace(iter, sym_flags, event);
 	}
-- 
2.25.1

