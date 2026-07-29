Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F463CB8EB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354555; cv=pass; b=pNA7SvOKDRtwuRkxcKhyWICPHbMkV0WLKvoOAsCkCmie9w28iMhKMIRqdJ31Yn3gqHl7yt4dk+AWSUG4J2KQqvk2XM/OvdB90m16SrNjLADq8xpHy0EqCyAIsbQJwDPwBiyFXrxMSOcWmrNhsLnNQM/GCviK3tpE6WkQdxQ1z3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354555; c=relaxed/simple;
	bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVTCtExA1ZTjSrRLG6n1NkiXL3nyanziEK6OXDlQeB5y2QLaY8eQXOtbRUByxyAyP+mmS9JcxexRK3GSv8dBYgpZh2qvR61IoawrZKDslNkx8AKFZfjiaSEcsUvDhEEPcHt6u3a1lJ8e3xXdAlPVFvZA6okajsQQQYyNIYr//h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YK0H0xb1; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Ct0t1uRA; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YK0H0xb1";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Ct0t1uRA"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TJWCrU2320932
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=; b=YK0H
	0xb1DPm9nCDpxbGpqgnswy4YgJeR3BrnGFAshAoVEcGsbUZp76B7dTTDLlwA336H
	r8R+amugj/dUWLx/0DXqETIwgtKrrZZ95h0j6q0abz3sZT5caDP7KVALCpee2Qr4
	uhEyVr0pc2Wvcjp9RwjNzzcGqe38ZcD/nEW+P7UiNNaxvP0Z5mDdGnhfwLu7hXc/
	NvpzLBpd5Wkrtl6Q33yxS4lpBjPRr+yvYUWHtfQpzAWJl0E2rviGI0PwFuO5AslD
	Z5O+3Zhr6qXNG24in8/OTW5yH/CzrvoePvA/wzI3D94//uPKj/wgga7iias7Zxr/
	effjiovKfg3ZLmTuVQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq308vxa7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 19:49:03 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-80ee3cb097eso27366567b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 12:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785354542; cv=none;
        d=google.com; s=arc-20260327;
        b=oacnXmO6NO08PsarP1etScL6JpP96eL5l1nQ8YS/deXB0+IZydPc/d/L2HZsltVpjC
         pRRrG8xhqurK8ifsako+hEIyWRyXMCRaoeLm61SiGLqXHU89e70sH6uxB+imwbGQqSCP
         fafjlgTmtvO1KaPgZzUsh5dVQ5vF/pkmmWyybbzROPa0h+ZoWeTNWWNu7hHVr0abXOKw
         pnoWBHJfGvY/wNd03I3DxkgKGX87Efler6h+HV2l/8OITKhTApiyvw/R33SsUP6OwgDG
         ED+Vfl00Ym9ma6u0Q/PXvmLsS+PWYzBpLyluEc7G7jDDTI+T34xug6lKBPpVAx9r9vvm
         BjKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        fh=JItKAguzFkdd8wYdLFjlrfhH3gsM3QgvpY+vjQMlV7U=;
        b=AijcVfKTAeKm5db+dpSlamtfZMNH96dVzmqCG/HFsW1RdWEq3MpexXFRGPqk2aJ7tg
         yYMAZV4fWE1PehNZPVqJwt/6kBak4m9UimIUaQHs2PC0qvLc0yVX3EatnBssvpANr8bZ
         atxNiQ6XLkpKvEYnxHFCqJ8pAa9SJLOCxxX6P99JGgIYps6tGPlKr6LymrSLE/+Y/KUI
         4x3QJx9AASReqR4ykmpVYkJJJRWcmBOJ4gjQJoF+Yd8Y9ZUVjVZRwv/lulvo4uy+1q0U
         +QlmCoOw29zhHzf4sRyoMLPNNoYp35zHuDr2acfhCadkHqeD5yjKVZJdm73PbrOuHvTY
         O/Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785354542; x=1785959342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=Ct0t1uRAKmNEO6pU2WZjuhEiLI6pnLsHrBXITu9Y3sLBMtCqAKrLBKserQ1xNGkp3H
         qgEE1s8+hL89s8d8/Cwrdn/tVvwD2Dmd0/lAy54ADr7VSWlOQz6l1+dp7vJGPiXk7kly
         5nKFRfVqHmi5JBIn0BOTs5QnPf8usuSlD248mYEoCDgQXrRIHpOGu62+xOk2/Vjnt2U0
         f9AHmkGsflOWZfV8FlfY4v4ROwWPVUJXrlnKYYsavAnNSjs27J2rSAqjs7l3hql4QC48
         Q7UwkRq44+bu69v2Q/QX1aVCq2c9bMD9x7rhUacD7dKH+NTZOASip+2FLwmYiCILt+ti
         fJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354542; x=1785959342;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0WW8IB1JX2f94+iPoUzoqfdlDsRGZQ88EgPOwCAJ8y0=;
        b=gML2KKMgX/PmqcbMMyV4RdHoikuMXViLhNU5AOP6iO8seZi2elZ8z0m+O/SghX5JPA
         cCeFuLtZ+bi6wIlkNZJSwIXY+jEBGTkiiaYz4ME/VhirRt2YFolptY1DIQu+O4GpY3Mc
         6xFEt7eS1LHh8O75eEYcY1/Z4GdlVgFUOj6Hs8Ue4lh7unSY68j/v5Oy6mpJSimh4t4v
         RU3a6bomnDLfy8tZtQyvhKLLi9M4qUgDedr8VigTonMRIvHOjgL6PyqkPuWoF4wJM3pj
         asULgrToZlSYu7QQKufpGgNvf0rwg1LWuzvzXarPj940psMNBa9cg65TdhJd2xEWE/iT
         2FEA==
