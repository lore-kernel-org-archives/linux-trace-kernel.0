Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6E3C65E0
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283673; cv=pass; b=RRCwUgOgoRjd0gsXPKuUjWKzJqFBHDuH+bVNmGwLEX659la8+d+MI4khRdtkIPBJfd037+r3t3+jNmr9mlwijeN7SFg0Aokee1A58shWM5bkDdQCwVMFZ3mVqj56JciCYm36FImE10yka8kaeB/IFHHcHMSlRIBP4hKyy5ne9DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283673; c=relaxed/simple;
	bh=s8jhCDS6DypoAkPUhEeNBzWAxC4U8w7kKhE16KEqpZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtbpwmpWlEvR9aNSpP2o+cwp6Q8w6X38yRUFyECLM3gGFCrk9RWTJpbjRKzVPJNwc1irW6NEYCoRQPk+YnfsWFb75pUjOKSGuacVFLOHo2wT+rMMSsigFhm42WqouLB9BD6OoK1o/x+iOaxuOhkK8tTux49o3MbiDjVn1IWwWOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP5lxNDp; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP5lxNDp"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d46e4cdcdso7810457b3.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789283670; cv=none;
        d=google.com; s=arc-20260327;
        b=m6Q0QZSOajkP1pRXcFSEk9k22nPpdKsiHEhrWUFUALNCwqTYDBuXBlWHq4a3LzMPbb
         sFrLUaIUlOMEFYm1fRRp7aIHFBrvr2xVB8IyWuojH4hU9UBMlTYmUSu9HMdRFI2TenGn
         FUCCazivXLoHxgvXe92ZC7w13QEFKPmr8I6Cm9qbsDAfnY1vgx20CVK0JFcNE4tNItNm
         bXupUpUBIlz/9BP5PjBrx+XtzjVedQ3bUnhaxCgkj13mrXr+gwhQ7F9tpAfhAGKw4apI
         fAsGHlE0myU0VdgSaCM4wl+ySMMsU0zczEzUEj7NaYG/0DJgibUqSpvKMY8MbTqUAEr+
         bJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hs7PCl8ZdlMvhgHWX0PHVYVp8DWBXv1h24H33tOaVTY=;
        fh=T426G7kYTnZ5HWeZONRm1RSmR+hCfhQiLOrz1rZXWxY=;
        b=GhJNS4XoYRx1TNysoQWQqfcYESvw+NIPEEMYDa0a0C0j+TTvOBT5BS+rW/YSQ41Za6
         LJgCf7oX+TRCOhP1uKdP7tkg266UwnWKJnasm2dmPoHeqZedH8b3lXIwmKwqilntKpkA
         94e69ZYmw0AZTVYimCImeFDJez4Liky6YEQ3FG9icSzXPmuLyRqOzWxlN78EPLim93v3
         6lWRtVXzpplgkxrEP6fT9tzEse5fww79uhPP6R1YLtYuKWyeVes8SgJPE7v8/RiItD5I
         4MsqcpE84dhhqH9JzMzbYj7ASIrupVWi0LA+g3BT3ydZ0zylDVSMOrwujwnX6eihEc8U
         1oEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789283670; x=1789888470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hs7PCl8ZdlMvhgHWX0PHVYVp8DWBXv1h24H33tOaVTY=;
        b=OP5lxNDpd8DMWxUVrNyGUdFp9IM5OJLWD99Cz/2yE9N4rCQ3pO6NFX4vmlIotvsDxe
         Xgx4gJZG140abj3nhVTKL5XmY97AOarvI5vmIoK9xcDOmNHL3PjoLy9XO0PeBJH0RPtn
         Lflhlj9C3tl3qjhz0PHGpnPL1XxiJRO9C4jcJgCI8K137NIiDugHpusA7SOQ7sBNTUvD
         VRi/4gPWQkJnqWTEYQy8UomoXx7/lGkhKilnk8NhJYl3vQstQatMyQHfHIYtZJ52JXyf
         VoiIKsPZbJoQPaRBxh7wuoMS4IGiTeaQiAPEaE6foL+k2Fk/2dqAQuvKCP1vb8cjUBhc
         pEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789283670; x=1789888470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hs7PCl8ZdlMvhgHWX0PHVYVp8DWBXv1h24H33tOaVTY=;
        b=j9IIhwilC4wv0lLN77cx2cWx7SpuxuTnmSTvfJZjMKvPBIb8MMiF9h70n7/CdxH/+V
         CKYIqrlTcafSqyZ/X7MpMwnD8YnNvIEwDGaNtqseGUY2E6vM3APdYn6IxJ1KBZ5HANUb
         qmY+R/M7u+GIiANday6YO+q+iARMcLX+CbjDKaBf9C6MPmPckXrSNEuRegJCAkqMfq1w
         xWFy4JNaYLnQTFM44r/cqUUJPtcRJU762etJBVHaA9uS9rMpzXFxF++QNWAC3e/eE6sw
         DMV8pInN09svmsd+3mN/e0e3ZAJjuH1MpUvPLgmS9zLe+EksHR+UCdzfIWEB1jRtYwWo
         LM1g==
