Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867022CBC9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575015; cv=none; b=Bu17rC2OhSFWXD2vQLDhj0xPRCzjVQwDnWVdvz2CCkbAwm1Y7TJqJD8MfQe325KwHFgYvQVoNhccGByxLh7d60u9w1yRWNJo27cZcCVQq1f3If2293UFsNLxxnQVmS2sYeGvxqy517pkj9TstLNH8pW5d3zOXO5fr98AxzX6040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575015; c=relaxed/simple;
	bh=1of9Uk4n7biohAeTpjqwyk96pJt0YLg4fTWMMq2MQAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V08hHrZloT8ICVKdrtIb56voCqmiz1xu2TVt5nZUW8E+/eO56LafSYqa2Zf+hCXJ47Rk5Q6y78CUQMFnQscmyYbMt5Q6v4iYqMhjss8liqIayyUXfNR94f4Yr2iOntnGF38luCpql+PhGcTrBjJIyDBgcZyf02GAYi+ZbJuzHWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE81C4CEE8;
	Fri, 21 Mar 2025 16:36:53 +0000 (UTC)
Date: Fri, 21 Mar 2025 12:36:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Have persistent trace instances save module
 addresses
Message-ID: <20250321123650.5042267c@batman.local.home>
In-Reply-To: <20250321155422.GA1290637@mit.edu>
References: <20250321155422.GA1290637@mit.edu>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 11:54:22 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> On Wed, Mar 05, 2025 at 11:45:45AM -0500, Steven Rostedt wrote:
> > For trace instances that are mapped to persistent memory, have them use
> > the scratch area to save the currently loaded modules. This will allow
> > where the modules have been loaded on the next boot so that their
> > addresses can be deciphered by using where they were loaded previously.  
> 
> Hi,
> 
> When building against linux-next today, I found that this commit
> breaks builds when the kernel hasn't enabled CONFIG_MODULES.  Could
> you please take a look?
> 
> Many thanks!!
>

Yeah, Masami has a fix already. I've been traveling for OSPM and
haven't had the time to apply and test it.

-- Steve

  https://lore.kernel.org/all/174230515367.2909896.8132122175220657625.stgit@mhiramat.tok.corp.google.com/
