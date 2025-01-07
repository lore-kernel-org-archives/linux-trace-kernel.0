Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17F1F63D7;
	Tue,  7 Jan 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286202; cv=none; b=RAUGS9yX7dr0m1PSdtOA00nVHXEp3OqZKPBzNcTk9FK4+vkzz4bnhEnz/OWxkKn45FFy33sPzD9Iw34FCT3xkSAZWPxfFEbverzZgTg6hvFKBU/+vkWtLfFJXiloAqu+1H5aucjTEDG8lFP8/ASAwCXy+5p7sQVOr3AA7ypQr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286202; c=relaxed/simple;
	bh=yTz3stwCffxcnxpph17ZrC3m56WrrJ7ASA2OpQfVGbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZkRsDAesVeRij6BRqRFzPU1lnQk9QWzcLubu6eln/Kqgli7U+BQIEsmGNwkkh3bQV6K0b52NGgMpkaTKhTZkIO3t8Hc428F8TC3N82GR5Got0A8gM/T1o/+g0knp4KfGFxKbz6Y4vxWSSFdc8bv6Ne4LMpJuQYxkyd2Y7rE/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD563C4CED6;
	Tue,  7 Jan 2025 21:43:21 +0000 (UTC)
Date: Tue, 7 Jan 2025 16:44:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 0/3] rtla/timerlat: Set OSNOISE_WORKLOAD for kernel
 threads
Message-ID: <20250107164450.75f0adb0@gandalf.local.home>
In-Reply-To: <20250107144823.239782-1-tglozar@redhat.com>
References: <20250107144823.239782-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 15:48:20 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> The patchset makes both rtla-timerlat-hist and rtla-timerlat-top set
> OSNOISE_WORKLOAD to the proper value ("on" when running with -k, "off"
> when running with -u) every time the option is available instead of setting it
> only when running with -u.
> 
> This prevents rtla timerlat -k from giving no results when
> NO_OSNOISE_WORKLOAD is set, either manually or by an abnormally exited earlier
> run of rtla timerlat -u.
> 
> osnoise_set_workload is made to distinguish between the option missing
> altogether and it failing to be set. In the first case, rtla-timerlat will
> ignore setting the option to preserve compatibility of kernel-thread mode
> on older kernels without the OSNOISE_WORKLOAD option.
> 
> Tomas Glozar (3):
>   rtla/osnoise: Distinguish missing workload option
>   rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
>   rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
> 
>  tools/tracing/rtla/src/osnoise.c       |  2 +-
>  tools/tracing/rtla/src/timerlat_hist.c | 15 +++++++++------
>  tools/tracing/rtla/src/timerlat_top.c  | 15 +++++++++------
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 

BTW, are you going to be implementing any selftests for rtla so that it is
easy to test these changes and check for regressions?

-- Steve
