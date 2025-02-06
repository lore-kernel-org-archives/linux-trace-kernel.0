Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EE15199C;
	Thu,  6 Feb 2025 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738801740; cv=none; b=UB5MbdFb4k+Mp25nHlv9XYjyIasS+bfnqEtHaUYVvWl6Cj0plhDDRMbS+b96uUmGhtm/bWAdPWBtbmBK3Z3OpiiT8G1uD95LeXejd3IKBzz036LI5cBBp0LM+z8K4VBVXI5pPNjRneyDtL9JGcP4uLe06Lf9zUEI/unzjNrzCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738801740; c=relaxed/simple;
	bh=LfdU6dfd/o6h8/7t4Zv4PI/+fJg+kTvuw8EKuAIygRE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fJC0uM00McXnvqWkgr67v54SZVfME/EWgmznLIt0FaytOTcD5/Cb9h/onM1zBbbQiE7jZxApyLFaOP8LaR/w/g4Yvk7ySA0BVKRylZJDUFfXVTGw6X8gJdE3hi5fX2/HdbI7PPKfDestcY7tYJZIRp6LcsDXeZl70YaQqZy0q1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERlLk0L/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERlLk0L/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96BEC4CED1;
	Thu,  6 Feb 2025 00:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738801739;
	bh=LfdU6dfd/o6h8/7t4Zv4PI/+fJg+kTvuw8EKuAIygRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERlLk0L/uSYb65s3+GEUZUhaKkZHYaSO8HrvH9H1vfYX0um0koUbMGxGgHFVzbfcj
	 EPi6vNc7/OaUUblveFvh+9CS/ZTKOgbo8/DtlPhJECHkBxFsh4givOb/4mS18sM7dC
	 RCeidqjwVy2DVzfVJCBGMzVOz1PkE/Oyf/JN9UYrjBCXGFz1uDqLakyGUa5qjVH8La
	 wG0/A4ZwTn6HhDqNX4BkCT0OJNnGWg0qpzBKLsKmbnrhNfnaEka93+qvEFld9A0Mzo
	 xKXzbYT6yUIvVvZpMcUzs6x6QnjafQVGmMwKytr45xVIwN5EHF3QN2GOd7/odINSl6
	 2UBeFiqTe645g==
Date: Thu, 6 Feb 2025 09:28:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 0/2] tracing: Introduce relative stacktrace
Message-Id: <20250206092855.6d313227cf5db2a1a96ac200@kernel.org>
In-Reply-To: <20250205175234.2c16671a@gandalf.local.home>
References: <173839458022.2009498.14495253908367838065.stgit@devnote2>
	<20250203103234.79c4a388@gandalf.local.home>
	<20250205212543.42bd11a8093a074e9df27670@kernel.org>
	<20250205095322.308234eb@gandalf.local.home>
	<20250205175234.2c16671a@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 17:52:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Feb 2025 09:53:22 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 5 Feb 2025 21:25:43 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > Anyway, let me try storing the module table.  
> > 
> > I have the module table code almost done. At least the recording of the
> > modules into persistent memory. Exposing and using it is not started yet. I
> > can send what I have and you can take it over if you want.
> 
> I finished what I was working on. Can you start with that? I can push this
> up to the ring-buffer/core branch. Although it's not fully tested.

Oops, I also worked on that. Anyway, let me check it.

Thanks!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
