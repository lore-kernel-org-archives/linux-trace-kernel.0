Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0067E567;
	Wed,  5 Jun 2024 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624459; cv=none; b=Ah3VVL3+1evzpY/45HPyLfrgBjG1AA8PxfjWPlJIgbjd3kZ55Y0lDI9/YRnfVf9AhT+/pQzDg0ULbv2GUIyjPEJMFMkrR4mnl8+7Nd3Eix6eRbekSulpU7M/4BCSBkFdFC2uuXuRbru7D/lu9OgFCYVG6MI3aAUWZcQR0yhVZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624459; c=relaxed/simple;
	bh=sPI6gUytCUQdUO8231L+OuoK8oZqXVA7yuHa2PeTVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFX2cMXXV6E9B0E7LPJ8PNJua2LQO+sXqDmS7PEo9SdXXttsqPgGDvfzfp7wHZID/VlIHc6j/kVGiwzj21nXYNoCX9Ni4hjl+sbmU05vPc+cTz7wwQrfooZlCA+IthAgt7WE2E+2+4LjqKu+f/riuy00Qd9gvFwpEQXACdzuNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C118FC2BD11;
	Wed,  5 Jun 2024 21:54:18 +0000 (UTC)
Date: Wed, 5 Jun 2024 17:54:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] ftrace: Remove "filter_hash" parameter from
 ftrace_hash_rec_disable/enable()
Message-ID: <20240605175428.1a07acbe@rorschach.local.home>
In-Reply-To: <20240606065018.0bf1d82a3bf9c526aee9a170@kernel.org>
References: <20240604212817.384103202@goodmis.org>
	<20240604212854.883675803@goodmis.org>
	<20240606065018.0bf1d82a3bf9c526aee9a170@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 06:50:18 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 04 Jun 2024 17:28:20 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The functions ftrace_hash_rec_disable() and ftrace_hash_rec_enable()
> > always has 1 passed to its "ftrace_hash" parameter. Remove the parameter
> > and pass in true to __ftrace_hash_rec_update().
> > 
> > Also add some comments to both those functions explaining what they do.
> >   
> 
> Looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks Masami, but I sent out a v2. Could you review those patches
instead?

https://lore.kernel.org/all/20240605180334.090848865@goodmis.org/

-- Steve
