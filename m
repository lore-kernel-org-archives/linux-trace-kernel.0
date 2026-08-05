Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCA47AF6B;
	Wed,  5 Aug 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963992; cv=none; b=TjYPNajBmSdQ4ys2Jm5iGVzAOkMuXumfSaNj5lkkbmfSOgiZLOvilzjVgaNaCjd8k4fB6Zq7kz3L5217udJDJbBM+esnHmXPQumbkGQoe/nMUMZ/XFOral0Fm814irtVlDEOLpa1vJ3oqmL7VTilqrHISLs8g2at7CEUS80sEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963992; c=relaxed/simple;
	bh=vR8v1HB6vHfAx3UFYBMiXSAqlFQbGWiRiBE7ygNsKo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idWX0PWLL/ZXI0dgeS4ETd5n9OdH7/Zb7z2yY/INb+tx9ek3Ra7QsKhEOlNgHpanbt93dDr0bEsjpHrXsxGWTnEDyVlyDKt9SF0tLg5TB6GCs7dH7AiAv7iflNUztviZ45UJi5DohCQFKYokgEilu2oSa50UGZJ+w+e8O60aan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmgJosYJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmgJosYJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HliGc242656;
	Wed, 5 Aug 2026 21:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MnNlJnwNEbaWAhNe10RMM2Hm3czTJI
	ZlmlKOX4SOdZA=; b=CmgJosYJKx7d6qJ4xxPT504Z8RlivMC6HmiczNj1Y0RdRc
	yGprdyg38KpfCUHYIXLJDQbqZy7aQR80GL/xalySH1eTSC2119PI1XggWpKXsZqu
	GpFWRymcaLhPMUBGYwUFpMVm7OO/JwzNBtts1pnYNxLG89R7NwWmiICQMv+8WoUq
	fTDH/OtmlwXN0etnp8mdTDQy7xXxrcVRc+fTz0oJBgfelzrqJvaR7L+Joj2HV2Wg
	sj8a03B6DiYoP8GtZfj6cQjdigCSwp1kHLxXcUVy/VqlqZsj8rx1oidECHedcpTM
	okEdtIUazhZfuxolcnOs1yzh/YtT3FSVbVLzL2tQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gcndq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 21:06:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675KuNC3014882;
	Wed, 5 Aug 2026 21:06:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhg8r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 21:06:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675L6G7449938862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 21:06:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A2E820043;
	Wed,  5 Aug 2026 21:06:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEF2320040;
	Wed,  5 Aug 2026 21:06:15 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.1.132])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 21:06:15 +0000 (GMT)
Date: Wed, 5 Aug 2026 23:06:14 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anNTRb2aGsvY8_Rf@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE3MCBTYWx0ZWRfX6/iILxyG8vwF
 qKBtE1qqqKCAWqlzd5zh9ME1PLJ1DaEhvHG5NkeItHyhkermRqpJtZIZlaXzfa0CkXXHuJB5E8e
 MI09+piDZdhtQVM8UkeU50fxV5ku8vtBxe2zMANF5EqkRU9DdaUZWRJ0N1uHgWBON6gPun0oQ4H
 HPg1WX48hL5A9OmEhR6P61fiNjuFV/YLwY2mTAmwecE7wuVj09RH9ki3RWpqqIE9maS7mgQ1Jwx
 24djYPk7/W8y32jq4S7H7+Ldfd+5B+SutbKRgdfEqNDP/E6GIz7myvnZPsSIPVkthBtTythVEDJ
 wHskebB98JIvEW40Hm0Oc4F1MkCthlUB91UDPI0p9qWe4tzOcEbZk/7QkurG/UBwNo9HPsP89rR
 e9reRIM1FjPyfK/mdpbVZJCQRcCSqWF2LQdtrNwPYzW7OfExBPPYumkGJcfZ8XZTQMqT1BQbbU4
 1RdjdtRIu4qabdDVCBw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a73a5cd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rEqGk-WHAAAA:20
 a=VnNF1IyMAAAA:8 a=lX0LuPYzzneyE7TRBqcA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: hszUd7bL67QV3l73L8vVZ6SiuFk43RJa
