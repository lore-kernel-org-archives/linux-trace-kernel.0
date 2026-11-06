Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928167;
	b=QCdC4yI11CTWn2jt2jYsijDbWlW+1WmvjJliRDufph95y5G3TSAayK6wvr+He6+DfXg9
	 n7NltxrXVBW9UN1hk0o3l+HYICB/pw4LmLGdup26ox9DdtlejEBfIBnzKSyAw36Deq2Wz
	 CPrjfGeftsNLN60WSV1nOZ901I+7/Mm+oiLjOFjab3s14Jmn1oi4Hj86xb7lmODNcsn2k
	 BhKASKWHai0yxrrEyYiISdAdUGZsnO0VPttpE5ZA84WU7kPYreHaLUD4BOI4ki/5QG0XD
	 XkV7DZrAqy3UDKaJ1LOWyh3+OTicDcewdgo/gudIGHOJXjnpdGvoGRBy1qiPkSyw1Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
	b=bQTAcC0iFVVdf70R0u1DgRH3K349iGqHGdslYn7+QGvGsd4pXLg9R+vNZtRp/4FxOQ+/
	 7Jf2rJDekpXcGrIOMFy9d5trYPh3VvX3nPDrJYqSKOTDafeQH1eHdeKunBxdOQ6zo/kcz
	 mKhSclUZdsppGZuP6e+gam6uKgxk++/ZcUSIbLtDIaUqBaXzpt+Y95peajEdmhW4VvrK4
	 RyyW3oVEHbjaHepQ357lThs2EntATceJBmlDckFBYAAzivW0aBUMZnfin5jsqq/h8pW01
	 oathsjzf+aMRLSvlR/zscFE3L8eUzAqXl4dkkE94BeZ2S6SmTb8tJEyClqWqLODIIHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FF606A330
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 01:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 508FF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=BXgsLCA5
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a06210b29fso39900b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 17:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793928166; cv=none;
        d=google.com; s=arc-20260327;
        b=fWBqmi5FJVxdKq7PWB70wdX/67Swve1zVs2dBwi5KxCg+/Xh/p8dsZiaQToYFEt44G
         IR1Qk3+1BX+44Yrvh35wQ0BVnd+6rcIF0WHU2a5EsprelKZmxILhSh86W4AxJpOvf14b
         Wsuh1rrFa0CkmNUKV/nMeCyQwkQzFHkwSEJgN+A+7eTePFrzqQDVi8Eqhh4FeV4AKpAD
         JHFS9ZuP4aX4p4n9yZAfJIlc6CiBO+GBg87ZxDAH3GxWpjeVuKogaEdL4LuAvQ9vEpuV
         ZMXnaeurDN8yJEeW3K2n1Ib6b7+Gf21ofi0akGxj/13ueGJhW+ncJokzcKSyYiWcgnIx
         AyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        fh=VI8v9Ce9QuHCcklx8XfVKBOViumn5otN7dkD8PAXweU=;
        b=fupXs1E4JOb5QwhU6XLjvWn4yMFZ/fH9c28Ozvpup1otvd+jg7sPlm6MO0CLcqCF6V
         cLPecqfC9eexBJvh0DY7tbqIWxeFZPtOYJ/wuP/d2ZYXI7E8Ntbthb0/1SNn9URATFaq
         lBhegNmsHd3RSUgDzduxjdewxf19mXsV7gzpXUjp6oBj/Oq3r/0XrSwOEuv7JCKsxFQ5
         o49M2EqASnepS3rxiprPQ7Zb8fooXBbBfbP+dqRQT0RzD1FaLDAdE7du5peMiA3sF9bt
         T/SyOWjrOMktaJaFWr0eLW2xDF3jXgwsMZmIBE2NAcUJ+cqrSmWyxwK8VPyokodxwHuG
         Oa3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793928166; x=1794532966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=BXgsLCA51X5/W48GvZrpBezpY+stGa03fvEbUi2MV56MnNmF4a2PjDTUVnBg0Dwtqe
         Pc0pFbbkVSP0pF2lMOwQEWZuhIoVpWFLaZww3T/CDXUanEMozEFBbg5xukYGZHM3dK7Z
         /fQ7M+BmNkKN//ilq5bRiwTE5y+M3XE5NT96+Mb4FuQk23KwrKKCtl+UAKDpUXGzEGJV
         USSryhSewq0S2ePnFYtulTY16RPJSyBaU+5La6UtGtX/D/3Czi9oUOP9+hhoTJe/0ETl
         gYSYGkR59nTYA3bP+5Nf3SMG0P++deg+hHNjH+z7C7raNaTFT7WIIduRah7XGk96iqIB
         wcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928166; x=1794532966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLgPV68l9ICjIDifE65oCN1RGzBXPv/N3KtgmZVNysE=;
        b=K6kCW1q0qi/hvnQjJBl8fX87XMQeW2GH12EfI5JtiCM6Jevi9SyUcBZn6qZXU+B+cL
         5q8GQGBl5xYP+JbtqqkBc+gMh206VJhh9d0QRUGxOnHB+DD8wV2xzyO6pqlcCn4RxaJd
         OXMHf56/3JgGLuXphC1xthShUqWOlK9bgU+2/GjZII57cSgd0eHfwuaJdSmDHYLJlZZv
         P/qLTIVnUEoJUW8GDTL129OfecJnoYtl0Q6AoY/hs4RbKqKSNasW45svQiuPKiOMo7Dc
         Ha88pvIFh6qp/uQhZbEdd1COV5IrzRBKFrQpwvuRHM5j2/Hb4cjzL0MkEiAt5rnfhMH7
         3tvw==
