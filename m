Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C2296BA8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998548; cv=none; b=YA3DSwNLGtG4lDp0Cd4Gu6J2/aiPkYTeqIEgrk1FmPPSke4M2Vf7TMCt+iKaDeMa46SROQs4IyTBwqqFa2Fl05HTD8NZUWxGopgm+KwXdx73wPOnNhyklb/QOV8GcqGzjgE+kfoy676VFNVpurnmseUHdKLirPWmSgIRs3mKabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998548; c=relaxed/simple;
	bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXWeqMGuo5A5rWG8DH5Vo2MqpoF9T9HXeaUr/MqySuhoWOuIb3NCM+4ss840ZD0A/6SLfoT6KdOAlFbTvzBbXNFabEQIjxCVV2lg115GbXBiocMDLUFbEo4c7JvcMSzPQv/ALTO2AlwrO9cjG22edHWT9gOK4un0sv9ryFEaFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOW+ZxaO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOW+ZxaO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so43331666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762998545; x=1763603345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
        b=mOW+ZxaOIb1Eut2DwNyQaEOe+GAfe1E51sL91ZgLlHGt+PrA7Jd0l3bsFU+EVLYogf
         oyolsb4l0daYwhvV3B6YgKZzyahMhgwnBPkpfu8UerMk3fShYUiX4F/q1X1yi8r97oX9
         LtmjmOENZqCHCYszWQETlxHXk6CIuZhMe6l8TRwGJlSQZuzi9MMA8jJm/FEN3Gd/y5iD
         IrevKtM1Y7jvCe6ZPZX3BGUMWplUIEBPsZ8MWbF7WPZ2FR4D4FAWUQgVLkyPsXicJDhW
         HcL9dIDTwhRS7H0EaJvMKz5i/F456QZXKaxE8on2a7WgYYF9ussF48izj6KWKrwH+tZB
         mm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998545; x=1763603345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BXa76nBAYuWd/9wvqfbPPw7zbjbNNpN6F7iPGRfgtg=;
        b=svFnCd1rOpZ9WUh1KfckLkq50+AG5U8Ij4RMnyglG/EnvqgeS4cqMoxqYgxJ6OkcSY
         lmv8kFlPq+/Z3L+/nGpL04Tzn0zjddqRCHAfOAOichtxz+9KJg5Y5XXexervwpW1Z5H6
         gV9duzDf3jpWM3/1Ryzyt9VTcOLt7RSpyOVegaBNx6D4UWTw+gmRD+GDLm/kimql1zUb
         ToRJdSll46LXrm9MenXa1fQYDsmmWPgCjBVY2X0SdkPRUqITSwY6iAXeAMleqBL4xUcm
         x6dKSGq4MS70uUitEBJg0xbJFkl2PqPZNqVbk8SDBxVjkHf4BGEkXITbWqrYMxTwMEH3
         j4yA==
X-Forwarded-Encrypted: i=1; AJvYcCUh2QFueyNF8TYihEhuwyZ5lop5sJ1fDOoBShNHvW8XTrjnJAGLW1eX5L83Ktvw494HO+1OPkh8JeovUvdBME+2WkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWk62VzkBpj2mcMUECy2xWB//zcBBrZkfstiOHMFXTBVRvqHTd
	+zAue28GS23GEK+r5cNIFkoYqiVHcyv+iHDvOu3YoF9iVx6ZgU7pz4fTH1FNrx67htUCl+flXC4
	1zMx7UMBX/V31NufLJYKowXcwQfKQxQE=
X-Gm-Gg: ASbGnct7mNU3gKoVvfioc0zlgCL6wPCBL2wlSLmWyrm57yAze05/jThnLRoUpD6I8wf
	vo9V7sSuWFqgzJxRLeNihyVQPfxvRFJaBYaP5tbwtW5NI4WvSpv90bQlqYk26PRTj8pzEexvpY2
	2nQFgsOTgXFl/5/5oS61hXukXxmlAb4lRUL52tfSzDgMTQ6Qbm8e83inoO6YrXLJyoXzvnJscum
	R8zC8KJO8i21kelgkmM4H0h2xUvW6eKBTNr314eMmJwjgXxlomGGkjR/J98RbddEYXJ/lNU
X-Google-Smtp-Source: AGHT+IHqPrXkwwUDap0ca9SLlYtO97n9ztGxu1x6wVw4xsLvIfW4MVbyJ3ujywmUi0PiOUwK6qabcxMBYdhHwV+o39I=
X-Received: by 2002:a17:907:3f23:b0:b72:b6ae:266 with SMTP id
 a640c23a62f3a-b7331970a45mr560470666b.10.1762998544691; Wed, 12 Nov 2025
 17:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com> <20251112103804.4a43591a@gandalf.local.home>
In-Reply-To: <20251112103804.4a43591a@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 13 Nov 2025 09:48:52 +0800
X-Gm-Features: AWmQ_bmfsBpIDeSjzAUhCej7Cw2PwEc1ZTHTzRB4GUxjSqLSY-cAbHgULGIT7O4
Message-ID: <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:37=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 12 Nov 2025 17:00:10 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > I have a question regarding the behavior of the funcgraph-args option.
> >
> > Currently, when the funcgraph-args flag is set, the function arguments
> > are saved.
> > However, when the flag is cleared, the trace output still displays the =
function
> > arguments unconditionally.
>
> Yes. The flag affects the behavior of the recording and not the displayin=
g
> of the arguments. There's no reason *not* to show them if they have alrea=
dy
> been recorded. Recording the arguments causes a noticeable overhead which
> is why it is optional.

Thank you for the clarification.

I noticed that when funcgraph-args is enabled, it registers
trace_graph_entry_args
to replace trace_graph_entry. The only difference is whether a valid
fregs pointer
is passed.

To reduce overhead, I propose consolidating the two entry functions. We cou=
ld
maintain only trace_graph_entry and pass the fregs parameter to graph_entry=
.
Within __graph_entry, we can then conditionally record arguments based on
'TRACE_GRAPH_ARGS && !!fregs'.

Additionally, I've confirmed that trace_graph_entry is exclusively used by =
the
function_graph tracer. Other tracers like irqsoff and wakeup directly call
__trace_graph_entry with a NULL fregs pointer. Therefore, this consolidatio=
n
would not impact those tracers.

What are your thoughts on this approach?

Thanks,
Donglin


>
> >
> > I expected that the flag would control both saving and displaying the a=
rguments.
> > But it seems that the current design only controls the saving. This
> > behavior seems
> > inconsistent.
>
> Not at all. The option is only for the recording. Otherwise, one might
> expect than they could do the recording and then after the fact enable
> "func-args" and expect to see them. That would be more inconsistent.
>
> >
> > I think we should add a check for the flag in the display part,
> > specifically before
> > calling print_function_args, to ensure that the arguments are only
> > displayed when
> > the flag is set.
> >
> > What are your thoughts?
>
> Big nope!
>
> The retaddr is different, as the information is somewhat redundant to the
> call chain and may cause more noise then needed.
>
> -- Steve
