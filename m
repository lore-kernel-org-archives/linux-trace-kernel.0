Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179999;
	b=xDJo9X7qJggowrsc5VRbpRunmRhwyFXrHztTx/RgjQUjhsPmxRNc2RzlWo4MUfYZu6gA
	 NVM21mzLxMW0hi/OvY+h/gq/5vbW68YIRgqDrKJnV7VE5UL4hXmYMvCuU1QqqTqDeoqw/
	 a1GUJK6dzozgnpQkPDCBNVHaYXXO5tL1koZ9dG66HwLYGhawNiCgb+94Jz4GAKrVKs9rU
	 bLLIgJ4q1ddRSlZMNU97IuHG1LNQxVdJuiBRbSfI+TymnRg5leUad6oEmcCud4uOzTPGZ
	 HvCy4jpJzl9nK3lxCEQ9wbAHEK6G0JYjkSZRShSIlw9KeCIjl3YXekm7xFwcl8gf2sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
	b=hrpeN189w//FmwOBAb8qURn1MXWk2cC9Cq2D0gw18t5LodSaIe709AqF7aPjl0S71joB
	 mGmtzB5YDJRfDhGv+AatiYMhaQDwFhTlpOr2iJSDgAyxld3Qs/WdKJK5tcpsHFakJqIPZ
	 UZN7M0MrfHE9oaBo911k+Lj7gmEBI35wcQHfZRajPpuin9spHDNB8shsRZklq1ktAEcLi
	 f8sfOi/oMe+JzPor1AsSzYAaRd4+/x3UCqtKiA+5y9IqVYAlWldJyKU9a0GGVYwFvFo8G
	 CHCkdlTwIEn4ZCfZ3s+Oa45zCDhTqrCZgCE2vVvUybmmkCbk0FMz6ffrv6zOmC79apg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvTC3UWm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9F606A32A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 13:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD9F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tvTC3UWm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so9021955e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795179997; x=1795784797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
        b=tvTC3UWmisWdUSymmpATqFWpFz0OJyrOUWNGm6TBa1nwW+7YrCpulfv3UsMXJUSMJR
         FeB7jMc6J+kTNoXVesQNAldCxnQi8kdK+ZaN5Mx5QWOevM9xrRb4hqkD/xjgcCCQoPvy
         OQby+O/fPsqDUrWqGaLaD1pwZi2J+tzxhFFhn6F1FHpJansAs9Ltyg9htJqpl1gpkoS3
         D+7f8lP4Kv3T4bkgIrdlvAsEXbYF0L0BBktabQ/c7R5Etqv5lPQ8bznCTbM05xww9bRU
         +9rjZPf4Nyffh9azDCNgN8C9/4ZVWysYDqolHHq7nOlV35Bq5qm/k3C91Gxo8pxoi87E
         tw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795179997; x=1795784797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aN9l8CDwOvjtRjMobYbC9T4AAnLVgaW+5jZeY6o9Xhs=;
        b=TrPp8+VZSpZSc2Z1gy26l9GgwrvdnIj5sdcX8ptjA1sdoiQRSsdNCdmgHX8PYAFxOC
         w2ep0e6tZSnwF2s8MoEM5UlDPv8fApkYI6OpigV3sMGTHuF//UiOqhilLs8DeqT8JCUx
         Ot4jxSBmmfYMDOGpJRd/4HIlQB+X6j6NHpPZGexPGZ1+75ZPJJN3unxmN+WQ9E3H/4P8
         QF+ioHDi/8F3V1mk2FwxVOhgcpvcB/nsmnOsHkCBl7BENKY6Pp6c/2FvNua3K0Pd/nyP
         xLeNGfrGSwt3WgIYml3p11VabSk3hfMTAIX5tCrcxX9Zxut1MN364gIkcIabBsybn+z7
         9Geg==
X-Forwarded-Encrypted: i=1; AL+hErFRUsaDWatGOiW0a90qXlOY9CzDuzNxAAkfp+rkjsh3OBkdiyF1ZEXPcHAfq3siO4FL3QbWssJmrA2aNqAZ+87z4bg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rHgrn3n6eqY+nMpu9I1gNlBiU8hKaT1rndXEl2Zm76IxkAfnk
	gRDk7brWj3UrIEhhC0KFWnwCifhTZ1Gyvyqj5Y6xZpOlklSTfhKtdkxJ
