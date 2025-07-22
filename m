Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E61E32C6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753156272; cv=none; b=l72iqPk8zF2KH969CcPMUTTlNpvmWgChkfqBqbIvcHJNE0NRAEghaKTmgRo/lAHjITIic1WBA0WYvyAPwCcN1WMOeKM1Zm3GCnIplO/EOh7nIoSQ/yRI7+7JH8WPVonhuID+BpP0RH9EQ/spoG+1fitdg/ANOXDLMHn6jiRYYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753156272; c=relaxed/simple;
	bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6ttiq+CBfpS4i4vNHoYkM4eBiQY1w+8qXvnMnqnlO9liQiXNcVUWgyJtf72dKJ0pcj6GCKBor62mLbbrdYMo890XkQ71VAhoWdnxUQoxQ5jY34RBCVr2ZRZ4GnqFcjKTgzH9hh7+aD7PTWq+/EyWmUsddQZwXGhivVHld+gYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Je266k/F; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Je266k/F"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso4144789a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753156270; x=1753761070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
        b=Je266k/F/o/W4OSEELSDKY9x8+y7O2WK1BEfFnA3WRHBkpb1FSv+T5VehlPm/GysCK
         VRqxjO1O8u5y4RsFdExyjT3AvRuyyiEJsP8yrDZuzG+ezMubS2qRATWZ9/EVRwNsSz7S
         F0u9O3AFs0Xd9+wtKmYjMt5YOt5xitThgZj3qpGBmZ2CNpnfGqgokHkOg/JCkUDSoc7Y
         wW15tpUsF76us7oVA64S/44+JS9mfqCJvOrPgqrcLfl9W2p5eSZQsz7wLzAzN448tOnk
         4TOyMwbWYeFCw/0qtKTk8mTqjOCjq6inmw/Oh/QqDP5kg09eoQEAYL5bxT5cOp9FM8aI
         jpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753156270; x=1753761070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJDeYXSX/bvDetfHjkTeV2ORKfWv7rgs+Q7ECkeHLK0=;
        b=f+W77ObfFDp+va1pYxI/Az42LIqCu8mKlAbARiURu01SVCS+xrUPbl300sTAuc2Ho5
         hJzvEpXNB602zOFJVssT+ZDeOkzFo+3i04ddhbuAuTroEaIV01Jxf5PbEFJDRmU5NAuC
         cWEFWpbpFwItKMMRRZ6Bsz/4dcI/Gf5KsUXeujSYunfJxIcePcVWAvG40ZgNZZ0VTEwA
         OtEosD1nvZDntWqvgmxZFfeYS+XC/FP+/ttc84vQ0DgNhj6uDg0qoDgrZad9DytdpHQy
         PY/H1cTVtry5I5IRieT4W8SrEz4pxLjkEHrqnt7bSxhSKFv9rcZZcA0M53dP5Kp+ZSQA
         zURQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpMU7wBN0hzsx3SW8/WEs0EEBdfftKTvxVfetbW4OakiAky07LLlJladOWbrt4vbfnS2krWfAc06e0K99r4syWoss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnEJaDJ5iL8sGEktBmBLXonNaus/8Dd7oBgNx8ROMQaEOF6Ii
	tPCL/OFoQR4XNt2g+55mS8xDCoyk/Hiykdr+2SuQqcM6RAOvgmaxuI0MEQ2I0ARyiryQD2wq9oW
	hpkRM34+hkwPTqLrneR7hB2YbNlsmFiPA4oPAsmtq
X-Gm-Gg: ASbGncswdLUGX1TeejIi6wNPe07kfq8mXWaY2qt2A9bzb97tIy8DdUfnVZEfpdQgtyP
	gYbUjbFsKDyQc8k6JG4eQtB1qNqfkyGi/Fbpl9zvfHAB8RhD3YC0dnbUlILYfc4UTmkQa9fd6n0
	M+YXifIE7uvxDCuSzACIWTZYm//niIEUX1pmGupsRTKzDRV7lnWvBwfw2TnVje1PIVqM2VwoA95
	bT06eYbY35PFGxqeMka983xa6BS2uqDQc0wynyR
X-Google-Smtp-Source: AGHT+IHtpgoTus5lwayXM01SpaU4GwH90Y2FHf3kxlp2FjqLuyW/RgCCnGVdY5X+U0jWSMGmt4T9U/mpCcao819S7/E=
X-Received: by 2002:a17:90b:35c7:b0:311:fde5:c4b6 with SMTP id
 98e67ed59e1d1-31c9f3efe45mr33017966a91.6.1753156270321; Mon, 21 Jul 2025
 20:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721171333.6caced4f@kernel.org> <20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn>
In-Reply-To: <20250722094808945ENOLvzY108YsJFz4CqbaI@zte.com.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 21 Jul 2025 20:50:57 -0700
X-Gm-Features: Ac12FXy9v416hau5beJ-VqKZOCQ6TgCXB1FDXzhWQtKR1uiwNtaKySQQ5qbKjRo
Message-ID: <CAAVpQUDaSccbmOC0sgihBYPTdtSE2OsFOJXC6s58QS81a+8nkA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, edumazet@google.com, ncardwell@google.com, 
	davem@davemloft.net, dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:48=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> > On Mon, 21 Jul 2025 11:16:07 +0800 (CST) fan.yu9@zte.com.cn wrote:
>
> > > Subject: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in=
 tcp_retransmit_skb
>
> >
>
> > Why did you resend this??
>
>
> Hi Jakub,
>
>
> Thanks for checking! I just wanted to ensure the v7 patch wasn=E2=80=99t =
missed =E2=80=94 it=E2=80=99s identical to the original.

You can check the patch status in patchwork, and actually this v7
marked the previous v7 as Superseded, so you didn't need to resend :)

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=3D217549&sta=
te=3D*


>
> Please let me know if any updates are needed. Appreciate your time!
>
>
> Best regards,
>
> Fan Yu
