Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DC7347A;
	Wed,  5 Jun 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610695; cv=none; b=qw8bmOWz7d6WA8CNYGCnL3LmDNBMceX9UnEJ8YUAmXroH3zy9WzFh7SFCnmcYC7J3vlEYCFcYmFTzlH3FkzvnfBGIbI+LwGsaZ/u0dLV/uZ3JaPN3/oP9vXZzB8If19eD/N3PVJdY74JYv8SCbe89UAOW5dowiAVewCBb0cBG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610695; c=relaxed/simple;
	bh=EwronXBW71M61WKlYINkIFLMDKf8/K6XHuj6hhf2t+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO2Nm7sYY43hNXLQ3voojzt17cG31nT/hejWdTrmAicmFe7TeGpRihe8qno+u6IDSkmG/E5DNHcShTsABfgx+AJb80ZHrb4OgBXjge0Kxr1QT5KyUsM8PkA9C/kfgdZ+/ffFdHzSFJvITsISNWZYxzpG6/v7A7VKhYfmNSuPWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21751C2BD11;
	Wed,  5 Jun 2024 18:04:54 +0000 (UTC)
Date: Wed, 5 Jun 2024 14:05:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] ftrace: Remove "filter_hash" parameter from
 ftrace_hash_rec_disable/enable()
Message-ID: <20240605140503.3b385ab1@rorschach.local.home>
In-Reply-To: <ZmA7OwmLw4QSt5uf@J2N7QTR9R3>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.883675803@goodmis.org>
	<ZmA7OwmLw4QSt5uf@J2N7QTR9R3>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 11:17:31 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Jun 04, 2024 at 05:28:20PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The functions ftrace_hash_rec_disable() and ftrace_hash_rec_enable()
> > always has 1 passed to its "ftrace_hash" parameter. Remove the parameter
> > and pass in true to __ftrace_hash_rec_update().
> > 
> > Also add some comments to both those functions explaining what they do.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Looks good to me.
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

I removed your Ack from v2 as it changed enough that I believe it
requires a new Ack.

-- Steve
