Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A64A8A04
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441781; cv=none; b=dU73gzpQFArLNydwn56F6fGQEZP1IQLEWPuPq8UsfB3KEluOIjFmkp5XWNlYubLhYuTxwUurQ9zkNsKe8IaY6kcB9LXt7fzXqelAntEr1IJQaqSc/7fviRSqZSoVSlzkT9Y3WFXT198gKIU495l3ALMtpI8UrDwX8x/MgZIycuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441781; c=relaxed/simple;
	bh=PEVmRGy5gh+Dt/A4TY4uR2plBY2Ml8HO3HylSTnFYAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gw75QAiqPbNAvK2cr22HVwI/pTruyEPRg1GIySO1tFaOY9HvDHkNRWLhAZ2Yeoh3TszCURszpLxMmJI4lKabf8U5m4O5w+vjLJU5x/lAVGOXQ0bpB4kxPYv/xKZhYApAaImK4M/aBCp+gNPu02YTkv/QLDBIvwdjyVWx5htUrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ0v9ClJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ0v9ClJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso11380235ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788441760; x=1789046560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PEVmRGy5gh+Dt/A4TY4uR2plBY2Ml8HO3HylSTnFYAU=;
        b=PQ0v9ClJwGnNAL9W9dhdGGBqcqt/2hF5QdXtNot+yC8cAncwQCTuT7Ij10so9uR+GH
         zYooH5Biw2X5uaRB7Fcxmn7okalDm8DR/Dx8qV3EdkW5eqLdVyO9TWg07anc9CeKHXfc
         C0CG5Kd2PuUxZ8t/Xh6IPJ+6YXivvVutEfpyAEiWGldEheS6TNccklLQ+XZzaPQu0V/A
         h8ktpuV0k4qozSRCD/3j1AR9RrS/8Ql8XqcGrRhIshGV5p6zbwNWJOq2LFKemQ0od0mX
         omPj8AFEYP5A59Smv/lJEjyegdr1IMN6ulUxRzKVb1mh51nsukBa8i6GVMSD4ukyHwIB
         HxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441760; x=1789046560;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PEVmRGy5gh+Dt/A4TY4uR2plBY2Ml8HO3HylSTnFYAU=;
        b=NxEBTq/tXKdNhsJxltqb5Re8scnfeyCJe/A+9hc0Drmt+EWa/M9aWJXO0FTF/XkFNb
         o/+oQx/cms4Yb55exwbiCwCxUDxuXFPxvE4GQ4D3n2jIKj2vU96C/v/JkNe2eZPGYa1H
         eomokRY5RZqcIHDhb/iQ1JBugHTSt9ww6l13sM4BAg2200GXJyPN31QRfptWlz/QCp/R
         v0E9ZegaWRm1z8CVrAY3L2WNb9Z51CywEwWNT8g9JBZlqxS0XEadjHIdCYmsEPQnxqtA
         ObQg9RtPrkZaVanyrGOED0I7Gg3Hxv5WYOInJ7Zx90lEjRj2NmyQbGghy6ZoE+UrQeEE
         /5NA==
X-Forwarded-Encrypted: i=1; AKwUvBxpFDSF9tFmMK83xYl9js5og9ixlEYgfwAH4ZBj6RznYXa5SYvSRtfXP/RcEPGwEkzuvZu0KjpKgDk6rJhGGHA7qBM=@vger.kernel.org
X-Gm-Message-State: AFuF++m+xmS8o+mf3iZ/Nhzps00UuYe633FBxcGYEmDSpnR5cRyCb2fh
	/c9P3XUg/mW20zeBDpjgkhK2XyOyrHiKhDkQOHAbo0jad1jq8G4Jn++K
X-Gm-Gg: AYBFou1fPBBlSXxaOsRr/oOKfnrYV06nN1zylPSNJmTvW1B85oxlwRFS5+mXOX+vYnf
	WU9MREpWcUETIGL8EKXUn+stUlskkdMGzeKOZQI0B6e7mEmXB67ARzecOw7EFHkme6DYk09fgQO
	8k0o2a3Yh7bhhtjhyNOVccgH6cG//0La39CAF0XF04onPvKy3E24ZU65Lh6mjr9CTE+0IYiMFBL
	191w1TgEK6KuI9426bzwJxwSjLqANjiK37MbOTbhPZ4NjZD5Jrjmcf5Y5EWTKq2P3ubhhgvHDb4
	DkffWqdJyeIgiNtn/ga1EsAM470rgp/jTYrF4JEOySfgqQLLToy7BE8ALvC10vkcbgJP3Ghk3JI
	T+m3Ro4ebYjpBSwZI6pOMMqU6MqCIK3fb9iK8R22k1ednLCw1o0+bwBNQLm+toI0mBFtPLz+HJA
	ZngJHBCN7AlkW7tICstf9yHlSq2jHE7HUgB8zw6Bh2B7QjRwn/nIH5Z5t0h+SmjNsPlDrabSzx4
	ak=
X-Received: by 2002:a17:903:1b44:b0:2d8:d4d2:d135 with SMTP id d9443c01a7336-2dafb1061cfmr56943085ad.17.1788441760409;
        Thu, 03 Sep 2026 06:22:40 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:d43b:6dcd:a4e9:1d79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62d1b4sm9977395ad.18.2026.09.03.06.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:22:39 -0700 (PDT)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/3] trace: add documentation, selftest and tooling for stackmap
Date: Thu,  3 Sep 2026 21:22:21 +0800
Message-Id: <20260903132221.256923-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902065127.662BC1F000E9@smtp.kernel.org>
References: <20260902064242.28606-1-lipengfei28@xiaomi.com> <20260902064242.28606-4-lipengfei28@xiaomi.com> <20260902065127.662BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Sep 2026 06:51:26 +0000 sashiko-bot@kernel.org wrote:
> Is the documentation correct, or is the commit message correct?

The documentation and the selftests are correct. The commit message was
stale.

Reset clears the map and nothing else: it may run while tracing is
active and leaves the ring buffer untouched. That is what the code,
Documentation/trace/ftrace-stackmap.rst, stackmap-basic.tc and
stackmap-reset.tc all implement. The v5 commit message still described
the earlier design that required tracing to be stopped and cleared the
buffer, which was dropped after Steven's feedback on the v4 thread
(https://lore.kernel.org/all/20260821235129.078dd489@fedora/). v6
corrects the commit message on all three patches.

> Would it make sense to add a similar cleanup trap here

Yes. stackmap-instance-gate.tc now installs an EXIT cleanup trap
instead of relying on the manual rmdir in fail(). It also records
whether this test created instances/test_stackmap_gate, so cleanup
removes the instance only in that case and a pre-existing instance is
never removed on mkdir failure.

Pengfei
