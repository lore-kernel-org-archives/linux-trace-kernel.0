Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953519D07E;
	Tue, 28 Jul 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242811; cv=none; b=Xr/RGAuKw1qZyqsyGa86owjBxgpKA6K+c0j/6dRcQYL/u2FudrdvlZHAQMhSWPAC876wILKaxj1jF62xpbjeiPcz02CNSuSbl19afB3y7nufBjD1C88/gaGt8/5ziifj+CBwrgWWDkuBGRo08r+jIPONV2w7JPgNWtEiQPntiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242811; c=relaxed/simple;
	bh=uCZpmYk207Jbp54JCVb5Z0Xii4lmAoRj6pOYsFqcKE4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NN/xPKIXYrAh97Td8vSY4V/MjvvhnVKcpq3U5YHQ/RK5P7pwPeAsn/DnpkTX3l+IDfM1mOoZeLMccor5Sf8I1KIqUtPySJ8ee98q6V93HwTsMjmIyii1XadFrYJpAh5SmqRvFERhWD5lS1hwWfeFPSMnDIXKmYThySVGBwn2d3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVmyEFh7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVmyEFh7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB881F000E9;
	Tue, 28 Jul 2026 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785242809;
	bh=McNxHSSYNzMl8Vl+JpPitIZPv9zhoae7OwY1F8bSqeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mVmyEFh7QAF3fSTmTFpE6y6d8UCjHloT8fSSgHXacdWTZE3xrADeYmeINQMaPYTis
	 ijWF9VK4fNAozfUNiaPERjj9+osCw3/U28SwB82DDlwIUdrUGDrS50NNgAFRkIlck9
	 tJlYW35PcG90g2LBmg9bfYH1Ih+zgdLo52SeenjyMR9CsEHAPm+LvmLQOezAN0Gre6
	 J+cYxgELPngUHYERhU+GLXz7QURXyCL1k8MHxDE+pdBHnP74ok3V14X1vJwcjcOZ9d
	 7I4z8830VlZMSbC73/KuExkTXfEi79SzGHWXr7FUItRqJTwr+TCKoupReCGTRTUzF2
	 26SZPylOy4c5w==
Date: Tue, 28 Jul 2026 21:46:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: fprobe: fix 'thos' spelling
Message-Id: <20260728214645.1e0584e6e654bea696294662@kernel.org>
In-Reply-To: <20260726065633.20897-1-shaikhkamal2012@gmail.com>
References: <20260726065633.20897-1-shaikhkamal2012@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 12:26:33 +0530
"shaikh.kamal" <shaikhkamal2012@gmail.com> wrote:

> Fix spelling error reported by codespell: thos -> those.
> No functional change.
> 

OK, let me pick it up.

Thanks!

> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
> ---
>  Documentation/trace/fprobe.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> index 95998b189ae3..46dd46a97c1f 100644
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -118,7 +118,7 @@ will be cancelled.
>  @fregs
>          This is the `ftrace_regs` data structure at the entry and exit. This
>          includes the function parameters, or the return values. So user can
> -        access thos values via appropriate `ftrace_regs_*` APIs.
> +        access those values via appropriate `ftrace_regs_*` APIs.
>  
>  @entry_data
>          This is a local storage to share the data between entry and exit handlers.
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
