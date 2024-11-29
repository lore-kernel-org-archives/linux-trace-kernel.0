Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C812B93;
	Fri, 29 Nov 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868208; cv=none; b=teFwnMdLHZeKj0qkd3i+F+a5JvLnvNpdEGVPuN0f5A1L04TL877rLQiLFq0CAkoT7T0wilRGGbkUegT15zCUJigzLomocB13+dIGyNsdNINg2Ju8O9ogbdlEzrgJqxDA+oWaObrhTw4FCwF9xrsVPRrRNfUxvhF35hc3EEgRxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868208; c=relaxed/simple;
	bh=qgjySOkXL3TnrfxEP64CtK4znfHB3eIijYhlLAaFON4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dR1vLVzWf3G4WiI288+5cN5eoOLE9aHtE4EpkGXk5D7yMmFss56w8My3hupxTvn5+CLSStAPZclxHxzg7bnUxOJ55harRO5CKhpLYDi28TD6RoRwQoPs/FRpQn80UthiwZr/8VR6XT+3wVNZJmGe/HBOfHFhT/AyFoRosOxoH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=And6veka; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="And6veka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B734C4CECF;
	Fri, 29 Nov 2024 08:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732868208;
	bh=qgjySOkXL3TnrfxEP64CtK4znfHB3eIijYhlLAaFON4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=And6vekaa4EjEQdv86kBrhIy+SgEO+oQA5F0RekkJHVsLhBEUMg0moR8gNrEQMLR7
	 dPAG29w/ZG9Hi5wUsNoyjTf4pwyT6IKB/CimMb4FHHyYcXPt+Rm46rgggfG3CCy8bq
	 hO0bRwl9Y/DSMP688z6YxfN5AzoC65blgBWP0+yOXlzTxtyf6XkTrz6sgTIrwNWeIT
	 jCRDq0dmt9Sd3PJa0fDogUiCrXVhO/e7D4aCM+w5JeSHAxDYeNlS7XaufbvT1UhZD7
	 6kSGG5iGWBnZdhzZ1Pcnhvl+3zpeNyT4SuSNUE1yAMzOkfrxheAzqOSPPIkxjlOdEK
	 /xGeudkIlwt7w==
Date: Fri, 29 Nov 2024 17:16:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
Message-Id: <20241129171644.1c1be22fed23c949f9a9b29b@kernel.org>
In-Reply-To: <20241128115756.24ab7b89@rorschach.local.home>
References: <173262943230.8323.4595317585229847937.stgit@devnote2>
	<202411281612.F29skJjy-lkp@intel.com>
	<20241128115756.24ab7b89@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 11:57:56 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 28 Nov 2024 16:42:47 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > 5448d44c38557f Masami Hiramatsu          2018-11-05   97  	p = strchr(event, '/');
> > 5448d44c38557f Masami Hiramatsu          2018-11-05   98  	if (p) {
> > 5448d44c38557f Masami Hiramatsu          2018-11-05   99  		system = event;
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  100  		event = p + 1;
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  101  		*p = '\0';
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  102  	}
> > 95c104c378dc7d Linyu Yuan                2022-06-27  103  	if (!system && event[0] == '\0') {
> > 8db403b9631331 Christophe JAILLET        2021-04-11  104  		ret = -EINVAL;
> > 8db403b9631331 Christophe JAILLET        2021-04-11 @105  		goto out;
> 
> This is a legitimate bug. The "goto out" can't jump over a guard().

Hmm, OK. let me fix that.

Thanks!

> 
> -- Steve
> 
> 
> > 8db403b9631331 Christophe JAILLET        2021-04-11  106  	}
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  107  
> > 79cc5c1710963f Masami Hiramatsu (Google  2024-11-26  108) 	guard(mutex)(&event_mutex);
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  109  	for_each_dyn_event_safe(pos, n) {
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  110  		if (type && type != pos->ops)
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  111  			continue;
> > 30199137c899d7 Masami Hiramatsu          2019-06-20  112  		if (!pos->ops->match(system, event,
> > d262271d04830e Masami Hiramatsu          2021-02-01  113  				argc - 1, (const char **)argv + 1, pos))
> > cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  114  			continue;
> > cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  115  
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  116  		ret = pos->ops->free(pos);
> > cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  117  		if (ret)
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  118  			break;
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  119  	}
> > 4313e5a613049d Steven Rostedt (Google    2022-11-23  120) 	tracing_reset_all_online_cpus();
> > d262271d04830e Masami Hiramatsu          2021-02-01  121  out:
> > d262271d04830e Masami Hiramatsu          2021-02-01  122  	argv_free(argv);
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  123  	return ret;
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  124  }
> > 5448d44c38557f Masami Hiramatsu          2018-11-05  125  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
