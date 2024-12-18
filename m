Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781D1E4A4;
	Wed, 18 Dec 2024 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482382; cv=none; b=FuOLdH34SMJQVCSfIgBrIFl01F3X+YKJ+DFag2XSlc8dugqQdcyfLHF4dSoVfwQ6U2XfkpU8QmD5+Tiy7kaDm+IXWwY8Fs1dqTrzbDc5B3VNZQ+iqNWSEd2gfhVlhPGCGBeS7YTHHECziQef/zEn2eEXH85h9AbNwv78R21RixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482382; c=relaxed/simple;
	bh=yejb2pHgJGWC4HT1gSlorFabtbvhdnOZEJL5HwO/QzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoywJy7MMvIOGQU1ast7tZcUS3X6yoKN0+fUyndrWpSEY1YKj1TfwSglLDCIj8u6LaDd4XECU346xx8FCkkK7ymq11Qux/3O3PXA7Jexaqq2NYplm4QrFVZwSgb89AyWx7zttvwF3cMMxMh88wv/BJSKN/EPbxUtUXOEetwDV64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043DC4CED3;
	Wed, 18 Dec 2024 00:39:39 +0000 (UTC)
Date: Tue, 17 Dec 2024 19:40:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, Vincent Donnefort <vdonnefort@google.com>,
 Jeongjun Park <aha310510@gmail.com>, david@redhat.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Message-ID: <20241217194015.7a4f0dc8@gandalf.local.home>
In-Reply-To: <tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
References: <20241217124602.2d498c3f@gandalf.local.home>
	<tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 07:43:46 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> > 
> > A proper fix is being discussed here:  
> First, my fix is the first one.

Yes I saw that.

> Second, the root cause of the problem is an overflow when calculating nr_pages.
> > 
> > https://lore.kernel.org/linux-trace-kernel/20241216164931.57323-1-aha310510@gmail.com/
> > 
> > Thank you,
> > 
> > -- Steve
> >   
> The calculation of nr_pages below overflows because the pgoff value is 8,
> the nr_subbufs value is 3, and the subbuf_order value is 0.

So basically you are saying that passing in the the mmap with the pgoff is
what's causing it.

> > >  	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
> > >  
> > >  	nr_vma_pages = vma_pages(vma);  


Thanks, I believe I now have a reproducer. And yes, I'll take your patch.
(If Vincent is OK with it).

Here's the reproducer:

------------------------8<-------------------------
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <asm/types.h>
#include <sys/mman.h>

int main(int argc, char **argv)
{
	int page_size = getpagesize();
	int fd;
	void *meta;

	system("echo 1 > /sys/kernel/tracing/buffer_size_kb");
	fd = open("/sys/kernel/tracing/per_cpu/cpu0/trace_pipe_raw", O_RDONLY);

	meta = mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, page_size * 5);
}
------------------------>8-------------------------

Thanks,


-- Steve
