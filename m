Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799B1E32A3;
	Mon, 31 Mar 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423823; cv=none; b=hKtpJB+TvQDXP4AJKXdPSkEWaEMvdjljREp/dpOVxNUeDnB4vwg/im4ki0PQEU5MBcPAKWLtz4iPVdbpnhAk+R3anANZwf8L3YeGyoaHjP/RHuekp2u8LFHYQAFBQCupxCu0HZ0yrUKE2DQUKkzIGHTIjloqSKPWvWjHqi9OUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423823; c=relaxed/simple;
	bh=mk08bQi7oAvb4CjdeBzWQKC/iPCDoQmDNgmxnk+Bdhg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lECgUX5tu9knLt2FlR5aQ/2+KkmRngS+lQ03S5nZPCNqP20absDupSUO0VptYQsyvdLtyCHBMQiG3uCO+GAJixLzflkKAQOhq1lFb/9UubuxvLydUwptf6JBmiOK85j9AGgIV0KL263EPBnkOvVDLCznVsW0qVLQHOmBWlPWBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AavBOCrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AavBOCrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE58FC4CEE3;
	Mon, 31 Mar 2025 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423822;
	bh=mk08bQi7oAvb4CjdeBzWQKC/iPCDoQmDNgmxnk+Bdhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AavBOCrty/NkMy1yF1lq2/E5BFrj8LLFvrYNwVI0RFpwvmJ4X5bq1+41189Rt7+kY
	 66MppxJDtuKU5+ctmLwFDd1cqLIqfZ6M8QU6m7y6z2MazWPrMlZpqjZw9Y4QVdHWXi
	 ako2wn8tqCFhEsH/6+jau68O9I2MKM1OyfArI1josJKeyOqQwvVo9v4n0MsqhsS7HG
	 nYseLIooXuj1o8obu6RsVQj3yyFUgnFAx8ihM6b7oUlYG08T52vMWrXFw527ARu4CI
	 UcskJghq1+P3Jl9gyvQr/7iyR6CUdXLeFLx1YAyDG7D8560jMuIZyFb9aa3MHLvSPm
	 IOLSuRs4x0a6w==
Date: Mon, 31 Mar 2025 21:23:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 aruiz@redhat.com
Subject: Re: [PATCH 0/2] tools/bootconfig: allow overriding CFLAGS and
 LDFLAGS
Message-Id: <20250331212337.3e9e4a5c50f5d3f16a95b120@kernel.org>
In-Reply-To: <20250328183858.1417835-1-bmasney@redhat.com>
References: <20250328183858.1417835-1-bmasney@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 14:38:56 -0400
Brian Masney <bmasney@redhat.com> wrote:

> Allow the user to override the CFLAGS and LDFLAGS similar to what's
> currently done on other kernel tools. These changes allows bootconfig to
> be compiled with the hardened compiler and linker flags.
> 
> Brian Masney (2):
>   tools/bootconfig: allow overriding CFLAGS assignment
>   tools/bootconfig: specify LDFLAGS as an argument to CC
> 

Both looks good to me. Let me pick those up.

Thanks!

>  tools/bootconfig/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.47.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
