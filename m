Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9F43E07D;
	Wed, 12 Aug 2026 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538996; cv=none; b=qKWUI+pOwe2ppeOa0eY3pLuJRSRGTlNjCfq2HBAIgc43iptwiWrAgMVQZo9pmfOAEWMQdsws3PPT8gN1PznisUPvVGk7TFQe6ygrIFbe8x1DbxndPP0dzZ5nwX0QZIavFFthRg3TqLBZfyTGvpwiEMtmUhhkXjuKj1HwpJlD/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538996; c=relaxed/simple;
	bh=jG+AWQOBGqD42gegMUCOoXopISM/6YA70DDfWV+aVcM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ad5Xraiw0PqMU1BwDepTnB6qNwxRkDj171hRZX+vXgMmFacYsZ41/3+iRsMknO0Nr43EbkwtxgaQUccfQGCSXApA93Pf2rKCZSMJQFLhenSQ/T6Qde5B3d6zlZiXOspwkkDzwy0676iFPQfgBrjW6RKSIfU1589YTctxMLEYTh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0i2FduT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0i2FduT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B771F000E9;
	Wed, 12 Aug 2026 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786538988;
	bh=TIrVtILA9d9y7eY4Xesk1ruLPSsT89a1u8Czn8ojO9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g0i2FduTvYjGAGuwHOxP+6JN3LSNuKVrSvMVPwP9oOfbL68iy4CCOfl3/OXU8L0A0
	 zV3kjVupoff1LoZWmJwmgrE0I02wUcO/E87//vxrFw807QCeVsaCcw3MJSAmW8kmnz
	 V334OxgjLvVu1QPgAqC9S3M3cb+abIc2Ct7+v9KozU4Cv5F8NStuF86PJArxgaJu72
	 5olTdRj1Kk1K4hCBt6NNCt8e7GpOZGz5e6r4TGmGrGzdZ1xyLVwzYdHuY1ijG8gbXI
	 5Vhma5QJ58INvz2mCPqbgTE0/lhspa6seVR6EqFOtK0V2IRQlEFJQsR9FvF0W9nc3t
	 75Ptz90nPgPmg==
Date: Wed, 12 Aug 2026 21:49:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests/ftrace: Add persistent ring buffer
 testcases
Message-Id: <20260812214945.304e444446d33e659f7433ad@kernel.org>
In-Reply-To: <20260812005732.48E1F1F000E9@smtp.kernel.org>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
	<178649544683.438282.14573895196260214231.stgit@devnote2>
	<20260812005732.48E1F1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 00:57:31 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Test enters an infinite reboot loop if the persistent trace feature fails.
> --
> 
> --- Patch [4]: [PATCH v3 4/4] selftests/ftrace: Add persistent ring buffer testcases ---
> commit d365a5483f67b1295e536e6d26fd4ee7166e27b3
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> selftests/ftrace: Add persistent ring buffer testcases
> 
> Add test cases for persistent ring buffer and backup instance across guest
> crash/reboot. These verify trace data retention in the boot_map instance and
> preservation in the backup instance on subsequent boot.
> 
> > diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh b/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
> > new file mode 100644
> > index 0000000000000..49abaf518481f
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-01-reserve-mem.sh
> > @@ -0,0 +1,28 @@
> 
> [ ... ]
> 
> > +
> > +# Check if Boot 1 marker was already written
> > +if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/null; then
> > +	# Second boot: verify persistent ring buffer content from first boot
> > +	echo "PASS: persistent-01-reserve-mem"
> > +	exit 0
> > +fi
> > +
> > +# First boot: write marker to persistent buffer and trigger kernel crash/reboot
> > +echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
> > +sync
> > +
> > +# Trigger reboot to restart into second boot
> > +echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger 2>/dev/null || true
> 
> [Severity: Medium]
> If the persistent trace feature fails to retain the BOOT1_MARKER across
> reboot, could this script enter an infinite reboot loop?
> 
> Since the test falls through to the first-boot logic when the marker is
> missing, it appears it will write the marker and reboot again indefinitely.
> This might cause the test to run until it is killed by a global timeout
> rather than failing cleanly.

Yes, that is why I made the timeout command required. Since the test uses
only initramfs, we can not save the state on it. Of course we can use
virtio-fs or something like it, but it is too much. If we can handle such
failure via timeout, it is good enough.

> 
> > +sleep 5
> > +echo "FAIL: reboot trigger failed on first boot"
> > +exit 1
> > diff --git a/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh b/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh
> > new file mode 100644
> > index 0000000000000..0b2a2f03ce4f2
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/boottime/tests/persistent-02-backup-instance.sh
> > @@ -0,0 +1,40 @@
> 
> [ ... ]
> 
> > +
> > +# Check if BOOT1_MARKER is in boot_map/trace (indicates second boot)
> > +if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/boot_map/trace" 2>/dev/null; then
> > +	# Second boot: verify BOOT1_MARKER was copied into backup/trace from Boot 1
> > +	if grep -q "BOOT1_MARKER" "$TRACEDIR/instances/backup/trace" 2>/dev/null; then
> > +		echo "PASS: persistent-02-backup-instance"
> > +		exit 0
> > +	else
> > +		echo "FAIL: BOOT1_MARKER found in boot_map/trace" \
> > +			"but missing from backup/trace on second boot"
> > +		exit 1
> > +	fi
> > +fi
> > +
> > +# First boot: write BOOT1_MARKER to boot_map and reboot via sysrq-trigger
> > +echo "BOOT1_MARKER" > "$TRACEDIR/instances/boot_map/trace_marker"
> > +sync
> > +
> > +# Trigger reboot to restart into second boot
> > +echo b > /proc/sysrq-trigger 2>/dev/null || echo c > /proc/sysrq-trigger 2>/dev/null || true
> 
> [Severity: Medium]
> Similarly, does this script also risk an infinite reboot loop if the marker
> is missing from boot_map/trace on the second boot?
> 
> It looks like it would also fall back to triggering another reboot instead
> of reporting a failure.

Ditto. It is eventually handled by timeout failure.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
