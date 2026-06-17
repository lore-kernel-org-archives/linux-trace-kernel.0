Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0533859A;
	Wed, 17 Jun 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689249; cv=none; b=RSV//R7cqndh/oTEGP/fvH3RT0WHrxgvLw0MegZZJVLwjDcRV6R9QEOVl8ovC1ze5hLVia7KD1yEOJmfRpyV+lb3xs1vKItmD3Cl/5Wh4e+Q06AzI9iTnZIuhLUnDHa1xoUnAm8pQQz6rj5TsccIhQ5n2DvpdZNg5D7HlwCF3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689249; c=relaxed/simple;
	bh=aIQ0rqYNiHXa9y7GmYvya0yl5Baj2l98FKvSvypf6fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeM0SBN4h8wpxIsYRCwFdQdq63AgNS4q5nZtVusHQQjOvLX3drKA08X4U8sJwnSiv4DSEBGRYwk2tYpbrmzd7iUYmr67wCQyfjN93gEGQIFapPNQ4O1UWG36dy0uhojBbXKxGKB3M4shxDAqI755MIjAYsRz7XThVmH5Ob6oa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a1NqyOZT; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a1NqyOZT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=o/OJ3K9rTkOIlY7WWVITVWwnzTwDC6V7F9kkJkXQoTo=; b=a1NqyOZTRvdH/2jRwOv2SEzPR4
	w9g+aT75GU3bVUstqfQFMqP3TvZgSLyAKzSpai1RgWWTlBC4ZgxP0AB9tB2i2GqbQzG6I7zVdv0U5
	r0eur5xDS7+7NiOIhnRSxPyGwzObWhKDLsAN57WGenyNSjVpZLcwBF7rMI0hVwbpz8jWJ3MsKwFxh
	5n1GUJfkhzzJkXhsX6JsqcjeITzTZeuCnQVrDr5OkehVDKWLgFLskCp+Lb2PTJRkP23suSb6xkAOh
	SR/lRmnaBOYtaw+7wAg8VeK2X1ur7ef62V/PCw1l+r7UuAAmSCooAWiSCshP2FTuujBJmPysig/9D
	CiFgGAKw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZmkn-00EWde-0g;
	Wed, 17 Jun 2026 09:40:13 +0000
Date: Wed, 17 Jun 2026 02:40:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v9 0/6] mm/memory-failure: add panic option for
 unrecoverable pages
Message-ID: <ajJq-uVRBH5SBkwK@gmail.com>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
X-Debian-User: leitao

On Tue, Jun 09, 2026 at 03:56:54AM -0700, Breno Leitao wrote:
> A multi-bit ECC error on a kernel-owned page that the memory failure
> handler cannot recover is currently swallowed: PG_hwpoison is set, the
> event is logged, and the kernel keeps running.  The corrupted memory
> remains accessible to the kernel and either drives silent data
> corruption or surfaces seconds-to-minutes later as an apparently
> unrelated crash.  In a large fleet that delayed, unattributable crash
> turns into significant engineering effort to root-cause; in a kdump
> configuration, by the time the crash happens the original error
> context (faulting PFN, MCE/GHES record, page state) is long gone.
> 
> This series adds an opt-in sysctl,
> vm.panic_on_unrecoverable_memory_failure, that converts an
> unrecoverable kernel-page hwpoison event into an immediate panic with
> a clean dmesg/vmcore that still contains the original failure
> context.  The default is disabled so existing workloads see no
> change.
> 
> There is a selftest that test different cases, and I tested it using
> the following variants:
> 
>   ┌─────────┬──────────┬───────────────────────────────────────────────────────────┐
>   │ Variant │   PFN    │                          Result                           │
>   ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
>   │ rodata  │ 0x2600   │ Panic with "Memory failure: 0x2600: unrecoverable page"   │
>   ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
>   │ slab    │ 0x100032 │ Panic with "Memory failure: 0x100032: unrecoverable page" │
>   ├─────────┼──────────┼───────────────────────────────────────────────────────────┤
>   │ pgtable │ 0x100000 │ Panic with "Memory failure: 0x100000: unrecoverable page" │
>   └─────────┴──────────┴───────────────────────────────────────────────────────────┘
> 
> Each one shows the same call trace, exactly the path the series builds:
> 
>   hard_offline_page_store
>     → memory_failure
>       → action_result
>         → panic("Memory failure: %#lx: unrecoverable page")

