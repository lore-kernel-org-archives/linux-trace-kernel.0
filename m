Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793482768;
	b=qTNxr4mK4MVTE0GuN6NIyioS7lrJYZgMwnK3gOhX1x2Uqj3GPNbEOnPE81CMslvkgrbv
	 lOj8AgiPKR8bYBRKHo6xPcnQVjJW3QWi3Pps315+Gsm9Zxy7zDjJY/Q71Aucprasg762M
	 H/aEpFWAqS3kgdevtFWoDtexjb+ter5EYeJwKtyLFA/ULja4eM8/fiGoJ1HXbMvI9LHpD
	 lyjtycQJGw3pxE6qteSMzlKWhlZE6g3iGMV4SNA+g441SMpI7pqUVPT16X/Pfj7V37tAI
	 HpAY22YV8QSi8FNUDcWZyhAWjrhP8o88t5dtW3zi1NCHNZDI00m8jqIy9aCUlcrwByQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kp18/mHsiF5qBN7v25qcp961nWpYoHUy85dDrDdwpTQ=;
	b=tTXaZpXAPumMzQTb4ddLKQBHWCCdtjbDwLERPXOwsYRJFiR9OtTVtkzhiHjv57GrS1K7
	 w2DdVsgL6Mu4qfLnsGKSX80hcnS9wfebuOdYuIIwLtIDg6U+9VkXwIkLvjExOGErMZlkC
	 l0TlTr4TvPzEPUNb8y1lDq5tIAkQ8NLwjiKbUrlfIEZx5XajH7V7rBbOAcHbsN9oQVXtC
	 4D2pKvgZz5fG9TN05z9XyI0PYe1wAmW4VH9GBFEfTOMJ8o97PeCiW+jbisuZroYcETytR
	 l8Ke4VvbHs1eQITlS6r3m3U4JbAl3fOk4BO5u9acL3fpjddt+Dlepp6UwlgNtaTEg9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1Tybpwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7142606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H1Tybpwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6E1F00919;
	Sat, 31 Oct 2026 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793482767;
	bh=Kp18/mHsiF5qBN7v25qcp961nWpYoHUy85dDrDdwpTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1TybpwewN7DiAlNwiCXT+4lYJb3GFyi5bHe06fVx5lFapn4o/Sb/hTGEcPll3RTz
	 UYi/rxoAI/4EJoriBs+7OY+CcqhjnyqSKSMUHDOdHUM1qmrX9FkLCKrYRH1jKScn47
	 lHY2QE7dAfYgdf2jpXxzlOdvKXz50WzYnYtsMjkOcUJNDWz/XgwClRlSKPKMkda3m1
	 ojl+6QwQttpz1XV+X9aoTziYFOwZb52rEggbZCJFJY4JOy+mUIgSAT/91BXhe7Xu3M
	 qGhH3+/YN+MBnJqQTjmH4UcpfY3tY1bSBZ4QNvankXZu5IukZQVxOnDGoXZvruPYOf
	 AVlS8Bn9mKtyg==
Message-ID: <sashiko-outbox-192181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] sched: Extend task command name with
 TASK_COMM_EXT_LEN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>, "Shuah Khan" <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com, "David
 Laight" <david.laight.linux@gmail.com>, "Linus Torvalds" <torvalds@linux-foundation.org>, akpm@linux-foundation.org, "Yafang
 Shao" <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com, "Petr
 Mladek" <pmladek@suse.com>
Cc: kernel-dev@igalia.com, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261030-tonyk-long_name-v8-4-c9b030332254@igalia.com>
References: <20261030-tonyk-long_name-v8-0-c9b030332254@igalia.com>
 <20261030-tonyk-long_name-v8-4-c9b030332254@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:39:26 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Medium] drm/tests: drm_test_framebuffer_init() fails due to extended cur=
rent->comm
- [Medium] drm/amdgpu: amdgpu_ras_check_bad_page_unlock() fails for >=3D16-=
char comm
- [Medium] selftests/bpf: verifier negative tests fail with 64-byte task_st=
ruct::comm
- [Medium] drm/nouveau: format truncation in nouveau_channel_ctor() and nou=
veau_drm_open()
- [Medium] tracing: broken comm event filtering in filter_pred_comm() for l=
ong names
- [Medium] lib/string_kunit: string_copy_task_comm() uses TASK_COMM_LEN for=
 TASK_MAX_LEN
- [Low] ipv6: ndisc_warn_deprecated_sysctl() fails to deduplicate long comm=
 names
--

commit de6fdb5089442d5e041310e67345e77eafd17cb9
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

sched: Extend task command name with TASK_COMM_EXT_LEN

This commit introduces TASK_COMM_EXT_LEN (64 bytes) and expands
task_struct::comm to allow longer command names for userspace and kernel
threads while capping existing userspace interfaces to TASK_COMM_LEN.

