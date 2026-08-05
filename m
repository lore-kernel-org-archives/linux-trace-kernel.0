Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B5484251
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946365; cv=none; b=Ws0EfdarVKyv+64/bMPD20zBc37MVQFK1zq5mISTP/AlfFvD5CVIgGldZzj9cdlp7XQXxb8Y1C3kL5eLS6zjILQtHbbuHa5edZJnaQxl9Vz9aUITfAPwdk8Mb6OmwDUHPBG0tHsUHEppIGvR4d5o1kuyL4yWuOYa+pRPGlvO/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946365; c=relaxed/simple;
	bh=h6KPzrWshT29tSuoqzCwE+fz+AH59orLg8EkRCWjXe0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kIYnm2VuOc6yNlq+MdkoRg0DLwtVRSXZAHs322gEAJNy4Nm1qdjmn0PaIBpwshOYQjLo0ztKgWY9AOevbtfwgb/8A284J2yCZezdv/qmcDv6aQQk735egnPmNr5RMG0jAgtZaORiLe+dC51eQdXCOLayuH+Bk0XB+B4A+pBVD9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nF/JP5bn; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nF/JP5bn"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15d4bd2afeso111331866b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785946358; x=1786551158; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pnKG5lupQBX258Un+WQL6Ij5fYYy+dSkBnY0mw39UZc=;
        b=nF/JP5bnkpP/EWY8qmXXIpA7KOPpEytb1cZWvQMun7cKhzXFuWWVdNJy2LgcuE3TzG
         THNquJWM3iJsspTigUgIWEyVGBdlbdkZxlG479CzSf9oviPtEBw5j7d5a5GrKHtcZUiM
         I8MQlyb0a3AZYSqoosvAFV1FumTNAsfRQzx30E6BMOKSfQNgDUKc7LC4z7woC8L9Q3sd
         5ZJsyFuWd76tMf+2bpJJMcXFcMAHWrcDde+LtFwuuD8fgj5a3ktLsowuu3ojys6fiT/D
         Ymc9XVITNcBbHSrMKpxK5rt3Aei6okjtSDYVRCn7RKwSpLvUSo9r6/fJWqbUS85eC8U3
         PhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946358; x=1786551158;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnKG5lupQBX258Un+WQL6Ij5fYYy+dSkBnY0mw39UZc=;
        b=rgpC3E5gZBldve8DLtMT3+bA15mXOEjuC19Kpjw7kESx6M7tRQbEE2ZvkczS9EAm/P
         bzL+K/9iGA4KzyMgIgJnNrM/YXPCSGyeegjVEp292dlJgIImUomEaXvks+JSTcuJxc1T
         XRQ+5oVkpwrR2079s3GfmtPEIfVG80d7LDrAKuUU1ISZ7QucGHqKhoC2QIGa72Et4Lup
         jIeHb9p6xFV1KEIn3rmWsO0/CadlQNJrJj+hDe7nDVjKJxmya7b+JzfFZf8GWyefVy3r
         l/xxTkO7NMjksTlGxCRF2KM/a6nEc0QUoYX2WJIK4hQPe7RI2PnUJesLVWHp+3f2nMhi
         S1jA==
X-Forwarded-Encrypted: i=1; AHgh+RpIZ2pXH/nK9Z69dr/wtMw5pbgvpaHluDVXZtaUbNJG3QtPAtDwHVHuRT1JDMaJIIlL34ikDlyA8f6WEcPANPazShg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFJhsqsgm5U14x+pDj5CQf6NVIK6DurCMmOU6dtj1f9H27lun
	9RRYesmbPRB7xy5AdkJA4Sv8ONCYK+RiFnEiPq86kJxq6pxqH9vbgffhAhF1MlhxVogsIY914lJ
	6R16Nww==
X-Received: from ejcwz13-n2.prod.google.com ([2002:a17:907:b04d:20b0:c15:bb6e:9e2f])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7ba5:b0:c1c:2c32:1163
 with SMTP id a640c23a62f3a-c2039f3d9c8mr399976666b.25.1785946357599; Wed, 05
 Aug 2026 09:12:37 -0700 (PDT)
Date: Wed,  5 Aug 2026 16:12:21 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805161221.2428623-1-lrizzo@google.com>
Subject: [PATCH] kprobes: Fix NULL pointer dereference in unregister_kretprobes()
From: Luigi Rizzo <lrizzo@google.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, "David S . Miller" <davem@davemloft.net>
Cc: JP Kobryn <inwardvessel@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

In unregister_kretprobes(), rps[i]->rph can be NULL e.g. when called
after kretprobe failed registration. Under !CONFIG_KRETPROBE_ON_RETHOOK,
the unconditional access to rps[i]->rph->rp, causes a kernel panic due
to NULL pointer dereference.

Add a NULL check for rps[i]->rph before invoking rcu_assign_pointer().

Fixes: d839a656d0f3 ("kprobes: consistent rcu api usage for kretprobe holder")
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 kernel/kprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa93..5dd4786c455de 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2359,7 +2359,8 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
 #ifdef CONFIG_KRETPROBE_ON_RETHOOK
 		rethook_free(rps[i]->rh);
 #else
-		rcu_assign_pointer(rps[i]->rph->rp, NULL);
+		if (rps[i]->rph)
+			rcu_assign_pointer(rps[i]->rph->rp, NULL);
 #endif
 	}
 
-- 
2.48.1.500.g5897711438-goog

