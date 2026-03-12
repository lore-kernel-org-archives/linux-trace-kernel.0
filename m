Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39A35DA7B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773280154; cv=pass; b=BNxZFdHzJb1DTOPeRVChmfYoZMhS+20ZFdgBnlpden1Mqt4xiJpvMHRsVG/G+QhaQfx24M1GKqMPFMVCNi68SO/fZXza81dLBd4xfeSzB2Cygzlsq3qP6+OwxS9+0GZc2eVEXK00X/QMN0i8U9/lqhSvZG7TBTGmKgzzbzKI3cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773280154; c=relaxed/simple;
	bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR/rZtSIQscelnnm7ULh2B2gSvNohI1LCuWcV6Zu+Ws2pouhWYe3hdLw3heUydDxNrVecPWUttH6fAuRop1g0NoXGOjnnu/C264TdJUGA4FXvbvvW6K76xuiA1Ew6CB3wJyriaNogfkanTPq9w9bq/oFeMoaN58smTt4mTrWp3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0eMifdGf; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0eMifdGf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506362ac5f7so4878311cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 18:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773280153; cv=none;
        d=google.com; s=arc-20240605;
        b=IfheAlr78nicxnq7XfCB7eKC+ovviO1CcqpXl7Wsj+WU1Kp9rEmqajVTqJCWUn600L
         b/t7jineKkdPM8Zlh1GjRR5vu+zU5p06bsotklai/WdFeOIEVKn1GHgVmqG9N4Jc6tCx
         tQxmnpXPDsXflrH5h9+5kM3vAaeIqF+k6GpvG6XJx2ifghKK2ccONR0NRGrJDjBl20+L
         9Z12KGtpLPahFrGDbT5NV0OQKBV8nBRjhdbUlRebckhdv9hfZ7nrbQBr7Yn/9Rg9AfRY
         ihu/mw2xsQ7bBGsia9q84lHPiOgeIG/oRCcEy4XVqcSx53Hevm09SXvkWAw9AK2C2SJa
         FVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        fh=yG2Mg8GSfaIezpjRO/0iHFNrTwMr71L7dyt7jlmZ4/8=;
        b=WIAkxfXwVzt7nMIkuHdCMZTw2/x16bfedlnYtgZXePgYFcT89pYtvS7co8FtT6Quhx
         N9+o+MuXkmhcWcR55DpY119AmWTj/D67MyFjJeQeqwicerD0w2nJCAB6LhhdxiGE7b7V
         hWtxTbYIO9aIePV78X0/25CbOO5tJaF3/UDjRTp+e4OM9vU3NVfl2XwKYYjPHTSkaFkW
         o1nTFqgTZecAnOb4/C1aRLpQb4ZqGSqvV5j0KuV3FM36Gmge+r+Dsb26SDeEdbsV2U3P
         VYi2CD5uzkQvAnAT4gMjJAFFS11uLoCbqkpcYYWZZhxfqs5m9VoiyQdgEJcdcrWn0uo+
         OHsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773280153; x=1773884953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=0eMifdGfKpRZHoi52nmNGMWWDldqbwBE3cc2rsvDTH+R/z9ZsWBwUDJ8Vx3JPLZLoV
         0QcD5I2N7FPP03l84aunFwmPvJTIX6WureHBe7RVC3LC/rrv6AxCbIJ8K75IVdb3jHkl
         MtBDe8kamI7tNWMRAxTYQ+/4XtD2RwQ9e8i+7DLTLloVPFQ3lw5wqBez2CX+YKWNyU7m
         zNZVLwJioy6vJbobq4mI+qETr6a+1ou4ty/0S4TkE+VdTW7Sty5FYRY74E3ea4G7lupt
         oVxF3URRjvHYhR0xdK/O9I5BT9OCV6JEU79tP6DE0GZEaROJXATUPYroz7jYEjsEOJlI
         Pwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773280153; x=1773884953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0pdZ6aJXNzjnX3WguteAiYv+XlY3/vYQqBj1jhOzDg=;
        b=pg38CF4QS9qLzaE05Min468TdhFyLSxq9GojhYsd4TyBEF0bstvS8kWXCGz27qJFhy
         rQK79wh++WSdA0h0QT25QgFzCxE7trPqxdz7oxO/kln1ZNHMFMdn+qYkIRn8srw40Ktd
         BgO49LHK9arK2pzzIt4MSqK2ts1hyONZft3D/KIrmwCv868GDkLGav7hTXo2/e9TtVGN
         UWxif7hU4cRibpdIKb8EBzIeZnvGrtst4GxjYIeE0RBZJgDZEwxv1suWBuCOdOEx/vUq
         pw+OQGS1bX1oPfR8PIuwsTxDauI3Fd50jjtqq3va8qg53HFjrfTznlFINzuo3ETHVMay
         sL8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGY8akA2iHmn5ZdGHs7y97NvpXnOSjuEkE09D/36H5Al07PaxNrmIRR7SMuhC/J9w9fwqOaol0JI63QaKpCJ5YDUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysXzxPkbcxVp07xmtK7UBLbe7Y3+ocmk2rQY7TrGNjaT6NunWn
	sig/ZiBkpv0/yTISBc0DH5gWdgATBq5tNRw+r2W0tBMIJg2Bzn6tc0cmxRAZOaPMAfTEvdjAvhn
	SWP+MnqF26YfjyKXpcGQ7tTuwgXfg3c/0IIBJI8PM
