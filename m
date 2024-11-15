Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9C1CEEB8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683208; cv=none; b=dyFEs3Yg27AJqNULG4dUZnkWFzB5K9Wo/77URAh4CINtNzrWygn2w8p8lW5D7GL/64uDxSlBvA9Obd6Ur6rk1qgSpau2OuFY9fq6Xu7G2cc3+DdiusZRl2BbCSfc4zC363/eOoEwqjAi72x3NHZMMukN++c+x1ENuPIBIWB7by4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683208; c=relaxed/simple;
	bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEcDrxSe4Y/4++IgtQeEIl4xq1/WDtypd2Ju7R8oxqHSmbnqJ91UZpAnHpWeY0QJgOIdqsZtS/LoIxkf8yLBt04CPb6CDXRcbRgoN3CWSOP9c5ESBFG3D2KmfzbSbkkspwm2856kjsqRWMsDQBgdL5PbTxXUAWUqEhYeK5zGVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ3BH0cd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ3BH0cd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720d5ada03cso806485b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731683207; x=1732288007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
        b=bZ3BH0cdpGqjLW/Zy1Su3xOAXFJG64gGA19W1qzxzuZimGCtfPiSnIQF/RA9wzk2sO
         xmC9DoW9tsNRxJHENh336HU1fVe6aYKch+Kfgy8vArCS8JLyohnGxDFfEuChqlJMO1uc
         ye6wzVcV5WPvpCdHWZVpbR4/+VY2MYU1ktck7ot1B4v8PvUh+19FMiNQmpZH3Kp+gpjg
         rWeQGduyfOZZCF5f715Q26J/hYLvC5LtymhxzJSRqiVFwcf80femPdv5afKPDxh1EGGn
         91JUfZHLrCu0i6rgPalNVsbnuqQYnQmNwlWtQvlUkxT8GEw4z697c/ublA3aZ74RD+M3
         a92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683207; x=1732288007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
        b=gDfLZK5tnRbhvirJpWqpkgbwM7b7U79ZuP00nx/+f6vcn3y+lFK4pHJBw5aSsnJq9h
         A6QCtiWRFJ7HUrXjzlScwdB4GF1rXDbzMtOZs1aBwevTE6DEhR4dJI1jTbQ0RG9dIxSe
         rJmLq/eXGvlSUKpYYXJ5xzVc4TBMRwPE2PjYbwUazHU7Xo1j1fVO5sVSIFGTRoKAxc+7
         sxtDi/YRFLrHnY77ebzQdwtBjU2g0QG732UjBMd/gqAL3ZJADVem6g6MDENqnp3UUjeM
         yLiL04O8qRX5yREQDzFkVL+X8Ws0QVhQqPo1nw+xL0EQmttwehYvzzTzbh8YBUeoaoby
         yWdw==
X-Forwarded-Encrypted: i=1; AJvYcCXLGMKi9KFWn7M9CZHtWxIb+vBmX3mUuydouq5h1cGvy3ci/KfSn7I4dzlGP0GTpR9JwSn5uoiCt/X5P6Xcz96oz5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfmfqnxQytwc1GiTSdMABFWSF/TzzCECWcY4a0Di9XeMJdKSjr
	lxgYYi7F7ykmDDH4oCtA2oOJkA7MT/dciYl4z6sHzT1hb9VV+VpxKhAZo/L11Nwdoi/Tv33gRxv
	cWs5Ox0P+IU5UleEwi4n6Pl1BTly3wRqhdgC6
X-Google-Smtp-Source: AGHT+IEUgPtK0zm9JlHmILKAZrzqF/XanePDYjHMFgQeF9qQLS2OeBR9J+dbTbFzei2pMXsVmlaqR4ic11xSOoquQpQ=
X-Received: by 2002:a17:90b:3b46:b0:2e2:ca4d:9164 with SMTP id
 98e67ed59e1d1-2ea154f71e0mr4241757a91.12.1731683206476; Fri, 15 Nov 2024
 07:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com> <CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
 <20241115082737.5f23e491@gandalf.local.home>
In-Reply-To: <20241115082737.5f23e491@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Fri, 15 Nov 2024 16:06:09 +0100
Message-ID: <CANpmjNM_94fmQ025diHd9_vKtRxtDbSYaOpfBbshNQYEPQmHZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 14:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Nov 2024 13:00:00 +0100
> Marco Elver <elver@google.com> wrote:
>
> > Steven, unless there are any further objections, would you be able to
> > take this through the tracing tree?
> >
> > Many thanks!
>
> This isn't my file. Trace events usually belong to the subsystems that
> use them. As this adds an event to kernel/sys.c which doesn't really have
> an owner, then I would ask Andrew Morton to take it.

Got it.

Andrew, can you pick this up?

Thanks,
-- Marco
