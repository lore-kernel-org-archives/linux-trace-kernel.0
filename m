Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17161233710;
	Mon,  4 Aug 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291444; cv=none; b=eRpikBOwnyWzwyg1A+rpTvBSnstq/UY6MggHo5CtXMarN985ugk2gJhAx4J0oJRMYO5OtDreyolWh5oXI3nMKeyX7cCexv4i/SIwcm8SMUxpR0Rt0RwFDtfZV1rNrAkvVIOX9B45t2kTK4dObhkTk1/PfNqeTWpSl/J4WBqPyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291444; c=relaxed/simple;
	bh=HrsOW22baBZHUqSVf1topf9Fih/6rEOGbnxwilBnzAU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LIoisLcXaIIbIr2aeYJh3WGvAEzLuzhS5GPXzce4hI5TvF838156z/GjBVcxeQ7tI/qNEJFmA6th2c46DEDf57RVDoAG/gHNgYGioqlQanAis/oTsrtCqieQpoG/xP6RfrkAXrsP24ZSHM2BnaNCtQVgtx9aDPsalEliBF+2Xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nr7dHrb3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nr7dHrb3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573LxwWM022899;
	Mon, 4 Aug 2025 07:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ramS1p
	jeVqGHWF62ogc3ChKuur9gxv5FESmY3rJXJ3k=; b=Nr7dHrb3gQre9O1N3YGGHV
	zc4A9ZYxxm1Y+FreEygz/5Ey97+A9fxsffKBn9xzPLs/WeeQcKwCpk98gO7WgXCI
	BaS6Z0qGvQuzmQHqylVJE8qDLk+jUo9L9NmLTFDIlSHzMv6h0fdzWTGD2X48Cfd/
	p1vByYhP1Bi/d6uhpNY78vjef/n0IoNrGjP4O5TOgHVHyXb4imXVpAAzYuDdnXDH
	1NFnreUg47YFxS+thvHXu95rpFoULeuHE6gihQhy/grxwRo7yU25Z2AlJrx4TTTM
	mlKf5d7S029jfDqItIv4gffH9/cZlLmPC6Y5MOChEpquOK5VnbKKk+I5jhzw9KFw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9ud6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:10:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5747AMxE016695;
	Mon, 4 Aug 2025 07:10:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4a9ud66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:10:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5746JtsP009594;
	Mon, 4 Aug 2025 07:10:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489x0nvj0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 07:10:21 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5747AJMp10420968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 07:10:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B433758068;
	Mon,  4 Aug 2025 07:10:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4282F5806A;
	Mon,  4 Aug 2025 07:10:16 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.249.29])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 07:10:15 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 1/2] powerpc/ftrace: support
 CONFIG_FUNCTION_GRAPH_RETVAL
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20250722085648.1640-1-adityab1@linux.ibm.com>
Date: Mon, 4 Aug 2025 12:40:03 +0530
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org, maddy@linux.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <401DC39A-0A74-467F-AE01-68B164BEDCF6@linux.ibm.com>
References: <20250722085648.1640-1-adityab1@linux.ibm.com>
To: Aditya Bodkhe <adityab1@linux.ibm.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vmIqo5qkpwOUPwTHBdryw-kouyk2yfb0
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=68905cdf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=dNnesIPfpvp5sUh9fRYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rY8OKm7Bh0NIlp7qqJINZ-QryM85_CqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzNSBTYWx0ZWRfXzixPKAmFRwjV
 gpwzjRTIinCjcYAi4Gh6f/tcBFbuKoL9/DKL1WntrFLh23MVdBFEFuHIw56qvaHKjkLwqdH2aaE
 NpZ/jvAV3htbnY/a1iaiFkSdof4jWzy2hnEPJ0w6lmrLOolV4rNVGEkJhearoiO/k81HDZFXFrx
 RuXpkTiEX3EItA+i4oPRH4bAa4pHO3hvUN7r4U+AyHbHXxZsM1eDrCB+LaeRiq8tvPMHGR6rEUS
 +4RhTE3x09j0pYpQJZcC4G5EMfqYttuiR9/C928XQAa6X8L0JEVlvGOAIREb13+i9QTYQyALyqu
 yd/hwZYm2k4aelHt6vSOM8IIpm/4TA+gYfY/+fEc1iP1HZI0/avDQXTHtEulhwmYs1kKpvvcJ1M
 TFuVpQhLiFDSyHjmZkI7xmlMIs9DiTidDaq7/20CU7VS+4zB+I/q/BgdHrwdQoxv3DsBT105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040035



