Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706EA217F40
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jan 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416250; cv=none; b=J1Km1ZXAN4VKx5T8BBRew9lPBmvkXEpmogdnIzM+k8mIsgk22W+N9CQ+sHyGUszHkP1rfOmG4p06RLP++ZawTuTy7iGdp9I17H0lVKSMhiMs06fKfUtc8TTWGlziUGwSrf7UMqwLmdyDKcz3JJh7+i1CDhBb57jbrwvYfNCOlsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416250; c=relaxed/simple;
	bh=vD/OIJah7fJrKQATARyY66obbiZXWKJJJFBgCbg0WJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEJhy1Vnw00/ugVjaOWHpFj4qAdG84B0jMjURzC/chqnvpjJxVkPLqFlEW4/gg1o/eA7prRjVcVX/UIQd1PbyE7PDXeR2cGbR3hAgLvKJLHtLsMRSgx2JakJKRF7R665gfj/UAkfD29BVvCq2WtNJDQxr+UtnM6vIXVV6vIUTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWZVBhDT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWZVBhDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736416247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vD/OIJah7fJrKQATARyY66obbiZXWKJJJFBgCbg0WJs=;
	b=gWZVBhDTMp3tqWG4KMDEaIbDGri31xJ4K8+68Bq5Gdd2mXEY/I6fSulBOBY0PxvrW6DkIg
	H6syiOnQks0MAn2EclrZiTCBoiv6FBsvq5BWOmjOpOT63Erzl7BNWbOTRRUVpGffpvyKUg
	c8hYeoHQ2Ve14TqD42tN+kBTa4kDDoY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-JQ92iJOxPxi6v12F-54E4A-1; Thu, 09 Jan 2025 04:50:46 -0500
X-MC-Unique: JQ92iJOxPxi6v12F-54E4A-1
X-Mimecast-MFC-AGG-ID: JQ92iJOxPxi6v12F-54E4A
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa63b02c69cso169729866b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jan 2025 01:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736416244; x=1737021044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vD/OIJah7fJrKQATARyY66obbiZXWKJJJFBgCbg0WJs=;
        b=CW119U80bYX5/mrHxBu2MHEa4UZnWsTMQbuxWJk8hdKmVVYbBa3YZ2uu1OU9fzLXSG
         56YVWn/O86JCy7IHu7cCWxCERY/sxhaJxuU+trx5lX9T2mmgdd+1R6h9C4q/zTE3xdv3
         20xzP9aniMYMkI2M8qO8/RLqo0EsdEYG9DV8zaYMucj85gnDRmGThKtU+OlLF/trT1R+
         qjTpZ87aRaa5QopKjp7xV5iU7wyVbbQyLhkmajp7PlwnQxOgjXUgfQfS1HyZrhUHX5Q2
         +yYxUyHbQ7II2U5bDnmLaUVBPtvBfVOgMOca/dXh4LoDDctjx3eP3SKhFNP/YPZSvHso
         c32g==
X-Gm-Message-State: AOJu0YwlhxYgwUB4n48QNEen4eyRzmlhSBZzDmt/jTy2/DCH5j9kQU6w
	57+Gzf8nh6G/YF95pcGAZ2SjwEywFr5RpVUpIj3+IccCOLhm/ldRZBJ0sZICYrLnHe4YWZkNSt+
	an1JcrivYZYu7KXKEAbgaa2V3SkfbUcYrGwKlgQiT36nrU9wxZwt0Mz5X+c1xzb0r5EEAeRnShc
	A9FeWVOOFQMQg9OOSXwiiiAtmCu3JK4wY4DPOg8cAQ1B9IAwFEOrIRp1s=
X-Gm-Gg: ASbGncvyrMtkV4X/8udMIUscdGLfAk1B7xNK3HRTnAp6d0+4KoOwR3LVpgkmIKkU1e1
	bwgaUqIWzMQdH7VZonrM1qBpSQ+zS7iqojND1iw==
X-Received: by 2002:a17:907:7b86:b0:aa6:8dcb:365b with SMTP id a640c23a62f3a-ab2c3c5c979mr188172966b.5.1736416244378;
        Thu, 09 Jan 2025 01:50:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUt637cJ8ppsQkkNxsJKMjnqy1zlfTMRZ//LBFVaTULYxUmxM/AeLQJty/L8yieQSpRPVL6Py3H2VCwdaBlH4=
X-Received: by 2002:a17:907:7b86:b0:aa6:8dcb:365b with SMTP id
 a640c23a62f3a-ab2c3c5c979mr188171566b.5.1736416244042; Thu, 09 Jan 2025
 01:50:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107144823.239782-1-tglozar@redhat.com> <20250107164450.75f0adb0@gandalf.local.home>
In-Reply-To: <20250107164450.75f0adb0@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 9 Jan 2025 10:50:33 +0100
X-Gm-Features: AbW1kvb28nM9l91BL91fDWM7QulbCDkcVQkAVcBNMoGwvGuFnNTXywozGcgV0dY
Message-ID: <CAP4=nvRCw_2hKPUyd7obZv2Xho_mjdSC7EmozFsoeS0OZC9xaA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rtla/timerlat: Set OSNOISE_WORKLOAD for kernel threads
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AR4-XVkz6kKBsMx2YOi3czBKJfiAGEFuSaCFB2jUOKk_1736416245
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 7. 1. 2025 v 22:43 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> BTW, are you going to be implementing any selftests for rtla so that it i=
s
> easy to test these changes and check for regressions?

Ah right, I promised that some time ago. I have a simple test suite
adapted from CKI tests [1] that is close to being ready, I was having
some doubts about the implementation, but I will send it after adding
a few comments into the code so it can be discussed.

I have discovered already through the tests that this OSNOISE_WORKLOAD
issue also affects rtla-osnoise, not only rtla-timerlat, so it is
definitely at least somehow useful.

[1] - https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/b=
lob/main/rt-tests/us/rtla/

> -- Steve
>

Tomas

