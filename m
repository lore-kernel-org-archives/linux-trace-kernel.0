Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91CB1FA243;
	Fri, 14 Mar 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956120; cv=none; b=nhq/PaIw/nhDWb+CW6xEpdvDcjSrGr/V23REToo3PTt+YzVWq7AuIkMCBtJ4eMO+I7cosMthgDGuu5st/Mv0hMki7O6nhv8fEwjQANeehRBAz6rGa7oeXek5e2dwNkdkI4k8hDRUsF2It9DPD5RxwSqBxA6d3PcjR0p8cD8SvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956120; c=relaxed/simple;
	bh=eb8PRZSa+Q6UlOskjlqOXZMi7tv3nKrTXtWPr/Ifakc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L111WdXTgxKs+xfjCz0VykarG2B7YOUX5fatTjYC79D2c4Pia3rJ7ihYBqXgYi8Ddqf3gT81P1S5oDXxd/+lVzpLVAu810b/rf75jwJVS405c7uEQ1+FkcvhZpcMpsknXK6/KUb9lLhKWKdDBUTQGa9V1NnlzWZEDjKvOyASZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67510C4CEE3;
	Fri, 14 Mar 2025 12:41:58 +0000 (UTC)
Date: Fri, 14 Mar 2025 08:41:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] docs: tracing: Reduce maxdepth in index
 documentation
Message-ID: <20250314084155.20c3e662@batman.local.home>
In-Reply-To: <b1882a1f-3ed0-4307-8a34-3236bdfb79a6@gmail.com>
References: <20250312124717.7208-1-purvayeshi550@gmail.com>
	<20250312134907.06d27d78@batman.local.home>
	<Z9JKqVvG1iw0bFXR@archie.me>
	<20250313070457.647c8c57@batman.local.home>
	<4cc0a072-3eaf-4fbf-a334-012aacf9039f@gmail.com>
	<b1882a1f-3ed0-4307-8a34-3236bdfb79a6@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 14:26:37 +0530
Purva Yeshi <purvayeshi550@gmail.com> wrote:

> Thanks for the reference. I will keep this in mind for future patch 
> series and include a cover letter.

Note, a cover letter isn't really necessary here. Why? because these
are pretty much two agnostic patches. One fixes the maxdepth, the other
is changing the layout for readability.

Cover letters are best when there's a bigger picture being had. That
is, the patch series is set out to accomplish a single goal that is
broken up into little steps. A cover letter explains what the goal is
and why and how. Each patch after that explains what that patch is
doing (why and how), but from the focus of that particular change.

As these patches could theoretically be sent as two separate patches
and not as a series as they don't really share the same goal, a cover
letter's only purpose here would be to make the email thread look a
little nicer ;-)  But that's about it.

-- Steve
