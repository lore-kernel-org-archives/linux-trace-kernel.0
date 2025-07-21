Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6E2877F4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112951; cv=none; b=T4j5vxSZ5qO9dGR9qxr9UvIyNLkauoAM0fxAiHRT+3m11jnbxZW577XVEecb3Cc/oA7Y8P5nhlPXYrdj/2t+HLLKv68or9YyV66hlwo/w8MH6mD+aBmEsJcvhlR7ggVeW7Uw/I7SRdKx81KwgKeveDgVGuz7YhP73RDv2fX6N4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112951; c=relaxed/simple;
	bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3SBWoJtuOAT++232r6MCSlz958zDPs5RlOW0liX7LJgjzV8qiiY9lYvK0cx6vadCzyO1WtRymGDjutYC7FYFE8TsLDeGdxM+XAU4qnngFoTNcTgi+8hEqmXdHj6RN2pwWCvuHbz1a+jKAPYrWXI7p8OAWQujuiJY+8bqbsOe2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka3q2wTU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka3q2wTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753112948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
	b=Ka3q2wTUhSIruk8mtgUcUv0mQDC9zDBZOPbJ77hXrdb54v1J9Ds2IJP6c0cRxXsnBWqN4c
	mlOiUbAF6Sn5/nbVqfdYeyQMNf95j28elUGnE8is7NqP1hxu9rEhBQ/8unte90r15PqLv7
	AKfY/2knrSZ+mfDfwOKgtV+gV/pgb58=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-5snScEqqOC6CwEAdf2OPRg-1; Mon, 21 Jul 2025 11:49:06 -0400
X-MC-Unique: 5snScEqqOC6CwEAdf2OPRg-1
X-Mimecast-MFC-AGG-ID: 5snScEqqOC6CwEAdf2OPRg_1753112946
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so23886765e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112945; x=1753717745;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POrcf+RPRXp8K+I6Vss6WEdWtp5M6eqlG7yTLHztb0g=;
        b=NxtQD9pbG93zDzGhpGR3BXopFRcnECPmnVokl1b48n/2T2GXNdenB8yHPEDA5/MNRb
         sEm+hJcpdU6OeLh+JHgwkrLel9+YzhVWfXxR7HHUjxCRsEs4NOI4Aysb0hyg5GnnSVZ2
         J5OalHH/523lAVVmpXP6e1a+J/U+4K4hgT+1GSHPheupsuUvF81+Uyju/wD/AODkWhP1
         Tx7GrGxWWdU6MlOQbf3BOUW5U3P8qQpALiS+tPy6WMxxZ820S2iRlvpp2S5HSX71NMuO
         hlR4hwcUeL1JSElQNfyqN3EXzTOduNJtQi2wlS3xcp1cdbl8DY49iQQ/r60P5fMsHYvL
         PneQ==
X-Forwarded-Encrypted: i=1; AJvYcCVROVf4/hMs6Rir7p6NlqxxxzOYPzexn5XagNi78Rp5qJc+YpfN2V1w2E85Zab/zpuR0v9OhLS72iAkKUvKw9ORmCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkh7fyIaUrKPkWfxUXfn9ezuHdMmHXqesK2wgODHQd+2kCP0Qg
	2+Piqhp32kp2lZNZeay+uHx97jVDw+VoVtQfqMcW1j3qjtSXeO74ZK7RItlZba18HqUZYuH5K5j
	FYXdqZzm5dYSTY0jPV7QKJ2lXhdZECWA84Rq1xQ3DZZBwh35bmWP6bigwvYevSDeqebbZOB6Nnw
	==
X-Gm-Gg: ASbGncthkDAVl1AUmyRoGqaJ2TIEgYVTr31NAM4qQDJ1wv9W53q4P91cJrbsw7uLB8L
	iFGBGAEFSVjnVDE7kZPoRKvn3TeVzsdqXys2NZYc1ZZfKy0Fi0czzEMCduNCnRIPCttvSvnWCk1
	J+xnAFlhyyX93obEWB0TW0MWQ3EC9jinxD/hV3mAKpUYKTMadsX2Rr5ZlzGnOvzf1XMB4/+fcbF
	R89J5PcR1gZzBAHUOStLD49jvJxLo+88fCNe7rlqU/Fd9UtdNyqTxPR0dyDldIZmrGBoJ6kTGY/
	jCN6NgWZbgGP5fTPalXDTf+eSBDh5cWtirp4wAqzYovYb9uj2UbVAE2fv1BaS5/S8w==
X-Received: by 2002:a05:600c:3f09:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4562e38aab0mr179789955e9.18.1753112945468;
        Mon, 21 Jul 2025 08:49:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIFWo3B2GOS//BnnNmJIYALEj7XiYgiNuybauiYRbDvMNgRDKwifmEKsxQzLiJICQqZvTHsQ==
X-Received: by 2002:a05:600c:3f09:b0:456:2d06:618a with SMTP id 5b1f17b1804b1-4562e38aab0mr179789745e9.18.1753112945009;
        Mon, 21 Jul 2025 08:49:05 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d581sm10692443f8f.64.2025.07.21.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:49:04 -0700 (PDT)
Message-ID: <eabfae8b0f29c88437cc51af21797e869d99aef6.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 17:49:02 +0200
In-Reply-To: <20250721140425.OeD16I4D@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
	 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
	 <20250721140425.OeD16I4D@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -40mAdDoJ61NrkBaJO8O053kchJXjHLnPKFqfJxQ2ks_1753112946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-07-21 at 16:04 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 03:20:44PM +0200, Gabriele Monaco wrote:
> > Mmh, I'm not understanding how, let's assume I create a custom
> > reactor
> > as a kernel module and I want to use it on existing models (built
> > in or
> > modules themselves), I'd do.
> >=20
> > =C2=A0insmod myreactor
> > =C2=A0echo myreactor > mymodel/reactors
> > =C2=A0rmmod myreactor
> > =C2=A0## I want this one to fail because the reactor is in use
> >=20
> > =C2=A0echo nop > mymodel/reactors
> > =C2=A0rmmod myreactor
> > =C2=A0# now it can succeed
> >=20
> > How is MODULE_SOFTDEP helping in this scenario?
> > Am I missing something here?
>=20
> You are right, MODULE_SOFTDEP does not help this use case.
>=20
> I did a quick search, it seems try_module_get() and module_put() are
> what we need for this. Let me amend the commit message.
>=20

I wasn't aware of it, then sure we should be using that.

> But my essential point in this patch is that, the current ref count
> implementation does not work. Furthermore, we should use the
> centralized kernel module's facilities, not implementing our own
> custom logic.
>=20

Yeah I get your point. If I understand you correctly, what's broken is
that we just return EBUSY and ignore that on __exit instead of doing
something about it (set nop to all monitors using this reactor).

I wonder if we shouldn't also fix this (using the module refcount).
But that can be done in the future, I'm not even sure reactors as
modules currently work.

Also, I'd need to verify this but depending on the order of exit
functions, we might be seeing the same problems with built-in reactors
when active on shutdown. I'm going to play a bit with this and see if
this workaround of not deleting the reactor was introduced for that (I
doubt though).

Thanks,
Gabriele

