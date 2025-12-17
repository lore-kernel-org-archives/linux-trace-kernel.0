Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349C28DB76;
	Wed, 17 Dec 2025 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766002235; cv=none; b=Da4H3f27dO75mFYKe3VStzQhgTCmDWcD0j9UAzRj7q8Ei5Rd8ifVYWs5suQN4h/7zOjlI416ZlQrsWIQ3vDOJx3ie563bSs4fBW2lB5fwo36qsz3qfd9KPUFVquzUCBY/Z0QTvaJrFw96EAyUwvEtQSmR6LkklzLYlT8pE00HpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766002235; c=relaxed/simple;
	bh=T43YOePmzGlUgolZa46Aj1G7SoDZAJFoGiNwqCowyqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPcgzX/FLUYGLT75emOI+f8wcOu2VKDDCpAtlDQ/fGxsV+tZUXr+18U4ZYlsr2VPopeVU8p+cWOZTTL+v5bFkUxSt9BxS8HlyX+XTbxQfAQtNdHHK4NEf++U8Ft7VAogn5skzw9arCZbh49yQgDfXHEz+yb+iwaPBUfKAqZmzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 5C592160C4D;
	Wed, 17 Dec 2025 20:10:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 4C04B2000F;
	Wed, 17 Dec 2025 20:10:23 +0000 (UTC)
Date: Wed, 17 Dec 2025 15:11:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Thorsten Blum
 <thorsten.blum@linux.dev>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH] unwind: Show that entries of struct unwind_cache is not
 bound by nr_entries
Message-ID: <20251217151159.2eee1081@gandalf.local.home>
In-Reply-To: <202511171303.1623D77@keescook>
References: <20251114121352.35108fb8@gandalf.local.home>
	<202511171303.1623D77@keescook>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C04B2000F
X-Stat-Signature: rp43mu73r6d8kj19asw4dd9k87r173oo
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19kIi/bmuV7uGc/fxrZqezrLXCDeKA7ETI=
X-HE-Tag: 1766002223-739935
X-HE-Meta: U2FsdGVkX1/bqxB1D8kxs4NABd1/HyRaCBTB6j2r0143dxLdiZm0Bmiw1rj7TbqjsxiJdNpWnoy630ynuOSYjUsdzSd8O1FeTpLTexNNkFuprsy4WoqUMJLxbpvStoga5+08ANyQT26LiTaNcywmT9B6Ht6jwBqDRU5gOlPkEz/aZlth5pPTkEML3ymt7I1YfkdfboEMmzC7pOQ3qx4iGFLf5eK5yY5tkfA1juBuEaP3MTOaEELZDTAtzK1pZu21uGnrmT+iG8RnOc9Y7vk3TsyrUEUVMv4FZjKH4EuMzvqmttMr1zeU7/2+N6G8CPoHe4i+amAx4Zy16bO42Qk/36YdN403dkXg

On Mon, 17 Nov 2025 13:28:59 -0800
Kees Cook <kees@kernel.org> wrote:

> struct unwind_cache {
> 	struct_group_tagged(unwind_cache_hdr, hdr,
> 		unsigned long unwind_completed;
> 		unsigned int  nr_entries;
> 	);
> 	unsigned long         entries[(SZ_4K - sizeof(struct unwind_cache_hdr)) / sizeof(long)];
> };

This may help automated tooling, but it is horrendous to read. I value
readability much higher than static analyzers.

Hence, I'm leaving the code as is, and just keep NAKing patches that try to
add __counted_by() to entries.

-- Steve


> 
> #define UNWIND_MAX_ENTRIES ARRAY_SIZE(((struct unwind_cache*)NULL)->entries)
> 
> And this checks out for me:
> 
> UNWIND_MAX_ENTRIES:510
> sizeof(struct unwind_cache):4096
> 
> No hiding things from the compiler, and you can treat "entries" like a
> real array (since it is one now).

