Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938214;
	b=QZ5JlAEz5Xm39kLHJRSy2ctRQuiYgZqfaSo816TRkm6nC92teKkdlRT+RLp+lo/EO9UY
	 7kBcjBkJHnpkq6OrP50g3fsUDpgShXvC0o7oEMALFoINGbq35n7Iv5ODDOmkpEx293hmf
	 XS4TPuWPdxammLq/vUHjpxpZvjBY4dae2CkYHuHTXUR0/s9mTpwT6tlJV2onqEwKeaOxp
	 vwBmP6haDLbkHBfT5n9yVLJUSJCDu9LolP81P9u3TC7+Uo/znSm5OmPqnjgkb1HM1E0lV
	 v0Jh/AYcIhVRJ1JOkcmhWRjP7EjtDHWyNj83X4UKTDuZdXC/853exYYgyTojZdekGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938214;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bpOrsKv6qGnA9uW832gOGeZZa5N6TFONX1C9LOr1sUo=;
	b=LTSu3fl6Y+ahKNd70CsO/fypJCWbvVTy5aZvl2+C6acMwupk3KhTEj0LdANeNWv1yDq3
	 ocZmOzAHpd1gK5r57sjrQHzXqHxcotTnEbY82C36OSWgoJyZhJFCjoRZLr8PXTR+c+K/O
	 PmXQAwrpOJvE6pIAzOHT1sGL0Jemwc7qZjljo7kNrU0yM7e5EASXpH9kVoUC08tSVRBSo
	 jrHgLhKDy9hozYBPcxvWPcbzP2Ou8uqIL2n1VSM/8RSvTarzRN7toT9tEED4B4Ot0S4LD
	 EWWpR0FQKC/Sc4r1Wm2n7lr6BilFi8HMbUkZr7fkcKlD5nqVqfbqtNACd3bkR74AIfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4g7meN9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19413606A332
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 04:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M4g7meN9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6BC1F008A1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938213;
	bh=bpOrsKv6qGnA9uW832gOGeZZa5N6TFONX1C9LOr1sUo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M4g7meN9L4jcufSegpXXlWaGlXSAiSHsKt/N0gqp+weN1qe6aJeULVDkyojAgWtGd
	 gPzkuMhS3VJVvD2iSMsunZRORx5vJwxaWTAQVgFcpLq14jjWIAD7Nw2dIR1i7/2Hzk
	 /O5QenXf94M6jdl7yxnrnrLBTyfQ+VOsC+G1To0qVtvIPWpP8LkN4Fxrkoshn5Eodv
	 iI2U+VQDFU28zucCyh62Ju3w7+sSJBZjMtmNRYMl89xvA9b06kdZffirB4Mo5dQJxN
	 lfwJBW8CcnqbWHB2+bVzFKHN9Grs/TML+8Rs5t7LhzX+R2+u3PZkzW2XpkS0NsohGE
	 EFmyKRadV+PGA==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e4c00d71aso17159885a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 20:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz+JJBt6Je2EigmZTLDZQpS8SWtmkPpKHvSx4Ik13MCkZu7o2T4lR+086hkmZ5i7gDlSmPT5ST24YYn2F64cYSiqvo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KQfJZRFRJ02kvfe9vu4Anvb81fduyXMpkGE+oHBKrKmHWJCbr
	e2jkyr/Rk2cKpo+TYEcl/o5M3gEwi8QV8uLtME1TdEOWiaygDOyc+0F32IgUvSmXmG7wYOMcxS8
	5FHS8yNEjOCWDl5fYJVMaLZQjRhLDhr0=
X-Received: by 2002:a05:620a:1b86:b0:93e:c12c:f134 with SMTP id
 af79cd13be357-945f364d640mr184996685a.79.1793938212273; Thu, 05 Nov 2026
 20:10:12 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-4-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 12:10:01 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zfovh2t9zNeo2D6+TqPbKeEeoFniTyE6DQT8w8stXNhw@mail.gmail.com>
X-Gm-Features: AclHuK-3k2KPmLqEqbOgFVFtxh57Y4Ge5X7nQzdyUQMEUj3H7k7EkhGovaoUjnE
Message-ID: <CAGsJ_4zfovh2t9zNeo2D6+TqPbKeEeoFniTyE6DQT8w8stXNhw@mail.gmail.com>
Subject: Re: [PATCH 04/13] mm/migrate: convert VMA flag tests to use vma_flags_t
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

On Fri, Nov 6, 2026 at 5:32=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> migration logic.
>
> We retain the READ_ONCE() of vma->vm_flags in remove_migration_pte(), as
> there is no vma_flags_t equivalent, and arch_make_huge_pte() continues to
> take legacy flags for the time being.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,

Reviewed-by: Barry Song <baohua@kernel.org>
