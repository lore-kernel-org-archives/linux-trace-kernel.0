Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B429A30D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Jul 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890978; cv=none; b=uuwMcp7tF5UF1OR0yRC2qoIShgGnPU70Mv1HKuyLL+TnJfZH6O1k4ZYgaAiTQC81ajveQMI4OvguIXHnuF4dNiMFW1JJ+qYfDuXFADOVBQUamv5viVMlZLZSmo8GaM+UIib7VnFWaq73w0LLU3BfOhHET6fCPyMhydcztIl8J9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890978; c=relaxed/simple;
	bh=EbIwVWGrvCj/w9SGk7EAImBhD9ATPqR/BLUabvsyYm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVrHHMg0QNgcGYkZDOUsEOUEaov8Cq+aV11a+UHD8mZjh/GMoy79J5J2X+GJafTYMFDRc0cVMLSJEqGtj0C81hWppJjyEUPxT+mjl89kIARPcNUgAyxKPqJ8pQ6kxn+ZRGUf1omImNnjncRiYqYKxELtGXkNGCRbqbjjcODVw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aroYKfJf; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aroYKfJf"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a44e94f0b0so40553201cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751890975; x=1752495775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC2OTWmkGVSsuY5pTtvXdp/tUOOzmOOr9IcRB4wUDDM=;
        b=aroYKfJftD16ZuvOuV8wMdmzkvcDv2PXn2Rhv+hhCFD80ltv8cFTTqDY/4XBOaFDpx
         DJhoIFQu9cWEoVhDM25qYKgFNW5eCCDT7VZjPZosJt+LZqtnzlJmA068zRFPt5P3Y1FF
         4U0kwKlU9/NlERCnBlRkw8Ahjda0h8qX23W3cgko1NkOb88zMBgI00JyFdw99EOdpRqJ
         O+vmEd7VBWDgfpi35c+tGSK/JrFZZCQg7CGUFPfFPIvcOmQ1hfYZdoF8xsg3/1yJ2m7E
         eylWcH4bjEoPUqdlLRBMiCMSyaw+/q97OpJpIw3Whq/knt2IexzR0RjjQPiCAxkO3p8f
         lhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751890975; x=1752495775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kC2OTWmkGVSsuY5pTtvXdp/tUOOzmOOr9IcRB4wUDDM=;
        b=pEPe5j7UZ00Pq9MEu/ufB/yfHpZoFp4XwJWrYkX9Wh1mj2s6fdQHeVle+wnmumPwaT
         S72vOG4hMPYXvxvQTafrhOjbGUulUUP5mIQWANsKHQC1GME08x0GaZYuziiQYuzUU93J
         jRKUk4omPPIwETp3xJs+iyIMHK3iEaPKvXdaPuTU8D7fnHdmQy6+bnfVtarwi9w0w8nU
         C3I2sjJqTw8RtkJPeopKzSRZzcs/tBsbS5p6/q+X6AY2EU7Ljv44r8gzajT53UZshdzs
         tBFoSngcDGgzMIDjOsHkQxXy9nY8/ev2EAjtCJHrV+Q3AbRAA6BYF9g/FcfblA3mGOAT
         boYw==
X-Forwarded-Encrypted: i=1; AJvYcCUf4/ZtRtzOS6gE53I7S5q4ug8Z7PXl8PgD8WQHHy2C8UuH85OB0iVyuNAqeQDSniUdmCRXsXbih1ZFG6uCA1CcCRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUi7KkwuGnoGaJtcQLWfj1vzrtoL9f2iDy3dh/X5MLB9gxZz0G
	RDDu3APOpNm04lBmWguBNhMt9ioZqizASF0PIlfp5xR7FlnxLbo92yL7OM1f2JxPu3kuTy+kL0H
	zuVHS5hfc6DWvKYjgOQ6iJ8sjzjkylcKMV8eVzDFu
X-Gm-Gg: ASbGncu9Du4wi3padx7sNhEy/ezgAlVKnZT/KYRnztWoPmu3jgkde6xS2JmGf04rezc
	m7FAoooUTbMYFzbPhXPBW4wfOyj4IRKj0rav5nllql1eCVZshB3h45+4gQNn8fvdrsG/tzVPBsa
	4TzgWMACL4VEyJYRXTRzQXUCnHAjy/ml2FJK64ZY5zeqc=
X-Google-Smtp-Source: AGHT+IGmu1jMB8m9mV8Tvai9M9eqluKCKwizyfOIqDCTpHTFG9NpgFDmREZITt+nSs5e8TFauiHUjuiBum43hF1gaYA=
X-Received: by 2002:a05:622a:5e83:b0:4a7:1403:15c0 with SMTP id
 d75a77b69052e-4a9a6828d6bmr143410911cf.4.1751890974914; Mon, 07 Jul 2025
 05:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com>
 <202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn>
In-Reply-To: <202507071846455418y7RHD-cnstxL3SlD6hBH@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 05:22:43 -0700
X-Gm-Features: Ac12FXxCIE-AGdCW1zPw0jMzjWM8tMZL_ZlRElWTTwxHobUT7zQ-ePBitnGFpAw
Message-ID: <CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: extend tcp_retransmit_skb tracepoint
 with failure reasons
To: xu.xin16@zte.com.cn
Cc: kuba@kernel.org, kuniyu@amazon.com, ncardwell@google.com, 
	davem@davemloft.net, horms@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, fan.yu9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 3:47=E2=80=AFAM <xu.xin16@zte.com.cn> wrote:
>
> > >
> > > -/*
> > > - * tcp event with arguments sk and skb
> > > - *
> > > - * Note: this class requires a valid sk pointer; while skb pointer c=
ould
> > > - *       be NULL.
> > > - */
> > > -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> > > +#define TCP_RETRANSMIT_QUIT_REASON             \
> > > +               ENUM(TCP_RETRANS_ERR_DEFAULT,           "retransmit t=
erminate unexpectedly")    \
> > > +               ENUM(TCP_RETRANS_SUCCESS,               "retransmit s=
uccessfully")              \
> > > +               ENUM(TCP_RETRANS_IN_HOST_QUEUE,         "packet still=
 queued in driver")        \
> > > +               ENUM(TCP_RETRANS_END_SEQ_ERROR,         "invalid end =
sequence")                 \
> > > +               ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,       "trim head no=
 memory")                  \
> > > +               ENUM(TCP_RETRANS_UNCLONE_NOMEM,         "skb unclone =
keeptruesize no memory")   \
> > > +               ENUM(TCP_RETRANS_FRAG_NOMEM,            "fragment no =
memory")                   \
> >
> > Do we really need 3 + 1 different 'NOMEMORY' status ?
>
> Yes, different "NOMEM" status pinpoint exact failure stages in packet ret=
ransmission,
> which helps distinguish which process triggered it. Beneficia

ENOMEM is ENOMEM. Honestly I fail to see why it matters.

If this was the case, we would have thousands of different ENOMEM errnos.
