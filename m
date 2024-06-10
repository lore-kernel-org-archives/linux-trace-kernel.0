Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F14690;
	Mon, 10 Jun 2024 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717985405; cv=none; b=R+SDDGw4Lx8+rmbZCjHafFIyI3vIxJNiKK6RTKbsEQXBTfOBCXe2LVND+XJind5ldFr4Kij7ZApy5/OCd0/IjNpxuHG3hlRqdmAXybXmb4KqYXORcRj04RIcjnTiGbkkZXZWXCPNrdQjFbuWfzHysplY9DcrXbtGyMXCwnZq2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717985405; c=relaxed/simple;
	bh=jhxWRa0+J1JHMbuwYGlUbrlrc9N4suvPVz3VmXVLMyU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uZ+mQhxdTYXxJ0ienT6XkkMSBi1SPg5SUdoxXl+j4y11sklp0jWvOXWt4YgceCEPNWNYVG3jKpyyjBHZ9UaKNNQucrZgghY/XJVjZvrv3LQj5JCFnf4pS94TWNRbOXLAQETRHohHi/H1Lbp2vIgRT7sEEz40+IpeRoNod6pjWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny/+cEbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny/+cEbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F366C2BD10;
	Mon, 10 Jun 2024 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717985405;
	bh=jhxWRa0+J1JHMbuwYGlUbrlrc9N4suvPVz3VmXVLMyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ny/+cEbiDGl/YTmkXoj6hCCAnSTf3Io6fsEWazovZSFqOhb0JTiCjNm0CejjTACAz
	 kR/TNDjcTT2V7F8PmMUFie8fVbZDtd3E8eZ4DVv5Vkvuz+0WfMl0UIjwS9MgiauMzo
	 /jJ0rmEzjmSvULIAfSHXvJUV0DdYPxjDtqRLZW3jvN5UfuzuMH4e0ZmIGJPRSJaoGq
	 Md2wVbrwbLBNKBhYVL3uD0hJwsXZJb0W66Sp9EqPI6i3m+gsapmSj9/Q7W7guatgOE
	 7xBQdHlOee0YeA45PNKXQG6rktvjPRGSr20BKDReqo9GvwN/rentpXXghbBghiTriO
	 7rP3OtYRz8HOQ==
Date: Mon, 10 Jun 2024 11:10:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-Id: <20240610111001.5ed3e97f6383915fcba87e31@kernel.org>
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

I also found another problem on these modules. These modules get trace
event file references to prevent removing probes. Therefore, if we
embed these modules, we can not remove these events forever!

        /*
         * Now get the gen_kprobe_test event file.  We need to prevent
         * the instance and event from disappearing from underneath
         * us, which trace_get_event_file() does (though in this case
         * we're using the top-level instance which never goes away).
         */
        gen_kprobe_test = trace_get_event_file(NULL, "kprobes",
                                               "gen_kprobe_test");
        if (IS_ERR(gen_kprobe_test)) {
                ret = PTR_ERR(gen_kprobe_test);
                goto delete;
        }

This means most ftracetest fails because we can not clean up the
tracing state by removing dynamic events, which are installed while
booting.
Note that these references (locks) will be removed when the module
is unloaded.

Thanks,

> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
