Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4839DBCC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439378; cv=none; b=lrxBAneqkcPtoG8pzWxjnrKutwJAaUcZkXWu8yihAtRgE7vRxGp7rWV7pzpSYILgO0rk6BMCsEIhgVwkQkzmtZBGrDI3RtjU6fH413GWsWFM+DaWs9bHdqwX6Q6U74LPMOhOrvhG+SRSGxPbg+akRgHmAEw6vub7AAZJCQJBRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439378; c=relaxed/simple;
	bh=1pyvnAvu3vn/CmTfMaIbSe20FKdLPRlJ91/yYNEczZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2D4HG5wfq8J9ZhsHosPvH7Wpcdw7RTHaWNABguKyYe+8gZiRdGMAAd+tmDrY8ByGd4g0YaHBh/uThJrTid/vPUviB1VY2gefdpZvrAmQZqarvGS9uhRPw3jHh3AJvpqaaUb3PSs6wi/xKmkOPU5+uPXz4i+vnx9KtrCX+ssKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFBdknys; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFBdknys"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso26753545e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 02:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786439374; x=1787044174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yxq3Qyxawzz9rhrj4XvTea5uvOn2PHD3WDA0/U4VTpk=;
        b=BFBdknysZSoE1Hp2tSP1Lvr1sYnn1f1rEVfsRa5j8sMxZPCBkiEsA8XGqLBcGmoLz4
         kepf90sVBD80WlfLtmr5G5NRHMAXThI5Gq+4244ImlL3dVrZrbLVy8/nHgUAuDvTM9um
         V3ZoKJ4MdeDUN9FLrLqOwZMKrFqXpiJZP6FgNIk9kbEuynTZpX/O+owcUvzpF0YBen6f
         Jp08mvTVesfUcIGUmV+I7TtWlNc6WHdlNR7nc1MH6Sgwx+c6lZFO5AwnfMMgC/D/4kvS
         um3pd3HFh/uBF/W9Lyne4Kt0abRSOnHox+GsHJ3R3zuI2qi2moKxu2TfhO+qEemYUvg3
         ynuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439374; x=1787044174;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yxq3Qyxawzz9rhrj4XvTea5uvOn2PHD3WDA0/U4VTpk=;
        b=Nkk6jSkj23jRg43EPzeX8B1Zr5+Wx+xF0qhdags+42OoES4Tz6w/ggwul7NUJK0qog
         j2P8IocPPeYyd9DIzDzlxkIk6dF2Jr4NIczPOmV6OZ0bcOO3RY6L8afN65VJlgHxr/3z
         F6x0C/3GYfv48Kp+hejK6aMnWYyR0s7RRcLyrvqkeSXiDEMb+ECUT3GsT0fqm7k3+owO
         c4B0vsLJc/8Izv6xyHnqyEwE4YlEYh+IDxp1b+nVqHNOuGqzDljGbwwLS9+ec2J1Y2L5
         FNU1Tw3tW8tVTpjEsmvyhDkztEFs66LzxUvurt0HctUCYwElmfpDlKPchdjPNIyKpfx4
         o59g==
X-Forwarded-Encrypted: i=1; AHgh+RomoP5vVkRRVobJ1Xk7hX0Nche2wD2wTmhRiJ9aFoSF7sqPyKX0UAvh9rmb51J9pNsX0956QiPBsEWhh3cpzl0kKbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ltWnD1uj83awVX/EKolenziplOBJ54S2ChxoRB9j2/3YtMct
	EFAcyXUIxw6cRjVibknHs53w7m+K+uu+QOpoobkV3deM8/tTh0KHArIVOD2bM/6Aog==
X-Gm-Gg: AR+sD11yijn+U5i9VylpF745QMnqKDykqnbXdDTisChcNXv5sFhwk/vZ4fcsitNY+kJ
	AhooLC+lnTvVHkDJwmWgqcI0lfyo/MDrHO86v5Nxy28SaVujFuSlXdckaYTLB9zaxLlpaxNryEZ
	n2YoZQrVjuFY3V2giuBqQg+psJW7v3djQFxlQWelr74QbcNhSuipgwSWLXqHKYskbyKPPbXREWi
	YXAi2nBFIyCqEN6HcbifasFNq0iU/eDhdAJ6C8Up5Gw0eGjeIWeBEnqHSXAaFSThRxM9ZScNPTt
	cO+51CyFRBPCnM1dtdaE1ZPGilvaYlmsGyKMPKcBuwh2LHFVBIieTSy8Up+LK713tHl6dbOVOfA
	4GmrcZF5Sa7CwsPI1jU/vlt/w1DEQPjXxBOJ4gAD4401DEW6IbDZc/bzcISs1kldiviLiFQbwyx
	RIFljp1MJh2IdwN/iKB0kFe2Wa6NyWGBtJm9aORY1JwwYLqaO9ZBs0m7Brlp7rsiCMvDs0n9gt6
	+ZGFfYbYSVMWZLHhbwYXhdGncKEU2Jr