X-Forwarded-Encrypted: i=1; AKwUvBwuVky+ZHqYa9BMlU9OvytiZlYgqJjIe8hWtLKIDA+nc7b7zPN1gf0Mj25a5Wcqao9DINISGqIs0laGFEDuA3tbQS0=@vger.kernel.org
X-Gm-Message-State: AFuF++kThODk2t4yeU9P19A0CqMTZxR9tpTbVGVM3xbpjl+WKVCGIsB0
	nv5zTOmR7SZM0+UIZDZ6zF1Iqbf/nRyX6VQays2P//LeMmDqEt4P5ZWXaQjvVVCTQa35Q9bPZ7Z
	FVURh4epu8Kzjf5+wH3BrSdITPVXAiGo=
X-Gm-Gg: AYBFou0lIqcX8ij5r3xGBxxCnvOi3Zg5sZCSOfkATjDXG46Uxlit53TnvzM3OCqxvVS
	mG+Rhg2lz7rBSzQAt9qYK39ZOe0UFxxoVuBDho5YXULem1Q65cS0ie2sNMMjUE4zebV5210mD+W
	J/VR9wd7Jczlzfo2+4NhnC2Jb5MLQjjX8Z2J/WhLk7hxDwekfn7PgAqLefPh6xAz3jtWGthx0ok
	roZOQL46DxoCXJrgRZf+guuausLr2vL8wkn9grHqETOgwVFioKOOK3rI8sMidZCMcx6F5ssbUcF
	p8Hsbd/cxfanKtSriYJyWOjrOJ43M+Cktb8siXFbWkU/2QFKwsvihhI6iBvZfz4/oj0qm+YyE28
	gub8usTvek2U9
X-Received: by 2002:a05:690c:e3cd:b0:87f:a9c6:470b with SMTP id
 00721157ae682-884ae7afba1mr42342687b3.2.1789283670033; Sun, 13 Sep 2026
 00:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
In-Reply-To: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 13 Sep 2026 15:13:54 +0800
X-Gm-Features: AcwNN1UspbNtkItJTCvCtD3l6jewbKb17CHUZA9TTmeWwkQ5AKSxYWpYJfiUJCk
Message-ID: <CALOAHbAE1Lq=EZE=HpNJS3dxm_sVDmjWxNm5m0ugerwWr9RN6g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/15] rcu-tasks: let preemption outside
 trampolines be a quiescent state
