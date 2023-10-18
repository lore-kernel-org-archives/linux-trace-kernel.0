Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4C438BB0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0QdATYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E5CC433C8;
	Wed, 18 Oct 2023 15:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697641989;
	bh=gf1en1MFTQj6YIJHsRedci2J/yLMelSJ1cxQHEVixBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0QdATYk2ED50MAUiZZHQPGpZl6D5AjwJDSwNTxhENMbNDzpvyX5QPH5Lv05hrVxX
	 uN2oBcvkh9eyda1QNf5J2/NeJKqQq8BOzqtprSBqRE5z0eRG+415TYv00HYMwH8K2W
	 re+fMBRljLDEtvMo/DZ3jno8Dh/Mlihem7KeO15opsRt6ApcbFlW06kh8w7vD08U9c
	 OGa9ubWM8NjndwQT4kQV1RLDkQVHqS6XHOyTN2AaYKGYuKOVQ0t2xky+ktuBHkEv47
	 Qstpq5pMlzlQDVB2INsjCu/kfINN8YqAwZum2Ngt3AQHiSv66FTNY1fl/I/4wvx46B
	 SGaTtML3IAvwA==
Date: Thu, 19 Oct 2023 00:13:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc: linux-trace-kernel@vger.kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, naveen.n.rao@linux.ibm.com,
 rostedt@goodmis.org, peterz@infradead.org, akpm@linux-foundation.org,
 sander@svanheule.net, ebiggers@google.com, dan.j.williams@intel.com,
 jpoimboe@kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com,
 mattwu@163.com
Subject: Re: [PATCH v11 0/5] lib,kprobes: kretprobe scalability improvement
Message-Id: <20231019001303.befd514dd103d334527e1754@kernel.org>
In-Reply-To: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
References: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 17 Oct 2023 21:56:49 +0800
"wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:

> This patch series introduces a scalable and lockless ring-array based
> object pool to improve scalability of kretprobed routines.
> 
> v11:
>   *) patchset rebased to branch probes/core of linux-trace.git
>   *) objpool: objpool_fini optimized for better code readability
>   *) test_objpool: asynchronous releasing of objpool now covered
> 
> wuqiang.matt (5):
>   lib: objpool added: ring-array based lockless MPMC
>   lib: objpool test module added
>   kprobes: kretprobe scalability improvement with objpool
>   kprobes: freelist.h removed
>   MAINTAINERS: objpool added

OK, this version looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I'll pick this series on for-next branch.

Thank you,

> 
>  MAINTAINERS              |   7 +
>  include/linux/freelist.h | 129 --------
>  include/linux/kprobes.h  |  11 +-
>  include/linux/objpool.h  | 176 ++++++++++
>  include/linux/rethook.h  |  16 +-
>  kernel/kprobes.c         |  93 +++---
>  kernel/trace/fprobe.c    |  32 +-
>  kernel/trace/rethook.c   |  90 +++--
>  lib/Kconfig.debug        |  11 +
>  lib/Makefile             |   4 +-
>  lib/objpool.c            | 286 ++++++++++++++++
>  lib/test_objpool.c       | 689 +++++++++++++++++++++++++++++++++++++++
>  12 files changed, 1270 insertions(+), 274 deletions(-)
>  delete mode 100644 include/linux/freelist.h
>  create mode 100644 include/linux/objpool.h
>  create mode 100644 lib/objpool.c
>  create mode 100644 lib/test_objpool.c
> 
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
