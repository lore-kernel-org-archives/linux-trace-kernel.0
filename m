Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECA1C861F;
	Wed, 30 Jul 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870267; cv=none; b=mxFwDqhPAVFICSw9NqB/H5AKwSlorW5sr98mXJxDRYAjblDwdv1ZzVb94ILLi8WCtWRF9+AhFgbRBHyT0UNhImA3pPrG+mqJStX7Jf9Wq3Ux+a2b0WTXCHrFHu50X1ks8dYMDd//42kZdAeA5pgMyV/mshLjl9MVJn0sdSgcwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870267; c=relaxed/simple;
	bh=pnGxoS3OSecq/nhtm6H+J4Cjcuia3dKAU/NRqZLtAY0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T2QzSxD+KPdAPD7ukjEib0edqk4KayGsVoeJUKHaT5kNnag4rm17NQW+E3WiXWxgUnFriEvbsS4cPdK6jPOLHoH3E3Qpxe1pQj1peekklbkw4BBwvxp79w+VhFgqGED3F0vjLWuPVRtdbFWTU73ubXu1m92QBCbElKzFD/CxcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrE9nbyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrE9nbyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112E4C4CEE7;
	Wed, 30 Jul 2025 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753870267;
	bh=pnGxoS3OSecq/nhtm6H+J4Cjcuia3dKAU/NRqZLtAY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrE9nbyJnXasszyzxe7vuARHwlZqRT4Egs8bU8yW7nxeMXKu+ofCfJWdWI9vY/1E2
	 f+vKgHulgbDiHWElrxhi7ziGMvehBIoDHfaXNhciy32V1IrHXC7o7NfJqC6Qa1qhfG
	 gVUuC5C5bZXcJFeK7Xunxz8EGdXxm0E3qJl118erF6tqja8IFneOstrFfOVPjqUSee
	 64gg/x0fiBrFdMENMIWlxKzvhcLDG3E77FBMts9mXKcz4h7OcWY1rcs+qfBE6z37KW
	 bMi2n1Rk1nSQI6WE8oz65iext9Ry6aWyphwXDVsoQJio8lnqnfii9n2bqk48yfMFt3
	 nmekez5FtSNww==
Date: Wed, 30 Jul 2025 19:11:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config
 option
Message-Id: <20250730191101.7e6203f21b94c3f932fa8348@kernel.org>
In-Reply-To: <202507301452.JPAcMvT0-lkp@intel.com>
References: <20250729161912.056641407@kernel.org>
	<202507301452.JPAcMvT0-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 14:27:08 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Steven,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on lwn/docs-next akpm-mm/mm-everything linus/master v6.16 next-20250729]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Have-eprobes-have-their-own-config-option/20250730-001958
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> patch link:    https://lore.kernel.org/r/20250729161912.056641407%40kernel.org
> patch subject: [PATCH v2 1/2] tracing: Have eprobes have their own config option
> config: xtensa-randconfig-002-20250730 (https://download.01.org/0day-ci/archive/20250730/202507301452.JPAcMvT0-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 12.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250730/202507301452.JPAcMvT0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507301452.JPAcMvT0-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace_probe.c: In function 'parse_probe_arg':
> >> kernel/trace/trace_probe.c:1105:23: error: implicit declaration of function 'regs_query_register_offset'; did you mean 'ftrace_regs_query_register_offset'? [-Werror=implicit-function-declaration]
>     1105 |                 ret = regs_query_register_offset(arg + 1);
>          |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                       ftrace_regs_query_register_offset
>    cc1: some warnings being treated as errors


Interesting, this find another issue. Since this is provided by
CONFIG_PROBE_EVENTS, we need to fix CONFIG_PROBE_EVENTS depending
on HAVE_REGS_AND_STACK_ACCESS_API.

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..cd239240b0ef 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -792,6 +792,7 @@ config DYNAMIC_EVENTS
        def_bool n
 
 config PROBE_EVENTS
+       depends on HAVE_REGS_AND_STACK_ACCESS_API
        def_bool n
 
 config BPF_KPROBE_OVERRIDE

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