X-Proofpoint-ORIG-GUID: hszUd7bL67QV3l73L8vVZ6SiuFk43RJa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE3MCBTYWx0ZWRfX6Jdp5RcTR/iw
 MWoDLO/tvX3RcYlUaBtgyYKNe2LVBzUTc0W9SIJNg24te6L0H1Vbabkj+JqMPbcZF/iC1TaxzSu
 i567NCKihTx1oGyWLFWW1/1A+/uYLkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050170

On Wed, Aug 05, 2026 at 05:14:13PM +0200, Oleg Nesterov wrote:
> On 08/05, Sumanth Korikkar wrote:
> >
> > bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe {
> > printf("%s\n", str(arg1) ); exit(); }'
> 
> I am hoping that Andrii and Jiri (cc'ed) can take a look, I know nothing
> about usdt... And TBH, I don't even know what RELRO is ;)

Thank you Oleg and Andrii for the feedback.

As far as I understand, relro segment contains the following sections
in the usdt_semaphore_test binary (s390)
.init_array, .fini_array, .dynamic, .got.

ld.so dynamic linker resolves all the relocations and fills in the got
and then calls mprotect() to make the relro region read only. This
prevents runtime modification of these data.

> Let me ask a couple of questions for now.
> 
> > expects a semaphore increment of 1, but semaphore gets double incremented
> >
> > Test program:
> > https://github.com/bpftrace/bpftrace/blob/master/tests/testprogs/usdt_semaphore_test.c
>
> Perhaps you can provide the test-case which I could compile on my
> machine without libbpf-usdt/usdt.h?
> 
> And can you explain what the bpftrace cmd above actually does? I mean,
> where does it put the uprobe? I guess the ref_ctr_offset argument of
> uprobe_register() refers to USDT_DEFINE_SEMA() in that test-case...

Right.

usdt_semaphore_test elf contains the following information in notes
section:
Displaying notes found in: .note.stapsdt
  Owner                Data size        Description
  stapsdt              0x00000039       NT_STAPSDT (SystemTap probe descriptors)
    Provider: tracetest
    Name: testprobe
    Location: 0x0000000001000742, Base: 0x00000000010007d4, Semaphore:
    0x0000000001002024
    Arguments: -8@%r1 8@%r2

bpftrace and libbpf reads the uprobe offset and semaphore location from
.note.stapsdt and calls bpf_uprobe_multi_link_attach()

bpf_program__attach_usdt()
bpf_program__attach_uprobe_multi()
bpf_link_create()

kernel side:
@[kprobe:__update_ref_ctr,
        __update_ref_ctr+0
        update_ref_ctr+242
        uprobe_write+596
        uprobe_write_opcode+76
        set_swbp+42
        install_breakpoint+106
        register_for_each_vma+712
        uprobe_register+308
        bpf_uprobe_multi_link_attach+956
        link_create+506
        __sys_bpf+678
        __s390x_sys_bpf+72
        __do_syscall+360
        system_call+114
]

bpftrace -e 'kfunc:uprobe_register { printf("offset=0x%llx
ref_ctr_offset=0x%llx\n", args.offset, args.ref_ctr_offset); }'

offset=0x742 ref_ctr_offset=0x1024

> > Reason: .text mapping and RELRO mapping resolve to the same page aligned
> > file offset 0
> > 01000000-01001000 r-xp 00000000 5e:01 usdt_semaphore_test (.text)
> > 01001000-01002000 r--p 00000000 5e:01 usdt_semaphore_test (RELRO)
> > 01002000-01003000 rw-p 00001000 5e:01 usdt_semaphore_test (semaphore)
> >
> > valid_vma() currently accepts both mappings (which contains executable
> > text and RELRO mapping) during uprobe registration, since both have
> > VM_MAYEXEC set. This causes register_for_each_vma() to call
> > install_breakpoint() twice for the same underlying uprobe offset in the
> > process.  This means, update_ref_ctr() is called twice for the same
> > process, so a usdt semaphore is incremented from 0 to 2.
> 
> So, 2 vmas map the same binary, install_breakpoint() is called twice.
> But, the 2nd install_breakpoint() -> ... -> uprobe_write() should see
> that the original insn was already replaced by int3, in this case
> verify_opcode() returns 0 and uprobe_write() should do nothing.
> 
> And, if this uprobe was optimized before the 2nd install_breakpoint(),
> uprobe_write() won't be called.
> 
> Hmm.

I saw the following behaviour (without this patch) for usdt_semaphore_test:
sudo bpftrace -e '
kfunc:install_breakpoint
{
    printf("pid=%d comm=%s vaddr=%#lx vm_start=%#lx vm_end=%#lx pgoff=%#lx flags=%#lx exec=%d\n",
           pid,
           comm,
           args.vaddr,
           args.vma->vm_start,
           args.vma->vm_end,
           args.vma->vm_pgoff,
           args.vma->vm_flags,
           (args.vma->vm_flags & 0x4) != 0);
}'
Attached 1 probe
pid=3704 comm=bpftrace vaddr=0x1001742 vm_start=0x1001000 vm_end=0x1002000 pgoff=0 flags=0x8100071 exec=0
pid=3704 comm=bpftrace vaddr=0x1000742 vm_start=0x1000000 vm_end=0x1001000 pgoff=0 flags=0x8000075 exec=1

bpftrace -e 'kfunc:__update_ref_ctr
{
    printf("vaddr=%#lx d=%d\n",
           args.vaddr,
           args.d);
}'
Attached 1 probe
vaddr=0x1002024 d=1 (increment)
vaddr=0x1002024 d=1 (increment)
vaddr=0x1002024 d=-1 (decrement)
vaddr=0x1002024 d=-1 (decrement)


bpftrace -e '
kretfunc:verify_opcode
{
    printf("verify_opcode vaddr=%#lx ret=%d\n", args.vaddr, retval);
}'
Attached 1 probe
verify_opcode vaddr=0x1001742 ret=1 (install breakpoint)
verify_opcode vaddr=0x1000742 ret=1 (install)
verify_opcode vaddr=0x1001742 ret=1 (remove)
verify_opcode vaddr=0x1000742 ret=1 (remove)

So semphore incremented to 2 when a tracer was attached and decremented
back to 0 when tracer was detached. install_breakpoint() was called for
both vaddr and succeeded, also remove_breakpoint() succeeded for both
vaddr.

> > Installing a breakpoint for mapping without VM_EXEC and
> > updating usdt reference counter in that case is not useful.
> >
> > Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
> > double increment as shown in the above usecase.
> >
> > Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >  kernel/events/uprobes.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 6300b216012c..9e0bbc3cf401 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
> >  	bool first_uprobe;
> >  	int ret;
> >
> > +	if (!(vma->vm_flags & VM_EXEC))
> > +		return 0;
> > +
> 
> Well, but then it makes more sense to change valid_vma() to nack the
> non VM_EXEC mappings ?

After looking at your 2012 commit 78a320542e6c ("uprobes: Change valid_vma()
to demand VM_MAYEXEC rather than VM_EXEC"), I thought changing it in
valid_vma() was not the right approach.

"If a program maps memory as non executable initially, but it has
VM_MAYEXEC permission, the program can later call mprotect(PROT_EXEC)
to make it executable." So adding VM_EXEC in valid_vma() can be too
strict.

Hence, I think install_breakpoint() can be one point where non VM_EXEC
mapping can be restricted.
