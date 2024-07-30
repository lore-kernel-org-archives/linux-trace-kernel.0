Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA80C1A2553;
	Tue, 30 Jul 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352242; cv=none; b=sdSNPjRBEp5A3ptfVFi0BFFYJ5HHsHMZF01gCQnjY1T3DX77NRIBoU/t7UkwQ4c5NjOt5XDgF1gDrkxvMruROE4wuu66ZpzDjbJtTdn6Lj5BXjyupkyo0Rc1fkJJuAUrw5D17mHPh6R6QUwdNTheJU9Hn1sOQ14PlbtCxAvDPnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352242; c=relaxed/simple;
	bh=hmwWQzDQ25SuorwsyKRj4wl1UNLVTz4Upf0N6htKTwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdqiRtfVNrbl4nCSI70Cfr99tqpH1Z59T7+ct07e3UjNQOVGCOOW+qRXl5Y8RZWqPw2gtgfWu59RuLkQbCeyaGlZjpdw/IHsY2lwik6R1vVP6lSW3wmeoHSV/ZkOehWlnMzpn8ATT8T60jGCAkVXsq4RZy7y9pbCj+3hBOjAgeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRr7mFa2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRr7mFa2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so2985886a91.0;
        Tue, 30 Jul 2024 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722352240; x=1722957040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UkVYv8YMQHHFJCnBclXsFYTEqiC7YVlm5OC6CeRyng=;
        b=WRr7mFa2+3MLngRIx9wg9SMbtvx1iel+LcaTCPKIVaAP4cZa4KSa9c/ktw1uNw4MFs
         jUBs9/oglrm8D7TI8ze0NOIQAjQgWJKnFlQkGr3tG8Ii12hDd2bLYqkmosiTqps6HYCF
         D0OZUkBqWygi4IyrCY0AJMbeBhW+hb21y0bVGsWLH3Su13oGinVWYZf+Web4nADyS6/0
         1qUNXLOOdOO15SUnBwAng6/clizb5T7pM1lPjdbeOmPrO73gnPWhSz0HMkXNR4fynk/m
         vWW/bRv5dQbDRXsoK8hNZbMvf+Pvax+CKSSqRja1JJ+RKs6SA3FgOM3slxHSk6Vm8tlA
         hCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352240; x=1722957040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UkVYv8YMQHHFJCnBclXsFYTEqiC7YVlm5OC6CeRyng=;
        b=BodHpZogec1HvNWVPYdnwnKBY7TJiooG3LT+aJK4U4j8MXyxIwwOXbyYhjk1eYZPux
         dFp05/fj2vEX0016ej1Ftq69i1XdzDwCQet27+hoc+xLQsJA9kjiBfgaa0Y3E0hwiZwX
         L1gPUYrRoPZHezKGlpaxK1ZAZiMmMT6dFONTzZdZNElcOvGArIu7RzKILzRgxd9/A+5a
         1qPOUSM4stU4GpXDxR5WYHYxvrD9auFvWvC2MHdOzSvjeiSEQ6ViAn3PNeJ1z2Qr9UKr
         BbmkNmPuC8K3472GWFzBsDfuF+k16334RiOCO12XRxVGo1EFg9tlAS87UkAKTx5Egixc
         KsYA==
X-Forwarded-Encrypted: i=1; AJvYcCX3f/bxWHWiFjHRYPFI7bud2pmYVeszl/qzD9kIZ89kRXgbFwxsMuHN25d0qDPPuVDf1UY1x1+9YHAGkDnBrUBjD/K5r8hX6EgjXkIWVKLooeYx6iYPrgFqpjrMY3lma9WgIRdYmaCBxvangUcGdGxo
X-Gm-Message-State: AOJu0Yzk+1/t/AhuceJbi+eT6N6e3RKZk2+B0GO29jP+t+MDU09cGZi1
	irtf2GRxOo6mbBu5u82DoPMX3D1bZWfwqb2PvlMmIoz+W7zqFZClatRVf5LEFc61lNGb2Dqxdla
	FftJscmYckkY+qPSaayQk59xPB4w=
X-Google-Smtp-Source: AGHT+IEE2NO8I7fi5nFGGtfWNaJ+PkkmNA+AZhI8q3l2322eNWiDRwfgixixPDGESLR99hs50XbskW7ZfeO+MQEg67k=
X-Received: by 2002:a17:90b:3ec7:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2cf7e207332mr9724330a91.23.1722352240158; Tue, 30 Jul 2024
 08:10:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730123421.GA9085@redhat.com>
In-Reply-To: <20240730123421.GA9085@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Jul 2024 08:10:27 -0700
Message-ID: <CAEf4BzadOamfkR+ww-4F2romXJzMo96V6=MTgqN1G+p5CXuOmw@mail.gmail.com>
Subject: Re: [PATCH 0/3] uprobes: simplify _unregister paths
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:34=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On top of
>
>         [PATCH v2 0/5] uprobes: misc cleanups/simplifications
>         https://lore.kernel.org/all/20240729134444.GA12293@redhat.com/
>
> I sent yesterday.
>
> Oleg.
> ---
>

Both patch sets look good to me. It would be nice to get them applied
ASAP to have a stable uprobes code base to work on. Rebasing is
painful and error-prone.

>  kernel/events/uprobes.c | 47 ++++++++++++++++++++++++-------------------=
----
>  1 file changed, 24 insertions(+), 23 deletions(-)
>
