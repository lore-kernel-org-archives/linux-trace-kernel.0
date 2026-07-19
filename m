Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B92DA75A;
	Sun, 19 Jul 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784455467; cv=none; b=FqvroJHS/tlsXJWsGY3ApYTmakrwwh552iA2u6MsHbQIBGb27leQ123Rs3k2r/MhbYYS0bPW1lCeAPN4QLA5vsHpqE5q2gNmD1paWX3Qjf5RyKAdZGFM5DFaHtQ4xO+ZxFDLIRpHocINiME27abaH/ZibfQi/kaRiwPVKxcoscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784455467; c=relaxed/simple;
	bh=80Iv1r7mNqJ5Y06dstMEqMA0r1l2WeRNNAMkzFtfKvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZR+OnYN4IjfvVEOImSXdauvciEEVsPERayt8AJuP6G0o9/kCfcnuK2VmNshnBepxjH1EKfRNhhf86bvNazW6d43ZsQWe4C6qvdAOuBzO1LYrYXP02+W95lZOamkOwgLdc/dF+NwwImN8z/vhZUEE/CHuS/HNG/IZ+OudAiqSog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from martin by akranes.kaiser.cx with local (Exim 4.98.2)
	(envelope-from <martin@akranes.kaiser.cx>)
	id 1wlONg-00000001eoI-2yeJ;
	Sun, 19 Jul 2026 12:04:20 +0200
Date: Sun, 19 Jul 2026 12:04:20 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [tracing]  206b25c090:
 kselftests-bpf.ftrace.ftracetest-ktap.Generic_dynamic_event_-_add/remove_eprobe_events.fail
Message-ID: <alyhJP3w_cZCmLLu@akranes.kaiser.cx>
References: <202607151010.b68428e1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607151010.b68428e1-lkp@intel.com>
Sender: "Martin Kaiser,,," <martin@akranes.kaiser.cx>

Hi,

Thus wrote kernel test robot (oliver.sang@intel.com):

> kernel test robot noticed "kselftests-bpf.ftrace.ftracetest-ktap.Generic_dynamic_event_-_add/remove_eprobe_events.fail" on:

> commit: 206b25c09080cc20fd4c2bea12d59df4b7ba2121 ("tracing: eprobe: read the complete FILTER_PTR_STRING pointer")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

> [test failed on linus/master      3b029c035b34bbc693405ddf759f0e9b920c27f1]
> [test failed on linux-next/master 49362394dad7df66c274c867a271394c10ca2bb8]

> in testcase: kselftests-bpf
> version: 
> with following parameters:

> 	group: ftrace

> config: x86_64-rhel-9.4-bpf
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

> (please refer to attached dmesg/kmsg for entire log/backtrace)

[...]

> # # ++ echo 0
> # # +++ grep '^ *ls-' trace
> # # +++ grep file=
> # # ++ content='              ls-5520    [006] ...1.   335.361454: eprobe_open: (syscalls.sys_enter_openat) file="/usr/libexec/coreutils/libstdbuf.so"
> # # ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libselinux.so.1"
> # # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libselinux.so.1"
[...]
> # # ls-5520    [006] ...1.   335.364212: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.UTF-8/LC_NUMERIC"
> # # ls-5520    [006] ...1.   335.364239: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.utf8/LC_NUMERIC"
> # # ls-5520    [006] ...1.   335.364265: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.UTF-8/LC_CTYPE"
> # # ls-5520    [006] ...1.   335.364292: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.utf8/LC_CTYPE"
> # # ls-5520    [006] ...1.   335.364341: eprobe_open: (syscalls.sys_enter_openat) file="."'
> # # +++ grep '^ *ls-' trace
> # # +++ grep file=
> # # +++ grep -v -e '"/' -e '"."' -e '(fault)'
> # # ++ nocontent='              ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libselinux.so.1"
> # # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libselinux.so.1"
> # # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_openat) file="libselinux.so.1"
> # # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libcap.so.2"
> # # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libcap.so.2"
> # # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_openat) file="libcap.so.2"
> # # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libc.so.6"
> # # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libc.so.6"
> # # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_openat) file="libc.so.6"
> # # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
> # # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
> # # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_openat) file="libpcre2-8.so.0"'

This list must be empty for the test to pass. Files with absolute paths and
pointers that can't be dereferenced "(fault)" are filtered.

My patch fixed the dereferencing, some of the faults are now readable
filenames. And for some of those, openat used a relative path.

IMHO, the test is not correct, relative paths should be allowed. (In fact, any
name of an existing file should be ok.)

I'll think about this a bit more and submit a patch to fix the test.

Thanks,
Martin
