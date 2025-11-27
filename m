Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AA52D94BD;
	Thu, 27 Nov 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764262346; cv=none; b=ntcROnBq5/PDb56YcxvnB9iC3n0QhHi+2eh1N7cUXn/ZXMyjbxuugrzIUyW1uCtF9af8Qg4WnJl2oo/w24JFh55VC/2vTsjVALlP7j3oavGsp0MFV6rBiP2y/TOvgjTcDalKGds2TYr7G13eKTQuoJxwQR42FrnAVJDUyJgQmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764262346; c=relaxed/simple;
	bh=NOBr0IPZLiHTXKcsJsMcOPpuhcn58DxbhtDWgQGxT40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sz4d2lo3Ehea+4paw3iy8BVzzab9Sb360ehnu6NTpMhJUZqI7f6jicyGP4QHMVUPq530zqw1aRzp3De+RF7Xe+DqdrYU1+bk6/UM496xQFqzh47v6KzmP+zovdyXHzbYAPMBTOW6mvBI6Hss12zD8Wg09ZJItbBh6aCoo/SZWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eX6sU9zW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eX6sU9zW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARFaBA1005188;
	Thu, 27 Nov 2025 16:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HlhKJZ
	MgpGME+PYO9GqXE+tCX4ZwqLGrTvuP+EsRrmA=; b=eX6sU9zWf8FfeezAPMHiXD
	fwrNsC/uqPtPgpadPGzERDUGxUL4mvbsqcf+cD1oVoDaJie21BYlMQxJ0NxAAOCU
	z5hOd8Dr2Bofk9J4abDaCf/p5njX6sQlhTX6TNMlW1bdkAVJqBifus3kXsk/z0xA
	esyD6prAxmBi31jvTRm9rx8VcqAy+SCD9dFnEyVXTsYzm/NQJiEZSj7qU4W8osNP
	Pa+5FN18oVpjTSVyG85mqxDpCf5rSn9+BBucIUHAacGx2IcOIcXZzyeRj+zYe8YE
	Vie4F68E8zqxQL68LwVIzjclugfs72dwm5n1ZTjiqKhRc9ktQRL7Sg71PLU1NLKA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u2984u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 16:51:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARE0TO1000851;
	Thu, 27 Nov 2025 16:51:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvy94nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 16:51:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ARGpmup59900170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 16:51:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6489520043;
	Thu, 27 Nov 2025 16:51:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF3C820040;
	Thu, 27 Nov 2025 16:51:47 +0000 (GMT)
Received: from [9.155.200.37] (unknown [9.155.200.37])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Nov 2025 16:51:47 +0000 (GMT)
Message-ID: <20dda91c-46e4-466d-9ebb-7e12fc6f5d28@linux.ibm.com>
Date: Thu, 27 Nov 2025 17:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] unwind_user/fp: Use dummies instead of ifdef
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20251125164349.2592874-1-jremus@linux.ibm.com>
 <20251125164349.2592874-3-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251125164349.2592874-3-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX54N/8/jq7KN5
 RQ5aX8Pc5fn8uZq67gBxp8l0Xb4YUVz6fbf0MYEx4PM3XKZCP2fjNBx2vr2hKsi/BXcsAxkiRdg
 AbUWYgkUKSjiDwi87WFPgenKhuDVwx+ZCPNw8aM25CbnhAvdB5Bv1ybnFtJaPdmTrePuhaP/h0D
 Fspybnoc/j6r1BadAbg4o28nHWyYEYXU/R+w9GAhk/6vOGV2SaOtUKnvdO9H6tp8KXNPUzDiePl
 v3j8DTSzBXxLAzTWAzBT7ueNDU/IyQdRGfjiupAaOckEY8nDwOKvOOT4bsL7j8FwzW/ux4iyfkv
 64oBD6p27irJxUdJ9lyuz5bz8kWuzdvwpUOj+2vLeklwpDubpBFzPItUJq27YdILvPnvQv++Orc
 9ViV1hVJf4pI1sZLzfaVU+5zH20Vgg==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=692881aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=zQfrUCwJMigNTRNSlqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BT3IUAD3N9rfMyWkIunLI6JebDVfTY83
X-Proofpoint-GUID: BT3IUAD3N9rfMyWkIunLI6JebDVfTY83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

On 11/25/2025 5:43 PM, Jens Remus wrote:
> This simplifies the code.   unwind_user_next_fp() does not need to
> return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
> unwind_user_start() will then not select this unwind method and
> unwind_user_next() will therefore not call it.
> 
> Note that enabling the config option HAVE_UNWIND_USER_FP without
> defining ARCH_INIT_USER_FP_FRAME, ARCH_INIT_USER_FP_ENTRY_FRAME, and
> unwind_user_at_function_start() will result in a compile error, which
> is helpful when implementing support for unwind user fp in an
> architecture.
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

> diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h

> @@ -5,9 +5,17 @@
>  #include <linux/unwind_user_types.h>
>  #include <asm/unwind_user.h>
>  
> -#ifndef ARCH_INIT_USER_FP_FRAME
> - #define ARCH_INIT_USER_FP_FRAME
> -#endif
> +#ifndef CONFIG_HAVE_UNWIND_USER_FP
> +
> +#define ARCH_INIT_USER_FP_FRAME
> +#define ARCH_INIT_USER_FP_ENTRY_FRAME

Will fix this as follows in the next version:

#define ARCH_INIT_USER_FP_FRAME(ws)
#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)

> +
> +static inline bool unwind_user_at_function_start(struct pt_regs *regs)
> +{
> +	return false;
> +}

Would it be better to provide a generic dummy implementation (see below)
or should each arch implement that if it cannot tell whether the topmost
frame is at function start? If so, would it move from linux/unwind_user.h
to asm-generic/unwind_user.h?  Either way it would need to be outside of
the !CONFIG_HAVE_UNWIND_USER_FP guard.

#ifndef unwind_user_at_function_start
static inline bool unwind_user_at_function_start(struct pt_regs *regs)
{
	return false;
}
#define unwind_user_at_function_start unwind_user_at_function_start
#endif

If doing so ARCH_INIT_USER_FP_ENTRY_FRAME should be handled similar, so
that archs do not need to provide their own dummy either:

#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
#endif

In that case only ARCH_INIT_USER_FP_FRAME would remain guarded by
!CONFIG_HAVE_UNWIND_USER_FP, so that compile would fail, if enabling
CONFIG_HAVE_UNWIND_USER_FP without providing ARCH_INIT_USER_FP_FRAME:

#ifndef CONFIG_HAVE_UNWIND_USER_FP

#define ARCH_INIT_USER_FP_FRAME(ws)

#endif /* !CONFIG_HAVE_UNWIND_USER_FP */

> +
> +#endif /* !CONFIG_HAVE_UNWIND_USER_FP */
>  
>  int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
>  
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

