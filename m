Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3747FBDA;
	Fri, 31 May 2024 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140299; cv=none; b=HCrYWVa183QucSZ+aYWYZyRYord2YCPxqqjX7A4NO2RUSfhTCGywnApZORqNmesVMhMfBqCBbHVbfbWqC4h8MA8A3EiP7jMqnPayqZf4vjxGEZbcZyDy1yen82SRlGbs9QBkGRmMOxVh/zWlmw8SPSXSqMYV4692sXb///61O6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140299; c=relaxed/simple;
	bh=V35cqtk9XTo/2IpnTDToiE7mqkZ1wlRTu8Z37svt7cY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZSMfJrImO7zOWu57pX7a726Cbm3DSRupxXpRsQCKhIiKqvi8vIBRW5BRT9mXTFxd/LU/rVpWZEZLW4EfHF4HJ3UnCWWGwE9GOmJiRX/cD+NdNi03fJ8lAcbtTijSWriTe8yH448T/FI3JTGJ9zVLsCyMz61EEVoxVIY46uregs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C7CC116B1;
	Fri, 31 May 2024 07:24:57 +0000 (UTC)
Date: Fri, 31 May 2024 03:24:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-ID: <20240531032425.3635dc93@rorschach.local.home>
In-Reply-To: <20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 11:37:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> So, in summary, it is designed to be a module. Steve, I think these tests
> should be kept as modules. There are many reason to do so.
> 
>  - This test is designed to be used as module.
>  - This can conflict with other boot time selftest if it is embedded.
>  - We can make these tests and boot time selftest mutable exclusive but
>    if we make these tests as modules, we can build and run both tests
>    safely.
>  - Embedding these tests leave new events when the kernel boot, which
>    user must be cleaned up by manual.
> 
> What would you think?

I was mostly following what Ingo told me long ago, where having it
built in is just one more way to test it ;-)

But that said, from your first patch, you show the stack dump and
mention:

> Since the kprobes and synth event generation tests adds and enable
> generated events in init_module() and delete it in exit_module(),
> if we make it as built-in, those events are left in kernel and cause
> kprobe event self-test failure.

But you don't explain what exactly the conflict is. What about those
events causes kprobe selftests to fail?


-- Steve
