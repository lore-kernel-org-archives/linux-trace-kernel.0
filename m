Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B127E8
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712610790; cv=none; b=kdVCL673ZySHP95a6Nt4Cy4cqoyX5Ymtt//0ZRSiVspPsFZirOmNB1670HQdGavu6xuxLbuMcRO62Io5Bs7Y1aDv92NKVk+0XQVIGTwRiwLgqIBurDbhUHtgNqhfeEZSO6mep9YP3kEDoeabB1RQl1C3A3kcGm7BMaivKzTFDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712610790; c=relaxed/simple;
	bh=3HBPHjqBlTJQ8GA62J3dwHHTdwgGwyG6YNrro7MYCrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=apKusL4iHty8lZJFspaA4aU3TNsjdTXhA7BAAXUcSxW5Py5ws1hPtywV1YlZxLIwVTjeszxWWim1lcAb2eZx+8IWv9f7U2ZGn+Bn5Q6gRJmrFSsaEuXaapLhfluFEcWCfZcddvurZWvjVKbl8TPOu2ULAc/PEy4lGYyNbruhuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.90] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id twGFrZZEAUWUFtwGGrUO5Q; Mon, 08 Apr 2024 14:10:42 -0700
X-CMAE-Analysis: v=2.4 cv=H/oQwPYi c=1 sm=1 tr=0 ts=66145d53
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=bv5mqyoQTMx-qQ9dIWAA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <a51419a5-5685-4a6b-8467-be8d3837c519@squashfs.org.uk>
Date: Mon, 8 Apr 2024 22:10:36 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UBSAN array-index-out-of-bounds in read_blocklist
To: Ubisectech Sirius <bugreport@ubisectech.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
References: <87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com>
Content-Language: en-GB
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <87f5c007-b8a5-41ae-8b57-431e924c5915.bugreport@ubisectech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPHxFGFdCEUayiJ5NuoGSj++Zmq6KWIhIogShVOmcnXEPEVaH6TVQn/nUfM+rv/87RuwNtK2D5x3bjQfgBf/+e5Jm9jrx2O3Bf2M+K2aNLTM4LUAITXL
 LlyYqeNFStHNlnlmnUhizYfwoPP1WGR4sILHFnbFZS48FSrulr+Zgu2NL5xJJCLbEQlXUn0+H8J34+sNFi/X53XjXrykE4mem1EvpB/+BHAPJ6qnsEODPidv
 Rg3LGMlP6vxa4hOYHtRRorvBxU2a3/RgpVbfXAc3ThtZ4l07TeQQF4J193jq9ETF

On 08/04/2024 01:56, Ubisectech Sirius wrote:
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8. Attached to the email were a PoC file of the issue.
Hello,

I have found the cause of the problem and fixed it.

A patch will be sent to the LKML shortly.

Thanks

Phillip

Squashfs maintainer.

> 
> Stack dump:
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in fs/squashfs/file.c:256:34
> index 4294967295 is out of range for type 'meta_entry [127]'
> CPU: 1 PID: 16927 Comm: syz-executor.0 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_out_of_bounds+0xd5/0x130 lib/ubsan.c:347
>   fill_meta_index fs/squashfs/file.c:256 [inline]
>   read_blocklist+0x175e/0x1790 fs/squashfs/file.c:333
>   squashfs_readahead+0x14fa/0x22d0 fs/squashfs/file.c:591
>   read_pages+0x1a2/0xd70 mm/readahead.c:160
>   page_cache_ra_unbounded+0x477/0x5f0 mm/readahead.c:269
>   do_page_cache_ra mm/readahead.c:299 [inline]
>   page_cache_ra_order+0x772/0xa00 mm/readahead.c:544
>   do_sync_mmap_readahead mm/filemap.c:3153 [inline]
>   filemap_fault+0x1691/0x3390 mm/filemap.c:3245
>   __do_fault+0x108/0x490 mm/memory.c:4396
>   do_read_fault mm/memory.c:4758 [inline]
>   do_fault mm/memory.c:4888 [inline]
>   do_pte_missing mm/memory.c:3745 [inline]
>   handle_pte_fault mm/memory.c:5164 [inline]
>   __handle_mm_fault+0x340a/0x48b0 mm/memory.c:5305
>   handle_mm_fault+0x3c2/0xa40 mm/memory.c:5470
>   do_user_addr_fault+0x2ed/0x1010 arch/x86/mm/fault.c:1355
>   handle_page_fault arch/x86/mm/fault.c:1498 [inline]
>   exc_page_fault+0x99/0x180 arch/x86/mm/fault.c:1554
>   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7f8446a28202
> Code: 48 63 c3 5b c3 0f 1f 00 f3 0f 1e fa 48 89 7c 24 f0 48 89 74 24 e8 48 89 54 24 e0 48 8b 4c 24 f0 48 8b 54 24 e8 48 8b 74 24 e0 <8b> 41 40 23 81 00 01 00 00 f3 0f 6f 06 c1 e0 06 48 01 d0 0f 11 00
> RSP: 002b:00007f8447755018 EFLAGS: 00010212
> RAX: 00007f8446a281e0 RBX: 00007f8446bcbf80 RCX: 0000000020ff0000
> RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000020ff0000
> RBP: 00007f8446af14a6 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020ff0000 R11: 0000000020000000 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f8446bcbf80 R15: 00007f8447735000
>   </TASK>
> ---[ end trace ]---
> 
> Thank you for taking the time to read this email and we look forward to working with you further.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 

