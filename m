Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515867;
	b=Cgl8nY2rdtxzp0slueIb+I+Ctl5bbYA/NdsNnF5uHLTTIS0P3r5+JL5ZuOokd11YXWYm
	 MTW/4wxFzBbK2K73z5j0HigX/TIfuDqurfgBWRGTX77K57+thqE1IK0y1q9xwqNb7TXgj
	 zjZCfm1WXVdv1ob6+T8E5SWJW0WrLbRdDqpxgBOve2yJPssG3UeR6wCqwkODmKb4SJRxF
	 0LuduszT2I+ae/rdN4I2PJm/4hajnx+40/A38q6atNkedaTnY3wtJaFAcwPt8sAKyYhfm
	 Buq7q0Jvr8acH2FNhce820z4xOVgVLwV3Ft6tUWZzUk1z5tDNg7n/2wpHmYT7m4kRAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yee+wxcLaXMSXZcwc3mnTan8zJx8NOKtHj/C/GekHBg=;
	b=ZySopy+ne9vD1BPwkLugrC0w9LiffXZgfnVoysw69YoCc1Yd8A2lGIsKxcfzVDH9JIDW
	 Fp4geSkEiAO54WnmcEdihmrDhoBE3IFdlHye+bQI7PwgWn+Q/XoE+M/nc+rZ1m0vHIRb/
	 D8NK+fll8RS1ojBzja5xoaTy54ZcMemKi0gYophAI5vpOOlXiNf0apKnPowY6+khcqEEK
	 pwuNOnS5FgEKlht6uLvNkrHk74QQ2vNvzWse6x4QoNM/8qDS9qO886sidsiAzcaOCQWsi
	 mIPmTFPMEnw664WslYVG56mOCUXL8/EVZS59HxYmlxHbgY4/4XBqFji5c/m89BVzMtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoRSmR+k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E14606A338
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoRSmR+k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E0F1F000C5;
	Thu, 12 Nov 2026 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515867;
	bh=yee+wxcLaXMSXZcwc3mnTan8zJx8NOKtHj/C/GekHBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IoRSmR+kSj4t/yBRXD+H8lf//npdr/Xr68eYsaOAz6GDvcFvZ/ZqwhuNzkVL4a1PJ
	 OidEi1luy3UhjDAlKJ7831WAn0fWy/LDON7P2uQY5kTW6BMrRj8MUQFyjSkDpC/Lkw
	 gwwBnaUgJsq0dDPVSXukBmMnNo8z/F6EP6ZPI2AbZYVuSc8+uL7z3j1sz3bHHdKCss
	 dq+t59wspSicDf9lOXft45H2wexa2Ryl3RLGfnhi4PdhKz98oL6TCyTrgFkserg4/T
	 nwAqkxMdtUqT/xF2p71USeugqkMyBT+A+dBTrCc0/uRHEaW+beBW96U0Bb66pjFfQB
	 pSxczSib9uYlA==
Message-ID: <sashiko-outbox-211802@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v25 07/14] mm: keep the RSS counters of
 single-threaded processes exact
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "David Hildenbrand" <david@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Dennis Zhou" <dennis@kernel.org>, "Tejun
 Heo" <tj@kernel.org>, "Christoph Lameter" <cl@gentwo.org>, "Martin Liu" <liumartin@google.com>, "David
 Rientjes" <rientjes@google.com>, christian.koenig@amd.com, "Shakeel Butt" <shakeel.butt@linux.dev>, "SeongJae
 Park" <sj@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Sweet
 Tea Dorminy" <sweettea-kernel@dorminy.me>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "Wei Yang" <richard.weiyang@gmail.com>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Al Viro" <viro@zeniv.linux.org.uk>, "Yu Zhao" <yuzhao@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Mateusz Guzik" <mjguzik@gmail.com>, "Matthew
 Wilcox" <willy@infradead.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Aboorva
 Devarajan" <aboorvad@linux.ibm.com>, "David Carlier" <devnexen@gmail.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Harry
 Yoo" <harry@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Kees Cook" <kees@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, linux-trace-kernel@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Oleg Nesterov" <oleg@redhat.com>, "Alan Stern" <stern@rowland.harvard.edu>, "Andrea
 Parri" <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Hugh Dickins" <hughd@google.com>
In-Reply-To: <20261111203626.95838-8-mathieu.desnoyers@efficios.com>
References: <20261111203626.95838-1-mathieu.desnoyers@efficios.com>
 <20261111203626.95838-8-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:37:44 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mm: clear mm->rss_owner on fork failure in dup_mm() and
  copy_process()
--

commit 388976e575ede4fc50ab3cc88ddde7c67d80cb2e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

mm: keep the RSS counters of single-threaded processes exact

This commit initializes the RSS counter tree lazily when a second thread
shares the mm, using a plain owner counter and an atomic counter for
single-threaded processes.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index d9bdaf2bd9984..dc1db6cb5da04 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c

[ ... ]

> @@ -1550,6 +1550,8 @@ static struct mm_struct *dup_mm(struct task_struct =
*tsk,
>  		mmap_write_unlock(oldmm);
>  		goto fail_uprobe;
>  	}
> +	/* The child owns its RSS counters, see __add_mm_counter(). */
> +	mm->rss_owner =3D tsk;
> =20
>  	err =3D dup_mmap(mm, oldmm);
>  	if (err)

[Severity: Medium]
Can a failed fork leave mm->rss_owner pointing to a freed task_struct?

Once dup_mmap() succeeds, the new mm is reachable by external
mmget_not_zero() callers such as userfaultfd or swapoff.  If the fork then
fails in dup_mm() at try_module_get() or later in copy_process() (for
example when put_user(pidfd, args->pidfd) returns -EFAULT), both error
paths clear mm->owner before mmput(), but neither clears mm->rss_owner:

kernel/fork.c:dup_mm() {
	...
free_pt:
	/* don't put binfmt in mmput, we haven't got module yet */
	mm->binfmt =3D NULL;
	mm_init_owner(mm, NULL);
	mmput(mm);
	...
}

kernel/fork.c:copy_process() {
	...
bad_fork_cleanup_mm:
	sched_cache_fork_cleanup(p);
	if (p->mm) {
		mm_clear_owner(p->mm, p);
		mmput(p->mm);
	}
	...
}

If an external reference holds mm->mm_users > 1 across that mmput(), mm
outlives tsk.  A new task allocated at the same slab address as tsk can
then match current =3D=3D READ_ONCE(mm->rss_owner) in __add_mm_counter() and
perform unsynchronized non-atomic updates via
percpu_counter_tree_add_owner(), losing counter updates or triggering a
Bad rss-counter state report in check_mm().

Clearing mm->rss_owner alongside mm->owner on both error paths before
mmput() would avoid leaving the dangling pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111203626.9583=
8-1-mathieu.desnoyers@efficios.com?part=3D7
