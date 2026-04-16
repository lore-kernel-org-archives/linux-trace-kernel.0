Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694637F8B3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335408; cv=pass; b=frVbBtuzfa66Wnse3PGbTB7jErwW9u2ojSz2ZPVhCLcAD9gGjTniXgL8H7UtudksbYuMIAvuOBoGIBfyA3meU69bKUeZ8kNuzmUGhEoETL6cVEiQp9a3VsuG26cwD02zQhU1it1oBeDG/sUdYjuBNuK7ulo3NuuuRf+w4DQh5uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335408; c=relaxed/simple;
	bh=waJiDzOo49cMRleBM9fFS7wM9KT+ZlkCB7xqbkKrq9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF/Vz7LZlR/LKxrWoZ8jZTkHmCSTgVOUX1jH9WF9DXnQUlNhECNSJ0GjEil5IQdiJgR3KPh4G5WRUwv0WbYOAnlYyAClEpQ9l0wkhc/3obZH1LKeFw2ZPK6/XWNIYt/MIkMHTmBquiAQ1AwCqJ4QF431+zCbvuo2VmBj+Yr9sWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4q8woPu; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4q8woPu"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so1068023a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 03:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776335404; cv=none;
        d=google.com; s=arc-20240605;
        b=l12oT3uhuUGES/Z/w/4tXFOOrPsPn/0xB6e9n1v1ylTrhPKL2NXbgRUpn+a+nEpCxM
         3aRXPchI11Xqfps9/ecnEEZpIw1IWzoXT01oKdTEx6PstR0aLID/0kH1l2SyVAYDPnsT
         wyO+AqB1PibLDTyoiqhN9zhRkT8ZT0VtP9eeR8siArz90L1r6UzoHApOP4dKZ/Sza5Q8
         OfH2QgUwltxZsb06dlj94e7QN4VJ0RWIOyWFw2GBc/juUk4qk7CjiOFOKlivOYZ+a9N2
         ppA2KtA5X1hehHV+BnhxTA5sKP/SXbULWkXy/4/lKK0nB9mP+tyAFloMkkG8h5JBzley
         PEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O4x/p20rCdbt363tjV0+ABHeJuaMLyMj2lG+gRWDekg=;
        fh=bVLpw8AB9Uw4NPhxDHyLXaG8R4VjTdZEQ+Mdm/EtZJg=;
        b=i0wrh3NCnQhVe+Geq4GmG8qip1XSRiC8L/lYMLO9Gc7eD9rTZEpw0ZrAVWDeXj6R/e
         sDlQMPIFBqyLKgmQ9EScQPLRBY6TjEFTrbzCPHg6knAI/dLQJwsgtSV1w5SAtMxK/Rey
         BisonFbbntbUo6lPRJmFsdrMHUctmKCpWOkdRcUaF2XcILMK2K6Ur8ymRpqC6FJqWYyi
         El3llGdSQzlweprb/LFo5VHKo4muFN5YF5a8pdW3o6BhYCDZK52nFzyvVbaPUUI3I+JI
         fX6E+H1gEMkUJft9EXBNOBf63bI81C/7bLteLQMElZVjnkM37jZ0bnJO7BUyRQ1fqX2u
         VcXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776335404; x=1776940204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4x/p20rCdbt363tjV0+ABHeJuaMLyMj2lG+gRWDekg=;
        b=H4q8woPuewhmnSwupiWyXSO0br9VwrNdTqx3AAh0ZdoHsn8P/BS3W229QhJTRcQenA
         +Y2Se9s2vPVFdlsVmVqd3G7OMhH5sWT9y/KQCXJUIPXiIj6tBp0FclX+43XoNBm4Q00J
         HLKZxkcODRGNbGQZH+p9TjyrhfFWO1VenoSfyNuiUD7XwkrsNGMKjxhHmmojJoWTPZ+f
         XAx6l/cdSeqXldmngMI7ZdM3/7aUgiPqM1XYoNaWgYjROSQFpApE8By4FC0FnYt02omZ
         orazUsYImFAG/GLW27GIwCI/pd/MuDH9xavNw85VG3mt1LN4tItpAUD5qfUd2Ialatuu
         tQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335404; x=1776940204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4x/p20rCdbt363tjV0+ABHeJuaMLyMj2lG+gRWDekg=;
        b=Wb3FVs/CVs/y8Fl/8z/MkcOnIgv/+6LEXqTBuPqj3wKKPJtIUcSWLnzgerXb4jtUeH
         7PIFV52A4a2ONDdQVcxSBUNkFeya59M+D+8ln3Srj28njJsmo1j78qifYtgwChRZlfWT
         5A7xGPSXXq/Y5KvfKKF4x2YFHNgy8+YkwX3niNTHWchZpJRMHJ0p3z8QZGi+eCjtB5Mi
         tezodlCvuBBn9UN/j/nVVhvQs4RTnlzJ6o/J1ETbrs5++aws+drrdviPJcXbJEiyzO4B
         tAFS7lvIBMDzE0a3uMGLyCgHSpnGGBeK8sNuiqKPQ8r44wta032N8CLK03ZS006EKHB4
         Geng==
