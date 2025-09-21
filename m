Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0234BA28;
	Sun, 21 Sep 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758464075; cv=none; b=t2YUhxhmAgxzLbs3a4uYQAhKXiirGQNqv+nTLvRi29BkbLLibdweNGXmJlCPsMtI4oZaVb5wB/DhrtnEdfgePqCdArrwY6YW1dSUwn7HAQRW6E5D8DIWo+JlU5EiiQJ1tPKmR6Vzct6y3kmc2+U/Dxyp86LPwUdHpO8C6mwZn4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758464075; c=relaxed/simple;
	bh=yQe6GTyed+bf6gX5mLuOnWqpRoDA9ZC1uGgD1I1Q104=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uCPqbhVPdSjCEKnAw3aI/5HTmDcqHNY0s6CkrcsiXeRYiMmtLItVgL/Rw03RbdYs3h/faNs8kh0Oa4f6I2VUVrDJ2kVYk4DOUQ7RHOLL+k89OmRivQRl/qDEjfOHIbrNNKRiwseDeupJx1hyGozRGxMejuG1yGr/ik2G16T+kjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPywV+G4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPywV+G4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33D2C4CEE7;
	Sun, 21 Sep 2025 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758464074;
	bh=yQe6GTyed+bf6gX5mLuOnWqpRoDA9ZC1uGgD1I1Q104=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qPywV+G4wS+ndT8c6+ueUmHmqMvzi6w18HQqkLC0K4CULoS/PCaQRsNcJdlh8gqts
	 dFmh0mJZbN7xRR+MQfiiYnLVmttD6ODumIIPUKFXioYh+ypzsOKl84LaqcXeDWPlZw
	 tdFlTsOCMfu5ikjqmbF5s6PosJNK1b4PLi69fNrVCnlfhbCSUD1BQO9br8uWvid5MA
	 X0QIv0jkSVBGie3e5aEDLNoFDf92xRA+o7JHcJNpU6jKzHcu7xfKewsPOTRvtLrkif
	 uB437Fr9O83EBpwprE1fzMET3T3soiBLTE5Zlo7InUTFBLHz0c7/K5usbfGi94OvWP
	 jWPLR1rS0nJZg==
Date: Sun, 21 Sep 2025 23:14:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <lkp@intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, oe-kbuild-all@lists.linux.dev, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add an option to show symbols in _text+offset
 for function profiler
Message-Id: <20250921231430.66a0da9e185ea1084bc6d301@kernel.org>
In-Reply-To: <20250919131621.093295c8@gandalf.local.home>
References: <175826135058.101165.7219957344129610147.stgit@devnote2>
	<202509200000.EJ4InVti-lkp@intel.com>
	<20250919131621.093295c8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 13:16:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 20 Sep 2025 01:09:52 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Masami,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on trace/for-next]
> > [also build test ERROR on linus/master v6.17-rc6 next-20250918]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/tracing-Add-an-option-to-show-symbols-in-_text-offset-for-function-profiler/20250919-135733
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> > patch link:    https://lore.kernel.org/r/175826135058.101165.7219957344129610147.stgit%40devnote2
> > patch subject: [PATCH] tracing: Add an option to show symbols in _text+offset for function profiler
> > config: x86_64-buildonly-randconfig-002-20250919 (https://download.01.org/0day-ci/archive/20250920/202509200000.EJ4InVti-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250920/202509200000.EJ4InVti-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202509200000.EJ4InVti-lkp@intel.com/
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    In file included from kernel/trace/trace_sched_switch.c:15:
> > >> kernel/trace/trace.h:1422:37: warning: left shift count >= width of type [-Wshift-count-overflow]  
> >     1422 | #define C(a, b) TRACE_ITER_##a = (1 << TRACE_ITER_##a##_BIT)
> >          |                                     ^~
> 
> Ouch! We need to make the option enum64 now!

Ah, it is an enum, not macro.

Thanks!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
