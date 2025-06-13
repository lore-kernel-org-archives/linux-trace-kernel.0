Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D582DA74F;
	Fri, 13 Jun 2025 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801051; cv=none; b=K7SJ7q3xi8+MnUPrJFslodeuqtIZa8bwUKPTiHR77u/7k51pxz0ecBu5PM+pqnh1ShFpcwmCo8hwcGodruq8nmwiBirsUjdcQt/a5iTlnQXPhMs+XZOSbogUR+8gYCoV3hwMAzRZJQt/qpDiLNaIOg2e2y63UxBF/fPKw7nX6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801051; c=relaxed/simple;
	bh=73jLAMbSAMcXdTceq4NRl/9fgjEkYWA9YZFX/pA1DvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ne3cB/qYIiZsMLMkMdM9OB0EtHRAEHslL6bC3D9Nf8n80lW4+luTk1Ign0bRnZh2XbejW5S/ofeFQJagJVLZP6Goozgi/uoJGqjjc68JHc4dZbgas1p7uEFkdALq86pHrqNURzs8/yS47FwZdfmJBt4zgJu2JO4jIhRyV9qKF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=egEtkIFC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="egEtkIFC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CJOfNb001635;
	Fri, 13 Jun 2025 07:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0J7cGA
	Ce8mQObfmJ58swJYDeJJ/SQ+ULJH95lPJ9mhk=; b=egEtkIFCq0n8XufUIEMwue
	NlBQXFFWdcmHuaFPeUegbPkpN7EvxwPlv+1zBjc5CvO1aEeuTyn4Kv/T9VFHCeKK
	AtXyCn2U4W7LLXeWT9X0Ol6YoCNATp39D+cvaHEiEtL2Bx8encYFWG8VgZ+xZHqb
	4xnJ4UgkdLY4CzxLOPFrD2qKcFEbnV5KbjIOqJVT0gQ20GgSnCRmknvuqjL79J+U
	sH494L5rzbyiY16LOCbrCIjKW3Zi1Sq1vAaNbBtfY3H8pV9ICpYFeRLge8OZGEZt
	L6vH1bZRBjRxTywq3UJMc75Db0B7Y9MSSeMz+NBGD0Gg/ur4QKKSwG8HODlUvNNw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769x04h3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 07:50:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55D7gtLh019864;
	Fri, 13 Jun 2025 07:50:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769x04h3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 07:50:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55D5w1N5021839;
	Fri, 13 Jun 2025 07:50:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47505093xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 07:50:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55D7oKtA50856434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 07:50:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1869D2004E;
	Fri, 13 Jun 2025 07:50:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC0220040;
	Fri, 13 Jun 2025 07:50:18 +0000 (GMT)
Received: from [9.109.199.41] (unknown [9.109.199.41])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Jun 2025 07:50:17 +0000 (GMT)
Message-ID: <1e79fee0-2845-498f-bd16-4589edf19df7@linux.ibm.com>
Date: Fri, 13 Jun 2025 13:20:17 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        Aditya Bodkhe <aditya.b1@linux.ibm.com>
References: <20250528134820.74121-1-adityab1@linux.ibm.com>
 <840249c5-2602-4178-a408-f7d502111f79@csgroup.eu>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <840249c5-2602-4178-a408-f7d502111f79@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yniYR6aGmmi4Wlk9dJE1i8toMH_yxv_8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA1NiBTYWx0ZWRfX7z/5XOJc+Tqy W6l4S5C3lgdorFWpqS7BbJdpGgDz7B6fSmdOS0DVlXQmHkQNYfgGmgSHaQk22PuMQ3RSiC9GwBe Ed562b6i0XqF5bC9vX3deZ+WBi5V+rJXBr6lhVqzQklHjCHsBv+dlOXEO0tPBgvTup4+9BH7Geh
 WEi+DiinmRvpLcHAlWt20gsdDzP11y0dOUS++VBNjMg5+iWZv4XEuKc9GNtUwNdAToJ0h2cv0KV EtRNyQb2s+xYzh/FcY2IURewv6fIdpYV7epWA9d0kYXd4IzKSmp8JNw6/qfvAS3ffB+5jWdiHas zrsKCmx8Fjop4Az7ioINs56MtZTLMMxSFaM6GTVqFbvTWA0dAYkJi8KIkykhMVn7lhYEz88IL6r
 20oFafCB5/BVsNEDhQ31ShRAFCphUdbyILeycHJJLM7+aCbpor6ICkuv0S5hIs4iJ2rGFoOT
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684bd844 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=_EeEMxcBAAAA:8 a=VnNF1IyMAAAA:8 a=3ShwC3RzYPBMsP622vUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mRsADJhDk3ArtKDoDH0ljDC-yiHtz1hR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130056