X-Gm-Gg: AYBFou21SDX3boYYqPE7ZxvgFZNhBJw+etZvPwxDi+RZya8ov6SmaHSjXaDrpwuHIs5
	UlOw0/vM9r1OsOrFi+jwL1BW8JcKZEBabnDucRD+7f7lsP0IFYY3bnMuhppfpGBLU/tQXg/Vw1M
	v6hdfy1qEGpxXK9OmsgiI7wxgdDXEN+V+MHs4NCahSeB8VrV+yHJ2ybjt0tRwYOP7QQhjEgNVwj
	zkGb5vvfY5bpeiM5jtaoYqMHgf5l7wKscq3WtRMdxx10+VFXCBuKeUMBmbA7kVEXvBD0sJFrbI9
	qPSl6bHxatA0UrWCyR3w1O5Ut2Z/VbMFLzE++fdKGmW9iTk5XhIPuk+e1I6E7CiK/q6jKAh0Tjx
	Jz3GWFmfz8TbM5lorqLmInmD4fE0/kXnL3gfMD8X6tHSTvJaD7ruF4yysJWM6CnWHOD2396NaVb
	fr58DbGl9wkC90iuxBt9NJ2ZPnpzi0CwZedA1St6byUrg9/hEAqzjC4Gy8tWPL5YcJHqVMEN5lV
	GqPmvPDIJNggW5tRx6MZbkQPf+Ee33mGmHHZRFPPQHpFu1rJGgqUz5arcsMzYiN+tuMNZELjaE5
	vEkPN6YlS3EfEzCCYvPcsY+yXh7+Wvgu0uNyZ0v1EGbwinez3SfFmmnivzhWXQNzKZuflbl+sJn
	m
X-Received: by 2002:a05:600c:4e0e:b0:4a1:da58:1ee with SMTP id 5b1f17b1804b1-4bb88938dc9mr73795085e9.31.1795179996992;
        Fri, 20 Nov 2026 05:06:36 -0800 (PST)
Received: from ubuntu-nuremberg ([2a01:4f8:1c1b:70eb::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a9846sm133317135e9.11.2026.11.20.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:06:36 -0800 (PST)
From: Reza Ghanbari <ghanbari.reza94@gmail.com>
To: Keenan Dong <keenanat2000@gmail.com>
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	andrii@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ming.jvle@gmail.com
Subject: Re: [PATCH] uprobes: clear extra_consumers before pooling return instances
Date: Fri, 20 Nov 2026 13:06:19 +0000
Message-ID: <20261120130619.738336-1-ghanbari.reza94@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408100247.2065245-1-keenanat2000@gmail.com>
References: <20260408100247.2065245-1-keenanat2000@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Keenan, all,

I ran into this crash on my own and can confirm your patch fixes it, so
here is a Tested-by.

I was seeing it on an unpatched 6.18.63 (kernel.org source, built with a
Debian 13 config). With libfakechroot in /etc/ld.so.preload and a couple
of "setarch -R ls" loops running, I attach entry and return uprobes with
bpftrace to libfakechroot and to the same functions in libc, detaching
and reattaching every few seconds. The kernel oopses in handler_chain()
under krealloc() within a minute or so, which is the extra_consumers
path your patch is about. I haven't pinned down exactly which probes end
up sharing an address in this setup.

With only your patch on top of 6.18.63, the same probes ran 20
attach/detach cycles with no oops, and a fork-heavy variant ran 40 more,
also clean. 6.12.117 doesn't crash, which fits the Fixes: tag.

One more thing: Keke Ming's v2 for dup_return_instance() has a hunk that
clears extra_consumers when cons_cnt <= 1. With only your patch applied
the fork-heavy runs were clean, so I haven't seen a need for that hunk
for this crash.

I can send the reproducer and a full splat if that would help.

Tested-by: Reza Ghanbari <ghanbari.reza94@gmail.com>

Thanks,
Reza
