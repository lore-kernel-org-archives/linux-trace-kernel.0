Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57758374739
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578295; cv=none; b=WzICBeippyQitpjPji+Tnomu6OAY6s2y9PxqwE3/VoLkh4o485I4R1zg013ayR8taM26cDPT4JX4p3Ud0ZjqO7Pnr8vr+QsWrMKLOyRVIgZULci8RECK/5Y7Dm+ZQe+VlB0I6mdY2ac+76d7Q5tQIobzKuFn1Gc2XCGMILrVwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578295; c=relaxed/simple;
	bh=/YVUXGy9XsepfY5ixMUJiWhjh1V91ITMsJcCapvoeAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LskIPOoXvHdhZr9ud9MU+Oj+RGZNveHqSpMnXekzPe9TDCeUS1eVFelAJroBE5ibQJBA3v+vqpVuqmjdN0Agt4Eh9CHEqb7M/W18fRynNmZjLexuPIF+qXM0c3uCPV+pGPJSxuMxIeccdB2M89dAUaDLDUVfU9sdBm+qeX0MCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIaln0AA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIaln0AA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780578293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/YVUXGy9XsepfY5ixMUJiWhjh1V91ITMsJcCapvoeAE=;
	b=NIaln0AAw/qFzbejbM761KUDZFg1MHOajs9X5bAvH5fH6AS07osMZASer4kg+FOyHxr6fv
	YqXmvtnEp74xAguFSq04tZtx+oJeIjxAHNjkDDucxxbGt0wk+U7iekvax+Kkx+LpSjzDMB
	T8WyF7cKHW++QkOMEqj5ubJ7W90p/XE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-QtasSfXbOoeygxZg2CKivw-1; Thu, 04 Jun 2026 09:04:51 -0400
X-MC-Unique: QtasSfXbOoeygxZg2CKivw-1
X-Mimecast-MFC-AGG-ID: QtasSfXbOoeygxZg2CKivw_1780578291
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae016853so5350625e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 06:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780578290; x=1781183090;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YVUXGy9XsepfY5ixMUJiWhjh1V91ITMsJcCapvoeAE=;
        b=GhrXVkzSm5ORnwdsVF/KvXmGQpeaGk4ai9NKJez52a9Rg7DfhxIXz87XJF4iyTsdZn
         tBqSuFVeIEiaelsJxH4xc+/CunA/QLIax6LPCGlOWU3vOYmdpJkYBWJnxet6wahTRidp
         yFgJWOyciEEujV6FziLxJBidOwtDl4S4lBSjk+eHH3vFW6RA98IcQyWAEJcpuexltiXf
         FctijN99NjJgujUzTximJTDiygH0TcjZ+TSCkrrXEwZtQ3O+NI7HJbiLzp77+WAlnrz2
         AKJtvSIPI7LsJcIgY7oTXX+niuZ8MS0m0gEcuwBIIfoYjymTsi+PK1BIr1GnQBwOZ0SI
         eoVg==
X-Forwarded-Encrypted: i=1; AFNElJ8K3M9oEMrVXDg5o3HRA5po/6ietwbShPG0cFh2e+8hPwXUyvo5gVWeqBgxaWHvLUEYfo/JwB+ylDyMnR8NjP0QjSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGdVhu+ezG/6D8EqcAYDOnoCg373KAxUJn/kskT56JMKlhw3G
	bY1xUaHjl//BgZr4EXWjnZ0h9CHnKOAIXMmt9Qf7gNKi5C6I2WcV8R3IQMqO5/XLWz/Qe3MprOU
	I6pyv7p/HjUyLJzItvEJwu3PDvKneC9KiQ8V4HegGt9XAsTslnzkMhtItPxTOup7HX2HE7Sw/7A
	==
X-Gm-Gg: Acq92OEZHHzkCpyO05dtM+0UoFwhNB3xXE+i2cYzXoYI68rp4xqmeSg4Ak6MZ8bP/vC
	oms8x09dYTdUWIu6dDRT7Zxysha/DZFGcy41QbKsxzXFc2HnbFCKbOdgaY8IlGrOdb7pSOXP45o
	F5J2wSDuPbsUkdTG3gqdnXUou2Kdt88uG0p5ivuqo6JAlZYRWFjHJjLNlSnLFYjRGhZ/TvAUUqB
	xD7ObwRVYM7mFM6qfTL87pUS9n+OmIclkd2p+iaXRonF1lXeb0QuGwRtI+0VNlgu9SnUJhLg7XQ
	jZZv/GSVzysCoXGpfHheRUogzPqD1xLBdo2xfpy8CqjPY03cPP+bepJllKHJvDHflmvVP1wF6Jx
	vtZgvhq32SRLBsmBYcMhJTLW6zR3E3Op4LV6g
X-Received: by 2002:a05:600c:8218:b0:490:bfa4:5f0f with SMTP id 5b1f17b1804b1-490bfa46194mr26270965e9.18.1780578290635;
        Thu, 04 Jun 2026 06:04:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8218:b0:490:bfa4:5f0f with SMTP id 5b1f17b1804b1-490bfa46194mr26270395e9.18.1780578290159;
        Thu, 04 Jun 2026 06:04:50 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm59593385e9.4.2026.06.04.06.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:04:48 -0700 (PDT)
Message-ID: <1ec107781373557924ee369ee13bf69d1efaa12c.camel@redhat.com>
Subject: Re: [GIT PULL] rv fixes for v7.1
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, unknownbbqrx <dev@unknownbbqr.xyz>, Wen
 Yang	 <wen.yang@linux.dev>
Date: Thu, 04 Jun 2026 15:04:47 +0200
In-Reply-To: <20260604085405.234d22eb@fedora>
References: <20260603125056.75559-1-gmonaco@redhat.com>
		<20260603191627.5cb4ef6c@fedora>
		<CAP4=nvQEF7BtsMSoDaVO+5MazsRGypUnxB8w0Uq=2sCy=g2HGw@mail.gmail.com>
		<791528a4f69460ba1e9589361860bafeb1517237.camel@redhat.com>
	 <20260604085405.234d22eb@fedora>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w9DEQRm-DCdNIIXwaVq3Du9QXMJxjmqjkMHk7OFF9a0_1780578291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-04 at 08:54 -0400, Steven Rostedt wrote:
> On Thu, 04 Jun 2026 14:42:02 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > All this to say that, in my opinion unknownbbqrx
> > <dev@unknownbbqr.xyz>
> > is NOT an anonymous contribution, just a nickname that differs from
> > the legal name of this person (which we wouldn't validate anyway),
> > so I would say it complies with the rules.
>=20
> It's a username on github and not a nickname. I did a search for
> "unknownbbqr" and it doesn't come up anywhere but Google tries to
> find similar matches which brings me to an OnlyFans account :-p
>=20
> It *DOES NOT* qualify because there's no accountability for this. For
> people who have a nickname as their entire internet persona, sure,
> I'll take patches from them as there's an entity that exists behind
> it.
> But I'm not going to take some username on github as a persona. To
> me, that's still anonymous.

Alright, fair. In the link I sent, the signoff got changed to Ali Ahmet
MEMIS <dev@unknownbbqr.xyz>, but I believe we cannot use that unless
the user themselves adds it (and they seem unreachable).

I posted the re-authored patch in [1], I'm not sure that's the proper
way though (the patch is so simple that is unmodified). But if you give
me a green light I can send you a pull request with that patch instead.

Thanks,
Gabriele

[1] -
https://lore.kernel.org/lkml/20260604120946.90302-2-gmonaco@redhat.com/

>=20
> -- Steve

