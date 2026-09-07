Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814E4AEBF9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786843; cv=none; b=Da5h+6hqOYzx2o8QiYZsKkcjRkYGNEqjKU7UGSvIg0LR2TcEtH66FvFmOvjDvFZZXPefNAsTdX+xMYMRm+aEZnhi/CO7rAXonB/PUvdcXaCMNyF1J0cvfY6JrYUyFaVFARJUFzXTARRmppttdOcB9uL1MIWAgtFeTAWt3C8So+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786843; c=relaxed/simple;
	bh=U/K1TM87MGaUzxHbH+OVtkemYc8EIpNWLBeSJAGJLME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSGaXd3wzvUhPDX4SO2EojjVC9TYNdNqtJJiJU8HvCFIARovDCd62kT8BSzzoLaxwLQgUqR8TpFppXoVNIHpIxbvcn3oLWjljG4kIHWumg3SU3GgPv9OIYLi56PjjSrhwJrVZ99DHdYIcbOSoTYNmO5M66tReiUowZcutRqd7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZLtAFyE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZLtAFyE"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8557c3f270eso1690041b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 06:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786837; x=1789391637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4AAG40LTRoPDYyIeHaDyg92sdqewT/vjBha2Pue4bw=;
        b=AZLtAFyEIdS4OD5Qt33sr6ZY68xHorzRrOKjJIXF5v8/zo2iyvGrgJg5PVANsj5GXf
         TOPazGQrfu8lAVfYb8+Qeg5iKHT+FcNoA5SE5NO1tOP71aUkLDYWzSwPfZQbm6LLtTQa
         x8yT9jh+xE/f0BF8Gn2Sl8N4W8i4SifTs4UlIMig7BdqIrBq3NU5l5ca8uVw8lbItAYt
         Isu6svNlNKZwaryqE8Bp60AabsO3NLaCbP6da8WZ/PrLqtTMj+LAWxknb2+hwYfH68D+
         cnv4iku7fk/oAKRmMnfSQCt4xS3q3JalzhP5kKu03RATbp41wZx/fsrOR8wYpFRUvrBc
         gDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786837; x=1789391637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T4AAG40LTRoPDYyIeHaDyg92sdqewT/vjBha2Pue4bw=;
        b=iM6Nlg7e3lItlBkmFZuhqeOkUaoVVCtYRrhEFYG63R5ESMe0zEt5++gBu9XX6xiIcD
         SDVif9FcG4YWg5P7tjOJpV0Sy+yuYbf/o3HT+kbGE2nHuJM8IsamkrNA07xz32a9NSA6
         Rgh9RfC+/GFJsU8PAZnBwsHwzruiPuKq/NUynwQYC3KosFPwwRwjKQClPyvMe0SK+XIi
         Ev8I6PmZkPdVK8j2WqZ/3vmjARci8C3rhTSmaMF1G3YL2XCULyMIuRKPS+5H5sHDaRSZ
         X+RTa7RljSpsf5JBqajFB/VuQh7qt4PY7urKV8AJ/BcrbWrJebirKfI8yiNDkBrY9rNc
         ZQ6g==
X-Forwarded-Encrypted: i=1; AKwUvBzcpm1UC/jPpoYoo8p9omWbC1UizgzVXHLwR33jU3kWXgVE8vE0xtx0xAOtOec5TOcqpPTg/sKYb5l0MtkCAfbX/ow=@vger.kernel.org
X-Gm-Message-State: AFuF++neJrqX8XJsuAPm/qDhruLh7gMkN2KNzgqUFOyyohdedHTNaMZH
	RA5EMZPBmZ8ptX27QlhpTeDDtq1/7BQ9EQHY/zaCZ7UEvl7iKfqnjgI=
X-Gm-Gg: AYBFou1xEhuHZdPB3jGRnPiySgEUpJxxfxD0bz3CVYLEZzMmVDFRAW4UOiOwiKtrS6v
	nJlTsjhniy3QrG5dwkU8w0l/NuVdlyKGUr+9uPmFUURCLeF+EZfZCphY+REv8AT6FFKtlP5OO2h
	695GnjmuZMsSC2sstZy94d1VAhAfnlQqOTCcxM4gQN9n82J73ZDU0mxMMr6aFDb3TYbk06/tezP
	zpdqkqLmJCAmY4bwkgF5a5glA97AoFZnCMY9Xlbqbsd1cfcDaHOR/I2bbsHyNLHNaD94pqpZW+d
	NlLRMpHU323JIVduegXf1/n/KgJy9KQ3D2uwFx/9fSapkSUzjEyK3KN13NKR8eV562BsHRCqZL8
	Uqc6sYi39x5Uh6C5RU/b21hk5f32hHFgdECn71cpXTWNLJpwRZi7yzDTeL6bo+N9OetoU3/Ik8g
	wW3ug+uh9Kr4kLXrKcum421H71lN1RVft6LIuXoYsoWfCkxpkxtBEjbnlBGbd+y4hHue6gWMCVX
	1TMMNRxX1X7PTx/
X-Received: by 2002:a05:6a00:8015:b0:857:4dea:e2fe with SMTP id d2e1a72fcca58-8616b26f4a8mr32915798b3a.13.1788786836830;
        Mon, 07 Sep 2026 06:13:56 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153e3ac30sm4343157b3a.56.2026.09.07.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:13:56 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH 1/2] tracing: hist: take the reference before publishing the named trigger
Date: Mon,  7 Sep 2026 22:13:51 +0900
Message-ID: <20260907131351.613525-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907125934.5C6261F00A3E@smtp.kernel.org>
References: <20260907124420.607097-2-donggeunyoo.kernel@gmail.com> <20260907125934.5C6261F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 12:59:33PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but does this fix leave another
> identical use-after-free and memory leak reachable from tracefs?
>
> If trigger registration fails in hist_register_trigger() after this .init()
> function succeeds, the error propagates up without undoing it:

Yes, and that one is already fixed. tracing_set_clock() is the only step
in hist_register_trigger() that can fail after cmd_ops->init(), and this:

  https://lore.kernel.org/linux-trace-kernel/20260907091415.554535-1-donggeunyoo.kernel@gmail.com/

moves it above the init, so nothing which can fail runs after the trigger
is published. This series is based on v7.3-rc2, without that patch.

> [Severity: Medium]
> This is a pre-existing issue, but does ignoring the return value of
> save_named_trigger() break histogram sharing?

Yes. On a kstrdup() failure the trigger keeps running with data->name
NULL and off the list, so find_named_trigger() cannot see it, a later
trigger of the same name builds its own map instead of sharing, and
pause_named_trigger() misses it.

Memory safety is not affected. trigger_data_alloc() runs
INIT_LIST_HEAD(&trigger_data->named_list), so the unconditional
del_named_trigger() in event_hist_trigger_named_free() deletes a
self-linked entry and kfree()s a NULL name.

Not addressed by this series.