X-Forwarded-Encrypted: i=1; AFNElJ/WNGmbFLh2rBOltxtjbADSa5NNFmUiDl69Kstm/ujAKai8iah1hgEycmi6gzkIXmhQpVKh/4UB0RR7ksuCf3TCJHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKk3bFKrxJ+JYqU/LHWM4/E0F9Q21+SpVIoPI9dOeh2+X3/65
	l8BGk8b7SsAvbui6elVH3aP1cOyHxy/Tr4qtpRqfStmVXa41gIx+lQKoHLbCPioszmD8G8icrC3
	3imchaSEk3XTgznC1ltVyJOOOdlRYgAw=
X-Gm-Gg: AeBDievZOUY9m254Udn+DLoxPxC6BG5HTz+vSbJ6hPL0IgKxDDamVWqUWH1dMPrxrkl
	W4qXzPKp4feRhba/AASaK5ANSe0JOOIi3yi3yqZc6Hv8PvwEgon830EhWvJsU50gZl/JUe15KV/
	ssbGG0xMDF0yn6vUre2Fvm75y0k9JGjx/4p6oya3/yF2q15+9BiGNJqDf88FJekpv+rngbg0laG
	Uug199Cu2VmMpsEAxCdnFaqo/TSztxFXNJURg2ZTWKqXHad3m/V9+m8Hvt6sNdWRKHna4PYi+Oe
	hhackGzJim+rEcSWfpshRZEO3GQxvzEIPtTW90B7PrVkygshhQ==
X-Received: by 2002:a05:6402:1bd0:b0:66e:103b:6350 with SMTP id
 4fb4d7f45d1cf-67271085617mr945994a12.7.1776335403710; Thu, 16 Apr 2026
 03:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413062042.804-1-huangsj@hygon.cn> <76pfiwabdgsej6q2yxfh3efuqvsyg7mt7rvl5itzzjyhdrto5r@53viaxsackzv>
 <ad4EvoDcAKE2Sl4+@hsj-2U-Workstation>
In-Reply-To: <ad4EvoDcAKE2Sl4+@hsj-2U-Workstation>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 16 Apr 2026 12:29:50 +0200
X-Gm-Features: AQROBzC-j8c2wDPnYX4NqzriRAjav7sQoMIZaVyLzvRZ8lq-CJThcPkUuW_xSxI
Message-ID: <CAGudoHGLaoc+CoBPNCvFRYojnj+6E_Lsdv7NaJWxFMoHezemMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: split the file's i_mmap tree for NUMA
To: Huang Shijie <huangsj@hygon.cn>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	muchun.song@linux.dev, osalvador@suse.de, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-parisc@vger.kernel.org, 
	nvdimm@lists.linux.dev, zhongyuan@hygon.cn, fangbaoshun@hygon.cn, 
	yingzhiwei@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:11=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wr=
