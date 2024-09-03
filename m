Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6381413D531;
	Tue,  3 Sep 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375579; cv=none; b=Y4G3kNmipSv0rIrBLH5zMoX4hZrfPKdYadm/NDpK2txUAmBzfsOvR5O72fh6nCu/XU7i7RcdcpcRF6ooslss3pVWaNOpSLCmUMoR2H1dUtpCqyEY+PKVU6z7ETp8RwZfgN3kVKxlVd6YZM/qzfYRPmbUnVpGol5kEBNbtog+4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375579; c=relaxed/simple;
	bh=aApIHYzdYOYkRQ8xvVR1RtlPH9XV5jWFEtmCj/Cff1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb7LpHMx61Cp5JJj16APKU4Y2w4CsgZ0r+C78X+GF0316OU6+vKJIORPVGYM/S+cU6I6tVTIRC2ak7TGVl7QlmkiIp8E+7e7VGDoFaE1BtXDYnUkytthcBng2c0xQHvTgVbOmhbl+fec8e6drPeC30QGYwJjNkX/1JjICVeKUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEDC4CEC4;
	Tue,  3 Sep 2024 14:59:37 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:00:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240903110035.562fd595@gandalf.local.home>
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

I'll make the first one an official patch and start running it through my
tests. We need something soon, as this is a standing bug in the kernel
where the fix needs to go to stable.

Thanks,

-- Steve
