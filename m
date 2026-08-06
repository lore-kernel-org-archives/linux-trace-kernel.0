Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E838645E;
	Thu,  6 Aug 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023324; cv=none; b=WbLDyg4V2KlgKjsG2DiyhuLoFn+Jzud2kTN3AGtNfVS+1uLwcV7vk9L/8WlBJSxU5V0Ze5xDbpdloMU7KXc1bMzL/sbBt9ycrlLHP3UsnzCEPFJnM3tXL6EmfXOzLgnVC3GF2Vtir4Fy/DsBPcC6YG0I8MPCuURNQ2I3Jp7RgYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023324; c=relaxed/simple;
	bh=6WOUaYVtl9kIfgUtlfuaxglgjlouSRKKqZ0p/VgF24Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwo1vsrAN36HeIV+52/EdEPO+efTHVDlJ5IfPQ1KUTL8qkTexom7t3cngx0fJsliO1wPSWwZ8Z2/z6kNi2zkgk3b9JF8zF6wyns3MtrMNGeMt3LKj6CjnF2sqm6bw7j42hhvdzb65VJl8mIT/9pXT6ytC9NqIRBju3NshdCUVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EA20htVQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EA20htVQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nmra01068446;
	Thu, 6 Aug 2026 13:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WV5VnaD2da3/Wc+lQzJnyOpsrJF+cL
	tjDaqj3yjNJeI=; b=EA20htVQSpE3k7h66JyiiVIBXyNY5Obzdgxvxd9wMGg8cV
	cutb+wUp3qldS/0bDe2B4lzC9JSjV0ZCxpi3d4XT7Wvf1536yUjtB0G/THCA183f
	QNT4zsgFY6ltAo95a5K9tBnLw0uZBeMXXGdxUlXiSPKyKUG3qWyWyeuhlvy7gtCF
	Ax+Cl7cbOo1DHH5TThW3DsAYzUg52mF7zC2RryfcXSiLzVxbswBM4z+suMJCBEhq
	bCj+y1tmw6FoBBmYcUmOAZh5I0Q6YDq2dyWJ8lPfB30oVcRnaKm3xBSdByq4j4s2
	ghJRnDjZUYOgEEIDVhCwiTmwMrBpoGaM0a9O4aLA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a48e3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:35:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676DQigT005336;
	Thu, 6 Aug 2026 13:35:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgk4q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:35:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676DZ0g835520790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:35:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D310C2004B;
	Thu,  6 Aug 2026 13:35:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A84D720040;
	Thu,  6 Aug 2026 13:35:00 +0000 (GMT)
Received: from li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com (unknown [9.224.64.159])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  6 Aug 2026 13:35:00 +0000 (GMT)
Date: Thu, 6 Aug 2026 15:34:59 +0200
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
Message-ID: <anSNg4EA-tUc3C7W@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
References: <20260805131904.1127416-1-sumanthk@linux.ibm.com>
 <anNTRb2aGsvY8_Rf@redhat.com>
 <anOlxodwEMPvb1EJ@li-0f4bfd12-9554-4bfb-8b14-7ccf0f0767af.ibm.com>
 <anRpdyApCza3MYVi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anRpdyApCza3MYVi@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a748d89 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=x50oQC-lhhJfbDA-FTcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iN4K-sujkeSHo4wz9-0aXCjqXld-D_e4
X-Proofpoint-GUID: iN4K-sujkeSHo4wz9-0aXCjqXld-D_e4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfX7FOvioTEFrSX
 1Me2qMShZI/NKRL2FI4ui/Wgg94iQ90MEX3U7lpUdKVbqeE0NURiVVpLJsa9UFfdONv22gBFiMr
 GDqHpbHtnJEn2uimYcP1BwXa84+dg3o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfX0sGor8QxejYY
 /fWhxO6Dnw5IoXxQng2gg5nbpMifE6Yonr7RVJ95TkadZ/Qk6AOFvTqdsBrg+CcOW2LfCOfuOi3
 5SqgGf3jNk6tRecgPfa17pMZb8dJJfrGv2D3FK09Dg4yu0+E5PU1NMhTaoRultanyJ6yGLiYM8L
 2oR0FwLtYTJBdAWRQ9XtWD+v1CD0Ls/ToCyjQxZonVowTV5OB8SmBscSmNUeEAeuyrn9oGUHNvp
 eV47+VdsE1Kq0TjmqFDAcY2e1cWl0104YbiZKK2q1FM4btI5vUHIW1sLEguph+JjxjQlsmodfrY
 yakzomMRT5c3jWsLv4RTw2YhOixFd72ciZFQHdPLVesZh2nofHa6jw1sC5uG+fS2mQmEAEFjNvz
 hHziRmBll3Kd9mNDm+hE5cgVGn5AAjGcRezzlbeuP5YG6uPj3uB+eZyYph+tcDBQII040nxIong
 5B1tbT6HvbQm+3e0Nig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060104

On Thu, Aug 06, 2026 at 01:01:11PM +0200, Oleg Nesterov wrote:
> Sumanth, thanks for details!
> 
> On 08/05, Sumanth Korikkar wrote:
> >
> > So semphore incremented to 2 when a tracer was attached and decremented
> > back to 0 when tracer was detached. install_breakpoint() was called for
> > both vaddr and succeeded, also remove_breakpoint() succeeded for both
> > vaddr.
> 
> Then I agree with Andrii, we don't really care. IIUC, only the value of
> .active != 0 matters correctness-wise.
> 
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -1155,6 +1155,9 @@ static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
> > > >  	bool first_uprobe;
> > > >  	int ret;
> > > >
> > > > +	if (!(vma->vm_flags & VM_EXEC))
> > > > +		return 0;
> > > > +
> > >
> > > Well, but then it makes more sense to change valid_vma() to nack the
> > > non VM_EXEC mappings ?
> >
> > After looking at your 2012 commit 78a320542e6c ("uprobes: Change valid_vma()
> > to demand VM_MAYEXEC rather than VM_EXEC"), I thought changing it in
> > valid_vma() was not the right approach.
> >
> > "If a program maps memory as non executable initially, but it has
> > VM_MAYEXEC permission, the program can later call mprotect(PROT_EXEC)
> > to make it executable." So adding VM_EXEC in valid_vma() can be too
> > strict.
> 
> Yes,
> 
> > Hence, I think install_breakpoint() can be one point where non VM_EXEC
> > mapping can be restricted.
> 
> But your change in install_breakpoint() essentually reverts that commit?
> If uprobe_register() -> register_for_each_vma() finds a VM_MAYEXEC vma
> without VM_EXEC valid_vma() will return true, but then install_breakpoint()
> will fail anyway.
> 
> Oleg.

Initially non exec vma will be ignored via uprobe_register(),
install_breakpoint() will reject non vma mappings initially.

As far as I understand,  if mprotect(PROT_EXEC) is performed later by a
process, it adds VM_EXEC flag to vma and calls vma_complete() via
vma_modify_flags(). uprobe_mmap() will then call install_breakpoint()
and now it should succeed because VM_EXEC is set.

So, it doesnt really revert 2012 commit. But it just defers installation
of breakpoint until the vma actually becomes executable right?.

Thanks
