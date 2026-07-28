Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFB4749D2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Jul 2026 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279488; cv=none; b=CwXhK+QFKH8j9h2mc29KOH7heBYpZIvV1fUWmdvfWsJsphGOnptNcvCPb9FX87sWGSVS/sIHINRxo5wgSSjJSAdSAZ1VTwMauC9HV5JS0XpCG7sNeXU5KTBbXA/MzIRxxRUwfX+/qfg4T5Fc6RDyzi8VcYQJO3D00i4dDWvO4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279488; c=relaxed/simple;
	bh=mwBgDaRcjUrtK+2FIGTTE1Seh69/8X+u+immKYNCbjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndvf6eDxKE0phGYvZiYrsQy2KO5Ikr/5omypwckNxw1QGXskVHeDRdSMSKaogk5MhqDOVujKIxEFx/lo7Zr3sITblQAWTLRg23mPxZJNdzB2hBmWfycgCQyNgo9X/GcQ4BtZ+TR2pF21N7hMhS5ku1p0aARLjdW/BB49apKi/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NCsR2n79; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NCsR2n79"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SLHkPu450481;
	Tue, 28 Jul 2026 22:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qaMGsT
	pFuwsIuYqgKD4Hilx9BBwxnwshe1/ay+mDTC8=; b=NCsR2n79Ildhc+Sm5t6H+n
	EQ0YqC5/e3pocvw2GOa0y2g6TzsPVLo0Y0OFgTDzYKbcmATfq/9Av0iCjLYekqsD
	2AZydO4t2hjNLs4TTmbsrZyDWIE/1H8vhZ/E3uk9dju+UNyDenQXGjbZ4L5ZkIxm
	Sb47C1FwGV4JQya55JZVR7KJGVviWBQG7VxOl/PsxCFlGNbOrH0NPPzSIMYhXXeh
	8bR+gId+ynlGj+GBhxgvz+mMKCUFmGH6+6lF/Wny/BPJ/HTzP9OSQihNtOmw+SLE
	OyPqLG+9Ziu17JFCseLiUkhXVp0YbBotxcZFkLfaqib7KW0Eb9aO3pfapnM4EQyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycfvxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 22:57:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SMuctK015957;
	Tue, 28 Jul 2026 22:57:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhc6cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 22:57:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SMvoYF16056580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 22:57:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BFEF2004B;
	Tue, 28 Jul 2026 22:57:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C00B20043;
	Tue, 28 Jul 2026 22:57:50 +0000 (GMT)
Received: from localhost (unknown [9.87.133.185])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 22:57:49 +0000 (GMT)
Date: Wed, 29 Jul 2026 00:57:48 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Paul Murphy <paumurph@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sashiko-reviews@lists.linux.dev,
        Paul Murphy <murp@redhat.com>, ojeda@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-trace-kernel@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
        Eddy Stefes <eddy@linux.ibm.com>
Subject: Re: [PATCH] rust: enable fentry support
Message-ID: <ttiwqgc@ub.hpns>
References: <20260724170132.3783816-1-murp@redhat.com>
 <20260724172024.0648C1F000E9@smtp.kernel.org>
 <CALYDSrQhUbKDHsPnQqp0K4WMe2iZC-G1nGrLT6eQ9doCqdVXKQ@mail.gmail.com>
 <CANiq72nJ=7TAjtArF2VzDZqwKDcuMFjeisD25R2GuA0NiJwk-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nJ=7TAjtArF2VzDZqwKDcuMFjeisD25R2GuA0NiJwk-Q@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TLa-eqwTiKNR5g72zCWGYZEVpJ4Uz14W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE5NCBTYWx0ZWRfXwYvYT6SxAtUh
 2zLeyKzgPTr4W5DNs7G3+mbm1TNnhrB30WCPSHX/Lz5lh9Lo4SFM6g+7L49zbIbmhs6lEGGMzsE
 ywTS+/aMzYOW1PsohPbLsb/YkXVYFEN3kW6ua5ZT4VHA3lGU7SDDYMULnB2LX2hCT/BpC5C/PET
 6Y1zyeNqnJN57e3gZwvzL0x19y8pUy+evV5MWPX0XYgjITQVwUiSyUt6/Yoxqu3wkMc8KKPJne8
 +boq923GA08s6GCfuLhhuBRs3jmz62JCb8hRjArwL7vBv081K0GHEtp/yIP0GfLMsQsa4UDxliP
 nbqFnhH2AapXW7w3VGhnGSTMFsoCk+TPgWa3mFirDbTnMmbFLDmG3avQumqE5n0XWyMrvjEzloV
 J9qKKMIkmfGVZN3FeQf2uQJcbrEE7Cz3Riy+LOuPQHExpxjIhjYmG8peb2CE+aX4P4fIoefVxjs
 G5Z9klBmk7E90M+F7Yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE5NCBTYWx0ZWRfX1YV//myPUQw4
 LaOZ13jtbAv29Z+iN650W0Gda4ffqZxlsJ3MrTFqP8Kht76tusZ0brehrBvE4ecdO6534MkVT56
 TLpiTP6zOgHjAFycSbponEqB29Fe2/s=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6933f4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=20KFwNOVAAAA:8
 a=BUKiap52dCV2wjJGAl0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aZfxP55-UcalYPEQCleJorMegYMP_kLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280194

