Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07C2940B;
	Fri,  7 Feb 2025 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895126; cv=none; b=WAiY6FPSzrMcTYDwjFCjj934MlrAgh2lGgRTL3uY8ws9hHhV6bBkqTB9n87M8xfimyWGoaMR+Srm9JgwSk+uyYmBNPW8/4Hu3Kz4IfX6kknrqHyeZpJCy2Tc+OPffksrniU66o+reHxtyfx+YsViEXWFwvVDfSu44xEnI/JVS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895126; c=relaxed/simple;
	bh=TIJY7SnPvNanNZ/wQCdJ3IMuVJFoKA0bi4mack9qR3g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c2vNwsjnP0k6MWqPliV+wBIvgkNvKkGqM5VfqDbdbF2QnNHFLvhZWSStRkkPjra9NpBYmfARM8T/nYGML48K5t6xKjHkuwo7S9BIkltJe+x5QnQaQbvHyE6rfPvZ3HfZBxyc1j30kyuYx7k/PFhIwNMcRERTai3YuYbDt9I37FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTv3N5NC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTv3N5NC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEB1C4CEDD;
	Fri,  7 Feb 2025 02:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738895125;
	bh=TIJY7SnPvNanNZ/wQCdJ3IMuVJFoKA0bi4mack9qR3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hTv3N5NCEME+iJXYrn+n83YJjl383qpw2Lv6/UQuYi63fi35b+6NlQegz+KceaOz4
	 E4PKuD4HSNDzVIjxnYpwjq4Oj1D+Nz86y1vD4tO03vyMHdRxSMwmT6PFncmJkjgRMX
	 7wBkFK0tGzAKUrO6cvpOJGtHyf4VBa4Zjs7FEZWd7cGB6BLit6449x8gkFZyEFjYhr
	 tiE/WZxUNfE5tDAjEfCBUV2QjFaWHf+Rvepdz/ry5rQ3B4lihFunDAXSlumIFWlj5+
	 L8agdXvGVK/RmYIvFQefgclTTuX56eppCziOIzRvvcoc/Pz+qbqE3I/XbTvJRKrTo+
	 gJftuqEJ220Fg==
Date: Fri, 7 Feb 2025 11:25:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/8] tracing: Show module names and addresses of last
 boot
Message-Id: <20250207112521.1bf4522aa65a4ae2d0a94eec@kernel.org>
In-Reply-To: <20250206210247.4daa94c8@gandalf.local.home>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.096389081@goodmis.org>
	<20250207105111.1067fc1421bf682818e488c1@kernel.org>
	<20250206210247.4daa94c8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 21:02:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Feb 2025 10:51:11 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > >   # cat instances/boot_mapped/last_boot_info
> > >   Offset: 10c00000
> > >   ffffffffc00ca000 usb_serial_simple
> > >   ffffffffc00ae000 usbserial
> > >   ffffffffc008b000 bfq  
> > 
> > This is just a suggestion, what about using the same format for all
> > lines? For example,
> > 
> > # cat instances/boot_mapped/last_boot_info
> > 10c00000         [kernel]
> > ffffffffc00ca000 usb_serial_simple
> > ffffffffc00ae000 usbserial
> > ffffffffc008b000 bfq
> 
> This can be confusing because the first is an offset, and the others are
> addresses.

I think both are the offset from the viewpoint of `nm` results. :)

$ nm vmlinux | grep " t " | sort | head -n 5
ffffffff81000820 t __pfx_devkmsg_emit
ffffffff81000830 t devkmsg_emit
ffffffff81000a80 t __pfx_io_queue_deferred
ffffffff81000a90 t io_queue_deferred
ffffffff81000ca0 t __pfx_io_uring_drop_tctx_refs

$ nm samples/trace_events/trace-events-sample.ko | grep " t " | sort | head -n 5
0000000000000440 t __pfx_trace_event_raw_event_foo_bar
0000000000000450 t trace_event_raw_event_foo_bar
0000000000000780 t __pfx_perf_trace_foo_bar
0000000000000790 t perf_trace_foo_bar
0000000000000af0 t __pfx_trace_event_raw_event_foo_bar_with_cond

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
