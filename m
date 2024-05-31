Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3140848D;
	Fri, 31 May 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165251; cv=none; b=EZY9Kh33cySxNzhIli/OkKgMtgnLlEDv2Vs1kDkgyXRlrrBPcxFdSTNbqmBAfH/bd9AkI+DAJo0HtoRY9osXYpw0jNnjNREAusKudNvQmUIEl9RJpxZoOYvsIeh15pQ/+3mk91ikbgupQUzHnSYX0GNxBQVXdprBeV365C0fnmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165251; c=relaxed/simple;
	bh=24V3OlbxU0oH/IDoFPcIbXWPFTslHktxEQ/AHEVjUE8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=co0ZWUxByv1RO9zZ1Q2CTE0G7FCKuHlPTnVc8kODqW7NttXqsA+T7liqOnzUf53JEiNGJvCtR2+rq8c7pg+Z7pXn54Fa+Y4zPxUM+D8se48co9XicmPoB1o+pPDYk6C52yb9LFa0LDbdMi/ES5lDBjhUU4uR/06XoR1x2KvhAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOlKdpgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOlKdpgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FCCC116B1;
	Fri, 31 May 2024 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717165251;
	bh=24V3OlbxU0oH/IDoFPcIbXWPFTslHktxEQ/AHEVjUE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOlKdpgxpSj7lq6hDLoL1tF1g/GGWKh5KA5HAsdir79YDyeQpUSJq0COLrAqFghLF
	 6MoPfU+3yju32iVlBfjOgRQOtGpYJOV1zx6nohksPpyKgtaGPeAYjt88r6rf2+EMSJ
	 2TThXzlD1T73ZY+2732EeD/h0DKUkxy5qtnhjUTErGLKZJFox7C4HdgXGtXO7zy1yd
	 usLMt1t8TpyWZgiCdxZfHEy8ogqKASb2WVxzhlrQIoKnSXxw2mjibQsIZTvJOSdelx
	 ZpWthZLdYomTP8lTydUbuJ1R90naklRwfjSI6dtfyMlNJNg6Bmv/jrwk0uZJPG4OyL
	 fXswou4LYx+tw==
Date: Fri, 31 May 2024 23:20:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240531232047.fca5712a98e360d4a27fd92c@kernel.org>
In-Reply-To: <20240531032425.3635dc93@rorschach.local.home>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
	<20240531032425.3635dc93@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 03:24:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 31 May 2024 11:37:21 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > So, in summary, it is designed to be a module. Steve, I think these tests
> > should be kept as modules. There are many reason to do so.
> > 
> >  - This test is designed to be used as module.
> >  - This can conflict with other boot time selftest if it is embedded.
> >  - We can make these tests and boot time selftest mutable exclusive but
> >    if we make these tests as modules, we can build and run both tests
> >    safely.
> >  - Embedding these tests leave new events when the kernel boot, which
> >    user must be cleaned up by manual.
> > 
> > What would you think?
> 
> I was mostly following what Ingo told me long ago, where having it
> built in is just one more way to test it ;-)

Ah, would you mean embedding the module is also a part of tests?

> 
> But that said, from your first patch, you show the stack dump and
> mention:
> 
> > Since the kprobes and synth event generation tests adds and enable
> > generated events in init_module() and delete it in exit_module(),
> > if we make it as built-in, those events are left in kernel and cause
> > kprobe event self-test failure.
> 
> But you don't explain what exactly the conflict is. What about those
> events causes kprobe selftests to fail?

The major conflict happens when the boot-time test cleans up the kprobe
events by

  dyn_events_release_all(&trace_kprobe_ops);

And I removed it by [3/3] patch in this series :) because it does not
needed and not confirmed there is no other kprobe events when the test
starts. Also the warning message are redundant so I removed it by [2/3].

So without this [1/3], if we apply [2/3] and [3/3], the problem will be
mitigated, but I think the root cause is that these modules are built-in.

Thank you,

> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
