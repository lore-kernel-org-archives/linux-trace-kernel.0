Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D13EC80E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.148.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337249; cv=pass; b=lTSkhz+jB2PZuk35YfRv/LBYIr5ZC9KVPx60IfOmK/71dgh7ELpg0grTLs8JpJLZ8W4BK7R7HoZTRB4OM3d6zNzceNptSrQFo6YEzGEOkEtZZUlGRA4pABvJNrRrveywiLH9oPhA6gokDTERZ0gDkmDrMZeItjcxfbOP9BgWpLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337249; c=relaxed/simple;
	bh=WoRDoEi0VL1vigksALz/83dPkS3F5vPYjkl8rzXgfkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh3L4teOu4MyQi0L56yKF4p3P5NdRBwjgSFKomoeRAbePV/LfU6T1nLvINBHMdAeS9ETsqmYnQEqr+qV5qCDkB01E44ZOLsBooECSzGlL8Q+sdbBcPhSkLe25ntru+TaV8UuYE1SVW/Wtg68Pet64DMDcf3GSSVof8E2A9a/KfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=McQ1nMx8; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Qu6l3/39; arc=pass smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="McQ1nMx8";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Qu6l3/39"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDU5lu669727
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=; b=McQ1
	nMx8M7wPOjuOLAkLDA6WuHxFcrcAStnEaL9XPowHaB61V31/WItQ/KdjBYstRpwK
	P+O5TLQc91sUMJSjuMaWZyc8qd1Aeg3A7MrBzuKtAkVZ9D2TEjrYp75iz3jQDOja
	WFnbMcZOrkrsE4DyxHhfuFuY6UhCfcM9qYgnJBF5r88ZTN1MSo+1YXmC8nwwX6ud
	fyvDRcg+iKR2WyvT8SjElYxyjfR9i80ynYuEp4yEzjRI44b5nuM3wy6zlupaiH5Y
	eslsUCM8lDphmgvIYrnuVGF0Jb4CsfC8FFNXl8wPmf/x5yjgfL3pdJtA2FWBQRUG
	vw9r71nevvUHAXnFvw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4fq6mctrwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 15:00:45 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7f582244e9eso19897397b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 08:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785337245; cv=none;
        d=google.com; s=arc-20260327;
        b=AhJAXyrDjN3JCYx1vRlOaqFExx3tDJHY6zUG+GjqbPNEROqeHGfHfZBUB2CGAxUhYJ
         TUS2lOx4xHOJ/Lk3tmyDQ8viaOmtWLDOqDnbZBKTVtOvVoo9diL9/jhLLKQENpdTXBMB
         G/LIhpiIveMSnz9957B0rTuLQYAiAlsl1VZNpxly/UNeh+dDi+cMPRC8qoKe4nitiahe
         4/3al6XT5TFdCxlMX3YLPhfwnurJct+4pI+ssS4JlGHjMGFPjRaj71hCIbPvRKDheIIw
         jKwwtvbGrQl/O3Wy6aSkgO3H+Vpussya71Q93+ZdSClrozIY8C/mLo/gBaFgcda2PQpD
         ya1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        fh=mVpSVkLHWMYPVgBoHbU+EN+m1orWDD1HNGRDYEOZTUw=;
        b=OADwo1DHsW05epnIMRC5d2ZPhZy2PKq1Fps6Z/0PRFrrw6/do/AB24ufenk6bMMpWv
         eQn9kZepk09Qpbjm1Rpk8QKd9q/ImXjG9VU9k/OTERJmzFQ45MkY+KJ2JGptajZJkXZ1
         hoC5UjGAxlIDa8na6gsltbykKXen3TP7YQe/YXLQLshShuUFVXmkXR284vyNE5/VEhHb
         48816bBGG/dpo4LcXS/ORpjSJm7C2zOVVgs+bZ6XYsfNFHl9bRDZW0jTEnpUniWLLavb
         lQm48m7G0KFvBJMD+yK9S8jynnzL8NVgFGD77Mig980z4BukbWOldfl8OQddzKZClp6f
         ztvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1785337245; x=1785942045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=Qu6l3/39lMzxJJwhCPtNM7+PJrnRNx9fGchVjQ8CO1nXJ8xU0GTdoX2eEqLrH1jhKX
         HsLF7/xYVtIhsfDcEj+BRLLzyTYnSdQ7gQFUdCmm1Ej8WiX71HjOL0aQeRrUOFHGQGVc
         VRnPqgbHsU8YLgDA5lE+B0ws1GWGDQxK9qHRUCczMtBltukfh4RMHuUqt/JCYka559nU
         AH2efMfwSTik167uU4KvhBoTLhtDkZq8k9TWfUreYDKe6QeCKIDsqfoS/7PTEdeKz2qV
         +BfOPLza6P92ZD/ecn1znUfqKYMMSmlja18J7XMzOHGjC8pVdo0BGOvnctbLSfOpr8Eh
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337245; x=1785942045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNsIs+LJSh7r0iAi+d65HQSOE09/M+m4FY1F+mUNWXY=;
        b=UuKBWgL+ZEM04fbNNi7ZNj2zIN+/+JclacuHxpagm4Rkoyk01Az0EAPVvwyixkbS95
         qDzG+IamSK6zawqTUpAaYBeogW3E8QocHVOqoYdOEabRCebm0JRsjYtbRmE4ss0bObLZ
         lZ9fMS9K5+glBbRf+gbpFUPz1qZSM3hG3WIoPvXDTgZNIVFYQeTU7KMb9AInW072Tlc3
         MRPxxuhDkHWpJ6w8e83VohCiFDpIy6iPTbd9N8XW6cj7iwD0iVlFRAOxEFb5PJsiDCn0
         OV4I0FxHlVL+aJrGe29VA4dE1wTMNMh6k/sRFE2UpMCDElDQnxqzcgORed2/5gbn1pmb
         REDg==
