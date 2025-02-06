Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94928F1;
	Thu,  6 Feb 2025 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738809935; cv=none; b=WqDt5V5xjgNzeQK8o0ke78ydeQwzylbjjrzcq8CwVzFfTl94uJFskth6eZmMfHQYVyaS1cJ0S3b0tplznExiovQ+XEyFOv3QTzbeiZzpfm8EdetPdqzw4AndtMoC/ZSW9/MZCr4vr6jVb2UDjX6w01jwbUE4rCyffWMfdob+WQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738809935; c=relaxed/simple;
	bh=zD/v9T5ezF+mM+r8BeAzTGxdqpYxWCV7HF6b2TzWeDE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jXRBQmU9M2gouCEttS82rENZDWt75MO5TO+zNzmPxG5rDWwSfQtSFGzl0lIKXKkgu5tq+hzWBquym8oR5Sy9ERsN2FjT6+i1kbG6vggkKmwJzd6PFT+tFTT1NmxXcP8/dGX86uhk0aX2CC3uOSMFnfur1/+JKQDwQ+B+A8kZDoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpglOpgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpglOpgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D3CC4CED1;
	Thu,  6 Feb 2025 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738809935;
	bh=zD/v9T5ezF+mM+r8BeAzTGxdqpYxWCV7HF6b2TzWeDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpglOpgHvGhNAm71MSNVgSimudm+JHOiJJE7yhyIFCE15pyduSXtMwCGIf2RblIDJ
	 KjqrP5St08/AaTdGUXodASQjT7OISSuhVrghkjrBdsOXjFxfoWj7cihc5z+pxQuydd
	 DDuADRsqlqL1D1oJlmAmHZ+tV21gNkdYxc7lxhL3jRU3v/6wRL7j+up7jE5I7vbdQr
	 m6cM9qBT/CcbLQUpIIVoO6gbL+uBGZ+0TgE9gIhauHlTOkIGdaszqer1AeWvqmSF2B
	 pxQ2wyIeIYWFQdQMMw8OPXXpO8bJ7FNpBPxrOquepMcqY1eq2tye9Vj0S2xnJYroST
	 ZXggg9kTyc+Kw==
Date: Thu, 6 Feb 2025 11:45:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Haiyue Wang <haiyuewa@163.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, samitolvanen@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS
 is enabled
Message-Id: <20250206114529.d2483df2c9d09726f1f3a43d@kernel.org>
In-Reply-To: <20250205195300.42d3e3b0@gandalf.local.home>
References: <20250205180116.88644-1-haiyuewa@163.com>
	<20250206093853.4e55405ccfcba7111705f395@kernel.org>
	<20250205195300.42d3e3b0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 19:53:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 6 Feb 2025 09:38:53 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Thanks for the fix. And this fixes one of problems.
> > Another one is that `is_endbr()` is defined in <asm/ibt.h> but that also depend
> > on CONFIG_HAVE_FENTRY.
> > 
> > Let's pick this and fix above issue.
> 
> OK, I'll pull this into my urgent tree and start testing it.

Sorry, Gabriel found another issue.
Let me fix this instead of this patch.

https://lore.kernel.org/all/CAFEugPfFykYsHqS-J36CNWDn+d34bSQg-e5hJ=AaJPC8=6Ej-g@mail.gmail.com/

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
