Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BD39E184;
	Wed,  9 Sep 2026 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981574; cv=none; b=H9z1Bz57G09a9BP/Fr3FEfXvdPkYMBdTUpw/D35dN9s+mER1m4R4YFf/9u1yfYA116nz2XI0H9jQSaGnuAU0OsY+GEVScV3etv4xZMVVlH18VhETiAvtNxp39uKxnKRCZv9BckFfvnQwu0XhNjF/BSJ1ayUfuv1qgIvOuYlBZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981574; c=relaxed/simple;
	bh=jQZiHMEXqmuOYDoibg3Byfi7kxBqx18ULj4hcTFEclY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tl2PPtghx/XsDq1OY9Cubnk5n93xvEZReYFZmWtjZ9H95ruErSXLfBr36umlQd/NT3QLQoEGjoHUEljkXqmhXD/QFTWd4ZOvu0tsNNhXoaAcEnqa6wMmt7tAEjQHewTXq5jL8Z4wGyD29PVArC5IbmgBAyytQS4cA/7OHc9V3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=YJmf/vdg; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="YJmf/vdg"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7DDDEA032F;
	Wed,  9 Sep 2026 19:19:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 6983E2002C;
	Wed,  9 Sep 2026 19:19:28 +0000 (UTC)
Date: Wed, 9 Sep 2026 15:20:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Tom Zanussi
 <zanussi@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: hist: keep the entry count when the stats
 allocation fails
Message-ID: <20260909152043.6ebc1238@gandalf.local.home>
In-Reply-To: <20260907060323.480728-1-donggeunyoo.kernel@gmail.com>
References: <20260907060323.480728-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5fbhu4jszh9oddwypy6db7q89f5ucohi
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 6983E2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HdDy/rio1NXjaljTbIPZGa5paVbXXmQc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=YegicUDRWhVlDHJUJx91BIOBXO2SsK6EvfQsAmSeiNQ=; b=YJmf/vdgsboVgUBXSX7v2zy0sQeMFBz32NNI/ScA/GgfGK200iNQ3PcYQzcpoXFSGjyWZarTgwMcyUcnWC88kQ0Rg/jVlxJQOEg5HIgNWdyAVCJSZ6pjMNR/DW6fV0GVUwO1+NPGmgO9hnGRYvqfhfFobpBFupahFWY7bJiAjCA=
X-HE-Tag: 1788981568-140625
X-HE-Meta: U2FsdGVkX19QPF9RiEdme9QVfNtZ8SzSZaBSXkSFzkiQjBLVzem/SDSvYuTLa7cmNgzdMJ5DrdvOb210yT9DyCJdbQpeFrJpoxEVmJhLgAjac45zmv8x28MKMnkkjjctDIV8fFFdrvK33rumLS8kp9qKXj4SFJS7HjQnS6WFA3nZk1L85xC6rxsrWglO0EtVk8+cfFpT8GyW+h4pfqXNuI45mcIO0NwsZ65b+pTzskycAmRfT7tevD0fMmS8+uI2GY+tCy6zpOHRAP0LJdewavegpI4W1CXxxIToDWzmtXwdX7htvB4QAXL2cBDVSPXFi3FUTK/5fYwRwhpVEsAKM7pDa/NSeWUO0k9H9GZSo97+XXgY+cJVrg==

On Mon,  7 Sep 2026 15:03:23 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

First I want to say thank you for all you fixes you have been sending. The
histogram code needs a lot more love that it has been given ;-)

Note, I've been changing the subject lines of your patches to:

This one:

 [PATCH] tracing: Keep the entrty count when the histogram stats allocation fails

And for you other patches:

 [PATCH] tracing: Free histogram ...

As histograms are not a separate subsystem and just part of the tracing
subsystem. And all subjects should start with a capital letter.

> print_entries() uses n_entries both as the number of sort entries and as
> its own return value, so the -ENOMEM it stores when the stats allocation
> fails overwrites the count that the cleanup still needs:
> 
> 	n_entries = tracing_map_sort_entries(map, ...);
> 	if (n_entries < 0)
> 		return n_entries;
> 	...
> 			if (!stats) {
> 				n_entries = -ENOMEM;
> 				goto out;
> 			}
> 	...
>  out:
> 	tracing_map_destroy_sort_entries(sort_entries, n_entries);
> 
> tracing_map_destroy_sort_entries() takes an unsigned int and loops up to
> it, so -ENOMEM arrives as 4294967284. It walks an array of at most
> map->max_elts pointers and calls destroy_sort_entry(), which dereferences
> and frees, on whatever lies past the end.
> 
> Reading the hist file of a trigger with a .percent value, with that
> allocation forced to fail:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in tracing_map_destroy_sort_entries+0xa0/0xb0
>   Read of size 8 at addr ffffc90000045000 by task init/1
>    tracing_map_destroy_sort_entries+0xa0/0xb0
>    hist_show+0x6f7/0x1df0
>    seq_read_iter+0x2b8/0x1190
>    vfs_read+0x176/0xa40
>   The buggy address belongs to a 4-page vmalloc region starting at
>   ffffc90000041000 allocated at tracing_map_sort_entries+0x5c/0xd50
> 
> A few pages further the fault is fatal. The registers at the oops confirm
> the bound: the loop's end pointer less the array start, over the pointer
> size, is 4294967284.
> 
> Return the error in a separate variable and leave n_entries holding the
> count, the way tracing_map_sort_entries() does on its own error path.
> 
> The stats block is only entered for a value carrying .percent or .graph,
> which __create_val_field() has rejected since v6.3, so this cannot be
> reached in mainline as it stands. It becomes reachable again with
> "tracing: hist: let values keep the percent and graph modifiers", so it
> should be applied first.
> 
> Fixes: abaa5258ce5e ("tracing: Add .percent suffix option to histogram values")
> Cc: stable@vger.kernel.org

Please place the Cc stable above the fixes.

I'm not sure who is suggesting that but I'm seeing a lot of patches that do
that. To me, the Cc's (even to stable) should be the first thing in the
footer portion of the change log.

> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> ---
> Reproduced under QEMU x86_64 on 1fc5a74b108f, with the percent/graph patch
> applied so the block is reachable and with the stats allocation forced to
> fail. Before this change the read of the hist file never returns: KASAN
> reports the vmalloc-out-of-bounds quoted above and the kernel then takes a
> fatal page fault. After it the read returns, the histogram prints its
> header with no rows, and KASAN is silent.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20260907052113.430818-1-donggeunyoo.kernel@gmail.com/

Informative links should go above the '---' and be included in the git
commit. In fact, you should always add a reported-by if something informed
you of a fix. I'll be adding to this patch:

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260907053113.1CED91F00A3A@smtp.kernel.org/

-- Steve
