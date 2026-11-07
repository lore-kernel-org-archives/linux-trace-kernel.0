Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794032950;
	b=TK7kgP9q0dA89PunTUFjmaQIXguZsy4/FaMgh+u++MW3aCZrfB9ptKWirMy/g1vz+5Ig
	 6xqmJOWnjogXxJTbXmcSwfLUfv6+r5KXWce3SS679f4xbUcappRpAEaCdlPMHU1Kutdqp
	 M6fkmNR37TAJj0DtkxrTGwHNPg4f9XjzR+llvBkc2MS9+O8rBjRZWzfvzJyb9XoqHjbU0
	 Pr3HsD6k50jVixdEEk8y+wAE9DOkdRx2whh45wALtI0w+QaTDQDjwZQ2iPE+FnyEFvp15
	 Qa+k7paPd9Acxu/PHyFDA56xING6PsjXv8MmU42xrDP/jjfSXQmo+/v0OXHwXR59opA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794032950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8O/YtBbFAPp5NwvDGteEcyHryQg3K8JIIIYVXGE7IUc=;
	b=oKdnyJOEzJl4cm9Qjtetms33tG9IEexm5K+9EjOWtK/kc2ziaeMsbfnO0WF/9mhgsHma
	 yt+zSXh1iRaRM0BRWMErgpb44Wjq8WYamI4KaFfXhqksm0PpPdv76Fz/KXbCkbbrZ7K28
	 uHOYiXXuA68fjBmw4TeEpXts9MDu+UdZF4jLj2FhCcsPJfuIcWCGeOveszA1l0a5ftx+o
	 p8ldTXO8wx8dWBbLm32ywu2/OTub24nH68Eukz2i/qu05MwKjUwkgeO5Qn+HgJJPbMIo2
	 EUJGYprXQL7UBYsoTE0FVhk5p9LeOfJ8+nwiosfktbAN7VyF1CSnbhJYYwklB+FUKqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYaIXDeD;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A02606A32E
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 06:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A02606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYaIXDeD
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b0a519049aso932084a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 22:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794032949; x=1794637749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8O/YtBbFAPp5NwvDGteEcyHryQg3K8JIIIYVXGE7IUc=;
        b=zYaIXDeD/ZWt27eZTb/FXR1Ei54NEXBrfYk0lGFzIrK04hqXvJbt4RY/udaYZwsuRF
         pMyL/ZYTBPrqyXZl0w51+VFcTtZ7uZpQXL/b1ngiI/AoXN62k2G2D4uwv/4WozQ5OREN
         uMUaMC/JE6irPYbMNmnLX/LBYefPbWV9imrAw7tL2WDIdrjnQM/gQRovFQUfj3D5AWRT
         PrAPoKzlbCKwQtN7ic3//ml8lfhdnvvt5VJJr/aMLo2YwyuB/glDtPWfRS/irwaFqocl
         7K4+eq4WN+t8Ve16MInu8F8YDxxrJRXhmShoMOifWYu6yg8Lee/oeY94kvUKfax0iZh1
         hIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794032949; x=1794637749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8O/YtBbFAPp5NwvDGteEcyHryQg3K8JIIIYVXGE7IUc=;
        b=RUpr+vlmpwCgrm9Ps1si4tozYF3Kjc7H1jtUTWyzIVGdknk9IrGWfVhxWyn0qFgw+Y
         DIgTlQijM8Ggrg6UiPSy5rBkzRn7M1DGxX7F3W8yLriQn8zk6ceHI9Uze+avrcW6Vit3
         5t81efRXReN0+oVjF9NbKrvbPCT1Gii7PeNuswaMtV+vQm3jqWnIyWYos1xXbvarsLKy
         aFNEL+G1a8+JuvnTMBn6QmrIiNdPSAMJTb5Zva3JrTax/0pYmyiGyQEwLBjvS4klx+WC
         Bf+7KstEvxVEGLDvp3i04UBhy5OEffDkdGWhnrCjB8OyPkepY+njQLSd/lAFm4+gj/jG
         y15Q==
X-Forwarded-Encrypted: i=1; AL+hErGvqLP+M5mmncZ6/r3VWuiFw/dhUNwC4rKCqIYZYoppNVmq5qusE+yPd0u5o/gd0CrqWJR39xwh3v7ronei8Yz7G5A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ae2ZYPfuJiX63LcJnjeUnUF7Ntp9WPRHsQ+M+rnbi5Gs23rFx
	CV3ac89IPUgdxE46G/54buc23LsUILep61mzPCi/4Bb8OQotXiLyefZz
X-Gm-Gg: AYBFou23+hPByy9DJSLnbR0v6ARE/XPc3HwvHLcz0ZYG2rHFxn91uto/hq6ASDKAs/D
	PYn4VzQNBynGS5ruIF1YNQGnTpwOfHMpX30vb5fcoe5OsOd4p4p7ri5VmjwxUeQC2jjB66xhsaN
	fIWOCconbbl7hOakn9BS/b2EsefDJrUlmvyiIEQGXi3upHXuUybYEWALvmEnzDlJJOQnrinXmWq
	ZMnoDfgvSjRnZiOPshgpdaH+VkQSrgGEbi8gFPz0PepDW5BYpHXqDSdfsUcplM6zFAaDCHdVKuk
	h7C3wNZloY0bxcaIe85ZLA1L6W1rZcTzwGz+PV0bc5FbLsW0UKEndReHdYmqVThtL4P9T+SG188
	ECrFFpPVs4UsgQHg+8XIoaLTv2ukIN15QkznyPtm9+DpSz/3x5r3eXpRaeQJSYwsiTgN8TrFWHo
	c+vyU3mZj/UQtmH6ZsFT2Te9g7j/T8FDpz1l8tS22BYC/HhEW3HB1WdhyXvaWJTTs0h5yMALAcV
	KCXcFLqy46AF7AkGh4hVBRSNUmv0E6aQGyeg4FsBcF3WutboH3u4FqtqhpWGhOHulU45UgU8Upt
	pVTPCgtTnIAvUXMqoU6ySMkUG5gEWL9CDrcuuDEpEBr07D8OPP3oygIHLJgMWZ8+YMKAHJo=
X-Received: by 2002:a17:90b:4a89:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3b0db6fbf17mr4900373a91.53.1794032949623;
        Fri, 06 Nov 2026 22:29:09 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm2307453a91.15.2026.11.06.22.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:29:09 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [PATCH v8 5/5] selftests/ftrace: Add a stackmap basic functionality test
Date: Sat,  7 Nov 2026 14:28:51 +0800
Message-Id: <20261107062851.3367923-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <sashiko-outbox-202648@kernel.org>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com> <20261107055139.3138633-6-lipengfei28@xiaomi.com> <sashiko-outbox-202648@kernel.org>
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

On Sat, 07 Nov 2026 06:07:50 +0000, sashiko-bot@kernel.org wrote:

> Can clear_trace race with the resumed worker and leave the trace ring
> buffer empty when max_ref reaches 2?

Yes. Hits recorded between enable_tracing and clear_trace raise ref but
their cookies are cleared. The worker switches every 10 ms, so in
practice more events follow before tracing is disabled, but the test
should not depend on that. The next version clears the trace while the
worker is stopped and tracing is off, before resuming it on the last
iteration.

Thanks,
Pengfei Li
