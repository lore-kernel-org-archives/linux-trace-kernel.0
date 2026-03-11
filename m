Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1FA3DEFF2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230191; cv=pass; b=JLyVIexirUzoD4himeKNr0BCAaJhoXo+MIlBVpE43pC9/L5iqfVoRosWftCMbVVO45bPJMdr284Xi//OY2iAZvIFe/TFwtI85ABuM0tqbYsVPZ/Ler7z3l03bdpeZFbxm6efCpjJuGvjzeSyWdSYz23TPYsoA594Twhi81bb8Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230191; c=relaxed/simple;
	bh=23USlkopLdPBgRnbZ2H21Zz/UvYCy1dETih/pIItJz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFz3NElkTwu+lI+Fr4wqbKzr8ai4CjrpdESH52kpD/+IZGgvcmEL1AKCx+h45+z82lSschZKHSkGTRoNaMx3jjF1apSLAmmcVVOpUSaf0RLUwcAc4te34HSjiSZAR7WQeqXURZ8K4XrhShp6M/TJTbYJzJFpvHTrmIbMHqtCdT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVXCL6u2; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVXCL6u2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79907171da2so28224037b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 04:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773230189; cv=none;
        d=google.com; s=arc-20240605;
        b=gv6F1PUlnwKsV+HbFX4UOyIVhJ1ZWIav6GUlzEvYktwwNXgsmlAWVo5jPhxaYOpysy
         e+4F8MDT0fIt3wp/gg33OW55Ip0KvsSRusYbnFCGovJ0KOcYsiuSxRhi5BgXgQYfIBlZ
         6+No17nCOQ87FToERX/X1VLbQ0UY7mkVvtKd059KCT3AqdOZQMy6f6WzLKCZ7gx36lCp
         gkg0+eOU+6YPRYA0rvV5jvS2bgrWSDQL3wl+x7NKuz+tvND522XZPX2WqsoBwG2ofwL3
         zUUZhnZTgl56boRsSKguD6mPBJ7QXG+90B6uiOK2MXl7G60DmDMt7sS42Uat6QWltYWB
         kKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=23USlkopLdPBgRnbZ2H21Zz/UvYCy1dETih/pIItJz8=;
        fh=ZelkgANxVt5DuuFhSGQzIQL4KRENr2fowC3VC4HAjGM=;
        b=cI9tz/NPbQysTPvoBKxc145DpGDFi5hHcCSm+nz9mJ/gNXA1PIevX4mu0WBJAQc7Vg
         nUuuEbf02m+Uii+32xoDnMm8skXgq/5mhTm4m6QNFxvq706AQAdyna5Weia1Oy+LlVGj
         kd/uGYgiXsvfKlabkAT8f1LitfMev+dNrzmI3LD+7YhKSWsIkFbk/j9e8iYMfUJRqqR6
         M8X9uQEXWxhrZiMwV7n0nwrQU/TjXSErqq1GOeZicj+81wIgyxcdjsH9YLeBkD4xrjNk
         As/YQUx2fAUlTF+6MrT0DCirhqgnbHWJWl4bFrOQCipMG3pyWgH1GQzPRbWRmvaZ5Qj5
         PIzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230189; x=1773834989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23USlkopLdPBgRnbZ2H21Zz/UvYCy1dETih/pIItJz8=;
        b=bVXCL6u2V3USi2jyzpnd6K1/hHj3+ccEWKXFg3JCQ2QFKb2A/TVFZBDJbI/rBktf8B
         CPjib05M0B8NfntSv1K/5G5XDnKicrQSWaKaxQDOTJ76Z4DQeGn0AUtXnMp85Y3h9omw
         M7ukmVLx1LHHQCJ1lvCNe8mACU/gMUOJP9JoZ1QzoNQSLqMPlecbKoLceg/YrSC5cKk0
         gJVZsLFNjq6XYieqDG4PpsCzJpAHfwG5WhOY6/ZJMwH5/gBLF6luK8AI4e8QEorua5OE
         OVujKY2YNnizEjjVMn5CS7X6dW/yMPYV4HJL3QvA+d3nhvoHBrL/RoZ0eG9kSCjDI5vj
         /n5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230189; x=1773834989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=23USlkopLdPBgRnbZ2H21Zz/UvYCy1dETih/pIItJz8=;
        b=PF19QaL/iSYrm+yedpsRZkUAG8l77OwYfR/iivjvxB9+Ne5R8u5sLtvUYpr9hI/Fq7
         DEzWuu0o0Bh5DsaVs0bY6j8nNHSg6kP/DZJygTZp+lhxjU7pXHbxSD346anJ9FEx0pDM
         oMM9iRtYKEs800XnsMsCngkCgbnXqZ5YoyFpH4Xc1cDOMBzaLsbVdvIiG4c9DdYJqnb6
         IKZKP8vZN2hH8Kc2UyEcf3skVmtTZO8iwke9JsYIT1RabLW7rmpza7OG76fGIF14VAnV
         CLv/T6/9nsVUvZeB8YKIzSvZLU1VFFnB5wrQnBbq5afw/Nm8hbCn9WsFl9WKgCjZ6kUO
         J2+A==
