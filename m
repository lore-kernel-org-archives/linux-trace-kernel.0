Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6ED3B3894;
	Wed,  1 Jul 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927866; cv=none; b=qP9jdg8IodBvc6H5FjfAzbzkmAv4C53djd7AuiXLhc2BeO8fvtGELB6IFXUI5nq8XQhvSdKJXdV2bxxEoI6y+l24xp1hTuLfL6kvkpqVJCXfuU4K2S+c9hnRUICppKby2oiG9mwmERG61Q6pLzsLpTWQ3omdN84shQk33ou8GN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927866; c=relaxed/simple;
	bh=y9izET4NOx8LcJvUhAZwHHb0PC2pE68DEeGvgFjPY1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utJlfi3vdTuoaszCs5DyN/nBdRDWUkW/+gmlXEEKNpdOQTUk8A/sm1ZL8QotCpMWBg5ljWHRxi2XAouz3KmMWkVkOBNyLFhapyWBT+rXPSF5V2kGKFZRq/dSi0uIst4WwuwbYwXEgCXT+JDSKHsG38Vp+D8KCH6t9jZzxvnV77s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCbtCvze; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCbtCvze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7091F000E9;
	Wed,  1 Jul 2026 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927865;
	bh=AZUtVGDi2E1uDHHozjSVNvV+vNTQLZohC8EXeeFcY9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mCbtCvzedxySlWRFDyqnWlbxwuEQgDPW/qZSCpQjl9D2UmFZV8L4YDIfm4RSS9vod
	 I7GYVulM7S8po8qeeOqLoavXuSJVdOqckDiKY0ejfbrvcLzdYsgXuKu+kG5ATFtEay
	 4BqhcGHZVM2rO/M2b+zldnjMviI076o2E/1q0h8YLge52bwWr6MsYCPLIkElbJKGjw
	 BvESDCIUL2e7w3Z0IEMvYKqNZssJLmN48bAEZXhShjCXHywWfFK49ju2V2cbH9PmPc
	 aVcoWJ9mfWbCdMsERUV9iorNGnf5dC5tJvh0QzeAfIPipBSf3TfVTZWA5YWht22anG
	 gLoqFOGCu9l+g==
Date: Wed, 1 Jul 2026 10:44:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 04/11] perf/probe: Ignore comment lines in
 dynamic_events/kprobe_events file
Message-ID: <akVR9oUGIjmheePT@google.com>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
 <178271361825.1176915.16095297120719039761.stgit@devnote2>
 <20260630073211.2a505d1f31e5fae1bf03b81a@kernel.org>
 <akMO53eG_4YKJH0j@google.com>
 <20260701073939.81842d6f6bd139a329c45c7f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701073939.81842d6f6bd139a329c45c7f@kernel.org>

On Wed, Jul 01, 2026 at 07:39:39AM +0900, Masami Hiramatsu wrote:
> On Mon, 29 Jun 2026 17:33:43 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Masami,
> > 
> > On Tue, Jun 30, 2026 at 07:32:11AM +0900, Masami Hiramatsu wrote:
> > > Hi Arnaldo, Namhyung,
> > > 
> > > I forgot to CC this. Can I pick this patch via linux-trace tree,
> > > or would you pick this?
> > > This is a part of typecast series [1] only for debugging.
> > 
> > Thanks for letting me know.
> > 
> > I think it's better to route this through the perf tree as we're seeing
> > a lot of cleanups all around the code base.  Having this together would
> > reduce chances of future conflicts.  Does that sound ok to you?
> 
> OK, thanks for confirmation. Then I'll drop it from probes/for-next (and probes/core).

Thanks, I've applied it to perf-tools-next.

Best regards,
Namhyung
