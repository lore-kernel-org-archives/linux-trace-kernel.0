Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5228470EAA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332181; cv=none; b=BGvSROGt7fzCbeHeIJY4PLRU/aauyRrpxeXsGjqFz7+ZrZN6Qx1QT8y1UmN4r9U6FaGKjsJ/Yj+Qsmz8/OusO7fX5HZfAZf9o+DsWSc8QhzMlLCG++NgzzoTiV/kE0fG1KODzPMel+ZYbprVFhwb/557mFTW7AfijT3icK6l6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332181; c=relaxed/simple;
	bh=V8KkWNEIL1EtblHKb3pRj3mDqxpGnxcUY2YFdefRDZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fm9ZvQw9IwMxp8ZkzJJs9VkA88aEgaoQEEciEzrN07AGJqVbDtJFjzOL3P+rXGcF2iR1j+8hbuIonp+j3r/372XBdsQtAviKVj47q/ylLPsrBHJkBRQzDdPyFk+TSsRp9oWvWacdMKZm1XB2xsFqqRQ/SdpyLVvzk+7sEVikF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nG9FNmDW; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nG9FNmDW"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c158e733fd6so113393966b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332175; x=1785936975; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DqKEjFTGm7dqnB3Iuy8Yez/XkakkUBzOCNyU+fjpBRU=;
        b=nG9FNmDWSIdmkusARNQu0qExVNRo0PVo7xoci3dOMZah81RcENLfI0HhRIHJnaZagB
         6GAdh//ednJTa1JX92aEYGLsOcNRmPlXkq34DBFK/fR1rc4R/kjhxwk/2x6LE4iGMwhC
         yN0y6WBup2tsko6eISV+7BKat0WY/3D1OUKGpwSsknyyby20L4G8cU0StMyPANMboWWv
         nSetJUaZqCykiynQAqjSOXBEk92kg/S3h2casDme8j+swiDHCNPc7IV+8PSbrQsBU5Da
         XKZk7t4Mm7dRjMoZYxBLj3pS0tgs7RUFf6mbvDwypjipUV/iQ1KBGCd1J4+rC5Omz7Ga
         k2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332175; x=1785936975;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqKEjFTGm7dqnB3Iuy8Yez/XkakkUBzOCNyU+fjpBRU=;
        b=gXHgrfTIisQzUjAF4HCfTQaUsv8UK3YLV8tJ2fcpgop3FtGK+GIVDy3DmnF4Or7q1S
         C8U2n2JFuhD69DhdX5eYPiMXsvHN5CBAt+IqJvlDwGlpeRlFN6Kc0nrF0nCnp5JDkA2M
         cxpsRTfQpBue8VboCZn88u/iOk0u21inWABMlENCMRDoH7S52qhR0avH0teWyG7R5v99
         ogyj0EAWjrRdBVdT2t+0Pvyro2gZu6ud7HOd95WPc/MjzQz0KCd5rdrHUOUzRGgyRd8e
         kjFTCUxDtzJ/9G/2zEbLz9to67/l+3kFGUmCcPItknyeaB3lwpvcqIhmRzk41VkN6jgt
         edtA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1bUBCapKzz77WroGlTwl33M6/BlIh/1K+TLFkztsOh0ZYSmcRP6odqfr7dey1tMPm5EczOFzZs42u38IUuLhoFRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrV4UpVp7mSZSt1NAFhZzlWWqmzcfluGiugdikAI24/UvNtaD0
	BfvWz7Qb/tWA7M1evjxwxA3Yr5TqFbKo39rWbTUprttYApCT4FZztOzitxaEoqPzCrPGdSZy30O
	i8GGOg9tbVJ6wACixZAnwXg==
X-Received: from ejcjv3.prod.google.com ([2002:a17:907:7683:b0:c1e:eadb:2ec])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e00c:10b0:c19:5d7c:ae72 with SMTP id a640c23a62f3a-c1f720ef123mr268508066b.32.1785332175379;
 Wed, 29 Jul 2026 06:36:15 -0700 (PDT)
Date: Wed, 29 Jul 2026 14:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260729133609.4022734-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Fix reader page read offset for remote buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, keirf@google.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

A page swapped in by __rb_get_reader_page_from_remote() retains its
stale read offset, causing subsequent reads to skip events or read
past valid data. Fix it.

Fixes: fbd1743ecba1 ("ring-buffer: Add non-consuming read for ring-buffer remotes")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 804ccae694d2..78d3875a47a5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5783,6 +5783,7 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	cpu_buffer->head_page = new_head;
 	cpu_buffer->reader_page = new_reader;
+	cpu_buffer->reader_page->read = 0;
 	cpu_buffer->pages = &new_head->list;
 	cpu_buffer->read_stamp = new_reader->page->time_stamp;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.55.0.487.gaf234c4eb3-goog

