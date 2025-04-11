Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFA259491;
	Fri, 11 Apr 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396341; cv=none; b=dAqZgue84mhdj4cux5j6X/doc11x8oM7zQHJJdNLuZQb6PSuIuAXR5vxDdm9IaKHGWn9HHmZsY+USVpgjUgVLpwnjTkOiVc3eGNxiv6BmyCtDqJtMFFIg/X0M0dQc6MX93wmdqhmxgj/m1Ty99rXCOp1+zNd2dFkx8boCj7uaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396341; c=relaxed/simple;
	bh=/S5WyIP5TkvY1lFU2S/lSS4J4IPMIoyh+otbxcxq0PA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIc/b+HcJMrzEMhWG75noa4V9HfGmR6G6KfVZVG2i1J907s9Yz0NnLIFqoHeg5pzs7ApY8DXHRJsm0ysa1imUng/wLqdQdXGdD2xIXwcOxK98rqSqKCSQDWm2RCNrYTqCUkEvmSyTdIYsZ4IA2Wfw0fpPdJcZisGBMgmnY4QAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB73C4CEE2;
	Fri, 11 Apr 2025 18:32:19 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:33:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
Message-ID: <20250411143344.6ae21943@gandalf.local.home>
In-Reply-To: <20250411173328.8172-1-Liam.Howlett@oracle.com>
References: <20250411173328.8172-1-Liam.Howlett@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 13:33:28 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> MEMORY MAPPING does not list the mmap.h trace point file, but does list
> the mmap.c file.  Couple the trace points with the users and authors of
> the trace points for notifications of updates.
> 
> Cc:Andrew Morton <akpm@linux-foundation.org>
> Cc:Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc:Vlastimil Babka <vbabka@suse.cz>
> Cc:Jann Horn <jannh@google.com>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c7fdc41a6bfb..d8e9a10adc81d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	include/trace/events/mmap.h

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  F:	mm/mlock.c
>  F:	mm/mmap.c
>  F:	mm/mprotect.c