On Mon, Jul 27, 2026 at 08:33:35PM +0200, Miguel Ojeda wrote:
> On Mon, Jul 27, 2026 at 7:18 PM Paul Murphy <paumurph@redhat.com> wrote:
> >
> > Hrm, s390x has more nuanced usage. It still uses -mrecord-mcount and
> > -mnop-mcount. The x86 configurations I've looked at use the kernel's
> > tooling to nop and record as needed. Is there any reason s390x cannot
> > use those, or should rustc support those (for s390x only)?
> 
> Cc'ing the s390x maintainers -- they probably know why they use them.

Cc'ing the ftrace maintainers.

I do not think this is true for x86 in general. Generating the
__fentry__ call and recording its location are two separate operations.
-Zinstrument-mcount=fentry only generates the call. Dynamic ftrace also
needs the call site recorded in __mcount_loc section.

The recording mechanism is selected in kernel/trace/Kconfig:

config FTRACE_MCOUNT_USE_CC
   def_bool y
   depends on $(cc-option,-mrecord-mcount)
   depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
   depends on DYNAMIC_FTRACE

config FTRACE_MCOUNT_USE_OBJTOOL
   def_bool y
   depends on HAVE_OBJTOOL_MCOUNT
   depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
   depends on !FTRACE_MCOUNT_USE_CC                <--- NOTICE THAT --
   depends on DYNAMIC_FTRACE
   select OBJTOOL

config FTRACE_MCOUNT_USE_RECORDMCOUNT
   def_bool y
   depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
   depends on !FTRACE_MCOUNT_USE_CC
   depends on !FTRACE_MCOUNT_USE_OBJTOOL
   depends on DYNAMIC_FTRACE

There are currently three ways to generate __mcount_loc section:

1. The compiler does it with -mrecord-mcount.
2. Objtool does it with --mcount.
3. scripts/recordmcount does it as a post-processing step.

These are selected in that order.

Looking on my system:

For x86 GCC builds - current GCC supports -mrecord-mcount,
so FTRACE_MCOUNT_USE_CC is selected and the compiler gets

  -pg -mfentry -mrecord-mcount

For x86 Clang builds - current x86 Clang does not support -mrecord-mcount,
so FTRACE_MCOUNT_USE_OBJTOOL is selected. Clang gets

  -pg -mfentry

and objtool gets

  --mcount --mnop

s390 uses the compiler path with both current GCC and Clang:

  -pg -mfentry -mrecord-mcount -mnop-mcount

Here -mrecord-mcount creates __mcount_loc and -mnop-mcount emits the
six-byte nop expected by the s390 ftrace code.

So -Zinstrument-mcount=fentry alone is sufficient only when some
later build step records the generated call, as objtool does for
x86 Clang FTRACE_MCOUNT_USE_OBJTOOL builds. It is not sufficient for
FTRACE_MCOUNT_USE_CC. For FTRACE_MCOUNT_USE_RECORDMCOUNT - the
scripts/recordmcount post-processing step is also currently wired to
the C build rule rather than the Rust build rule.

Objtool mcount recording is currently supported only by x86 and powerpc.
Those are the only architectures which select HAVE_OBJTOOL_MCOUNT. And
s390 currently has no objtool support.

So I do not think -mrecord-mcount Rust support is only needed for
s390. The Rust build path needs an equivalent of -mrecord-mcount when
FTRACE_MCOUNT_USE_CC is selected. And additionally an equivalent of
-mnop-mcount for s390 (this is debatable, we could check if this brings
us much or we could drop it).
