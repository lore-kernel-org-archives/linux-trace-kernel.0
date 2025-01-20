Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A9188A0C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jan 2025 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358742; cv=none; b=DqmXc2aiPp2ahcoqS7FYPvV7pF5Li2+9Q2pdY+Fhhk9maiiqMR27YMyT/b0ulYwdTHaR3YrYor+dlPqBgQ0uSRc/xfMHjHLFC1mcSnkTg7kRhx9ZPLEKEb8TXwGEAvFjMFUHBepN+vMnofusTEAbBjzL5UMPHuk87ssMAyCtegA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358742; c=relaxed/simple;
	bh=EAfaou/82vAiFQRlUsLznPMQu7mT5Woka4Z4uiFAYfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8qBUkYvOAGsD4suZRfqe+SMxq4MyCo542m+mAVlksPxXpbplwJjN7INHJzJHrCbbolZelprf1sBJZPWDcdkxZPwTsxHzkcnu0SKPasj0SnZrWV5wHegBTjJb+zZzcNeXdsYB29t5AcU58Uog9310yJvjQDwhpdB/sloM1EGsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cff+soGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cff+soGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737358739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EAfaou/82vAiFQRlUsLznPMQu7mT5Woka4Z4uiFAYfE=;
	b=cff+soGgbkwPHzCvorgRDX+rk0o5/Z+Yx5D4ubW2zDiB6IEBtZifCxppauJv/OaSi0VT13
	ChKNDBLwwcsZ6a1iK6GmBLb7DnILLzQBJN1ivqter6vNDfY1QGofJmuZtgw2rrWYFPat0j
	tCFe7ghsIt+bBDZjOwnF87dd/2HXjGs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-E5Yck_pfMLmkTKn0oanihQ-1; Mon, 20 Jan 2025 02:38:57 -0500
X-MC-Unique: E5Yck_pfMLmkTKn0oanihQ-1
X-Mimecast-MFC-AGG-ID: E5Yck_pfMLmkTKn0oanihQ
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa66f6ce6bfso354464266b.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jan 2025 23:38:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737358736; x=1737963536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAfaou/82vAiFQRlUsLznPMQu7mT5Woka4Z4uiFAYfE=;
        b=EcTzMFGLnRnq4AGAn1Kk55eIi4e+FgKT4rifhfXLci3nvxe0brRZ+3xVqUPcVEqWKA
         8cVrvtUVI4BrYIJshAK9xOzNsCL0LYARb9UShFzThyHcldTky9urZVTLIMhQjR5wsOOA
         +BaiE1XAClQtzJD1Y91KgVc9cKdYVTDx6cZn4HP5/R4aAgdJyE6VuJ6FcCcuNh/jwgDG
         ZK86dkysNdj+HEvPXbO1+qxQj5E1c2RZdXI62s3sunLPuur0A9EvfHcikyaB13EMXDr0
         ayQ6ZFo/YA9OLm8wBSiDpjkrWtsFrLNngyBMmrFiccIjzvx2K+CiadMTF9+4/gJuXwg8
         vIug==
X-Gm-Message-State: AOJu0YyCEYpl5ZiO7nHh/mje4MvZsDrXpAQ4qSNtisYBORB2uyfEp8Nr
	LhzQRh0tXuCqFGrtu3okwrb4wL0lXdY3j28dUAZyOyRXb2+ohbDQa7CfkyLZgcf7JX8O/EWoKNW
	xod+J4Fq9t0xsCPSeymCy3wwYt3uVl38zX11POBzyVvoEk9saupLgZME0JsaWyy6oSMP2GMuKx+
	2cq+sTHu9oVw+skz93aaVE5jFrswMfCyWnjV9pEkFjxhlU
X-Gm-Gg: ASbGncuJISFVV8HKuFz1aQ+B6lslU6/rs3WFCQqAsY1vfOpDOrdyLqCnARVZgVd0fbf
	h3IHHbpFORX5VUA0q9ZWyEJPjLUtEWIyzK+Xy9yStrtxa+tJUP305wCRUSxRn12he11lFsyEIWU
	DuZJdXsDw=
X-Received: by 2002:a17:907:1c89:b0:aa6:96ad:f8ff with SMTP id a640c23a62f3a-ab38b3fc0f7mr1236965366b.52.1737358735861;
        Sun, 19 Jan 2025 23:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6k4MX5PQMKz6vQVUFegKVXpwAmPVrJt3JIRUT+5DpVHoF8DPeGUUxS7+Nwc+mITebGI6CVHpxEF0T1U/u8Sc=
X-Received: by 2002:a17:907:1c89:b0:aa6:96ad:f8ff with SMTP id
 a640c23a62f3a-ab38b3fc0f7mr1236964366b.52.1737358735431; Sun, 19 Jan 2025
 23:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109133852.360122-1-tglozar@redhat.com> <20250116201808.3c8721c1@gandalf.local.home>
 <CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com> <20250117160254.4a366149@gandalf.local.home>
In-Reply-To: <20250117160254.4a366149@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 20 Jan 2025 08:38:44 +0100
X-Gm-Features: AbW1kvazwyOqo-sCQX_1xiGGlmJ2JDgKn8MN0NRaaJTAYFbQl4pz3JRlEzCfwn4
Message-ID: <CAP4=nvR4an1nzBvPyYv3YBY0Cu=fNwTkEN0_q63JxNAi6799mg@mail.gmail.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin <cyin@redhat.com>, 
	Qiao Zhao <qzhao@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8GPqgFWHwQlEM3XIkd_zyEokLPEGJHAYKHOpSVqEAo4_1737358736
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 1. 2025 v 22:02 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
> Now, what I also noticed was. When it did crash and die. The osnoise trac=
er
> no longer creates any osnoise threads. Can you take a look.
>

It's likely that you have NO_OSNOISE_WORKLOAD set. The default value
is OSNOISE_WORKLOAD; rtla relies on it not being set, and rtla
timerlat -u resets it to the original value after it ends, so usually,
everything works. But it breaks either when you set
NO_OSNOISE_WORKLOAD manually or when rtla timerlat -u crashes (and
fails to set it back).

> So that failure puts the system into a state that can no longer run osnoi=
se.
> It takes a reboot to fix it.
>
> That should be fixed where a reboot is not needed.

I sent patches to fix this for timerlat [1] and as I commented in the
thread [2], the same has to be done for osnoise, too. I just haven't
sent that yet since I was working on the rtla hang in sample
collection bug [3]. I also discovered that OSNOISE_WORKLOAD is not the
only option that rtla relies on being set properly: stop_tracing_us is
also affected and possibly other options. rtla should set all osnoise
options properly on every run, not relying on them being set by the
cleanup of the previous rtla run.

[1] https://lore.kernel.org/linux-trace-kernel/20250107144823.239782-1-tglo=
zar@redhat.com/T/
[2[ https://lore.kernel.org/linux-trace-kernel/CAP4=3DnvRCw_2hKPUyd7obZv2Xh=
o_mjdSC7EmozFsoeS0OZC9xaA@mail.gmail.com/
[3] https://lore.kernel.org/linux-trace-kernel/20250116144931.649593-1-tglo=
zar@redhat.com/

Tomas

