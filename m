Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D028DEF5;
	Tue, 15 Apr 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717501; cv=none; b=YjTXbBNKFArhx0VQL6ivhlsfiPwLjlC+2PW+LKiiesiZDpq9W9HO9TDRDKxN5GZ3u5yAJs0gpNt4+O8wuokbBwwXarjZ8yTrx7zdWmWyrq2HXUWmMzNdCW6mUfwVh8HhHaLf1UA45+9oJZvJQs77d5JfyRnjVQwdLiMwuTkN8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717501; c=relaxed/simple;
	bh=7JPX+2GYolK1KRD+y0abQNSxtm1R8tnluqSvHjMuoyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okBEsNm0tsDKbCcHDbRT0+y6g6rxiKOh1ZvZdfo31JA47eCQb9hHVnqlc7VyMUkhpbph4RQOow9Tdmo3Fm3ZfX/hNlJh9z/5l+YLbGOkKOoxGjzff38SAPT+B539uECXknpzs0uM5bc2EwkNdY/DuSdNXFuzrwT/xIYXauqQSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F4C4CEDD;
	Tue, 15 Apr 2025 11:45:00 +0000 (UTC)
Date: Tue, 15 Apr 2025 07:46:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jin Guo <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jin Guo <guoj17@chinatelecom.cn>
Subject: Re: [PATCH] ftrace: make ftrace_location() more accurate
Message-ID: <20250415074633.3cf7546d@gandalf.local.home>
In-Reply-To: <20250415112750.1477339-1-guoj17@chinatelecom.cn>
References: <20250415112750.1477339-1-guoj17@chinatelecom.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 19:27:50 +0800
Jin Guo <menglong8.dong@gmail.com> wrote:

> The function ftrace_location is used to lookup the ftrace location with an
> ip. However, the result that it returns can be wrong in some case.
> 
> Let's image that we have the following kallsyms:
> 
>   ffffffff812c35f0 T sys_ni_syscall
>   ffffffff812c38b0 W __pfx___x64_sys_io_pgetevents_time32
>   ffffffff812c38c0 W __x64_sys_io_pgetevents_time32

Have you tried the latest kernel? because on x86, weak functions that are
not used should no longer be in the ftrace table. That is, you should never
see __ftrace_invalid_addres_* anymore.

See https://lore.kernel.org/all/20250218195918.255228630@goodmis.org/

That was just added this merge window, which would make your patch obsolete.

-- Steve
