Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933C4C96;
	Wed,  5 Jun 2024 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552632; cv=none; b=r6fYcLIXD+6xETFco5zndDMN/yFdl+HNTus940v858M/W/fVtiYrM3ht7KRNDCylKsdMchvlbJZWzInbWtaEcFfIkNwSjpB+upCKPE33vsmctmJqUuIxx1SFtxN83E2Wg3enzfgPR/x9L0BWXEXWeR4LFCIUZOpHzZDl38OiTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552632; c=relaxed/simple;
	bh=Ur1oYLXFb18gjU9SJyinVjulkshfuu3L5E854Vj5zog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krG8U62OfkK8uiIBg438ERlFZSQvnTl4gmvwE42qPztBojp118Tua/xqssMO007AjHre+z5fjXuVivwjFXYW2io4AghqRSG2G551q8uLCiMt9GAh+me4U8x55c20oOyqCxVq75cSx/iZpWoNhaXcbTIAM0BJWRWVgVN4XFBzqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B527DC2BBFC;
	Wed,  5 Jun 2024 01:57:10 +0000 (UTC)
Date: Tue, 4 Jun 2024 21:57:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>
Subject: Re: [PATCH 4/5] ftrace: Convert "filter_hash" and "inc" to bool in
 ftrace_hash_rec_update_modify()
Message-ID: <20240604215711.4636e416@gandalf.local.home>
In-Reply-To: <202406050838.7r32JzDI-lkp@intel.com>
References: <20240604212855.046127611@goodmis.org>
	<202406050838.7r32JzDI-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 09:12:57 +0800
kernel test robot <lkp@intel.com> wrote:

> >> kernel/trace/ftrace.c:1961:13: error: conflicting types for 'ftrace_hash_rec_disable_modify'  
>     1961 | static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops,
>          |             ^
>    kernel/trace/ftrace.c:1384:1: note: previous declaration is here
>     1384 | ftrace_hash_rec_disable_modify(struct ftrace_ops *ops, int filter_hash);
>          | ^
> >> kernel/trace/ftrace.c:1967:13: error: conflicting types for 'ftrace_hash_rec_enable_modify'  
>     1967 | static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops,

Of course these static functions have prototypes to be used earlier. Bah!

-- Steve
