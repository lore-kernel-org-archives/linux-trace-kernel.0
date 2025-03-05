Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA61CAA62;
	Wed,  5 Mar 2025 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157277; cv=none; b=ut5AE85MFJnVQG7kRDhwhdpidjEIU6EUNh8/rNeRY390hnZd2a27FzdkXY2l8cI6tV/WSbddVi/BOXyUlUjx5P5S2D3vH2Vq6swwpGvOlhmDOVqoMgFwqFXGfrKIUEWDhya9C/bTvc+OzzeDDyTfaDWAEHlHuVHVKq0JCXZ0o7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157277; c=relaxed/simple;
	bh=fhRAF87/QEA7Em0a04Y82ATE0ensxZoTQPPkiTbfW7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq/EldFctyUsl5uH8JnPKOm1q2ILaQ0Hmbx1GDMR/2x3E0BmUmeeGYAWFS1I78k6YHIKQczT5puz8D1p8eO4wjIslCL06PyustBUyM4PeEzXHz1r0JgBrloiqzLgwA5Pw9UbaVYwZP4qoUND/TrkubBqQLxvLDkTSj2UQPfzJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhGfd9M9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhGfd9M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA121C4CEE2;
	Wed,  5 Mar 2025 06:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741157277;
	bh=fhRAF87/QEA7Em0a04Y82ATE0ensxZoTQPPkiTbfW7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhGfd9M9W4HyDwG9OxtMSlU688I7ghN20pVP8ix6GhP1xM9didXDiTizBwfBS5VOV
	 pyfUqP3zfC0OonUN0/qStfa+o030EHqTfCcihNUcL/RmeMqqFrbA4cZ/z65nw/ECMD
	 HuWbc31f8t1j6SQNKvVC1CVoFTm2k9ErgrwTy1aBRcK/gdm10key6jbkN/VDdQfz/k
	 u9RIxvBCL9uHB3WC4VImo0gNOh+4Zzktaqxgs1SrhndEuC0wPi4r2NOaMLoLPiBMnP
	 EkgN+hXnWwJ9/fIv/A5zowqxd8W5OTzoWQFXJaH06/1iRErTBmaPA4jaRw7DusEHYS
	 psmeRy+if+XRA==
Date: Wed, 5 Mar 2025 08:47:43 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <Z8fzj5VjtbTOS4Vn@kernel.org>
References: <20241124140705.2883-1-rppt@kernel.org>
 <Z07KnNk5AK_Jq6CU@kernel.org>
 <20241210230056.185826cd@batman.local.home>
 <20250303172427.1ae6c924@gandalf.local.home>
 <Z8am3EgVK9qADIgJ@kernel.org>
 <20250304095505.4716c41e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304095505.4716c41e@gandalf.local.home>

On Tue, Mar 04, 2025 at 09:55:05AM -0500, Steven Rostedt wrote:
> On Tue, 4 Mar 2025 09:08:12 +0200
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > It's not relevant anymore, the commit that changed text_poke_early() to
> > text_poke() is now reverted in tip tree.
> >  
> 
> Will that be going into 6.14?

It seems so.
 
> -- Steve

-- 
Sincerely yours,
Mike.
