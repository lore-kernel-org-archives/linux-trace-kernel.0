Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F731A558
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723297; cv=none; b=aLt0R9hol0Y0sAc67YQA6w1SjuRjfMgEUUFr1gJ16QIX99vfyTHGRwP6uHeuBSAeWIpKm0lk+etatmBcaejcEKnkc5pUeqym5KRu+uMa1pTyRQI6ArwKWGnbN5OR3E+0HSPmygifZV3aPltcE7yfUXOb4/YtabuZ7efVyYKSWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723297; c=relaxed/simple;
	bh=G5eRL7qq4qKfG1bg+gMqDto6FFY13JVc3AzZwauaMjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZnLgkJCHtg/71VQLzE8Ov1kQCxjEjhVz7S+dUBsXwHimnBmZjRyXqKSOXqOWkRtwyvnrtnhc1bGFdwSPTBZbxPKmTbAEMiqzWyuqOoKKsBOkAnTKP5ipVvIqiV0jBIBTRvdrZX+nM7QNx7MGxrwOVFMTjIufetCQZ4FPVWa2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J47UMGFy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J47UMGFy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4805ef35864so47235525e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723291; x=1771328091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XUdzb++Ot2O9XYmK+edoXm2j9wNmswRmiQS49YxQxo=;
        b=J47UMGFy6fX9DokZxzDkhbFMjDt354DfMwOTHrIGHtWVlClBV6Y1dcJ+QW/9il8u6R
         Vppvr6A2AsG+3FO+umKLXZ0/0GkftylpNyMz4QI1gbiVs/Md7ysm5rhbZKAscelYLv2D
         rNlYobMUQFva31jWqKHKJ9sYvcyjo3CId/zmi01OGtPbt1FdC1/3hVT7wEksLMyYjuj3
         wGXDXBvrGluhwvw2ApB4vP5DV2ioPMGeBnNcTYX6emxunyYsxtkmdOAA2/J2BR3ruhDQ
         hmIvnO0p1PCqXE03PlN8O7rqHrzQDti+QBc8GEfDP0VrUG5Ge2etQ/R78g5EpL8xKHVz
         tYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723291; x=1771328091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5XUdzb++Ot2O9XYmK+edoXm2j9wNmswRmiQS49YxQxo=;
        b=Sie41dGM2WFyx7o3L6UX9z8Qb1hsa+emnZNaPwHVzNo2gfIHQNM7ahy9Kjkjusr6qi
         RXM4hpq70hNUYYx+HUD4VVmDLGkysao/s6FjWzL2hBeENjKb+sOIp7+Oyh+kFbasPlql
         9lPPDcdeqq3STja5cf1onO/8FbQ3m8JvvTbogoAyyHSahN40eBEVY/v6dSETLkcisZZY
         ZfH64TYKi5jOshtGlqI3d0+/nd9SJM7KNdfdCEEsayPMlD1zJ9Nylzu1wu7ZnRK3KVul
         /wbulPoTlZrqavBvwiYO01X4y4DC+KCOzygiDjIAJqn+NcYJjv6oWqwvJ6T2HmL7GDK0
         rlqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcWOs9+S+6ynV6U4CXQQ4oX6CiaDFAonpG0NYpw0iIWpG5WSoHJb+NCr+o1ykKDv1eFSwiniYyCIzSS8l6LzSaG8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxocN7/J3dSXQSIeXoyrGEE+ygYHQAgZ53IKjrZbj+Mdfp8lcBf
	mXWaooaWaPrbaa+5lXHYlLbptakJrrRSJ3Ywoip5bOHUwaHmzt3YTsz0DjnabIiQero=
X-Gm-Gg: AZuq6aKOtOxJsQ2OSriL00sagNnUbZAvGqHoYdf9xOEJJQQYstOsWGpel0GQ+sZCy1p
	HHhchDWCibDQei8W0quVjqwYOf1BAUQRg0fc0jJYnTI0a867ptPLHjsOQYLt30D39Kt8xopBaYl
	eVlEUxp6JBbcC091NnKhzIGDxUrGWQWVwQxJakY6Zjq/GyoIMTjDBTay4WY/GcGMD+OsxaoaOZ2
	780C0hnwgrp7z2OybkleHUm1gnOAQC7dZkcuVu8T0wYkn0rBKX9Y7lD+MSSH5yAaMcOwbNWlCwp
	nEz5RSWSeNTsyyZVmaTPZIb8lRiPXZ4AG54x/Sk5mEagI0ernnctyS635vB+VSk6Kwi55xg6Ndy
	ox+u2UJY+ttmT06z1avQxRFUSf3WcQbsZ31O1q8/HR0svAD/I9ZMjzRNpDSuo2IAgxL4qlp/iO5
	QZNgtewpMsDTItzGxFfKxhvHySAXm5jh0ciLleyHq6ewQ0/3TsmbEY9Zp49p/R2vIuqgymlca8e
	mNYm0ikqHQOPblxa+0vlSvZ+f/G2Z/urXw=
X-Received: by 2002:a05:600c:1d2a:b0:483:456a:5146 with SMTP id 5b1f17b1804b1-4835082c590mr31057165e9.25.1770723290505;
        Tue, 10 Feb 2026 03:34:50 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:50 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 3/5] tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
Date: Tue, 10 Feb 2026 12:28:18 +0100
Message-ID: <20260210113427.1068932-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210113427.1068932-1-petr.pavlu@suse.com>
References: <20260210113427.1068932-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_filter_write() function calls event_file_file() to retrieve
a trace_event_file associated with a given file struct. If a non-NULL
pointer is returned, the function then checks whether the trace_event_file
instance has the EVENT_FILE_FL_FREED flag set. This check is redundant
because event_file_file() already performs this validation and returns NULL
if the flag is set. The err value is also already initialized to -ENODEV.

Remove the unnecessary check for EVENT_FILE_FL_FREED in
event_filter_write().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace_events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3d272b3cd688..401ab7ed869b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2160,12 +2160,8 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_file(filp);
-	if (file) {
-		if (file->flags & EVENT_FILE_FL_FREED)
-			err = -ENODEV;
-		else
-			err = apply_event_filter(file, buf);
-	}
+	if (file)
+		err = apply_event_filter(file, buf);
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
-- 
2.52.0

