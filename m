Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647B1DFD1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPco6XOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C41CC433C8;
	Thu, 19 Oct 2023 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697717927;
	bh=y3v4IfGSgIc8FpfyQVXiNpDGuzP2wM1wvkHAL6T5GT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sPco6XOa1kuZi9AoXasi2hVstQDVEouN0SHm5PKpLLDILwezdkTae7vIiBP6M6vk+
	 7jhnmDjV3VpxXdXqxHbY6Nf01eWKbvvwF7sWczqtnXYgFGsdIzwqYu2wh9y3kvr7Gd
	 lqlq7Iipn1EC23y+VrMasPHlyfcuJuEiE7If2EpWlqdvkHgPZ7sU+7mH6d8+yvUSs+
	 iJKlo0GFdCUVP/DksEKP07fHRaJCkhNoI5Y1tILOEdioafZB6mjFOJjJNrClXQTDvH
	 PM0DgR6WMErBvLRrzzeTjr/XhRF8cX5nfHEd0p0OS4+PfDrlsbiJWGb0s6hMm3Ellt
	 3w5rGGXQ+Ez9w==
Date: Thu, 19 Oct 2023 21:18:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Francis Laniel <flaniel@linux.microsoft.com>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-Id: <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
In-Reply-To: <20231018130042.3430f000@gandalf.local.home>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
	<20231018130042.3430f000@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 13:00:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 18 Oct 2023 17:40:28 +0300
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> 
> > Changes since:
> >  v1:
> >   * Use EADDRNOTAVAIL instead of adding a new error code.
> >   * Correct also this behavior for sysfs kprobe.
> >  v2:
> >   * Count the number of symbols corresponding to function name and return
> >   EADDRNOTAVAIL if higher than 1.
> >   * Return ENOENT if above count is 0, as it would be returned later by while
> >   registering the kprobe.
> >  v3:
> >   * Check symbol does not contain ':' before testing its uniqueness.
> >   * Add a selftest to check this is not possible to install a kprobe for a non
> >   unique symbol.
> >  v5:
> >   * No changes, just add linux-stable as recipient.
> 
> So why is this adding stable? (and as Greg's form letter states, that's not
> how you do that)
> 
> I don't see this as a fix but a new feature.

I asked him to make this a fix since the current kprobe event' behavior is
somewhat strange. It puts the probe on only the "first symbol" if user
specifies a symbol name which has multiple instances. In this case, the
actual probe address can not be solved by name. User must specify the
probe address by unique name + offset. Unless, it can put a probe on
unexpected address, especially if it specifies non-unique symbol + offset,
the address may NOT be the instruction boundary.
To avoid this issue, it should check the given symbol is unique.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
