Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440C8BF8;
	Fri, 16 May 2025 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362353; cv=none; b=LZfWMWnQzojFLd1tuNdpBfjvtW2eF4jqtp8BgBAjpjjtbspZIGaiEUS54Yq1BRmM/ML3i9isXYzlzqLTAGiVP0l+KuW2hOT2pxUUbeMEHApMdirBdNVbI+EEbn+mH9PR4vTpj8IHd8aVsOpoLqP3PwJMVqzXcutZzfJvRfhTVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362353; c=relaxed/simple;
	bh=evP0eaE4GLopPs9IFKV4OGgSgh6RJKFtbVSQLyZEmr8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o7Wf1QEAyHK/j6zAxAmcZ6/bXLPXakTH2yXQPlD2BK1edHI+/A6SI77GltqupwFhrfvglAfKGZhXBf0iUNKtZrajmfZ/Y1pH3beV8K2DuUMxCJu4IM6M14KeIKgpzT8Chf7/2JWpfEZtLtePdCfDWuob92X5SkhcuTMKyWVU6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWfSu5KQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWfSu5KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CBEC4CEE7;
	Fri, 16 May 2025 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747362353;
	bh=evP0eaE4GLopPs9IFKV4OGgSgh6RJKFtbVSQLyZEmr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jWfSu5KQKZYa+OkC+cnnPddQzodoPoObQS8Wd5K2MoQqhh+us4mtvqmayF9HJi2AE
	 dXghW4kO85DExYQENcy7WXLOWYCaUzXxZJxa7R4Ek5caQCad8mYBBkuRp2tXt746Te
	 JeWCqGimxOxSp/k73Ry7tbp3nAQyl7Og/ixmqYx1ESbTjmbURMGoxUK/qhX4i1bLmD
	 g9aE9ZWB3mvx400LbmpR9StzsvE3qQwsk1B47qAVzMOYyTqCsgwLrgEX9g/jvubG2b
	 KVw/BoX9xU4wIhWXHwEOVxdBa2pe4lzTH6QvxlJvQVWE0PJnyhJ/INF0lD90C44vHX
	 Wzsky5Eu5Px2g==
Date: Fri, 16 May 2025 11:25:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Brian Masney <bmasney@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, aruiz@redhat.com
Subject: Re: [PATCH 0/2] tools/bootconfig: allow overriding CFLAGS and
 LDFLAGS
Message-Id: <20250516112549.365dfb31b3b04abcdfa53ffc@kernel.org>
In-Reply-To: <20250331212337.3e9e4a5c50f5d3f16a95b120@kernel.org>
References: <20250328183858.1417835-1-bmasney@redhat.com>
	<20250331212337.3e9e4a5c50f5d3f16a95b120@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 21:23:37 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 28 Mar 2025 14:38:56 -0400
> Brian Masney <bmasney@redhat.com> wrote:
> 
> > Allow the user to override the CFLAGS and LDFLAGS similar to what's
> > currently done on other kernel tools. These changes allows bootconfig to
> > be compiled with the hardened compiler and linker flags.
> > 
> > Brian Masney (2):
> >   tools/bootconfig: allow overriding CFLAGS assignment
> >   tools/bootconfig: specify LDFLAGS as an argument to CC
> > 
> 
> Both looks good to me. Let me pick those up.
> 

Sorry, somehow I missed these patches. I confirmed

tools/bootconfig$ make LDFLAGS=-static

passed the tests and it is statically linked! :)

tools/bootconfig$ file bootconfig 
bootconfig: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux), statically linked, BuildID[sha1]=88323308c8d2cc45d1985ef94751bfd60199b32b, for GNU/Linux 3.2.0, with debug_info, not stripped


Thanks!

> Thanks!
> 
> >  tools/bootconfig/Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.47.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
