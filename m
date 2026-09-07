Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7B4AEBF9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786849; cv=none; b=kPhA1SnpxaNRjB3sqMw1Wq1f34ruq2AgH31cSZYw101bEwiFzamO1TP5KQoVgivmdyYEz1Ic4IovrmyEAUx6K+b1PvfiQeJ7waIFLtnZv2QGt31dawS0VTwKBTJbYMSUJHH8E2f8mFsRSfyUqH11qbWVMhiNUyp+nBE/CBh+nwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786849; c=relaxed/simple;
	bh=dWzNR75g7GxtOP9gnAemxDujVQlcOaJPEWJ4zxqivnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiwYXhFu1y6OdtdzDjiZZSXgd+xBJFai4N7aGJ94CS/PAaH4ZtgLggeoqIagPAI6R2ioudIfLgqHwVXR68OsfA796ywx+rNH95DJLpKqM3QZNz/Ph5wUSAI5TI1NlhwYGFxotrMTbFmcWPOLLiZ9Y2VAFzOj/5whlWpKzwlYmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3aZ8mBj; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3aZ8mBj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso56858a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786843; x=1789391643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBNOe0eEjUTG15p8/eAAeCa3HJjbYU/T5PhuLMghgho=;
        b=d3aZ8mBjoT8Q3pD2+IjedJ+RH8gpZ9SEv8xlbiy3fN+KMokEZr7wT7hOBBrrIlNAm3
         9Jf6cbau9QDKAGjfB3VDScJt9amSp2UKCnQlOVAh14nXTO2RjyYgRPAupn0DhjRQuqDD
         iwD8g9a9gGq10U0iSKScqVoRv45SARLUyrPQj1QsTkzdB6/Q909iUs/CVREDQXr4+RQm
         TtitMK5aqJDQfofcQsuJ/rQU9JeAqxifEEWcp7pVx9eBPUAnr9w07QJMse+1hhOMghjY
         jJ6bY2hKR4NV1KQCchIQdAjwDyCUeRgiJrCJ7pkfgVEXxX7pFNVTo8nQY7w/wudjx5RC
         /dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786843; x=1789391643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBNOe0eEjUTG15p8/eAAeCa3HJjbYU/T5PhuLMghgho=;
        b=oFt6FuSSXbakoxgJOtvUOiFKov9uRWZVOBE7vuf9iU3VaSClRXts8AuZZ6F4f7l2+0
         QYUsoydHlFcQCzB95Z16GCT/XhsxtPZ2Agz7Z1Xr12Dagtd7UeJz8srL+eJMUztgkIpm
         xEGRmhOyPGqs9f+s/qQd/Ki5ahDEA/Ji+vN1ObADMnhmH/4xuX65Hhg9nHZw9ZNC6L0B
         OwLIyiNa7Anp9WY2Lbv42vX4sejCSXFiqDoquzCAjJOWiT81AAuVxeOG4PV9abX+Gf29
         6kXs4zzkO0QdaLXS0eT+zeA2ViHa8jkGCRpTGMX0ZEpr1jx26f8xZ9uhoTDhhmIi4zFJ
         +WaA==
X-Forwarded-Encrypted: i=1; AKwUvBwISiggZxgiaoYKuUp54xKAwGe71NaOe6HJBZDMSxQ+foxGV+kJCVHA4BGYv4rNm+zW6Mw8NrSXHM9Mw0znuJe724w=@vger.kernel.org
X-Gm-Message-State: AFuF++mjWXCld7KBBdMLqEodq9qPjA2p5/Ol1nAK1o/1iLD8lIWxEWMF
	PnkQOnNXMI4T2Sn69W2Hi/dNfNseAPsI1M/E9it0u7fSoYC5JXouMbQ=
X-Gm-Gg: AYBFou2v4rsbXf6dhyEXiANGSfU9TW5DeOoDIypHG3o6A3XwJf9Afwmbc77IOGDUW/s
	y59skozoWyOEs7szVXe30u7eKeMRvNXQ6BXp6fXRXwX5Az9yVlMNFAXl5y9/sxopO9WdugJ96Yz
	dXu9lfdBnUoiXSC2qv6PWiuwGxCr4xG4mF/AgbFf9T0eP7KTrWA4xGjCNGv0uh+dO1cpUm+W0oN
	lsuLtCQXtYoENtniUDnLtGZ93P+cOWOWczCDa6q/fx6Bza7Xv8ts0bsX/iHgFrMup3T/lk3VIAq
	OroXu3PhOtWrcLlCQ7pr81uSYAIBciLU8ViIiYEAHKPUprbW71SeDB/quAbboGfuoZA1cErIEun
	2LVmG0Wz75y9j9i4oHhtghgs9/1Ze0szV0MGMPzmQvBV5+ZbjVX45iMFdjK9iNpgIszp0Cc4+hp
	Ni9Mw7RmK5RoAF1UG/A+XPy2DB5auh5RS9ukqh9vP0uZGxZT6X2tygrFbhuF19CLm2xVAHa9uOl
	uye1kw1E95aWuiOjA==
X-Received: by 2002:a17:90b:4ad1:b0:38f:657:6823 with SMTP id 98e67ed59e1d1-39b8bd997f7mr695966a91.8.1788786842561;
        Mon, 07 Sep 2026 06:14:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f88475sm20713756a91.1.2026.09.07.06.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:14:02 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH 2/2] tracing: hist: undo the registration when enabling the trigger fails
Date: Mon,  7 Sep 2026 22:13:57 +0900
Message-ID: <20260907131357.613555-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907130105.94DD51F00A3D@smtp.kernel.org>
References: <20260907124420.607097-3-donggeunyoo.kernel@gmail.com> <20260907130105.94DD51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 01:01:05PM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but missing cleanup in the error path before
> this label can lead to a use-after-free on the global named_triggers list.
>
> When hist_register_trigger() fails after successfully executing
> data->cmd_ops->init(data), it returns a negative error code without undoing
> the initialization. For instance, if tracing_set_clock() fails due to an
> invalid clock name:

Same one as on patch 1, answered there:

  https://lore.kernel.org/linux-trace-kernel/20260907125934.5C6261F00A3E@smtp.kernel.org/

It is fixed by a separate patch that moves tracing_set_clock() above the
init, which this series is not based on.
