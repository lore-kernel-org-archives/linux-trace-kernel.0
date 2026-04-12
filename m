Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C72BD11
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001870; cv=pass; b=TAGPX0EizenWO+RTjN1yfRcJOnNYDAx9sZr0RNeeTHIebDWZSMIUVJXil59XEnG0TN3te+FfCK2cXcW+/Ik1fHMjmB21RPbq+KR9WEf8fkp9iwXmEndyIZQuNBLxxjhulOciFCTX1oANdkcuex+cf1RTo4gtuAYa/FGvEWeF3OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001870; c=relaxed/simple;
	bh=Vm+QvtQZE23sVbgK/tEkRjhUlOBlrvQ/gGRliE28Mbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUD25kZBCByQDsDkiQRZ1HloTDE8m23RkQMbSDTT/rwrx+v97+gw3ldGGmI8YuW0Ua3fj+Ao1mWncIDHMHz2zbGWD+baZbqAWUBIuTeFYAd95t/R3vijZx0Ny9pa+lAlKQmPGt5dawQEeB6vC4WmXz/9HQGcfcBB5ZogWn3Id48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9EpLx+G; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9EpLx+G"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65075c2ba66so4257282d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Apr 2026 06:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776001868; cv=none;
        d=google.com; s=arc-20240605;
        b=PNUDr1DgYEpFtSZoIQp65WF+Y8za61UfsioNHKRXnXxtAkVm4AiaOWwflHgFK/WY+L
         7txsgDq4Zlr43PxSquAglDraacz+/YDNk9nQbxTnOwKz64C1SBRs8cjOjeEXgW6j2ln6
         aWumDKrAUgz7JLTW51RlvqaWwhJ3UWPUf4QE6OUDI6JAOmfem7+D7/+jcR40r7qKK6Dn
         Q+2Y0iC71IjfHPJ+ETaunusfLkCyLhzGd0qtua1EAKzIyPQylFnH6yPQVYb5MygTWTjx
         Q7zkMnDbR+rQ2PvJHPSbhVPV9fPKn1HkPsfKPw3ECjBZeNhaLCmw9KqPoUPFmuzfS8hm
         qFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        fh=ZBcIyWMoeSQHmfF3eX2HcDHO4lDemYS1rV1VBc/UGRw=;
        b=PpEsqLAqn8KmLCcXbSfVbAW3LXqMM3+kLcV3QYmJhTb9OR+zmzlFl+bCa2DmbAjzdG
         9kWh79T5A1cAf/oU+cE+/YtUSjZUhKl++JunBWowUvUb94eiklnf+V7KuD76hIYIosbF
         o4RAMLz/E+GtDWdqpR5gGEtBylJrBuLT7pXJShHv8GimiuMC4Alcq+P65h/YVDg0F4Lx
         ElySU4MplxabSlHtMw0vPdiN6l+HRgholSYOS2xoEuiJEKFq3ild9wtgtkBYLEps4SRc
         muWdPQA2Kie2pvQ014B8umRbSTslQRyQd1u9JPyNK04dttI6C6L4ZQFtNZ7JkXyXIXhH
         ZnyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776001868; x=1776606668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        b=C9EpLx+G3IANRDKis1pKPomgySzvwrG/DTrjgtOykO1b4WyF3+cMHefL7ElWXKi1FU
         CeYm5P+RLOwAP1N249Neu8WTFkgGtw5FjimXN1muGdRIrzADFh+Uq3Go1DbLWIXT7RjX
         V07TzjpDIxbj7Oc/EFLBW0w7CQ4HHrvyUJ7wHNLEwrDPgS1Yw9gOm8oDkmsOnVwJYd3u
         To0SeMQSipn0oCThDiy4jRix087DHW9zam1PJ/H8bxZ77aBwnIj0uKulpEq4DjCtYRbg
         u6OhiOFwAcxkzhM2L+cbQcodjM+mQfGnKAzlqKb42c8jnt1MikHeiFpTgFWx37F2Doem
         QqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776001868; x=1776606668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdsrFw8g8Bu97byW04CT8KXQ2lpv8OYnpWUOna6h/+A=;
        b=kSmggk6im95JbVRzSRZYRc2CkYCs/DC2gGNM094wNF2AlMd49pJaCy6VJB8HOU/8FY
         REnlLcsoxwBOpT4JifCkuLiItcdrRS8+ANfNI0137MP1HAgMqS5BcLgy+FiPe6SaDKYg
         5ETlm++BoO3HaWU0JTQRy8A/Eix66OnPDLPq+N59B0mqPSGGPZfNnymNG1knFo5NxnXi
         CrZfPQZGMti+nj7Cfj4uot4YIms6zMz/24+fTg0zcYCkrlh6LdlpS9GGWIYkzxek4WQt
         7b+GJghmviYGhfw1UwgsYTu757PqE9Wdi82gTgNfPxcCcGn5v19j6aTkdOW9PRt7N3IP
         Bgcg==