X-Gm-Gg: ATEYQzxyzUatboPaKMTIyovm+nCeykW2zUV79fTijcUozjWCxICokyLI+6xv7tcXKfk
	9PNVH88iBDDjB90lk05BpUE7k3LypTL4AM9vBvBpEzq6gE0nxtk0JJ+KfCx5KucAxm+tQmBw5FT
	XTPD7hiGtgxa9LslsW7hALl/bBxO8TNXfaF13JXYywpNvHwxoCHqiKR4r0KBRtQa3PJg8Ln18en
	GZTwfIseNxe/YotI60W61ZZ0h0uohGQS/fAbvD9iQdIPSmB4DGUifck6rLlGRLxTl0iJdUYeCHd
	3cLIUEM=
X-Received: by 2002:a05:622a:245:b0:509:16ba:d537 with SMTP id
 d75a77b69052e-50939fc6311mr62588591cf.19.1773280152190; Wed, 11 Mar 2026
 18:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075600.948413-1-atwellwea@gmail.com> <CANn89i+dojcg=TDh6E1++g_TM7qdcpnyu47n2Q9DRW_w73TjzA@mail.gmail.com>
 <20260311174154.5fadb207@kernel.org>
In-Reply-To: <20260311174154.5fadb207@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 02:49:01 +0100
X-Gm-Features: AaiRm52zaoXRZHJbWhVYmknx0ZhJd77Ysbeej4LqlWfvsr4aOTCUEXNpCukM3UU
Message-ID: <CANn89i+8LBnbwGE+4qfXv3uKrwLXog1hXqabSK57dCABJ6Nx0w@mail.gmail.com>
Subject: Re: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across
 receive-memory decisions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wesley Atwell <atwellwea@gmail.com>, Simon Baatz <gmbnomis@gmail.com>, davem@davemloft.net, 
	pabeni@redhat.com, ncardwell@google.com, dsahern@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, kuniyu@google.com, horms@kernel.org, 
	geliang@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	0x7f454c46@gmail.com, linux-doc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 11 Mar 2026 09:34:32 +0100 Eric Dumazet wrote:
> > Your series will heavily conflict with Simon's one
> >
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=3D1063486&s=
tate=3D%2A&archive=3Dboth
> >
> > I suggest you rebase/retest/resend after we merge it.
>
> Would it make sense to extend netdevsim and packetdrill to be able to
> exercise scaling ratio a little more? Having it optionally clone the
> skb and truesize +=3D X would be trivial. IDK how many bugs this would
> let us catch tho :(

Yes, I think we mentioned this at some point.
packetdrill uses tun device.
Adding a TUN ioctl() to control how many additional bytes are added to
skb->truesize after tun allocates an skb is doable.
