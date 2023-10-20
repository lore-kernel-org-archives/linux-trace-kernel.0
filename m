Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA619BA6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r63mR0I9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3690C433C8;
	Fri, 20 Oct 2023 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697803962;
	bh=5RyJPTQh2SZ9yQhKE8MPQtknC50z+6MymORVw2G/tZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r63mR0I9MvGZJdXh3ZuuXqIsWwTzgqiZZwKABXiI3Iv724kpIbJlcKNraVT0rjQ2o
	 XG0oG99KBTalRGofHExDGZVgU3t+aCU2zW8mVE0PhzYGSRIWKD6r4DxM9bYc1YLaXE
	 uWc7Iy83VSM26WMc+r4slC2AO03EAvjKHuDe/kz7rw6GMAv5pd+od6hBFixlatm7Mv
	 rTEeEeaKhT6Ozwsj76lPYnDkBsssMSMAgcCZkJdINWhLdX2dZHNBPf/KGI3JcMdpHb
	 gigUdvi5V0y7f2cAHIjCiGUqN94nDTB6GTuuQIXZXMEowyaLB/XDgKu7wSFYLgOiru
	 4Rywv/sbm64rw==
Date: Fri, 20 Oct 2023 21:12:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [PATCH v6 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-Id: <20231020211239.85855928dedb0f5128143f2a@kernel.org>
In-Reply-To: <20231020104250.9537-1-flaniel@linux.microsoft.com>
References: <20231020104250.9537-1-flaniel@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Thanks for update the series. The series looks good to me.
Let me pick those in probes/fixes.

Thank you!

On Fri, 20 Oct 2023 13:42:48 +0300
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> Hi.
> 
> 
> In the kernel source code, it exists different functions which share the same
> name but which have, of course, different addresses as they can be defined in
> different modules:
> # Kernel was compiled with CONFIG_NTFS_FS and CONFIG_NTFS3_FS as built-in.
> root@vm-amd64:~# grep ntfs_file_write_iter /proc/kallsyms
> ffffffff814ce3c0 t __pfx_ntfs_file_write_iter
> ffffffff814ce3d0 t ntfs_file_write_iter
> ffffffff814fc8a0 t __pfx_ntfs_file_write_iter
> ffffffff814fc8b0 t ntfs_file_write_iter
> This can be source of troubles when you create a PMU kprobe for such a function,
> as it will only install one for the first address (e.g. 0xffffffff814ce3d0 in
> the above).
> This could lead to some troubles were BPF based tools does not report any event
> because the second function is not called:
> root@vm-amd64:/mnt# mount | grep /mnt
> /foo.img on /mnt type ntfs3 (rw,relatime,uid=0,gid=0,iocharset=utf8)
> # ig is a tool which installs a PMU kprobe on ntfs_file_write_iter().
> root@vm-amd64:/mnt# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
> [1] 207
> root@vm-amd64:/mnt# dd if=./foo of=./bar count=3
> 3+0 records in
> 3+0 records out
> 1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00543323 s, 283 kB/s
> root@vm-amd64:/mnt# fg
> ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo
> ^Croot@vm-amd64:/mnt# more /tmp/foo
> RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN… PID              COMM
>   T      BYTES     OFFSET        LAT FILE
>                                                 214              dd
>   R        512          0        766 foo
>                                                 214              dd
>   R        512        512          9 foo
>                                                 214              dd
> As you can see in the above, only read events are reported and no write because
> the kprobe is installed for the old ntfs_file_write_iter() and not the ntfs3
> one.
> The same behavior occurs with sysfs kprobe:
> root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_iter' > /sys/kernel/tracing/kprobe_events
> root@vm-amd64:/# cat /sys/kernel/tracing/kprobe_events
> p:probe/ntfs_file_write_iter ntfs_file_write_iter
> root@vm-amd64:/# mount | grep /mnt
> /foo.img on /mnt type ntfs3 (rw,relatime,uid=0,gid=0,iocharset=utf8)
> root@vm-amd64:/# perf record -e probe:ntfs_file_write_iter &
> [1] 210
> root@vm-amd64:/# cd /mnt/
> root@vm-amd64:/mnt# dd if=./foo of=./bar count=3
> 3+0 records in
> 3+0 records out
> 1536 bytes (1.5 kB, 1.5 KiB) copied, 0.00234793 s, 654 kB/s
> root@vm-amd64:/mnt# cd -
> /
> root@vm-amd64:/# fg
> perf record -e probe:ntfs_file_write_iter
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.056 MB perf.data ]
> 
> root@vm-amd64:/# perf report
> Error:
> The perf.data data has no samples!
> # To display the perf.data header info, please use --header/--header-only optio>
> #
> 
> In this contribution, I modified the functions creating sysfs and PMU kprobes to
> test if the function name given as argument matches several symbols.
> In this case, these functions return EADDRNOTAVAIL to indicate the user to use
> addr and offs to remove this ambiguity.
> So, when the above BPF tool is run, the following error message is printed:
> root@vm-amd64:~# ig trace fsslower -m 0 -f ntfs3 --host &> /tmp/foo &
> [1] 228
> root@vm-amd64:~# more /tmp/foo
> RUNTIME.CONTAINERNAME          RUNTIME.CONTAIN… PID              COMM
>   T      BYTES     OFFSET        LAT FILE
> Error: running gadget: running gadget: installing tracer: attaching kprobe: crea
> ting perf_kprobe PMU (arch-specific fallback for "ntfs_file_write_iter"): token
> ntfs_file_write_iter: opening perf event: cannot assign requested address
> And the same with sysfs kprobe:
> root@vm-amd64:/# echo 'p:probe/ntfs_file_write_iter ntfs_file_write_iter' > /sys/kernel/tracing/kprobe_events
> -bash: echo: write error: Cannot assign requested address
> Note that, this does not influence perf as it installs kprobes as offset on
> _text:
> root@vm-amd64:/# perf probe --add ntfs_file_write_iter
> Added new events:
>   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
>   probe:ntfs_file_write_iter (on ntfs_file_write_iter)
> ...
> root@vm-amd64:/# cat /sys/kernel/tracing/kprobe_events
> p:probe/ntfs_file_write_iter _text+5039088
> p:probe/ntfs_file_write_iter _text+5228752
> 
> Note that, this contribution is the conclusion of a previous RFC which intended
> to install a PMU kprobe for all matching symbols [1, 2].
> 
> If you see any way to improve this contribution, please share your feedback.
> 
> Changes since:
>  v1:
>   * Use EADDRNOTAVAIL instead of adding a new error code.
>   * Correct also this behavior for sysfs kprobe.
>  v2:
>   * Count the number of symbols corresponding to function name and return
>   EADDRNOTAVAIL if higher than 1.
>   * Return ENOENT if above count is 0, as it would be returned later by while
>   registering the kprobe.
>  v3:
>   * Check symbol does not contain ':' before testing its uniqueness.
>   * Add a selftest to check this is not possible to install a kprobe for a non
>   unique symbol.
>  v5:
>   * No changes, just add linux-stable as recipient.
>  v6:
>   * Rephrase commit message.
>   * Add "Cc:" to stable.
> 
> Francis Laniel (2):
>   tracing/kprobes: Return EADDRNOTAVAIL when func matches several
>     symbols
>   selftests/ftrace: Add new test case which checks non unique symbol
> 
>  kernel/trace/trace_kprobe.c                   | 63 +++++++++++++++++++
>  kernel/trace/trace_probe.h                    |  1 +
>  .../test.d/kprobe/kprobe_non_uniq_symbol.tc   | 13 ++++
>  3 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> 
> Best regards and thank you in advance.
> ---
> [1]: https://lore.kernel.org/lkml/20230816163517.112518-1-flaniel@linux.microsoft.com/
> [2]: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
> --
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
