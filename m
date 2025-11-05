Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954122D0631;
	Wed,  5 Nov 2025 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383982; cv=none; b=EcgfClwabjmisAMi9YJQuvIKlOZZLhkb04m+v8GpYMZugzAROAfJeXVp2DDUsPp83UGjjDu1/fc33ZEDUKPU5OkQVWrqxGhH2zVc/PcZMkj1ymKVO636huOl1P3yKmVCuJO1yBgIJddcij9BvVELfM3+VMEBlCl6Vr4C1sDScZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383982; c=relaxed/simple;
	bh=xjJJrRt/+YaNT/AFTKVY7ybcWTD2NtqQCre1H1sURRQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OraU26C+wObOJ9NX9U8W5bLIh8FRQSc9aDou4DjLufNg1ir4z5SibUUaOL1T3FApf0jRDvxPgewTdKMe0YnHq75gnl6GoLbdYNKezQ9/HDwvWJd1JafIBZg5AqWsU6JYfagbS6IM9R5e0FEHR99uHSS/VCGbsQM1T/EcUpi4VeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy0PAjcw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy0PAjcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B5C4CEF5;
	Wed,  5 Nov 2025 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383981;
	bh=xjJJrRt/+YaNT/AFTKVY7ybcWTD2NtqQCre1H1sURRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iy0PAjcwB/iUQJOaIA2ZxK3STWDIHc2MJBw0VBufU9PN6mLNVikWgwHJvlrtrK5yI
	 CSAqf0wOfV/dgcKIZMnYDfKeTdyLJHj38NXmiI5b/pHTdSFYzzHfCHOn32b55zqG5H
	 BJ6DLDqbT8JNB+s9dVaiqAW2f9NetuTMykGYboYHAuNzBA9ukHC/bY0lDpmVO0J8/9
	 Z8sXAjeSYpR9NUhVS4jswVHaSD+qOhqhdW3050yCp15IdIh6HKqxzV1y4jAHgF5dsu
	 b7kf608Z/J8s6IGX/iqyKQj3HLNRef3fUKuRr/0+mSib78U7htsMHVcCCCTQExrImA
	 deSl9jBxyzz2w==
Date: Thu, 6 Nov 2025 08:06:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add tracepoint core-api doc files to
 TRACING
Message-Id: <20251106080616.a46ca1c46b4034ce9757e5c9@kernel.org>
In-Reply-To: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
References: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 10:24:28 +0100
Lukas Bulwahn <lbulwahn@redhat.com> wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> The files in Documentation/core-api/ are by virtue of their top-level
> directory part of the Documentation section in MAINTAINERS. Each file in
> Documentation/core-api/ should however also have a further section in
> MAINTAINERS it belongs to, which fits to the technical area of the
> documented API in that file.
> 
> The tracepoint.rst provides some explanation to tracepoints defined in
> selected files under include/trace/events/, which itself is part of the
> TRACING section.
> 
> So, add this core-api document to TRACING.
> 

Yeah, that should be maintained by us.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 499b52d7793f..297358d26bbb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26197,6 +26197,7 @@ L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> +F:	Documentation/core-api/tracepoint.rst
>  F:	Documentation/trace/*
>  F:	fs/tracefs/
>  F:	include/linux/trace*.h
> -- 
> 2.51.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
