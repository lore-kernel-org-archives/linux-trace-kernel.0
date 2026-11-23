Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445955;
	b=wydf2NeXllwLX8YgU1ZCLRYtLlGemaXDsLsLhVNiBI9PhAmDyPEGJPCe9+Gg8hj10tdY
	 HrbEFP5vel4hlJMkegTgoV3ajNmFxywW5mk6B/0kW4SHdkKMBeZZtqN2dJPpySWeS6/h/
	 O02Wfo47jFb7pG0I0JAQp4jfGAPLj9ekORMMOVVBz3igTSAQinNHoqaI6s57hlCDq5F13
	 ooaWUb0Sj6Q7TNVD0XOak35j/NEmaK+wSwlxc73l93sL8GGzqYWtAJY1BN8gfjsts1olo
	 FqMSy+Ef4UaCJOu/2ZPQXxi9nHmievL2eyzM2Yx6FoIyqa3TRt0TYdRZ8S5RIB+Cl4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445955;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=5WG01q9x7fNydHzOUJiz8YwOwYvkUE1Kpri/g/6ilc8=;
	b=KQuR4bBwPGwcvW98gS0yUmkiKA78kkkV7QLbd0T9h5gk4v7qJRrGK5TFng6qaOneLvYe
	 JXuFd726tUOzYJXV/72gQxWW08D8k2UDRf2IZ26AzA6HS8vr4g3cvo6VSh9sKWcxbMqt9
	 i1p+zZd01+vVERUNTBr2SkWMI+j9NvcrIdTu10LMvvhmzEQXrjFwqej3wT4uBZUs24Mi3
	 OD7xjslzXNWK3mcIRtH9R9psUsShp8A7eqewKjx2TnYSpac/cOXhxZ8Wym/XFTffWFL0d
	 PAvPy6s8ysTyDiF9+kN0tqqyW5nY33OQaTGmMgMI5KnpaB4OngmSwsop7omMU0VwQ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ayomnPRg;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4C606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 14:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EB4C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ayomnPRg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795445954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WG01q9x7fNydHzOUJiz8YwOwYvkUE1Kpri/g/6ilc8=;
	b=ayomnPRguVXDT4vFdjvKKl8S/XvjRXbLi5J3GZ6o89Sgng0wq5IDfTYrhOEUkmNN2p1ld/
	Q3AUL/kYhPByQMetVMMQ650lkwNToxVNbnmaMo8ROnE2hwzZQv7dg/UuXp5cdtGSTdIN/r
	Mu6Quf0S++uTn+CTYz6e4lfnBegJU6w=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-zXVXlNhHO5uVsZMFUDXOdw-1; Mon, 23 Nov 2026 14:59:12 +0000
X-MC-Unique: zXVXlNhHO5uVsZMFUDXOdw-1
X-Mimecast-MFC-AGG-ID: zXVXlNhHO5uVsZMFUDXOdw_1795445951
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so2440833b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 06:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445951; x=1796050751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5WG01q9x7fNydHzOUJiz8YwOwYvkUE1Kpri/g/6ilc8=;
        b=kNBpBEWkKYdVwZSbbYw9oPzuQM0NXOXkPjkC+qK5nsx9+eQfzDQqc4GlYNr59/WeHH
         8iQUeVBGP96EKYjobKbcB4bO8EgyMUt8uxI4t62FtINdiygf2ZdS82a29XZgpqd2KlSg
         UxrdXHsGsDMNu19gPRG+i+zsqaEdhYaxpP5I3tkaCC/zgA0igm4nJxm1bFS/zgFuXZEr
         HsufgUZZUjCr8Mu2OCp9qPThl9/8k7cEMuUsxj08dDl0AOyAVTJDjqdncSmEQ7JjGJxF
         WSvteHL36SUxoiFAxv7FKpBtQFAx9f12XKMtg4b3GRBO7d/n4M8HnfEUqTGjGblNQ0tk
         0XVg==
X-Forwarded-Encrypted: i=1; AL+hErEt57UARVkbfOm/iMr4bZTKcq6B4qIlEtx0Ropp9WrnKzWNk4t6RitSO/Vq6/PUwK7WxHaoT72yfZaQzdhQhIDUyks=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xNq+Ih+IoYHrKDw0ydmpbZBYEIFFUlnVBFcNaBtEyFc04fREc
	lbXXuEiBccCNvMWyRO6trjfo6J1ptHzPHl7RM6VUNHehSwvTKU4FTvacSITU4pnWkWzpG89CXbA
	Xy05XFzTJaJpEdshcZbWYAKTk3XBLI2QUJPN1LNLBZjd5T7wWU9u3YNu1HDj/3OOdLy9/YsTav1
	ID84S0qS53Ycnl+fzaIq0jlpChO7nfa4iELl2L/BuIRFor4LaonGP58bRWqCY=