Debugging another issue earlier today, just found a kernel crash that is
hitting a ignored page later in the day, and randomly misbehaving/crashing.

 Memory failure: 0x140ae: unhandlable page.
 Memory failure: 0x140ae: recovery action for get hwpoison page: Ignored                     <-- Ignored 
 loop0: detected capacity change from 0 to 15241056
 EDAC MC0: 1 UE multi-bit ECC on LP5x_0 LP5x_0 (node:0 card:0 module:0 rank:0 bank:2 device:28 row:42700 column:96
 {3}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 308
 {3}[Hardware Error]: event severity: recoverable
 {3}[Hardware Error]:  imprecise tstamp: 2026-06-16 02:50:03
 {3}[Hardware Error]:  Error 0, type: recoverable
 {3}[Hardware Error]:   section_type: memory error
 {3}[Hardware Error]:   physical_address: 0x0000000aeccde180
 {3}[Hardware Error]:   physical_address_mask: 0xfffffffffffff000
 {3}[Hardware Error]:   node:0 card:0 module:0 rank:0 bank:2 device:28 row:42700 column:960 requestor_id:0x0000000
 {3}[Hardware Error]:   error_type: 3, multi-bit ECC
 {3}[Hardware Error]:   DIMM location: LP5x_0 LP5x_0
 Memory failure: 0xaeccd: recovery action for dirty LRU page: Recovered

 Internal error: synchronous external abort: 0000000096000410 [#1]  SMP
 Modules linked in: ghes_edac(E) squashfs(E) act_gact(E) sch_fq(E) tcp_diag(E) inet_diag(E) cls_bpf(E) evdev(E) sm
 CPU: 51 UID: 0 PID: 1 Comm: systemd Kdump: loaded Tainted: G   M       OE K     6.16.1-0_fbk2_0_gf40efc324cc8 #1
 Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE, [K]=LIVEPATCH
 pstate: 834010c9 (Nzcv daIF +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
 pc : clear_inode+0x34/0x108
 lr : proc_evict_inode.llvm.1771226604092943895+0x28/0x68
 sp : ffff800083f6f8d0
 x29: ffff800083f6f8e0 x28: 0000000000000011 x27: ffff0000c1378788
 x26: ffffffffffffffff x25: ffff800082747de0 x24: ffff0000c0ae9898
 x23: ffff8000819155f8 x22: ffff0000c0ae9888 x21: ffff0000c0ae9808
 x20: ffff0000c0ae9818 x19: ffff0000c0ae9788 x18: 000000000000001c
 x17: 0000000000000018 x16: 0000000000000040 x15: 0000000000000000
 x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000002710
 x11: ffff0000c0ae9898 x10: ffff0000c1299b58 x9 : 0000000000000001
 x8 : ffff0000c0ae9900 x7 : ffff8000828db000 x6 : 0000000000005040
 x5 : ffffffffffffffff x4 : ffffffdfc05c8aa0 x3 : ffff000126470000
 x2 : ffffffffffffffff x1 : 0000000000000000 x0 : ffff0000c0ae9788
 Call trace:
  clear_inode+0x34/0x108 (P)
  proc_evict_inode.llvm.1771226604092943895+0x28/0x68
  evict+0xec/0x328
  iput+0xa8/0x310
  dentry_unlink_inode+0xa4/0x188
  __dentry_kill+0x74/0x358
  shrink_dentry_list+0xc8/0x198
 ....
