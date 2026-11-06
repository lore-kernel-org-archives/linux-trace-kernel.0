Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975034;
	b=wAPt4N0jUM9nvcdTLh8DI+QJ013pQwcEmQGiY/iLrX2DQ9rJHSx59girPxUJCEFyTME9
	 bwE5qYV83Uw4QsyTtbpUIRsVT7/S7sTMhxP7iN+gWMQqQPT9UdMauqYnnVk9K4Cqyekyk
	 qi1mla04a0dTg4S4N5vA7C6dniIoFhAo/udmJ+mmz9Qn6PWrXd3QahDGcvYplqNH6cc9u
	 zwvuEh6g6YCrhjtzMG7PVgxom9ifNMWapOJdx9B6KVI7hm2JZ7DIsVOprgLn4ioDeI4sD
	 asVX5qGxjAYzKhY2IBKO+F91t8CECXqmWOtVUxwh4EmIqqp3kKwbGvq3cHWmgg3OQjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975034;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=GH/ncfbeQ7ilPdkBkVcg+I7LlA5i2bpzryJ/6Ye4fBU=;
	b=L+I4dXcP9p0K5DMEtVwgq+H+X5hKrp8Yhunvh5uPHmtdJbExpTStndFsWlmwlsjl8HhL
	 EfyGzTflZpDiKOT6VSbl+1cNqg5ZDSfo3zSLUo8Q2SelF8ykQn4IqDg9QPBDVUH7ldD1i
	 kPM1qBgIBaU1ftU0Y1u4zSbOZRzRRIeE+01h1wZjCyv6S6//jUWwXhbL07/TMBISUCg6g
	 RC0kks+A1MyykolC0zGlVeo7k/hkGzpGataBT+Ggv9Y0HyZMJFtGpslJVfc5fXU+Xzr+A
	 coo+7cqrQEf6v5eZCGmaKXlTGWC8JHSqvPDojaZJKC19hdfpPkBGW3VxhVSvT1syVBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SgAUGpj8;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45859606A329;
	Fri,  6 Nov 2026 14:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45859606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=SgAUGpj8
Received: from omf09.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 844281A0DF4;
	Fri,  6 Nov 2026 14:23:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id B83C420025;
	Fri,  6 Nov 2026 14:23:49 +0000 (UTC)
Date: Fri, 6 Nov 2026 09:23:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Martin Kaiser <martin@kaiser.cx>, Vinod Koul <vkoul@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [tracing]  b5cc230af5:
 WARNING:at_kernel/trace/trace_events.c:#test_double_dereference
Message-ID: <20261106092348.59ace6ed@gandalf.local.home>
In-Reply-To: <202611060303.c90f27a7-lkp@intel.com>
References: <202611060303.c90f27a7-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B83C420025
X-Stat-Signature: y11ur35snzacao1tnqfm81r83sfn7har
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UN5ph8eIV3VDT4wh6J+NcPTDpotMJOKE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=GH/ncfbeQ7ilPdkBkVcg+I7LlA5i2bpzryJ/6Ye4fBU=; b=SgAUGpj8ys0HxCP5kwoJGb3240Ut0DjtKgZO9XuDraiIkMS5H9WuxjTfzTBq9F+N+mBrA/CFysLM0Oh2tst8St9DWN2mMKv8HsIFpxoL/dAS310Avs1urC8fwrsyNJYeFTkYRF4lwK9sTWcaXiFgV9hCeAAWARNPAHxTzbA3l8k=
X-HE-Tag: 1793975029-751001
X-HE-Meta: U2FsdGVkX1/DnDILrB7JgUkuEp197qJHo0Ob0V+VXGwcXl0qzwjjatAqoJFSq79krvXWInlwj1AaYJucj/9HLeTD9pqfSY67KKctBP5IR8jIGsRg2taOfKekx6tmRa4To0N5/uHmWJD7Sjpy6u7iMbOcBvI5eXIoqImQqvzkrAp5LoDswIKXenXO7LNnNIJdqlPlxiZak9Zg5QH/wkuW7vJQzyJ/Rqyjf6E197x7xsiOTQhBWSj/pHWAtgLpjEO6p71BN+Iia8AMz6zmOOvBn5UohgrNpX357f//gYI5W8jT7P8zQxsa6wU8Iy7/3SlZLl7ECCubVR+x4oLyxVsKjF5LVuHkhY0nblvYSbudu8XkN1GJnoSC/oKDmZ9ktm5jsIsWObgfmK+JyfHiOAoBOCyFO15HJPRpi38DAT/yL26cjX5K6hOKZHKMlb/MVCT5YNkIm7s1kVQ=

