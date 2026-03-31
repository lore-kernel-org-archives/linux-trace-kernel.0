Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD01421EE4;
	Tue, 31 Mar 2026 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973548; cv=none; b=fhABDnNZdvGMwVZKlBiFYF/HeFVwq0n8w0CApKsatBx2vvR4MsGctgZmlT1q1qE08bKQWzQ7DGpmluaEX/eyGAs903Ezx3LS/aEmgdtQJ/NTT1ox2I79NMKtp3xT6TXnGdjydHiLYFhSX7ZXkRMZDoxuq0TuG+ri/coP9vlQUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973548; c=relaxed/simple;
	bh=pQLuqPapV8QsQ/YEglNRNOp8+22fgBzZv9DeDuvUDhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxM/vFSZorWLYUCIbnNMylGxhnifWz36E/nln0PSoQBZnGBJNGCfjJKa8qaE3xxofM9xbrdQ9PnbI9Zou8EPbsiOvN72GuIsHaNamjwiMr+oMhk4+qdThbM9GAUSzoDMHMbouuRDh+18k5+GgrSmSIMgjurTi60BJHjIXyvJ4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id DA9751602DC;
	Tue, 31 Mar 2026 16:12:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 250472002B;
	Tue, 31 Mar 2026 16:12:18 +0000 (UTC)
Date: Tue, 31 Mar 2026 12:13:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: always provide a prototype for
 tracing_alloc_snapshot()
Message-ID: <20260331121316.40da8cfe@gandalf.local.home>
In-Reply-To: <20260331182036.e62143d5a9a59776d8cf7ae2@kernel.org>
References: <20260331082001.31345-1-bartosz.golaszewski@oss.qualcomm.com>
	<20260331182036.e62143d5a9a59776d8cf7ae2@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: zmhckaq8kkrtba9gnsbmy4pus78md9cw
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 250472002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XShK8goG+xyIvS4wTltEkzXGcS2umLL8=
X-HE-Tag: 1774973538-849721
X-HE-Meta: U2FsdGVkX18hJGzx8wxn4MOhM7FJM33n9BOY2rw+Ycfhsy7O8BmGgpz/rw8fzXIHpMxlROZITmNKCmzLU/66M9P4U4HsyFC8rPEs162PVS6mzWJczeRhEwwtNgpjrgLK5Tw6OHRTl14E/FPCOmUE4nM4UttfYRy32mStiBfnxivCGDLxX2Zknk3R6TZuYSj03yCz9Hz/pWjF7MrfCRwfmF97O7TA/am1uRrQYx6vAECwA4iDagjQuDCTl6Picx8U+m+GuXtLfP+vOEbCRrHlCjBM1JHUVnNV99GCFxi4Gn4x1WAbvnJ6uxSmLvBHpCbfsukSdZ+a95cCZO9Ml1uvFVvqJC1/dm5/O5pCAmDA51HIvzZX9k/DFj7G5pBnmo/0Al/rRCohMpRiKCcPtdJvbh5Eb/s6hYJt0tKWh1th1ppqZ8m7djktlujjMMPvUEokD0znSTPoN0M=

On Tue, 31 Mar 2026 18:20:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 31 Mar 2026 10:20:01 +0200
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> wrote:
>=20
> > The tracing_alloc_snapshot() symbol is always exported even with
> > !CONFIG_TRACER_SNAPSHOT so the prototype too must be always visible or
> > we'll see the following warning:
> >=20
> > kernel/trace/trace.c:820:5: warning: no previous prototype for =E2=80=
=98tracing_alloc_snapshot=E2=80=99 [-Wmissing-prototypes]
> >   820 | int tracing_alloc_snapshot(void)
> >       |     ^~~~~~~~~~~~~~~~~~~~~~
> >=20
> > Fixes: bade44fe5462 ("tracing: Move snapshot code out of trace.c and in=
to trace_snapshot.c")
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m> =20
>=20
> Good catch!
>=20
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

But is the wrong fix. I already fixed it properly:

  https://patch.msgid.link/20260328101946.2c4ef4a5@robin

It's still in the testing phase but will be going to linux-next this week.

-- Steve
