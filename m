Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01395FF03;
	Wed, 14 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927655; cv=none; b=BTITpPxAkqGfwD2lg9S3nvtxWPovPwF8iJWfZxFIJ2I90T4eGNxDQDMtZdk9jLT7LwmEMdmEKahplagJOZd7JHuTNiaVIwKXbDRT92RSaAUUeM8RpOGfv2xB6Ko8GM9Z/xEF9sdVXV5Cq0vUdG3/fQ3sxxFO8m++4fN2UC7sINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927655; c=relaxed/simple;
	bh=UYB+HoT6dXR3Q4alz/s7RxFLW6sCTSYU0ADxHCZfdsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeFoqRhWwIVkectvoks089USgU81wtzebWXap0eU0nxo1+jG13MQVKryeMaArN1cQuoqyIXPOyHqawQbMrylFJBnFqxOMxr6QUi90XTF2OKGvYPJFeKk1+4ic2NzVmnFGj0eDL+RFCNlkZRJiyZHskJkzOIRA1Ws/8NSkc6i9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0D7C433C7;
	Wed, 14 Feb 2024 16:20:54 +0000 (UTC)
Date: Wed, 14 Feb 2024 11:22:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jeff Johnson
 <quic_jjohnson@quicinc.com>
Subject: Re: [regression] tracing: kmemleak warning in
 allocate_cmdlines_buffer()
Message-ID: <20240214112225.088484da@gandalf.local.home>
In-Reply-To: <87mss3njvj.fsf@kernel.org>
References: <87r0hfnr9r.fsf@kernel.org>
	<20240214094617.1e6ec684@gandalf.local.home>
	<87mss3njvj.fsf@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 17:30:40 +0200
Kalle Valo <kvalo@kernel.org> wrote:

> Although the patch didn't apply for me as in my tree the functions are
> in kernel/trace/trace.c. I don't know what happened so as a quick hack I
> just manually added the three lines to my version of trace.c. Let me
> know if there's a git tree or branch you would like me to test, I can do
> that easily.

I sent out a v2 that should apply and I added your Tested-by tag. But you
may want to verify that it does indeed still work, as I decided to swap the
order of adding kmemleak_alloc() with the memset(), so it's not exactly the
same.

Thanks,

-- Steve
