Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3111F16B;
	Fri, 31 May 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123046; cv=none; b=Ctv2DbgCSCR9MBrueKZ1H/8RSW1vjU72iR0WDFcKKamyuW+dHxK4UnQE3dt4YTYG4Nbm7TTAVkxGohKuSR5FW3weEe0iiyn/FlT+xinRyB11l/JgXsHnT0kmson6zozZuPmY3GZaFdTnjnj7gdDBYMjkaokXm0MzQlnA/DKoOM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123046; c=relaxed/simple;
	bh=25NiTbvE2NzMasFL8W/zwIAxAosWFfxZafXz8WmfOPQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZywkbKJyYbaYzFcVoGWGE6dCsksug3XS/v2xIkykHVpOPg8oQqruMBnkqRk0c0uPL7VPJo9Td2B6p1ysiLD7c4YGuc6J1Bfzn2/fZ3Y1oc2Mn0LURfNAemrrVIBfCGkzAL6Rv71TS5ALFYSbY6aQjuqHhoo+Bh4hQcXeNofoodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLp4FjPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLp4FjPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6DFC2BBFC;
	Fri, 31 May 2024 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717123045;
	bh=25NiTbvE2NzMasFL8W/zwIAxAosWFfxZafXz8WmfOPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BLp4FjPyHwL+h/cA7S8LBPh8vsMNy7+9gGPFH7z04VKN9JuYXJfANIJev/nEdFVsW
	 AiXBGSekzI7kg5z2h4N8aNmqOG8Zyt2BiRnc2l6mgwcs9s8nFtEKTKsb/V1sISOK58
	 6Xi64WweIzZxAzCx+OefTDFlnoiZ1PSzDRAOZVH8SO8XMdkRtw5jTBqv5w/vijtmNN
	 GaK4Roy3GMaHNOiRPnDCKE08Lviw0IJA2suEr3hS5r1m9RXRTlpA4aTTobDOgf763x
	 av6meTzr4X7bX9f1RdUaObai8WS7xMGRCi4xcGyx/hbh5E6vX5o2TEziqVMeVyUXRd
	 8mkJYoIRwphUQ==
Date: Fri, 31 May 2024 11:37:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
In-Reply-To: <3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 11:01:43 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Wed, 2024-05-29 at 08:38 +0900, Masami Hiramatsu wrote:
> > On Wed, 29 May 2024 01:46:40 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > On Mon, 27 May 2024 19:29:07 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > On Sun, 26 May 2024 19:10:57 +0900
> > > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > Here is a series of some fixes/improvements for the test
> > > > > modules and boot
> > > > > time selftest of kprobe events. I found a WARNING message with
> > > > > some boot 
> > > > > time selftest configuration, which came from the combination of
> > > > > embedded
> > > > > kprobe generate API tests module and ftrace boot-time selftest.
> > > > > So the main
> > > > > problem is that the test module should not be built-in. But I
> > > > > also think
> > > > > this WARNING message is useless (because there are warning
> > > > > messages already)
> > > > > and the cleanup code is redundant. This series fixes those
> > > > > issues.
> > > > 
> > > > Note, when I enable trace tests as builtin instead of modules, I
> > > > just
> > > > disable the bootup self tests when it detects this. This helps
> > > > with
> > > > doing tests via config options than having to add user space code
> > > > that
> > > > loads modules.
> > > > 
> > > > Could you do something similar?
> > > 
> > > OK, in that case, I would like to move the test cleanup code in
> > > module_exit function into the end of module_init function. 
> > > It looks there is no reason to split those into 2 parts.
> > 
> > Wait, I would like to hear Tom's opinion. I found following usage
> > comments
> > in the code.
> > 
> >  * Following that are a few examples using the created events to test
> >  * various ways of tracing a synthetic event.
> >  *
> >  * To test, select CONFIG_SYNTH_EVENT_GEN_TEST and build the module.
> >  * Then:
> >  *
> >  * # insmod kernel/trace/synth_event_gen_test.ko
> >  * # cat /sys/kernel/tracing/trace
> >  *
> >  * You should see several events in the trace buffer -
> >  * "create_synth_test", "empty_synth_test", and several instances of
> >  * "gen_synth_test".
> >  *
> >  * To remove the events, remove the module:
> >  *
> >  * # rmmod synth_event_gen_test
> > 
> > Tom, is that intended behavior ? and are you expected to reuse these
> > events outside of the module? e.g. load the test module and run some
> > test script in user space which uses those events?
> > 
> 
> Yeah, this module was meant as a sample module showing how to create
> and generate synthetic events in-kernel.
> 
> So the interested user insmods the module, looks at the trace stream
> and sees, ok the events are there as expected, so it does work, great,
> let's remove the module to get rid of them and go write our own.
> 
> Having both the creation and cleanup in module_init() wouldn't allow
> the user the opportunity to do that i.e. verify the results by reading
> the trace file.

So, in summary, it is designed to be a module. Steve, I think these tests
should be kept as modules. There are many reason to do so.

 - This test is designed to be used as module.
 - This can conflict with other boot time selftest if it is embedded.
 - We can make these tests and boot time selftest mutable exclusive but
   if we make these tests as modules, we can build and run both tests
   safely.
 - Embedding these tests leave new events when the kernel boot, which
   user must be cleaned up by manual.

What would you think?


Thank you,
> 
> Tom 
> 
> > As far as I can see, those tests are not intended to be embedded in
> > the
> > kernel because those are expected to be removed.
> > 
> > Thank you,
> > 
> > > 
> > > Thank you,
> > > 
> > > > 
> > > > -- Steve
> > > > 
> > > > 
> > > > > 
> > > > > Thank you,
> > > > > 
> > > > > ---
> > > > > 
> > > > > Masami Hiramatsu (Google) (3):
> > > > >       tracing: Build event generation tests only as modules
> > > > >       tracing/kprobe: Remove unneeded WARN_ON_ONCE() in
> > > > > selftests
> > > > >       tracing/kprobe: Remove cleanup code unrelated to selftest
> > > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
