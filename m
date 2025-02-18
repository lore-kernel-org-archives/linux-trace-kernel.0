Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40401DA109;
	Tue, 18 Feb 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914161; cv=none; b=ZF551/aMlmOPfs8pr8rBtpp0n6HLTblH1adoKQ8Pj5IZP70zn7yWehih4vlYwDbPqr6cBYAk2W3W4Td84aI2Fl0tMHgVpo92g1FLVSOUzpcpxjUGULdO+wPC6vkHlKRVDre+jEoPXUqLSjb+AH8Aft3Z7YlreDTqVQYTxZLINpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914161; c=relaxed/simple;
	bh=742eb8tJQvj6DrFiZoD4vx3trd5C86nCyfRqwdt5PgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jfp7524W0yircMUyDQ8A+6F/dI0xl0LjcgrlmKR8ZQZWv6DFs319LqmZtJiJRBQ2ryyDacRpXUvTp8SJjUiUxDEfbo37PhH8hc1mdJg2NH/wVl1FNioCveLd6buhqSoVAKSeyfsZtUlJQKVnFS59KCEmmHKJskLbKB6BekzBTB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BECBC4CEE2;
	Tue, 18 Feb 2025 21:29:19 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:29:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <20250218162942.5267a002@gandalf.local.home>
In-Reply-To: <Z7T50DxEL7NYkr8H@bombadil.infradead.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.760856859@goodmis.org>
	<20250206142817.91853f475c681bc2ef7ca962@kernel.org>
	<20250206102720.0fd57129@gandalf.local.home>
	<20250214173017.07b0b250@gandalf.local.home>
	<Z7T50DxEL7NYkr8H@bombadil.infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:21:20 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:


> > Luis,
> > 
> > Is this patch OK, and also is there any plan to move the module code to
> > using just rcu_read_lock instead of preempt_disable?  
> 
> The patch is not OK, you're looking at old code, look at
> modules-next and as Petr suggested look at Sebastian's recently
> merged work.
> 
> git remote add korg-modules git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

Ha! Some how I missed seeing the two replies from Petr and Sebastian!

Not sure how that happened.  Something may be going wacky with claws-mail. :-/

Thanks for pointing them out. I'll definitely take a look.

-- Steve

