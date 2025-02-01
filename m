Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36510E0;
	Sat,  1 Feb 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738414504; cv=none; b=AEEL/n3SdfxiLApTaT7lqkbRMjxrC7eKlsyAZNm2/2reMJ88myQ+trOn1lAokDJAuwWivTHIoNYHwVlhD7vO2RyzEHi3l9/py1OXD4jCa8oHAZcqAVuNyL2V+kk+N48JOhTNoyqgPJkPzVHYmYOcEywiCSzYfqqNmbpoaKvAEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738414504; c=relaxed/simple;
	bh=4WR3YjQkj76sANFt8k+A8YjRxWhXlFp9eSB0Oi7zCeU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nILwtlr8AyB9gnsYrlUmCR1OHaxgUDjRfA3Bb+iom4pM17lgv6X8CCrPSBW6lALqUYjUe+pVklZvyW2GfHxzKdZFPiLJmnwGqeSJdaYpcGyXKVB738lnTgxs6zNrVatvFsM+mcEWKDe4FtjmHDfhq6ylompWAvtF/2BgB3DyJDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 08D9C141576;
	Sat,  1 Feb 2025 12:47:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 009DC20029;
	Sat,  1 Feb 2025 12:47:30 +0000 (UTC)
Date: Sat, 01 Feb 2025 07:47:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com,
 andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>,
 Vineeth Pillai <vineethrp@google.com>,
 Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de,
 daniel.wagner@suse.com, joseph.salisbury@oracle.com, broonie@gmail.com
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
User-Agent: K-9 Mail for Android
In-Reply-To: <20250201115906.GB8256@noisy.programming.kicks-ass.net>
References: <20250131225837.972218232@goodmis.org> <20250131225942.365475324@goodmis.org> <20250201115906.GB8256@noisy.programming.kicks-ass.net>
Message-ID: <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 009DC20029
X-Stat-Signature: 6sxenxk597ry6zomh9t4emq1d5emxmut
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qDUG+uvJFuXQrkjkFDLnhn5Y3oNpjwi4=
X-HE-Tag: 1738414050-844362
X-HE-Meta: U2FsdGVkX183JdtBqO3NAY56g42n+J+TG7B3+uu1DpQJfugQFp3wDOEB5f1AjgIefpIf2fRE3Dh6w/ZplU2KNPfeZdGLDzJ+uzU/KdoFFPCXTzU/3JpV1LCfs6c8g2Qdch1f10l0U4UJX0N2hJLqdysnWFMNXAZ3SQo/yld6u48GEPVwTbbXtcmUI2zj/HZN82dA7nWkIbpQmgJh3vbzy0yccNbpDUwuzXojBlDHA//mGxiSUa+ci/hlhPohVNOxT5UWVPHzbVvdYMyGyPqt06AGVnZRJQ7k3w1FFvZRdmsqfT7vs38aOz2m/4MTvZej9DHYAqU9xYEFRfj7yALYt9V6AiEPCimhSu+xlYg3KsOAwnciLMIXgYY9jXgWkY3mWlXM0l9kVXo2VUTJtIs2TA==



On February 1, 2025 6:59:06 AM EST, Peter Zijlstra <peterz@infradead=2Eorg=
> wrote:

>I still have full hate for this approach=2E

So what approach would you prefer?

-- Steve

