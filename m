Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6012838A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811390; cv=none; b=rwUD3L6dkf2slytWpjvKeUDc0BLvZESYDbXMyV9kJSH93OR1IoJZXNOmgYpM/SSPPtkjCs0bXQ2muvgHTt+qIjwUAo2PvujCpJl1CzmYEd8xn5U28VZlgEKcGO6gT8cU8SsCGK9uwiYCyhtzvOySKn9ocvsV1IHZ3fSQytHIc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811390; c=relaxed/simple;
	bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBgVbDy+pf0677wT63ZTZ0LvI/BMe9Ks9me4f8HCau8j3Yj0240c45P8YUqRRKqgl01pl7V9mCZl5xBPFldT0vq17+mLF0rAbQJ/4jF/tCKXp1Y2/bP0U3UPxHinFYIiHhpJb6cEW9yUBfT0PYreoNpfVrqdPfGmYppT1VQUWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3/YH6w7; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3/YH6w7"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5681b7f338aso3364a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709811387; x=1710416187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
        b=p3/YH6w7V3ni0kAfCB554OLE3gcBjcfTMFxfwadffcDXkPR4L+rRSSI0iJUaYNNp4W
         FYmACN8wNxeIC046XUIc4BPXx9WAYEUyoBnQ2haXqgys/OWu/Z3gr/iBmxHbF9w2OTXS
         ewPQrNZCiSi+mftOEHTMJyOvNMunw92QiSrPCLuEeYIACXxkR2ZWCjoF8hLDXpZ2gJMc
         7RFRbH0hLRJliuoTG0D6Ks951o2bxg+nhA/x53J0ZdXQmpzRvmy28dOpDe7hKUJT3aR7
         wnumfMvIBRzwFJXhc66m0xlhTZDjDv/IAUT4buWMz/IVRdaK+FgGDPLqenm84jJ9sE5/
         O9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811387; x=1710416187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
        b=JiRYHI+STuN2PdCuomcHEWezZ9uFp6ACFLEu5VMzelzzzHzaXUXnyYMaS6+jjY7IxX
         MaRLlG4ePPYxRhgNJiZpTT3EKH2gf1Mh88wWXA72d55Op9uxWKXikXk3yZea9bnAZtK1
         u0tDGMzPISKTL//bt7EQDuBjm2MG9z9SpG/ORQ2lvigZ/oEjo2OiWBUBo9GL/M2KnXpO
         OEYJzTDBRL9Z5Xez8ERe11ZOX1QtuzDxIYqkciwA3JJaYuKTAWvwJ+dLDXp9eimKS6iH
         xnpSkKFxLQszuyolr/i/w/nmPA2HXu7dwNYdYYwEyPNTI3AOS+HhRSVHOFWEuZQqSOT1
         crbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTaX6a6gNtWMx92CTWKgqCupMQFu/unEYWUGyMqo4vJFRBK3PzahMoEpJEvxPfE5/IuB1e/SFZRV+pyqpWSrpUwbhZiNnkkBkXPdhYnahEphq+
X-Gm-Message-State: AOJu0YwHp59o7smnrXia2tyzLAAyihjvlyjkE7vzhJD4is9xtkcLo6VQ
	Fzxh2SGVd56nur5tS3Tyd4une3XR7mhkenBBQjEHOesQ2RGupIByfMhpb+pM6xaOOKBljYmQ57l
	OIq3eVKUAl/Dd9lKi+nxr/GkP4yy3/QSqEaSH
X-Google-Smtp-Source: AGHT+IGhKpaFISh6h77rzCFM8kMEcKQujZVf7FZR95JZO09BK+PBIzQ0T/DBA/25M6CBax+euiF805iv0p6iHRNTWsc=
X-Received: by 2002:aa7:df92:0:b0:567:f511:3815 with SMTP id
 b18-20020aa7df92000000b00567f5113815mr149020edy.3.1709811386941; Thu, 07 Mar
 2024 03:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304092934.76698-1-kerneljasonxing@gmail.com> <20240304092934.76698-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240304092934.76698-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 12:36:13 +0100
Message-ID: <CANn89i+LCcumU32pHt2oUnpA19hvgy7YJ7us0brcpL7Szx8tcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: add tracing of skb/skaddr in
 tcp_event_sk_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Printing the addresses can help us identify the exact skb/sk
> for those system in which it's not that easy to run BPF program.
> As we can see, it already fetches those, then use it directly
> and it will print like below:
>
> ...tcp_retransmit_skb: skbaddr=3DXXX skaddr=3DXXX family=3DAF_INET...
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
