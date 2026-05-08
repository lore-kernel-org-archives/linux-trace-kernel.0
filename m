Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E524536DA03;
	Fri,  8 May 2026 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226458; cv=none; b=WcC/r5xL//MR3Rec6zQdtNqjJb9DPAIZEhrqU2+EsYx/skVu4tkQCOIuXMwh2CtEcil64vTPmedEW/JrPLMfYVGj8eLJay1b4+/GyCUVmIngbGyMwfHinYmKG/H0cYWNfoQOo56o4XKYJ8iTNvrxEG9nYIPsRfjUaHit7FnshGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226458; c=relaxed/simple;
	bh=b5ZnG+FffZ0PYvd7betoYiNY9ZBZWNrhkv7RLSwtBAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFNjMWccAaPYH87nNGyFeJh6zaQT9VPRU6O1y11mZF9JtnVpvUxJDSCD0Yq8n1uzN1CaeLZnBN7tTnZ74Q/fc6WAPTRBQIW1X7lTZNFbAkKKDK9J/QHpRFfQ6bzYHMezGWsb+3uypJczJh1It1wA2yJbD+zuXnN9GPNKZidZiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TlPF11ED; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TlPF11ED"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647MPsds577034;
	Fri, 8 May 2026 07:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KdTmLn
	t4+Uw45r8n5nQK2dwbWWmXN8lIyCQ+VxorFXg=; b=TlPF11ED/ifXJ23oAQIcoF
	IwIyzZPmZtpnpRtfKjVlRTbig/o8pp7bpc+Zfr2VTjwQYk9uKKIRiY2nxC1jQDkO
	fl1lnm6uEjto9X+AXqXWn0M5Ff0n1t3BrHnUI0QQKpgqMAaL4Ifg2hNYB7XUDE1m
	sBbQ4oml0tFli012RPaBvMDYwaWLdzyK8GPkoYw58v+jfZz+E3FLuthuMxDxdPzs
	HnzhAAjvhD89EOtBtjPFgEtJsCwzEi7M92kUBMTrAE7zJ4T/oHwkYjm4igv9vhvE
	x1qpDYgktaAgfIlzAnL3aSc6IuH87MPEav+U7aQo+w/mUKqv32PjmrVLW2GMFxmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy1ase-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:46:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6487dwVd010281;
	Fri, 8 May 2026 07:46:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk78tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:46:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6487kWYr31588608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 07:46:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD58820040;
	Fri,  8 May 2026 07:46:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 357C120043;
	Fri,  8 May 2026 07:46:31 +0000 (GMT)
