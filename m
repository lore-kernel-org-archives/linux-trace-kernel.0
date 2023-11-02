Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CD20B04
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YZDFWC5H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8EDC433C8;
	Thu,  2 Nov 2023 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698947701;
	bh=eNyLiJ3uo1qygaTV2uokhL8xwomApdjRSSf10+Tj/YQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZDFWC5H4kixNGUF57cNRaMtENJ2kqLaJkHV43fFry6fzZ4nmq4Q2PVYL19DnCI+o
	 RYTgiNXtSMhPwmF3+eCRUPQKYH7m6r3JywxDzUc6bTVCSh+bXQfUXnCcC6PEa2oN5N
	 eHay9OqUfxVSkZpuolKrkLY0RcR8PuKDWXInB+FQ=
Date: Thu, 2 Nov 2023 18:54:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-stable <stable@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: stable-rc: 5.15 - all builds failed - ld.lld: error: undefined
 symbol: kallsyms_on_each_symbol
Message-ID: <2023110251-animal-onset-3b21@gregkh>
References: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuFUTr+riZ5bREOowR_QsspR9n_UC4pLCJQGxksU46M2Q@mail.gmail.com>

On Wed, Nov 01, 2023 at 08:54:56PM +0530, Naresh Kamboju wrote:
> Hi Greg,
> 
> I see the following build warning / errors everywhere on stable-rc 5.15 branch.
> 
> ld.lld: error: undefined symbol: kallsyms_on_each_symbol
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(create_local_trace_kprobe) in archive kernel/built-in.a
> >>> referenced by trace_kprobe.c
> >>>               trace/trace_kprobe.o:(__trace_kprobe_create) in archive kernel/built-in.a
> make[1]: *** [Makefile:1227: vmlinux] Error 1
> 
> Links,
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2XXALLRIZaXJVcqhff4ZmGTeZoQ/
> 
> - Naresh

Offending commit now dropped, thanks.

greg k-h