ote:
>
> On Mon, Apr 13, 2026 at 05:33:21PM +0200, Mateusz Guzik wrote:
> > On Mon, Apr 13, 2026 at 02:20:39PM +0800, Huang Shijie wrote:
> > >   In NUMA, there are maybe many NUMA nodes and many CPUs.
> > > For example, a Hygon's server has 12 NUMA nodes, and 384 CPUs.
> > > In the UnixBench tests, there is a test "execl" which tests
> > > the execve system call.
> > >
> > >   When we test our server with "./Run -c 384 execl",
> > > the test result is not good enough. The i_mmap locks contended heavil=
y on
> > > "libc.so" and "ld.so". For example, the i_mmap tree for "libc.so" can=
 have
> > > over 6000 VMAs, all the VMAs can be in different NUMA mode.
> > > The insert/remove operations do not run quickly enough.
> > >
> > > patch 1 & patch 2 are try to hide the direct access of i_mmap.
> > > patch 3 splits the i_mmap into sibling trees, and we can get better
> > > performance with this patch set:
> > >     we can get 77% performance improvement(10 times average)
> > >
> >
> > To my reading you kept the lock as-is and only distributed the protecte=
d
> > state.
> >
> > While I don't doubt the improvement, I'm confident should you take a
> > look at the profile you are going to find this still does not scale wit=
h
> > rwsem being one of the problems (there are other global locks, some of
> > which have experimental patches for).
> IMHO, when the number of VMAs in the i_mmap is very large, only optimise =
the rwsem
> lock does not help too much for our NUMA case.
>
> In our NUMA server, the remote access could be the major issue.
>

I'm confused how this is not supposed to help. You moved your data to
be stored per-domain. With my proposal the lock itself will also get
that treatment.

Modulo the issue of what to do with code wanting to iterate the entire
thing, this is blatantly faster.

>
> >
> > Apart from that this does nothing to help high core systems which are
> > all one node, which imo puts another question mark on this specific
> > proposal.
> Yes, this patch set only focus on the NUMA case.
> The one-node case should use the original i_mmap.
>
> Maybe I can add a new config, CONFIG_SPILT_I_MMAP. The config is disabled
> by default, and enabled when the NUMA node is not one.
>
> >
> > Of course one may question whether a RB tree is the right choice here,
> > it may be the lock-protected cost can go way down with merely a better
> > data structure.
> >
> > Regardless of that, for actual scalability, there will be no way around
> > decentralazing locking around this and partitioning per some core count
> > (not just by numa awareness).
> >
> > Decentralizing locking is definitely possible, but I have not looked
> > into specifics of how problematic it is. Best case scenario it will
> > merely with separate locks. Worst case scenario something needs a fully
> > stabilized state for traversal, in that case another rw lock can be
> Yes.
>
> The traversal may need to hold many locks.
>

The very paragraph you partially quoted answers what to do in that
case: wrap everything with a new rwsem taken for reading when
adding/removing entries and taken for writing when iterating the
entire thing. Then the iteration sticks to one lock.

The new rw lock puts an upper ceiling on scalability of the thing, but
it is way higher than the current state.

Given the extra overhead associated with it one could consider
sticking to one centralized state by default and switching to
distributed state if there is enough contention.

> > slapped around this, creating locking order read lock -> per-subset
> > write lock -- this will suffer scalability due to the read locking, but
> > it will still scale drastically better as apart from that there will be
> > no serialization. In this setting the problematic consumer will write
> > lock the new thing to stabilize the state.
> >
> > So my non-maintainer opinion is that the patchset is not worth it as it
> > fails to address anything for significantly more common and already
> > affected setups.
> This patch set is to reduce the remote access latency for insert/remove V=
MA
> in NUMA.
>

And I am saying the mmap semaphore is a significant problem already on
high-core no-numa setups. Addressing scalability in that case would
sort out the problem in your setup and to a significantly higher
extent.

> >
> > Have you looked into splitting the lock?
> >
> I ever tried.
>
> But there are two disadvantages:
>   1.) The traversal may need to hold many locks which makes the
>       code very horrible.
>

I already above this is avoidable.

>   2.) Even we split the locks. Each lock protects a tree, when the tree b=
ecomes
>       big enough, the VMA insert/remove will also become slow in NUMA.
>       The reason is that the tree has VMAs in different NUMA nodes.
>

This is orthogonal to my proposal. In fact, if one is to pretend this
is never a factor with your patch, I would like to point out it will
remain not a factor if the per-numa struct gets its own lock.
