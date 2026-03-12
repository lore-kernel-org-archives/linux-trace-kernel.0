Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C282D8DDB;
	Thu, 12 Mar 2026 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302766; cv=none; b=aVlD+B1n+lD/OXd+u7ogF/JKNHmLSp2pubZooZpFNfPhqObN8MxRVU7ylWjCC2cm7urNyCiJvRHmrxN/Oo7jX2k1duBFqPERc4DOQzAv9W0jyYXYV0hBYeEdYwdrxzP6xSMn9+i/V4TevgqZhao0yVmrConHLd5GSf8F/vWXO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302766; c=relaxed/simple;
	bh=8vMfBw1+j1+AlEMGodkzcoZiuF4bRylUsPikca4EklQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C+/mD79oNmhj3v3nBoG5p9FxqDX1kgnKeAyjTXV1GoNO3pM1JvQwjs4VZDQgoAfS4642CyRJWMCI6l/qLKS8XT/aPRHyOBHOr/lh91w925SzTwwAaYJGb/u+y140XzvXsAPcI+dfIL7qyIZDs/R1hJp2x+pQ42kbWwRx8+ff4nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3dq+NT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3dq+NT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B268C116C6;
	Thu, 12 Mar 2026 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773302766;
	bh=8vMfBw1+j1+AlEMGodkzcoZiuF4bRylUsPikca4EklQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e3dq+NT2E/AWNUZcuoSL8eVrSSMOMCwcH71SFgLnk3rCu5WTn2XcRHAHQZofxuK9A
	 XESo51HpfmKkfLMM8mZWW1rdl8n3nJf7u49ZbbD6fFaIzWMCl1TwJZk6VUTFFsMcfr
	 mpqKN5NDL6lkhPI3if2JZy6ZyRSAG+KC018Tv2tfKdXDOxjNRvMtH2hJsX8Gfa36G6
	 Wp22BzH+puy7L+zT6mHEkkrULfWPJ4TUwKMDHGQQynmwCSHwlzgSRtwrWqXfcsoxB4
	 x6j0dbRdNIk//XIbG2B7ITR29CTTD20N1lgnXmwnyMYT55jI6qHn10jlKAYH+QSDEN
	 J/woVjaQ4C12w==
Date: Thu, 12 Mar 2026 17:06:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
Message-Id: <20260312170602.703df4c77dba2b558b4c08e1@kernel.org>
In-Reply-To: <CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
References: <20260311115250.78488-1-laoar.shao@gmail.com>
	<20260311115426.GN606826@noisy.programming.kicks-ass.net>
	<20260311125350.1d89341f@pumpkin>
	<CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 11 Mar 2026 21:40:32 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > Although there is a bigger issue of why on earth the code is reading the
> > list of filter functions at all - never mind all the time.
> 
> bpftrace reads the complete list of available functions into
> userspace, then performs matching against the target function to
> determine if it is traceable.

What about changing bpftrace userspace tool to cache the list of available
functions? (or just add an option to pass available function list?)
Then, you can just copy the function list somewhere and uses it.

Of course we can do the same thing in the kernel, but I don't think
there is any reason to do it in the kernel instead of user space.

Thank you,

> 
> > I'll do it by hand when debugging, but I'd have though anything using bpf
> > will know exactly where to add its hooks.
> 
> 
> -- 
> Regards
> Yafang


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
