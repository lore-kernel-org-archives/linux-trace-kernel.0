Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BB37267C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531671; cv=pass; b=tvkuUh7GiB5LM6hkJ8kmb7JCvzISXOwabGM8E//5uBVjsINNkFwpCWqhDs9sixJlLIPP7r3enyDGmghdrHUIQpaUjevU621JOi2plOwx//T0D0wHOt05A0zkND45MKhfsTJlne4ARcCLmOQnw4ab7TPfBSTxQisJWcMxxcq1AGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531671; c=relaxed/simple;
	bh=squ6n2HGdHi3UxLO+I4JuWRPtoqYf/aQUuDGYO1d7Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdpMk4JqFv+oJHC+oAdL9Yl6Y/a0JNBaA2d+tC/fBsevfbJ/i0rtl2y3JIe8VjGjTfIX2usevgOZfeiqXxJhV+W6KboYsKrUf2nzdoFv8Wch1vLnn+sC7byyJHvP6Ifw4U91SahYm8GPQn1KpP4ud9AuGa55+slMJNYzuhwenyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahofZkd/; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahofZkd/"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6507a9303fbso406405d50.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 20:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531669; cv=none;
        d=google.com; s=arc-20240605;
        b=JLl4FFi36dGbiJw5+kn2H1ddgt89xtqzfY/fkV4MGuoWknq8SHzYcq2HFCoRRu5KGZ
         nFJIRvY9N8/hgzotbP2hTLzcMWwzDY723CyrFJEpS6LKB9/o72zSJG/tWiwY43L2P5hH
         304HudRwyk7XD5sEN6mXtAxVcl5hYdXp1e5qf/0z3N9qtojJThp1BlqmLj8z2LFiF7WK
         eOmH0ZOVWqsruRxrUK5nvJ1kVbevSlRAPn5wNdKDF+blBAIBbUaB2zn4JmTNloh5urET
         BmDIi4Uz0ebyvBV+U9+k62uSUy9Daw1s2Y2FvS0UO1/cOinfC9IwVD8eI5z5IYhXUnMz
         iqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        fh=KINmeNlSC0yEo9kSJDQdzQHXPj1pnuEWgwg4lclR0cs=;
        b=WGq3LyqeqItW5MPj/Um5OmFGm45hPtjT8f8wZNBEOLnXKk5VayAjCoTkHNeYUtyEHa
         BfRTV5DRkfFNX0RBPosaf83LjVdc7hC9Mn6ao7gC6u7sdp/rxb+s532hQ+Hpk/0dJn3M
         I+lSaA9OyyAffzmi4myjbfm4+ZiMMs2iX2TctIAARU4mR78srldumX9l8cdvGwUgVTVm
         yi18ERKv65LX2ILcQ9WExWPnpVNVNkbLCNRwLD7pg1naFerPXoeSKNxTY2BghIge/dNQ
         tS24jn5O9hhgLzrZFaB+pzG3zYt+3Xe+M06ytU+1de0SYz+cLh6tXDpw6ItY8wczWYCC
         quXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775531669; x=1776136469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        b=ahofZkd/LDlzScpDFA08CbGu322YcV4lsdhPZDiDybFzOFhhNMo91dxCK37eMiltP6
         piG9ccJBTZzI9Z/BFScbfzMqc+xrZPrjgPZU1WBhVsJuhi6LAMexV8yl5LrnTe0c9Dxb
         Ys/7q0YZL+Coc3YuQUyijjudvKeiRt8F/aGq5F0ybfwNVSlyRLzxyPJNYHTr8zVkCWWB
         7ruYtyD2gMzC55+bnislk1Iye22fSsO9r2fnoT4j/fX4wZkTwSGb2cIwL/ZYFcgKgZfR
         b+aP2My5fP72z7x0UvXM6thljPQ9IB6X619zMo7zgTyo8oe1bofWQ041jthxJzV3k1HL
         dBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531669; x=1776136469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        b=LcaElnPaZMHRdpfNWZG55zGgBi8b/jfBozYR9zPXVZgSRHoEQ5jTag/GJ2T8sBNF1j
         9JA+HxjwnU7EV9Pug+KMlYPtpNaFraNyT4UduCHpTLJKZq2lloU7QyVkLHWCBYytYGs1
         ok25MgaW8nJkccfNwrQC72cZt7qZWK14N9JtITX7pXXdW97LDrrUFtMoRro09TBw69Uz
         0ZOdOlgelrDKKhgtD+xs1VodrXbfon98d6ICooHMYdaUKgcGHPGSYp6x+dybHCZ3nkGb
         of648vK8vFOwReNQcoq2RmNYzk2L6bVJlFfV56tHIAwbHP79risahE5hkm/CzSrpkZyw
         EfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT9UMbJzWhQaFDw1kDEilwDBE66WhRSbX2ILgupCJtQItAQsQXKv8a6e5WHq/ws58VWKXIYkrdKmwpuXQacQ2fv6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58B2h38eKEh/4G2MtBLt/ZMYGAYkVN9Y0O+OOTGQUqO9kul5v
	jggILBOTzOqIa5LkCGLA74FgDbPNZugXUsUmEWbHQQ++jzi/dc15Rqlcc/8JMF4ahQf/J8YFpY9
	loiXt9e7o1vZej9Cy3/HqvorSX2fGsQw=
