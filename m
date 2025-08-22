Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564A22D7A1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887426; cv=none; b=GCnSiYv5CKV7wt9cCqCKp9sQQ6JXGn1rhIPDMogqJTtFHIfJgjRRmvlgLMuOkimIlYrdVLegn1kKCNrlaWXZENW6niNkULBTYPmWDR4CzRY1GkDC5Z0X9gy1nv/b2HKilqVVlLWwvSB40Xze0gb5sUPKBaReJQUagsF7vWOLa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887426; c=relaxed/simple;
	bh=KOTjvo5Uz94OrGKZwMmoKy2q23bXBZzAMoEvTsB4Qr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejBrWZMAaQSHBY1E3jvGqWIBl5KX/FV9ZVaN3j4T27Nzt81Tg1blCDOnndD0Dqhz0S9zjr7Y/nA5BKtEkPkb3/2lhcScjmFLI2g2aIJqNI0HTXtEmdgsob0HbsjdJXwF0tES5CXkmTp+LWHEfjNSQEkzyuiopx9BFoxdNcf94UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=GJx3k4zY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="GJx3k4zY"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e93498d435cso2534012276.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755887421; x=1756492221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAVbxvKFmubmCFIV/MmqSVaMXCvHJLOw/8uDYKGFsdk=;
        b=GJx3k4zYkiC+UXBbMEF1Q+wxn2W9jyOyV3Ay3T0OQlxYhbDcqgKIL18/i76WdYtmhO
         KRv86c2C6+UajfE31oL5rW55NhIkuo9xbW1fx3xN/SjU3DRX2yocqy2bNpzYSrH+414S
         72ZBElOZD+ZvrSIl8F5emfOGKDJ5kRF3EpwOcGJRVKRkseHX8fhQvonjGHe4vAJkehE1
         Ba6YBR89P/9uXMJuRY8ihzhdUHGk3S0ME+yY8rrdXhgDOKsy1ZtTN5XgEpqtusd+R+Sz
         3E+D2g/Kf6UW8Jw5rlY/JqeOT+amHhFDIT6lm61WBgKTfFnppgzIlz2+LzDwBu1UR1NE
         AlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755887421; x=1756492221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAVbxvKFmubmCFIV/MmqSVaMXCvHJLOw/8uDYKGFsdk=;
        b=ON28cUfWO6VHMQ/j0YIsQpb9/Uke6EWqPxpXPR2lYILYc4nP2vagMw+l57a8BVAcTn
         NrVDsMj+MnpK2uEG2XmXZRil69UsNDXvSFDhg/HNkmkstuN8xmQ2oqdazC4hYknm/yNs
         EkL7/FrtmsSEgqPOS5XE1e9X2rNVtshN1x0YK/QQp/6KH7nEeM3iOYP8QRi88ZYj6JTw
         6fRF1UEy4IKp8zRaikEC2YBdJJ0HlzCOBpfI6YYzb2kLXqR8MyokNs1oQpRfTJrKKWi7
         PAKL/DEQUXUZ553zvnF9fLohD778eEPgMxXfb5bP242lfLJIs79qeN+JC7Itc8kQ2Vhq
         nqtg==
X-Forwarded-Encrypted: i=1; AJvYcCX06XCHJHkNZYcdWoP2KhzHn03RiSIna7mPxI9qjNi7jLdXT0IhM/vAXjfzcDBxCozrvHt/efrfy4ZRvTnNo4Xs97Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dyladDuIcZGmLuxRQlMVwTFpPC/iZ01JC0rOMwuoR1+DTmKw
	5n/V5SjnPqRNRMvO91T+wVGm8HjLB8WZxBeZBkwwvrWEFohXoWDryBKKPUWlngbSpdUrZA2oh0b
	W8dfnX3P2PW9vKIwvOuDTCK6I++Vb3f7ZsAA66nBM
X-Gm-Gg: ASbGncss6Xzd7kAhV7dyLeCvBbnse7RjGnlnT4CAK8njIkz99gNe+yEw2lzcpq0WimZ
	lm+LKmwZemjqMPweOzCD030GYLBJ5blkubjCJofVGHVxUgbtVyvv9VUzHPbl10sOTSw8plPHSVJ
	8ZhyJUidBveVhjCh3MVZQK3i/LGT7sfc2CWfCvJAgr/F574GLFoDRZDPYxBBWuHaK494LsPmMEh
	dnoxAQNCO48D5e2
X-Google-Smtp-Source: AGHT+IFpulQoP2yus1YpJjiAq8SECqslg0G79YGF/MlaiCfrGmAd1Wfa+eDPH6ROAf0AXOkQJfJYAMY5NjQ+s8WZELw=
X-Received: by 2002:a05:6902:1285:b0:e8f:e526:fda9 with SMTP id
 3f1490d57ef6-e951c23d0femr4833724276.22.1755887421462; Fri, 22 Aug 2025
 11:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
 <e11fd419-1095-471e-a57f-fc5ff7ce713a@ti.com> <CADL8D3aR_ecr4q54cX7yfr_aDPA7NhXmLhkiHjUY9MjNZeg78Q@mail.gmail.com>
 <c05c0a13-e7af-4fc0-9363-b629b2c48201@ti.com>
