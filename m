Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCA3BB673;
	Fri, 26 Jun 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491265; cv=none; b=INrdZO7wvd5Y1umRdinJuB46fj7kIz29o/JOQZcoNZhCxcuTnsFdNfE1dkJVOdtduugDM+aJcl2ehZgRo/PScOmFYUll6KYU1NvTFROQq/bZkEtg3ygGBl+hkoq55MAlm0/A2EEad3rcNZPrly/sfTpYzsfLmkz5dVpBUcp0qxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491265; c=relaxed/simple;
	bh=ImorTgLxdVBZ8KA+SoiC+IQN13SzOs8n+JsQl8npZi0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eYM4YETvcsRI+riLQCfY8bHNooqQ6aiflZ/L6THqVo3F/G+EnJch47x3xeBKAwtHvZ+ZmVsqZSrs+Msi+pHgW1jKila4VIMV5S1Q0lUP0HgVY+Ii7lNjfPePzshii3vvEbyfj5Zd0+o48S1poZjnM/SE+YCVosR7yqryx931h0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PQqM6y8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PQqM6y8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129131F000E9;
	Fri, 26 Jun 2026 16:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782491263;
	bh=6xdhB1h20JevoCIK0FA3vdUPT1iU5NQ8QI9Cuj4CG3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PQqM6y8Zwq77LOJE9kupv7UIeWj6h/06JBTFkhuilrKOfhlxaX3dctYkVnn8BXe7h
	 p4nJis+WgZhlJnu+H/F9D7juqnDnGg3pyP2kzyGY15N9xdJerS2x0e0oumg42fh6wU
	 On9cS26zBQWDtUbm0SoX4z0UCj+TB8vYPO5u5xAE=
Date: Fri, 26 Jun 2026 09:27:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>,
 lance.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v10 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Message-Id: <20260626092742.160c3c10196852f075b3f5e3@linux-foundation.org>
In-Reply-To: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
References: <20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 08:33:14 -0700 Breno Leitao <leitao@debian.org> wrote:

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

Cool, thanks.  I added this to mm.git's mm-new branch.  Next week I'll
move it into the mm-unstable branch, where it will receive linux-next
exposure.

Sashiko identified a few possible things, some pre-existing:

	https://sashiko.dev/#/patchset/20260626-ecc_panic-v10-0-6dacb8ad024d@debian.org