On 03/06/25 2:22 pm, Christophe Leroy wrote:
>
>
> Le 28/05/2025 à 15:48, Aditya Bodkhe a écrit :
>> [Vous ne recevez pas souvent de courriers de adityab1@linux.ibm.com. 
>> Découvrez pourquoi ceci est important à 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>>
>> commit a1be9ccc57f0 ("function_graph: Support recording and printing the
>> return value of function") introduced support for function graph return
>> value tracing.
>>
>> Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
>> ftrace_regs") further refactored and optimized the implementation,
>> making `struct fgraph_ret_regs` unnecessary.
>>
>> This patch enables the above modifications for powerpc64, ensuring that
>> function graph return value tracing is available on this architecture.
>
> Why only powerpc64 ?
>
> I see nothing specific to powerpc64 in your patch, will it work on 
> powerpc32 too ?
>
That's a oversight on my part . This patch necessary changes for 
powerpc32 bit and tested this feature to be working as expected on the same.
>>
>> After this patch, v6.14+ kernel can also be built with FPROBE on powerpc
>> but there are a few other build and runtime dependencies for FPROBE to
>> work properly. The next patch addresses them.
>>
>> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>> ---
>>   arch/powerpc/Kconfig                     |  1 +
>>   arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
>>   arch/powerpc/kernel/trace/ftrace_entry.S | 41 ++++++++++++++----------
>>   3 files changed, 40 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index c3e0cc83f120..9163521bc4b9 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -250,6 +250,7 @@ config PPC
>>          select HAVE_FUNCTION_ARG_ACCESS_API
>>          select HAVE_FUNCTION_DESCRIPTORS        if PPC64_ELF_ABI_V1
>>          select HAVE_FUNCTION_ERROR_INJECTION
>> +       select HAVE_FUNCTION_GRAPH_FREGS
>>          select HAVE_FUNCTION_GRAPH_TRACER
>>          select HAVE_FUNCTION_TRACER             if !COMPILE_TEST && 
>> (PPC64 || (PPC32 && CC_IS_GCC))
>>          select HAVE_GCC_PLUGINS                 if GCC_VERSION >= 
>> 50200   # plugin support on gcc <= 5.1 is buggy on PPC
>> diff --git a/arch/powerpc/include/asm/ftrace.h 
>> b/arch/powerpc/include/asm/ftrace.h
>> index 82da7c7a1d12..6ffc9c9cf4e3 100644
>> --- a/arch/powerpc/include/asm/ftrace.h
>> +++ b/arch/powerpc/include/asm/ftrace.h
>> @@ -50,6 +50,21 @@ static __always_inline struct pt_regs 
>> *arch_ftrace_get_regs(struct ftrace_regs *
>>                  asm volatile("mfmsr %0" : "=r" ((_regs)->msr)); \
>>          } while (0)
>>
>> +#undef ftrace_regs_get_return_value
>> +static __always_inline unsigned long
>> +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
>> +{
>> +       return arch_ftrace_regs(fregs)->regs.gpr[3];
>> +}
>> +#define ftrace_regs_get_return_value ftrace_regs_get_return_value
>> +
>> +#undef ftrace_regs_get_frame_pointer
>> +static __always_inline unsigned long
>> +ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
>> +{
>> +       return arch_ftrace_regs(fregs)->regs.gpr[1];
>> +}
>> +
> Why unset and redefine ftrace_regs_get_return_value() and 
> ftrace_regs_get_frame_pointer() ? Please explain why the default ones 
> can't be used on powerpc.
>
Because for powerpc currently for ftrace_regs_get_return_value() this 
function regs_return_value() is getting called and it's implementation 
returns -regs.gpr[3] if is_syscall_success() returns false . This was 
causing fails in ftrace selftests .

Also for ftrace_regs_get_frame_pointer() current implementation was 
always returning 0 hence we had to change that too .

>>   static __always_inline void
>>   ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>>                                      unsigned long ip)
>> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S 
>> b/arch/powerpc/kernel/trace/ftrace_entry.S
>> index 3565c67fc638..eafbfb7584ed 100644
>> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
>> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
>> @@ -409,23 +409,30 @@ EXPORT_SYMBOL(_mcount)
>>   _GLOBAL(return_to_handler)
>>          /* need to save return values */
>>   #ifdef CONFIG_PPC64
>> -       std     r4,  -32(r1)
>> -       std     r3,  -24(r1)
>> +       stdu    r1, -SWITCH_FRAME_SIZE(r1)
>> +       std     r4, GPR4(r1)
>> +       std     r3, GPR3(r1)
>> +  /* Save previous stack pointer (r1) */
>> +       addi    r3, r1, SWITCH_FRAME_SIZE
>> +       std     r3, GPR1(r1)
>>          /* save TOC */
>> -       std     r2,  -16(r1)
>> -       std     r31, -8(r1)
>> +       std     r2,  24(r1)
>> +       std     r31, 32(r1)
>>          mr      r31, r1
>> -       stdu    r1, -112(r1)
>> -
>> +  /* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
>> +       addi    r3,  r1, STACK_INT_FRAME_REGS
>
> Some of the changes seems to only be renaming and should be done in a 
> cleanup/preparatory patch in order to only focus on real necessary 
> changes in this patch.
>
Now the way we are setting up the frame we cannot have negative offsets 
, hence we used offsets which are defined already.
>>          /*
>>           * We might be called from a module.
>>           * Switch to our TOC to run inside the core kernel.
>>           */
>>          LOAD_PACA_TOC()
>>   #else
>> -       stwu    r1, -16(r1)
>> -       stw     r3, 8(r1)
>> -       stw     r4, 12(r1)
>> +       stwu    r1, -SWITCH_FRAME_SIZE(r1)
> Why do we need such a big frame size just to save two registers ?
>
This Frame size is needed because we need pt_regs as part of frame , are 
you saying instead of SWITCH_FRAME_SIZE for 32 bit architecture we 
should just setup a frame with size of pt_regs because ftrace_regs size 
is same as pt_regs on ppc
>> +       stw     r4, GPR4(r1)
>> +       stw     r3, GPR3(r1)
>> +       addi    r3, r1, SWITCH_FRAME_SIZE
>> +       stw     r3, GPR1(r1)
> > +       addi    r3, r1, STACK_INT_FRAME_REGS
>
> Why is this needed ?
>
The function ftrace_return_to_handler takes pointer to pt_regs as 
arguement so we are setting that up in stack and passing that pointer.
>>   #endif
>>
>>          bl      ftrace_return_to_handler
>> @@ -435,15 +442,15 @@ _GLOBAL(return_to_handler)
>>          mtlr    r3
>>
>>   #ifdef CONFIG_PPC64
>> -       ld      r1, 0(r1)
>> -       ld      r4,  -32(r1)
>> -       ld      r3,  -24(r1)
>> -       ld      r2,  -16(r1)
>> -       ld      r31, -8(r1)
>> +       ld      r4,  GPR4(r1)
>> +       ld      r3,  GPR3(r1)
>> +       ld      r2,  24(r1)
>> +       ld      r31, 32(r1)
>> +       ld      r1,  0(r1)
>>   #else
>> -       lwz     r3, 8(r1)
>> -       lwz     r4, 12(r1)
>> -       addi    r1, r1, 16
>> +       lwz     r3, GPR3(r1)
>> +       lwz     r4, GPR4(r1)
>> +       addi    r1, r1, SWITCH_FRAME_SIZE
>>   #endif
>>
>>          /* Jump back to real return address */
>> -- 
>> 2.43.5
>>
>
