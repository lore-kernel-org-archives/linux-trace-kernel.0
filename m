Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920680;
	b=L3e1GrxW3ZbzRz/wuGlWAiTKGgrHeQSKPPdmu+VW1Ee66htrKy/0d7/ZcCW92DawJslL
	 /NhY3IpTIzttcS7DoB0joLPqDnhDv16xD9LmhDHmxptTIqRYhBsdTeZR3wqJcVZGE3XMM
	 RkYV4td7E8rJgSv1NQUm9sHll/ubZPzGWVdwJ4sZYY9BaHOOI88tnKlqdhPCx1TPNF1Lg
	 f2e5se7jdZdrJ7gQL6fnyjb8ML7FJjPDsJS5yHtwtlcIlUpMoNNkJf1QoZpvQEN3K7nOf
	 NoNGXL/J0fjiFDUuBxUV0mQxn7JF6MpXo1t3PnL0sM29iNpZplSQfKY7w7mu1bVTThA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
	b=xOOSvfwq7GX8ANHwppySS9nwfImm2MlrvA7+IAmhsvdgrYXCmeRzTiyhHBHCzLCvKG+T
	 xvsI7ef6tnm8kPSbvizrpImx7F2x7KaDAXWsyTzG+0G0ZGdkLncM+J33yvR5hKN+Rj9Pu
	 dB7yC6KFWHD73CjaO7S+r+rqC1K41f7Ik9xgWmp2xiey0eH8uQEbhJtdG2QfpdRuxMKiU
	 JSQtWL+SitedJj3cJ1915RCO+TtMgAAzNhjYYK13yurzh1uT+uDfocI9sA1JIGbdWv9ox
	 RYtXXovyVSWynGTPJGEakK5m8Xh3674aKulRWVtmKnVv58FZcEKPBfuvFpXMy3dXFCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm;
	arc=fail smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E4606A329
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 23:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C1E4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=F936vzKm
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so26858a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 15:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920679; cv=none;
        d=google.com; s=arc-20260327;
        b=BZi+rRUqlfxP0gH5RptIdyfp3fSvLEI9W8/gOQna/PMjE5KBJRnYtAg4fVnc+1cTiz
         oY4phzqpgTkYLLu6Le7IBK41SRILpRDuI+PMrR8LVITHBozrXag3ycJ4Sv1tfoJPcypU
         P8oebRplKbb0q7MU+k+5OpGLR/b1nROWLBP8rYz0Qa2dcUr+rNrnLsJ6Z4M34byJauwi
         wPRDVtcJPqlxmXmMxKLOoExRdcuG57K1Y2FIt64a5S/BA5RnEjvoosmwgHT/Kpssj7z+
         onzvmNGwYzDWycmYp6A+Z5H3Xac6lg7a8yCiOY57QnMYN3IqpdAH8L3SqiiKAc04f28+
         xdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        fh=9gO2NjuJnjVX6uS03TQ5bnSnh0/7DsF1n7JU5Vu7nEc=;
        b=W4IBp3T51vAi5WjJFCmIpWShoKmChGPn79gAmyQmnk8EgSwL6IfGgqHiKRuk1mj+CH
         YR5rIJEVxuOuk5twRqiTguyln4Jl19ZIYfO4t86EOGI20wfHy72aIHBs4Lbh0eM1WB9a
         0u0v3cQp7cpUHYqbD5i4MVUjXq46TD1YEJf0NdtlgEu84DhXJ9MyIjgR5yBvT6w5RZQ+
         6+JJloFOVwkt1ie5POhxBhxLxQF8htH5Q7DPeGJ55oPwH5Z6U4soUotxr0rvMZ3QFmDO
         vJT9YzpgXnzUqZuf2T+nHclSyt4NrgU+HJ0deEdTFW3/i0IofBtkzZpZB4h6n5VXkwmj
         55nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920679; x=1794525479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=F936vzKmZco1Rg9qiS2Cf7yXwnXt8dn1LQ3YxCN5SMsKSJRTlu37FG2JQnmiZ4tO3q
         ZY7C/eCqTECYbf79gAR8gp3oow9+Ykdrk78RZdAOFLnN4sIU8x8jDIiI/j4+tmIgfhgQ
         Kfc7/iulz45+20nMepsyi2DVKsca2I7vu/IOFa2DSNB+5NoNB+X3xZL+TnSEr5nUJW/0
         t+eWupnUof2Q+Z07m3XUdhgKdmPOk5SNXh4+R1i03zuB5eyYkN5hGGMTpwfL4P3jF/oi
         qjoVjwxKWuHtQbutc+EbzPaNTI2YVJHBnHBIs9egvV2qx2jXIUZICkPleteOCZKku3cJ
         ZAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920679; x=1794525479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuCDmSI9zu6AYuOwJkaSaRyngdfgRozjSLztTOAphqk=;
        b=TZdnGsyGxM8mJ9NEaZDNceg4lkKshYMPHX5FobgN5Dlny/lxQAfI6e+2fx/EcOpbTR
         +ebsYi2rQWgQQdzOIkYg0reKcneI4ChZNK5JCFF+eaERvRe3+kKk/k+oCTaG4PCJ8ERT
         XQB7goZBtdv3qwbuXU7ltWs8NEbhKyazMHl43FbDvSyeKZriPPz0sn7GWc+iXXQCM6kU
         4005kAwbCaUOoK3IQ7abungNH1nn+yFckZSFOzaHQiXPMGMsbcsQZcx1MWW0G1kPFYwy
         6/rVXYM4xFiU2O813vDszT5b9J4sTKVvASbqZ2sznhSxAT1gkEerG2wb+afKqGHQ1BF0
         wFxw==