X-Gm-Gg: AeBDiesNlHRjs0VPemdIIkFmeq9EqVcEtBms4yFkE/3vOfd0oMfhyyVyI3JWhXudhEf
	XKmnrMIGZNQYn2S2samWdwVNx1QigAuMMgi3Pjsir4Ty+GSOjPpZPjsyG2E8+8H5+ZDpLO+gzI3
	2SdMQPhYW33OzqKNVpFxCHhUw5T+DTEn2i3x6PbsplGY+Ap7VoeCVJDYk13TE/aB+0NToKinQKd
	zp5mfgoO9dCr21LgURi6u0WbPeIhuynox/WYswmi3lW8XqDOb1ZCHhaNzJl55QfMfgnLR+yxrgQ
	5fI7eLB7/PIo3oyGrMoXKSb170kz4641ysKhZsRv
X-Received: by 2002:a05:690e:304:b0:650:3bbc:57a7 with SMTP id
 956f58d0204a3-65048746577mr10316392d50.25.1775531668967; Mon, 06 Apr 2026
 20:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
 <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
 <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com> <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
In-Reply-To: <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Apr 2026 11:13:51 +0800
X-Gm-Features: AQROBzAwoTocrSdgLlq9jjuaEvd25BiOxk_ha4-MCiHen7ISJudiyPIWC0L9dTA
Message-ID: <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:47=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 6, 2026 at 7:22=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Tue, Apr 7, 2026 at 2:26=E2=80=AFAM Song Liu <song@kernel.org> wrote=
:
> > >
> > > On Mon, Apr 6, 2026 at 3:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > On Sat, Apr 4, 2026 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> =
wrote:
> > > > >
> > > > > Hi Yafang,
> > > > >
> > > > > On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > > >
> > > > > > Livepatching allows for rapid experimentation with new kernel f=
eatures
> > > > > > without interrupting production workloads. However, static live=
patches lack
> > > > > > the flexibility required to tune features based on task-specifi=
c attributes,
> > > > > > such as cgroup membership, which is critical in multi-tenant k8=
s
> > > > > > environments. Furthermore, hardcoding logic into a livepatch pr=
events
> > > > > > dynamic adjustments based on the runtime environment.
> > > > > >
> > > > > > To address this, we propose a hybrid approach using BPF. Our pr=
oduction use
> > > > > > case involves:
> > > > > >
> > > > > > 1. Deploying a Livepatch function to serve as a stable BPF hook=
.
> > > > > >
> > > > > > 2. Utilizing bpf_override_return() to dynamically modify the re=
turn value
> > > > > >    of that hook based on the current task's context.
> > > > >
> > > > > Could you please provide a specific use case that can benefit fro=
m this?
> > > > > AFAICT, livepatch is more flexible but risky (may cause crash); w=
hile
> > > > > BPF is safe, but less flexible. The combination you are proposing=
 seems
> > > > > to get the worse of the two sides. Maybe it can indeed get the be=
nefit of
> > > > > both sides in some cases, but I cannot think of such examples.
> > > > >
> > > >
> > > > Here is an example we recently deployed on our production servers:
> > > >
> > > >   https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy=
5hy9Yqgeo4C0iA@mail.gmail.com/
> > > >
> > > > In one of our specific clusters, we needed to send BGP traffic out
> > > > through specific NICs based on the destination IP. To achieve this
> > > > without interrupting service, we live-patched
> > > > bond_xmit_3ad_xor_slave_get(), added a new hook called
> > > > bond_get_slave_hook(), and then ran a BPF program attached to that
> > > > hook to select the outgoing NIC from the SKB. This allowed us to
> > > > rapidly deploy the feature with zero downtime.
> > >
> > > I guess the idea here is: keep the risk part simple, and implement
> > > it in module/livepatch, then use BPF for the flexible and programmabl=
e
> > > part safe.
> >
> > Right
> >
> > >
> > > Can we use struct_ops instead of bpf_override_return for this case?
> > > This should make the solution more flexible.
> >
> > Upstreaming struct_ops based BPF hooks is a challenging process, as
> > seen in these examples:
> >
> >   https://lwn.net/Articles/1054030/
> >   https://lwn.net/Articles/1043548/
> >
> > Even when successful, upstreaming can take a significant amount of
> > time=E2=80=94often longer than our production requirements allow. To br=
idge
> > this gap, we developed this livepatch+BPF solution. This allows us to
> > rapidly deploy new features without maintaining custom hooks in our
> > local kernel. Because these livepatch-based hooks are lightweight,
> > they minimize maintenance overhead and simplify kernel upgrades (e.g.,
> > from 6.1 to 6.18).
>
> I didn't mean upstream struct_ops.
>
> We can define the struct_ops in an OOT kernel module. Then we
> can attach BPF programs to the struct_ops. We may need
> livepatch to connect the new struct_ops to original kernel logic.
>
> I think kernel side of this solution is mostly available, but we may
> need some work on the toolchain side.
>
> Does this make sense?

Are there actual benefits to using struct_ops instead of
bpf_override_return? So far, I=E2=80=99ve only found it adds complexity
without much gain.
Can we add something like ALLOW_LIVEPATCH_ERROR_INJECTION() to allow
error injection on functions defined inside a livepatch?

--=20
Regards
Yafang