> On 22 Jul 2025, at 2:26=E2=80=AFPM, Aditya Bodkhe =
<adityab1@linux.ibm.com> wrote:
>=20
> commit a1be9ccc57f0 ("function_graph: Support recording and printing =
the
> return value of function") introduced support for function graph =
return
> value tracing.
>=20
> Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs =
with
> ftrace_regs") further refactored and optimized the implementation,
> making `struct fgraph_ret_regs` unnecessary.
>=20
> This patch enables the above modifications for powerpc all, ensuring =
that
> function graph return value tracing is available on this architecture.
>=20
> In this patch we have redefined two functions:
> - 'ftrace_regs_get_return_value()' - the existing implementation on
> ppc returns -ve of return value based on some conditions not
> relevant to our patch.
> - 'ftrace_regs_get_frame_pointer()' - always returns 0 in current code =
.
>=20
> We also allocate stack space to equivalent of 'SWITCH_FRAME_SIZE',
> allowing us to directly use predefined offsets like 'GPR3' and 'GPR4'
> this keeps code clean and consistent with already defined offsets .
>=20
> After this patch, v6.14+ kernel can also be built with FPROBE on =
powerpc
> but there are a few other build and runtime dependencies for FPROBE to
> work properly. The next patch addresses them.
>=20
> Signed-off-by: Aditya Bodkhe <adityab1@linux.ibm.com>
> ---
>=20
> Changelog:
> v1 -> v2:
> - Added explanation for redefining ftrace_regs_get_return_value()=20
> and ftrace_regs_get_frame_pointer()
> - Explained why stack space equivalent to 'SWITCH_FRAME_SIZE' is =
allocated.
>=20
> arch/powerpc/Kconfig                     |  1 +
> arch/powerpc/include/asm/ftrace.h        | 15 +++++++++
> arch/powerpc/kernel/trace/ftrace_entry.S | 42 ++++++++++++++----------
> 3 files changed, 41 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c3e0cc83f120..9163521bc4b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -250,6 +250,7 @@ config PPC
> select HAVE_FUNCTION_ARG_ACCESS_API
> select HAVE_FUNCTION_DESCRIPTORS if PPC64_ELF_ABI_V1
> select HAVE_FUNCTION_ERROR_INJECTION
> + select HAVE_FUNCTION_GRAPH_FREGS
> select HAVE_FUNCTION_GRAPH_TRACER
> select HAVE_FUNCTION_TRACER if !COMPILE_TEST && (PPC64 || (PPC32 && =
CC_IS_GCC))
> select HAVE_GCC_PLUGINS if GCC_VERSION >=3D 50200   # plugin support =
on gcc <=3D 5.1 is buggy on PPC
> diff --git a/arch/powerpc/include/asm/ftrace.h =
b/arch/powerpc/include/asm/ftrace.h
> index 82da7c7a1d12..6ffc9c9cf4e3 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -50,6 +50,21 @@ static __always_inline struct pt_regs =
*arch_ftrace_get_regs(struct ftrace_regs *
> asm volatile("mfmsr %0" : "=3Dr" ((_regs)->msr)); \
> } while (0)
>=20
> +#undef ftrace_regs_get_return_value
> +static __always_inline unsigned long
> +ftrace_regs_get_return_value(const struct ftrace_regs *fregs)
> +{
> + return arch_ftrace_regs(fregs)->regs.gpr[3];
> +}
> +#define ftrace_regs_get_return_value ftrace_regs_get_return_value
> +
> +#undef ftrace_regs_get_frame_pointer
> +static __always_inline unsigned long
> +ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> +{
> + return arch_ftrace_regs(fregs)->regs.gpr[1];
> +}
> +
> static __always_inline void
> ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>    unsigned long ip)
> diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S =
b/arch/powerpc/kernel/trace/ftrace_entry.S
> index 3565c67fc638..3da14d8271d9 100644
> --- a/arch/powerpc/kernel/trace/ftrace_entry.S
> +++ b/arch/powerpc/kernel/trace/ftrace_entry.S
> @@ -409,23 +409,31 @@ EXPORT_SYMBOL(_mcount)
> _GLOBAL(return_to_handler)
> /* need to save return values */
> #ifdef CONFIG_PPC64
> - std r4,  -32(r1)
> - std r3,  -24(r1)
> + stdu r1, -SWITCH_FRAME_SIZE(r1)
> + std r4, GPR4(r1)
> + std r3, GPR3(r1)
> + /* Save previous stack pointer (r1) */
> + addi r3, r1, SWITCH_FRAME_SIZE
> + std r3, GPR1(r1)
> /* save TOC */
> - std r2,  -16(r1)
> - std r31, -8(r1)
> + std r2, 24(r1)
> + std r31, 32(r1)
> mr r31, r1
> - stdu r1, -112(r1)
> -
> + /* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
> + addi r3, r1, STACK_INT_FRAME_REGS
> /*
> * We might be called from a module.
> * Switch to our TOC to run inside the core kernel.
> */
> LOAD_PACA_TOC()
> #else
> - stwu r1, -16(r1)
> - stw r3, 8(r1)
> - stw r4, 12(r1)
> + stwu r1, -SWITCH_FRAME_SIZE(r1)
> + stw r4, GPR4(r1)
> + stw r3, GPR3(r1)
> + addi r3, r1, SWITCH_FRAME_SIZE
> + stw r3, GPR1(r1)
> + /* pass ftrace_regs/pt_regs to ftrace_return_to_handler */
> + addi r3, r1, STACK_INT_FRAME_REGS
> #endif
>=20
>=20
> bl ftrace_return_to_handler
> @@ -435,15 +443,15 @@ _GLOBAL(return_to_handler)
> mtlr r3
>=20
> #ifdef CONFIG_PPC64
> - ld r1, 0(r1)
> - ld r4,  -32(r1)
> - ld r3,  -24(r1)
> - ld r2,  -16(r1)
> - ld r31, -8(r1)
> + ld r4,  GPR4(r1)
> + ld r3,  GPR3(r1)
> + ld r2,  24(r1)
> + ld r31, 32(r1)
> + ld r1,  0(r1)
> #else
> - lwz r3, 8(r1)
> - lwz r4, 12(r1)
> - addi r1, r1, 16
> + lwz r3, GPR3(r1)
> + lwz r4, GPR4(r1)
> + addi r1, r1, SWITCH_FRAME_SIZE
> #endif
>=20
> /* Jump back to real return address */
> --=20
> 2.50.0
>=20


<Resending to the right thread>

Tested this patch by applying on top of mainline. Build and boot is =
successful. Also ran ftrace selftest, intended test passed and no new =
failures/errors introduced with this patch. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.