X-Received: by 2002:a05:600c:35c4:b0:499:78b3:7b36 with SMTP id 5b1f17b1804b1-49978b37c8bmr34818975e9.11.1786439374135;
        Tue, 11 Aug 2026 02:09:34 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740a6f4esm48747265e9.2.2026.08.11.02.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:09:30 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:09:27 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <anrmx86wMG0Jh-E1@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
 <20260804140333.797210-7-vdonnefort@google.com>
 <20260810184216.3484cfd6@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810184216.3484cfd6@robin>

On Mon, Aug 10, 2026 at 06:42:16PM -0400, Steven Rostedt wrote:
> Adding Sashiko review: https://sashiko.dev/#/patchset/20260804140333.797210-2-vdonnefort%40google.com
> 
> > --- Patch [6]: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file ---
> > commit b6a4c19257d91807c612baa19691b2d602bb0670
> > Author: Vincent Donnefort <vdonnefort@google.com>
> > 
> > tracing/remotes: Add dmesg tracefs file
> > 
> > When enabled, the dmesg tracefs file enables the redirection of all
> > events to dmesg. This is similar to tp_printk.
> > 
> > > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > > index 1fbe2f3f20e99..58a38f3d49024 100644
> > > --- a/kernel/trace/trace_remote.c
> > > +++ b/kernel/trace/trace_remote.c
> > 
> > > [ ... ]
> > 
> > > @@ -882,6 +908,87 @@ static const struct file_operations trace_fops = {
> > >  	.release	= trace_release,
> > >  };
> > >  
> > > +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> > > +{
> > > +	struct trace_remote_iterator *iter = smp_load_acquire(&remote->dmesg);
> > > +	unsigned int max_events = 1000;
> > > +
> > > +	if (!iter)
> > > +		return false;
> > > +
> > > +	trace_remote_iter_read_start(iter);
> > > +
> > > +	while (trace_remote_iter_read_event(iter)) {
> > > +		trace_seq_init(&iter->seq);
> > > +
> > > +		trace_remote_iter_print_event(iter);
> > > +		trace_seq_putc(&iter->seq, 0);
> > > +		if (!pr_info("%s", iter->seq.buffer))
> > 
> > If the remote trace event exceeds the PAGE_SIZE sequence buffer, does
> > trace_seq_putc() in trace_remote_do_dmesg() fail to append the null byte?
> > 
> > Since iter->seq.buffer might not be null-terminated in this case, could this
> > lead to an out-of-bounds read when pr_info() prints the string?
> 
> Yeah, we may want to have it be:
> 
> 		if (!pr_info("%s", seq_buf_str(&iter->seq))
> 
> Which will make sure the buffer is nul terminated.

ack, and same for trace_remote_panic_handler()

> 
> 
> > 
> > This isn't a bug introduced by this patch, but the same pattern appears
> > to exist in the pre-existing trace_remote_panic_handler() with pr_emerg().
> > 
> > If the kernel is built with CONFIG_PRINTK disabled, pr_info() evaluates to 0.
> > 
> > Will this cause the loop in trace_remote_do_dmesg() to break without calling
> > trace_remote_iter_move(), leaving the event unconsumed and permanently
> > stalling the workqueue?
> > 
> > > +			break;
> > > +
> > > +		trace_remote_iter_move(iter);
> > > +
> > > +		if (!(--max_events))
> > > +			break;
> > > +	}
> > > +
> > > +	trace_remote_iter_read_finished(iter);
> > > +
> > > +	return !max_events;
> > > +}
> > 
> > While reviewing this, I also noticed a pre-existing issue in trace_pipe_read()
> > when handling oversized events:
> > 
> > kernel/trace/trace_remote.c:trace_pipe_read() {
> >         ...
> >         if (trace_remote_iter_print_event(iter)) {
> >                 iter->seq.seq.len = prev_len;
> >                 break;
> >         }
> >         ...
> > }
> > 
> > This is a pre-existing issue, but if an oversized event causes
> > trace_remote_iter_print_event() to return -EOVERFLOW, will this break
> > the loop without calling trace_remote_iter_move()?
> > 
> > Since the event is left unconsumed in the buffer, could this lead to an
> > uninterruptible infinite loop (hard lockup) when reading the trace pipe?
> 
> I'll let you answer the above.
> 
> -- Steve

I don't believe this can realistically happen, trace_seq buffer is 8K and remote
events are really small. 

-- 
Vincent
