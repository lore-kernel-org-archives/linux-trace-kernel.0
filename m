Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF23AEF24;
	Fri, 14 Aug 2026 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751896; cv=none; b=h+bzxLCvpOtKAqYZfDjdqS85ZAPJIEUBLW1Vj5h9wK8s32/REgUp9bzPmXpPSxYEAUhJ5EPddU0IKSBqWHMKlpKKkkNPLvk/8duq0sRoWp9x7PS4LUUG7yJPOd+ZZlkqcq6eb2SElIAxlP1gaTtDs91dk5TFi0CSiqLOyAnzLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751896; c=relaxed/simple;
	bh=NK7zVIPMHNiKPkpS0fr1s6UAAz6/AB/w8yX/QVdglNE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p/2f5jyzehCh2CQ8bcPcUEHXcD5KQ+dyP4F9uGcgsAkL78TkCch+m5XkEXxolnSJXUKyFVPhAZD2G5CULIRKKjRjgnvWrcMPf89Vo7KaeyOlOejGOD2vy+OLWZlbeQYPPVGt9HYhfXsmWCjDR7RNb5FvW2RCBcP3wy9yr1/0fwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOKig/72; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOKig/72"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8B91F000E9;
	Fri, 14 Aug 2026 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786751895;
	bh=yTKEaExnWA9LlP2KiNRQafVSy0272KPps/FHnkwKHhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FOKig/72pEHwYxEI0ZCmJP+x7eXoTggw4MlM1XoyxGkGwTU3RiuXO6LNoCHpIYBzR
	 telRS7uK/mJ/H3nwXrGuKTFpYLVvairX6QckAezPSX/hzEK30vNAhmM2NAeZSxZdYC
	 GtIYhwRVlDaVlSlrFuZcmnNqgOLVAVT0Gwz919Fwh0Y0hV/jDj9IWq21rEEbB2FjJ6
	 IFS3/LbfZpM2hjDENCdmSg85PdjCiIPgXyGLPoKzdNPmLvlrlo1wbOeaw3tJ0I4JxM
	 CITlhAVE2bWk02kz6hGqGLww0qnPM5Deb49egypDBVTVbX+Ed5LKXF/Z1PoAR9Jxzx
	 rqn4kl3vUjWLQ==
Date: Sat, 15 Aug 2026 08:58:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] selftests/ftrace: Add a boottime tracing test
 framework
Message-Id: <20260815085810.7255ac3b0021b2e3e086cc63@kernel.org>
In-Reply-To: <20260814133610.32eb5da9@gandalf.local.home>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
	<20260815010524.b361dc036dd2e997d23cc421@kernel.org>
	<20260814133610.32eb5da9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 13:36:10 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 15 Aug 2026 01:05:24 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Would you have any comment on this? I would like to pick this to probes/for-next
> > for ensuring boottime tracing works correctly.
> 
> Hmm, it's a bit too close to the merge window for a good review of it. I'll
> be traveling next week and I'm trying to get all my pull requests ready
> before then. You sent v1 on Monday and v3 on Tuesday. Sounds to me a bit
> rushed when you have 3 versions during the -rc7 release week.
> 
> This isn't a trivial feature. I think we should let it settle during the
> next merge cycle to do it properly.

OK, then I'll drop this from for-next.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
