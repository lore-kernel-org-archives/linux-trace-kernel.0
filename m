Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0B38F647
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107168; cv=none; b=gL91Vd/fnchkcgFCJlxojDw6uS8EWc8YbNCoxj/T+VVLCUR8ns0eyApeZ4rS5Y1B5W/VZTv0yf24uH8QTRuO92WuMxQvHrqbfwMr7s2i6IpEfHmM86yqzM7en4uagT31BqFIp1yLFfatXjNDbrC+WnB7KTgaGX9Ckim+gAuyfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107168; c=relaxed/simple;
	bh=DHvTbgVBW3hw/f0a//QlChJQ2MhY8ExqMLSzgMSMh1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jqi5JlB5cnaaDl9H+FxWsVGGb/YLCkX8vmsLexlLVQmrJLzGzF+QwdqOdNj0xpn+qCAdxNeVdJ7Ow0nd8BnIxvg6nuLB50UPwQnSzaIkuKirx5UX/V+SNXzpWG9LX7hlPTouseLEooP8SYRG4Em1oRU1TSIKEd29EQrBlQIfdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMjQYVoQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMjQYVoQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4888375f735so46662065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776107165; x=1776711965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+CMGgVpbGSFYrtIdzPvzmGJsZQ3Z4zuKxslghksSgw=;
        b=PMjQYVoQvJS0lEJXD+gduttFbpf9YGCLB+jqy9chm5CX0lbGKs79Vk67stAZlJ4ol1
         72lv2NbplJWcHBWPX7OSQE4Jv+Hm8R92uWGg1e3bk3Q/gt19QIAg8fATCY/b6dgipneH
         Lki7TNIJhGNEHhzmdkVXnPS1jA5UKrfN1if9mwbQUCFnGG8/TP5n1i5+Nu/DfAtMEaz2
         rPzTuS9uAZsIwOF4qIvxHTU9SxXmLwLt5pfnmBndokQy0hC+7wrgmkh3fsrc8mGklTX9
         hqmdguNwWyzh+W+fLCbR4p/RGnkgI2iZyhU8V7NaCaR5kh3oeRS3yYBCJtEvsMfPJA8l
         iFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776107165; x=1776711965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+CMGgVpbGSFYrtIdzPvzmGJsZQ3Z4zuKxslghksSgw=;
        b=YhOaQr4BtP1A5xLK80ye7PVOoSixR1Pij/kzm+sTkAnoDkYADjsNycjvqag+3B5iHf
         dvtNkUnMU2bqH0dnwMGz7QkatN6YFgVYkusieFrWXqBdcABgJu570wyWasH8j2+ham1N
         iTUbj8H6OLaXhhH2FKw674k/6AbYaRwoTWebVTr7XrY+agZxsB9gwbflbowncO9+/pkR
         h2hvBPrJUD1vTON5r8E4KCa+RIFFy4UaGhnVVmsKh/uKeTxT19U3/wBYGrF0uMd8ZIeb
         KIK/g5ptdNidsPOSdkwVTJJTNxTI5AnszQXTsLr5VcAnoTSBNeZWp7zeDy7z5gF5ScLj
         rIgA==
X-Gm-Message-State: AOJu0Yww/czfMWm6KjjSF+QCJoNwpLWgpU62ZtAKsd2SKZ/Ed3iW6EXd
	FTBcBlYsUJTGcmNn4VC49T7ZUwDETvYjqcox0603mk50DhcUxdtbkDRc
X-Gm-Gg: AeBDietmR6e1U0vlHLqeON1vqInvG4Sv2fWBjVdTj156wktOURrbCvg+8MXTThTp90S
	akRkmwM/PplWwg1uQVs+JpzQXRqv6ZrU6UmJ3r1HR7d9+yhrhKe1JBYaWwm3L5UcGvhXrHQVkPZ
	RfnTPaTumnFksgSy8sbcyamLJsJ+sQTTl6e/WRkHukz1d3g8LrPLjOvYUjv3cQXwjT6oZuP4Cb5
	mH5fJnpRcgrno+7OyQIfYHMHXATwkB3wJ6Gx6mdOWJDHUyAGErODSgu/2VHQTMpWhauRDHfyRlM
	IoIRGsRX0q5lGH6VxCudhxnCdkUwTDlaD1UWVaUkHDfGGlIVjPv6PrerleoklJ2DN0RLh1c7/iT
	fkVDec0EViIHcgr0qZ+JJY0ZxycynNbtckVKqBdu9XZpHPlcGfbiHU8QUjKOdb/NmFyzgh7RlVv
	QAt6b2C3/4UQxNi/JTBDsQ4nZwKS/Bl+Ws/VVNX/i+qPILjhh1/AL8rMZ4WWekPJXERVwo98Ytb
	4fIxV4FyBC9
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr202216175e9.13.1776107165068;
        Mon, 13 Apr 2026 12:06:05 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538c39bsm309952685e9.14.2026.04.13.12.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:06:03 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracepoint: balance regfunc() on func_add() failure in tracepoint_add_func()
Date: Mon, 13 Apr 2026 20:06:01 +0100
Message-ID: <20260413190601.21993-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a tracepoint goes through the 0 -> 1 transition, tracepoint_add_func()
invokes the subsystem's ext->regfunc() before attempting to install the
new probe via func_add(). If func_add() then fails (for example, when
allocate_probes() cannot allocate a new probe array under memory pressure
and returns -ENOMEM), the function returns the error without calling the
matching ext->unregfunc(), leaving the side effects of regfunc() behind
with no installed probe to justify them.

For syscall tracepoints this is particularly unpleasant: syscall_regfunc()
bumps sys_tracepoint_refcount and sets SYSCALL_TRACEPOINT on every task.
After a leaked failure, the refcount is stuck at a non-zero value with no
consumer, and every task continues paying the syscall trace entry/exit
overhead until reboot. Other subsystems providing regfunc()/unregfunc()
pairs exhibit similarly scoped persistent state.

Mirror the existing 1 -> 0 cleanup and call ext->unregfunc() in the
func_add() error path, gated on the same condition used there so the
unwind is symmetric with the registration.

Fixes: 8cf868affdc4 ("tracing: Have the reg function allow to fail")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/tracepoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 91905aa19294..dffef52a807b 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -300,6 +300,8 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
+		if (tp->ext && tp->ext->unregfunc && !static_key_enabled(&tp->key))
+			tp->ext->unregfunc();
 		WARN_ON_ONCE(warn && PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
-- 
2.53.0