In-Reply-To: <c05c0a13-e7af-4fc0-9363-b629b2c48201@ti.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Fri, 22 Aug 2025 14:30:09 -0400
X-Gm-Features: Ac12FXwko-lHWrKeX_HXwKQRgoNpj8lFRexnA4jkRYcVCsmVQHRfYtBjR82Lv-o
Message-ID: <CADL8D3aMOcuWY+5wy92Vvd=WK4kgOiSz2z+OEoUtwL_6Z8CDVw@mail.gmail.com>
Subject: Re: [PATCH 0/2] PATCH: firmware: ti_sci: Add trace events to TI SCI
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:39=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> On 8/22/25 11:05 AM, Jon Cormier wrote:
> > On Wed, Aug 20, 2025 at 4:04=E2=80=AFPM Andrew Davis <afd@ti.com> wrote=
:
> >>
> >> On 8/20/25 1:10 PM, Jonathan Cormier wrote:
> >>> Add trace events to help debug and measure the speed of the
> >>> communication channel.
> >>>
> >>> Add parsing of the messages types but I am not sure how to parse the
> >>> flags, since the REQ and RESP flags conflict. Left as seperate commit=
 to
> >>
> >> The REQ and RESP flags should be handled by different TRACE_EVENTs. Ri=
ght
> >> now you only dump the content of the response messages (the ones in
> >> rx_callback), also tracing what is sent is just as important, so you
> >> might want to add slightly different ti_sci_msg_dump EVENT for the
> >> sending side which uses the different REQ flag parser.
> >
> >
> > Does it make sense to have seperate trace events, one that only decode
> > the hdrs and ones that also include the buffers?
> >
> > I'm bothered by the code duplication, but am trying to convince myself
> > it doesn't matter.
> >
> > Currently, with the above updates, if you enabled all the traces,
> > you'd see something like:
> >
> > [15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D=
00
> > flags=3D00000402 status=3D0
> > [15.xxxxxxx] ti_sci_tx_msg_dump: type=3DSET_DEVICE_STATE host=3D0C seq=
=3D00
> > flags=3D00000402 data=3D<data>
> > [15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=
=3D00
> > flags=3D00000002 status=3D0
> > [15.xxxxxxx] ti_sci_rx_msg_dump: type=3DSET_DEVICE_STATE host=3D0C seq=
=3D00
> > flags=3D00000002 data=3D<data>
> > [15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
> > flags=3D00000002 status=3D0
> >
> > Presumably if you were worried about timing, you'd disable the
> > msg_dumps, avoiding the extra memcpy's.  And if you only cared about
> > the data being sent, you'd only enable the msg_dumps.  Does this make
> > sense / is it worth the extra trace calls?
> >
> > Or removing the buffer decoding in the msg_dumps, removes the duplicati=
on:
> >
> > [15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D=
00
> > flags=3D00000402 status=3D0
> > [15.xxxxxxx] ti_sci_msg_dump: data=3D<data>
> > [15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=
=3D00
> > flags=3D00000002 status=3D0
> > [15.xxxxxxx] ti_sci_msg_dump: data=3D<data>
> > [15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
> > flags=3D00000002 status=3D0
> >
>
> I like this one ^^^ but I'd also just remove the `ti_sci_rx_callback`

Sounds good
>
> trace, the contents would always be the same as `ti_sci_xfer_end`.


So in TI's 6.12 branch, there is a response_expected variable which
skips waiting for a response message. Indicating that there won't
always be a rx buffer.  If I keep the rx_callback scheme, it cleanly
handles both cases without changes.
However if I change xfer_end to track the rx buffer, sometimes it
won't have a header to parse. Or sometimes it will use the TX header
and sometimes it would be the RX header, which would be confusing.

I could keep and move the ti_sci_rx_callback trace into ti_sci_do_xfer
(-> ti_sci_xfer_rx), right after the completion and timeout check.
This would keep all the tracing in this one function, though if
someone wanted to know if there is lost time in waiting on the
completion it wouldn't be tracked.

https://lore.kernel.org/all/20241220114118.uwi5bsefxnue46re@lcpd911/
>
>
> This way you have two sets of symmetrical trace events, a "begin" and "en=
d"
> that can be used for timing measurements, and a dump message for "send" a=
nd
> "receive" that would help with debugging based on the message contents.
>
> As for the code duplication in the send/receive traces, I'm not sure
> what can be done, these trace macros already confuse me enough without
> trying to optimize them :)
>
> Andrew
>
> > Or do condense the trace calls so they all have the data into something=
 like:
> >
> > [15.579036] ti_sci_xfer_begin: type=3DSET_DEVICE_STATE host=3D0C seq=3D=
00
> > flags=3D00000402 status=3D0  data=3D<data>
> > [15.587595] ti_sci_rx_callback: type=3DSET_DEVICE_STATE host=3D0C seq=
=3D00
> > flags=3D00000002 status=3D0 data=3D<data>
> > [15.606135] ti_sci_xfer_end: type=3DSET_DEVICE_STATE host=3D0C seq=3D00
> > flags=3D00000002 status=3D0
> >
> > Simplifying the code in the trace header.
> >>
> >>
> >> Andrew
> >>
> >>> make it easier to drop or make changes depending on comments.  The tw=
o
> >>> commits should squash easily.
> >>>
> >>> Nishanth Menon and Vignesh Raghavendra requested I send this patch
> >>> upstream.
> >>>
> >>> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> >>> ---
> >>> Jonathan Cormier (2):
> >>>         firmware: ti_sci: Add trace events
> >>>         firmware: ti_sci: trace: Decode message types
> >>>
> >>>    MAINTAINERS                     |   1 +
> >>>    drivers/firmware/Makefile       |   3 +
> >>>    drivers/firmware/ti_sci.c       |  11 +++
> >>>    drivers/firmware/ti_sci_trace.h | 146 ++++++++++++++++++++++++++++=
++++++++++++
> >>>    4 files changed, 161 insertions(+)
> >>> ---
> >>> base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
> >>> change-id: 20250709-linux_master_ti_sci_trace-91fd2af65dca
> >>>
> >>> Best regards,
> >>
> >
> >
>


--=20
Jonathan Cormier
Senior Software Engineer

Voice:  315.425.4045 x222

http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211
