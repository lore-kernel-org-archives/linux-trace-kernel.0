Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838722089;
	Tue, 28 May 2024 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939502; cv=none; b=OFmkIYUTxd2gfoNBmR4ukud9MKcKSSTQ7KU3I4w8eugrBgg3HK1YdbnkBvrdck8rtUV8d+mJqWUDeZpzN+gwkFxhZqOwloY0E4+UGY93Yj8RPqKcDyFLsDwK1bD1JXjS3MIEhaGaVtNusBLwWyzSPLONqPPX7MVCf3mERPfBYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939502; c=relaxed/simple;
	bh=TpDi1rlY2iMnEAvGzJaWls/kzXNX5boHttjre4NjfoQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fb6LIXyhocGIFpNiKHIuDZo2W+PeiCehpfEs3Fep/gZe/3fXUfs9bfxS0wrZ+nblxmde18DH0AfWfWHNnFGEP/abhI60FP8yL0xhgoWDgOWj8rq59aQ7wDTxVavHBy8+TCMV5xRampq1SNvTLfFn80YICPVhrD/zt3u4SBHAiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4ogkXsa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4ogkXsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FD6C3277B;
	Tue, 28 May 2024 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716939502;
	bh=TpDi1rlY2iMnEAvGzJaWls/kzXNX5boHttjre4NjfoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s4ogkXsa+62W8C1AJPuL5IV3P0qrRMShwzi+74VDtJYPSP/tEt6/NMmilxjTxsTxl
	 OPTBQZ09T7KswYJcGegYOi0YfHDARkYQNisGv3HKyDFX1RHGBwjO+bKyI3dNR9PrIT
	 4bNq1NiapYAnZ7KMTo792I+1EUtUW7BazK6U+X/gw+Taul/1kkSjlmKR6DszsCZmmI
	 WXOnX0Oze2PRjc8yY9wZnx/xsPC9VBhNr8oLWeV53N+1HlkaZnYsBpO4OxR74LjFA7
	 y1pz9Jbgem4Jz+HTKDn+E8k3qhLvD461ls6VQ5sU3hXnuklXemPXEDZz3NddGOAFz5
	 tOx0uRIBvM66g==
Date: Wed, 29 May 2024 08:38:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Tom Zanussi
 <zanussi@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240529083818.b7835de167191d4567405ce6@kernel.org>
In-Reply-To: <20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 01:46:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 27 May 2024 19:29:07 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sun, 26 May 2024 19:10:57 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > Here is a series of some fixes/improvements for the test modules and boot
> > > time selftest of kprobe events. I found a WARNING message with some boot 
> > > time selftest configuration, which came from the combination of embedded
> > > kprobe generate API tests module and ftrace boot-time selftest. So the main
> > > problem is that the test module should not be built-in. But I also think
> > > this WARNING message is useless (because there are warning messages already)
> > > and the cleanup code is redundant. This series fixes those issues.
> > 
> > Note, when I enable trace tests as builtin instead of modules, I just
> > disable the bootup self tests when it detects this. This helps with
> > doing tests via config options than having to add user space code that
> > loads modules.
> > 
> > Could you do something similar?
> 
> OK, in that case, I would like to move the test cleanup code in
> module_exit function into the end of module_init function. 
> It looks there is no reason to split those into 2 parts.

Wait, I would like to hear Tom's opinion. I found following usage comments
in the code.

 * Following that are a few examples using the created events to test
 * various ways of tracing a synthetic event.
 *
 * To test, select CONFIG_SYNTH_EVENT_GEN_TEST and build the module.
 * Then:
 *
 * # insmod kernel/trace/synth_event_gen_test.ko
 * # cat /sys/kernel/tracing/trace
 *
 * You should see several events in the trace buffer -
 * "create_synth_test", "empty_synth_test", and several instances of
 * "gen_synth_test".
 *
 * To remove the events, remove the module:
 *
 * # rmmod synth_event_gen_test

Tom, is that intended behavior ? and are you expected to reuse these
events outside of the module? e.g. load the test module and run some
test script in user space which uses those events?

As far as I can see, those tests are not intended to be embedded in the
kernel because those are expected to be removed.

Thank you,

> 
> Thank you,
> 
> > 
> > -- Steve
> > 
> > 
> > > 
> > > Thank you,
> > > 
> > > ---
> > > 
> > > Masami Hiramatsu (Google) (3):
> > >       tracing: Build event generation tests only as modules
> > >       tracing/kprobe: Remove unneeded WARN_ON_ONCE() in selftests
> > >       tracing/kprobe: Remove cleanup code unrelated to selftest
> > > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
