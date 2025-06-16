Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D63A8F7;
	Mon, 16 Jun 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059424; cv=none; b=loDxkU33anTpwya6KWzVgMvwo55WRE8T9MtCzPd9u36n5+auX/Knsf9vs7BOPcLHoGzZxgCE26/bGIFxjXEB3CXXBonNW2isyvMXZdu9VYmcsbmkRYTSzoYBM2GF1jp4YjgTZUQpylw+X8opxzx6IWghuK5vwANr1W5vRw53UtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059424; c=relaxed/simple;
	bh=wayYiE/MmsxT57Q8rzTSixOQMtuCZ3T0/Ht4feIVuHM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=stcQTdG0XYj9I1NY0mQPD6rNtU0AmvfSvZYCKBf5OpYYFRdVv8+0ryhu9SlyDgDzHqkNEte59vldxJUwYOt+rvQpavxTZFY8rbu9W7o5z/0NXeh/mX2OjYv0pHNc9xCMw3dFXjzPfkAqnUJiUqq+oqiwWRMSpHxPZxXlK4Ymm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7cFBMoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7cFBMoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFCBC4CEEA;
	Mon, 16 Jun 2025 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750059423;
	bh=wayYiE/MmsxT57Q8rzTSixOQMtuCZ3T0/Ht4feIVuHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c7cFBMoPgR99ik7q35EAkOdGMmVKf5FMVoXMAju0LbSJgFxYmqvRZ9b6T5YlqezpK
	 W/tIBdO88vLMDgpk4hQw/SEyUIGfqm5GLuqZlN8xvs10b2Dk05eY4u4XeWckiaQ+8B
	 bVYuoD9lufGcrJAs/jsd0A2GitEkrCeROlDPW4c/rUq1YoGXkFACtx5IX2xas24vbi
	 s6LJl8btQRFzSRtClHcrPr0lGBwF3EreQuTijkcI38zX0sgm6qSYTsE1IsGYd0tUyl
	 TOGyWUZ+Ma8DP+ZE4C2Db3sUkk9pxdCtUR9qaduJ1u1eivI7XLbC+lLSgdtOWI1zzO
	 qJvJz0529f3EA==
Date: Mon, 16 Jun 2025 16:36:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Steven Rostedt
 <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd
 Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Anders
 Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250616163659.d372cf60ee0c476168cd448e@kernel.org>
In-Reply-To: <20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
	<20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
	<CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
	<20250610105337.68df01f4@gandalf.local.home>
	<CA+G9fYv+1FPMD8e1ZadA3nLcfSRDAWvPRW-A3bGrV0y1VP2zLQ@mail.gmail.com>
	<20250613172753.3479f786d40c29ec7b51df0a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 17:27:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > Run 3:
