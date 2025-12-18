Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C833A719;
	Thu, 18 Dec 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080856; cv=none; b=IKkD2DS9ITxFiNlvXN1pT3p2zAN0LHQ1aQHVC8iblm7Rhz9YKmg6/OSdEjyNiSW3CECiT6O4bQ+prpu48fBquu87HTDgsNmAg1DgL22QK5UHK9e/JmUloiEdBV5sATDngZDovosEen0ZkZAL3sHqGsLvGz5dlo6dSl0YtdsRObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080856; c=relaxed/simple;
	bh=eIRqnYtuAxd1Kk0aoFD4GGo+0qoPjGyuF5frk+Rh9RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5BYlB3GWLhdIUiwUNXafFiRCnkJ59lko2DlyyhD4kBT8gsR2TXnFu/0KtmnNq6xaKBsNt5boJUPTuYZAHnurrxkHT4/PsiB6zZs056PUD+sOrBoFUzj2LlRIFfWDzDskYh4xj1K6+3KsXRxbeIaYFticOZhMQMAPeFDHi61YiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd8ofurX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd8ofurX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEF9C4CEFB;
	Thu, 18 Dec 2025 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766080856;
	bh=eIRqnYtuAxd1Kk0aoFD4GGo+0qoPjGyuF5frk+Rh9RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rd8ofurXz5oh4qJ4Fm4bs6vlIdCbSLvTDQJe8MLX7Jgl+ZeaEiFM0TxUtjUfZBrP/
	 nFyNx5QQt399VNSFbB4QV7lp8hR3+Cl/2KRXzbjQcoOtTNQ5PvGZki2crYuZiYyVuA
	 w7Z/TSmLb2NqhQLX0cDzKhUcVUfjQmHFduREbnkmGEibpRcOHn7YB1cTAtv264k0CJ
	 dDarz+tXAzLsm9gbqywFZI/p4PY25l4DwzLCqUlAOe24Tk9qkiP3Vdal99+GH500XD
	 AwKb4DFSE/iCmbMX0J+d8CrDh2hMPbG39h1imBMDEvr55qKj2ph2OdCrtW5Mosx1Ji
	 mUhH6aPZZV9kg==
Date: Thu, 18 Dec 2025 18:00:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH v10 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <c8acf650-ef96-4449-ba85-557dedba0ffc@sirena.org.uk>
References: <20251213185608.3418096-1-mathieu.desnoyers@efficios.com>
 <20251213185608.3418096-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eJ6YtZ/b8rQ/+1kJ"
Content-Disposition: inline
In-Reply-To: <20251213185608.3418096-3-mathieu.desnoyers@efficios.com>
X-Cookie: ASHes to ASHes, DOS to DOS.


--eJ6YtZ/b8rQ/+1kJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 13, 2025 at 01:56:07PM -0500, Mathieu Desnoyers wrote:

> Use hierarchical per-cpu counters for rss tracking to fix the per-mm RSS
> tracking which has become too inaccurate for OOM killer purposes on
> large many-core systems.

We're seeing boot time crashes in -next on the Arm FVP and Ampere Altra
which bisect to this patch which is commit 240587b6cca2822d.  Many other
platforms aren't showing this, though we do have some other breakage in
-next which might be obscuring things.  We get a NULL dereference:

[    2.481143] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000

...

[    2.485036] Call trace:
[    2.485094]  acct_account_cputime+0x40/0xa4 (P)
[    2.485226]  irqtime_account_process_tick+0x17c/0x1d8
[    2.485382]  account_process_tick+0x12c/0x148
[    2.485531]  update_process_times+0x28/0xdc
[    2.485656]  tick_nohz_handler+0xbc/0x1bc
[    2.485809]  __hrtimer_run_queues+0x130/0x184

I note that __acct_update_integrals is being called from here most
likely inline and doing get_mm_rss().  That uses get_mm_counter() which
we've updated in this patch, though I didn't spot the specific issue
yet.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2269797#L1305

Bisect log:

