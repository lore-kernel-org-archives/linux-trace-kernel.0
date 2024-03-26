Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1D73537
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448988; cv=none; b=Gc+dxSBh3TA0sQ13ahal33QGJKZWKZIZuzmJF7tdVfvC1CDKHbadhVAkFRVLwaa5Pz0BtXrFSLTUgz6EeIy2JR4TVf5D6uxiboeIJTtCtQjFg68GIXA1DRfYgBwrnSLFLrRQEYWfVWwE62Dgffho7t0bOzNXk/tDnpFstk1MiW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448988; c=relaxed/simple;
	bh=y8gwjrNfhhyPwtvkNsOIwPSSVr7z/gt6MPOep8tVyDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vt3meu0Z6vheOFvyiUXw5i6aDTjzLNH04s6JtvM2N+GSxkxTAHRtdL3KcQgUg1MOdXCPSDf03Ldx5+j1hskWGgkRE+AjcWJKxOJPYUBkgI+dSZ6eFIC75/DGWT5q2yIg8UNRfFO5sFaCdAdKvsIWTw3jCaIXuanEn4d9VquW8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDzQxGhJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDzQxGhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711448985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGNAumZ7yiaVmw50vUWWecYNtfUFlfoNeFuOj9jByrc=;
	b=DDzQxGhJQ+6NeG/+Da035whzrPaNXjnz3xETBoh+bsOnOMBDE7XTdB9nzIkYHwy2P62VEw
	FLqj7ozuYGPBSpoZg4q01nJn0B/JxfO7bW+pl7kLnC8yPH+9MkpUpEsBJdA6ogV4WTrOZe
	WpD0qO5LP8Wpw9bchrORAqkBj43AquY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-NwX0sHtzM3evvP330pX4qQ-1; Tue, 26 Mar 2024 06:29:41 -0400
X-MC-Unique: NwX0sHtzM3evvP330pX4qQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-60a42f7c01fso13444217b3.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711448981; x=1712053781;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGNAumZ7yiaVmw50vUWWecYNtfUFlfoNeFuOj9jByrc=;
        b=YblZjSF96xledxIqZmOhyQBUDAVDc66Pt5eTAQ160gYVvuCg+tT0VPOOr7wdsI7e1I
         29jGOtuojJToNSUa4YhodCTgH3NjFMKp9mrxgsVHGO3P1SvGib6j+swV5Huhl0oLJSDo
         bzPVJbcq1dsSyNFQLrCwc81zH+8kc7WB4rGdsyd2ujetDK/Y3enUQZPJ2bQAqRPrO5Hl
         ow7M5u6gTgAkCCPoabek1Vz5wysmnX3gsvspZu1TkzLlhDu8ncwO29SxjbqQjDJGhD1i
         hlDz/jzs/Cx99QbiJzHf/snbMB/ynR3rf63iaEI3nRsyjmqXf/TUoh6etgSAZY4a1r3x
         jD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzFewzl6zpKqXiUrHJzFX8NjAqrH577ardTJFbd+upf3CfGgfyrOK7bJIMxpuIPUB/pW1EWUTIIYBP7lMvLCMjxMygnzsyJYSnbXnPs4o1OKTV
X-Gm-Message-State: AOJu0YwwqoHMrrQ6b0wBVOn4nrevzlg1Jue0CL/VYVniJDR0fL1aD5Au
	zMKdxl3tIbRJeqsUd9ERJSBxg9EU8gs8gjJFXvnd0vrl8RylLvO8ZSP4jrvYTSc6X5t8nR92ffi
	S6UgZUiZ0sQi2EzoS6iNa8sAEk7pmn2HjEL2+fttAAwpWXUTAkjHKEXit5OfV+zEJ89JyXw==
X-Received: by 2002:a05:690c:13:b0:611:280f:5eaf with SMTP id bc19-20020a05690c001300b00611280f5eafmr5834626ywb.4.1711448981243;
        Tue, 26 Mar 2024 03:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY1rhmvyT6nmzta8EOQpEY9Vk/y+OpR0hPCUZsoW4rMcN+piJ07roo7PYy10H0YZcddmmHGQ==
X-Received: by 2002:a05:690c:13:b0:611:280f:5eaf with SMTP id bc19-20020a05690c001300b00611280f5eafmr5834590ywb.4.1711448980594;
        Tue, 26 Mar 2024 03:29:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-229-159.dyn.eolo.it. [146.241.229.159])
        by smtp.gmail.com with ESMTPSA id z1-20020a0dd701000000b0061156eaff81sm1060329ywd.27.2024.03.26.03.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:29:40 -0700 (PDT)
Message-ID: <b84992bf3953da59e597883e018a79233a09a0bb.camel@redhat.com>
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, edumazet@google.com, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Tue, 26 Mar 2024 11:29:36 +0100
In-Reply-To: <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
	 <CAL+tcoAb3Q13hXnEhukCUwBL0Q1W9qC7LuWyzXYGcDzEM56LqA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-03-26 at 12:14 +0800, Jason Xing wrote:
> On Mon, Mar 25, 2024 at 11:43=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> >=20
> > From: Jason Xing <kernelxing@tencent.com>
> >=20
> > Using the macro for other tracepoints use to be more concise.
> > No functional change.
> >=20
> > Jason Xing (3):
> >   trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
> >   trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
> >   trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
> >=20
> >  include/trace/events/net_probe_common.h | 29 ++++++++++++++++++++
> >  include/trace/events/sock.h             | 35 ++++---------------------
>=20
> I just noticed that some trace files in include/trace directory (like
> net_probe_common.h, sock.h, skb.h, net.h, sock.h, udp.h, sctp.h,
> qdisc.h, neigh.h, napi.h, icmp.h, ...) are not owned by networking
> folks while some files (like tcp.h) have been maintained by specific
> maintainers/experts (like Eric) because they belong to one specific
> area. I wonder if we can get more networking guys involved in net
> tracing.
>=20
> I'm not sure if 1) we can put those files into the "NETWORKING
> [GENERAL]" category, or 2) we can create a new category to include
> them all.

I think all the file you mentioned are not under networking because of
MAINTAINER file inaccuracy, and we could move there them accordingly.
>=20
> I know people start using BPF to trace them all instead, but I can see
> some good advantages of those hooks implemented in the kernel, say:
> 1) help those machines which are not easy to use BPF tools.
> 2) insert the tracepoint in the middle of some functions which cannot
> be replaced by bpf kprobe.
> 3) if we have enough tracepoints, we can generate a timeline to
> know/detect which flow/skb spends unexpected time at which point.
> ...
> We can do many things in this area, I think :)
>=20
> What do you think about this, Jakub, Paolo, Eric ?

I agree tracepoints are useful, but I think the general agreement is
that they are the 'old way', we should try to avoid their
proliferation.=20

Cheers,

Paolo