X-Forwarded-Encrypted: i=1; AJvYcCWITQy2kEiyDT4phXXOmU00xNX3lmcuX6RCK7xZdL1tJPqifWYAUWlbnjD+oMBWmTZuTadnLyRNBK6bC99cd8/Lnng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQhza3f6pdBBTvS1ltN2nKaRNDOxy0YtG2dvXo/w4e34iX5w3
	Megucgd/47TKLZzzXf3Irf2/6gQPbU4YNiHEuuIH8jCyxj+gVOn0BdupspjTwxCFWwyuxWAUgqb
	aiFpzKdzvd6HSD1dCbu1YlL47vzNU3GM=
X-Gm-Gg: ATEYQzxiw1AWPQ+rB10y4XvJm7otSWoNjoSijStQtJyyCs41zUEcdS8OLt6aKU3mHdo
	w34G+o/mUimLIugOvDE1jQFwpoxDwVhRgA8u9xY/iRWkRWwsQn3Inymn9CHr/9HiitVpR5whqha
	7WwDoeby8TkGybf4DX1gmCop8p8IM+nsiimHAoRox0xEAOPspY/0vdwmiOjE7hoL/p+iYy/l5UR
	u/hnDYLXjCqF6ncZCVdelYHIeCkjXu/eYMLJZiKu8zABPruvTUxVAqF+i8pr9TutGY/G8B7K76q
	vqJrOCOT
X-Received: by 2002:a05:690c:dc7:b0:796:4b03:73bd with SMTP id
 00721157ae682-79917f89928mr19965747b3.31.1773230189493; Wed, 11 Mar 2026
 04:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311115250.78488-1-laoar.shao@gmail.com> <20260311115426.GN606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260311115426.GN606826@noisy.programming.kicks-ass.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Mar 2026 19:55:53 +0800
X-Gm-Features: AaiRm50AUyvIvga5Gd4wDBbTFsGtvXVaPdlKK1DIMyB5fzRseiv7shqdXv8fmW4
Message-ID: <CALOAHbAOqODMGnwqwvHsvystrk=0kEzLiNNdYSeGLZRgWtTZbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, david.laight.linux@gmail.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 7:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Mar 11, 2026 at 07:52:47PM +0800, Yafang Shao wrote:
> > Recently, we resolved a latency spike issue caused by concurrently runn=
ing
> > bpftrace processes. The root cause was high contention on the ftrace_lo=
ck
> > due to optimistic spinning. We can optimize this by disabling optimisti=
c
> > spinning for ftrace_lock.
> >
> > While semaphores may present similar challenges, I'm not currently awar=
e of
> > specific instances that exhibit this exact issue. Should we encounter
> > problematic semaphores in production workloads, we can address them at =
that
> > time.
> >
> > PATCH #1: introduce slow_mutex_[un]lock to disable optimistic spinning
> > PATCH #2: add variant for rtmutex
> > PATCH #3: disable optimistic spinning for ftrace_lock
> >
>
> So I really utterly hate this.

Do you have any other suggestions for optimizing this?

--=20
Regards
Yafang
