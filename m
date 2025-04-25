Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F46236435;
	Fri, 25 Apr 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571284; cv=none; b=jXCRQD8WOcMP9y9TGDTLH0dCI7a/WY/7e+COBIySOjR0yJlm1wSRN3zX5AKYHykJFL3q6uXCV0yJn0KrlVAo8WJ221Ok4DkHQ983Oejyvw38kUQDxvH6jiKanHGte3pAXd2u48muNaPtrrWycHYzmFRfIWD5yUT/W4ckEa9172k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571284; c=relaxed/simple;
	bh=byos0KBTq/TSuKpnONmQSZ/S7MqfhwZ6bkrEWjklef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js4h8NQ/SK4ag0E6UUZbiA68Dj8OefnhRA8ALV5d1/kAbdWD/bp1gdAoBwf18bJ8LNMNeM5mIDNLmBsTm0K8jqv9R0W8nBaDpH9sKguAuj9P9gcIg1ZSUqzkToViQPfLdP8TgfysdBBM26P7zJ6Z2vNjN4okveZmOu2WrVUnMmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq49QPNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq49QPNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C5C4CEE4;
	Fri, 25 Apr 2025 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745571284;
	bh=byos0KBTq/TSuKpnONmQSZ/S7MqfhwZ6bkrEWjklef8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yq49QPNm8JISyJIWA2gTjzx9WngHH+jHBnH+w++QZ4pLMPSVcKMh0Ut10d2/xzj7u
	 DHBPjAgGLWsLqEba9tvqZ60cDvalmVmpUC0shPA/dfsmSMelBP/17e4an3ddQJxLZJ
	 9PVdU9hqvVyqjF91HUSMPadBgv/Yy/GhiJNOEpJpM3Mg6f52UlfpguAqQzY1o/b7FV
	 yESvey9PKaic4QrnwGUnY/tD+pTwnEQluFLVZqjr3akxgz2J33cQ+0+zVzRf3kNL6S
	 G6eKTst6v2EoKA75j2SpeC2gRocKxR7Ua0Um4vA9GT+1140PqAUvt/5qTml+9HmhFO
	 Rt5+CrLgQldkA==
Date: Fri, 25 Apr 2025 10:54:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v1 00/11] mm: rewrite pfnmap tracking and remove VM_PAT
Message-ID: <aAtNy6VjUvOrOC7r@gmail.com>
References: <20250425081715.1341199-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425081715.1341199-1-david@redhat.com>


* David Hildenbrand <david@redhat.com> wrote:

> On top of mm-unstable.
> 
> VM_PAT annoyed me too much and wasted too much of my time, let's clean
> PAT handling up and remove VM_PAT.
> 
> This should sort out various issues with VM_PAT we discovered recently,
> and will hopefully make the whole code more stable and easier to maintain.
> 
> In essence: we stop letting PAT mode mess with VMAs and instead lift
> what to track/untrack to the MM core. We remember per VMA which pfn range
> we tracked in a new struct we attach to a VMA (we have space without
> exceeding 192 bytes), use a kref to share it among VMAs during
> split/mremap/fork, and automatically untrack once the kref drops to 0.

Yay!

The extra pointer in vm_area_struct is a small price to pay IMHO.

> This implies that we'll keep tracking a full pfn range even after partially
> unmapping it, until fully unmapping it; but as that case was mostly broken
> before, this at least makes it work in a way that is least intrusive to
> VMA handling.
> 
> Shrinking with mremap() used to work in a hacky way, now we'll similarly
> keep the original pfn range tacked even after this form of partial unmap.
> Does anybody care about that? Unlikely. If we run into issues, we could
> likely handled that (adjust the tracking) when our kref drops to 1 while
> freeing a VMA. But it adds more complexity, so avoid that for now.
> 
> Briefly tested
> 
> There will be some clash with [1], but nothing that cannot be sorted out
> easily by moving the functions added to kernel/fork.c to wherever the vma
> bits will live.
> 
> Briefly tested with some basic /dev/mem test I crafted. I want to convert
> them to selftests, but that might or might not require a bit of
> more work (e.g., /dev/mem accessibility).

So for the x86 bits, once it passes review by the fine MM folks:

  Acked-by: Ingo Molnar <mingo@kernel.org>

And I suppose this rewrite will be carried in -mm?

Thanks,

	Ingo
