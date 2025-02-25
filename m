Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7224254875
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470528; cv=none; b=XJGHPKz6cBdI2QxaDdNG5Gms6QgrnQX1IxM9/sNxFWITRztRpnqMFT6VubdmMNzvdLjOITygr84JtEqnYs5nDL5T97xewby6HC9nr5Nj9Gl20kP13WpKJ5mZwTIBp5Ps8SbfF4pEs0ux48NZzceFgL1P9qqQ8tYiB7cQOhrCK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470528; c=relaxed/simple;
	bh=YnEEavwYJZDtuHSBVJml1w92O0Db5z5AgLmB7SLsUUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcplNvP4ssN/HEGSiQD34oJFCU9D1QPuS8SnYKi3D3i/V1Kj+PRwkKRf1hJf+AR0gu03i2LSXfrBQ6dVhmXtrCSWawbLfSrGGUVEmzRsP+e/q5eOGYRC8zhKe5s/AccHT5eg9IcCOWri9VYTyj/wQiohMi98MQZKcAKLiCOkjps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTDjRS7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTDjRS7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740470525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XGo/Cz9/crDfpQp8ognzNaewpjAhfMb4mr7HM/IjQg=;
	b=OTDjRS7ZYYeT2CjBbnZUwMGUESVP/jU28plkc9a9Vwkhc6ei9HC9/61hvT6H3DvAfefpJW
	bAzdGO3zbPSH6GItn8QeaKySBMARbd/FZbJomYh3zMxcz+7g5N6gXcoAb5XWZgMgXb9/08
	zzligLeuerGaklFvI+w/sZj/zqdOmRw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-DP1-KhfiNRaVcVjDXfWHUw-1; Tue, 25 Feb 2025 03:02:02 -0500
X-MC-Unique: DP1-KhfiNRaVcVjDXfWHUw-1
X-Mimecast-MFC-AGG-ID: DP1-KhfiNRaVcVjDXfWHUw_1740470521
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f27bddeeeso5659662f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740470520; x=1741075320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XGo/Cz9/crDfpQp8ognzNaewpjAhfMb4mr7HM/IjQg=;
        b=G4FC1nfweiaObXnZaeL7icaEitFesseHnEqiW97i0I89aM6pIksro/nBVXnw5OEqN4
         kX9m2aXj+dGbgUCld5RQyCaBsxbeDBYi7kxrE70BqH2k/8wG30DThDQFiv0A0gpEzBo9
         K4ke/ihw32fFRAKKNRp/kvz2zUZbXqKfm0hoZ8lZ3OrWZwfuLLnlFXUHK9fB6B5PFr5T
         rGfQFQmkx09kobWfUudSRE4K3cavCHB/7mRofJjB3nR6voqf0ibhBlAd+2kagfB0Ze0Y
         NhRvD9wx3NTH0cmVXed+9xXIAKSnG6AHZLBMDAsP7Pfj5EYZBeQs9fRVYmCTBua6XZLI
         YjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8rLDKW6hKiK3UA6H5YNnsLoU3201RCl18Sgq7mLHDZIwTpGgPqHfVHsUWUuL+gVnlPrW94UlMmSBayLBUkaeMqho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfl99mm5NsDHXDc/4NrZ9TUmqm+/zdGmyu57AgkY4+HhrqTwDx
	G4BwytNWKq4jnkqoJS8XEhq4MM1bdEp7oJSrbmcyD9WwcpLXNzuxxGObYpVRltPop2auP4ng9ge
	jdKvv1WKcZUVl1HoXwt7oG5kGIjj6AYCAk+a+jj/41yF6oKvIS9rnRIHtCXnluPVBooDuR+Yhzb
	/neZenJAAK6tl6mmYdaA4CDf90fEgcfgSSOypzyPB/2vUtaHY/bEGCcQw=
X-Gm-Gg: ASbGncsXDJe5iTuFechGUSdUSjcQR06b15nPtijmn50pV68VT3JkH5WfJipTbyyl4Ae
	s4dvUBhPthBpDJE8SGB42PQhTNeC2PHdts79dBp+CEbzsOUX29Ic1DDRQFk9PH26dYLqwnLDH
X-Received: by 2002:a5d:6486:0:b0:38f:31fe:6d12 with SMTP id ffacd0b85a97d-390cc6047c0mr1800966f8f.19.1740470520431;
        Tue, 25 Feb 2025 00:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAwnouvqQYwGzF53Gyq1y+LLEfT/I1L+DL0ZbRwqwq2iA8+bCBCuZkfO9y62AXgZlT9ODgJ3ipPnECL/jbi1s=
X-Received: by 2002:a5d:6486:0:b0:38f:31fe:6d12 with SMTP id
 ffacd0b85a97d-390cc6047c0mr1800915f8f.19.1740470519957; Tue, 25 Feb 2025
 00:01:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
 <20250224131049.3a4d8945@gandalf.local.home> <20250224194804.73c57307@gandalf.local.home>
In-Reply-To: <20250224194804.73c57307@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Feb 2025 09:01:49 +0100
X-Gm-Features: AQ5f1Jr5-UKzHEgkzPswb9BJrLhKytXXqINxw3_nKdoaORJeSRXCn3g760yLbz8
Message-ID: <CAP4=nvREzbs3r+Na9qF1gPBV0bRnKM5KM4qMo==daT4DuVhdGA@mail.gmail.com>
Subject: Re: [BUG] Crash on named histogram trigger with invalid onmax variable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _2RtxWS2myO4USreKdAB5-hu5LWFJpcVDryKSWy1VsU_1740470521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 2. 2025 v 1:52 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>         list_add_tail_rcu(&data->list, &file->triggers); <<<---- SKIPPED!=
!! (this is important!)

Ah, so the issue is that even though hist_register_trigger() has been
called, that is not where the trigger data is put into the list. In
other words, to be able to unregister a trigger properly with
hist_unregister_trigger(), you need to call hist_trigger_enable() in
addition to hist_register_trigger().

I (naively) assumed it is hist_register_trigger() that adds it to the
list, which led me to think that it is hist_trigger_match() that is
failing.

> So I moved the code around such that if event_trigger_register() succeeds=
,
> the next thing called is hist_trigger_enable() which adds it to the list.
> Probably should be port of event_hist_register() instead, but that could =
be
> part of a clean up.

I agree. One would expect that hist_register_trigger() and
hist_unregister_trigger() are paired with each other so that the
latter reverses the action of the former.

> Looks like a bunch of actions is supposed to be called if
> get_named_trigger_data() returns false. But that doesn't need to be calle=
d
> after event_trigger_register(), so moving that up shouldn't be an issue. =
At
> least I can't find one.

As those operate purely on the hist_data, I cannot imagine there being
a problem. The trigger isn't going to activate before being registered
anyway, it makes sense to first finish setting up whatever we don't
need the trigger data for and only then register it.

> Can you try this patch?

Yes, the patch you posted gets rid of the panic.

Tomas

