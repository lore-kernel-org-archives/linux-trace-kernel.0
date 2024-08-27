Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B519D88B;
	Tue, 27 Aug 2024 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759579; cv=none; b=qrq69gpkCCjkROXZmSvnBmdTgROE3dm12CcuWcbSC61JraqEYF+PCJQqf+VBN510TUWZuIJ5nFGL4N5moty5x9xPa24zT5jDwyyMH7LhFhKClle7GJBMYUdiZQaDv6dt2gqK3U4daTDD2cvtQMdh8npaM/x+J54SXAwP0GQMKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759579; c=relaxed/simple;
	bh=DFWIEmoK+/fqJ5NdqkTGlRn2iJT4TOA+yIeHbCFUelY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAF1esc1X4Hzbh5fbrtaeAOt1GQBE3mW+JXEAAAoO89mEWdJsJyQ3FTWx43DtvUQE1Az916eT2d8THbnrhh9yr8PtLw11K4gDemDNiDQuwWsuAFze86U9C9PjdTqVEpsDiYLCMzY9Ya/NwQjoRy8msC3VwazNDXADmO1+zEZU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7613FC51E5C;
	Tue, 27 Aug 2024 11:52:53 +0000 (UTC)
Date: Tue, 27 Aug 2024 07:52:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Mitigate possible softlockup in
 __tracing_open()
Message-ID: <20240827075241.5cd652ae@rorschach.local.home>
In-Reply-To: <d3c2ecfd-6590-dc17-4ea5-d80872d01016@huaweicloud.com>
References: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
	<20240826103522.390faa85@gandalf.local.home>
	<d3c2ecfd-6590-dc17-4ea5-d80872d01016@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 09:29:55 +0800
Zheng Yejian <zhengyejian@huaweicloud.com> wrote:

 
> > This is the wrong place to put this. If the problem is with
> > tracing_iter_reset(), then add it there.
> > 
> > 	while (ring_buffer_iter_peek(buf_iter, &ts)) {
> > 		if (ts >= iter->array_buffer->time_start)
> > 			break;
> > 		entries++;
> > 		ring_buffer_iter_advance(buf_iter);
> > 		/* This could be a big loop */
> > 		cond_resched();  
> 
> Do resched check every event peek, I'm afraid there will
> be too many 're-schedule'.

cond_resched() as the name suggests only schedules conditionally if
NEED_RESCHED is set. This isn't a fast path (obviously, as it requires
a cond_resched).

-- Steve
