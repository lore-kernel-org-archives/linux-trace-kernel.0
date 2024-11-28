Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE31917F1;
	Thu, 28 Nov 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813081; cv=none; b=GK9ipPCjHNK6/BhiIwigxKCayC9e4LEe4Dt8WkdvKQwc94cVe32/EipKScc4hJ1Cb7qV+Rkq6Zgo+Z//fhbSZWAYOA3vwyDzAo7Ox7u1Q4sL7NKHRo4lYxBGNzTN2DZQAwvakAEmYf2YmwTROD+q1WFaccYcQWaoBIDspkWMykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813081; c=relaxed/simple;
	bh=AvnVFKOQ2ode79ZkWEmlcOXmVo9cdari5/YRXRbg7Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qC7h3KzV97FpQJ1MvbsClSmTnMEHj0ajqBbPd64vrpfo5fZfPgLteNDOhqCwdi5jeVfWbahndwHsXnppJqTLjAWBll0qND6m2OXkC4Ctlc5k6ModHXHAi/YHptBo8pNloAMmmLynQuqgadE/UQtDjK9E26DYZRlEWQtTWesBgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F696C4CECE;
	Thu, 28 Nov 2024 16:57:58 +0000 (UTC)
Date: Thu, 28 Nov 2024 11:57:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Naveen N Rao
 <naveen@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Oleg Nesterov <oleg@redhat.com>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] tracing/dynevent: Adopt guard() and scoped_guard()
Message-ID: <20241128115756.24ab7b89@rorschach.local.home>
In-Reply-To: <202411281612.F29skJjy-lkp@intel.com>
References: <173262943230.8323.4595317585229847937.stgit@devnote2>
	<202411281612.F29skJjy-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 16:42:47 +0800
kernel test robot <lkp@intel.com> wrote:

> 5448d44c38557f Masami Hiramatsu          2018-11-05   97  	p = strchr(event, '/');
> 5448d44c38557f Masami Hiramatsu          2018-11-05   98  	if (p) {
> 5448d44c38557f Masami Hiramatsu          2018-11-05   99  		system = event;
> 5448d44c38557f Masami Hiramatsu          2018-11-05  100  		event = p + 1;
> 5448d44c38557f Masami Hiramatsu          2018-11-05  101  		*p = '\0';
> 5448d44c38557f Masami Hiramatsu          2018-11-05  102  	}
> 95c104c378dc7d Linyu Yuan                2022-06-27  103  	if (!system && event[0] == '\0') {
> 8db403b9631331 Christophe JAILLET        2021-04-11  104  		ret = -EINVAL;
> 8db403b9631331 Christophe JAILLET        2021-04-11 @105  		goto out;

This is a legitimate bug. The "goto out" can't jump over a guard().

-- Steve


> 8db403b9631331 Christophe JAILLET        2021-04-11  106  	}
> 5448d44c38557f Masami Hiramatsu          2018-11-05  107  
> 79cc5c1710963f Masami Hiramatsu (Google  2024-11-26  108) 	guard(mutex)(&event_mutex);
> 5448d44c38557f Masami Hiramatsu          2018-11-05  109  	for_each_dyn_event_safe(pos, n) {
> 5448d44c38557f Masami Hiramatsu          2018-11-05  110  		if (type && type != pos->ops)
> 5448d44c38557f Masami Hiramatsu          2018-11-05  111  			continue;
> 30199137c899d7 Masami Hiramatsu          2019-06-20  112  		if (!pos->ops->match(system, event,
> d262271d04830e Masami Hiramatsu          2021-02-01  113  				argc - 1, (const char **)argv + 1, pos))
> cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  114  			continue;
> cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  115  
> 5448d44c38557f Masami Hiramatsu          2018-11-05  116  		ret = pos->ops->free(pos);
> cb8e7a8d55e052 Masami Hiramatsu          2019-06-20  117  		if (ret)
> 5448d44c38557f Masami Hiramatsu          2018-11-05  118  			break;
> 5448d44c38557f Masami Hiramatsu          2018-11-05  119  	}
> 4313e5a613049d Steven Rostedt (Google    2022-11-23  120) 	tracing_reset_all_online_cpus();
> d262271d04830e Masami Hiramatsu          2021-02-01  121  out:
> d262271d04830e Masami Hiramatsu          2021-02-01  122  	argv_free(argv);
> 5448d44c38557f Masami Hiramatsu          2018-11-05  123  	return ret;
> 5448d44c38557f Masami Hiramatsu          2018-11-05  124  }
> 5448d44c38557f Masami Hiramatsu          2018-11-05  125  
