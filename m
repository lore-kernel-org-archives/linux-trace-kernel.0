Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030013;
	b=LFEFdNlzcMe7kSSTFsbEgZ5dkzQxb9+cySoOvYlW16Om8/6wVH6VzWI1WQc5sKcsTP50
	 eEwSOuipm81uxlZi9kMGLQ44e4oMrQSAGfi/xO8wO1W3XZKaxSWKPm3t4cFcnCmP5KuMW
	 iqbdyf/fVBMyv4WaeERdNj2/vRlOSKI0cqeuHOXm/aisU1YuMdkHKVdoY7A2wlO+4+6xG
	 4dKzyhl37hVrABsLfk/4Q+8Leo4twteU/C/AoY10hRhuQHMlR3WYh2swk03eyIepuiKvC
	 DCBum/bW+kmh0mb0HiuY0Cpfc2E1CGJAMlS5JgzkPL9hyfdgUacYarUzf9uk0Pm9gxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n07BclH5UCpfeNF6l7UkFRCz0CaPQfb02nzFrlh13A8=;
	b=QRphOLGMc54JLUvBAFJ01b/Tms0Vjn9yHvmJ9+ioAFwJAj99f96zg7mgOoL4FH+Yu3Zd
	 jThdAWgVWakMiwMVXHV3NM0qTA/EztNvga8tBGqIu8aGv287PhCkCJG2c7qSxcT2H90Sw
	 HppjHZayMdRmJ5FxuH+BPwJqae1A73vzmBDD3zcvyxfUoyrJzy3T1D7qmmqMtRD11fm9J
	 HEbH6YykqBMIARg7qdk91aATsLFDg7fW0cBGMFg39gvQ4eLKZiAo67kGpflEhKyri8qi3
	 HA7PTZ9JAfhocsvJ3wj2cTHNLfcHIIQH7qFh3jXESgZw0DF7HphKPhM4871yy8QX1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJWcWfEL;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A1606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB8A1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sJWcWfEL
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9d7791b00so9768025ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030012; x=1794634812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n07BclH5UCpfeNF6l7UkFRCz0CaPQfb02nzFrlh13A8=;
        b=sJWcWfELjWnmPKnlNLqGiGA9IT8I/5hSE/TtEHyDveF88BOLxQWRKZTy+XmrZwfOVj
         6SHdPkiKpJxyGVajxyZXDAJNOLm1YneO0Wsmw76rvTlCP6JpJq7kIh7hKUE8w9LH3wcl
         oiErSBdoBO2Z0m57+3+ugZtOv8Eo+fy7TevfteP2bg7wzCKQnsvYP3pvod1iTxvMPx1P
         HxrsvidioOJJzf9bQmkzf42dLqQuhAluXTAhswCBjZtCamyB8Kk0e1sbbH926CpEeIvi
         vwIM8rzJ+O0LXNtL77KfGuuh4KESAx+F6yC9WSpVYk4BA6x5+H5UmkRE3gmN4tTO2vGc
         pYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030012; x=1794634812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n07BclH5UCpfeNF6l7UkFRCz0CaPQfb02nzFrlh13A8=;
        b=HCFugzmedXxzVVN8I5UMs6vdwmfGJbaUj6QSJxjyBKKoaNPeHOK8teCMhS7W4GE+KB
         swNfhPC2BQSs1OlRXOam9PFxOu2LbfI7P1HNgdjfAUIIGBW/RSQPZ6lK+uWcxNWTHmVp
         2CyO3qdf0T8T3dvdAfunjRFyquLrCBXdMkPHdxur217lUpNagWR3fPRcxi+ar5+ny11X
         SS7aAf+vEcN/rzu2cC3EBpmk3HDbAskEE9HVlfXDMtJe/FZfj5KjRJahcKixP8tJ2tai
         OdUImW57SXPYe6XFrN34+8nFv2pY+wd/IUHyzh78u26bpR2e8LEtj4rHcd9k9eubCZ/4
         0P5g==