[ ... ]

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index db529a93525d3..5e02bce749b82 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -323,6 +323,7 @@ struct user_event_mm;
>   */
>  enum {
>  	TASK_COMM_LEN =3D 16,
> +	TASK_COMM_EXT_LEN =3D 64,
>  };
> =20
>  extern void sched_tick(void);
> @@ -1192,7 +1193,7 @@ struct task_struct {
>  	 * - set it with set_task_comm() to ensure it is always
>  	 *   NUL-terminated and zero-padded
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				comm[TASK_COMM_EXT_LEN];

[Severity: Medium]
Does enlarging task_struct::comm to TASK_COMM_EXT_LEN cause the
drm_test_framebuffer_init() KUnit test to fail?

KUnit runs each test case inside a kthread created by kunit_try_catch_run()
in lib/kunit/try-catch.c:

	task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter,
				     try_catch, "kunit_try_catch_thread");

During kthread creation, copy_process() in kernel/fork.c copies args->name
into p->comm:

	if (args->name)
		strscpy_pad(p->comm, args->name, sizeof(p->comm));

With p->comm enlarged to 64 bytes, current->comm now holds the full
22-character "kunit_try_catch_thread" instead of being truncated to
"kunit_try_catch".

However, struct drm_framebuffer still defines comm as char comm[TASK_COMM_L=
EN],
so drm_framebuffer_init() in drivers/gpu/drm/drm_framebuffer.c truncates it
to 15 characters:

	fb->funcs =3D funcs;
	strscpy(fb->comm, current->comm);

When drm_test_framebuffer_init() in
drivers/gpu/drm/tests/drm_framebuffer_test.c checks:

	/* The fb->comm must be set to the current running process */
	KUNIT_EXPECT_STREQ(test, fb1.comm, current->comm);

won't this compare "kunit_try_catch" against "kunit_try_catch_thread" and
fail on every run?

[Severity: Medium]
Can this also cause amdgpu_ras_check_bad_page_unlock() to reject the owning
process with -EACCES when its command name is 16 or more characters long?

In drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, amdgpu_vram_mgr_new() saves
the allocating task's comm into vres->task.comm (which is sized to
TASK_COMM_LEN):

	vres->task.pid =3D task_pid_nr(current);
	strscpy_pad(vres->task.comm, current->comm);

This truncates names of 16 or more characters to 15 characters and places a
NUL byte at index 15.

Later, amdgpu_ras_check_bad_page_unlock() in
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c verifies the caller against the
stored task info:

	if ((flags =3D=3D BYPASS_ALLOCATED_ADDRESS) &&
	    ((blk_info.task.pid !=3D task_pid_nr(current)) ||
		strncmp(blk_info.task.comm, current->comm, TASK_COMM_LEN))) {
		ret =3D -EACCES;
		goto out;
	}

When current->comm has 16 or more characters (for example from execve() via
begin_new_exec() -> __set_task_comm()), current->comm[15] is non-NUL while
blk_info.task.comm[15] is NUL, causing strncmp(..., TASK_COMM_LEN) to misma=
tch
at index 15. Should that comparison use TASK_COMM_LEN - 1?

[Severity: Medium]
Will changing task_struct::comm to 64 bytes in vmlinux BTF break the BPF
verifier negative selftests that test out-of-bounds accesses against
task->comm?

In tools/testing/selftests/bpf/progs/task_kfunc_failure.c, task_access_comm1
and task_access_comm2 expect a 17-byte access to exceed task->comm:

	SEC("tp_btf/task_newtask")
	__failure __msg("access beyond the end of member comm")
	int BPF_PROG(task_access_comm1, struct task_struct *task, u64 clone_flags)
	{
		bpf_strncmp(task->comm, 17, "foo");
		return 0;
	}

	SEC("tp_btf/task_newtask")
	__failure __msg("access beyond the end of member comm")
	int BPF_PROG(task_access_comm2, struct task_struct *task, u64 clone_flags)
	{
		bpf_strncmp(task->comm + 1, 16, "foo");
		return 0;
	}

And in tools/testing/selftests/bpf/progs/verifier_btf_array_access.c,
kernel_btf_array_out_of_bounds expects offsets in [0, 31] to run past the
end of task->comm:

	/* task->comm[i], i in [0, 31]: max offset runs past comm. */
	SEC("syscall")
	__failure
	__msg("invalid variable offset access into struct task_struct")
	int kernel_btf_array_out_of_bounds(void *ctx)

With task_struct::comm enlarged to 64 bytes, the verifier accepts all three
programs instead of rejecting them. Should these selftests be updated to ma=
tch
TASK_COMM_EXT_LEN?

[Severity: Medium]
Could enlarging current->comm to 64 bytes trigger -Wformat-truncation build
warnings under W=3D1 and truncate the PID suffix in Nouveau?

Similar to the i915 places updated in this patch, nouveau_channel_ctor() in
drivers/gpu/drm/nouveau/nouveau_chan.c formats current->comm and the PID in=
to
a 32-byte buffer:

	DEFINE_RAW_FLEX(struct nvif_chan_v0, args, name, TASK_COMM_LEN + 16);
	...
	snprintf(args->name, __member_size(args->name), "%s[%d]",
		 current->comm, task_pid_nr(current));

