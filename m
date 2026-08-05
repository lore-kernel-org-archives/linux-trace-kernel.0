Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11D352000;
	Wed,  5 Aug 2026 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965392; cv=none; b=rcErTteGmwuGYjMvpIY3SPiDH/pgWjnEeXCGjjV2wPw1WdWLMpQLZe4gBW2M2bOkF94qclYzWqQ+fgf4HkmkcV//9BSnl9u6e7TtGyPfcoaFAgwQGBgONAMa5XmG2E2xRW251mkN7ttMmlb9h0wgfeH4XUPJqV5/Bz91aknMak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965392; c=relaxed/simple;
	bh=ZqNmA/sxTHDhs6HlHp3fV2gpRCOGXzA95JMv4JGJ/wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR1EaA/wog5btTtZmbK0kcZ5VD0iwyE4Z2hnMpvwMK34NE0EUV8gEL3m2YArvUCOVkb8F3aWVPHZ7rWmqRaKVce0Jtr4YL+euTfFZK3gGiJ267/qNzgqWOQJqMFtir8NzWWlGu/oLa4Q5XZ91lXFz3cYZJusQ9xsAKENbetsnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2fSS8JG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2fSS8JG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675HlZQA315500;
	Wed, 5 Aug 2026 21:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0H6Qsr
	AqxOszT038iXK4pTNPjlxOqA4/00gwtaj51xo=; b=U2fSS8JGJZcoZrsUbZaSLy
	p2bk8reonwhF8myExO3ny5Z8S8fCaiTyMDk9tAEXWrsanOKrx7nGV00TLTfs4+p4
	+6NrgGshmrEVs/nLuZuN1R/78tyxZh2jR/g9Ix4/jst2olEjKtNEtRkp4SoNJM5d
	RPR3Swzf0aRQSc/LM/eAW8pzzWoUOsB/vDneBo5zQ7WsTbrt0B6xSzYsUuucgfeU
	fJ903uSa8Fp7hgMW5BduhXh02yp+6M/BvmpiGsV+k1hHTIo55YKTyPbonD9PRbWB
	nV7bEwEVWR3ZKObCooe1BcgYInU2HGDm6afkV/zmdwoLQEcstvqddn/qQJzsS9Kg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a4560p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 21:29:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675LQHiF026103;
	Wed, 5 Aug 2026 21:29:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgg7dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 21:29:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675LTUMe34800000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 21:29:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF0552004B;
	Wed,  5 Aug 2026 21:29:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48CB420043;
	Wed,  5 Aug 2026 21:29:30 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.111.1.132])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 21:29:30 +0000 (GMT)
Date: Wed, 5 Aug 2026 23:29:28 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] uprobes: Skip breakpoint installation on non executable
 vmas
Message-ID: <anOrOJfOkGhLeDp5@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZum6AjU1G_hazOwW1ECNzHm=2vLVUGOjD-tSYqr-HRuA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a73ab3f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=CCpqsmhAAAAA:8
 a=rEqGk-WHAAAA:20 a=20KFwNOVAAAA:8 a=64rNDwc5oh53VVzcicUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ul9cdbp4aOFLsgKbc677:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: OBzRBSmT4z5XRMgGwzKXdmc3fU0SqgmG
X-Proofpoint-GUID: vAllnf9Qx8k7rJdEbGlMf7qDPIZykSDI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE3NSBTYWx0ZWRfXwejTXg5SFyQh
 P6524BzrXx1G14Q5e0XeBMrTb+tMQKTtnobJVLraenZaErJkPZ03cSKubC9Huf00xQa46D/GtOO
 ZqubzHN0WAhT60u5kp1a7XmvQheAYcc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE3NSBTYWx0ZWRfX9pCvg5ehRchf
 iB7foYrdYsHafQaWsRmv674KYQ3o4LspdpuQ8tizDqvfeCC5+SJ9ppdbg+xVXvurw+Bwbb87zUR
 a42XzvhNDaEDHQpWDBlhCC8EQwcRPU5GBKKqWktFMOK71oIlSiShWSfth1A8HVrL3RuFg59XCcq
 +yYHUYZ3ZO0zePNZ4Mo1nR1mt7NN+mhetFJfq107fo1bI1PPQN8zBau49wQNAekFlRETHIqC/f1
 mnfux+Yi7xDVrr3I+9zvlx6S6UWXcOx3gklxidFzGkYhHkjyKuidHgV4dNrGtP1FkDBKMfa7Mhk
 MYPzB7ld+63ra1+aG6oBrMfC0QBYHSQcjikW9GFM10X+C0jL6+/77H7qXP0aSPnEJ0hP2KS6KZr
 H9yF6Mc6QozK+TK+aaNF5TJb9iJqvlY5H0FqDe3mfWZEbCgNEUXqDKe5PqzbOtm0hzG1Yn/Wd+R
 bgyw6/6QmBKwJ9XnmuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050175

