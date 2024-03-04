Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6BC171C4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540666; cv=none; b=aHgRsmTmWo5nKYyf2lib7ngJdzsvcWXO9+P566yDX9iwUAchU7il6Bc6SsBBNhXqsE2SPi8hKB6GOqhHLmz64aAesdLn2YsjfOnErP420bUVhYyxwB2U+12OqfOvsA5pAwMK34bd5/caCfNadXktqNQge29iV70IcPehBPu8CJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540666; c=relaxed/simple;
	bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lO2XRlQtNZE8uxQh5SbNTRIxEoTTuRYAOw4JyElmTC798jEWSabXpOpXmEUJXkzyJgrpAv6gYjNqjscEBErj520eROSKWv+UDCJSVi2TIY0zqp9v27X1uQ1NewA5HS/rM7BlMb95KbMP3CEJyYd4MBUqdyZLT0u3UXbAhqAFbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnufAxEZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnufAxEZ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56693f0d235so19119a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709540663; x=1710145463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
        b=OnufAxEZqbM7M6QuuWBZYPj626AEXak7ODTyQDRFI9npS+NdxQH72pza8qK/fw32bb
         3Ymj+yHJkJfLnRlfKKm2N5YHgLf+Aj2VpYqhNZKfT0kJk8sKLLwVWGgZRYwCzOVFl+jw
         mDACCUgekNTyw2RrxWpr6J3czcEt3ZdMEZ6n/MmU57lPldKoHmnkql4DYgxMll/8ncl0
         uFdXj5ZWsC5fCm9F4CSd7TKlJeF4tJg4zuiylzOk2JdcO8NoggtP6vMVlohv7/7DbaMw
         Zn95Hd4e+Zg3La09EyAP4II/9K3apQexqF7C/bvFUkwL9YengIf+J/CDMjsnOZCVVLCG
         7iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540663; x=1710145463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xuxYP6DP8Cdr/UAZq7ZNL5tg247ofyZcPoyR+xDjmfs=;
        b=xUhy6+W/16mzwOVydvKFPWrWYAVqGT2PXra09gfgMrcwFAo+vaFHzLmDsfjOqRuJKI
         brNUyh8uZAc/SkDiKjSTmJ9zwURfQ9wnwbOX+zNcnpiw2DJyP6b/o+oXlpBjdQ39U5LZ
         SqvMwh81LN4KtwKRndJL99jkLxPOJCxKOVxqj0s7lNyWPSS+TIRv4cFuM74N2AWEAZRE
         oao1xzR2R1PGNBXgusYMqmmnam3D39loou8n3udppaBsP92ENtVtBTlfBam8eSPgPkRj
         GwqjCw2ACGKUVt8O8l1vnYtKFBgwQXsxbdcd1hPU1MouzvCycl9qKnCpZQqVky+am7pv
         Ihpw==
X-Forwarded-Encrypted: i=1; AJvYcCVpd8s4ve1ED3O16ZyIQAIEyvbAWuLScXUsP4WWzPGmhND3Q4XRrykW32WitDsOw+bCUi7+JynkndMyfaawANTH+uCN5pNLAIXOJsag4+wKat77
X-Gm-Message-State: AOJu0YzQIrdBfQc6ffw8ud44ff8E11oJPEPBxg/S23wYlU5JSP9VJ1oe
	x9aQFSygl0HeAcBHvadwzLhggJr6qesp21FzZs/FSvieRpYxLKauvco2fgrn941FM9MpRQX2Ksf
	FG3YR+vHYObbLWMpqrxeuePsIQd99PbtLchL4XuxLGOvfaCqFhkOz
X-Google-Smtp-Source: AGHT+IGsrm+exERQpnzcTrgZMnftf2s2OAnI9eMhtFaLJa+VkZE16xQePWCjjedaR9AnUu1ThJ2DT7qdZrjK+Zcvkx0=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr289225edi.1.1709540662841; Mon, 04 Mar
 2024 00:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229170956.87290-1-kerneljasonxing@gmail.com> <20240229170956.87290-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240229170956.87290-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:24:11 +0100
Message-ID: <CANn89iJcScraKAUk1GzZFoOO20RtC9iXpiJ4LSOWT5RUAC_QQA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add tracing of skb/skaddr in
 tcp_event_sk_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 6:10=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Prio to this patch, the trace function doesn't print addresses
> which might be forgotten. As we can see, it already fetches
> those, use it directly and it will print like below:
>
> ...tcp_retransmit_skb: skbaddr=3DXXX skaddr=3DXXX family=3DAF_INET...

It was not forgotten, but a recommendation from Alexei

https://yhbt.net/lore/all/20171010173821.6djxyvrggvaivqec@ast-mbp.dhcp.thef=
acebook.com/