X-Forwarded-Encrypted: i=1; AL+hErEcEwu+GvLW0koK6vC3BgIo3+X3Jvq4OP/ygNa8nPIpKIYuCzP+JowZz7w/H1uIhRGH0LL5PgDteaHicNx5l2QPwxM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b/4eXk2BKQ4Omu82YqDjR8RMLgPQbQE3+imDi7uoykyA50Q1v
	g9YzmYzZ+sOBGp23wde/oIS3RTaq3yC0EpEvRZAPzJPUXFX1tm/c83sy
X-Gm-Gg: AYBFou2kJmCxTmiSn9O8SR7gGFhFqAZCVflz8A0OxZh8egRwJP6jyA6hs49HExwCrFq
	Zq0iJ22pbDDoCbut7rMpY2jJzk3gA4p8uz8tUrNlNF1n9eriTsEdJIQaWHHi6UOHgcBIfvSMJFX
	CDCNsUklaFp0RqkYtUtXr0/5Rc2C8Cixh8b1wElTtXkuY2y4rf4avb/X9Jh2ZuHbttiVZ2gb4DZ
	T6OGJyVPO1VXEZoafDPWxmFk5qIAWcIVx4QzAJkvFbYWi9gSljjkzfhwi3KYRRJ6EQUqyMlJaxx
	Qk5j/8MDMCZ+tpy4PkJE8IK2OSUhCfpRpkmmLuZHTcLTL9VrxuC5tFm3LOCsbXOMPK1RR8ylK+s
	nAvTADnperiCejQ9Aj7Srx4wAl7vbJLiWpDM1woZEn/8QijcoMnT2sIUGhyOs4ddnHZIqP6YSR3
	gkDZx8UpoGC4tQ8fn4k6xl11SjCZBBH/NheaNdcGmBVHHO46b5r38kjDZu7ahSZVX4Iqh+dDEcJ
	9QN7U09OTKaSmCvhBWV9pdtI/tYqrNF70nNIstXuzcPsLRovWkFZa2KSL2P7GV8aqqKu58Rve2i
	jwK+b7G/F1PFrCEe+/93uB3pfQBD7M349bN/hGsMZ47IHa2zwaLBU5dV+tAhlMvp3/hB1Q==
X-Received: by 2002:a17:903:13cf:b0:2ea:19bc:2fe2 with SMTP id d9443c01a7336-2ed404dd277mr59480405ad.10.1794030012078;
        Fri, 06 Nov 2026 21:40:12 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da11afsm10992515ad.72.2026.11.06.21.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:40:11 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v7 01/10] trace: add lock-free stackmap for stack trace deduplication
Date: Sat,  7 Nov 2026 13:39:54 +0800
Message-Id: <20261107053954.3075147-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103174905.701e078a@gandalf.local.home>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com> <20260912083753.3426176-2-lipengfei28@xiaomi.com> <20261103174905.701e078a@gandalf.local.home>
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

From: Pengfei Li <lipengfei28@xiaomi.com>

On Tue, 3 Nov 2026 17:49:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Let's get rid of using rcu_tasks_rude. If RCU isn't watching, then we
> simply discard the stack trace. We do not want to add any more code that
> relies on it. If an architecture wants this feature, then it needs to
> update to not allow tracing without RCU watching.

OK. v8 checks rcu_is_watching() before it loads the map and only uses
synchronize_rcu() for reset and free. When RCU is not watching, the
stack is discarded.

> There's no reason to use a rw semaphore here. Just use a mutex. It's
> serializing the reads of the stackmaps from user space right? There's no
> reason to have more than one reader at a time.

Yes. v8 uses a mutex.

> Instead of duplicating the open coded free in ftrace_stackmap_create(),
> move this ftrace_stackmap_destroy() above that function and call it on fail.

Done in v8.

> The above paragraph is unnecessary here. If you want to add it to kernel
> docs where it is user visible, then fine. (I haven't looked yet if you
> already did).

The docs cover it, so the paragraph goes.

Thanks,
Pengfei Li
