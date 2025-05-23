Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769B297A61
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 May 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025860; cv=none; b=PPyC9sPiNgVhqZC20tFm2fygw1ouvZFzTV1NuSpAerb2azzqvGxEO+OM1Uuoi2srPukaOX46N57FPFdZvmv0vFwaEV7KE8a7RKqfJ5MAddo4bWe05QaU61ptYIftoETqtMDrSz3lkIHl3Yiq9dm2s5hdKpRlYgVDZ6BCR3GV9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025860; c=relaxed/simple;
	bh=dcUBeVOUSNwgxL49JtDJ+DtvLO83UW1Xz2Z2gm0CIXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRDwGnt0p9cGAYp3YX7ulf1U8uwg4BGKKfoYpIgevzuywNwS+9zcmYmtCD8NFkRGEmxpfOMdnTqu2oukDmou7jI1FM4KbfbDTj06yJNbzHcbgVN2vPDE9uOmQG/hAFSD7DTrr3C0tJHLzkEW8X7evFk0Zzcq03cnKdum/dgwoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938FDC4CEE9;
	Fri, 23 May 2025 18:44:19 +0000 (UTC)
Date: Fri, 23 May 2025 14:45:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [BUG] v6.12.4 copy_page_to_iter WARNING
Message-ID: <20250523144507.3d5649d0@gandalf.local.home>
In-Reply-To: <Z1hcOV5_xVEeAJxN@google.com>
References: <Z1hcOV5_xVEeAJxN@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 15:20:25 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Hi,
> 
> Running v6.12.4, I can trigger the following WARNING

Hi Vincent,

This is a very old email, but I just found it buried in my inbox ;-)

Are you still able to hit this? I just tried, and can't on the latest
kernel.

-- Steve

> 
> [   62.374530] WARNING: CPU: 0 PID: 133 at lib/iov_iter.c:344 copy_page_to_iter+0x44/0x148
> [   62.375388] Modules linked in:
> [   62.375747] CPU: 0 UID: 0 PID: 133 Comm: grep Tainted: G      D 6.12.4 #51
> [   62.376452] Tainted: [D]=DIE
> [   62.376732] Hardware name: linux,dummy-virt (DT)
> [   62.377147] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   62.377794] pc : copy_page_to_iter+0x44/0x148
> [   62.378196] lr : pipe_read+0x104/0x3d0
> [   62.378530] sp : ffff800083b7bc00
> [   62.378816] x29: ffff800083b7bc00 x28: 0000000000001000 x27: fff00000c21f73c0
> [   62.379494] x26: ffff800083b7bd60 x25: 0000000000000014 x24: 0000000000001000
> [   62.380171] x23: 0000000000000000 x22: fff00000c21f73e0 x21: 0000000000000015
> [   62.380891] x20: 0000000000001000 x19: 0000000000000000 x18: 0000000000000000
> [   62.381536] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [   62.382185] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [   62.382831] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [   62.383478] x8 : fff00000c1603400 x7 : 0000000000000000 x6 : 00000000000000a0
> [   62.384153] x5 : 0000000000000000 x4 : ffffc1ffc30867c0 x3 : 0000000000001000
> [   62.384798] x2 : 000000000000103f x1 : 000000000000003f x0 : ffffc1ffc30867c0
> [   62.385441] Call trace:
> [   62.385684]  copy_page_to_iter+0x44/0x148
> [   62.386091]  pipe_read+0x104/0x3d0
> [   62.386413]  vfs_read+0x294/0x2fc
> [   62.386728]  ksys_read+0xdc/0xf4
> [   62.387025]  __arm64_sys_read+0x1c/0x28
> [   62.387400]  invoke_syscall+0x48/0x110
> [   62.387759]  el0_svc_common.constprop.0+0x40/0xe0
> [   62.388178]  do_el0_svc+0x1c/0x28
> [   62.388525]  el0_svc+0x30/0xd0
> [   62.388818]  el0t_64_sync_handler+0xc0/0xc4
> [   62.389233]  el0t_64_sync+0x190/0x194
> [   62.389663] ---[ end trace 0000000000000000 ]---                 
> 
> With trace_pipe and grep.
> 
>  $ cat trace_pipe | grep foo
> 
>    and 
> 
>  $ while true; do echo "foo" > trace_marker; done
> 
> Is that a known problem? Eventually this ends up in a more serious BUG such as
> 
>    BUG: Bad page map in process cat  pte:72616d5f676e6963 pmd:800000102279003
> 
> Or.
> 
>    Unable to handle kernel paging request at virtual address fff82e2dee2e2d80

