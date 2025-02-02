Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984720ED;
	Sun,  2 Feb 2025 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738466789; cv=none; b=M4C8aAogwm9qG+RYYTbZoCZrIGYv6yXsDUEwFpq6VEx/XvdJVHAoVG+tBLISrH8C5t17i68+Do/juUs9/YiPcEAIwZ1snbXQumg8EC4E3R5lDkqHuVMSjPQqU1udcGKsLg97zgcDmj/RciDAVUI5PTPS1CpH9rUM0AUtq7jTnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738466789; c=relaxed/simple;
	bh=EL8R7+4DLL9JYXNTxNyqGEzs87ccKluFIBrQZ9V3Fxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHdmE1hD9QyhSdA8zI/1XIDao8sgiK5IjJkI6avqbWDzNw/Nk0/YUBQDHWolSv9uJRitSppTqq9b7kIKfj/dtOngPUN5SC4uA0/vxfyQ3DKW1G2nRAXKDQ7VdMa6K8NagbOO1aHug0pz70g+qLjNOztUUMj5ZL/h1lJJwwPDsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDB2C4CED1;
	Sun,  2 Feb 2025 03:26:25 +0000 (UTC)
Date: Sat, 1 Feb 2025 22:26:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ankur
 Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, Vineeth
 Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, Ingo
 Molnar <mingo@kernel.org>, Clark Williams <clark.williams@gmail.com>,
 bigeasy@linutronix.de, daniel.wagner@suse.com, joseph.salisbury@oracle.com,
 broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Message-ID: <20250201222624.61722cdb@batman.local.home>
In-Reply-To: <CAHk-=whVzwPwiQj5PdmZXA8G=9ZS2T-OUPm4VrM8TKTDQW3Dmw@mail.gmail.com>
References: <20250131225837.972218232@goodmis.org>
	<20250131225942.365475324@goodmis.org>
	<e83ce086-b55f-431a-a499-f83a434b70db@efficios.com>
	<20250201180810.1faf4906@batman.local.home>
	<CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
	<CAHk-=whVzwPwiQj5PdmZXA8G=9ZS2T-OUPm4VrM8TKTDQW3Dmw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Feb 2025 15:35:53 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I didn't actually check what current active schedulers do.  I would
> not be in the least surprised if different schedulers end up having
> very different behavior (particularly any RT scheduler).

The only real use of sched yield() I have ever seen in practice was in
a RT application where all tasks were given the same RT FIFO priority,
and the application would use the yield() system call to trigger the
next task.

That's also the only use case that really does have a strict defined
behavior for yield(). In SCHED_FIFO, as the name suggests, tasks run in
a first-in first-out order. yield() will put the task at the end of
that queue. You can use this method to implement a strict application
defined scheduler.

-- Steve.