X-Forwarded-Encrypted: i=1; AFNElJ9YFPBQ3Ayut03icBnGrBQTocRPET57bIlIdPmyzsO2sFaqX+yCPpajGkGwFE45nz4pCQHjgNehr7ZuIw+DbWEYFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTNBv0tJtKxVYu8GdNcmkHi4NkwprAz/cxpOl3Wklw05PZ7h8
	mSPdJ2y9pljs/S4WKZ63QJJ9ASNMXo3HARIsnyWafZjGGBJj30G+TYeJYM6EJFX1DIYVCs5MXun
	4clDwvUNJTs2Rl7nqmqQwo8X/ZMz11G8=
X-Gm-Gg: AeBDievbB4NxYojvRwtfDwoLqakPj+AmDOuDdRdYmFi0DprG/TlYNv/dPrrXSjE6wfd
	o0YtKXlVdpSpOWcDZZZHWgVSWFv+qH1G2JcZrjiqNLBeJIUBEB5f6lSKtVVntmSDNB1WhLj5Euu
	FT6bjRwpK+pYP6LDYtXoBoRK/TgwJWNr6zfuPGdE6LfqgfyaoD+lFFfTuuF8ozPhqYLWZhOI9r9
	z7GuxPST499jCIbn04MlDHhgymmSR7iotdzvvU3VID1nvBZNmbYXTnqGqns6002YVNc95twFcQZ
	X5rQFvOz/ZvuX2UYC/tORWXxTACLNhjlwVDq6Ku0
X-Received: by 2002:a53:d246:0:b0:650:77f5:1410 with SMTP id
 956f58d0204a3-65198b47128mr6848061d50.33.1776001868315; Sun, 12 Apr 2026
 06:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <20260410133844.56ab7964da7628d1c3482acb@kernel.org>
In-Reply-To: <20260410133844.56ab7964da7628d1c3482acb@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 21:50:31 +0800
X-Gm-Features: AQROBzBaWJkKG21AiORGSzFrR-pHHuRCQzMa1l_wXUruYUno8uNhz0WAA12-V04
Message-ID: <CALOAHbAOx=C4b+4xQwRf59xvY0vbMPfOjO5LMDghC4Ryksv++Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, song@kernel.org, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:38=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:
>
> Hi Yafang,
>
> On Thu,  2 Apr 2026 17:26:03 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads. However, static livepatches =
lack
> > the flexibility required to tune features based on task-specific attrib=
utes,
> > such as cgroup membership, which is critical in multi-tenant k8s
> > environments. Furthermore, hardcoding logic into a livepatch prevents
> > dynamic adjustments based on the runtime environment.
> >
> > To address this, we propose a hybrid approach using BPF. Our production=
 use
> > case involves:
> >
> > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> >
> > 2. Utilizing bpf_override_return() to dynamically modify the return val=
ue
> >    of that hook based on the current task's context.
>
> First of all, I don't like this approach to test a new feature in the
> kernel, because it sounds like allowing multiple different generations
> of implementations to coexist simultaneously. The standard kernel code
> is not designed to withstand such implementations.

However, this approach is invaluable for rapidly deploying new kernel
features to production servers without downtime. Upgrading kernels
across a large fleet remains a significant challenge.

>
> For example, if you implement a well-designed framework in a specific
> subsystem, like Schedext, which allows multiple implementations extended
> with BPF to coexist, there's no problem (at least it's debatable).
>
> But if it is for any function, it is dangerous feature. Bugs that occur
> in kernels that use this functionality cannot be addressed here. They
> need to be treated the same way as out-of-tree drivers or forked kernels.
> I mean, add a tainted flag for this feature. And we don't care of it.

Agreed. This should be handled as an OOT module rather than part of
the core kernel.

>
> >
> > A significant challenge arises when atomic-replace is enabled. In this
> > mode, deploying a new livepatch changes the target function's address,
> > forcing a re-attachment of the BPF program. This re-attachment latency =
is
> > unacceptable in critical paths, such as those handling networking polic=
ies.
> >
> > To solve this, we introduce a hybrid livepatch mode that allows specifi=
c
> > patches to remain non-replaceable, ensuring the function address remain=
s
> > stable and the BPF program stays attached.
>
> Can you share your actual problem to be solved?

Here is an example we recently deployed on our production servers:

  https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqge=
o4C0iA@mail.gmail.com/

In one of our specific clusters, we needed to send BGP traffic out
through specific NICs based on the destination IP. To achieve this
without interrupting service, we live-patched
bond_xmit_3ad_xor_slave_get(), added a new hook called
bond_get_slave_hook(), and then ran a BPF program attached to that
hook to select the outgoing NIC from the SKB. This allowed us to
rapidly deploy the feature with zero downtime.

[...]

--=20
Regards
Yafang
