Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129427F010;
	Thu, 30 Apr 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566263; cv=none; b=rfPuMzKLkSvjexUM0iy5yxMXXJEV3vQFMV5z2atnpt/M9f4vYBH0wogT2VXRm5qV13hzqOb0KO9NpPrIED7ZBNGnztKOMQuT5j/samJhhNWV/qbv/5Rzb2LM6/vw4Ss6zV/vSJvGP5ieE54wkeRZrQ6zK4iavkEDe8Qi09l37m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566263; c=relaxed/simple;
	bh=PvX+7Rpy6otqJqZxfCW2MnQ5RTSTD6HfhaTzr0z8+9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krb6Uk49Ov3oyeduP1keSTZ/Y0ATMASL0ZlDO/V23fEsR8YArJMnTdQ33C4Wfc5ZAZYzEn4EUhoH2IEdPDZN+0NRK7ZtpM3kr9VKoM7KKCWwKe4eA7pFYKbmI/I03r45UKAoiJDFSmu7KgG40H5W+9+JXtzjpTXDU2VgaxG+C1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NzGoUOgd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NzGoUOgd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGFGVa1456647;
	Thu, 30 Apr 2026 16:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EAQBzA
	rHcNMVM71micpeThUsUmNsfQEmWRe4OdEDRws=; b=NzGoUOgdbztHmwZHWgONjA
	raRm+5c8stIfOAQOOXf2kP/pYWtmuXDVsyo9b1EEw6B/tynOYWjHhVO1IRL/pMXp
	Xjy+vQRvg9/7elbwiDqMr13O0SFVaSSvAyk0+CHkJ0SskoLWhuc07bB6C9a0vEvR
	ZmUZVw0X9Z3wUbFp1ePgmnDOj7Gkfiyrj4y5lQHt8mE2DSu6+9czUMUaoZMDqI1H
	pIBYqsazZ/kHsKtaMs8uDfbU/DnYTvpBHuxzPDCuyNNXWsKC6XkXSQSx7KA6RIlJ
	CIAg6RaKJOcRtgXOicgqYGVL1m8nYfBBBwiN5HT8dJqmsWv/gZmaBAHt4vLqrn/g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vpy41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 16:23:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UG8ohn007501;
	Thu, 30 Apr 2026 16:23:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqkwge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 16:23:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UGNLmc49742124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 16:23:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8609520040;
	Thu, 30 Apr 2026 16:23:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA09C20043;
	Thu, 30 Apr 2026 16:23:20 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 16:23:20 +0000 (GMT)
Message-ID: <46aa63d3-0ebf-4062-aefb-86cf0f05dea1@linux.ibm.com>
Date: Thu, 30 Apr 2026 18:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>,
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
 <ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
 <20260429145512.461e09fe@gandalf.local.home>
 <20260429145815.69dcb1c0@gandalf.local.home>
 <20260429160344.7e5510e9@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260429160344.7e5510e9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f381fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=meVymXHHAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: -hSW_O5p2nSOB1nch67Bj0CeTTFs7ILS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfX8VRHONAa71JN
 ctSfz7kejmYYahGVRpvYD3PEvdYFOR67e/o/SmGX4PGf76uGJAn6CP6VyDJ/GTRiGBMaZNqNtgC
 KeerdWkp7RHI1fGlAMlEdUjaTnmO0kovUOF3L960CFaspc2OyjOcxEwsRZs8B8jXvRlkateebZi
 RiUJOoSvfCTNXHz/4g//0WQ1qDyyB8ZVeiGQi2JXNW5L7e8FeZrUDwosaD946jUNvQWxtZZjkUQ
 q/O+v8NRGXq1a3dSYX5DLWObgk4TaXm4HyOQtYvSghIMveOHkcSUt2PFtR+7GAlTRzjtidpG6bo
 ihdhEwijBzG+Cx3StzbIVG+wGt4/Zv0YpNlT+J9aT8udyLRIpmppvzLOnCjjigL3JWJttsZpbn7
 ru9sV99vvaRv3NtqfEx20uA+c/Qwh1qwgBu4+SyxQUyLs75Si1OYtORx8rICoSHXEH50D0J6234
 wTiGxEv2yb68rQw4Q7w==
X-Proofpoint-GUID: RvbVqX0okIcRgVcA2lin9pgq85mKLEg8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300169

On 4/29/2026 10:03 PM, Steven Rostedt wrote:
> On Wed, 29 Apr 2026 14:58:15 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> If the main executable doesn't have a sframe section, I don't see why this
>>> shouldn't be allowed to add one.  
>>
>> The address is added via mtree_insert_range() which states it will return
>> -EEXISTS if the range is occupied.
> 
> I confirmed this. I changed the test program to load its own sframe section
> again, and it errors out with -EEXISTS.

Should an executable be allowed to remove its main executable sframe
section?  Currently the kernel takes care of registering/unregistering
that.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