X-Forwarded-Encrypted: i=1; AHgh+Rrwq6V8NfsSnHnmyL5t3xz0hHBoGRWG+SiyabPzxiMkxPDbFJNN+xGual9AnyHU8vunFqTf30L8kXV+fdWHH7ERFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sPGe9ATwIJMXvYBc8hMZNpPyzQDnAHOAvqtE77TQ08PxQOxM
	ThZtxS6H3vTlKrOm1pUb6n3T/6MKGpqY8SQoSVMDW01xkvjeeaqnVIo0AdYuUtbGUUYjqGrusHw
	gBdY4VdcLGqzeOchu6fb2k+i25ncIWjqCkauat+Edlg9VJxi/YCtAiltXM8jIXKKMXvW5pnW6RA
	80DKkrieMdndBSxPYKqVB3mLDPPy9LHvox1sWEgpzTym489Mwd
X-Gm-Gg: AR+sD13tSwF+beb1dGoeTkwIWoaFApajC76uu4XtbqJBRF0TtRuZ84b0+oZR5GiRFW3
	ja40rjvaVeCcpUfX7X0t9qA9eWKIYg6u72qxPKjUSjUg6PX38jFV5lHIG8/55LvyKwSeYqnzm4x
	ICCLAag0xoEagtu/6g08BhH+drl9Y9fAAidY06PUokt6lzzbW4J/dJ+hBB
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id 00721157ae682-81f993340e2mr37632847b3.48.1785337244847;
        Wed, 29 Jul 2026 08:00:44 -0700 (PDT)
X-Received: by 2002:a05:690c:6a85:b0:7fe:1413:f6b7 with SMTP id
 00721157ae682-81f993340e2mr37631177b3.48.1785337242714; Wed, 29 Jul 2026
 08:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com> <20260729104114.04298a48@gandalf.local.home>
In-Reply-To: <20260729104114.04298a48@gandalf.local.home>
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Wed, 29 Jul 2026 11:00:31 -0400
X-Gm-Features: AUfX_mxePSJcFU2kU3VYl-YapXlBxTsM8pdNfueUNu8RCOjDR26LSYERFFJr5l8
Message-ID: <CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, jolsa@kernel.org,
        naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
        stable@vger.kernel.org, linux-open-source@crowdstrike.com,
        mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX57LlskDuSgrI
 o/ob2Ea+79PO9m66F6RwT5cwVYUYPwS1J+YhpnwshB/THlNVCTf0+nq2GAJxGZWUCK/stBeSg8Q
 oqc3hph8UKV3IJlRHztpEDYhJJ0Ax4cjdAudsDQ234kwZRXCUHK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXyjx9sB6BRjhr
 M1fDevPVHuqr9ZcLoYpfmp456FKEVkGECFg+AZDShhdABCML6rsY7Ui/nF48Njty2Xgxv+Wxlgx
 7JAzIbDmNMd9EWFrVz8T8XSjuU4EE9r70Wj/U2kNqFNi5bYSr0cz4VbuOIsdatIg6VCFQHQ7TPQ
 8bm4Lo9EGh2YMKHSBvKDsKheo+uKEIPWMYIn+NP/yublCw80JlG/ilcmyO55l1VHzguJbJRnwDr
 eeEnh27DrO+2pDYb7OTacXCv9yH4ies+6H3fSnI+uZkqtWwr961LgKNrP1JEGal3ZKlk5doM5Ho
 +GWR1zdQu9U+VTwirEeZPpniXoCnwj/FRLvy39gQCdjZRfFpd7H9eV6rpzrVKRugRdB7kDrBWoM
 /tfWRM7XxdQtq3tQKm306JlX8SwmHiRufZ1d90+IXx+QIMyg1AO2yDL/MGnvn7TtxJ3C8QESWvp
 L/DgutUvsqVN3X1yB2A==
