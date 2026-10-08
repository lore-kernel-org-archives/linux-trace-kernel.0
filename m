Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A43B14B6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479340; cv=none; b=PBr9UUscuLOvJ59hjzbC5SyJUrM4sAp7QVG5EnAltL3YbuAXCMtc9h/+hpXXDiPSnBpFUdMKHr1WVhI8X4gWsB6+E3yJRjmusMSnDCzJOOFOvpxsFoBO6GupM1IBMW+dAHGxD2sGwTR1cunv+RlrosIs0AcfJpkg6pgG4yPDdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479340; c=relaxed/simple;
	bh=uzc5djF85E//odOYdOjPt2GittKhdyE9SqtN99W2ky4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grcFZZ7EUqktgztb3Q3s/QOfXiPEFbot/wYvPOCyVM7QdsM1NrVeVtIR/HxRJHKWygV+mb/k0R6Ycl13hJiioQrA2NGjIuib18lH4JcLDrt1E0wtNFPmeECNxNV6b8+pxSQKU1dkoZMV6LIaaBg2wqaKaEGd182OWI/k9lq3938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqFU6Tj4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqFU6Tj4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso11553035e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Oct 2026 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479337; x=1792084137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZzFC0Gnqf5rubheTFydiqJ9yK61ie2+Ek+jk+ivkUU=;
        b=OqFU6Tj4844RAtOXRiQZFhIuhvFiFgK+WcpGkkPJyrbx8Cgw84W0UgzxhguYVnxfIg
         Y9pAuO3Vbf3B4rdD40W5eXr2Btytke94hePBtgLAOc1pg48/HAnYZljSGaptcQXhz2L+
         c5k3lWu3e4JSJrlCjmvaEGM6Pdzp5QXOHuXu4JRnfz3c/N2TgFATwup5SZ1xhULaZAmJ
         3awzf0lH3rjHYYnxShE6NXamrzWb0amqE5zCxhmep1qxRb+mdgILKwH7X9RyaPgjWN94
         /tPS3VEJQwtKr6NvrSkkmnW8l9DojPDsYoRjbFkVgtGx9uoQCQ/xpepXD/av0IZ4LEq0
         x5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479337; x=1792084137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZzFC0Gnqf5rubheTFydiqJ9yK61ie2+Ek+jk+ivkUU=;
        b=KDC5LIebEHqxVHcQ1AOshjxGvs+6XkFcutwnILAum2q1bWGm6ONIfvl5uJi6LG+9xU
         DJ262AEk6NGpJQ0HP2xiRBwmMrXQcN+sS00yzLmn5mpDeeAtAUedZ2ijSCu3WphWCBJh
         8EOv8GLDPggqboWYLjCPHbPmnnswJJl4WxNBqupV/TH7yiySFefUSIj71A/ecQ9AItbM
         x9q9aEJDXN5eqCAoe7q6uyBAp4ssqz1MMfqTLS0djyQMOprXuqK7oXROWPcJw4Xj1klR
         KmRaPaGA5L2wPQYaMc3QKoJZFKqaU/HNKnN/56PH4fcDJwdxKaKhpUoREeOdHh6Cyz+u
         aiig==
X-Forwarded-Encrypted: i=1; AKwUvBxRBN8MoAYNspNgjNIUx4wVV0fP71BNIu0PZ5pT95qIF68zyBS7icETSx+Hp7m60YM1935HYbSGX5dq6E8HU8WSE9c=@vger.kernel.org
X-Gm-Message-State: AFuF++kTh2wrAivuMsPjqp+ABEL837oDI9uh704jkb0SIlYs4H0sMXfQ
	+nOzU07TIIWbWzArZiM2doGr+1FVyQcIFJoyxTF0N8FEinFmrazUmUz4
X-Gm-Gg: AYBFou10uS3OHoVrE2FGiJVjn224sbA5dcmLuYGFWWPAZVeiffqIdDNYcaHDEWIPBdn
	SHETw4baiMqFxJHThbEV55ihlXXzU+AJTVWZ3JBsGJgrM6UncmYC+YE+Bvps4wW+eXff7oZTAen
	1RQ14R0vjezkxRxXa3FOUeNCc2UTmwtTqBagsdZXEm9/ggeEAOBmEgMaJNYwkKlSXN6zaS29mWs
	L6MRa3r+e3QjkPMApvSh/xGBbeQ2f0X6byjOXUEJ7TEXiiX19RceKkKBcT3lbNGZWTk8KR98naU
	G9UIZmP84BPeeHmP4lq9ayjTdfKsbddG1gCUvUO0q3mk5QICA0xOAos8z4LYLZqILEpgoqUs+44
	LosuD7FNcJZAbb+X6vIksaNQHD3HVSYX6/4OFplYc2yt8xFXeDwkzXQnLVU5MA01iUfSHsbsSgz
	+B1KdMkI/BGHgm3kPsvibCtgabPFR8dV/wt3Xe6MPSnWR3UGWn9+LiA72bJ9ICyYXCRGAAsjR1O
	uiEUWwDpTWNZoDqbZUfC7obk83WDQMt9fK/jJ7TxXAq0Q==
X-Received: by 2002:a05:600c:4755:b0:4a1:8963:b865 with SMTP id 5b1f17b1804b1-4a18963b9aemr17251305e9.1.1791479336435;
        Thu, 08 Oct 2026 10:08:56 -0700 (PDT)
Received: from ubuntu (ip-86-49-251-138.bb.vodafone.cz. [86.49.251.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843cb261sm84563085e9.3.2026.10.08.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:08:53 -0700 (PDT)
Sender: Alban Crequy <muadda@gmail.com>
From: Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <albancrequy@microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Alban Crequy <albancrequy@microsoft.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf syscall tracing"
Date: Thu,  8 Oct 2026 17:08:31 +0000
Message-ID: <20261008170831.49376-1-albancrequy@microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817150000.2@kernel.org>
References: <20260816133101.83109-1-admin@ptr1337.dev> <20260817150000.2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha, Peter,

Another data point: Ubuntu picked up the same backport in its 7.0 kernel (7.0.0-38-generic), and it breaks Inspektor Gadget and bpftrace in the same way. A BPF program on sys_enter_execve or sys_enter_openat only runs on CPU 0; sys_exit_* and sys_enter_close keep working on all CPUs. Reproducer:

  bpftrace -e 'tracepoint:syscalls:sys_enter_openat /comm == "cat"/ { @[cpu] = count(); }' &
  for c in $(seq 0 7); do taskset -c $c cat /etc/hostname >/dev/null; done

Only @[0] shows up.

I also tested v7.1.13 under QEMU with 4 CPUs, using a small cilium/ebpf test that counts per-CPU hits of a tracepoint program while running 10 syscalls pinned to each CPU:

  v7.1.13:          sys_enter_openat [10 0 0 0], sys_enter_close [10 10 10 10], sys_exit_openat [10 10 10 10]
  v7.1.13 + revert: sys_enter_openat [10 10 10 10], sys_enter_close [10 10 10 10], sys_exit_openat [10 10 10 10]

The revert looks right to me for 7.1.y, and for any other stable branch without 57918341dd19.

Tested-by: Alban Crequy <albancrequy@microsoft.com>

Alban
