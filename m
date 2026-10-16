Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0E38F62F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129124; cv=none; b=TDnGYTsgp8/kxo74VLcKZTTInN0zyWX5q0PxXTrO0/fnycqzyPdMqbiTQdArK4DDP++fCuMMlXG8KR++qBhtY0lWtLWdDjlWkKtE+qNsX8xdluHl2YfCQEWfwrS4WQz0Si79f+kb552b5Usip3sPBegU2jfyjz+hK+G0BoaUdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129124; c=relaxed/simple;
	bh=XA1td5RtXyr53ECVqINeTSELxJLO5VlbkDz1qkltoms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PW+G3OYS4a0UyhyN770n0tLnEJjUj5d94UHCH60qQH2KmxPcQfA0+18M01i4kiRecCtrj+F0kxCOjyZr6ldTX5J1VFH/1Q9yVHcjDRSnF8mPo4GkS5CrAeduXszhSCS6cvo2iAs0rz6JPd/wYZ9mP+KK8rqJjAjbq8PebQw4Fxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9wC3PV7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9wC3PV7"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so48734995e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792129121; x=1792733921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TOIiQ6a4LuFeFNpA463QSfXeTShKxZ66XyKQsJ4fw4s=;
        b=m9wC3PV7XGX8JoHcO6Fb/rSPE/nxKaxOTssgwI0+SvUYKD7tLiN9shqpxg6gSlmA/u
         AQCprENSA10LROwWRnJJQDqrCfO4Yx1LWfzPdFuzTeWN5pnVpVQ+fZ/d7S83RdXDZHXt
         ckdzmxBV9Cfk31+QGQw0TvDSQ34/w8R5Fpr5Y71VrOHJX68L5iNkwcf8n0e07AyWvLoA
         d6Di+htDoFkSUednTuT6w5AM/U/w4EcHpgLhIJ3FdXviHtV82l9TTuXqxjgJQLx6r3TC
         2UDfFin2tMYb2QUKAkGgsv8B9zcex5HfMz5P+QahZIvKNJSvC2O5dz6FzeBp6OuKaH6v
         zkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129121; x=1792733921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOIiQ6a4LuFeFNpA463QSfXeTShKxZ66XyKQsJ4fw4s=;
        b=iZZhm9xZyGwqIf+HKHLEWBlFPag6816qYDnBj9xHqlERiGOZEL00j/XSp3NT6zeWly
         C2qoXfksa4Mipm9voXGXP+AlzbEzgotgIvk0uYPfs6dwFxpK3VqI1juwvYB7CbqYwazs
         5a2NjKLFLqld9pv24y7rP/L2GYsgU3KmxLXn4o5XVn8DmaBvvD7YJbdjY2bADCHK5BAM
         W8xA4f8teznhSpl/935TlVs/FGohe3qloUKhsJ1fSQPu7nNkE+9lgKVvBL2W4ffN7y75
         D6yllgu1EjrCNirEO4mwmpde/jcIUX6qrvHjB+YpQTHucARkTVcmsUg4JhFpKhXweYos
         RGfg==
X-Forwarded-Encrypted: i=1; AKwUvBxZzdpwkd/m3exSwi9PkP7SV05QOtQyK96qKEOZo53Kto0R2CT0EQhrn6GZn0yDHYOdlFGwzg6fVvxrvMY7IPotOIg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/1gAErKSWgtmPVvCGzb+IbZ3XEEr32OwTDrVk+M/byEKPFhQW
	tZhAOevay8XlU2Jo/L6etkrnIWgL4GY/bj1ySBB0eXN2qNrYyXRQVsUw
X-Gm-Gg: AYBFou0p1Pei/0NQsh4Kpmxqow1DIsl02rYDejNF47NKcGOVDh/2I/DAryHohxmapVM
	43tGslAZq7eIB4KCzFqi8/Fxw1APVzHadog2cI9OwtuIbJQGmFhYe3MA8rwN9DZmpIwo66PpyuM
	N65VZHxWouSOkIlbjmgx1DZP8aZZHNFtbaZ6zIkxWeG3tTsQizhBha9KuXR5fxLZHZNjquDVopl
	zylJdVBvT5my9RTyTci9UCyOV4foomTozQ2geiG/Lw/035Oi4ionq9yzOcpNbmUhbTkwVol44jG
	dMVxcBXJLKKJXCqgpZRHHdgz4i6n0QECwQJyoUpY878wPDd8YqkLsJnFF2dwWDd34L1fjZGUeER
	4QuG5eIWervZEh1ZKj5D1SuTYCEHW0Ewgmzx53p/SU/QBDaZtMqjxlrd8PThVBcWJE26rLQ2SYb
	YkZ6qxpyf6P/WGG3b1YDtYAYrEMNgqbfpE3UrzZoP/pJMXqx/+IXo60W1ndgfFXGvFQFwoIkL3J
	pPeSAyiBViGqsB8okMhbNggLV7w0qxgIe2MrseDX8j4dOHxDmydJckKUos=
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr452496145e9.9.1792129120743;
        Thu, 15 Oct 2026 22:38:40 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c10fe9d3sm98463075e9.13.2026.10.15.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:38:38 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Hold trace_types_lock when updating modules in persistent instances
Date: Fri, 16 Oct 2026 06:38:35 +0100
Message-ID: <20261016053835.204353-1-devnexen@gmail.com>
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
can walk into a freed trace_array. The notifier also reads and updates
tr->scratch and tr->module_delta while update_last_data() may be
resetting them.

Fixes: 5f3719f697c3 ("tracing: Update modules to persistent instances when loaded")
Cc: stable@vger.kernel.org
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

