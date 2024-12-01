Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A81D6DDC;
	Sun,  1 Dec 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733083450; cv=none; b=Xiod5gYz0EmRyOXBgfLv/VI8IWYtV6hJ7VxslIB08D+uF3RvEBOBSIVfSE4HDO/CKPhEJl+x1FDuaYt3fxB9upY6J9JfN+164znWqXABnbpnghy9OecGPtVPPyIEjOHnZ8pen07y3osmuC2CEi3DvVg8ZR9HWP6RD200R4ZddLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733083450; c=relaxed/simple;
	bh=GjrgLUXjD/FqFyg/kI22t4bPlYkN6sXX7Ui27n8R7rg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhIxgy1EZ15D8xw4yu8AytpdXNzWTFpMz2ms+bsXomG53WnieUvvo8tYhABath6+GP9njOSpd+tUjEp/xNGi1CuaERDtSzgAfhtzfrTNFxlxHbzEtLEOyjh8p765DeftR0QJyXlD9DOVK2l89KVzbKfbufcPtriMBzkCTUZfaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C1BC4CECF;
	Sun,  1 Dec 2024 20:04:08 +0000 (UTC)
Date: Sun, 1 Dec 2024 15:04:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Show timings of how long nop patching took
Message-ID: <20241201150406.17f10247@rorschach.local.home>
In-Reply-To: <6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
References: <20241017113105.1edfa943@gandalf.local.home>
	<6fb1e232-3bc3-4d5d-bff9-9f1a8c784782@csgroup.eu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Dec 2024 20:37:42 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Hi Steven,
>=20
> Le 17/10/2024 =C3=A0 17:31, Steven Rostedt a =C3=A9crit=C2=A0:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >=20
> > Since the beginning of ftrace, the code that did the patching had its
> > timings saved on how long it took to complete. But this information was
> > never exposed. It was used for debugging and exposing it was always
> > something that was on the TODO list. Now it's time to expose it. There's
> > even a file that is where it should go!
> >=20
> > Also include how long patching modules took as a separate value.
> >=20
> >   # cat /sys/kernel/tracing/dyn_ftrace_total_info
> >   57680 pages:231 groups: 9
> >   ftrace boot update time =3D 14024666 (ns)
> >   ftrace module total update time =3D 126070 (ns) =20
>=20
> What is this supposed to report / measure ?
>=20
> On powerpc I get:
>=20
> 25850 pages:14 groups: 3
> ftrace boot update time =3D 0 (ns)
> ftrace module total update time =3D 0 (ns)

Hmm, does powerpc support "trace_clock_local()" at early boot? I
probably can just switch from using "ftrace_now()" to using
ktime_get_real_ts64(). Hmm.

-- Steve
