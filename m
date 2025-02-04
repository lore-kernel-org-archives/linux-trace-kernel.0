Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3F2F46;
	Tue,  4 Feb 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674981; cv=none; b=bRYvoO8yzszFNWecl1gyIU78+qOlXbxRomW7HZHMmUnKZp6l6GJy2oPcJVCkx5M+I+UEqlfb9W38Hbo9g54LkXN3etFgwJA+yh/mWZbJ7z6b8rJQKBzU/kQ9qF6q/kC2pcUviM2ArpQvl0Vi+7Tzk6G9OMRWcGSfsp1hTdIAe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674981; c=relaxed/simple;
	bh=9BVtUC2dRYqRRAzPmjV+IpydnNfRfTZ+iwtUkO71hos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUAnmbW+qkIqjw0ZilwWO/b3DjkfA7iPXE7kmEraZ6aIfQMepxRDVfxv4dufYDfG17SSpEQ3ADnyPGGVfXydZ/QOHQWP4HxNL5pDyRGv7xRY7gG/wZOXz9pOhdCaVPznJCfCH1xn4lYTeXb5KdhDoOYxpIJUWklmNdv8O+Mn5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE861C4CEDF;
	Tue,  4 Feb 2025 13:16:17 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:16:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Clark Williams
 <clark.williams@gmail.com>, bigeasy@linutronix.de, daniel.wagner@suse.com,
 joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250204081653.18dfe905@gandalf.local.home>
In-Reply-To: <20250204075100.3fcbfda8@gandalf.local.home>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<20250201115906.GB8256@noisy.programming.kicks-ass.net>
	<F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
	<20250201181129.GA34937@noisy.programming.kicks-ass.net>
	<20250201180617.491ce087@batman.local.home>
	<20250203084306.GC505@noisy.programming.kicks-ass.net>
	<20250203114537.6a30c7c0@gandalf.local.home>
	<20250204091613.GQ7145@noisy.programming.kicks-ass.net>
	<20250204075100.3fcbfda8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 07:51:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I'm so confused, WTF do you then need the lazy crap?

IOW, the "lazy crap" was created to solve this very issue. The holding of
sleeping spin locks interrupted by a scheduler tick. I'm just giving user
space the same feature that we gave the kernel in PREEMPT_RT.

-- Steve