To: Josef Bacik <josef@toxicpanda.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 2:54=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> v1: https://lore.kernel.org/all/20260910-b4-rcu-tasks-preempt-qs-v1-0-d44=
69f4cc101@toxicpanda.com/
>
> v1->v2:
> - Only walk the kprobe hash while the optimizer is actually waiting (Sash=
iko).
> - Re-check the kprobe jump window at every QS decision instead of once at
>   preemption time (AI review).
> - Updated Documentation/RCU for the new rule (AI review).
> - Added 14/15 and 15/15 to address Paul's comments.
> - Added a comment in trace_recursion.h per Steve.
> - No change for the arm64 ftrace_static_tramp_end report, the Kconfig
>   dependency already covers it (Sashiko).
> - Re-ran the x86-64 QEMU tests, still 0.2-0.3s and clean.
>
> --- Original email ---
>
> Tasks RCU only treats a voluntary context switch, usermode or idle as a
> quiescent state, because a preempted task may be sitting in a trampoline
> that is about to be freed. That was a fine trade when PREEMPT_NONE
> servers compiled Tasks RCU away and PREEMPT desktops rarely ran
> long-lived in-kernel loops. PREEMPT_LAZY changes both halves at once:
> Tasks RCU is now real on server configs, and cond_resched() is a no-op,
> so a CPU-bound kthread or kworker only ever loses the CPU by being
> preempted, which is exactly the event Tasks RCU refuses to count.
>
> The way this showed up for us was a cgroup writeback worker draining a
> very large cgwb for around eleven minutes on an arm64 box. Nothing wrong
> with that on its own, but a BPF program detach on another CPU went
> bpf_trampoline_update() -> ftrace_shutdown() -> synchronize_rcu_tasks()
> while holding trampoline_mutex, forty-odd tasks piled up behind the
> mutex, and the hung task detector panicked the machine. The kprobe jump
> optimizer is worse in principle: it does synchronize_rcu_tasks() under
> kprobe_mutex, text_mutex and cpus_read_lock(), so one long-running
> kthread can stall static key updates and CPU hotplug for its whole run.
> The current answer is to find each such loop and add
> cond_resched_tasks_rcu_qs() to it, which is the kind of annotation
> PREEMPT_LAZY was supposed to let us stop writing.

Hello Josef,

Thanks for the great work!

We've run into exactly the same issue on our production servers
running the 6.18.y stable kernel:

[   84.393333] INFO: task bpf-thp:10274 blocked for more than 28 seconds.
[   84.393880]       Not tainted 6.18.44-3 #3.infra
[   84.394214] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[   84.394759] task:bpf-thp      state:D stack:0     pid:10274
tgid:10274 ppid:10266  task_flags:0x400100 flags:0x00080001
[   84.394764] Call Trace:
[   84.394765]  <TASK>
[   84.394767]  __schedule+0x2c1/0x6f0
[   84.394772]  schedule+0x2a/0xb0
[   84.394775]  schedule_preempt_disabled+0x15/0x30
[   84.394777]  __mutex_lock.constprop.0+0x3a2/0x9c0
[   84.394781]  __mutex_lock_slowpath+0x13/0x20
[   84.394784]  mutex_lock+0x37/0x50
[   84.394786]  bpf_trampoline_get+0x2a/0x80
[   84.394791]  check_attach_btf_id+0x32c/0x3d0
[   84.394796]  ? __pfx_mem_cgroup_css_offline+0x10/0x10
[   84.394800]  bpf_check+0x4d6/0xf20
[   84.394804]  bpf_prog_load+0x4d7/0xb00
[   84.394808]  ? avc_has_perm+0x42/0xd0
[   84.394811]  __sys_bpf+0x729/0xd50
[   84.394815]  __x64_sys_bpf+0x1a/0x30
[   84.394816]  x64_sys_call+0x19e1/0x2190
[   84.394820]  do_syscall_64+0x67/0xe10
[   84.394823]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   84.394825] RIP: 0033:0x7f2aa7e3ee5d
[   84.394831] RSP: 002b:00007ffd2b3e2a88 EFLAGS: 00000246 ORIG_RAX:
0000000000000141
[   84.394834] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f2aa7e=
3ee5d
[   84.394835] RDX: 0000000000000094 RSI: 00007ffd2b3e2b10 RDI: 00000000000=
00005
[   84.394837] RBP: 0000000000000094 R08: 00007ffd2b3e2c30 R09: 00000000000=
00018
[   84.394838] R10: 0000000000000070 R11: 0000000000000246 R12: 00007ffd2b3=
e2b10
[   84.394840] R13: 00007ffd2b3e2b10 R14: 0000000000000005 R15: 00000000215=
804c0
[   84.394843]  </TASK>
[   84.394848] INFO: task bpf-thp:10274 is blocked on a mutex likely
owned by task kworker/1:1:80.
[   84.395463] task:kworker/1:1     state:I stack:0     pid:80
tgid:80    ppid:2      task_flags:0x4208060 flags:0x00080000
[   84.395468] Workqueue: events bpf_link_put_deferred
[   84.395474] Call Trace:
[   84.395475]  <TASK>
[   84.395477]  __schedule+0x2c1/0x6f0
[   84.395482]  schedule+0x2a/0xb0
[   84.395485]  schedule_timeout+0xea/0x100
[   84.395488]  ? trace_hardirqs_off+0x30/0x90
[   84.395492]  ? trace_hardirqs_on+0x2b/0xa0
[   84.395494]  __wait_for_common+0x94/0x1b0
[   84.395498]  ? __pfx_schedule_timeout+0x10/0x10
[   84.395502]  wait_for_completion_state+0x21/0x40
[   84.395505]  __wait_rcu_gp+0x135/0x140
[   84.395510]  ? 0xffffffffc03fed00
[   84.395514]  synchronize_rcu_tasks+0x56/0xb0
[   84.395517]  ? __pfx_call_rcu_tasks+0x10/0x10
[   84.395521]  ? __pfx_wakeme_after_rcu+0x10/0x10
[   84.395525]  ftrace_shutdown.part.0+0xd8/0x1f0
[   84.395530]  ? 0xffffffffc03fed00
[   84.395533]  unregister_ftrace_function+0x47/0x150
[   84.395537]  ? 0xffffffffc03fed00
[   84.395539]  unregister_ftrace_direct+0x49/0xc0
[   84.395542]  bpf_trampoline_update+0x448/0x4e0
[   84.395545]  ? __radix_tree_delete+0x84/0x100
[   84.395547]  bpf_trampoline_unlink_prog+0x8f/0x150
[   84.395550]  bpf_tracing_link_release+0x1a/0x50
[   84.395553]  bpf_link_free+0x57/0xd0
[   84.395555]  bpf_link_put_deferred+0x12/0x20
[   84.395558]  process_one_work+0x1b3/0x400
[   84.395561]  worker_thread+0x1a3/0x310
[   84.395564]  kthread+0x107/0x240
[   84.395567]  ? trace_hardirqs_on+0x2b/0xa0
[   84.395569]  ? __pfx_worker_thread+0x10/0x10
[   84.395571]  ? _raw_spin_unlock_irq+0x11/0x30
[   84.395574]  ? __pfx_kthread+0x10/0x10
[   84.395577]  ret_from_fork+0x10d/0x150
[   84.395580]  ? __pfx_kthread+0x10/0x10
[   84.395583]  ret_from_fork_asm+0x1a/0x30
[   84.395588]  </TASK>
[   93.199020] rcu_tasks_wait_gp: rcu_tasks grace period number 1
(since boot) is 40249 jiffies old.

We eventually traced the root cause to a problematic BPF program
looping inside do_check() in the BPF verifier, and we've worked around
it with the following change:

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20411,8 +20411,7 @@ static int do_check(struct bpf_verifier_env *env)
                if (signal_pending(current))
                        return -EAGAIN;

-               if (need_resched())
-                       cond_resched();
+               cond_resched_tasks_rcu_qs();

                if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
                        verbose(env, "\nfrom %d to %d%s:",

We've also observed random Tasks RCU stalls caused by kcompactd, but
since they don't result in hung tasks, we haven't applied a workaround
for those yet.

Hopefully we can come up with a generic solution for these Tasks RCU stalls=
.

[...]

--=20
Regards
Yafang