# bad: [1058ca9db0edaedcb16480cc74b78ed06f0d1f54] Add linux-next specific files for 20251218
# good: [b67535593a28aff9d355799ec5efc2e90bc405a6] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [f4acea9eef704607d1a950909ce3a52a770d6be2] spi: dt-bindings: st,stm32-spi: add 'power-domains' property
# good: [f25c7d709b93602ee9a08eba522808a18e1f5d56] ASoC: SOF: Intel: pci-nvl: Set on_demand_dsp_boot for NVL-S
# good: [524ee559948d8d079b13466e70fa741f909699c0] ASoC: SOF: Intel: hda: Only check SSP MCLK mask in case of IPC3
# good: [fa08b566860bca8ebf9300090b85174c34de7ca5] spi: rzv2h-rspi: add support for DMA mode
# good: [fee876b2ec75dcc18fdea154eae1f5bf14d82659] spi: stm32-qspi: Simplify SMIE interrupt test
# good: [b884e34994ca41f7b7819f3c41b78ff494787b27] spi: spi-fsl-lpspi: convert min_t() to simple min()
# good: [ba9b28652c75b07383e267328f1759195d5430f7] spi: imx: enable DMA mode for target operation
# good: [124f6155f3d97b0e33f178c10a5138a42c8fd207] ASoC: renesas: rz-ssi: Add support for 32 bits sample width
# good: [aa30193af8873b3ccfd70a4275336ab6cbd4e5e6] ASoC: Intel: catpt: Drop superfluous space in PCM code
# good: [9e92c559d49d6fb903af17a31a469aac51b1766d] regulator: max77675: Add MAX77675 regulator driver
# good: [81acbdc51bbbec822a1525481f2f70677c47aee0] ASoC: sdw-mockup: Drop dummy remove function
# good: [0bb160c92ad400c692984763996b758458adea17] ASoC: qcom: Minor readability improve with new lines
# good: [03d281f384768610bf90697bce9e35d3d596de77] rust: regulator: add __rust_helper to helpers
# good: [e39011184f23de3d04ca8e80b4df76c9047b4026] ASoC: SDCA: functions: Fix confusing cleanup.h syntax
git bisect start '1058ca9db0edaedcb16480cc74b78ed06f0d1f54' 'b67535593a28aff9d355799ec5efc2e90bc405a6' 'f4acea9eef704607d1a950909ce3a52a770d6be2' 'f25c7d709b93602ee9a08eba522808a18e1f5d56' '524ee559948d8d079b13466e70fa741f909699c0' 'fa08b566860bca8ebf9300090b85174c34de7ca5' 'fee876b2ec75dcc18fdea154eae1f5bf14d82659' 'b884e34994ca41f7b7819f3c41b78ff494787b27' 'ba9b28652c75b07383e267328f1759195d5430f7' '124f6155f3d97b0e33f178c10a5138a42c8fd207' 'aa30193af8873b3ccfd70a4275336ab6cbd4e5e6' '9e92c559d49d6fb903af17a31a469aac51b1766d' '81acbdc51bbbec822a1525481f2f70677c47aee0' '0bb160c92ad400c692984763996b758458adea17' '03d281f384768610bf90697bce9e35d3d596de77' 'e39011184f23de3d04ca8e80b4df76c9047b4026'
# test job: [f4acea9eef704607d1a950909ce3a52a770d6be2] https://lava.sirena.org.uk/scheduler/job/2243946
# test job: [f25c7d709b93602ee9a08eba522808a18e1f5d56] https://lava.sirena.org.uk/scheduler/job/2244079
# test job: [524ee559948d8d079b13466e70fa741f909699c0] https://lava.sirena.org.uk/scheduler/job/2243984
# test job: [fa08b566860bca8ebf9300090b85174c34de7ca5] https://lava.sirena.org.uk/scheduler/job/2232928
# test job: [fee876b2ec75dcc18fdea154eae1f5bf14d82659] https://lava.sirena.org.uk/scheduler/job/2231264
# test job: [b884e34994ca41f7b7819f3c41b78ff494787b27] https://lava.sirena.org.uk/scheduler/job/2231779
# test job: [ba9b28652c75b07383e267328f1759195d5430f7] https://lava.sirena.org.uk/scheduler/job/2231420
# test job: [124f6155f3d97b0e33f178c10a5138a42c8fd207] https://lava.sirena.org.uk/scheduler/job/2232853
# test job: [aa30193af8873b3ccfd70a4275336ab6cbd4e5e6] https://lava.sirena.org.uk/scheduler/job/2232678
# test job: [9e92c559d49d6fb903af17a31a469aac51b1766d] https://lava.sirena.org.uk/scheduler/job/2232518
# test job: [81acbdc51bbbec822a1525481f2f70677c47aee0] https://lava.sirena.org.uk/scheduler/job/2232960
# test job: [0bb160c92ad400c692984763996b758458adea17] https://lava.sirena.org.uk/scheduler/job/2233063
# test job: [03d281f384768610bf90697bce9e35d3d596de77] https://lava.sirena.org.uk/scheduler/job/2231118
# test job: [e39011184f23de3d04ca8e80b4df76c9047b4026] https://lava.sirena.org.uk/scheduler/job/2232449
# test job: [1058ca9db0edaedcb16480cc74b78ed06f0d1f54] https://lava.sirena.org.uk/scheduler/job/2269797
# bad: [1058ca9db0edaedcb16480cc74b78ed06f0d1f54] Add linux-next specific files for 20251218
git bisect bad 1058ca9db0edaedcb16480cc74b78ed06f0d1f54
# test job: [066839a14b076089272a60ed81f11e423d5c9361] https://lava.sirena.org.uk/scheduler/job/2270122
# bad: [066839a14b076089272a60ed81f11e423d5c9361] Merge branch 'for-linux-next' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect bad 066839a14b076089272a60ed81f11e423d5c9361
# test job: [3f506139d1ada1f7dbb8593973ed287379747c06] https://lava.sirena.org.uk/scheduler/job/2270335
# bad: [3f506139d1ada1f7dbb8593973ed287379747c06] Merge branch 'xtensa-for-next' of https://github.com/jcmvbkbc/linux-xtensa.git
git bisect bad 3f506139d1ada1f7dbb8593973ed287379747c06
# test job: [b5d3cb02801b2e109f9dd0e5e39ca47ab1edaf14] https://lava.sirena.org.uk/scheduler/job/2270661
# bad: [b5d3cb02801b2e109f9dd0e5e39ca47ab1edaf14] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect bad b5d3cb02801b2e109f9dd0e5e39ca47ab1edaf14
# test job: [8cf5d38999d1dca70f34de411b72a099d07c1b6a] https://lava.sirena.org.uk/scheduler/job/2270863
# bad: [8cf5d38999d1dca70f34de411b72a099d07c1b6a] Merge branch 'kbuild-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git
git bisect bad 8cf5d38999d1dca70f34de411b72a099d07c1b6a
# test job: [6f7df192578220290c5ee01dc146f01c919fdb7b] https://lava.sirena.org.uk/scheduler/job/2271024
# good: [6f7df192578220290c5ee01dc146f01c919fdb7b] kallsyms/bpf: rename __bpf_address_lookup() to bpf_address_lookup()
git bisect good 6f7df192578220290c5ee01dc146f01c919fdb7b
# test job: [a525b83d913f000bed66b69f6d9c05c0c04551dd] https://lava.sirena.org.uk/scheduler/job/2271528
# bad: [a525b83d913f000bed66b69f6d9c05c0c04551dd] mm: add basic tests for lazy_mmu
git bisect bad a525b83d913f000bed66b69f6d9c05c0c04551dd
# test job: [667c24fb34a273ffc323d591ac628285602bd324] https://lava.sirena.org.uk/scheduler/job/2271625
# bad: [667c24fb34a273ffc323d591ac628285602bd324] sparc/mm: implement arch_flush_lazy_mmu_mode()
git bisect bad 667c24fb34a273ffc323d591ac628285602bd324
# test job: [d70090581c46c001d0886afbaf08bcbc85a5e8bc] https://lava.sirena.org.uk/scheduler/job/2271840
# bad: [d70090581c46c001d0886afbaf08bcbc85a5e8bc] mm: implement precise OOM killer task selection
git bisect bad d70090581c46c001d0886afbaf08bcbc85a5e8bc
# test job: [eb526e6344d1dd7784bef5aa4cbe7f7fada3bf12] https://lava.sirena.org.uk/scheduler/job/2271925
# good: [eb526e6344d1dd7784bef5aa4cbe7f7fada3bf12] mm/damon/core: fix memory leak of repeat mode damon_call_control objects
git bisect good eb526e6344d1dd7784bef5aa4cbe7f7fada3bf12
# test job: [240587b6cca2822dd579caa0ff05a7f5e459c597] https://lava.sirena.org.uk/scheduler/job/2272240
# bad: [240587b6cca2822dd579caa0ff05a7f5e459c597] mm: fix OOM killer inaccuracy on large many-core systems
git bisect bad 240587b6cca2822dd579caa0ff05a7f5e459c597
# test job: [f9ff5ba6bbfcc8f8a61cd7dd61a0c33b7c4deb30] https://lava.sirena.org.uk/scheduler/job/2272347
# good: [f9ff5ba6bbfcc8f8a61cd7dd61a0c33b7c4deb30] lib: introduce hierarchical per-cpu counters
git bisect good f9ff5ba6bbfcc8f8a61cd7dd61a0c33b7c4deb30
# first bad commit: [240587b6cca2822dd579caa0ff05a7f5e459c597] mm: fix OOM killer inaccuracy on large many-core systems

--eJ6YtZ/b8rQ/+1kJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlEQU0ACgkQJNaLcl1U
h9A4swf/ZUWTE4e9ocGurpj7hPBc3j8xm3Cb6Tmk+InLQ+jq4hY9zjXUD3ZtL4v2
kM3syntnXTQMUXGv7Yt3ag+fcHGkBfQmQMAwV5W7cKlnwSJL1nWXAwbZZ+F90p5n
L56ZkfD71bF6fUmCJScAhVla7ITTibuCgd0FrhfIDv1WYP3m0h3DbemYikrS3REF
1CSRQObZ6MRUzFgY1Nc71mwF3asCNLlY4Z5XCkuo+VEbriI8sB0n1V/sd0qAmBtf
+z/USby5vcI2cHUOzGQIpENjagZavk/7W7Wc8jE9T6dqlcc3mzxgArgVq8edm2eV
kjVMFjWvcTQ4UdPbik687J1Z4o9sOg==
=LrCP
-----END PGP SIGNATURE-----

--eJ6YtZ/b8rQ/+1kJ--
