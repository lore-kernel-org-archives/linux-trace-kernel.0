Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EE1D5147;
	Thu, 29 Jan 2026 00:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769646914; cv=none; b=gOdbwVmYT447Hsj8qJbQkx19/WMc5A99iR83AA7Z3HfAW/DwE2C7as1re75y8KyLgVEYoth1P0aWaQeKvcWG7GMw59ait2nNGgOIEpBnqDEZUSBDQPS5MmxHiIL9dNQlxiZwUMi2Rw2YzpYaJZLZ89esg+SP+PDzBLrooSIFqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769646914; c=relaxed/simple;
	bh=qq+oA5AHnndX9GCK+w43dKQmGLdT9h8BF5gnKPc2xHo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fdkEF/2GjjxoAPgxSl4R/pYCuW630gQXBnJxIWqbs+kk+d2w4fRK3Ti3JdcpaWMQ2VzAbS5icycOd2N1hmsRRyyzj4KUmyYGLytlco4ycC+RoMGVWytDnEVt3j6kSRG2MXO/P2bGUGbwUxRnyvk/jirw3M4Hsv6n1RxrAcP8LFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpZ85zI0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpZ85zI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD925C4CEF1;
	Thu, 29 Jan 2026 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769646913;
	bh=qq+oA5AHnndX9GCK+w43dKQmGLdT9h8BF5gnKPc2xHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WpZ85zI0J+mPkfQp5EDeRjORjeNqrXZQ0y1At/OJfbDHqWqKzutM4mHeFRLobnREi
	 353a6vSt0u4uNoB3UHP36Axf0YmiAR+F77Cot9BTSsqcskFisCOCJsdT0x2/KrktcO
	 +0Dlm4BRADqGk+Ag1rlzzyxPp80IBbioyDgPoQTmHLWOFLOpTGX7sCC3gP4HKqQtKX
	 jSiqBwhnWxlXelSJiLRS+cRrvgrV/ATJi96KYhC/0YdvFrje4kOh4fyOjvHrF+86WZ
	 D/o/QO4d0wuVewt32B0c+makvEYCOtu9m9EVP+IRwxl3d8vKuwQX7ta2M2DTUSpYvW
	 p509cVCv6ujtA==
Date: Thu, 29 Jan 2026 09:35:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Seokwoo Chung <seokwoo.chung130@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 corbet@lwn.net, shuah@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 v5 1/3] docs: tracing/fprobe: Document list filters
 and :entry/:exit
Message-Id: <20260129093508.5064b3782a40811cbcd8cb7b@kernel.org>
In-Reply-To: <wqpijkdwziafpuci6js5mtfzro46bre4z7une547crcdzrlm67@kd4fgea5m6ov>
References: <20260118011815.56516-1-seokwoo.chung130@gmail.com>
	<20260118011815.56516-2-seokwoo.chung130@gmail.com>
	<20260120155340.2dac7fab@gandalf.local.home>
	<wqpijkdwziafpuci6js5mtfzro46bre4z7une547crcdzrlm67@kd4fgea5m6ov>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Sun, 25 Jan 2026 15:23:17 -0500
Seokwoo Chung <seokwoo.chung130@gmail.com> wrote:

> On Tue, Jan 20, 2026 at 03:53:40PM -0500, Steven Rostedt wrote:
> > On Sat, 17 Jan 2026 20:18:13 -0500
> > "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com> wrote:
> > 
> > > Update fprobe event documentation to describe comma-separated symbol lists,
> > > exclusions, and explicit suffixes.
> > 
> > Usually, the documentation updates comes *after* the changes.
> > 
> > -- Steve
> > 
> Thanks for the comment. As you noticed, I sent another patch since I forgot to
> put log. That said, please let me know if you want me to continue on this
> series. My apologies on the ordering. I noted after Masami mentioned but I
> misordered when sending. Thank you.

Sorry for replying so late,
Can you fix the kernel test robot's error? I think it is almost done.

Thank you,

> 
> Best regards,
> Ryan Chung
> > > 
> > > Signed-off-by: Seokwoo Chung (Ryan) <seokwoo.chung130@gmail.com>
> > > ---
> > >  Documentation/trace/fprobetrace.rst | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
> > > index b4c2ca3d02c1..bbcfd57f0005 100644
> > > --- a/Documentation/trace/fprobetrace.rst
> > > +++ b/Documentation/trace/fprobetrace.rst
> > > @@ -25,14 +25,18 @@ Synopsis of fprobe-events
> > >  -------------------------
> > >  ::
> > >  
> > > -  f[:[GRP1/][EVENT1]] SYM [FETCHARGS]                       : Probe on function entry
> > > -  f[MAXACTIVE][:[GRP1/][EVENT1]] SYM%return [FETCHARGS]     : Probe on function exit
> > > +  f[:[GRP1/][EVENT1]] SYM[%return] [FETCHARGS]		    : Single function
> > > +  f[:[GRP1/][EVENT1]] SYM[,[!]SYM[,...]][:entry|:exit] [FETCHARGS] :Multiple
> > > +  function
> > >    t[:[GRP2/][EVENT2]] TRACEPOINT [FETCHARGS]                : Probe on tracepoint
> > >  
> > >   GRP1           : Group name for fprobe. If omitted, use "fprobes" for it.
> > >   GRP2           : Group name for tprobe. If omitted, use "tracepoints" for it.
> > >   EVENT1         : Event name for fprobe. If omitted, the event name is
> > > -                  "SYM__entry" or "SYM__exit".
> > > +		  - For a single literal symbol, the event name is
> > > +		    "SYM__entry" or "SYM__exit".
> > > +		  - For a *list or any wildcard*, an explicit [GRP1/][EVENT1] is
> > > +		    required; otherwise the parser rejects it.
> > >   EVENT2         : Event name for tprobe. If omitted, the event name is
> > >                    the same as "TRACEPOINT", but if the "TRACEPOINT" starts
> > >                    with a digit character, "_TRACEPOINT" is used.
> > > @@ -40,6 +44,13 @@ Synopsis of fprobe-events
> > >                    can be probed simultaneously, or 0 for the default value
> > >                    as defined in Documentation/trace/fprobe.rst
> > >  
> > > + SYM		: Function name or comma-separated list of symbols.
> > > +		  - SYM prefixed with "!" are exclusions.
> > > +		  - ":entry" suffix means it probes entry of given symbols
> > > +		    (default)
> > > +		  - ":exit" suffix means it probes exit of given symbols.
> > > +		  - "%return" suffix means it probes exit of SYM (single
> > > +		    symbol).
> > >   FETCHARGS      : Arguments. Each probe can have up to 128 args.
> > >    ARG           : Fetch "ARG" function argument using BTF (only for function
> > >                    entry or tracepoint.) (\*1)
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
