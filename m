Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD202AD31;
	Thu, 29 May 2025 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748544146; cv=none; b=YSRx/FRnnIOjzKBSDbQg0PFYTiRm7f0ZPaTBnC/KqFNlBpeVAsTylNSBTviHBBT7UiyCdE51I1WXoB8NeNiIWZWLB7dNwqh/dSG7Twfrw8GnCM+Tp58i4RQDRFqkjAKJldXDehsa6yQnR7VhzNzWYPFRgg7+1sS90ZbuPATy5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748544146; c=relaxed/simple;
	bh=Neoym1y/VIebh0hqAKRlqN9KeVpgBGL7Tb/AAqhQXn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAXk7GvfeQyMzYIBPOIL791WaIEbvneByfcOYSSBrEFDz9/CGV6MIOlu970bKCYtJ+yG1LahWAB4AIkpPZ1SYdqnpfovYz9u5S8j6IOtuoEQRhF4AU5Dmr+2BMwxJGSdMaipOb+cFQ/nRJzpX8SJaZiJuq8qKqEYjYv2H1y3mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAA5C4CEE7;
	Thu, 29 May 2025 18:42:24 +0000 (UTC)
Date: Thu, 29 May 2025 14:43:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <20250529144327.1633825e@gandalf.local.home>
In-Reply-To: <20250528122411.16a551b1@gandalf.local.home>
References: <20250411161746.1043239-1-csander@purestorage.com>
	<3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
	<CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
	<20250528114549.4d8a5e03@gandalf.local.home>
	<b694c72b-0873-4123-869c-134709341e19@lucifer.local>
	<20250528122411.16a551b1@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 12:24:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Yeah, I have a patch that shows how many static key instances exist and I
> test that. But I probably could also add an option to the macro that
> creates the trace function to also add something to a section when used,
> and report when it isn't. Shouldn't be too hard.

Done:  https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

-- Steve
