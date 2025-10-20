Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14570320CAF;
	Mon, 20 Oct 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969231; cv=none; b=TSqVP0MR3RF18mDlgh5acN9yrbVs56BCvcg54Oy/PpMUc0N7X7H8I5Ix6FzToNJPt/OPahn7rNAqDLI7OSO4oJhKMI6x9+qZQ8YPlFAmAkGmqON8+mfudaCg7EN7OvZpQfkIPtCQvIA5q6bsUs3EHwfKz2aJ+6VC3y+C46L3kPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969231; c=relaxed/simple;
	bh=O+0KWMbFn+Xp9EiijEowPqXqIUgSIqrjtwX2V9bpQ7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2WT7/yfTKioURvzUI3fsZj64c6lOjZqMEqrD0cXTFbsKLv8mD+YPxPeNQ09LcBR0gyDl07rcZOmwZsEow7QdYi3ZRRIPGOAA+Vp+6TgPcEzrQQbIEk7urmh//oWdJyKe0ewH0Se/rp8bgLZ3nLRPyW8QRN1PayRPq0INS4izi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g66D8ti6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g66D8ti6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAobCv017546;
	Mon, 20 Oct 2025 14:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B804US
	0ey6Mbyu9dWEPe7fPCHKs9s52jhYL/kgQECzg=; b=g66D8ti6tn3Aw9EnGAUnI8
	mTQqJccsleNGzCYjCe1LDl6dU9fkmQWmNYjrXryV/GBHKEzk7DZ0RiASYcFNEOy0
	PSsM+cdAwXQrPs1wlX2TODbMwc279ZUUAfgmj1CyJcSG3oDFYFj2B8mdSnx8e6mk
	PgQrMz2dQh+9YqJJ/htg4H419WFvGwu4Ny9JtPaQhocUQz7kWI2cVQV1/+zY7fzJ
	f41j5vZi4fHbnY6PkAzj3kTIWbZdNEtfdnX6g/kf09FVm0l6zIxCqxrcHiV1wp5k
	aTNTkXnqXm2muagCWCrRBUQ7Ip+s8dwq/ey4Ti6Wu+AVCFfZiRmfk9dzGyI1Wb3Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f1u6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 14:06:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCGFm9011066;
	Mon, 20 Oct 2025 14:06:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx0wqpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 14:06:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KE6En821102856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 14:06:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7AC22004D;
	Mon, 20 Oct 2025 14:06:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D52942004B;
	Mon, 20 Oct 2025 14:06:13 +0000 (GMT)
Received: from [9.111.204.26] (unknown [9.111.204.26])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 14:06:13 +0000 (GMT)
Message-ID: <31167d13-abfb-44c3-8999-02132a8b495d@linux.ibm.com>
Date: Mon, 20 Oct 2025 16:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] x86/vdso: Enable sframe generation in VDSO
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.173709192@goodmis.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250425024023.173709192@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f641d9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=3JhgRXgks4luCjnt5rcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: OpqjzTxfXFzaza0fv9DNz8e_-0M5Q33C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX53QSAeovpUvh
 BLVZ6yZMPkT0ELun7735ePODuR+TJv3E2Zo4clCXMnsfb0lJlNkDLFsjc0D47pec6zhK+3S+9ey
 b1w3UHvR1sfgRymY1y9GqjdTSKKaXNYZRSi5YCPzijDw2NwGmbfXz3Shg4kkCWXfY8GfOpZcAgL
 tGcQxPCQIf/3VBL5L5PPhwwf3KZyaS2s5ALuM6I9K8aQHsbyYI8nWVouGqu2CaIeUogN91075eA
 FDAvfk8zGQeeBMxYvg77qouDoePEY+KURawZgZRxmhjOfxFUYl5w/lVvPkBo4mAG5KnSKWU5tMd
 oLbcOalcrSl7xsWZaLz88MRE4cYrXF9dIi8jAvKPMe7cYQB054IFzCPtduOC3gc0xeTtkFVQAgF
 tVHsPXAn9tVt/0hySP+ozV5lfF3IdA==
X-Proofpoint-ORIG-GUID: OpqjzTxfXFzaza0fv9DNz8e_-0M5Q33C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On 4/25/2025 4:37 AM, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Enable sframe generation in the VDSO library so kernel and user space
> can unwind through it.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

> diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S

> @@ -87,6 +88,7 @@ SECTIONS
>   * Very old versions of ld do not recognize this name token; use the constant.
>   */
>  #define PT_GNU_EH_FRAME	0x6474e550
> +#define PT_GNU_SFRAME	0x6474e554
>  
>  /*
>   * We must supply the ELF program headers explicitly to get just one
> @@ -98,4 +100,5 @@ PHDRS
>  	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
>  	note		PT_NOTE		FLAGS(4);		/* PF_R */
>  	eh_frame_hdr	PT_GNU_EH_FRAME;

On s390 I found that the respective s390-change needs to be guarded to
prevent the vDSO from erroneously getting generated with a bogus
GNU_SFRAME program table entry, if CONFIG_AS_SFRAME is not enabled:

$ readelf -Wl arch/s390/kernel/vdso64/vdso64.so
...
Program Headers:
  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
  LOAD           0x000000 0x0000000000000000 0x0000000000000000 0x001508 0x001508 R E 0x1000
  DYNAMIC        0x001190 0x0000000000001190 0x0000000000001190 0x000100 0x000100 R   0x8
  NOTE           0x000420 0x0000000000000420 0x0000000000000420 0x00003c 0x00003c R   0x4
  GNU_EH_FRAME   0x000000 0x0000000000000000 0x0000000000000000 0x000000 0x000000     0x8
  GNU_SFRAME     0x0014f0 0x00000000000014f0 0x00000000000014f0 0x000018 0x000018 RW  0x8
...

$ xxd arch/s390/kernel/vdso64/vdso64.so
...
000014f0: 0000 0000 0000 1190 0000 0000 0000 0000  ................
00001500: 0000 0000 0000 0000 4743 433a 2028 5562  ........GCC: (Ub
00001510: 756e 7475 2031 342e 322e 302d 3139 7562  untu 14.2.0-19ub
00001520: 756e 7475 3229 2031 342e 322e 3000 0000  untu2) 14.2.0...
...

Following would be the guard for x86 (same as the one used below in
arch/x86/include/asm/dwarf2.h):

#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)

> +	sframe		PT_GNU_SFRAME;

#endif

>  }

> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h

> @@ -12,8 +12,11 @@
>  	 * For the vDSO, emit both runtime unwind information and debug
>  	 * symbols for the .dbg file.
>  	 */
> -
> +#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
> +	.cfi_sections .eh_frame, .debug_frame, .sframe
> +#else
>  	.cfi_sections .eh_frame, .debug_frame
> +#endif
>  
>  #define CFI_STARTPROC		.cfi_startproc
>  #define CFI_ENDPROC		.cfi_endproc

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

