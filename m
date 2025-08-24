Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40C2737E6;
	Sun, 24 Aug 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756043088; cv=none; b=JRUOJ4EnSPiEKgbmlwVT3e3+bpoaVbNJlFuB/X3FhTAo94kiv9haZ3mxX8Qgzr0cDDB5lFML1ctYBZuTQmR4TOlhEZ1CL9yvkKI5WeRPwNV9+sHmD00tVf7pf9sllqe+h4nnetw7Ze8NQ+Z8t/lwMpMfXssQSwT1E1oytaFw/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756043088; c=relaxed/simple;
	bh=lqMJ5yd3r9xmUYokxKE+QAgIXxKUod3pGT7ousJijDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPzFo859xseH1jpzY1V5L/GkcpDZn+dy5MyLI3bqGTkQwU1JZmerbGeAFsh8g8OQ1L4X5+sJ8d8QmK96g4rYNyCpDzuFjTaiwonzANPNyLSdApy1mJ+7lQlflPtgnkqeaM6q1sxFy0RYQ4wxkOmxBEEh6vl8cjE4DSRGGH6uOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ggc0AYSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ggc0AYSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA2C4CEEB;
	Sun, 24 Aug 2025 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756043086;
	bh=lqMJ5yd3r9xmUYokxKE+QAgIXxKUod3pGT7ousJijDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ggc0AYSo+466AjM774D3VmGKqtFbpB2CG4c3U1bUw10xqrYQGgNq5LPuXWY1VE/0B
	 LcU5OYZCEmA1E9dWnKjuRD2e3kNnUd3HhGSxuLe8T8zcf+6RSyOJp3bso+n5X9V0rF
	 yql9y/XMsOJhfLKzLS+0vxE4O3ub3ITwCFGZMKGXHD5mmKi6qTKHCSQ0s1bqxvd7dR
	 vnyBP3m4mVL3/rIwOVj2nUhsx/Po8lXiCs4Ub8biTYCuL4ZICrnrcwVSzVv35p+FA1
	 dt7rdfPzN4UBWcSTFhSNyqRB7Q0bTUrrN1iRTZjX4EVenjAbRXpTlHCwLOrw/di7Ls
	 9BiY2kSpyavfA==
Date: Sun, 24 Aug 2025 16:44:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] init/main.c: fix boot time tracing crash
Message-ID: <aKsXRq3WQuQS-u6t@kernel.org>
References: <20250824130759.1732736-1-rppt@kernel.org>
 <20250824092150.0543aaa0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824092150.0543aaa0@gandalf.local.home>

On Sun, Aug 24, 2025 at 09:21:50AM -0400, Steven Rostedt wrote:
> On Sun, 24 Aug 2025 16:07:59 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > 
> > Fixes: 5d79c2be5081 ("x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace allocations")
> 
> Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20250820184743.0302a8b5@gandalf.local.home/

Yes, them :)
 
> -- Steve
> 

-- 
Sincerely yours,
Mike.
