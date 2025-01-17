Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1BD25A63B;
	Fri, 17 Jan 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737074068; cv=none; b=qeRWNMl5ILLMj9aA1a5dM6wmDZPbO/hK1ztRkD0N1Hxu8uZVJsMrm+JQQ5U9pb0nIODSGVy1iNgLxH7HmJUsXwqG8r1tvfRaT5md43O1nzCyNVm7S9GrIa1TpE+Fs6KQ0xxZUh9JxkRCCBPjjscUx/ZiVlZuuBWqAzYYU2H65yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737074068; c=relaxed/simple;
	bh=pBC6LTvwhZ9x5a5IykCIMIgDPi7WijFDF73IP1E4cr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S49e1GMfqYYrHHhYdLqOyu0qTVMQkIJG1ZOh2fKI0z7jMCVBaX7RDr7fJLAR7gJW4Mh60Rarl4lbnLdEmy41c3PSU9PTO/9B8FAAbUaRvW48CT/U6NPN9mJlX7DHT5UExgl35/BncaaPMLIPrh8FyiomjcWMdVPC6rWiLyNxUxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1322C4CED6;
	Fri, 17 Jan 2025 00:34:26 +0000 (UTC)
Date: Thu, 16 Jan 2025 19:34:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tools/rtla: Add osnoise_trace_is_off()
Message-ID: <20250116193432.716db3a2@gandalf.local.home>
In-Reply-To: <099e9ae9-5d36-46bb-8790-1b6a33dc1448@stanley.mountain>
References: <20250115180055.2136815-1-costa.shul@redhat.com>
	<099e9ae9-5d36-46bb-8790-1b6a33dc1448@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 21:40:40 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Jan 15, 2025 at 07:58:30PM +0200, Costa Shulyupin wrote:
> > The original code accidentally works because offset of
> > `record->trace` is zero.  
> 
> It doesn't "accidentally work".  The people who write this kind of
> code 100% understand what they are doing.  They don't see it as
> anything complicated.

I'm taking this patch but I replaced the change log with the following text:

    tools/rtla: Add osnoise_trace_is_off()
    
    All of the users of trace_is_off() passes in &record->trace as the second
    parameter, where record is a pointer to a struct osnoise_tool. This record
    could be NULL and there is a hidden dependency that the trace field is the
    first field to allow &record->trace to work with a NULL record pointer.
    
    In order to make this code a bit more robust, as record shouldn't be
    dereferenced if it is NULL, even if the code does work, create a new
    function called osnoise_trace_is_off() that takes the pointer to a
    struct osnoise_tool as its second parameter. This way it can properly test
    if it is NULL before it dereferences it.
    
    The old function trace_is_off() is removed and the function
    osnoise_trace_is_off() is added into osnoise.c which is what the
    struct osnoise_tool is associated with.


-- Steve
