Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F842A176;
	Mon, 20 Jul 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557891; cv=none; b=CJ3RXCx1v8RDrck5MWgdaePh3zQGkBo1tBu5sqMVMYpRFIjrtALsHzMsw2dwyFgRd5a2Ci5mFkIypzldqcrVxxpw6q91a5t7E2Hg8W5xjpP3VeZLDhjhmiD4OCDD/eZNIxTB1kZXmL/Lbw+Aj6L+krjsS1geDrUGtOSLPBFqj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557891; c=relaxed/simple;
	bh=GFCWIYT9f9bOWdjrsxWq4iHBiaiNRV4506LjSlA+0HE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Kl294nXByw43WpdscYfD0+f9ohmAxOxSHcCISMTOBlqvpzjsDWSdpgD1cBr33z54xB5LAe6eP+GCXU1rfqKhhg40+sTjXQN/oglqEJuN6gc0XGGrFrxJgiz//97Xod0pK1SEhDHJBp7XwnccJiard9T055mfwLGrOGC187Eb5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVwWkOBd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVwWkOBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525691F000E9;
	Mon, 20 Jul 2026 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784557890;
	bh=jDLLWP+0ok/ZfLj0UZtD/wiR+h5obVnyE5o2PvdlF3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZVwWkOBdowPukkCd/fkoJ0H3leLy1ZAZqnQqOlGtSNqj3kTURVpAEpF7NaOCMQAVN
	 whgOk4TKmXb5wa/ikH4yaDck5duw9u/B5bf93+8le7DQjZQPXJyCpyf6cM9WY4J33d
	 mVYiGQt6BVpvG4mL7ea0bzPQ9H7RVYYM0349t1hBmlSwtMq991tf1Hn01Ij19fnUg6
	 5SBlHTneWqq9r7O4u19kK2kfn4AMfP8OLPHfG2zmxicZibrUhJc/R0WH4OIjaoyUxo
	 bXdCYtf75LCg2RSODGCf43WLqT1gjMwPH/50Wf2rOZj+or1Qws1Ij76hkcO8rR6zrk
	 idk9+jqpzlEFQ==
Date: Mon, 20 Jul 2026 23:31:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [tracing]  206b25c090:
 kselftests-bpf.ftrace.ftracetest-ktap.Generic_dynamic_event_-_add/remove_eprobe_events.fail
Message-Id: <20260720233126.b344d0ace8446a99f1177165@kernel.org>
In-Reply-To: <alyhJP3w_cZCmLLu@akranes.kaiser.cx>
References: <202607151010.b68428e1-lkp@intel.com>
	<alyhJP3w_cZCmLLu@akranes.kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 12:04:20 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> Hi,
> 
> Thus wrote kernel test robot (oliver.sang@intel.com):
> 
> > kernel test robot noticed "kselftests-bpf.ftrace.ftracetest-ktap.Generic_dynamic_event_-_add/remove_eprobe_events.fail" on:
> 
> > commit: 206b25c09080cc20fd4c2bea12d59df4b7ba2121 ("tracing: eprobe: read the complete FILTER_PTR_STRING pointer")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> > [test failed on linus/master      3b029c035b34bbc693405ddf759f0e9b920c27f1]
> > [test failed on linux-next/master 49362394dad7df66c274c867a271394c10ca2bb8]
> 
> > in testcase: kselftests-bpf
> > version: 
> > with following parameters:
> 
> > 	group: ftrace
> 
> > config: x86_64-rhel-9.4-bpf
> > compiler: gcc-14
> > test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> [...]
> 
> > # # ++ echo 0
> > # # +++ grep '^ *ls-' trace
> > # # +++ grep file=
> > # # ++ content='              ls-5520    [006] ...1.   335.361454: eprobe_open: (syscalls.sys_enter_openat) file="/usr/libexec/coreutils/libstdbuf.so"
> > # # ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libselinux.so.1"
> > # # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libselinux.so.1"
> [...]
> > # # ls-5520    [006] ...1.   335.364212: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.UTF-8/LC_NUMERIC"
> > # # ls-5520    [006] ...1.   335.364239: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.utf8/LC_NUMERIC"
> > # # ls-5520    [006] ...1.   335.364265: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.UTF-8/LC_CTYPE"
> > # # ls-5520    [006] ...1.   335.364292: eprobe_open: (syscalls.sys_enter_openat) file="/usr/lib/locale/C.utf8/LC_CTYPE"
> > # # ls-5520    [006] ...1.   335.364341: eprobe_open: (syscalls.sys_enter_openat) file="."'
> > # # +++ grep '^ *ls-' trace
> > # # +++ grep file=
> > # # +++ grep -v -e '"/' -e '"."' -e '(fault)'
> > # # ++ nocontent='              ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libselinux.so.1"
> > # # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libselinux.so.1"
> > # # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_openat) file="libselinux.so.1"
> > # # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libcap.so.2"
> > # # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libcap.so.2"
> > # # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_openat) file="libcap.so.2"
> > # # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libc.so.6"
> > # # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libc.so.6"
> > # # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_openat) file="libc.so.6"
> > # # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
> > # # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_openat) file="glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
> > # # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_openat) file="libpcre2-8.so.0"'
> 
> This list must be empty for the test to pass. Files with absolute paths and
> pointers that can't be dereferenced "(fault)" are filtered.

Yeah, it seems like a test bug.

> 
> My patch fixed the dereferencing, some of the faults are now readable
> filenames. And for some of those, openat used a relative path.

Hm, in this case, we need to fix the test too.

> 
> IMHO, the test is not correct, relative paths should be allowed. (In fact, any
> name of an existing file should be ok.)
> 
> I'll think about this a bit more and submit a patch to fix the test.

Thanks for you help!

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
