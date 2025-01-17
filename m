Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D71F754C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103944; cv=none; b=H4FOiYwgX2RwzLq2oHnl5DJLomQnU1Q76UeJFinRpQUlQ/sxBupDnlTTCCXfU77AVSfGQwehFuYeeR9IM1MAWaEqpYd2ar4zgeqtsk4hf55y9ykMN1JEMIItKQ+AA+DoUPgV9hPa3bK6esy25BNe59SpM11OLXIBzyDI9LYbXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103944; c=relaxed/simple;
	bh=pYAZbf63khUW9vSXQLaTShtcr+0PL0ShqvlGjf3Lrn8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZqGuX91jxMHnBL9Hntt3OF1/hrDJOB8NxcJ8/cS3o3L42ROqnerhW9mD697JGorE/QhnhPD8COZAQRGlZy7Tx9u/wMkBRZWnbJ4KLMtLVKh6hznf2WpLwwHnqB66+o9TZGA28Pm0VtpGaXze16P7r9jni1zFVIP92EcZmE4qL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoGyJW5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoGyJW5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4918C4CEDD;
	Fri, 17 Jan 2025 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737103943;
	bh=pYAZbf63khUW9vSXQLaTShtcr+0PL0ShqvlGjf3Lrn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OoGyJW5mhCt52wMkeVqNJbJbbBFj1owuLFwIpOwUBSU8f5bzftCbB/Kda1wrktHNk
	 hkWkG/DYPM6ExOC8UZJI+hzwSKPDkNJsl+UC8RkmEd1V1nfeew5gNM1dbUj/1Stzw4
	 n2TW1G2RNlwQkH9q7v/2GlcEpvcY++Vt3BRUBjUKqNK0HzAafwaq10qZI2hw8iic8u
	 EUUJTdWqEY5iYf/kpw/Dn+4V3yS8ZafhmfBEktAjbWgsg2sQ51cuUnILuP8g1ZLRfZ
	 u+JM7FB11bjbjNs/RYIekdnfkDgjFNwiwmXk45/JeVEnAUIhd8cXfc06J4nyKyq4vx
	 Rsr6wVpBzjo6g==
Date: Fri, 17 Jan 2025 17:52:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: kprobe not always triggering
Message-Id: <20250117175220.38e370942045bc52db1e8b7e@kernel.org>
In-Reply-To: <35dbe779-e7c1-48ef-8e76-86092d77a199@flourine.local>
References: <f91a64bf-c5cb-4d36-b50b-67cdcdccdccc@flourine.local>
	<20250115101715.12c6cce3@gandalf.local.home>
	<e5d64ac8-5a30-4196-a5e5-b3d2743356b1@flourine.local>
	<20250116084818.2160d4faf29cf34c9b6e612f@kernel.org>
	<35dbe779-e7c1-48ef-8e76-86092d77a199@flourine.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 13:04:18 +0100
Daniel Wagner <dwagner@suse.de> wrote:

> On Thu, Jan 16, 2025 at 08:48:18AM +0900, Masami Hiramatsu wrote:
> > Have you tried to use `perf probe`? Even if it is inlined, you can find them
> > by
> > 
> >  perf probe -a nvme_change_ctrl_state new_state
> 
> I had to build my own perf, as the version from the distro didn't like
> my kernel and just crashed. Thus I added a bunch libraries to my build
> system. The resulting perf installed the probe and the missing events
> show up:
> 
>           <idle>-0       [000] ..s1.   245.406139: nvme_complete_rq: nvme1: qid=0, cmdid=36865, res=0x0, retries=0, flags=0x0, status=0x371
>           <idle>-0       [000] .Ns1.   245.407192: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x2
>    kworker/u33:0-65      [000] .N...   245.407258: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x2
>    kworker/u33:1-78      [000] .....   245.421290: nvme_change_ctrl_state: (nvme_change_ctrl_state+0x0/0x180 [nvme_core]) new_state=0x3
> 

Nice.

> I double checked my previous setup with kprobes and now the missing
> events show up as well. It looks like my setup changes makes clang to
> not inline this function anymore, or there is no additional debug info
> available?

Hmm, I don't think (don't hope) the clang change the optimization
silently if debuginfo is enabled. This is a kind of heisenbug :(

> 
> > But perhaps, some of them are inlined with constant numbers (maybe you can
> > find them as nvme_change_ctrl_state.constprop.XXX in kallsyms)
> 
> # cat /proc/kallsyms | grep nvme_change_ctrl_state
> ffffffffc03dc04d r __kstrtab_nvme_change_ctrl_state     [nvme_core]
> ffffffffc03dc064 r __kstrtabns_nvme_change_ctrl_state   [nvme_core]
> ffffffffc03ca130 r __ksymtab_nvme_change_ctrl_state     [nvme_core]
> ffffffffc0405de0 t __pfx_nvme_change_ctrl_state [nvme_core]
> ffffffffc0405df0 t nvme_change_ctrl_state       [nvme_core]
> 
> This is with the new kernel, so after installing the libraries for the
> perf build.

IIRC, constprop.XXX is gcc's suffix, clang has different one.

> 
> > If my guess is correct, it is not inlined but the constant propagation
> > optimization[1] has been done by the compiler.
> > 
> > [1] https://en.wikipedia.org/wiki/Constant_folding#Constant_propagation
> > 
> > IIRC, commit 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
> > should support this case.
> 
> Okay, this commit is already in (v5.4), so it was always in.
> 
> Anyway, I can't reproduce anymore.

Feel free to notice if you see similar issue.

Thank you,

> 
> Daniel


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
