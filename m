Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F66BFB3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344533; cv=none; b=gvwp/t39uJd3gPjvaJaIxzt1LJLg8uBXeq7GmjeKYknCuYpVmCnoApdTQecX7ZSjXvO2TmPUvfDmCd7R5rBqtm6J57rKkcmVZhVPCTgWZBicjeXB8gLPKu+GkNjpkWBXepa1rx78E5mNYUYovEQKbdzI2kWazrVgTRqJAsmX7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344533; c=relaxed/simple;
	bh=co0vGStyxzs2wYudwfZgCahyCD+9GAQnQzEr1hx3Sl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r246xP2qyBENPXcZ0R8Fz08yiNGXcxrfTn2wuDv21WRD0PSmoN1vp0Vs2STybNtJPSWXdKE6y/x1gcdMC+q7a9d9UTegt8sriVksXfGZfh+xstRPfQL7wh+bOkmwd1mSrUf0BgTkhrWXDmt89+r9dXIIt6tsVU+BPmidxWBGJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqYxPXd7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqYxPXd7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so7708a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713344530; x=1713949330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=HqYxPXd77MPew12v8LA56Bq0K7omPm6X2MKAEaSBhlNXILBjnUAUtPC75YnQcIYEZx
         I2k8iR/g62xXeb1rJZlVAiC2AM+VFDR/YQmakOlgEDZYaodjL1BZ3QkK/NQMksJ+yhbP
         o5Zk872P7wbLiDL3b+WyAGIF99tjTlQHlf85YalvcxZ0+BrrFSiemBQRnd+0UD9xwCQa
         dhK4BU3P94N9XvN4ytbhzVQPkIDIh9Q+QtYbqUn8w1K4RZsPM0Cl0BKY/tmhMyyGc7eH
         DfLfEkEsAGe58W52sPE97LoMWpjGzHKmiud3MYuYOVQWxooWvkMjxp3bjkj5GUH8tnuZ
         LVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344530; x=1713949330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAY8JMpfOE+rjYgFlJjU2Fp0QQAa6jroDez9CFZ6FKk=;
        b=gQT6GJHub2ZM9gcob/XMyavTaFOUgI54KSNg+xJL3GMOQkmEivI+1MNwloWvjOZrOE
         5c2ZQ2bVrlDUZjv1z+BZCK5M8zgzqG0IyoTEbhN0TyB5/HuEi/0Ok1MErSt5pFcfUdSq
         D1AwYfmhriT+yhU4v0WzaBZInCg6YqSTQxrPY2WOuy1pM6FT2WuXXo5re4IA/5m9k2dn
         bF1GuLMjg5ru1wADGG39l3ghBSa/3Sa1o+/JjgFSKUismd0wwIu09lMnpHXKLASl5AOd
         FnGf2eJ/6pDsIBHt120IYM4by2cVk/5q49nSxghCedr7ovNOEw4d5LkfaQDOfSPrgbSq
         zgfw==
X-Forwarded-Encrypted: i=1; AJvYcCWUrHDA+uEJlNL1ZOw4eIb5WEK1h08EFp3PeSUIQMerrOMv0a+e2z0EUtacXq2HBQC9ptmxeNR/p/b7/ufn8u0uFqj1xHM1zfQtKok91XJG2Ghp
X-Gm-Message-State: AOJu0YwCnSb2vp7V1aG6YNVs8wgDG2kZd3SR/6lJa2l74wtos/0DjLMb
	f1hPgT5swQcWM65oOCz/cRlPXrZfAr4Hhu3m8CCF6QImAPeSiRPVvUDCE1l6Dw204N/r0NPNWeD
	s+EMNues832xPCIpS5g7XzHt1taJ2brQwuWvu
X-Google-Smtp-Source: AGHT+IH4cUad/wnQKLE4dWvHNWAVSWHtbhac2FgNRdt0BeRKm1vTHUByA1AGiXIWwXcHIzNQLrGDOtsihbDKjDzHamk=
X-Received: by 2002:aa7:d9cd:0:b0:570:481a:8a1f with SMTP id
 v13-20020aa7d9cd000000b00570481a8a1fmr108872eds.5.1713344530145; Wed, 17 Apr
 2024 02:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417085143.69578-1-kerneljasonxing@gmail.com> <20240417085143.69578-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240417085143.69578-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 11:01:58 +0200
Message-ID: <CANn89i+aLO_aGYC8dr8dkFyi+6wpzCGrogysvgR8FrfRvaa-Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:51=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add a new standalone file for the easy future extension to support
> both active reset and passive reset in the TCP/DCCP/MPTCP protocols.
>
> This patch only does the preparations for reset reason mechanism,
> nothing else changes.
>
> The reset reasons are divided into three parts:
> 1) reuse drop reasons for passive reset in TCP
> 2) reuse MP_TCPRST option for MPTCP
> 3) our own reasons
>
> I will implement the basic codes of active/passive reset reason in
> those three protocols, which is not complete for this moment. But
> it provides a new chance to let other people add more reasons into
> it:)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

My original suggestion was to use normal values in  'enum
skb_drop_reason', even if there was not necessarily a 'drop'
in the common sense.

https://lore.kernel.org/all/CANn89iJw8x-LqgsWOeJQQvgVg6DnL5aBRLi10QN2WBdr+X=
4k=3Dw@mail.gmail.com/

This would avoid these ugly casts later, even casting an enum to other
ones is not very logical.
Going through an u32 pivot is quite a hack.

If you feel the need to put them in a special group, this is fine by me.
