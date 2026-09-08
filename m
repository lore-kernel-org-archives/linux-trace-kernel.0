Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195134887B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898982; cv=pass; b=TawIC1XZqsIgVmPhsLlxFJrAFneW2iVgPxGdklNjazA9AZFPO2F/IWSO594OFxxjWruuWVAA6eqzzH50QRRWOWvc98Gdj0gk96Oey5292i0JMfGvfH6VCPSkY0daXa+7+i16GCi+20bjPCA+UzpXeaHPfiFQAO1apJsAHlOk2To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898982; c=relaxed/simple;
	bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hk4Ac8fpdIZCSreIvL5a0Q99rrD72qqc8goo2wmJ5u79a5l6a9RP4UgvZxfWwtser7TFGNDRDy5/iohmHBAkOXWMWO30uhwJE8LN+w6GSLo1WLAquxhZMWuheq/TD3VEaqitHL9mDNEtbthQJyBD8PeRkwHRWlvAziArvot+9u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcPkLzE/; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcPkLzE/"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so4635ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 13:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898979; cv=none;
        d=google.com; s=arc-20260327;
        b=U7BgzgaqXHGWCgLZCkJH82KoN/sPyj7ulhWF8QfYqYGgYeR/pg/mYs1HiRZHY1rv3D
         oqDlzkCN0rc1y71p34m3cXenZnLvz+dEUJWQ1UHa6UdDmIwAbfCXH0djEDXtxsQZslgy
         nUtR2NH87+k5FHfmwbQCDcu1RjDlUCsvsHJmNDo869RqeCQ//qp8RM0wkr+iE3//DeoI
         WdqJCN8jze06ZcHAkIqkGXHPj7viCgRkTXIOV80Qsl20aNq70j/+Ivb8q/kSnRYUiaSk
         L9qwNEO6Qi0pZz5s42bzfsvtChbcdbYOjs/wWuTlkpt3mtd62JxXBJRDpgH14XW+603q
         0ISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        fh=2q+I/9YXs6Ia+GwREN38C+Zs77DAz9dq7JWW382hY/k=;
        b=DMTrX13ZCP8RTyW223QrpZ+oWPKV47XxMvlrbWa9Xb5XAFAE6zswhF0eMrmJEfUG82
         Ka9ZIeeA1knnvVKRXiCx8I6RIcAtWr3tAFpwOGj23Nv9+nWsddPOLHyTMmu4tGXxVQZN
         MaC5sMJNrSS7cymqJZdgdi5M7g45MpAW0CTFIhtx757Z3UDNI7BCa64lkEjizhI2iEBq
         sEq+X1eglEXXjEIShQ6R6BvsI8skdNiHKC1dSciRH3RyZw9Rr2DYPj4sFX1AUW4oAr3R
         HBZWnL8nikkOaYtRVHGhnA4g/7RCL9TY8owAQZvWI0DyTeyWofAUIqXGEX43c9xvzM5N
         VljA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788898979; x=1789503779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=IcPkLzE/GWJgGQFgFjq3/BPu5Aholp3UD6OdBhJ355j7ahhQeEmYsZPEkfMh2aEMl5
         kHUyWUF+7Gsx3qUraZvXNlJnLnJQiF0g9Ms56lLpww/Qy1lXVKnPHtG77r2emwHYzjgR
         29ats7zhEVuqr/LN+0lRI5mQ7VWdrJWjQgAlCiR2iAQR35K53EjDk/rXhFfh40uzR4Jy
         RRI+QZWDqRc4KQgY+OCWmcvnTOnP8NhhpvoTwWYJ2q5xpq67mWPEnUw4qNJN1Bm0SzLi
         Qv7BYZ4pLiZwDkSBChbQ8ajWrWqXo9sO0KR94zXOkfUC2TZVByd27wmQIX6YkWcdIFtv
         GfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788898979; x=1789503779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
        b=I+La+PTlf//+Z4DRSlSSE2iNrlffQntVrD+oCK3AlOeVsACH2Gph/RHwx4B5aMeE8/
         AnWT64KRMn9sLia4RVy4XCAkLqE7RcyMTfUSVyi0uLvYUj//m3RKzX7VCdKGvc4+z9ne
         RVT2lKOzk/sibMkhMIbUNmypq5VoDF5jNNnifG6pVNXlOXCWq1HZChF54FDw6oRHQrLG
         aVoWdKj4uFlwYdt2F6Li1O0epC5AKoEUFuEIcesIMXLIcP37rasG8FTxoaf/jiX3rICF
         /1qXSET0ijduaQ27m7FcUVu6zcmQr5L8oNKPIw3OFe+paiTvZ/VF/WYMXw/XKTsMxB8R
         wzyg==
X-Forwarded-Encrypted: i=1; AKwUvBxym07g/gkh1C3S62a8y2HY553tvlRn4EX+bApSEVjmEZ5+5xPCr4HO9a5Pq1DFhs3a202v5urAiLrjm7z3fqj37bw=@vger.kernel.org
X-Gm-Message-State: AFuF++l2XpcYb8EW8YUx8XEMu2VLIZb1/bkGhe0ZsySA+2kBlPjXKZ3O
	mVu0xOsnrJN1tBVhQ/18M/8KoJ6EClGHxizM3l/6Ggp2tTZfjEU2b9lt5ehrHPiK7RmbsouhWEJ
	cViir42Zygxyb5faJpkoak+L/Rreyqkwh9xIF1826
X-Gm-Gg: AYBFou14BuFK+T9Ndw0SX4USFCn9sEY+Dlon9tMNK9BvLMsoQYqKaT/4WER75XXo8cv
	UNKc82Z44kvX9+6KeWUgnGnN2kv4sK9RFBXC/UbVO3a39knID5RVn/qPt/xrfgvMpZ9n3oMk91/
	5OjNHdIDzGJ+6YuvuOSy7v2iV7VR73w7LgttiWEcnitKIEdYSbHjdmm8P4DFUf0oU0wCueFeQYm
	P9wI8w5iW5cTab3A4DvVEtkc9ueqLhU3NEmD1zkeaa0b4/CTBtcahpWGIyImhx7Q1LpaxC9kabN
	3BUWikXy40BV7FoBIcOUGrFsjaNw1+d0Bykr67+PTZmMZtm7dfrrZCro9Axou1r4EhCH3XfCQxC
	GaKLuSQ5hCqsiRSm+lty/EOMJEQK7z/8G
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
	linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
