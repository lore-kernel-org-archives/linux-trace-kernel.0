Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A13909B5;
	Thu, 14 May 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756852; cv=none; b=GO3Olek3xGdFMPDXSEzP/LI16Xynf39JFo9IfXzFzw4WZW2MuvfdS8CXH8v/qq0ge0c+pmYixGwGCFYBa00QSggXNLY2Etd//6yyeJq/tVuyFotrs3TisEJKBPBAfOq15Wip4SmA9j4Ps67HMkkp7jttm6RHuuxRnx+wmROcV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756852; c=relaxed/simple;
	bh=64h78kYhiuhfHSxMUMUDpTwZLBrLQDm2GThKRcUhPbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a43M4BWuqCPPxza+r4DPDTLC3W0IeEceTIN4FOb6j+YVDwKAISkpWVlc4I36NFgEEKV2abgheu/sOaQuiY6KpfIUCCYks51lvXJ7WlB/uXeQxJKfzdRPrroDucuU/h2bXaczqDD197iTTY+UV37X2l2cwlPaLNckjKLaKB8Sdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FSkv2BFN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FSkv2BFN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8ajRUalzhgnnfvlPn0WFR2fLEgViH6plKkchspfix3c=; b=FSkv2BFN8Uucm7POm/m+FRQU/f
	OKnEJNeRs5TovgCDj71pFKXBJ1ywjwTYpsPkhqP9CZJSYJ2pJwTrRoWL15Kaz7/MMYxMntaic2dBR
	YWzDWy8dFIHIw5lFZC/dpG4I+/ayRH3T7wofabgAeBm2v8IZqoGuF3ep2U5WdJxuGiIevSKY5ovUV
	PD3MK0HHzJHnjLAcT2nyMQDmdsvV/0brczMU5K6/j0LxqEhDkA6JWF034qbFbC82lluwRPT0hgXgz
	QVNwSPf7c6MuOxJy4ycOlhxtvmO22G61aJu46aH+Dhl//jaXkvhovISFZBaHZaZKCfruOsjKVAYPn
	+t0uCj8A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNTu6-003tUh-22;
	Thu, 14 May 2026 11:06:59 +0000
Date: Thu, 14 May 2026 04:06:51 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v7 4/6] mm/memory-failure: short-circuit PG_reserved
 before get_hwpoison_page()
Message-ID: <agWrHSXGQzZPEg0L@gmail.com>
References: <20260513-ecc_panic-v7-0-be2e578e61da@debian.org>
 <20260513-ecc_panic-v7-4-be2e578e61da@debian.org>
 <511dc52e-f2af-43c8-a9cf-19321b091dbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511dc52e-f2af-43c8-a9cf-19321b091dbe@kernel.org>
X-Debian-User: leitao

On Wed, May 13, 2026 at 09:49:28PM +0200, David Hildenbrand (Arm) wrote:
> On 5/13/26 17:39, Breno Leitao wrote:
> > The previous patch already classifies PG_reserved pages as
> > MF_MSG_KERNEL through the long path: get_hwpoison_page() calls
> > __get_hwpoison_page() which fails HWPoisonHandlable(), get_any_page()
> > exhausts its shake_page() retry budget, and the resulting
> > -ENOTRECOVERABLE is mapped to MF_MSG_KERNEL by the switch.  The
> > outcome is correct but the work in between is wasted: shake_page()
> > cannot turn a reserved page into a handlable one.
> 
> If really required, can we just move the check right there, into get_any_page() etc?

Sure, we might move it to get_any_page(). I took this current approach
based on the following facts:

1) Lance suggested it, and it sounded a good idea.
	https://lore.kernel.org/all/20260512124837.38883-1-lance.yang@linux.dev/

2) There is a _similar_ check close to this one in memory_failure(),
   just before this one:

  if (TestSetPageHWPoison(p)) {
  	....
	action_result()
	goto unlock_mutex;
  }

  and now

  if (PageReserved(p)) {
	...
  	action_result()
	goto unlock_mutes;
  }

3) I wanted to give get it as  real layering point, not handwaving.

That said, I will short-circuit reserved pages inside get_any_page(), in
an updated version.

Again, thanks for the review and direction!
--breno