X-Forwarded-Encrypted: i=1; AHgh+RpBGJz8m9BHXfexId4jbUmQWIfjOpyf5IZHpI6ggQkytegxfwb8rwRIT43SAxHMyzLTXEYI7rqah+It2l+rrXmjrTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BAlVdJjO3alSoB931M7GRwSUbsaJkiDW+wZ8Eil/92AE1K5O
	+D/EGCWz1FB5dMjAqI/4rkILPrbKGZVn5E2UpWrGeI6phjOgPSuMhdQSwwOmI6gS/o2eTnj+JLO
	BsIT7zxAq7UkNsuMmZteCEK2Xfmo4rt00gC68S+bpjWp82ANBetuRe6D1XXx2a6M/Hor1DiWILs
	jb3MKShOQSYnWgWYcl3b0vXAcIs6r6FjYWFFo59QvjtIBcBP3v
X-Gm-Gg: AR+sD126hb2usdouEEHv+3BjAlU/q+o4kGVr4Nz/cUDzqYZWAOlAPrvWJUFBXbxorzR
	7pCw3qan+74hoBlXS1wdOOGJFPGi2XknEjyoGkDVa3gSsiv0nNVMJE/kKBUHWI7uqKXvtcUC2Jg
	r5kwIxinSa04a6xp6WxjALJh4VUHuYk5EXkhDYGOhDCYmojYQ3genEgxFb
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id 00721157ae682-81fb5e5db0emr1654767b3.70.1785354542388;
        Wed, 29 Jul 2026 12:49:02 -0700 (PDT)
X-Received: by 2002:a05:690c:4d84:b0:81e:d91c:29af with SMTP id
 00721157ae682-81fb5e5db0emr1654567b3.70.1785354541887; Wed, 29 Jul 2026
 12:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
 <20260729104114.04298a48@gandalf.local.home> <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
 <20260729113136.32af2a4d@gandalf.local.home> <CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
 <20260729133232.1e6c79eb@gandalf.local.home> <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
 <20260729154541.0099cb14@gandalf.local.home>
In-Reply-To: <20260729154541.0099cb14@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 15:48:50 -0400
X-Gm-Features: AUfX_mwF7DC0oGaTu80DDaK_FjjbvMjtCRB7Zz3uBteLMCWzuxKcaF0VD4WX16M
Message-ID: <CAOu3gNj=Ev+gW82_K1LFhjDWrmJ5CXGU26P6Mb8kEZrbGaMdqQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
        davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
        linux-open-source@crowdstrike.com, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX+/KE7QCrpsfS
 RFdy0VD863vQ6YFbuBqdZqSWW+cWz7w45mdj4rprPLTt8qBuS5xOrgSJnVFNuZAW4b5Eq2RSZF/
 EpJrAsNcp/Iv6bh5G7P8WhvAw7WDe5bCDdooDYMFZ1HYNQparELd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX22rk0acmo8os
 jKx7fNEYz/cuk/eL6KTUWgycDmX1Iv9CJq1rBYtzc/nkMrRXSIXbL0wtPPCZBfAZ3/2NTMDvygO
 Z6aSsLv3hW7rdOmJTU9K0x0VOYpYDi57Rb0yi1lbdqtx3V//QH+Wqy/3AeVOgy9hMUpiupxPgSq
 epuqw5jUUUtEcvljHyhQZbzZKdjRykBX9J7OhwFs+CiVzThOSmUw5WnAC2i8jc8BoTT/S1SKVKL
 3RPBlzVzUIenvFhZr8uuKIk5fsFQyHcVNNRooXRxMxqWPucgPbVrTVB1iKanDIPyL8d6sXDU8F3
 QwXr0ziQoXvE9coj4RkDsfrm5LXTX+4q5GXcKAq1vi2WclLsAHxHGnD9osFtclfoUq+ORLY+4GS
 sK1H2RzXusHR9mvWfZmv3EYsK6YgioAcPeMazW0qnqbhnDH9qUJLeykIx15gJQoIeJ7uIhct3E2
 VWDZVjzWlaymkxHrWwA==
X-Proofpoint-GUID: uxv_JPXhh0s1DwcNhFtQFMpTL6p_CzVW
X-Authority-Analysis: v=2.4 cv=fOAJG5ae c=1 sm=1 tr=0 ts=6a6a592f cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=b3B37AjAgz0HnGB3MuNd:22 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=jHs7IjXvhldTIRZNGaAA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: uxv_JPXhh0s1DwcNhFtQFMpTL6p_CzVW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290152

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 29 Jul 2026 14:20:17 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > Should I also clean up the entire PERMANENT flag logic we now have and
> > drop the flag itself?
>
> No, because we may need it in the unlikely case that we need to revert th=
e
> disabling of ftrace_enabled code.
>
> After so many years, we can drop that flag if nobody complains.
>
> -- Steve

Got you.
Will do.

Andrey
