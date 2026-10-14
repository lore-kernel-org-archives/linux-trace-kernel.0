Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A73C2774
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971535; cv=none; b=obDnzbig19I+MjAzu/2poAKzcNoRvfvcIC58kpaybcBmNsO0wV7Pate/G82FUpt/jxmALEbpWtHo9aN3IZsE98Jz2H6L9rOyGs227gNxl3X69zjlCh5BnmGHUJID11MWMU2yDVN6QpR0MYXe4CzrGeUIvjeqSQ7XkOdrpG+CAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971535; c=relaxed/simple;
	bh=kLTudfeiXplbh5MagTQ6gzarl091SScIP9jzkWyxtAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nytEz6aKGc3uFD5pi887rwwoQ+3bjuS9QEWjb/78ILiPc8fgKOiASH0jn8TAotQUPyH7j7d7iOMRQDROYNzJOEFgWCqECL7e/hBF1RsBkIcPMG/zX1oWJYaX84QPmtJNRRaTdIkg5SYll7qjKhIwAFsFFBBqeyVWtYuqoV4fuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEm+/mrI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEm+/mrI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791971532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kLTudfeiXplbh5MagTQ6gzarl091SScIP9jzkWyxtAM=;
	b=TEm+/mrIxg2/pb65mSD1wT9ZQPttBcE+rP/TrvfHzU1q2VBAx2tka8JkQkJDh3U+Vy9kIw
	r3Batpq92KC733/5ZMn7+8f+ZkuBVkY229B/rMFmkyHCrsZoeFPdQyjgsAgWp3J6M+iOtx
	I0CzMcZN5qXAKmkmBLWMSzKGRR/FtB0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-wzr9MNNIPEOiBRcfrtH1rQ-1; Wed, 14 Oct 2026 09:52:11 +0000
X-MC-Unique: wzr9MNNIPEOiBRcfrtH1rQ-1
X-Mimecast-MFC-AGG-ID: wzr9MNNIPEOiBRcfrtH1rQ_1791971530
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c415561aaso2534001f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971530; x=1792576330;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ew/yEA9efwsEsgTzBND1D0weZnW/cI9Jw/YyC/suOs8=;
        b=RpGm7FZO4gG5umhfjYyCY6v1YzGNuEmlkCySXusPzPXORXrxuy616zRb8jjpM+Le4v
         OhWZZXhaI8/DkW40b3/8UxwIPBPJ9LCD1KvB8PooQq3+BDowpbSxr3XwRT5Oj65Un/+y
         A9NNz2Yp6MUW2kqS08vdycfmr7sHLYo/XDqEBmZrgCYj9I8LYOeoI7Qf+Mswixg/fpJw
         F4B1UzML3Bs8mog1H3OL4cN11a8/CXTJ/B9L2EHhYDkPrIYoTywxLd8N85lGrQDSZI6w
         WUyP0iSzcxLEE2Tj5lRNdA+2YBDOSnorfzKXB23iE1PmuFw4Et1A2L8il1a/j1PaeW+K
         xHlQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3HhK84Izt0WGKrVVnJ68VaiSTamg5TpAK71F4dbbJmvRY3HqSce2lp3GbKYe+f+BD6TJJtoLzZtEG8niN6SpByic=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQUbg941OHfihvukWNz2WB8R7fwLJBWHrSDh/Nwh8mszpYflqw
	+aMZFiA9u7r+bg1QymU6+dAN4IaQGVVd0Ac7Snp8Md/+XIQQl1jRjBMwTf2hYhH6CVX/zrVU6uF
	QHA17Ypl1z171QHLeqXMa3wvdZTZluP3wyVx0rcSn3dQmIVnTwlKNMXleWz+5N2x7bsGBW8nVRw
	==
X-Gm-Gg: AYBFou3f7rcNOQg6lrPcOAHC7uxv1APM29mM+jsxOh2tU9d/+bfJrdA+L3Xuqi9OuAp
	/5QLe26YrbOnyN9nB8xd6Ze9yoBtBkHTNMVmQh+pP/Yt0FfvDax7PnU+KLCpxRK1Hj1d/f14qul
	e8okgnpLKAIf0NFMioc5Y+1ruxXZRrD6KhnUXhNdYHMBhgkDr//cPejKXKZYe1/HVBWJogbR7Rc
	G7/S6yfE9nFtAM2Gs2meST+rBOLl2mfYC4bCIAPlZHrlN9IWOxEQvkAvddWhRhOi/CN29htcceK
	Beg8A1R14v2UsF164U5Hv8E2vYklj6o9rUIoZkK00wfLSlivjz+iC+WFnj2VW5uw6QyNdbfbDRE
	GZQtaWVS1r2pZuXL2LrBroBlrzlWD
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr312576255e9.9.1791971530374;
        Wed, 14 Oct 2026 02:52:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8b70:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a18e4a01acmr312575565e9.9.1791971529966;
        Wed, 14 Oct 2026 02:52:09 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm679092125e9.8.2026.10.14.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:52:09 -0700 (PDT)
Message-ID: <1ff1999324ecbbfe9a36f8c088d7d4122ae59177.camel@redhat.com>
Subject: Re: [PATCH v2 04/15] rv: Cast result of model_get_*_name()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Wen Yang <wen.yang@linux.dev>, Tobias Schaffner
	 <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Wed, 14 Oct 2026 11:52:08 +0200
In-Reply-To: <87jynmgm94.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-5-gmonaco@redhat.com> <87jynmgm94.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ty5fB27L6_jlE9QLJoAGo6tHC5tIoISqNeU8EJ5Fnw_1791971530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-13 at 08:14 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > Functions like model_get_event_name() and model_get_state_name() are
> > shared with BPF monitors, however those programs don't play nice with
> > string pointers without fixed length and the event_name and state_name
> > arrays need to be defined differently. This gets the compiler to notice
> > those are const char and the above function discard the const qualifier=
.
> >=20
> > Drop the warning by casting the result to (char *). Note, a cleaner
> > solution would require to modify all callers, but that would require
> > changing every single monitor's tracepoint and the advantage is minimal=
.
>=20
> I prefer the cleaner solution. Just mass replace "char *" with
> "const char *", and manually fix up a few errors and we are done.

The reason I initially didn't do this was that some lines get beyond 100
characters adding the const, so I'd need to break them and make rvgen even =
more
complicated to generate things (TL;DR still laziness).

I'm actually taking a different approach and storing everything in macros l=
ike:

#define DEFINE_DA_EVENT(name)=09=09=09=09=09=09\
=09DEFINE_EVENT(event_da_monitor, name,=09=09=09=09\
=09=09TP_PROTO(char *state, char *event,=09=09=09\
=09=09=09 char *next_state, bool final_state),=09=09\
=09=09TP_ARGS(state, event, next_state, final_state))

So both per-monitor trace headers and rvgen get simpler and if we ever need=
 to
change something again, it comes for free.

Gabriele

