Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6818E351;
	Tue, 20 Aug 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724197728; cv=none; b=POUTZg4nLl6SzGkxZr/krhp0wD0AdlfgCQdUoBTmD8l2DTQ/V524OAd+wkp/0CfNnCygNs5qWCBwjkj9ECSS4tS/KJ31ZCJGuB3NOxikyoKS0QKOKOss/7fOV1KUJtBo09gQf0GZvxGGJ+Q/5+1L/VzxY9mgH9kwtweUgYsjuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724197728; c=relaxed/simple;
	bh=oCIIsNvmPIICxU6QNTqqfHLC5XBHenuWunM08Kcya60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvToPSbtf0cv9xZI7AAk97LnVGmBJZjJ4AZdCWSfPoJmf0/rRbklkU6iesK2geTpSMVNAU+Ogb9pmJym/BUTVG84Quq7S1Q/K2WdN9F5JVU6oBpvQScIILhAVe+tgUbZDapycBaln3J+PzKmDhim5TCeAt15fgUbx9oXRMPRwSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB53C4AF09;
	Tue, 20 Aug 2024 23:48:46 +0000 (UTC)
Date: Tue, 20 Aug 2024 19:49:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240820194914.2352a914@gandalf.local.home>
In-Reply-To: <20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
	<20240821070539.981b42e5f3b939c5ce5e3a71@kernel.org>
	<20240820181109.4203158d@gandalf.local.home>
	<20240821084351.4b1c9d4d52b5aa7e07681d69@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 08:43:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Can you add the __used and see if it fixes it?  
> 
> Adding __used to DYN_FTRACE_TEST_NAME() and DYN_FTRACE_TEST_NAME2() does
> not change, the test still fails.

OK, now that sounds like a bug in LTO itself.

-- Steve