X-Proofpoint-GUID: VzNseC6UWavzr0d00gpmwRljlzLr3rnb
X-Authority-Analysis: v=2.4 cv=UOPt2ify c=1 sm=1 tr=0 ts=6a6a159e cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=2KvRFfd_T_-xjmS8C1aD:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pl6vuDidAAAA:8
 a=FNDBzpQLrQZLHPu8S4MA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: VzNseC6UWavzr0d00gpmwRljlzLr3rnb
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290121

,

On Wed, Jul 29, 2026 at 10:40=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 28 Jul 2026 20:59:56 -0400
> Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
>
> > This fixes a long-standing issue: kernel.ftrace_enabled=3D0 silently
> > disables BPF trampolines (fentry/fexit) and ftrace-based
> > kprobes/kretprobes. The write succeeds, the hook stops firing with no
> > error, and re-enabling silently restores it. Livepatch already solved
> > this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> > ftrace while a permanent ops is registered and refuses to register
> > one while ftrace is disabled[1].
>
> The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
> back when ftrace was first added to the kernel. It's addition was namely
> there because live runtime modification of kernel code was new and we wer=
e
> worried about how stable it could be.
>
> Honestly, I would love to get rid of it as today ftrace has proven to be
> rather stable. But as it is a user space ABI, I'm not sure what will brea=
k
> if we do. I wonder if we just make it a nop, and print a message to dmesg
> saying:
>
>   "ftrace_enabled no longer does anything. Please report if you need it t=
o."
>
> ?

Thanks Steven, if you and/or other community members would approve such
approach I would happily do this instead for a few reasons -

1) Seems like the more correct course of action if idneed this switch
effectively became obsolete in usage instead of piling extra logic to work
around it.

2) As I mentioned in the end of the cover letter, I believe for some cases
such as fsessions/ksessions and multi opts retprobes, this patchset is
not effective and the issue will persist, requiring a more complicated solu=
tion
for them anyway if we want watertight resilience.

If you approve this - I can try what you suggested, this would include
making the
knob a NOP with a message, dropping the FTRACE_OPS_FL_PERMANENT
flag and reverting/cleaning what's possible from the original livepatch pat=
chset
that dealt with this issue [1]

One question is what the correct set of tests to run in such a case
would be to verify
we didn't break anything. For this patchset I ran BPF and livepatch
selftest suites, but
I wonder what else would need to be run.

CC Miroslav for Livepatch.

Thanks,
Andrey

[1] - https://lore.kernel.org/all/20191016113316.13415-1-mbenes@suse.cz/T/#=
u

>
> >
> > For trampolines this restores a historical property: from 2019-2022
> > they shared one global direct_ops, marked permanent the same
> > way[2].It was later lost as a side effect of the 2022
> > per-trampoline-ops split (patch 1's Fixes tag) and never
> > restored.[3][4] Kprobes never carried this protection at all, so
> > for them that is long-standing issue rather than a regression.
> >
> > Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
> > a selftest covering both directions for all four hook types.
> >
> > P.S
> > I initially implemented a per-record opt-in flag[5], but dropped it
> > as over-engineering once I saw the original blanket restriction.
> >
> > P.P.S
> > Open question: kprobe.multi/kretprobe.multi/kprobe.session
> > (fprobe-backed) aren't covered -- return-capturing fprobes share the
> > function-graph tracer's subops manager with unrelated tracers, so
> > marking it permanent needs a different, per-record approach. Perhaps
> > something along the lines of [5].
>
> Honestly, I would like to start deprecating that kill switch.
>
> For the series:
>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve
