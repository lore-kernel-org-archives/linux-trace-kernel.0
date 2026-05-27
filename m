Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794DA37BE9E;
	Wed, 27 May 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910779; cv=none; b=LjsTjDDHOikV+tXO1IbvvFBY6QNYy2+ahnaWCPWnwsevgtHEk29CqVuS02NLf65yRM9qa0uz/uVNanML9Spa7kJs3IHXcV1jhD3Y8YYwHUGvVg8ScdR5lAITiYW4roRSOjg+o47tSNg7gqMzdXsKOV7FEq3bm8zeesZRx1RYGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910779; c=relaxed/simple;
	bh=p8AxX9pryeSSlwsGfbi7RLl+AU19dVQGc8b5AFEemtw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ODpZueLhBESHCS9HEHmYuqhJAeE16p4n+weL/Tvlbt+Qgc08sXuvbOnqjxHXQ6F2/mOKzTBOCxrqoQip/qHkCfKGasBpFja+rNnnGjFPHikG3jrfVdb6dLIDSw+uTnI/YQLO8oF4r1P/xaLtllKj4E2JJ0Win8jtT2tSn9hu9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k0WaPiIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k0WaPiIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A7D1F000E9;
	Wed, 27 May 2026 19:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779910775;
	bh=Qje0s9+5g7mwBQLx6gyz3RzpOX1+aY/PlmzgLifJRzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k0WaPiIEBwU1aZfVY3U7+RBAE7VXMsxFrl481Ofs/0gzrkClEzhhWW/Af7E23YCli
	 0ipemC3dY0d2opQX7XXgRRYAotjFovhhh4r5uKR3k5z7L+JCzDDk0TT0+UfU079iBy
	 oTL2Y855DeQzOc+E+D7mBaQJDL3axvoPT9QZ0l5w=
Date: Wed, 27 May 2026 12:39:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang
 <lance.yang@linux.dev>
Subject: Re: [PATCH v8 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Message-Id: <20260527123934.77f789b4ecaf403f0ec6cd31@linux-foundation.org>
In-Reply-To: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 07:06:13 -0700 Breno Leitao <leitao@debian.org> wrote:

> A multi-bit ECC error on a kernel-owned page that the memory failure
> handler cannot recover is currently swallowed: PG_hwpoison is set, the
> event is logged, and the kernel keeps running.  The corrupted memory
> remains accessible to the kernel and either drives silent data
> corruption or surfaces seconds-to-minutes later as an apparently
> unrelated crash.  In a large fleet that delayed, unattributable crash
> turns into significant engineering effort to root-cause; in a kdump
> configuration, by the time the crash happens the original error
> context (faulting PFN, MCE/GHES record, page state) is long gone.
> 
> This series adds an opt-in sysctl,
> vm.panic_on_unrecoverable_memory_failure, that converts an
> unrecoverable kernel-page hwpoison event into an immediate panic with
> a clean dmesg/vmcore that still contains the original failure
> context.  The default is disabled so existing workloads see no
> change.

Thanks.  That does seem useful.

I'll pass at this time, due to -rc5 and not-very-reviewed.

AI review said a few things.  It claims to have found one pre-existing
issue.

	https://sashiko.dev/#/patchset/20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org