And nouveau_drm_open() in drivers/gpu/drm/nouveau/nouveau_drm.c does the sa=
me
into a 32-byte stack buffer:

	char name[32];
	...
	rcu_read_lock();
	snprintf(name, sizeof(name), "%s[%d]",
		 current->comm, pid_nr(rcu_dereference(fpriv->pid)));
	rcu_read_unlock();

Should these two callers also be updated so W=3D1 builds do not fail with
-Wformat-truncation and long command names do not drop the "[%d]" suffix?

[Severity: Medium]
How does ftrace event filtering on comm behave when current->comm is longer
than 15 characters?

In kernel/trace/trace_events_filter.c, filter_pred_comm() passes TASK_COMM_=
LEN
(16) as the buffer length of current->comm:

	static int filter_pred_comm(struct filter_pred *pred, void *event)
	{
		int cmp;

		cmp =3D pred->regex->match(current->comm, pred->regex,
					TASK_COMM_LEN);
		return cmp ^ pred->not;
	}

When a task has a command name of 16 or more characters in current->comm,
current->comm[15] is non-NUL. In regex_match_full():

	if (len < r->len)
		return 0;

	return strncmp(str, r->pattern, len) =3D=3D 0;

filtering by the 15-character truncated name (r->len =3D=3D 15) compares 16=
 bytes
and fails because str[15] is non-NUL while r->pattern[15] is NUL, whereas
filtering by a full name longer than 16 characters is rejected by len < r->=
len.
Likewise, regex_match_end() computes strlen =3D len - 1 (15) and checks for=
 the
suffix at offset 15 - r->len rather than the end of current->comm:

	static int regex_match_end(char *str, struct regex *r, int len)
	{
		int strlen =3D len - 1;

		if (strlen >=3D r->len &&
		    memcmp(str + strlen - r->len, r->pattern, r->len) =3D=3D 0)

Should filter_pred_comm() and the regex match helpers be updated to handle
TASK_COMM_EXT_LEN?

[Severity: Low]
In net/ipv6/ndisc.c, does ndisc_warn_deprecated_sysctl() fail to deduplicate
warnings when current->comm is 16 or more characters long?

	static char warncomm[TASK_COMM_LEN];
	static int warned;
	if (strcmp(warncomm, current->comm) && warned < 5) {
		strscpy(warncomm, current->comm);

Because warncomm is sized to TASK_COMM_LEN, strscpy() truncates current->co=
mm
to 15 characters, so subsequent calls from the same process (such as
systemd-networkd) will see strcmp(warncomm, current->comm) !=3D 0 and repeat
the warning up to 5 times. Should warncomm use TASK_COMM_EXT_LEN (or compare
with strncmp(warncomm, current->comm, TASK_COMM_LEN - 1))?

> =20
>  	struct nameidata		*nameidata;
> =20
> @@ -2048,7 +2049,7 @@ extern void __set_task_comm(struct task_struct *tsk=
, const char *from, bool exec
>  static __always_inline void copy_task_comm(char *dst, struct task_struct=
 *tsk, size_t len)
>  {
>  	const char *_src =3D tsk->comm;
> -	size_t _len =3D min(len, TASK_COMM_LEN);
> +	size_t _len =3D min(len, TASK_COMM_EXT_LEN);
> =20
>  	if (!_len)
>  		return;

[Severity: Medium]
In lib/tests/string_kunit.c, should string_copy_task_comm() also be updated
from TASK_COMM_LEN to TASK_COMM_EXT_LEN?

Currently, string_copy_task_comm() defines:

	#define TASK_MAX_LEN TASK_COMM_LEN
	#define SMALLER_LEN (TASK_NAME_LEN - 3)
	#define BIGGER_LEN (TASK_MAX_LEN + 3)

	static void string_copy_task_comm(struct kunit *test)
	{
		...
		/* copy to a bigger dst buffer */
		copy_task_comm(bigger_buf, tsk, sizeof(bigger_buf));
		KUNIT_ASSERT_TRUE(test, !strncmp(str, bigger_buf, TASK_NAME_LEN));
		for (i =3D TASK_NAME_LEN; i < BIGGER_LEN; i++)
			KUNIT_ASSERT_EQ(test, bigger_buf[i], '\0');

Because TASK_MAX_LEN is still TASK_COMM_LEN (16), BIGGER_LEN is 19, which is
smaller than sizeof(tsk->comm) (64), so the test no longer exercises copying
into a destination buffer larger than tsk->comm. Additionally, if TASK_MAX_=
LEN
is updated to TASK_COMM_EXT_LEN, copy_task_comm() only writes _len (64) byt=
es
and does not zero-pad dst[_len .. len - 1], which would leave the trailing
bytes of bigger_buf uninitialized when the test asserts they are '\0'.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-tonyk-long=
_name-v8-0-c9b030332254@igalia.com?part=3D4
