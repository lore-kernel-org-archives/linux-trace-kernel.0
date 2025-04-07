Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F218DB2B;
	Mon,  7 Apr 2025 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743990038; cv=none; b=mrhEx6bX4RTV4o2oZCMXEqjHqXeH37hWKc7ugr5ihPitSP2+0cEjLmnyQbEI0nVjyHt8SfAUixSOJdZiAW80aJXAgk8GNw7+RXiwbJwWJjz1rxG5DOW7v7BAZ8mrsbJ4EBYafBh/O+vkbc4k6tD57gunBjHrFlBtkfmazbqXSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743990038; c=relaxed/simple;
	bh=Okrp/iU8s6vx/iSN7wKtk1uNblTS/UT+9eq+ZTcQgRM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OpVqa+LFrCncV3c6tXwIYn98MIAueNqtL1U8hpO1mbH/aAzeAaecDKd4suqbayBrNeOpQKBVtDOBlJ4x7ItlcCNFS9sA6YB+zHsaU5pK2lh7ommq/Cdehh3jba0Xmf1hUlXNJ3SvOXDI1Gz0IibGN0Ro2qJTBOooMIAMqbcXg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N170TU05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N170TU05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B3AC4CEE9;
	Mon,  7 Apr 2025 01:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743990037;
	bh=Okrp/iU8s6vx/iSN7wKtk1uNblTS/UT+9eq+ZTcQgRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N170TU05rFjJdB/HBNmWwg/z2F0XYYkqY3cPK/MtzcCOjJ+8KUi2KSicxFKj5ehjX
	 uuJ7tEaWnOKzotfF0U//ksEQkSNP3lTaIrAwEiYqTeXqfrb0u1ogba9kQuC2v6qF5I
	 ZAULcNMzdLVfXer4yssF5hWk6/1lCN0vt1n5fdui5Xunx5UewUqJQrF4o3gSV2HLWx
	 uEXdejAaLsckmYuwa2lOUKi/XrLhmA9SARJgH54Cl3kNf0toxo2cOMGPI60g3kqUT4
	 s+qMHRXh2WjVeQ4p0+zn12l4q1sCte6EsIe2+3Yz8FcW6ZNMg6jEYOYJzS0GYagYw1
	 RGMT3BOMoDRgQ==
Date: Mon, 7 Apr 2025 10:40:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] mm/memblock: Add reserved memory release
 function
Message-Id: <20250407104032.162f1d10e9ab885c72bfac8c@kernel.org>
In-Reply-To: <20250407093351.5514960330bebbe07b707431@kernel.org>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
	<173989133862.230693.14094993331347437600.stgit@devnote2>
	<20250405023018.g2ae52nrz2757b3n@master>
	<20250407093351.5514960330bebbe07b707431@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 09:33:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> But this is fragile by design. As I did for lib/bootconfig and
> tools/bootconfig, you should use __KERNEL__ and makes it not depending on
> the kernel header files because it does not expected to be used in user
> space.
> Even if I added mutex.h, it stopped with another reason.
> 
> test -L linux/memblock.h || ln -s ../../../../include/linux/memblock.h linux/memblock.h
> test -L asm/asm.h || ln -s ../../../arch/x86/include/asm/asm.h asm/asm.h
> test -L asm/cmpxchg.h || ln -s ../../../arch/x86/include/asm/cmpxchg.h asm/cmpxchg.h
> cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o main.o main.c
> test -L memblock.c || ln -s ../../../mm/memblock.c memblock.c
> cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o memblock.o memblock.c
> memblock.c: In function 'memblock_add_range.isra':
> memblock.c:685:17: warning: 'end_rgn' may be used uninitialized [-Wmaybe-uninitialized]
>   685 |                 memblock_merge_regions(type, start_rgn, end_rgn);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> memblock.c:591:42: note: 'end_rgn' was declared here
>   591 |         int idx, nr_new, start_rgn = -1, end_rgn;
>       |                                          ^~~~~~~
> cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o lib/slab.o lib/slab.c
> cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o mmzone.o mmzone.c
> cc -I. -I../../include -Wall -O2 -fsanitize=address -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT   -c -o slab.o ../../lib/slab.c
> ../../lib/slab.c:6:10: fatal error: urcu/uatomic.h: No such file or directory
>     6 | #include <urcu/uatomic.h>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: slab.o] Error 1

Ah, sorry. This is from liburcu. I installed the package and fixes the issue.
Let me send the patch.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