X-Gm-Gg: AZFdTZfyKO994/DIqfVGYUEBM6zPr/QgbcHjCkOayT3l4dUyD6DJBp4JNs7/O4J3IMh
	4MBQE8RB9IE2uUtF1omnfBV8rBEymKakstIIt9C/e9xvWpD/Za8MD2X+ZqjVhnrMy+tBQmmEXxx
	SfRBcAE1RUDHrVGW08DkACWLNw6xVIf+LqpllD+ZDZ1VRIUJ3xbjRnBj444wJVIY+4ugfxk2E0A
	j/rAiv563duT5A=
X-Received: by 2002:a05:6a00:4b03:b0:89e:3ff1:920d with SMTP id d2e1a72fcca58-8c87d01fba2mr9824124b3a.45.1795445951347;
        Mon, 23 Nov 2026 06:59:11 -0800 (PST)
X-Received: by 2002:a05:6a00:4b03:b0:89e:3ff1:920d with SMTP id
 d2e1a72fcca58-8c87d01fba2mr9824105b3a.45.1795445950862; Mon, 23 Nov 2026
 06:59:10 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179360289114.124676.5863600854966859222@163.com>
In-Reply-To: <179360289114.124676.5863600854966859222@163.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Nov 2026 15:58:57 +0100
X-Gm-Features: Aa3M54p2FJodcylC0BM21pe9oXJlWt7vaXOK68xEMFI6ra6ca-U3i9Z5NfTFnEA
Message-ID: <CAP4=nvS-iHK1aFiwvdLtSf4sCYcfFvqj6cKjkSb0eJs-O=qfmw@mail.gmail.com>
Subject: Re: [PATCH] rtla: reject -e, --filter and --trigger without --trace
To: Chaosheng Qu <quchaosheng000406@163.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EmfHijQ4l_m1sV984BewnM9PaEZvI-3Ju7wRphApmUc_1795445951
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 8:03=E2=80=AFAM Chaosheng Qu <quchaosheng000406@163.=
com> wrote:
>
> From: Chaosheng Qu <quchaosheng000406@163.com>
> Subject: [PATCH] rtla: reject -e, --filter and --trigger without --trace
> To: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tomas Glozar <tglozar@redhat.com>,
>     linux-trace-kernel@vger.kernel.org,
>     linux-kernel@vger.kernel.org
>
> -e, --filter and --trigger configure events of the trace instance that
> --trace creates, and trace_events_enable() is only called from inside the
> block that --trace or --on-end trace enters.  Without either of them the
> options are parsed, stored in params->events and then never looked at
> again: rtla runs to completion and exits 0, so the user is left believing
> the events were enabled.
>

This behavior is already documented, see
Documentation/tools/rtla/common_options.txt:

    **-e**, **--event** *sys:event*

            Enable an event in the trace (**-t**) session. The argument can
            be a specific event, e.g., **-e** *sched:sched_switch*, or
all events
            of a system group, e.g., **-e** *sched*. Multiple **-e**
are allowed.
            It is only active when **-t** or **-a** are set.

            This option cannot be unset.

Currently, the trace is the only consumer of the events, so nothing
really breaks when the user requests the events without -t/--trace or
equivalent.

>   # rtla osnoise top -e sched:sched_switch -d 1s
>   ... runs for a second, exit 0, no trace file, event never enabled
>
>   # rtla osnoise top -e nosuchsys:nosuchevent -d 1s
>   ... exit 0, the typo goes unnoticed
>
> Reject the combination instead.  This does not change what happens when
> --trace is given: an invalid event still fails with "Error enabling
> event", and a valid one still works.
>
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
> ---

Any reason for not just keeping the current behavior? It has been
there ever since rtla implemented events. Changing it will break
existing uses that might always pass -e but only pass -t when needed.
I get that the behavior might be a bit counter-intuitive, but that
should be covered by the manpage.

(If anyone else has a different opinion, feel free to chime in.)

> [cut]

Tomas

