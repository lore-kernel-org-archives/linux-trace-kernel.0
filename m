Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122711;
	b=jfwsIIxsRU+2gjfLxjKnVB1DjLJKoB3cVPgVP+QX7Lfs5N0I26ptQr6o6UtQhp3gUXhE
	 ZIdVwDa8lF5CXVfOvcdQgUWpDDRBscGS3vISkNAtfN4VUfVGcE89g+o2D5SaUW4PkX6sw
	 P5BGkywlc6ZBwddiDglXT3SF6HjH4OkL6fuPIYpJThPIQsddBOePW8o95TW0O+W5pEygf
	 qKcwnA/vPM7R2C18gM4UKrqwzv0tNQZIWacY+s122oDSFEN4E0L1vlJr1wNoPD0mLKQnd
	 AkSThW/oLKLB8u8OW37m8f6VG8B1tq5XkNPbUSn93EvbyKXFcPJ/UZDupjUl9aRpC7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dop4F8OKR7cXm1nUzbyU2g5S5dDo+bHScDg3mp5FzUA=;
	b=zvwPCdipm3SJa2ioBZ2if+OrE8nq517hdGHGopgAotBkmVsh8+7q4hhG8RKB6tebZs3Y
	 BZYKA761uMMHK4lrBWAMEMHfOQ8o8RtCWiYImb5GBvZIPeDu2NWf/IoTIyI3TnygMMwj8
	 4wNXTixgNqOJpm1L76WJ/A2wo7ScITMsBB9LEC3mfpibPbvvRf11KnW/1w8i/5bQq3zb2
	 tGvxvNthpDR+wHKrIittKlUHuoDH97UEvEIgmKFw8P1dLr58inM7mylUqyyUEskqi7aer
	 ZqIUHsMopyQ/UF/ZT2mZi9DvpQBNSJr9wBGCQB6i9v/OEzi2hoJCE2kj4EApUsYKb0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KlWNEhc;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE9606A322
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Nov 2026 07:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFE9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0KlWNEhc
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36fb88ea38cso2830eec.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 23:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794122710; x=1794727510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dop4F8OKR7cXm1nUzbyU2g5S5dDo+bHScDg3mp5FzUA=;
        b=0KlWNEhccXytztXcpy8QDI9lEo0PCwVFU3u38U63n6E3HSrskIS1ZoHL5zE1ahXoOA
         Mwg5mx3WBDNu1bBTw/HUKVQ83wW6jFdSi3Et4OyKGo0pC3mlXYp7epQtek1zgT75kEod
         8PiiomRbBg2t81RKaJiSkW3QsAr4HmgGkGqhW6Y1dipfoiIAf6mNtWLukVfPilhdAMcb
         PKaXQ0d3GBJHy46n/1HYInRyJzZD89FNMuwtM7Sxd6295HZwv1fr+i0M5e2YRl5XsQbD
         QcmuaxSmb/mL/FuNb1Oe+W/b0oZoCcUJstHhQKExPS4En8BAQcYulKUdD9Yj9mYGqrgy
         USwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794122710; x=1794727510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dop4F8OKR7cXm1nUzbyU2g5S5dDo+bHScDg3mp5FzUA=;
        b=j8EsDjPtwGmgb1beotkAJzYJlYGVQfeonyCSy5N5kZSp89pWDp1lyVmtwBNua4J2Zv
         vIn3KFJwzEL9jB4CNLBPOoWBE3MhMAobaoI9Rm/5GZlFsrShwROKlxZeNHIZq70DsUdP
         1ugKlVIec6OeeG46oOwuiyRVI2Gp0h2MLmkclNEv2dEVBJmLYE3pknky+b13EPHad3Qz
         QIKFQNe671rG8aqrKYKvx3EB5Ewfxn4sKmxlbxHh0GNBb5rk6C5ikqAiBt9uMqNosDYs
         LhaWdLgUizmCcjo/xRlAWaZ28tj24Tv7r8MZQe0RwcWTUWD6as9opDj8zdndupCvNpIv
         lQ4g==
X-Forwarded-Encrypted: i=1; AL+hErE1mkLsYYT5ZFDj8z4LXroIoOwgBRnxkEkZaDjzpLeDVm0Sqiq7uajBmVF8IpW8UwOteWpQ10G4mM3E5wMGgg+9uOA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wiBvTb1Q1joBrGsyNY9Y+DryPdDhW2G/waUgm4dCwu6wxmnxM
	G0mwYw/W+fT6bV/YiFgTP+3BkjpabtL9HwM95FnXAzxhq0hRAOZY7SkO
X-Gm-Gg: AYBFou1qbhoBnT88D3gIQP0Hl1tU2xl5zFi6Lvrw7ZlTVlqZPahMrX2DweA8fB8+G2Z
	Q+RfRndPYRf386XCC2PVYOMcprRB2vVA7CPDT5q0D9tXs3m1w7xEM4TiQraSI0Wp3Fik2OOPl14
	wNdFmLdQPyvRrNm6EDO+6MLuZ1OttS1WuzyQY4sJuTdgE0Uw7hEtfFoeWUiiyFpr8GXDGoDmUAU
	R8RDvX1384IQCbBq8eTsC4srCjN+sjUh0H5zpBc9EU57jpgiUkz2y5NWx7GoONDwDSKQS2Ec3bU
	kFsETa0CLN63oPQ6gD2xe+/4ekRYFlg7WvstPm+lG/N76df/ETDksiB2UI7odFLx++GK0ixwpLJ
	SxLk7FvrXq6D7ZxNBPa2yNIbybdtIb8ZwOUV9RchEMzZuPK5tjSdcxXxF/94/dLeFP6+lNT9Sxa
	66z7zs5oGSb6EvkPbBuTZcjBTgrxIGxXRSCdqCfEj/naXlqI4enNCjPlwtQmpdFKdC7ntgviExy
	rcB7K3qtlkAQHezGXa40n8tQ/+VeH/0pYgkTrHPk48ApCzdMdxPR4Ir/PRu7YMBZB/5vzpYG1EN
	n9OuLIc2M9f0nuL78a1U/nEjzTeuxKXvrAoq3soZSm4Eh6ne6d18Skwcji2wKtrYy22Iiw==
X-Received: by 2002:a05:7301:1a11:b0:368:2c6d:ddfe with SMTP id 5a478bee46e88-370f6115a74mr6028007eec.9.1794122709628;
        Sat, 07 Nov 2026 23:25:09 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:5213:762b:b24:1be1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37265a16f9csm3499775eec.12.2026.11.07.23.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:25:08 -0800 (PST)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: lkp@intel.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	oe-kbuild-all@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [PATCH v8 2/5] tracing: Use the stackmap from the ftrace stack recording path
Date: Sun,  8 Nov 2026 15:24:48 +0800
Message-Id: <20261108072448.990755-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202611080654.sqFxIlwl-lkp@intel.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com> <20261107055139.3138633-3-lipengfei28@xiaomi.com> <202611080654.sqFxIlwl-lkp@intel.com>
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

On Sun, 08 Nov 2026 06:35:01 +0800, kernel test robot wrote:
> kernel/trace/trace.c: In function 'record_stackmap':
> include/linux/rcupdate.h:502:9: error: dereferencing pointer to incomplete type 'struct ftrace_stackmap'

struct ftrace_stackmap is only defined in trace_stackmap.c, and GCC
before 10 rejects typeof(*p) on the incomplete type in
rcu_dereference_sched(). I reproduced it with GCC 8.5.

v9 will move the rcu_dereference_sched() into
ftrace_stackmap_get_cookie(), which will take the trace_array instead
of the map.

-- Pengfei
