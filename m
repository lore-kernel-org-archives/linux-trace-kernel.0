Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B32328610;
	Fri,  9 Oct 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564330; cv=none; b=QQh/zA6PWcsOsnHoBG1ydzZSIxp3P1+frdQnfvmXuvmZXvh+I06y+Un79RGH79xF8OJ8BfKIO1kBxzar44kvaG6+F1oDw81FHfnkpMdX2z4tFokY0V4ehDPQCtjjELcxqhzFi5Lt0eMByt+hTMwD3LxPeaBYPLBBomyufZtnI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564330; c=relaxed/simple;
	bh=C1kkvSWYB275ELvoAodUeJXPfr5ByfVMaK1UolSEgaw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qGHVsMysznqMbu70n92rVNNv7s64DE8s0r1UTVK+k8NPXhamoeSTE7gQDfkId/F212kFfCE5GDVevwlzTgOSwwojWIqj16b3cmBxYiZLhfqmllcpoKqSWqa7/qAAjGDbYMSnhaV68ePvXDMaYDEkIPQcESqNFt5Z9sQ/Y5+up+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr7ImPEJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr7ImPEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0D81F000FF;
	Fri,  9 Oct 2026 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791564329;
	bh=EdkaoRcPZ8rutMeP2Na6pfoM9rtfitjBN8tbkMG9SsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vr7ImPEJTeJIXQQB6r+tUZPgbAgrAznPdboNv8u7iH4mbAx0rn1s+Lc/oI7FyPipE
	 6NvPdpah11+hNt9/drHTSj0R8T4YqnkpSJXYnOuJEN9TzCh5AcbmFE3WkdSc9hKK7R
	 afw71g+Gfb9b+K7pE2IE/bOvgZdoMeAafrWPLBaqNMqZHxbGNItEpW8shUUFgUAFIE
	 O+I9BAhtEKCt1HeaefKlZtwGC1hIq/FHTgdABOKDKbROZ7IK2DDnfmCXwgjPBXe5/d
	 FOE7hUwdx4WBsJetXOIRnckkMXpBseu9NIoGbPXWeUCBRuX3K2xAn5ef394Sa69l+n
	 UuDUFhFQu0ndA==
Message-ID: <sashiko-outbox-165847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:45:29 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] trace/ring_buffer: SMP boot failure due to premature si_mem_availa=
ble() check
--

commit b21cf9115adfbd1fd082e26d147a363a37bad846
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

ring-buffer: Do not check si_mem_available() during SYSTEM_BOOTING

This commit modifies early boot tracing allocation to bypass the
si_mem_available() check when system_state is SYSTEM_BOOTING. It aims to
prevent premature -ENOMEM failures on systems with deferred page
initialization.

Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f587..a9f82e2f8fad2 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_=
per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_=
INIT,
> +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> +	 * stage. si_mem_available() returns a false negative while actual
> +	 * allocations succeed by growing the zone on demand via
> +	 * deferred_grow_zone().
>  	 */
>  	i =3D si_mem_available();
> -	if (i < nr_pages)
> +	if (system_state !=3D SYSTEM_BOOTING && i < nr_pages)

[Severity: High]
Could this condition cause an SMP boot failure by re-enabling the check
too early?

The system transitions to SYSTEM_SCHEDULING in rest_init() before the init
thread starts. When the init thread runs kernel_init_freeable(), it sets up
secondary CPUs via smp_init() before deferred memory is initialized:

init/main.c:kernel_init_freeable() {
    ...
    smp_init();
    ...
    page_alloc_init_late();
    ...
}

When smp_init() brings up a CPU, it triggers the CPU hotplug callback
trace_rb_cpu_prepare(), which eventually calls __rb_allocate_pages().=20

Since system_state is now SYSTEM_SCHEDULING (not SYSTEM_BOOTING) when
__rb_allocate_pages() is called, the new check evaluates to true and
si_mem_available() executes. Because page_alloc_init_late() hasn't run yet,
deferred memory is still uninitialized, which means si_mem_available() will
return a false negative and abort the allocation with -ENOMEM.

Would this failure propagate through the CPU hotplug state machine and
abort the bring-up of secondary CPUs when CONFIG_DEFERRED_STRUCT_PAGE_INIT
is enabled?

>  		return -ENOMEM;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009163557.8846=
7-1-amachhiw@linux.ibm.com?part=3D2