Received: from [9.111.146.14] (unknown [9.111.146.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 07:46:31 +0000 (GMT)
Message-ID: <43158d95-b4c2-44d2-a244-eb546fb2bfaa@linux.ibm.com>
Date: Fri, 8 May 2026 09:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Steven Rostedt <rostedt@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260429114355.6c712e6a@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260429114355.6c712e6a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA3NSBTYWx0ZWRfXxNVvRp52XlA7
 ELo7dOdcyMENCAbR8FuBl5a3kPxEDAYvUJ038oD6rwK8afilcd8YnJFMzGEog95rcVCYfSCDvqm
 GjucfPJJnHVi4kFXpE5v/dsMB756d+Yx/YzAnVnqMRixmVITZg2GuoXdUHwpzsERhzjVTDB2zK3
 TTyfAzgpR5Cr8jO4o15i64GX8FI/ko9Zttkh65LBkQtvXX2DXtHCgeKVdEAOGvncYSVzHnbwwun
 C4RNOaomdWZS9YaLyVLyXDOg8Cck+6L9bEe0LCKS+Z9rJcf0985jO/Xjm3tJgX2lhVYprFKvwNb
 G15V/7gF/LamEY82BY1aabZzt6Tybb33ZfZH3CeMIMFkNjbS1PcdMjIBBX0Np9w+eqShJ8HX2Hu
 YZgmWRfFopv+P6jYpWM9wdezx1j2XSQzt4ecRuXsqyxrpTgsjC5RBO03cqgGrUhh0GyYSWdyKcr
 4GEnl3H4UsY+ivVtGpg==
X-Proofpoint-ORIG-GUID: 1mRLew4p4Dl-_9q-6OINvGWz4ldt5_h_
X-Proofpoint-GUID: TLgRO-H2zT9j7aYrVi6V0F2A8EJ_pTQN
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fd94de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8 a=OTwlLuw14AzAtFzMM_cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080075

On 4/29/2026 5:43 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> [
>    This is an RFC that adds a system call for dynamic linkers to use to
>    tell the kernel where the sframe sections are when it loads dynamic
>    libraries.
> 
>    It is built on top of Jens's sframe implementation for v3:
> 
>       https://lore.kernel.org/linux-trace-kernel/20260127150554.2760964-1-jremus@linux.ibm.com/
> 
>    I have a repo with that code that this applies on top of here:
> 
>       git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git sframe/core
>        
> 
>    The name of the system call is "stacktrace_setup", but I'm not attached
>    to this name. If anyone can think of a better name I'm happy to take
>    suggestions.
> 
>    This patch is just to get the conversation going and the final result
>    may be much different. I tested this with the attached program which is a
>    major hack. I built glibc with sframe v3 support and I used readelf to
>    find the sframe size and location of glibc.
> 
>    readelf -e /work/usr/lib/libc.so.6 | grep sframe
>      [19] .sframe           GNU_SFRAME       00000000001d3fc0  001d3fc0
> 
>    Then I wrote a program that takes the above location and size of the
>    .sframe section in libc as parameters, scans /proc/self/maps to find
>    where it loaded libc and then calls this new system call with a pointer
>    to the location of the sframe along with its size, as well as where the
>    libc text is located.
> 
>    It then spins for 2 seconds, calls the system call again to remove the
>    sframe section it loaded, and spins for another 2 seconds.
> 
>    I ran perf record --call-graph fp,defer on the program and looked for
>    the do_spin() function.
> 
>    With sframe loaded:
> 
> sframe-test    1350  1396.333593:     202366 cpu/cycles/P: 
>             7fdf0ec38a44 [unknown] ([vdso])
>             5621a6b97243 get_time+0x19 (/work/c/sframe-test)
>             5621a6b9727f do_spin+0x1f (/work/c/sframe-test)
>             5621a6b975cd main+0xd4 (/work/c/sframe-test)
>             7fdf0ea26bda __libc_start_call_main+0x6a (/work/usr/lib/libc.so.6)
>             7fdf0ea26d05 __libc_start_main@@GLIBC_2.34+0x85 (/work/usr/lib/libc.so.6)
>             5621a6b97131 _start+0x21 (/work/c/sframe-test)
> 
>    After it unloads the sframe:
> 
> sframe-test    1350  1400.332902:     657582 cpu/cycles/P: 
>             7fdf0ec38a5e [unknown] ([vdso])
>             5621a6b97243 get_time+0x19 (/work/c/sframe-test)
>             5621a6b9727f do_spin+0x1f (/work/c/sframe-test)
>             5621a6b97602 main+0x109 (/work/c/sframe-test)
>             7fdf0ea26bda __libc_start_call_main+0x6a (/work/usr/lib/libc.so.6)
> 
>    As you can see, with the sframe loaded, it was able to walk further up
>    the libc library.
> 
>    Again, this is just an RFC, but I would like to get agreement on the
>    system call so that we can then update the dynamic linker to do this
>    instead of using my hack ;-)
> ]
> 
> Add a system call that can be used by dynamic linkers to tell the kernel
> where the sframe section is in memory for libraries it loads.
> 
> The system call stacktrace_setup takes 5 parameters:
> 
>   op - the type of operation to perform
>   addr_start - The virtual address of the sframe section
>   addr_length - The length of the sframe section
>   text_start - the text section the sframe represents
>   test_length - the length of the section
> 
> The current op values are:
> 
>   STACKTRACE_REGISTER_SFRAME - This registers the sframe
>   STACKTRACE_UNREGISTER_SFRAME - This removes the sframe
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

LGTM.  Some comments/questions below.

> diff --git a/include/uapi/linux/stacktrace.h b/include/uapi/linux/stacktrace.h

> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_STACKTRACE_H
> +#define _UAPI_LINUX_STACKTRACE_H
> +
> +enum stacktrace_setup_types {
> +	STACKTRACE_REGISTER_SFRAME	= 1,
> +	STACKTRACE_UNREGISTER_SFRAME	= 2,
> +};
> +
> +#endif /* _UAPI_LINUX_STACKTRACE_H */

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

Having the syscall live in kernel/unwind/sframe.c means it is only
available if config option HAVE_UNWIND_USER_SFRAME is selected (which
triggers sframe.o to be built and linked into the kernel), which makes
sense as long as it only implements sframe-specific functionality.
I suppose it could be moved elsewhere if non-sframe use cases would
arise in the future?

Would Dylan need to guard it when introducing HAVE_UNWIND_KERNEL_SFRAME?
Provided the syscall fails with -ENOSYS if not implemented (e.g. when
HAVE_UNWIND_USER_SFRAME is not enabled) the dummy implementations of
sframe_add_section() and sframe_remove_section() in linux/sframe.h also
return -ENOSYS, so the user observable behavior would be the same and
it would not matter.  Do you agree?

> @@ -12,8 +12,10 @@
>  #include <linux/mm.h>
>  #include <linux/string_helpers.h>
>  #include <linux/sframe.h>
> +#include <linux/syscalls.h>
>  #include <asm/unwind_user_sframe.h>
>  #include <linux/unwind_user_types.h>
> +#include <uapi/linux/stacktrace.h>
>  
>  #include "sframe.h"
>  #include "sframe_debug.h"
> @@ -838,3 +840,38 @@ void sframe_free_mm(struct mm_struct *mm)
>  
>  	mtree_destroy(&mm->sframe_mt);
>  }
> +
> +/**
> + * sys_stacktrace_setup - register an address for user space stacktrace walking.
> + * @op: Type of operation to perform
> + * @addr_start: The virtual address of the stacktrace information
> + * @addr_length: The length of the stacktrace information
> + * @text_start: The virtual address of the text that @addr_start represents
> + * @text_length: The length of teh text
> + *
> + * This system call is used by dynamic library utilities to inform the kernel
> + * of meta data that it loaded that can be used by the kernel to know how
> + * to stack walk the given text locations.
> + *
> + * Currently only sframes are supported, but in the future, this may be used
> + * to tell the kernel about JIT code which will most likely have a different
> + * format.
> + *
> + * The type command may be extended and parameters may be used for other
> + * purposes.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, addr_start,
> +		unsigned long, addr_length, unsigned long, text_start,
> +		unsigned long, text_length)

Would it make sense to keep the parameters generic from start, similar
to how it is done in prctl()?  Or can this be changed later, if the need
arises?

SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, arg2,
		unsigned long, arg3, unsigned long, arg4, unsigned long, arg5)

> +{
> +	switch (op) {
> +	case STACKTRACE_REGISTER_SFRAME:
> +		return sframe_add_section(addr_start, addr_start + addr_length,
> +					  text_start, text_start+text_length);

Nit:
					  text_start, text_start + text_length);

> +	case STACKTRACE_UNREGISTER_SFRAME:
> +		return sframe_remove_section(addr_start);
> +	}
> +	return -EINVAL;
> +}
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

