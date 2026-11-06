Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937680;
	b=jHN6YG/iD4f6KV3RPfo/9erO02HMASeiwJqqo8l7GouGrgYiM5tnzwfzyt54lN0zfCQx
	 hYzuRSS917MjLqG1OX7A7RGU92z5Db11QMjkzD1PuCiJB+pceR2XB/ntTnnbVrZOiqj1h
	 tij3T/JZ8gc2dxWOWRd0fAi4JOOwWczB1ObY4RTY9y+DX8wJK6C4Abj+5Btb4QUoGmCCO
	 aVwaH6/E0qoYg5fiWNBl8ou69VbZUl53b4axOORs9QAG5QcI5C6cB3S9hoY5yiXpk+rhW
	 1/JmurN7CteWpOrFfWV9Hh4gzw5l8dje4MffIeSwOKocH7Y7FbtrdMBNAiWvhEuj+cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937680;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	b=AzVY13H3pFhg/Iqdiem/rXhEdwbNF6isv+yIeUCYmJuE0eQd0lAkV6HFToikpCBGQhsg
	 OE2Q5itofbNCdjGEScV3+aiMSk4y1RTeREXCyABom4oOCHipqgKMZVvQs7lpiFxqAbEoy
	 NKgV8qoXhQVNDYq7PaqJSE93m59NBJv2mb/q6BvSqhKE9VPlNN20V+3iTXqqSXRYn4pzG
	 n1vPI/BGSeJIRrJDYSKBRDCLVhon7h3hIODevUcs3+ydB2uZE4fTX4y062gGtlvyt9o+G
	 bOuuFH0mZezlLMXdUAbb63M+LylaoUW5QBYKv31TJuCAhSwRNpl45YYH6M5vXMnQjjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE91606A32E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNdgrU5z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9475D1F00904
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 04:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937679;
	bh=EKI7PGZaHzRnKhw9+Gxl7Ck/B2CGZVJrrWzNjxtIAHE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LNdgrU5zM2nugBvZVCR02iYgDIFmlQHM3kqBcyp/SVdk7mtCDyZg91KEZW9QGqiq4
	 pTrdL/v5+Sridp9dwQOz13aeDVsJ3H2YdUTQ2WgTqzAN3jOXnwlTOnh17e7nKmSJJS
	 cBGQ2Hysr/0o2u+C0HNxL4jSArWNZCkAWoE4VqHwdeCR6AmOWsinVXhs4XeD3AnnYL
	 NyyqQbfWqKaONffmcdGvCd7zgPIyaaZdh/1bZChmRJVWt9bEoba8Mj9VPdtvLQJHSL
	 LtcLpkBtQervU2s3YqAwlJwk+9qPdvnWWnyivKaN8yf3MXd/mXhVPuD1TG2CyQRZXk
	 koUxpIOcYqO3g==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f22a8515eso13941585a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 20:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy04GbPszhfKJembV+Hz/Wt0dTylF497BC2yufjJDSBY7ABA1HfiDA8Vy6IqoXZxpJvaOUbats9D6amq62yjUCpq5c=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ChLe8Vk2sCYKAgGjoGgx0AUY8sI3Oq+cf/NzxOmxW2G8BYR0x
	M2As3I0q1KIQqvm9VJguMqohnh4RODrFNwH3oznjcPGn4gOqjIhKA3T9USkL6eTIav9Xe7YIC7H
	bvdID+gl8pUISvglSdg41dwYgzhznm9M=
X-Received: by 2002:a05:620a:688f:b0:93f:5f83:2cbb with SMTP id
 af79cd13be357-945f33a9aa3mr181925685a.7.1793937678322; Thu, 05 Nov 2026
 20:01:18 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 6 Nov 2026 12:01:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
X-Gm-Features: AclHuK-043SJnHCawrQog3yw2g1v7cvWQi1ZSPtdBLorMSdL4MZoNdMju91VkJk
Message-ID: <CAGsJ_4zKtBarGn2gMEH7ckKtLLgugoyPb040Z2KtXX5Feye1Mg@mail.gmail.com>
Subject: Re: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
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

On Fri, Nov 6, 2026 at 5:33=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> VMA flags are tested directly in the THP and khugepaged logic.
>
> The thp_vma_allowable_orders() family of functions, hugepage_madvise() an=
d
> khugepaged_enter_vma() continue to take legacy flags for the time being.
>
> Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---

LGTM,
Reviewed-by: Barry Song <baohua@kernel.org>
