Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E81A8F60;
	Tue, 25 Mar 2025 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939243; cv=none; b=ULBwyu4lqxIoHlhbkFS/KqsR1t1a/bGEwA6dT6j8yKIGrKqgS6aHsRU9vLv/xDh/58fWnDgxuS7tIPn5c8vhCkbQ0s0ibNduNq9EHZbUrazv4rh9InhlZD+L3wvOD66vXA8nWP9RIQ61LQumHvh8xe2lwqPXel47bKtyH28N0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939243; c=relaxed/simple;
	bh=bbdGKpIZ8Zzhuv+k54qH/dpKkJXfG9auc4sCQPcqrR0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HPVrPjQKTqmombO883N4HDDuOXWsYEv3pMqpf86oKQoWMb3m7sTpH1MfQYP6cBCRwK+cghL+MiTQZRVxm/jZvtOhRZuran7Xfy54+HiZOtUIiuLBRkYSvlVbKC+PB96E7wg0JmgfdsI/QO2/qRgq9C07sGK4LAwMMmUn43+RIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmHz2xvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmHz2xvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B59C4CEE4;
	Tue, 25 Mar 2025 21:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939243;
	bh=bbdGKpIZ8Zzhuv+k54qH/dpKkJXfG9auc4sCQPcqrR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UmHz2xvfzPsdMZZqdQ7WFtdmOnniwWlctZELPWjQBrqE9Ly4YcJWUXDmkPJ3EsBEF
	 bfK78Zt4JqgW0OnCdXlhloSqKn0N/yAeN6X+Da0rwC/n3ynQMN/79s0etTqEPU5UVw
	 f6t9JnAhAchH+tVQTuQx/RVdr+3ThGSj+2AQK3Frnj4EteDiIE2e+fD2FiUG6Gfq+x
	 8EftLH6FVEuqA3ey5T9xxSBsphL9uWLDaJFXGAxLeaLJb4RWvD2Vc876voLWWjQCa1
	 iJW815jfeWr7XrFLhGHx8svUxxoABgvDrkir5UvbEG91DGgOYsomg7T/R6RyaywaLw
	 6rQbaC2kH+h5Q==
Date: Wed, 26 Mar 2025 06:47:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests: tracing: Enable fprobe events before
 checking enable_functions
Message-Id: <20250326064719.f63ed256e7ecd2bd6e9d426f@kernel.org>
In-Reply-To: <20250325144208.1149b51c@gandalf.local.home>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174212771234.348872.14455715715729686727.stgit@devnote2>
	<20250325144208.1149b51c@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 14:42:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 16 Mar 2025 21:21:52 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> 
> -ENOCHANGELOG
> 
> This still needs a description.

Oops, I forgot to add a description!

Thanks!

> 
> -- Steve
> 
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
