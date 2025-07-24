Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840572D8DC0;
	Thu, 24 Jul 2025 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363732; cv=none; b=gGil2drJRO2G1bXpNyRro2DPsDS4H051jSGVCsgBJ3wPV60ITXUZ72IZRaoLvuAdSHZvAj3Di6qST8xw4TBly5sR+KfDx4FGQBQCB5bCnsieDlO38GVdf/8pj8Q+Ip8yTQHhar0US6p0jUuMA6xB3H41eEfkOHtp02G/GI1ed00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363732; c=relaxed/simple;
	bh=vV62/6+8qhjhjo2/XqTRg9qrR4S18P9SqG3ZCVFf4q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIzhtkbcFNHUvadE3rGXUAkCSxfC+sP63KVymehHi6AAcRntzD2IcX28SGodSYASsydUKe688DXlzCzDGWEJEGzscft4qzN4EMKpOg81EAWr/aDZMztXKtFEa2XnkMVZSqCRhXCy94mIwKrEPxc5LoJWzGpQTqtIkWLXk1uy2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id DDE751DA81B;
	Thu, 24 Jul 2025 13:28:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id C889820025;
	Thu, 24 Jul 2025 13:28:46 +0000 (UTC)
Date: Thu, 24 Jul 2025 09:28:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/thp: tracing: Hide hugepage events under
 CONFIG_PPC_BOOK3S_64
Message-ID: <20250724092847.1aa83756@batman.local.home>
In-Reply-To: <20250612101259.0ad43e48@batman.local.home>
References: <20250612101259.0ad43e48@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C889820025
X-Stat-Signature: wwqsp3ycupd37f9jfqojdzid69kub8ro
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+rR41YkZ4vfPDuaVGPm5LjEQ+o87duC2E=
X-HE-Tag: 1753363726-693272
X-HE-Meta: U2FsdGVkX19TwKwFZE33d1YoVfppyNpdv/tncGvkHsZwMXaWnKE14AaArR6yFSehWaptxorH5BRbkpqvjBpmgqIAkUbK4csDkVsaN/jxHJXJ24Uoln1FdOMJaLuV2+u+trOzamfPkgOJv6Fg6/08hRiLVz4wABcvUtwkD9Hki9pHTrrBht/0CUs8D96Do1EtswbMe+r093l7NiwM9NKNTeUdKUn2kVYjcFgtRgfFyk2W3RNViePsGFdTzB8iGRYr+RgIELl2fhr2Jv6JvcDoUxlpuf/xhrurqovaYpdqHxpbdbfRIk9Xi8QmqXkOK6EsFengFjcaV3RveOifvzgL9a0HEnOL6JIDZQucAmMhUwXijoyEF3xPUnyjG854LrQ/Sl+ORHuGs/CDnzUlprRh2JC38MpQXAZC


Anyone have any issues with this patch? Should I take it in my tree?

-- Steve


On Thu, 12 Jun 2025 10:12:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The events hugepage_set_pmd, hugepage_set_pud, hugepage_update_pmd and
> hugepage_update_pud are only called when CONFIG_PPC_BOOK3S_64 is defined.
> As each event can take up to 5K regardless if they are used or not, it's
> best not to define them when they are not used. Add #ifdef around these
> events when they are not used.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Note, I will be adding code soon that will make unused events cause a warning.
> 
>  include/trace/events/thp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
> index f50048af5fcc..c8fe879d5828 100644
> --- a/include/trace/events/thp.h
> +++ b/include/trace/events/thp.h
> @@ -8,6 +8,7 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
>  DECLARE_EVENT_CLASS(hugepage_set,
>  
>  	    TP_PROTO(unsigned long addr, unsigned long pte),
> @@ -66,6 +67,7 @@ DEFINE_EVENT(hugepage_update, hugepage_update_pud,
>  	    TP_PROTO(unsigned long addr, unsigned long pud, unsigned long clr, unsigned long set),
>  	    TP_ARGS(addr, pud, clr, set)

>  );
> +#endif /* CONFIG_PPC_BOOK3S_64 */
>  
>  DECLARE_EVENT_CLASS(migration_pmd,
>  