X-Forwarded-Encrypted: i=1; AKwUvBwKnNtmdP/dkxHaBNB+DXUJXrj3T8gwwEZtZMlz/RWgX4rTz8lftVpO21TlhVhxli0Bx5fGagchjv2R5O7dsgvrLi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BClrkc4kQ1vxHjNWEaON0q7MrLSzZbv3zxZtdVzCuWHc+3lWv
	XtYAfhzbo4XvmIKDd1jy2T4qbnqoQ0ZXH1l2exNWVWtTpqEC/ndyPKBRNjZGDmRf2VDxYi1dDLK
	wq+O0qSSvAbilK7SouRs2j903lYWdvdQeB5v4QUxh
X-Gm-Gg: AYBFou14Ip/HCfREl2mI0gx0aQXCeFktpkAiRb1ALIXOHWOcMY+EthHuRKiDF+qilqq
	AwAbvbncmNbUtnwwgSdkTmnz0Ywrr+byDjRBzOGsgEeSaWlmK2z9yY7DS94+CJxssZtyq+M224X
	9URMbBbA3Q0e4PHi15JuFNRSLNSY1j1ICU+4eQwD1OJbfHeCseS7D32R5OHNSU6/5YPookluueA
	FJI96kbfUd+fxIh05he02M3K+FomYG7JMklPFpCoqhwryRA8bRf7VA0P++NMUDWUFIU3dDs6UvX
	uGcBGAUUL9Er369FZqzFSqGfFhtPwfQUw6BIF33oqaxARTkysEUwuM3JlI2gP5PVp6sCeBVjI5e
	FReleb3PcgKBFVPtNkn4KmmmrJKD0xCrYDwvBFDB/S+YB/AqE6l4AHkJn+WMTWNi0IlxE
X-Received: by 2002:a05:6a00:4f82:b0:87d:e8a0:2389 with SMTP id
 d2e1a72fcca58-8b37b37d233mr903874b3a.21.1793928166471; Thu, 05 Nov 2026
 17:22:46 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org> <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 20:22:34 -0500
X-Gm-Features: AclHuK_C6UmASiuiBuBvumlcrlzJEUCTa0-vZyEfxhlZIjAFaCskKj-ONE1360g
Message-ID: <CAHC9VhRDVz4M-m_4UZZDKMgs4uc+j-+-jwYEdBDfSD0rtd-1Og@mail.gmail.com>
Subject: Re: [PATCH 13/13] security: convert VMA flag tests to use vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
> >
> > Replace use of the legacy vm_flags_t flags with vma_flags_t values in t=
he
> > mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  security/apparmor/lsm.c           |  2 +-
> >  security/integrity/ima/ima_main.c |  2 +-
> >  security/ipe/hooks.c              |  2 +-
> >  security/selinux/hooks.c          | 14 +++++++-------
> >  4 files changed, 10 insertions(+), 10 deletions(-)
>
> Similar to the other patchset you just posted, is there any reason why
> individual subsystem maintainers can't pick these patches up, or is
> there some reason I'm missing and they need to go through a single
> tree?
>
> If they can go through multiple trees, can you split this patch up?
> AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
> different groups/people.

Since there seems to be a desire to bypass normal procedure in favor
of speed (surely that will never backfire), the SELinux changes look
fine to me, but please do wait to hear from the AppArmor, IMA, and IPE
maintainers before merging this patch.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