On Wed, Aug 05, 2026 at 10:29:13AM -0700, Andrii Nakryiko wrote:
> On Wed, Aug 5, 2026 at 8:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/05, Sumanth Korikkar wrote:
> > >
> > > bpftrace  -e 'usdt:./testprogs/usdt_semaphore_test:tracetest:testprobe {
> > > printf("%s\n", str(arg1) ); exit(); }'
> >
> 
> does bpftrace care if USDT semaphore is set to 1 or 2, it shouldn't.
> As long as detaching decrements it from 2 back to zero we should be
> fine. Is that what's happening? If so, is there really a problem
> needing to be fixed?

USDT spec mentions the following:
https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
 
If a semaphore is associated with a probe, it will be of type unsigned
short. A semaphore may gate invocations of a probe; it must be set to a
non-zero value to guarantee that the probe will be hit. "Semaphores are
treated as a counter"; your tool should increment the semaphore to enable
it, and decrement the semaphore when finished.
 
I do not know, if any application checks for exact value of 1
instead of semaphore > 0 check.

As suggested by Andrii and Oleg earlier - "uprobe_write() creates
the COW'ed anonymous page, so the 1st install_breakpoint() won't affect
the 2nd mapping to the same binary"

To me, the following looks like a valid point to consider the fix:
Installing a breakpoint on a non executable relro mapping is not useful
because instructions are not executed on it. Anonymous COW page sits
in memory untouched and memory is wasted.

> > I am hoping that Andrii and Jiri (cc'ed) can take a look, I know nothing
> > about usdt... And TBH, I don't even know what RELRO is ;)
> >
> > Let me ask a couple of questions for now.
> >
> > > expects a semaphore increment of 1, but semaphore gets double incremented
> > >
> > > Test program:
> > > https://github.com/bpftrace/bpftrace/blob/master/tests/testprogs/usdt_semaphore_test.c
> >
> > Perhaps you can provide the test-case which I could compile on my
> > machine without libbpf-usdt/usdt.h?
> >
> > And can you explain what the bpftrace cmd above actually does? I mean,
> > where does it put the uprobe? I guess the ref_ctr_offset argument of
> > uprobe_register() refers to USDT_DEFINE_SEMA() in that test-case...
> >
> > > Reason: .text mapping and RELRO mapping resolve to the same page aligned
> > > file offset 0
> > > 01000000-01001000 r-xp 00000000 5e:01 usdt_semaphore_test (.text)
> > > 01001000-01002000 r--p 00000000 5e:01 usdt_semaphore_test (RELRO)
> > > 01002000-01003000 rw-p 00001000 5e:01 usdt_semaphore_test (semaphore)
> > >
> > > valid_vma() currently accepts both mappings (which contains executable
> > > text and RELRO mapping) during uprobe registration, since both have
> > > VM_MAYEXEC set. This causes register_for_each_vma() to call
> > > install_breakpoint() twice for the same underlying uprobe offset in the
> > > process.  This means, update_ref_ctr() is called twice for the same
> > > process, so a usdt semaphore is incremented from 0 to 2.
> >
> > So, 2 vmas map the same binary, install_breakpoint() is called twice.
> > But, the 2nd install_breakpoint() -> ... -> uprobe_write() should see
> > that the original insn was already replaced by int3, in this case
> > verify_opcode() returns 0 and uprobe_write() should do nothing.
> >
> > And, if this uprobe was optimized before the 2nd install_breakpoint(),
> > uprobe_write() won't be called.
> >
> > Hmm.
> 
> Even though it's the same file offset, it is mapped to two different
> virtual addresses, so I think it should be two different memory pages
> that will have two separate int3 instructions. I don't think there is
> any contradiction or surprise, is there?

True. cross checked the behaviour with bpftrace stacktrace. Pasted the
output in previous thread.

> > > Installing a breakpoint for mapping without VM_EXEC and
> > > updating usdt reference counter in that case is not useful.
> > >
> > > Skip non VM_EXEC mappings in install_breakpoint(). This fixes semaphore
> > > double increment as shown in the above usecase.
> 
> You said that mapping is VM_MAYEXEC, which means that kernel allows to
> re-mmap it as executable, if that happens, we will miss uprobe in that
> location, so that's probably why breakpoint is installed for
> VM_MAYEXEC.

True. 
ref commit 78a320542e6c ("uprobes: Change valid_vma() to demand
VM_MAYEXEC rather than VM_EXEC")

Thank you
