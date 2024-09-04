Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F181DB949;
	Wed,  4 Sep 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459605; cv=none; b=jenm7Xb/kBMXXgtsaiTCk260baZSgD26/VD/HBdr2VKP7sXX8DJIN0llx/P5pyKO+rC3Am1qDsCZDxg1CBE6FVDASDmdKXQg3SvxbeVYsnjW8YtN7HxCjVq8hdoyAoSi8ueSXxTZanN45ADZg6EVlF4sC6rCYb1oUvV3AGb5bcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459605; c=relaxed/simple;
	bh=+n89Dd/XB0RwWJq3kRUYqqmo+cbkW6057PytnvWj7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQlwxL4XwxD/gOUjhTh4BEOMF6sppgsT1E3gAfkTaBDUyRBE/xFW//jV7QoFycbGLG53+6myFVJykwJpPAgC+Mbcv29ZZ1n4xhygfw3orf3TqI5pmcpvu+XEx7SalJ40NCM3oanu1QmYVBbJ3niRIPOvDrCYjODbc9HlgIidaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D60C4CEC2;
	Wed,  4 Sep 2024 14:20:03 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:21:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240904102104.6f2a35af@gandalf.local.home>
In-Reply-To: <CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240823125426.404f2705@gandalf.local.home>
	<20240823145211.34ccda61@gandalf.local.home>
	<CAP4=nvQnW5vS5CQBZtKp-BdjYxNFbq26P36uRy3RhCenHEG_YA@mail.gmail.com>
	<20240826132620.1618d201@gandalf.local.home>
	<CAP4=nvTR9EuA5WhGweSaoeptEw0n0w5exr8gq6zfqGhGNt3zpg@mail.gmail.com>
	<CAP4=nvRfkZ2CEbFv+MFBXikZ_p2K-1uucgkdgp27JeTxe58qhw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 14:47:42 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> I suggest using the workaround suggested in
> https://lore.kernel.org/linux-trace-kernel/20240823125426.404f2705@gandalf.local.home
> for the time being. Together with the patch that adds locks around
> stopping the threads
> (https://patchwork.kernel.org/project/linux-trace-kernel/patch/20240823102816.5e55753b@gandalf.local.home/),
> this should prevent the kernel panic at least until we have a solution
> for the race itself.

When running my tests, the second one would end up deadlocking and
triggering lockdep. I found a way to do basically the same thing with a
cpumask and no added locking. I'm currently testing it and will be sending
out a patch later today (if it passes the tests).

-- Steve
