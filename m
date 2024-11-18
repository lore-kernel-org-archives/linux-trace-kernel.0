Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4814F9CF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958455; cv=none; b=nCELIg+VfAQ2wG1cPHHt+wQx5kYWYxd7WKSI4nHwyG5eXYzwP2U3VKi1MdjJM0EFbjWKbMztzNM3o92qos0YdHh4i2DJUTmuVBaEp174bvkXTLt38COBb0Ri4WsOY7FLsiYA8BKCMcx0I1mPO1OstSAXwYZhuL8vme816VIvaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958455; c=relaxed/simple;
	bh=oGbCDw7S6bKv8zkO5iZA4/jld0OQsewzlRya8OA+goE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPkCUwyt2Sf0jclOTIomewMrr/TtuwJKIe7YSeQyvkr27nuK2pQIYar/OeSMk9JmOgm+NC0QMNnYaCqNx4Ma0mEEf6nlwDR71WxJ877eG71pwWNt/An1PKbbJ9mawwDrPvKbJx6DiEQ5V+L9f4Mjoy3TqsubaLT4VEry6k8BOpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AC0C4CECC;
	Mon, 18 Nov 2024 19:34:14 +0000 (UTC)
Date: Mon, 18 Nov 2024 14:34:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: furkanonder <furkanonder@protonmail.com>
Cc: "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "jkacur@redhat.com"
 <jkacur@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH 1/3] tools/rtla: Improve code readability in
 timerlat_load.py
Message-ID: <20241118143445.4ef55735@gandalf.local.home>
In-Reply-To: <j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com>
References: <j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 15:09:49 +0000
furkanonder <furkanonder@protonmail.com> wrote:

> The enhancements made to timerlat_load.py are intended to improve the
> script's robustness and readability.
> 
> Summary of the changes:
> - Unnecessary semicolons at the end of lines have been removed.
> - Parentheses surrounding the if statement checking args.prio have been
> eliminated.
> - String concatenation for constructing timerlat_path has been replaced
> with an f-string.
> - Spacing in a multiplication expression has been adjusted for improved
> clarity.
> 
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>

BTW, should tools/tracing/rtla/sample/timerlat_load.py be executable?

 chmod +x tools/tracing/rtla/sample/timerlat_load.py

?

If so, I can write a patch to update that.

-- Steve