> > - https://lkft.validation.linaro.org/scheduler/job/8311139#L1703
> 
> This is the same as Run 2, and clearer.
> 
> In do_int3(), if we hit a disappeared int3, it is evacuated after
> all. This means kprobe_int3_handler() is hit, and call get_kprobe()
> to find the corresponding kprobes. But,
> 
> ffffffff8150a040 <get_kprobe>:
> ffffffff8150a040:       f3 0f 1e fa             endbr64
> ffffffff8150a044:       e8 07 b0 e2 ff          call   ffffffff81335050 <__fentry__>
> ffffffff8150a049:       48 b8 eb 83 b5 80 46    movabs $0x61c8864680b583eb,%rax
> ffffffff8150a050:       86 c8 61 
> 
> It hits the ftrace and hooked by fgraph, and eventually returns
> via ftrace_return_to_handler()
> 
> [  137.338572] RIP: 0010:ftrace_return_to_handler+0xd5/0x1f0
> [  137.338577] Code: 00 89 55 c8 48 85 ff 74 07 4c 89 b7 80 00 00 00 49 8b 94 24 38 0b 00 00 48 98 48 8b 04 c2 48 c1 e8 0c 0f b7 c0 48 89 45 b8 cc <90> 48 8b 05 e3 ac c2 01 48 63 80 f8 00 00 00 48 0f a3 45 b8 72 39
> 
> This address is;
> 
> $ eu-addr2line -fi -e vmlinux ftrace_return_to_handler+0xd5
> arch_static_branch inlined at /builds/linux/kernel/trace/fgraph.c:839:6 in ftrace_return_to_handler
> /builds/linux/arch/x86/include/asm/jump_label.h:36:2
> __ftrace_return_to_handler
> /builds/linux/kernel/trace/fgraph.c:839:6
> ftrace_return_to_handler
> /builds/linux/kernel/trace/fgraph.c:874:9
> 
> It is for static_branch, which also uses a text_poke.
> 
> -----
> #ifdef CONFIG_HAVE_STATIC_CALL
> 	if (static_branch_likely(&fgraph_do_direct)) { <======
> 		if (test_bit(fgraph_direct_gops->idx, &bitmap))
> 			static_call(fgraph_retfunc)(&trace, fgraph_direct_gops, fregs);
> -----
> 
> But actually, this static_branch modifies the kernel code with
> smp_text_poke_single() (note, this is a wrapper of smp_text_poke_batch).
> 
> And this is MISSED by the smp_text_poke_int3_handler() again and
> go through the kprobes, and hit ftrace (fgraph) and caused this
> loop.
> 
> So the fundamental issue is that smp_text_poke_batch missed
> handling INT3. 
> 
> I guess some text_poke user do not get text_mutex?

Hmm, I've checked the smp_text_poke_* users, but it seems no problem.
Basically, those smp_text_poke* user locks text_mutex, and another
suspicious ftrace_start_up is also set under ftrace_lock.
ftrace_arch_code_modify_post_process() is also paired with
ftrace_arch_code_modify_prepare() and under ftrace_lock.


smp_text_poke_single()
  ftrace_mod_jmp()
    ftrace_enable_ftrace_graph_caller()
      ftrace_modify_all_code() -> see [*1]
    ftrace_disable_ftrace_graph_caller()
      ftrace_modify_all_code() -> see [*1]
  ftrace_update_ftrace_func()
    update_ftrace_func()
      ftrace_modify_all_code() -> see [*1]
      
smp_text_poke_batch_add()
  arch_jump_label_transform_queue() -> lock text_mutex
  ftrace_replace_code()
    ftrace_modify_all_code() <------[*1]
      arch_ftrace_update_code()
        ftrace_run_update_code() -> lock text_mutex
  ftrace_modify_code_direct() (only if ftrace_poke_late != 0)
    ftrace_make_nop()
      __ftrace_replace_code() <----[*3]
        ftrace_replace_code(weak) --> Not used on x86 (overridden)
          ftrace_modify_all_code()  <--- [*1]
            arch_ftrace_update_code() <---- [*4]
              ftrace_run_update_code()-> lock text_mutex
            __ftrace_modify_code()
              ftrace_run_stop_machine()
                arch_ftrace_update_code(weak) -> overridden on x86 see [*4]
        ftrace_module_enable() -> lock text_mutex (see below)
      ftrace_init_nop()
        ftrace_nop_initialize()
          ftrace_update_code()
            ftrace_module_enable() -> lock text_mutex
              prepare_coming_module()
                load_modole()
            ftrace_process_locs() -> lock ftrace_lock.
              ftrace_init() -> OK (ftrace_poke_late == 0 because its early)
              ftrace_module_init() -> OK (ftrace_poke_late == 0 because module is not live)
                load_module()
    ftrace_make_call()
      __ftrace_replace_code() -> see [*3]


smp_text_poke_batch_finish()
  arch_jump_label_transform_apply() -> lock text_mutex
  ftrace_arch_code_modify_post_process() -> must be OK because this unlock text_mutex
    ftrace_run_update_code()-> paired with ftrace_arch_code_modify_prepare()
    ftrace_module_enable()-> paired with ftrace_arch_code_modify_prepare() (depends on ftrace_lock && ftrace_start_up)
  ftrace_replace_code()
    ftrace_modify_all_code() -> see [*1]


ftrace_start_up <does variable set under ftrace_lock ?>
  ftrace_startup()
    ftrace_startup_subops()
      register_ftrace_graph() -> lock ftrace_lock
    register_ftrace_function_probe() -> lock ftrace_lock
    register_ftrace_function_nolock() -> lock ftrace_lock
  ftrace_shutdown()
    unregister_ftrace_function() -> lock ftrace_lock


ftrace_arch_code_modify_prepare() < this set ftrace_poke_late = 1>
  ftrace_module_enable() -> lock ftrace_lock.
  ftrace_run_update_code()
    ftrace_run_modify_code()
      ftrace_ops_update_code()
        __ftrace_hash_move_and_update_ops()
          ftrace_update_ops()
            ftrace_startup_subops()
              register_ftrace_graph()  -> lock ftrace_lock
            ftrace_shutdown_subops()
              unregister_ftrace_graph() -> lock ftrace_lock
            ftrace_hash_move_and_update_subops()
              ftrace_hash_move_and_update_ops() -> [*2]
          ftrace_hash_move_and_update_ops()  <-- [*2]
            process_mod_list() -> lock ftrace_lock
            register_ftrace_function_probe() -> lock ftrace_lock
            unregister_ftrace_function_probe_func() -> lock ftrace_lock
            ftrace_set_hash() -> lock ftrace_lock
            ftrace_regex_release() -> lock ftrace_lock
      unregister_ftrace_function_probe_func() -> lock ftrace_lock
    ftrace_startup_enable()
      ftrace_startup_all()
        ftrace_pid_reset() -> lock ftrace_lock
        pid_write() -> lock ftrace_lock
      ftrace_startup()
        ftrace_startup_subops()
          register_ftrace_graph() -> lock ftrace_lock
        register_ftrace_function_probe() -> lock ftrace_lock
        register_ftrace_function_nolock() -> lock ftrace_lock
      ftrace_startup_sysctl()
        ftrace_enable_sysctl() -> lock ftrace_lock
    ftrace_shutdown()
      ftrace_shutdown_subops()
        unregister_ftrace_graph() -> lock ftrace_lock
      unregister_ftrace_function_probe_func() -> lock ftrace_lock
      ftrace_destroy_filter_files() -> lock ftrace_lock
      unregister_ftrace_function() -> lock ftrace_lock
    ftrace_shutdown_sysctl()
      ftrace_enable_sysctl() -> lock ftrace_lock


Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
