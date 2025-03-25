Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AFDDA9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926731; cv=none; b=FSoml5gbL+KW2iQi4U8Ur5JOIg15CqCq/Vb/naEuRr2Prw1E+7JCfpZHbylmF4d/3CK/ByznklOObPsS3qysFA89iNwY7yCTerFCMN1rQilhmFAbb3NoxcKWNqsFVwxo23sR/8jJfdVSIRYFYlA59Na2FNgqvDPacEvbgWk5ixM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926731; c=relaxed/simple;
	bh=9hQSnvvFtfrZ12xytdBmJSS7NL6Us9HAGVmiLZ3wIIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbbybqi3jBMZOV5QroeckB0s0GUZHCPCC+vGwo+/PlTyWhAVIxjiPddBFVN5RhQF8uwW8RiknsFWZUirgyVh1KZYt1gZ6Hkvk88XLu2zk5C51rvf6470Lpp3UpNvpgXSzv8lwP5WJyNN7Wnvn2urfFcQVTnwBFs2fLKKQ1HrsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC7C4CEE4;
	Tue, 25 Mar 2025 18:18:49 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:19:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: gregkh@linuxfoundation.org, linux-trace-kernel@vger.kernel.org, Kevin
 Mitchell <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20250325141933.222e7349@gandalf.local.home>
In-Reply-To: <CABEuK15DRcNDj4Gscw3xuonJ5uCrqb34qB-+MzyAmxZn=h_X=Q@mail.gmail.com>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
	<20250324133619.6c3babf7@gandalf.local.home>
	<CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
	<2025032424-custard-volley-bbb6@gregkh>
	<20250324150703.69665622@gandalf.local.home>
	<2025032548-happily-saxophone-4079@gregkh>
	<20250325081551.270947fe@gandalf.local.home>
	<CABEuK14t7XR5Oi7kD13AHt-cQ8nc+mM8kojMkSh_WXbbNZbcyw@mail.gmail.com>
	<20250325140223.534df027@gandalf.local.home>
	<CABEuK15DRcNDj4Gscw3xuonJ5uCrqb34qB-+MzyAmxZn=h_X=Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 13:10:17 -0500
Sahil Gupta <s.gupta@arista.com> wrote:

> That sounds good to me. I didn't use CONFIG_FTRACE_SORT_STARTUP_TEST,
> but I manually verified the section was sorted by checking the ELF
> using a Python script. Maybe that is something we can consider adding
> as a build step in the future?

Note, that config only enables the runtime verification. Which means you
need to run the kernel for the check if it worked. It is not a build time
feature. And since it checks at run time, it does add a small overhead (to
iterate all functions), where you may not want it enabled in production.

-- Steve
