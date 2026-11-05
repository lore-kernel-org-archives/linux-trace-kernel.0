Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887956;
	b=BBiMLtQ3MqCr/mHoGCTh6weiwxGF1d7cm/DQ/DmVwjdZLmZB/7K2q0E7i3jISWb9W2NP
	 doYb+SMqEOmVId8Qo0OmGtCTMw+tTyFmplQMEBINn2XZyfKEkHXp9WPRi46kRESEhXGig
	 6WjjZoJv5EuAljECnyphPmfgl13g/ReRzZE7XcKGvM1JTeiTX+r3GbzES86PQtbqhSxA+
	 RgNqezXvZNdz1MgoSpgQNwg9dqAwBAc7qhEvYJe3HDVcJS4gjsOGKJ+MWLs38mmAV5VmX
	 Be9yJOT7OpiLhRejUK6lNVad70mx5dEbS9Qovuy4bwrc8eY/crtjCIgWonQN702eJwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=epReB34mJhoyIVXnBuftr0xqY+TB9SCuxEgMqdn9e9M=;
	b=fg06Wbo6BkAgyv3R5x9eJaelxK0VnoupBsVF+UB/Sqti5PFxvDcyH4FAD11MtPmSIvc1
	 SAkzb/2rGb3W52lwJcy+0K3cUDH7Vn7Z7dORHF6MfN+vBShS0PeqA8hhGCz6sZfVrCUyx
	 epIRed/D9VTzHeqKL6H+rwk7wOYk4b4W27lPlBvEnKto5TWKjmJTg1JeKCf1eBwvwHbJk
	 Fdk+5laVH7glVBWGI2b31t3MIjQsrg/ugw9F+2j7SZ4FHAwdMCtyhjVwl6Vr/uOMcplzt
	 0frxShV145Tl/qpUwEurOmLL6v+XtM3r0mjSb1ZsXlLhu98cIyZwrq5sbCPBbLbLcPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUtu4y00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD3606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jUtu4y00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D9A1F000C1;
	Thu,  5 Nov 2026 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887955;
	bh=epReB34mJhoyIVXnBuftr0xqY+TB9SCuxEgMqdn9e9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jUtu4y00WkJtpFj2+7sJp2HNJCGlUSO2IaBxo42/fMGckmJpPvp3D8ufvuFee2t13
	 Gs/EJqxXzz8wKL/YhQ19KoPutu/pBW6SebGHC88YRgkOY7CPSSc8mf5vhUuGifdjtO
	 1mrvYZjjMWghHotBgQw14i7O5vgv4hQObfkpBW/v7hlYgvPZ6BuE9Qwaq3AIklSUif
	 2lcdcG/C/AcChJ0oPApTPqVAGzbMFsToke9y6Oe4pLJlU6pm3gRLRmo6q8I0K3tZsb
	 KWTx/d1+nyw39ns0AXKoXYuPhfoMgDmrvJdRXuEvW+5IVOGVqAQsIPWKlUBpuCacLy
	 /TX6F88cNF0tQ==
Message-ID: <sashiko-outbox-199209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] tracing: add per-CPU buffer memory usage
 statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Gao" <gxxa03070307@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105140221.44614-4-gaoxiang17@xiaomi.com>
References: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
 <20261105140221.44614-4-gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:12:34 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tracing: duplicate helpers and fops in trace_buffers_memory_cpu()
--

commit eebda64960929af5cb03f9b9f28c818ce9a75fce
Author: Xiang Gao <gxxa03070307@gmail.com>

tracing: add per-CPU buffer memory usage statistics

This commit adds per-CPU ring-buffer memory usage files under
trace_stats/per_cpu/cpuN/memory_usage_kb using the same categorized output
format as the aggregate trace_stats/memory_usage_kb file.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6036e368fe102..e7e23ff38105c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5898,6 +5898,60 @@ static const struct file_operations trace_mem_fops=
 =3D {
>  	.release	=3D single_release,
>  };
> =20
> +static struct trace_mem_stats trace_buffers_memory_cpu(int cpu)
> +{
> +	struct trace_mem_stats stats =3D {};
> +	struct trace_array *tr;
> +
> +	guard(mutex)(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> +		trace_array_buffer_memory(tr, cpu, &stats);
> +
> +	/* Account for the bootstrapping temp_buffer as well. */
> +	if (temp_buffer)
> +		stats.global +=3D ring_buffer_memory_size(temp_buffer, cpu);
> +
> +	stats.total_system =3D stats.global + stats.instances +
> +			     stats.snapshots + stats.remotes;
> +	stats.total_carveout =3D stats.persistents;
> +
> +	return stats;
> +}
> +
> +static int trace_mem_per_cpu_show(struct seq_file *m, void *v)
> +{
> +	struct trace_mem_stats stats =3D trace_buffers_memory_cpu((long)m->priv=
ate);
> +
> +	seq_printf(m, "global: %lu\n", stats.global >> 10);
> +	seq_printf(m, "instances: %lu\n", stats.instances >> 10);
> +	seq_printf(m, "snapshots: %lu\n", stats.snapshots >> 10);
> +	seq_printf(m, "persistents: %lu\n", stats.persistents >> 10);
> +	seq_printf(m, "remotes: %lu\n", stats.remotes >> 10);
> +	seq_printf(m, "total_system: %lu\n", stats.total_system >> 10);
> +	seq_printf(m, "total_carveout: %lu\n", stats.total_carveout >> 10);
> +
> +	return 0;
> +}
> +
> +static int trace_mem_per_cpu_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +
> +	ret =3D tracing_check_open_get_tr(NULL);
> +	if (ret)
> +		return ret;
> +
> +	return single_open(file, trace_mem_per_cpu_show, inode->i_private);
> +}
> +
> +static const struct file_operations trace_mem_per_cpu_fops =3D {
> +	.open		=3D trace_mem_per_cpu_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};

[Severity: Low]
As reported by Masami Hiramatsu (Google) on v4 [1], could this reuse
trace_buffers_memory(), trace_mem_show(), trace_mem_open(), and
trace_mem_fops instead of duplicating them?

In kernel/trace/trace.c, the existing aggregate implementation already
forwards inode->i_private to single_open() in trace_mem_open() and formats
the exact same fields in trace_mem_show():

kernel/trace/trace.c:trace_mem_show() {
	struct trace_mem_stats stats =3D trace_buffers_memory();

	seq_printf(m, "global: %lu\n", stats.global >> 10);
	...
}

kernel/trace/trace.c:trace_mem_open() {
	int ret;

	ret =3D tracing_check_open_get_tr(NULL);
	if (ret)
		return ret;

	return single_open(file, trace_mem_show, inode->i_private);
}

If init_trace_stats_tracefs() passes (void *)(long)RING_BUFFER_ALL_CPUS for
the aggregate memory_usage_kb file and (void *)(long)cpu for each per-CPU
file, and trace_buffers_memory(int cpu) handles both RING_BUFFER_ALL_CPUS a=
nd
a specific CPU, all four duplicated definitions can be avoided.

Also, the comment in trace_buffers_memory_cpu() describes temp_buffer as a
bootstrapping buffer, whereas trace_buffers_memory() notes that temp_buffer
is allocated in tracer_alloc_buffers() to hold temporary event data for
triggers when tracing is off.

[1] https://lore.kernel.org/r/20260924103621.734c895420a97a2d6f36332e@kerne=
l.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105140221.4461=
4-1-gaoxiang17@xiaomi.com?part=3D3
