Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8D3EF651
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142533; cv=none; b=UGdkqmmVJHnHvOBIlQBx31gD+oSkRCxOiCcOEMBDkY88h18ELTxxzhV04ZNvvzMKrM/ItAFKYrialKPqoMU31+lFY0tMDOYE5mJI13nisEaPo8E/arhQKJXMMwpQ/Y1D2Bx0nt4iv9nTit0y3pSpaUqqr6ePHojIszIty7Z74f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142533; c=relaxed/simple;
	bh=Us4qCC8eMdzVqJpe55bYalmTA1Rs6HCke9ltwTB4CPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URaxHYMPkyQDU+YaFbfU83Odwy1ZEEnmw/kzUtKJqhpY0X6tIvhTQ2lIi0wSOvLQ0Jc3op7r6irtF+91uvGZNIb/b28oUSGPGMHRCquF33xJ60Dt34Ipxr2Ivf9Na2KxvFtI0CBjB7xeMFPqxagzT5wHGTOOUBtSD8rM3LSZDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YajvFj8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YajvFj8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775142531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Us4qCC8eMdzVqJpe55bYalmTA1Rs6HCke9ltwTB4CPI=;
	b=YajvFj8JuyuxrtvPgxEaPHVIJOBSOnsmFeonq/DaIQtZj9iPhoPtBh8ZQrjXyxrWoU3zt9
	SxChjy6N+9gLlAch3oHExA7BL3SyNQKgLo9RJNFpnWPnPZGd1EUfHZ98Uf7fDmkkarlKXo
	Y1eEIusQA81dCWcf3tp/OthTjy1S42c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-V-JukfWoMLSAwfUf2YGOPA-1; Thu, 02 Apr 2026 11:08:50 -0400
X-MC-Unique: V-JukfWoMLSAwfUf2YGOPA-1
X-Mimecast-MFC-AGG-ID: V-JukfWoMLSAwfUf2YGOPA_1775142529
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-66e2fa66696so341603a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 08:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142529; x=1775747329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Us4qCC8eMdzVqJpe55bYalmTA1Rs6HCke9ltwTB4CPI=;
        b=PMJpWZWyiK17kcRGdteYt8I9CI5VRsItaRuupq1FAlxFXvNgkiy/wop1ii/yrhLoee
         krcBSvAcz/IYOHmBzkppC3Ul6xwSO51VeNrlFkSdWM3si8v/olti6T+5fBSzaFBR9mO7
         2vhoSWp2xccl2MmJfeIG3FDMcTs5K5bxz36rTYrr3WLQVOdcS6tVt+IAzKeD8KceeSol
         OkQ48Q3J8mUCAcStdY5Hbg7AdeN/CFQ+LIBiuekqC/ixk+tO8M53w8enDarqbtg9CZ75
         aZm+yuXAqRjyT7rcHmI1VouiMN7VfTOz8cWZvHL7zZaeuyTivhpdW6jnI+8TjVhasEkt
         qbZA==
X-Forwarded-Encrypted: i=1; AJvYcCXuPYenm43stMxwEqh5CXY+5LNM8toKpM7RKe383BZeQNl5Ud6md9YRlcN/7YLRpqyxGVzIFpWrOdaR+VUjK3CexDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1xO78J1ayAj4kjQpVKw2PW5mMXoyJnLNsHB2fvl8+YYEP6PDP
	NLPNTMNnB1dg3B3pSU2YIcAxJetQRaRD1xGFvGWnhYetbvo0hPfaeyYxx/9lJfF1e20ajdK+IDT
	vVSo61rV+psBXuFaQpv0Hss8sOuep0WfRpaAxQnhMupZa61SX5jLTEC61Ff83Spkbkmj/7YNE96
	phxbLocCmVfl2oIwqwx6OLUnhy6SEqSWRUhoSfUXkpH+S2A7Cp
X-Gm-Gg: ATEYQzxIPnXfUfibFbg1FJVqJ2JGAXv29YcH7skdCGTLBq5rlF/HBIFUVAC511FbIPC
	Czwcr/D9SRkxfCg3ODVrH2fUJODQp8xAdllPtcRh4+UbOiCcY5Vm3bu4JF8bAIQpEzSqMqxStGD
	cRP3PHAqJMrAc+Znx3NjrUV1IK6j/7idoktDmbv+B3EdIQyQeewhSyTicjFb4X0A8XqHJN4tXWq
	22rGA==
X-Received: by 2002:a17:907:8285:b0:b98:6926:13a5 with SMTP id a640c23a62f3a-b9c13cc864amr391371566b.46.1775142529078;
        Thu, 02 Apr 2026 08:08:49 -0700 (PDT)
X-Received: by 2002:a17:907:8285:b0:b98:6926:13a5 with SMTP id
 a640c23a62f3a-b9c13cc864amr391370166b.46.1775142528560; Thu, 02 Apr 2026
 08:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327150237.405973-1-tglozar@redhat.com> <20260329122202.65a8b575@robin>
In-Reply-To: <20260329122202.65a8b575@robin>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Apr 2026 17:08:36 +0200
X-Gm-Features: AQROBzBmQybi6CU4WrpBPQMm0orH_UKuo45R40h7YV20ge5CGkONno5oukVV_Is
Message-ID: <CAP4=nvRZ2iEVxSgwHwumgonrhdvkYiG9KsCh0S2kwBwnemMi6A@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA changes for v7.1
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C3d3u7rZHjhLXlzHZboxmV7YeFIuIxnuUzSMFp2Jzqg_1775142529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 29. 3. 2026 v 18:22 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org>=
 napsal:
>
> That should probably be fixed on top of v7.0-rcX so that it is not
> broken in 7.0.
>
> -- Steve
>

After merging the fix for 7.0 [1], there's now a context difference
caused by commit ea06305ff9920 (tools/rtla: Remove unneeded nr_cpus
arguments) on merging rtla-v7.1 onto the current master. The context
difference merges cleanly via three-way merge:

$ git merge rtla-v7.1
Auto-merging tools/tracing/rtla/src/timerlat_bpf.h
Merge made by the 'ort' strategy.
...

Do you prefer me to rebase this PR on top of 7.0-rc6 once it's tagged
or to leave the pull request as is and perhaps add a note to your PR
to Linus the merge difference is expected?

[1] https://lore.kernel.org/all/177490453553.1933951.12021005257041359513.p=
r-tracker-bot@kernel.org/

Tomas

