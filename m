Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042747;
	b=fRFwEojT7BitmRa/LUIKHigU78M2cg9lfGWG51xyA0ry19bJCPHN+R7+Uv0XhHPpytj3
	 KHb0WOnOen9/2tNfr0oq0Zv4atOXajf2VZfQaPnyP2d8kTjlDQfaLlNjinXR1RJYafWMf
	 rz8Uh5io+R07tF7F/hoCrvOpDNlEIOGTHczayT3QEBggW57zXkbxcQjbJqwFx5d0QzfQZ
	 CBEPh2D6p+7tPqa/+lphz7DEO6MySxabWiC22h4OnM0gY97CYDGWwjhcT0x9+WnfH7sLi
	 YHOZtWzafUq0q0h4PL7jP+zm4lHyogRuHQulMW3BqPBV+1cZIQmaB+9an8Hnux1srtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042747;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=YeW/vsuTURatWo8vjPgKFuIFk5Oa69ycBygNEDu8EaQ=;
	b=HkXPga8rUJ4UrKP7HOFL6gmT6/u0ydzTL3wAc+0B0tK3CmISH/UukyIa9OUZDwVrL/jM
	 RTlAe+fwuHMjcLOHSPFBSBgczzMSW+OncYHxjbbPAYe6DrIhin9yVgWMwAtdj4fS9Lj92
	 JsGYXWJgIw65k5fBtxddTgA4plYKKL7w+1OgaEAz5jRhDVwcqHdIMc8b/ocEYbxJI9hXl
	 c2Z355H9kAX+2L0PEcpPFqmZ33XMmXW4qoe1rEe1MM65B5BBYPLAwS+xP8zWLK9zxuUpy
	 Yuy3BTXhmThw1PN5n+oL9iVz9KOb5mdcjza/b47y1VMJy2lg1joNTsiMh7Q0eOget0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hJIVYZtl;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B1606A31E;
	Mon, 26 Oct 2026 19:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 954B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=hJIVYZtl
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.58])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60E5220B7166;
	Mon, 26 Oct 2026 12:25:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60E5220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793042736;
	bh=YeW/vsuTURatWo8vjPgKFuIFk5Oa69ycBygNEDu8EaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJIVYZtlPTmPI5cyNa7YnpdtY68LGbJYo+ASmCKVcm1MZxUN0pDAXIz2UYC3R2wNX
	 eltpn2wFwj3M0ZvBMZt3/IRpTnCzKxaYamBnD0p1bNQDrvsKEJfxEDYIHhTthzPJ4o
	 kBVR526gFDxi2Fbu52VjNCOQ1LeU1PSxrX9ezdNw=
Date: Mon, 26 Oct 2026 19:25:41 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] tracing: guard trace_event_get_offsets() against an
 empty fields list
Message-ID: <20261026192541.GA65-beaub@linux.microsoft.com>
References: <6ad1f2ca.6048f038.32d739.a530@mx.google.com>
 <20261016102249.090d33af@gandalf.local.home>
 <20261016105100.7a64aa51@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016105100.7a64aa51@gandalf.local.home>

On Fri, Oct 16, 2026 at 10:51:00AM -0400, Steven Rostedt wrote:
> On Fri, 16 Oct 2026 10:22:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 16 Oct 2026 17:47:51 +0800
> > Haoran Wang <haoranwangsec@gmail.com> wrote:
> > 
> > > From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> > > From: Haoran Wang <haoranwangsec@gmail.com>
> > > Date: Fri, 16 Oct 2026 16:30:00 +0800
> > > Subject: [PATCH] tracing: guard trace_event_get_offsets() against an empty fields list
> > > 
> > > trace_event_get_offsets() dereferences the first entry of the fields list
> > > returned by trace_get_fields() via list_first_entry().  list_first_entry()
> > > then returns the list head itself, and tail->offset + tail->size reads past
> > > it.  The corrupted result is used as the BPF context-size bound in
> > > __perf_event_set_bpf_prog():
> > > 
> > >     int off = trace_event_get_offsets(event->tp_event);
> > >     if (prog->aux->max_ctx_offset > off)
> > >             return -EACCES;
> > > 
> > > so a context-reading BPF program that ought to be rejected can instead be
> > > attached to a zero-field tracepoint (which still carries
> > > TRACE_EVENT_FL_TRACEPOINT) and read adjacent kernel memory when the
> > > tracepoint fires, bypassing the verifier's context-size confinement.
> > > 
> > > This is reachable through user_events: a user can register an event with no
> > > fields (e.g. `echo u:my_event > dynamic_events`), which leaves user->fields
> > > empty while the event remains a BPF-attachable tracepoint,
> > > trace_get_fields() then routes through user_event_get_fields() to that
> > > empty list. The corrupted
> > > result after list_first_entry is then used as the BPF context-size bound in
> > > __perf_event_set_bpf_prog(), which lets context-reading BPF programs attach
> > > to a zero-field tracepoint when they should be rejected with -EACCES.
> > >   
> > 
> > Hmm, so user events can have empty events. :-/
> 
> I meant "empty fields".
> 
> > 
> > Beau, Is that a thing?
> 

There have been events in the past that are used simply to signal
something has happened and have no payload/fields. That is a valid
scenario from previous discussions with folks on our side, yes.

Thanks,
-Beau

> -- Steve