X-Forwarded-Encrypted: i=1; AKwUvBycAnkiOxgFb2g9XtEd7VAb7+yt2gu6IR0zrsNUbyOThZEroMNYFxVm/QPICsuVMOkXhlBBn6vOFHWI0BVZrcHIOVc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Zgp07YBt1LlJwAEX/kbjcn3PsSvONAOAi3x1Nqu1UqHRJmsnH
	IF1OrBMEMZJi9YeAyr4LBy/wGqIsJqkXrUiXAyq5M81GAxy6E2J3+cnwCzPpSh11cfToideQw+Y
	GwibRB6rvPBiMcu0sxx0fV0pPGw/d3ktQCkSNUcFu
X-Gm-Gg: AYBFou12+0vBhS7Lpr6zZOZqoTdxGlZUzgRUH4Z+CHfbLvuMCduOcMV1JXtihJVLEQO
	rkgocYrEo1Elpds8EdXNHGkF2suDE9aDxhmB1VvtwXaTOv8TJ0YIBeT2l5cLgMmhKjF9xzITSmM
	SYtzJlyfapvr9EEVLgeeMQvIYsR42Hn8+6IDkUhAIn/gb7yCPia4TLyIE468MgcJ7+3fbxM/0lf
	y3ZLYYNwqnHXn8bkP+w/SzCujqxunusRAex7LEz/MA/DZyV5P9w7R/MvF8KlLJrNdhsYnoJYD5Q
	eWt3i98I3+5TVcSw87zDxQNN53KJ/cM+NztNAObFT/uBTJfjQmxu1AdXUKpCMeNldKLgvpytT+W
	wNRwrgiOIqUeduLvBQu4v8+ky4P2MqoLch6ML+Ev50Mf0APjVB4TRmHMhc+gSeiDF/U4E
X-Received: by 2002:a17:90b:1dcd:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3b0db703e39mr535625a91.34.1793920679319; Thu, 05 Nov 2026
 15:17:59 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-13-0d3cd15ab75f@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:17:47 -0500
X-Gm-Features: AclHuK_gkg-Hspii6U5_01_jGLQO23B7F4YXuvzvsb53ImE19wnChR3DgLruv6g
Message-ID: <CAHC9VhSR=9YNhBxeFBcTR8wgG2yDP1fW590QKjzuc4Kq9ohaiQ@mail.gmail.com>
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

On Thu, Nov 5, 2026 at 4:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> mmap and mprotect LSM hooks of SELinux, AppArmor, IMA and IPE.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/apparmor/lsm.c           |  2 +-
>  security/integrity/ima/ima_main.c |  2 +-
>  security/ipe/hooks.c              |  2 +-
>  security/selinux/hooks.c          | 14 +++++++-------
>  4 files changed, 10 insertions(+), 10 deletions(-)

Similar to the other patchset you just posted, is there any reason why
individual subsystem maintainers can't pick these patches up, or is
there some reason I'm missing and they need to go through a single
tree?

If they can go through multiple trees, can you split this patch up?
AppArmor, Integrity/IMA, IPE, and SELinux are all maintained by
different groups/people.

--=20
paul-moore.com
