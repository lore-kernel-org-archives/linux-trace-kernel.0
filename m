Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936864;
	b=rCrV2/0GZIK5uxDgUrSo9gk986WL0yTkmme35B6IojW4KaWeZL+IrGBLQbbC/A0+/8Kk
	 JMDY5Q0aKLIKRROzrWlYEo6hnBrKUAAi/LxVzOPJIjKNEOejh1I8u9DP+K7OFr7K5daLZ
	 eM19DynBRfwoaqnEHbq5dyAPMdxb3sK5aGYdVHm1/BUh7bcsfndKKovJhVEE1Q+xn+SL1
	 2VCpIRXwQsV+pDNSfceFoFTNPSXTjZYTRwqULPinuWlkfBGGy/NOGHVI9C7+C1LyErrHA
	 edF3JkUZMdXbZV+kf4St7Ff9lC829n6/jM4doY+kYQF2z7IMpi3A1XoqPYdOzlEFr3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936864;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	b=sTVLnQJUhgT2dTLUvI/20XcEdPStACTt2XklfZNHYyT8DYgIru0+F5i/a+KuvZH/vWHK
	 3mKamIWEPEwYV58jJ01hyuMz7qOle2pMSHlSH9ni3vlcKWTi2gBOKrNOknq6Wez9Miajg
	 XTK4c0Ecjrg0fWhgpyxQMxqFKgMSF3ojtuvnRaHVneVMGSSt7/7+d67z+U+bPK911Rk+/
	 GgjFonIONBR6i01Y6HXp6kfgPP0dLgtjARgX8MCLM1+GxC95s+VALEvN6/Go22UxspYQE
	 AlwLKLK3zo/ZoWy4TjvDdg3+8MfbT9YXcGzoe/T/BIHtsuYgTRPHeSedvRgqlx4RgSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHNJYmjZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4078606A328
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHNJYmjZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924FD1F008A3
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 03:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793936863;
	bh=7itVVRO0OrCMzanAOyJRHIm0MPtgmrlnhYWCxSa5SEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SHNJYmjZARW+KMI9weZlYiailG9olXiPUIy9DhCfIwXmV7q4793PyRrLUT1E0bUGo
	 nmmkSMDlfuESlH1L51OEthu9tEkk2dz2ml2LZ2Yor/qURFWM9SBb47kSDL7kUWgh9C
	 KsoGQQsyq8SQ3dBpKKj2a0u8iYdYRtyHNqGxCi2IdNRzvx7Jk2ogdHgO1WRtzTr3ck
	 pbqvm15vJgAS3L3BUo1VvUPFU4RI+LQ3b7/f020/Qst049o3V6Tx1xgJr2l3zMg1Gi
	 d0CgtsezOi7hf/YovyD6VXycvpTFmxYdwrokEbGNW+riJ23JkFlugyHUX1hoqofhzR
	 GMHWANQP9U7qA==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-945ae2daa68so28239885a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 19:47:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByEEbDSz5UtmzGR5r2AuP/3uLyb5X/28z9UJGYR4H5pchPSBfKmpQEtyre3i/7MITIk76KHAzIECVZw3VEDL5wM2ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CEfEU4KRjSugTggGlsxkz6BSEqkMPLMnWtOYbWLHPqymM9yL8
	DK3hvNIfEIrHYSGmWMI/KO8Fkc8XXRXD7cz6+emhQq4o+t8eLhqazGE9I2E6y/8Ldl9s6TZyqVU
	plPdiKUlLTGuLhKOXVNhCHn0cXIz7D/Y=
X-Received: by 2002:a05:620a:6ccd:b0:945:d3ba:7d99 with SMTP id
 af79cd13be357-945f3593146mr175996585a.37.1793936862458; Thu, 05 Nov 2026
 19:47:42 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 11:47:31 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
X-Gm-Features: AclHuK8VX6mOjbrvfm7oXhssK45doLoq2eZ9cV_P4690FurSVGBQe9E3r9SjObI
Message-ID: <CAGsJ_4wFi9mqSsq9RFoYP8m0GbqU01he_icbP2VLPhBfQAvCOg@mail.gmail.com>
Subject: Re: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
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
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
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
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
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

On Fri, Nov 6, 2026 at 5:31=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the GUP logic, both for the MMU and nommu variants.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/gup.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)
>

> @@ -1514,9 +1514,8 @@ static bool vma_permits_fault(struct vm_area_struct=
 *vma,
>  {
>         bool write   =3D !!(fault_flags & FAULT_FLAG_WRITE);
>         bool foreign =3D !!(fault_flags & FAULT_FLAG_REMOTE);
> -       vm_flags_t vm_flags =3D write ? VM_WRITE : VM_READ;
>
> -       if (!(vm_flags & vma->vm_flags))
> +       if (!vma_test(vma, write ? VMA_WRITE_BIT : VMA_READ_BIT))
>                 return false;

This also improves readability. Thanks!

>
