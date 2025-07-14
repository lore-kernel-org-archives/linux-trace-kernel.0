Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669D1A5BA3;
	Mon, 14 Jul 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510175; cv=none; b=ZzGFblZtqjIFhgRG9qCd8sBqkugarMPklvTx3eeAgn8EPZp/CpqxUf7WZ8ynswLTbMhJ6L8b6EqPpwOtPHvmvmWjLvnGY4huw9Zlh49Cj9icwy3bQ568cqMtBHm8qc5AhCmapdgNyPkbzhOvs+Lbu7hEtNIh8Ss7YkTC47HG76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510175; c=relaxed/simple;
	bh=J5BbmABitS/Z56U/21eFenfHagRARnIxhQAY6AH/nvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX6XsBOmTnlSJic8hVj+rnzleanxuISF0Z6BCfn9AmUVbopepYQEl/Sq6NfMRNlmoDNyVMaswxogJHvsx8I2Qb2g60SgkT+f59B7Uuou1IaRwwQuaXuGN63V4g1wt5/dxRvEToj7Ia+GSkXo0jwgnVgslF7IXXRriekS62GBjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0982C14021E;
	Mon, 14 Jul 2025 16:22:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 895B02000E;
	Mon, 14 Jul 2025 16:22:44 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:22:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski
 <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Daniel Gomez <da.gomez@samsung.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, Yann
 Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 8/8] x86/ftrace: enable EXECMEM_ROX_CACHE for ftrace
 allocations
Message-ID: <20250714122243.19c9ab59@batman.local.home>
In-Reply-To: <20250713071730.4117334-9-rppt@kernel.org>
References: <20250713071730.4117334-1-rppt@kernel.org>
	<20250713071730.4117334-9-rppt@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r5wb4pojfof4fa8g781jhh8kxo5zdy18
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 895B02000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/oABu5KOy2BGyNBDoF58dzOuDvF5o4bxI=
X-HE-Tag: 1752510164-377651
X-HE-Meta: U2FsdGVkX18IZtlRjXFC0Shaa3uvZtomzZV05f7tYUhGt4RkiFauQtQUurUuegTuoLcma+mw8FIVARA/Wj5NN1NslWhNKbTBwkarCYNoTHSkbMcATn/le9x0PhshvTnU8uVrOxG7pycAfALTcc1w3cikw76Rhkqux8yXlXh5WTjksBbCQeCbYMpBNd3INbvKLRw/hnvxlWCLKGtVZ9+yDZC30Ll6nlpiwdG3iVrbKeGPqb/hKi2pJEU3Oqx+wqWA5KH1rGRg7cYtHo5Zj8AMWeak61Y/2Zs92WL9JnS1HNjdUBv0L5qegHctcO56Pol5m+ivZUt/rbVfF9j0dom+ncrMn26ImeGxznLqJ7Kz8xGyzj/8gBNpFF8Rucy78NTn9lGP+OYWa31Abm9XEUayW1Tb47d+HsyCntzFaZksEAl2rM/KM6GRrhZa1XZ5n9x59+tLnFeOGEArptCfL7/bRQ==

On Sun, 13 Jul 2025 10:17:30 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> For the most part ftrace uses text poking and can handle ROX memory.
> The only place that requires writable memory is create_trampoline() that
> updates the allocated memory and in the end makes it ROX.
> 
> Use execmem_alloc_rw() in x86::ftrace::alloc_tramp() and enable ROX cache
> for EXECMEM_FTRACE when configuration and CPU features allow that.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
