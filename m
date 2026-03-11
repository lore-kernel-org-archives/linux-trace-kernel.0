Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0A2E54A2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255951; cv=none; b=plpCVAJ9etsuhZthlrOB+AafkCoUQiOYV/TvXk4KDZ9xnXpekVMCiJpXr3zahJ6vKu2Qn50kcDx1nE0x7lh8PBsM/NjD+L7N21HmRJjPmq2SDZ9Kq60pSrUYEuhQgAoOxnffXsw3reHLOJu3s3/v4nEqvEJ8QkMqIYWPfsBVl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255951; c=relaxed/simple;
	bh=Wcqdehh141n/4jSMvJy7vOovoaJnhCiw6gtuN3sUVJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZsdMnHS2cy0UIh+moGl1YE7Cfth+CwGZ5eiYBquq2l8b+DodjnelmiLIpMtC/ZOoFMGfoU8NFomgVqZPAjntpFtLrUFYlivbDzm+h/eXKG0mIIGtZLbzr3XaDSE49QWTSffEWMXdBXRBXXXAnjV41l+1sl3al5u2ADbYkQFl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMjjFfKp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMjjFfKp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c6fc2910so169859f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 12:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773255949; x=1773860749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tPGB/NoSev18959WrnG45L3aRxkho8LPMhdN0AV+F8=;
        b=hMjjFfKpOjXBoldqA1lRTtqtzhg78pUpDhEs9XjFY+aFc1LQ1x55Dj7+d04JrGYbzF
         5t518ToL8WU/RKAU4YpJU0H/mhiBGruba3uJawulN9ESOFfTd6h7em2a9F8brXZQltSx
         kxDYmXGOy2FImqy9YmsIqt/025TiF/d9UIZLXEUgBv8ENNGY1e8F6K4pOSdjj3eZVcSl
         hT5a5VkmVSoqK+P4cYLM6HsVffy5RSkioKGG5pMjl32BfWhs/5TK/MqtaSXMdxaNxNb/
         Kh0D8475/bh8vEuF8psUIjMYj55a9zdh2Q2Jft+vA9r+IFEkBmVvJU07zx2FsGCEqd4A
         GQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255949; x=1773860749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4tPGB/NoSev18959WrnG45L3aRxkho8LPMhdN0AV+F8=;
        b=QW1JoBVzs8ErTkLQGyHs2ngF75Wb41J6o7VyytGHF7XUbbKs+ZD0np8VYqCD31rJ+I
         pz5W1Ib3fXU5wHtxxISQmRw6fQacNhJZB9rOLLQTSR6cCM1xTDR/iOqbt8w7bcQYOtqm
         D1rn5my7Neth812By9EMjiW1gyfxjt+yuhLuudpUrusWI4AbbsSXLsX9s4yrsB/d42WE
         wYtNxn2viK+lVgUS1t6e8NLml+E5LuvrAqES7zp055yHpgG8FX4/my9CwyHrlFsg2XzO
         2JXPtv1Y1IoQvUSYqA90Ywm2lCW5Hsp6tMqHSPMC4vywPtsBoul+6zPIx+ssiVXFueSr
         I/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvaJ7xK8hxfmyhQtUr5lM+7HmysDKAaMipna7TLPsp3AKURnNHTStrNdumIsW5e55VHa++Q/x/OiFErGuZppVL0Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwd1hE3Y7yso62OOMLwHpBGOtfo4IecZ77naUWOrcH7zDow0pu
	5t3yRmaz15JCotleoSr8cKQNCymjXpVePZgRVQVmwbfU7nbUaKCTc7aG
X-Gm-Gg: ATEYQzwcWQNVy6iRTuErFc6VeWasJWVsw2GgeDfScnKbCJIJ/sM+VKC7Td41oNyk2wE
	8S/pNmQUCuFqSHCmKpWLI2PKoLidLfMtXJYnFl16Lb00F/PJ8c/zsEzXKzYPfxM4GjnUa8CobJG
	jDc9jj4BUsSTQ7a9UqnPNX4XdWBJpsrYPUNg9urePxLB26SwxiGgw+EE3WfeVBryQn6IE0qM1HI
	xyO3daMzqsuJYt0uZI9jHhdaV4QIvuoc5u/kTlDlq47UnXXpr0nP7oKV0/2UbMpM9MW058iI31t
	W0bfOrLmekp+w5yTPL7rIg7V2qy97zYL7tfXkshLmQN16Vq11lZU0aayIZuYjj9hX/GOVMxyqEm
	WSiqfhkI3/VjX3Joq5mT+jErda4S/LX3Ktw1Vo9Hz+msIJ0FT1guaRyj2q6vOIJVfoUCODa6VfC
	hxYItRVddBEpR9syNrx8SH/tusH2ijB6+Njoos44A6RTCjdKQH9jxqwHNUYrqa2Ivhp3D96Oizk
	6o=
X-Received: by 2002:a05:6000:310b:b0:439:bc2b:cb57 with SMTP id ffacd0b85a97d-439f81f168fmr6921963f8f.6.1773255948650;
        Wed, 11 Mar 2026 12:05:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b287dsm1448117f8f.17.2026.03.11.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:05:48 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:05:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-ID: <20260311190546.1340bcc9@pumpkin>
In-Reply-To: <20260311130743.63c997ec@gandalf.local.home>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
	<20260311115426.GN606826@noisy.programming.kicks-ass.net>
	<20260311125350.1d89341f@pumpkin>
	<CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
	<20260311130743.63c997ec@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 13:07:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 11 Mar 2026 21:40:32 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>=20
> > > The code needs to drop the ftrace_lock across t_show.   =20
> >=20
> > It's unclear whether we can safely release ftrace_lock within t_show =
=E2=80=94
> > doing so would probably necessitate a major redesign of the current
> > implementation. =20
>=20
> The issue isn't t_show, it's the calls between t_start and t_next and
> subsequent t_next calls, which needs to keep a consistent state. t_show
> just happens to be called in between them.
>=20
> >  =20
> > >
> > > Although there is a bigger issue of why on earth the code is reading =
the
> > > list of filter functions at all - never mind all the time.   =20
> >=20
> > bpftrace reads the complete list of available functions into
> > userspace, then performs matching against the target function to
> > determine if it is traceable. =20
>=20
> Could it parse it in smaller bits? That is, the lock is held only during =
an
> individual read system call. If it reads the available_filter_functions
> file via smaller buffers, it would not hold the lock for as long.

But the expensive part is probably looking up the symbol name.
Shorter reads would hand the lock off to the other process, but overall
the lock would still be held for the same length of time.

How does the code work out where to start from for each read system call?
Couldn't you (effectively) do one symbol at a time the same way?

Another option would be to put a 'generation number' on the list of functio=
ns
(after all it doesn't change that often).
Then you can release the lock, generate the data, re-acquire the lock and
check the generation number hasn't changed.
If it hasn't changed you can carry on processing the list using the
same pointer.
If the generation number has changed terminate the read and worry about
locating the correct start position for the next read.

	David


>=20
> -- Steve
>=20