On Fri, 6 Nov 2026 11:07:56 +0800
kernel test robot <yi1.lai@intel.com> wrote:

> Hello,
> 
> kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#test_double_dereference" on:
> 
> commit: b5cc230af5e536ff752f8bd5c30e23612936d5c3 ("tracing: Warn when an event dereferences a pointer in TP_printk()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

That commit warns when there's buggy events. The bot found one.

> 
> [test failed on linux-next/master ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-r2309-20261012
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu Cascadelake-Server-noTSX,enforce -smp 4 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202611060303.c90f27a7-lkp@intel.com
> 
> 
> [    0.808840][    T0] ------------[ cut here ]------------
> [    0.810236][    T0] Event hfi1_txq_complete has double dereference in TP_printk: REC->sde ? REC->sde->this_idx : 0

Yep, it caught a bug!

ECLARE_EVENT_CLASS(/* AIP  */
        hfi1_ipoib_tx_template,
        TP_PROTO(struct ipoib_txreq *tx, u32 idx),
        TP_ARGS(tx, idx),
        TP_STRUCT__entry(/* entry */
                DD_DEV_ENTRY(tx->txq->priv->dd)
                __field(struct ipoib_txreq *, tx)
                __field(struct hfi1_ipoib_txq *, txq)
                __field(struct sk_buff *, skb)
                __field(ulong, idx)
        ),
        TP_fast_assign(/* assign */
                DD_DEV_ASSIGN(tx->txq->priv->dd);
                __entry->tx = tx;
                __entry->skb = tx->skb;
                __entry->txq = tx->txq;
                __entry->idx = idx;
        ),
        TP_printk(/* print  */
                "[%s] tx %llx txq %llx,%u skb %llx idx %lu",
                __get_str(dev),
                (unsigned long long)__entry->tx,
                (unsigned long long)__entry->txq,
                __entry->txq ? __entry->txq->q_idx : 0,
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You must not dereference pointers in TP_printk(). That is a bug!

I'll send a patch to fix their trace event

-- Steve


                (unsigned long long)__entry->skb,
                __entry->idx
        )
);




> [    0.812882][    T0] WARNING: kernel/trace/trace_events.c:417 at test_double_dereference+0x95/0x100, CPU#0: swapper/0/0
> [    0.815697][    T0] Modules linked in:
> [    0.816602][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5+ #1 PREEMPT
> [    0.818731][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    0.821353][    T0] RIP: 0010:test_double_dereference (trace/trace_events.c:417 (discriminator 3))
> [    0.822786][    T0] Code: 30 e8 c9 27 fb ff 80 7b 01 3e 75 25 e8 be 27 fb ff 48 8b 7d d0 e8 75 fa ff ff 48 89 c6 48 8d 3d 8b 30 8f 06 4c 89 e1 44 89 f2 <67> 48 0f b9 3a eb 3b e8 99 27 fb ff 41 0f b6 c7 f6 80 00 a1 fd 85
> All code
> ========
>    0:	30 e8                	xor    %ch,%al
>    2:	c9                   	leave
>    3:	27                   	(bad)
>    4:	fb                   	sti
>    5:	ff 80 7b 01 3e 75    	incl   0x753e017b(%rax)
>    b:	25 e8 be 27 fb       	and    $0xfb27bee8,%eax
>   10:	ff 48 8b             	decl   -0x75(%rax)
>   13:	7d d0                	jge    0xffffffffffffffe5
>   15:	e8 75 fa ff ff       	call   0xfffffffffffffa8f
>   1a:	48 89 c6             	mov    %rax,%rsi
>   1d:	48 8d 3d 8b 30 8f 06 	lea    0x68f308b(%rip),%rdi        # 0x68f30af
>   24:	4c 89 e1             	mov    %r12,%rcx
>   27:	44 89 f2             	mov    %r14d,%edx
>   2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
>   2f:	eb 3b                	jmp    0x6c
>   31:	e8 99 27 fb ff       	call   0xfffffffffffb27cf
>   36:	41 0f b6 c7          	movzbl %r15b,%eax
>   3a:	f6                   	.byte 0xf6
>   3b:	80 00 a1             	addb   $0xa1,(%rax)
>   3e:	fd                   	std
>   3f:	85                   	.byte 0x85
> 
> Code starting with the faulting instruction ===========================================
>    0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
>    5:	eb 3b                	jmp    0x42
>    7:	e8 99 27 fb ff       	call   0xfffffffffffb27a5
>    c:	41 0f b6 c7          	movzbl %r15b,%eax
>   10:	f6                   	.byte 0xf6
>   11:	80 00 a1             	addb   $0xa1,(%rax)
>   14:	fd                   	std
>   15:	85                   	.byte 0x85
> [    0.827992][    T0] RSP: 0000:ffffffff87403d48 EFLAGS: 00010046
> [    0.829610][    T0] RAX: ffffffff87183110 RBX: ffffffff87dcba95 RCX: ffffffff87dcba82
> [    0.831687][    T0] RDX: 0000000000000021 RSI: ffffffff87183110 RDI: ffffffff87fe7ae0
> [    0.833687][    T0] RBP: ffffffff87403d78 R08: 0000000000000000 R09: 0000000000000000
> [    0.835822][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff87dcba82
> [    0.837895][    T0] R13: ffffffff87dcbaa3 R14: 0000000000000021 R15: ffffffff87dcb92d
> [    0.839689][    T0] FS:  0000000000000000(0000) GS:ffff8884a6e38000(0000) knlGS:0000000000000000
> [    0.841148][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.842182][    T0] CR2: ffff88843ffff000 CR3: 0000000007497001 CR4: 00000000000300b0
> [    0.843452][    T0] Call Trace:
> [    0.843961][    T0]  <TASK>
> [    0.844424][    T0]  test_event_printk (trace/trace_events.c:599)
> [    0.845211][    T0]  ? __pfx_trace_event_raw_init (trace/trace_events.c:640)
> [    0.846111][    T0]  trace_event_raw_init (trace/trace_events.c:650)
> [    0.846904][    T0]  event_init (trace/trace_events.c:3384)
> [    0.847591][    T0]  trace_event_init (trace/trace_events.c:4857 trace/trace_events.c:4950)
> [    0.848366][    T0]  trace_init (trace/trace.c:9957)
> [    0.849014][    T0]  start_kernel (main.c:1071)
> [    0.849736][    T0]  x86_64_start_reservations (x86/kernel/head64.c:310)
> [    0.850600][    T0]  x86_64_start_kernel (x86/kernel/head64.c:291)
> [    0.851419][    T0]  common_startup_64 (x86/kernel/head_64.S:418)
> [    0.852218][    T0]  </TASK>
> [    0.852686][    T0] irq event stamp: 0
> [    0.853291][    T0] hardirqs last  enabled at (0): 0x0
> [    0.854409][    T0] hardirqs last disabled at (0): 0x0
> [    0.855533][    T0] softirqs last  enabled at (0): 0x0
> [    0.856645][    T0] softirqs last disabled at (0): 0x0
> [    0.857758][    T0] ---[ end trace 0000000000000000 ]---
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20261106/202611060303.c90f27a7-lkp@intel.com
> 
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

