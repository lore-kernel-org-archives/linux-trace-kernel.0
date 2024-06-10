Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787F249F5;
	Mon, 10 Jun 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048977; cv=none; b=o+9nHK7NKjSX/VS0ew0HxACKpr1mfqgBO9N/nxKhbjn2PzPRUBuEqeL3g7uQ6shqWyQgeBA+JynLglsPS1wSi5vujiug/xGwFPYPQatp0TJ0BZL93+OPYw7HckxEdbCspwyvCD5+cayP+s5lNiSr99VVw+QNwlZtEdgvRurhwqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048977; c=relaxed/simple;
	bh=BajpPb9cYuVE2LzaAxXNYoeuNPuKokjgXCrmdP/kO4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVcIL4V/W7zaYHVgu8Z+2bz0+jY/E4v09cM5mBihW5z1agnOtFHtOWniadJFdtkBDQns7MSXkvewbQCydPBfHJcS6bcmkFmLD8JrwrpUlUOMH4QkpKMjFz+khSdKcySx37AGVzsa7k71s8GjvL+srSKXs7SDEQr1s+WS/hAP4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309AEC32789;
	Mon, 10 Jun 2024 19:49:36 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:49:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-ID: <20240610154949.66f3c700@gandalf.local.home>
In-Reply-To: <20240610111001.5ed3e97f6383915fcba87e31@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
	<20240531032425.3635dc93@rorschach.local.home>
	<20240610111001.5ed3e97f6383915fcba87e31@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 11:10:01 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > But you don't explain what exactly the conflict is. What about those
> > events causes kprobe selftests to fail?  
> 
> I also found another problem on these modules. These modules get trace
> event file references to prevent removing probes. Therefore, if we
> embed these modules, we can not remove these events forever!
> 
>         /*
>          * Now get the gen_kprobe_test event file.  We need to prevent
>          * the instance and event from disappearing from underneath
>          * us, which trace_get_event_file() does (though in this case
>          * we're using the top-level instance which never goes away).
>          */
>         gen_kprobe_test = trace_get_event_file(NULL, "kprobes",
>                                                "gen_kprobe_test");
>         if (IS_ERR(gen_kprobe_test)) {
>                 ret = PTR_ERR(gen_kprobe_test);
>                 goto delete;
>         }
> 
> This means most ftracetest fails because we can not clean up the
> tracing state by removing dynamic events, which are installed while
> booting.
> Note that these references (locks) will be removed when the module
> is unloaded.

I'm fine if you want to force these as modules. Just make sure the change
log lists all the issues of them not being modules.

-- Steve
